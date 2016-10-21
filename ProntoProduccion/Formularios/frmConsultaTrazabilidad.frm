VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#3.0#0"; "Controles1013.ocx"
Begin VB.Form frmConsultaTrazabilidad 
   Caption         =   "Trazabilidad de Partidas"
   ClientHeight    =   7845
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   14055
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   7845
   ScaleWidth      =   14055
   StartUpPosition =   1  'CenterOwner
   Begin Produccion.vbalGrid Grid 
      Height          =   3855
      Left            =   120
      TabIndex        =   15
      Top             =   3240
      Width           =   13815
      _ExtentX        =   24368
      _ExtentY        =   6800
      BackgroundPictureHeight=   0
      BackgroundPictureWidth=   0
      HighlightBackColor=   16761024
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      DisableIcons    =   -1  'True
      HighlightSelectedIcons=   0   'False
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   12960
      Top             =   4680
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaTrazabilidad.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaTrazabilidad.frx":03C6
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton cmdCommand1 
      Caption         =   "Llena gDebug"
      Height          =   495
      Left            =   4800
      TabIndex        =   14
      Top             =   7200
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.CommandButton cmdDebugOrdenar 
      Caption         =   "Agrupar!"
      Height          =   510
      Index           =   0
      Left            =   3720
      TabIndex        =   13
      Top             =   7200
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.CheckBox chkColumnasVisibles 
      Caption         =   "columnas visibles"
      Height          =   255
      Left            =   480
      TabIndex        =   12
      Top             =   7440
      Visible         =   0   'False
      Width           =   2295
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   285
      Index           =   0
      Left            =   10800
      TabIndex        =   1
      Top             =   7200
      Visible         =   0   'False
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   503
      _Version        =   393216
      Enabled         =   0   'False
      Format          =   94896129
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   285
      Index           =   1
      Left            =   10800
      TabIndex        =   2
      Top             =   7560
      Visible         =   0   'False
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   503
      _Version        =   393216
      Enabled         =   0   'False
      Format          =   94830593
      CurrentDate     =   36377
   End
   Begin VB.CheckBox Check1 
      Caption         =   "ver grupos de ordenamiento de la vbalgrid"
      Height          =   255
      Left            =   480
      TabIndex        =   11
      Top             =   7200
      Visible         =   0   'False
      Width           =   3375
   End
   Begin VB.OptionButton OptAscendencia 
      Caption         =   "Descendencia"
      Height          =   255
      Index           =   1
      Left            =   1800
      TabIndex        =   10
      Top             =   3000
      Width           =   1575
   End
   Begin VB.OptionButton OptAscendencia 
      Caption         =   "Ascendencia"
      Height          =   255
      Index           =   0
      Left            =   240
      TabIndex        =   9
      Top             =   3000
      Value           =   -1  'True
      Width           =   1575
   End
   Begin MSHierarchicalFlexGridLib.MSHFlexGrid fGrid 
      Height          =   1575
      Left            =   8760
      TabIndex        =   8
      Top             =   3720
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   2778
      _Version        =   393216
      _NumberOfBands  =   1
      _Band(0).Cols   =   2
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   510
      Index           =   4
      Left            =   12720
      TabIndex        =   0
      Top             =   7200
      Width           =   1215
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   12480
      Top             =   1320
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
            Picture         =   "frmConsultaTrazabilidad.frx":078C
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaTrazabilidad.frx":089E
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaTrazabilidad.frx":09B0
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaTrazabilidad.frx":0AC2
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaTrazabilidad.frx":0BD4
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaTrazabilidad.frx":0CE6
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaTrazabilidad.frx":0DF8
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
      Width           =   14055
      _ExtentX        =   24791
      _ExtentY        =   741
      ButtonWidth     =   609
      Appearance      =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageKey        =   "Print"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel"
            Object.ToolTipText     =   "Salida a Excel"
            ImageKey        =   "Excel"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageKey        =   "Find"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Ayuda"
            Object.ToolTipText     =   "Ayuda"
            ImageKey        =   "Help"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdOrdenCompra"
      Height          =   315
      Index           =   1
      Left            =   4800
      TabIndex        =   16
      Tag             =   "ProduccionOrdenes"
      Top             =   840
      Width           =   3450
      _ExtentX        =   6085
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdOrdenCompra"
      Text            =   ""
   End
   Begin Controles1013.DbListView dblistPartidasFiltradas 
      Height          =   1935
      Left            =   120
      TabIndex        =   18
      Top             =   840
      Width           =   4410
      _ExtentX        =   7779
      _ExtentY        =   3413
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaTrazabilidad.frx":124A
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Label lblOrdenDe 
      Caption         =   "Filtrar por Orden de compra"
      Height          =   345
      Index           =   2
      Left            =   4800
      TabIndex        =   17
      Top             =   600
      Width           =   1920
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha final :"
      Height          =   195
      Index           =   1
      Left            =   2160
      TabIndex        =   4
      Top             =   7800
      Visible         =   0   'False
      Width           =   930
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha inicial :"
      Height          =   195
      Index           =   0
      Left            =   9840
      TabIndex        =   3
      Top             =   7320
      Visible         =   0   'False
      Width           =   1020
   End
   Begin VB.Label lblOrdenDe 
      Caption         =   "Elija una Partida a tracear"
      Height          =   225
      Index           =   1
      Left            =   240
      TabIndex        =   7
      Top             =   600
      Width           =   2040
   End
   Begin VB.Label lblOrdenDe 
      Caption         =   "OP"
      Height          =   225
      Index           =   0
      Left            =   0
      TabIndex        =   6
      Top             =   120
      Width           =   480
   End
End
Attribute VB_Name = "frmConsultaTrazabilidad"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'PARTIDA Nº 00315:
'
'    Artículo Terminado (ejemplo "Base Cashemere Season 1/28 2472 Negro")
'        Remito de Entrega el Cliente
'Orden de Producción (ella contendrá el número del Parte de Producción, también se podría explotar aquí el listado)
'(Explota Artículo Terminado en sus componentes según lo detallado en Orden de Producción a partir de la Ficha Técnica)
'    Componente (ejemplo "Algodón Manuar 17mic G572 NEGRO 38mm")
'    Remito de Recepción desde el Proveedor (ejemplo por fason).
'    Orden de Producción/ Parte de Producción
'    (Explota Artículo Semielaborado en sus componentes)
'        "Algodón …."
'        Remito de Recepción desde el Proveedor
'        "Artículo 2"
'        Remito de Recepción desde el Proveedor
'"Rayon Viscosa brillante 15mic G572 NEGRO 38mm"
'    Remito de Recepción desde el Proveedor
'
'Luego, haciendo un "clic" en el artículo que se está buscando, el sistema permite ver un reporte de los "movimientos de stock" del artículo seleccionado para un seguimiento de lo ocurrido en esa partida de ese artículo:
'
'"Rayon Viscosa brillante 15mic G572 NEGRO 38mm"
'    Remito de Recepción desde el Proveedor
'    Salida de Stock / Parte de Producción
'        "Base Cashemere Season 1/28 2472 Negro" (Partida Número)
'Salida de Stock / Parte de Producción
' "Base Cashemere Season 1/28 2472 Negro" (Partida Número)
'Devolución al Proveedor

Const GP_COL_PARTIDA = 1
Const GP_COL_NIVEL2 = 2
Const GP_COL_NIVEL3 = 3

Const GP_COL_PARTIDATEXTO = 4
Const GP_COL_TIPO = 5
Const GP_COL_NUMERO = 6
Const GP_COL_FECHA = 7

Const GP_COL_IDSTOCK = 8
Const GP_COL_IDARTICULO = 9
Const GP_COL_CODART = 10
Const GP_COL_DESCART = 11
Const GP_COL_CANTIDAD = 12

Const GP_COL_IDPP = 13
Const GP_COL_IDOI = 14
Const GP_COL_IDSM = 15
Const GP_COL_IDRP = 16

Const GP_COL_OC = 17

Public partida As String

Public Ascendencia As Boolean

Sub Cargar()
    
    Dim oAp As ComPronto.Aplicacion
    Set oAp = Aplicacion
    
    BindTypeDropDown 'bind de combos
        
    'bind de grilla
    'Set dblistPartidasFiltradas.DataSource = GetStoreProcedure(enumSPs.ProduccionOrdenes_TX_Producidos, 0)
    Set dblistPartidasFiltradas.DataSource = oAp.ProduccionOrdenes.TraerFiltrado("_Producidos", 0)
    
    Set oAp = Nothing
End Sub

Private Sub BindTypeDropDown()
    Dim oAp As ComPronto.Aplicacion
    Set oAp = Aplicacion
    
    'Set dcfields(11).RowSource = oAp.ProduccionOrdenes.TraerFiltrado("_Producidos", 0)
    
    Set dcfields(1).RowSource = oAp.OrdenesCompra.TraerFiltrado("_ImputadasConOrdenesDeProduccion")
    'llenar Con ocs que tienen op imputadas
    
    'IniciaCombo(SC, cmbUbicacion, tipos.Ubicaciones)
    Set oAp = Nothing

End Sub

Private Sub cmd_Click(Index As Integer)

    Select Case Index
      
        Case 0, 1, 2
         
            'If Check1.Value = 1 And Not IsNumeric(dcfields(1).BoundText) Then
            '   MsgBox "Debe ingresar un equipo para seguimiento", vbExclamation
            '   Exit Sub
            'End If
         
            Me.MousePointer = vbHourglass
         
            'Lista.ListItems.Clear
            'Lista3.ListItems.Clear
            'Lista3.ColumnHeaders.Clear
            'ListaCardex.ListItems.Clear
            'ListaCardex.ColumnHeaders.Clear
            'Lista2.ListItems.Clear
            'Lista2.ColumnHeaders.Clear
            'rchObservaciones.Text = ""
         
            DoEvents
         
            Dim oAp As ComPronto.Aplicacion
            Dim mIdObra As Long, mReq As Long, mAco As Long, mArt As Long
            Dim mPorFecha As Integer
         
            Set oAp = Aplicacion
         
            oAp.Tarea "Obras_GenerarEstado", mArt

            'Lista.Sorted = False
            Select Case Index

                Case 0
                    'Set Lista.DataSource = oAp.Obras.TraerFiltrado("_EstadoObras_RM", _
                     Array(mIdObra, mReq, mAco, mPorFecha, DTFields(0).Value, DTFields(1).Value))

                Case 1

                    'Set Lista.DataSource = oAp.Obras.TraerFiltrado("_EstadoObras_Acopios", Array(mIdObra, mReq, mAco))
                Case 2
                    'Set Lista.DataSource = oAp.Obras.TraerFiltrado("_EstadoObras", Array(mIdObra, mReq, mAco))
            End Select

            'ReemplazarEtiquetasListas Lista
         
            '         Set Lista.DataSource = oAp.Obras.TraerFiltrado("_EstadoObrasPorObra", dcfields(0).BoundText)
         
            Set oAp = Nothing
         
            Me.MousePointer = vbDefault
      
        Case 4
         
            Unload Me
         
    End Select
   
End Sub

Private Sub cmdCommand1_Click()
    '    With gDebugGrilla
    '        If .Columns = 0 Then
    '            .RowMode = True
    '            .MultiSelect = True
    '            .DefaultRowHeight = 18
    '            .HeaderFlat = True
    '            .StretchLastColumnToFit = True
    '
    '            .Clear
    '            .StretchLastColumnToFit = True
    '
    '            .AddColumn , "Partida1", ecgHdrTextALignCentre, , 50, , , , , , , CCLSortNumeric
    '            .AddColumn , "Partida2", ecgHdrTextALignCentre, , 100, , , , , , , CCLSortNumeric
    '            .AddColumn , "Partida3", ecgHdrTextALignCentre, , 100, , , , , , , CCLSortNumeric
    '            .AddColumn , "Partida", ecgHdrTextALignCentre, , 90, , , , , , , CCLSortNumeric
    '    '        .AddColumn , "Tipo", ecgHdrTextALignCentre, , 50, , , , , , , CCLSortNumeric
    '    '        .AddColumn , "Numero", ecgHdrTextALignCentre, , 90, , , , , , , CCLSortNumeric
    '    '        .AddColumn , "Fecha", ecgHdrTextALignCentre, , 65, , , , , , , CCLSortDate
    '    '        .AddColumn , "IdStock", ecgHdrTextALignCentre, , 100, False, , , , , , CCLSortNumeric
    '    '        .AddColumn , "IdArticulo", ecgHdrTextALignCentre, , 50, False, , , , , , CCLSortNumeric
    '    '        .AddColumn , "Codigo", ecgHdrTextALignCentre, , 300, , , , , , , CCLSortNumeric
    '    '        .AddColumn , "Descripcion", ecgHdrTextALignCentre, , 80, , , , , , , CCLSortString
    '    '        .AddColumn , "Cant.", ecgHdrTextALignRight, , 200, , , , , "0.00", , CCLSortNumeric
    '    '        .AddColumn , "N°Parte", ecgHdrTextALignCentre, , 90, False, , , , , , CCLSortNumeric
    '    '        .AddColumn , "N°Ingreso", ecgHdrTextALignCentre, , 90, False, , , , , , CCLSortNumeric
    '    '        .AddColumn , "N°Salida", ecgHdrTextALignCentre, , 90, False, , , , , , CCLSortNumeric
    '    '        .AddColumn , "N°Recepcion", ecgHdrTextALignCentre, , 90, False, , , , , , CCLSortNumeric
    '    '        'Columna que solo sirve para ajustar la última
    '    '        .AddColumn , "", ecgHdrTextALignCentre, , 0, , , , , "$ 0.00", , CCLSortNumeric
    '
    '
    '
    '
    '
    '            '.SetHeaders
    '            .AllowGrouping = True
    '            .HideGroupingBox = False
    '            .ColumnIsGrouped(1) = True
    '
    '            .SortObject.Clear
    '            .SortObject.ClearNongrouped
    '            .HeaderDragReOrderColumns = True
    '
    '            '.ColumnIsGrouped(2) = True
    '            '.ColumnIsGrouped(3) = True
    '            '.AutoWidthColumn (GP_COL_CODART)
    '            '.AutoWidthColumn (GP_COL_DESCART)
    '            '.AutoWidthColumn (GP_COL_CANTIDAD)
    '
    '
    '
    '            '////////////////////////////////////
    '    '        .SortObject.Clear
    '    '        .SortObject.SortColumn(1) = GP_COL_PARTIDA
    '    '        .SortObject.SortType(1) = .ColumnSortType(GP_COL_PARTIDA)
    '    '        .SortObject.SortOrder(1) = CCLOrderDescending
    '    '
    '            '////////////////////////////////////
    '    '        .redraw = True
    '        End If
    '
    '
    '
    '        .Clear
    '        Dim r As Long
    '        For r = 1 To Grid.Rows
    '
    '            .AddRow
    '
    '            'For C = 4 To Grid.Columns
    '
    '            If Grid.RowVisible(r) Then
    '                .CellText(r, 1) = Grid.CellText(r, 1)
    '                '.celltext(r, 1) = Grid.celltext(r, 1)
    '            End If
    '
    '        Next
    '        .Sort
    '            .HideGroupingBox = False
    '
    '    End With
End Sub

Private Sub cmdDebugOrdenar_Click(Index As Integer)
        
    With Grid
        .AllowGrouping = True
           
        .SortObject.Clear
        .SortObject.ClearNongrouped
           
        .HeaderDragReOrderColumns = True
        .HideGroupingBox = True
        ' limpiar criterios de agrupami
        .ColumnIsGrouped(1) = True
        .ColumnIsGrouped(2) = False
        .ColumnIsGrouped(3) = False
        .ColumnIsGrouped(4) = False
        '.AllowGrouping = False
    End With

End Sub

Private Sub Check1_Click()
    Grid.HideGroupingBox = Not Grid.HideGroupingBox

End Sub

Private Sub chkColumnasVisibles_Click()
    Grid.ColumnVisible(1) = Not Grid.ColumnVisible(1)
    Grid.ColumnVisible(2) = Not Grid.ColumnVisible(2)
    Grid.ColumnVisible(3) = Not Grid.ColumnVisible(3)
        
End Sub

Private Sub dblistPartidasFiltradas_Click()
    ReloadGrid
End Sub

Private Sub dcfields_Change(Index As Integer)

    If dcfields(1).Text = "" Then dblistPartidasFiltradas.Filtrado = ""
End Sub

Private Sub dcfields_Click(Index As Integer, _
                           Area As Integer)
    'http://www.youtube.com/watch?v=xmkcX47N0Lw
    
    'si me cambia la oc, filtrar las partidas.
     
    'FiltradoLista Lista
    Debug.Print "IdOrdenCompra:" & dcfields(1).BoundText

    If dcfields(1).Text = "" Then
        dblistPartidasFiltradas.Filtrado = ""
    Else
        dblistPartidasFiltradas.Filtrado = "IdOrdenCompra1=" & dcfields(1).BoundText & " OR IdOrdenCompra2=" & dcfields(1).BoundText & " OR IdOrdenCompra3=" & dcfields(1).BoundText & " OR IdOrdenCompra4=" & dcfields(1).BoundText & " OR IdOrdenCompra5=" & dcfields(1).BoundText
    End If

    dblistPartidasFiltradas.Refresh

End Sub

Private Sub dcfields_LostFocus(Index As Integer)
    Dim oAp As ComPronto.Aplicacion
    Set oAp = Aplicacion
        
    'If dcfields(11) <> "" Then
    'Set Lista2.DataSource = oAp.ProduccionOrdenes.TraerFiltrado("_PartidasUsadas", dcfields(11).BoundText)
    'RefrescaCardex (Lista.ListItems(Lista.SelectedItem.Index).SubItems(4))
    ReloadGrid
    
    'End If
    
    Set oAp = Nothing
End Sub

Public Sub Form_Load()

    'Set dcfields(0).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo")
    'Set dcfields(1).RowSource = Aplicacion.Articulos.TraerLista

    CambiarLenguaje Me, "esp", glbIdiomaActual

    Cargar
    
    ConfigGrid

    'If partida <> "" Then
    '    dcfields(11) = partida
    '    ReloadGrid
    'End If
End Sub

Private Sub Form_Paint()
    
    'Degradado Me

End Sub

Private Sub Grid_DblClick(ByVal lRow As Long, _
                          ByVal lCol As Long)
    Exit Sub

    If Grid.RowIsGroup(lRow) Then Exit Sub
    
    'MostrarOrdenCompra
    
    Dim oF As frmConsultaTrazabilidad
    Set oF = New frmConsultaTrazabilidad

    With oF
        
        .partida = iisEmpty(Grid.CellText(lRow, GP_COL_NIVEL2), Grid.CellText(lRow, GP_COL_PARTIDA))  'Grid.celltext(lRow, GP_COL_PARTIDA) '
        .OptAscendencia(0) = OptAscendencia(1)
        .OptAscendencia(1) = OptAscendencia(0)
        .dcfields(11) = iisEmpty(Grid.CellText(lRow, GP_COL_NIVEL2), Grid.CellText(lRow, GP_COL_PARTIDA))
        .Form_Load
        
        .Show , Me
        .TOp = Me.TOp + 500
        .Left = Me.Left + 500
    End With

End Sub

Sub MostrarOrdenCompra()
    Dim op As ComPronto.ProduccionOrden
    Dim xrs As ADOR.Recordset
    Set xrs = Aplicacion.ProduccionOrdenes.TraerTodos
    xrs.Filter = "Número='" & dcfields(11) & "'"
    Set op = Aplicacion.ProduccionOrdenes.Item(xrs!IdProduccionOrden)

    Dim rs As ADOR.Recordset
    Set rs = Aplicacion.TablasGenerales.TraerUno("DetOrdenesCompra", op.Registro!IdDetalleOrdenCompraImputado1)
    
    EditarOrdenCompra (rs!IdOrdenCompra)
End Sub

'////////////////////////////////
'////////////////////////////////
'////////////////////////////////
'////////////////////////////////
' Codigo original de test de vbalgrid (frmMatrixDemo)

'Private Sub Grid_DblClick(ByVal lRow As Long, ByVal lCol As Long)
'   If (lRow > 0) Then
'      If (Grid.celltext(lRow, 3) = 0) Then
'         pSetExpand Grid.celltext(lRow, 2), lRow
'      End If
'   End If
'End Sub

Private Sub grid_MouseDown(Button As Integer, _
                           Shift As Integer, _
                           X As Single, _
                           y As Single, _
                           bDoDefault As Boolean)
    Dim lCol As Long, lRow As Long
    Dim lLeft As Long, lTop As Long, lWidth As Long, lHeight As Long
    Dim lType As Long, lClause As String
    Dim lIconIndex As Long
    Dim i As Long
    On Error Resume Next
    Grid.CellFromPoint X \ Screen.TwipsPerPixelX, y \ Screen.TwipsPerPixelY, lRow, lCol

    If (lCol = GP_COL_PARTIDATEXTO) And (lRow > 0) Then
        If Grid.CellText(lRow, GP_COL_TIPO) = "" Then
            'lType = Grid.celltext(lRow, 3)
        
            'if Grid.CellText(lRow, GP_COL_NIVEL1)
            Debug.Print Grid.CellText(lRow, GP_COL_PARTIDA), Grid.CellText(lRow, GP_COL_PARTIDATEXTO)
            lClause = Grid.CellText(lRow, GP_COL_PARTIDA)
        
            'If (lType = 0) Then 'si es un renglon con crucecita
            Grid.CellBoundary lRow, lCol, lLeft, lTop, lWidth, lHeight
            'If (x < lLeft + 20) Then 'apretaron la crucecita
            pSetExpand Grid.CellText(lRow, GP_COL_PARTIDA), Grid.CellText(lRow, GP_COL_NIVEL2), Grid.CellText(lRow, GP_COL_NIVEL3), lRow
            'End If
            'End If
        End If
    End If
   
End Sub

Private Sub pSetExpand(ByVal n1 As String, _
                       ByVal n2 As String, _
                       ByVal n3 As String, _
                       ByVal lRow As Long)
    Dim lIconIndex As Long
    Dim i As Long

    ' Set .Redraw = False to loose the animation effect
    ' when doing this (it might be too slow otherwise)
   
    lIconIndex = Grid.CellExtraIcon(lRow, GP_COL_PARTIDATEXTO)

    If (lIconIndex = 0) Then
        ' Expand
        lIconIndex = 1
        ' Reverse order only so the "animation" looks nice!
        Debug.Print "Expand"

        For i = Grid.Rows To 1 Step -1

            'La partida debe ser la que corresponde y el tipo debe estar vacio
            If (Grid.CellText(i, GP_COL_PARTIDA) = n1 And Grid.CellText(i, GP_COL_NIVEL2) = IIf(n2 = "", Grid.CellText(i, GP_COL_NIVEL2), n2) And Grid.CellText(i, GP_COL_NIVEL3) = IIf(n3 = "", Grid.CellText(i, GP_COL_NIVEL3), n3) & Grid.CellText(i, GP_COL_TIPO) <> "") Then
                Debug.Print i, Grid.CellText(lRow, GP_COL_PARTIDA), Grid.CellText(lRow, GP_COL_PARTIDATEXTO)
                'If (Grid.celltext(i, 3) <> 0) Then
                Grid.RowVisible(i) = True
                'End If
            End If

        Next i

    Else
        ' Collapse
        lIconIndex = 0

        For i = 1 To Grid.Rows

            If (Grid.CellText(i, GP_COL_PARTIDA) = n1 And Grid.CellText(i, GP_COL_NIVEL2) = IIf(n2 = "", Grid.CellText(i, GP_COL_NIVEL2), n2) And Grid.CellText(i, GP_COL_NIVEL3) = IIf(n3 = "", Grid.CellText(i, GP_COL_NIVEL3), n3) & Grid.CellText(i, GP_COL_TIPO) <> "" And i <> lRow) Then
                'If (Grid.celltext(i, 3) <> 0) Then
                Grid.RowVisible(i) = False
                'End If
            End If

        Next i

    End If

    Grid.CellExtraIcon(lRow, GP_COL_PARTIDATEXTO) = lIconIndex
End Sub
'////////////////////////////////
'////////////////////////////////
'////////////////////////////////
'////////////////////////////////

Private Sub Lista_Click()
    Dim oL As ListItem

    Dim oAp As ComPronto.Aplicacion
    Set oAp = Aplicacion
        
    'If Not Lista.SelectedItem Is Nothing Then
    '    Set Lista2.DataSource = oAp.ProduccionOrdenes.TraerFiltrado("_PartidasUsadas", Lista.SelectedItem.Tag)
    'RefrescaCardex (Lista.ListItems(Lista.SelectedItem.Index).SubItems(4))
    ReloadGrid
    
    'End If
    
    Set oAp = Nothing

End Sub

Private Sub OptAscendencia_Click(Index As Integer)
    dcfields_LostFocus 11
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Key
      
        Case "Imprimir"
         
            GenerarInforme 2
         
        Case "Buscar"
            'FiltradoLista Lista
            'lblItems.Caption = "Cantidad de items : " & Lista.ListItems.Count

        Case "Excel"
         
            GenerarInforme 1
      
        Case "Excel1"
         
            GenerarInforme 1
      
    End Select

End Sub

Public Sub GenerarInforme(ByVal TipoSalida As Integer)

    Dim s As String, mTitulo As String, mPlantilla As String
    Dim i As Long
    Dim oEx As Excel.Application
    Dim oL As ListItem
    Dim fl As Integer, cl As Integer
    Dim r As Long

    On Error Resume Next
   
    Dim c As Long

    'mPlantilla = glbPathPlantillas & "\EstadoObras_" & glbEmpresaSegunString & ".xlt"
    'If Len(Dir(mPlantilla)) = 0 Then
    mPlantilla = glbPathPlantillas & "\Planilla.xlt"

    If Len(Dir(mPlantilla)) = 0 Then
        MsgBox "Plantilla inexistente", vbExclamation
        Exit Sub
    End If

    'End If

    mTitulo = "INFORME DE TRAZABILIDAD"
    '   If Option2.Value Then
    '      mTitulo = mTitulo & " - Obra : " & dcfields(0).Text & "   "
    '   End If
    '   If Option4.Value Then
    '      mTitulo = mTitulo & " - RM Nro. : " & txtNumeroRequerimiento.Text & "   "
    '   End If
    '   If Option6.Value Then
    '      mTitulo = mTitulo & " - LA Nro. : " & txtNumeroAcopio.Text & "   "
    '   End If
    '   If Check1.Value = 1 Then
    '      mTitulo = mTitulo & "[ Seguimiento de equipo : " & dcfields(1).Text & " ]  "
    '   End If
   
    Set oEx = CreateObject("Excel.Application")

    With oEx
        .Visible = True

        With .Workbooks.Add(mPlantilla)
            With .ActiveSheet
                .Cells(2, 2) = mTitulo
                fl = 6
            
                For c = 4 To Grid.Columns
                    .Cells(fl, c - 3) = Grid.ColumnHeader(c)
                    .Cells(fl, c - 3).Font.Bold = True 'poner el formato así tarda mucho
                Next c
            
                fl = fl + 1
            
                For r = 1 To Grid.Rows

                    'rchAuxiliar.TextRTF = Lista.TextoLargo(oL.Tag)
                    's = rchAuxiliar.Text
                    's = Replace(s, Chr(13) + Chr(10) + Chr(13) + Chr(10), "")

                    '.RowGroupingState(i) = ecgExpanded
                    'If .RowGroupingLevel(i) >= 2 And Grid.celltext(i, GP_COL_NIVEL2) = "" Then
                    '.RowVisible(i) = False
                
                    If Grid.RowVisible(r) Then

                        For c = 4 To Grid.Columns
                            .Cells(fl, c - 3) = Grid.CellText(r, c)
                            '.Cells(fl, C).Select
                            '.Columns(C).ColumnWidth = 0
                            '                    With .Selection
                            '                        .HorizontalAlignment = xlCenter
                            '                        .VerticalAlignment = xlCenter
                            '                        .WrapText = True
                            '                        .Orientation = 0
                            '                        .AddIndent = False
                            '                        .ShrinkToFit = False
                            '                        .MergeCells = False
                            '                    End With
                        Next c

                        fl = fl + 1
                    End If

                Next
            
                .Range("1:65536").EntireColumn.AutoFit

                For c = 1 To Grid.Columns
                    '.EntireRow.AutoFit
                    .EntireColumn.AutoFit
                Next c
    
                .Columns.EntireColumn.AutoFit
            
                .Range("6").Select
                .Selection.Font.Bold = True 'poner el formato así tarda mucho
            
                Set oL = Nothing

            End With
       
            '        .Range("A1").Select
            '        .Selection.End(xlToRight).Select
            '        .Range(Selection, Cells(ActiveCell.row, 1)).S+elect
            '        .Selection.Font.Bold = True
            '        With .Selection
            '            .HorizontalAlignment = xlCenter
            '            .VerticalAlignment = xlCenter
            '            .WrapText = True
            '            .Orientation = 0
            '            .AddIndent = False
            '            .ShrinkToFit = False
            '            .MergeCells = False
            '        End With
            '        .Selection.Borders(xlDiagonalDown).LineStyle = xlNone
            '        .Selection.Borders(xlDiagonalUp).LineStyle = xlNone
            '        With .Selection.Borders(xlEdgeLeft)
            '            .LineStyle = xlContinuous
            '            .Weight = xlThin
            '            .ColorIndex = xlAutomatic
            '        End With
            
            'oEx.Run "ArmarFormato"
      
            '.Rows("1:1").Select
            'oEx.Selection.Insert Shift:=xlDown
            '            For i = 0 To UBound(mVector)
            '               oEx.Selection.Insert Shift:=xlDown
            '            Next
            '            For i = 0 To UBound(mVector)
            '               .Range("A" & i + 1).Select
            '               oEx.ActiveCell.FormulaR1C1 = mVector(i)
            '               oEx.Selection.Font.Size = 12
            '               If i = 0 Then oEx.Selection.Font.Bold = True
            '            Next
      
            'If mPaginaInicial > 0 Then mPaginaInicial = mPaginaInicial - 1
            
            'oEx.Run "InicializarEncabezados", glbEmpresa, _
             glbDireccion & " " & glbLocalidad, glbTelefono1, _
             glbDatosAdicionales1 ', mPaginaInicial, mParametrosEncabezado
         
            '            With oEx.ActiveSheet.PageSetup
            '                .PrintTitleRows = "$1:$" & UBound(mVector) + 3
            '                .PrintTitleColumns = ""
            '            End With
         
            '            If Not IsMissing(Macro) Then
            '               If Len(Macro) > 0 Then
            '                  If InStr(Macro, "|") = 0 Then
            '                     oEx.Run Macro
            '                  Else
            '                     mVector = VBA.Split(Macro, "|")
            '                     s = ""
            '                     For i = 1 To UBound(mVector): s = s & mVector(i) & "|": Next
            '                     If Len(s) > 0 Then s = mId(s, 1, Len(s) - 1)
            '                     oEx.Run mVector(0), glbStringConexion, s
            '                  End If
            '               End If
            '            End If
         
            'oEx.Run "GenerarInforme", glbStringConexion, mTitulo, "" 'Lista.GetString
            If TipoSalida = 2 Then .Close False
        End With

        If TipoSalida = 2 Then .Quit
    End With

    Set oEx = Nothing

    'For Each oL In Lista.ListItems: oL.Selected = False: Next

End Sub

Public Sub ExportarAExcelVbalGrid(ByRef mLista As vbalGrid, _
                                  Optional ByRef Titulos As String, _
                                  Optional ByRef Macro As String, _
                                  Optional ByVal Parametros As String)

    'If mLista.ListItems.Count = 0 And mId(Titulos, 1, 17) <> "DEPOSITO BANCARIO" Then
    '   MsgBox "No hay elementos para exportar", vbExclamation
    '   Exit Sub
    'End If
   
    Dim s As String, mParametrosEncabezado As String
    Dim fl As Long, cl As Long, cl1 As Long, i As Long, SaltoCada As Long
    Dim mContador As Long, mColumnaTransporte As Long
    Dim mColumnaSumador1 As Integer, mColumnaSumador2 As Integer
    Dim mColumnaSumador3 As Integer, mColumnaSumador4 As Integer
    Dim mColumnaSumador5 As Integer, mColumnaSumador6 As Integer
    Dim mColumnaSumador7 As Integer, mColumnaSumador8 As Integer
    Dim mColumnaSumador9 As Integer, mColumnaSumador10 As Integer
    Dim mPaginaInicial As Integer, mFontDiario As Integer, mRowHeight As Integer
    Dim mTotalPagina1 As Double, mTotalPagina2 As Double, mTotalPagina3 As Double
    Dim mTotalPagina4 As Double, mTotalPagina5 As Double, mTotalPagina6 As Double
    Dim mTotalPagina7 As Double, mTotalPagina8 As Double, mTotalPagina9 As Double
    Dim mTotalPagina10 As Double
    Dim mTotalizar As Boolean, mFinTransporte As Boolean
    Dim oEx As Excel.Application
    Dim oL As ListItem
    Dim oS As ListSubItem
    Dim oCol As ColumnHeader
    Dim mVector, mVectorParametros, mSubVectorParametros, mVectorAux, mResumen(3, 1000)
   
    If Not IsMissing(Titulos) Then
        mVector = VBA.Split(Titulos, "|")
    End If
   
    mContador = 0
    SaltoCada = 0
    mColumnaSumador1 = 0
    mColumnaSumador2 = 0
    mColumnaSumador3 = 0
    mColumnaSumador4 = 0
    mColumnaSumador5 = 0
    mColumnaSumador6 = 0
    mColumnaSumador7 = 0
    mColumnaSumador8 = 0
    mColumnaSumador9 = 0
    mColumnaSumador10 = 0
    mTotalPagina1 = 0
    mTotalPagina2 = 0
    mTotalPagina3 = 0
    mTotalPagina4 = 0
    mTotalPagina5 = 0
    mTotalPagina6 = 0
    mTotalPagina7 = 0
    mTotalPagina8 = 0
    mTotalPagina9 = 0
    mTotalPagina10 = 0
    mColumnaTransporte = 0
    mPaginaInicial = 0
    mParametrosEncabezado = ""
    mFinTransporte = False
   
    If Not IsMissing(Parametros) Then
        mVectorParametros = VBA.Split(Parametros, "|")

        If UBound(mVectorParametros) > 0 Then

            For i = 0 To UBound(mVectorParametros)

                If InStr(mVectorParametros(i), "SaltoDePaginaCada") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    SaltoCada = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "SumadorPorHoja1") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mColumnaSumador1 = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "SumadorPorHoja2") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mColumnaSumador2 = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "SumadorPorHoja3") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mColumnaSumador3 = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "SumadorPorHoja4") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mColumnaSumador4 = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "SumadorPorHoja5") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mColumnaSumador5 = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "SumadorPorHoja6") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mColumnaSumador6 = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "SumadorPorHoja7") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mColumnaSumador7 = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "SumadorPorHoja8") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mColumnaSumador8 = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "SumadorPorHoja9") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mColumnaSumador9 = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "SumadorPorHoja10") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mColumnaSumador10 = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "ColumnaTransporte") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mColumnaTransporte = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "PaginaInicial") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mPaginaInicial = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "Enc:") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mParametrosEncabezado = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "FontDiario:") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mFontDiario = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "RowHeightDiario:") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mRowHeight = mSubVectorParametros(1)
                ElseIf InStr(mVectorParametros(i), "TransporteInicialDiario:") <> 0 Then
                    mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
                    mTotalPagina1 = CDbl(mSubVectorParametros(1))
                    mTotalPagina2 = CDbl(mSubVectorParametros(1))

                End If

            Next

        End If
    End If
   
    If mColumnaTransporte = 0 Then mColumnaTransporte = 3
   
    Set oEx = CreateObject("Excel.Application")
   
    With oEx
      
        .Visible = True
      
        With .Workbooks.Add(glbPathPlantillas & "\Planilla.xlt")
         
            With .ActiveSheet

                cl = 1

                For cl = 1 To mLista.Columns

                    If oCol.Width > 0 Or oCol.Text = "Vector_E" Then
                        .Cells(1, cl) = mLista.CellText(0, cl)
                        cl = cl + 1
                    End If

                Next
 
                fl = 2
            
                If mTotalPagina1 <> 0 Or mTotalPagina2 <> 0 Or mTotalPagina3 <> 0 Or mTotalPagina4 <> 0 Or mTotalPagina5 <> 0 Or mTotalPagina6 <> 0 Or mTotalPagina7 <> 0 Or mTotalPagina8 <> 0 Or mTotalPagina9 <> 0 Or mTotalPagina10 <> 0 Then
                    .Cells(fl, mColumnaTransporte) = "Transporte"

                    If mColumnaSumador1 <> 0 Then
                        .Cells(fl, mColumnaSumador1) = mTotalPagina1
                        .Cells(fl, mColumnaSumador1).NumberFormat = "#,##0.00"
                    End If

                    If mColumnaSumador2 <> 0 Then
                        .Cells(fl, mColumnaSumador2) = mTotalPagina2
                        .Cells(fl, mColumnaSumador2).NumberFormat = "#,##0.00"
                    End If

                    If mColumnaSumador3 <> 0 Then
                        .Cells(fl, mColumnaSumador3) = mTotalPagina3
                        .Cells(fl, mColumnaSumador3).NumberFormat = "#,##0.00"
                    End If

                    If mColumnaSumador4 <> 0 Then
                        .Cells(fl, mColumnaSumador4) = mTotalPagina4
                        .Cells(fl, mColumnaSumador4).NumberFormat = "#,##0.00"
                    End If

                    If mColumnaSumador5 <> 0 Then
                        .Cells(fl, mColumnaSumador5) = mTotalPagina5
                        .Cells(fl, mColumnaSumador5).NumberFormat = "#,##0.00"
                    End If

                    If mColumnaSumador6 <> 0 Then
                        .Cells(fl, mColumnaSumador6) = mTotalPagina6
                        .Cells(fl, mColumnaSumador6).NumberFormat = "#,##0.00"
                    End If

                    If mColumnaSumador7 <> 0 Then
                        .Cells(fl, mColumnaSumador7) = mTotalPagina7
                        .Cells(fl, mColumnaSumador7).NumberFormat = "#,##0.00"
                    End If

                    If mColumnaSumador8 <> 0 Then
                        .Cells(fl, mColumnaSumador8) = mTotalPagina8
                        .Cells(fl, mColumnaSumador8).NumberFormat = "#,##0.00"
                    End If

                    If mColumnaSumador9 <> 0 Then
                        .Cells(fl, mColumnaSumador9) = mTotalPagina9
                        .Cells(fl, mColumnaSumador9).NumberFormat = "#,##0.00"
                    End If

                    If mColumnaSumador10 <> 0 Then
                        .Cells(fl, mColumnaSumador10) = mTotalPagina10
                        .Cells(fl, mColumnaSumador10).NumberFormat = "#,##0.00"
                    End If

                    fl = fl + 1
                End If
            
                '            For cl1 = 0 To mLista.Rows
                '
                '               If mLista.ColumnHeaders.Item(1).Width <> 0 Then
                '                  If mLista.TipoDatoColumna(0) = "D" Then
                '                     If IsDate(oL.Text) Then .Cells(fl, 1) = CDate(oL.Text)
                '                  Else
                '                     If mLista.TipoDatoColumna(0) = "S" Then
                '                        .Cells(fl, 1) = "'" & oL.Text
                '                     Else
                '                        .Cells(fl, 1) = oL.Text
                '                     End If
                '                  End If
                '                  cl1 = 1
                '               Else
                '                  cl1 = 0
                '               End If
                '
                '               cl = 1
                '               For Each oS In oL.ListSubItems
                '                  cl = cl + 1
                '                  If mLista.ColumnHeaders.Item(oS.Index + 1).Width <> 0 Or _
                '                        mLista.ColumnHeaders.Item(oS.Index + 1).Text = "Vector_E" Then
                '                     cl1 = cl1 + 1
                '                     If Len(Trim(oS.Text)) <> 0 Then
                '                        If mLista.TipoDatoColumna(cl - 1) = "D" Then
                '                           .Cells(fl, cl1) = CDate(oS.Text)
                '                        Else
                '                           If mLista.TipoDatoColumna(cl - 1) = "S" Then
                '                              .Cells(fl, cl1) = "'" & mId(oS.Text, 1, 1000)
                '                           Else
                '                              .Cells(fl, cl1) = mId(oS.Text, 1, 1000)
                '                           End If
                '                        End If
                '                     End If
                '
                '                     mTotalizar = True
                '                     mVectorAux = VBA.Split(oL.SubItems(oL.ListSubItems.Count), "|")
                '                     If IsArray(mVectorAux) Then
                '                        If UBound(mVectorAux) >= oS.Index Then
                '                           If InStr(1, mVectorAux(oS.Index), "NOSUMAR") <> 0 Then
                '                              mTotalizar = False
                '                           End If
                '                        End If
                '                     End If
                '
                '                     If mLista.ColumnHeaders.Item(oS.Index + 1).Text = "Vector_E" Then
                '                        If InStr(1, oS.Text, "FinTransporte") <> 0 Then
                '                           mFinTransporte = True
                '                        End If
                '                     End If
                '
                '                     If mColumnaSumador1 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                '                        mTotalPagina1 = mTotalPagina1 + CDbl(oS.Text)
                '                     End If
                '                     If mColumnaSumador2 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                '                        mTotalPagina2 = mTotalPagina2 + CDbl(oS.Text)
                '                     End If
                '                     If mColumnaSumador3 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                '                        mTotalPagina3 = mTotalPagina3 + CDbl(oS.Text)
                '                     End If
                '                     If mColumnaSumador4 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                '                        mTotalPagina4 = mTotalPagina4 + CDbl(oS.Text)
                '                     End If
                '                     If mColumnaSumador5 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                '                        mTotalPagina5 = mTotalPagina5 + CDbl(oS.Text)
                '                     End If
                '                     If mColumnaSumador6 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                '                        mTotalPagina6 = mTotalPagina6 + CDbl(oS.Text)
                '                     End If
                '                     If mColumnaSumador7 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                '                        mTotalPagina7 = mTotalPagina7 + CDbl(oS.Text)
                '                     End If
                '                     If mColumnaSumador8 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                '                        mTotalPagina8 = mTotalPagina8 + CDbl(oS.Text)
                '                     End If
                '                     If mColumnaSumador9 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                '                        mTotalPagina9 = mTotalPagina9 + CDbl(oS.Text)
                '                     End If
                '                     If mColumnaSumador10 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                '                        mTotalPagina10 = mTotalPagina10 + CDbl(oS.Text)
                '                     End If
                '                  End If
                '               Next
                '               fl = fl + 1
                '               mContador = mContador + 1
                '
                '               If SaltoCada = mContador And Not mFinTransporte Then
                '                  mContador = 0
                '                  .Cells(fl, mColumnaTransporte) = "Transporte"
                '                  If mColumnaSumador1 <> 0 Then
                '                     .Cells(fl, mColumnaSumador1) = mTotalPagina1
                '                     .Cells(fl, mColumnaSumador1).NumberFormat = "#,##0.00"
                '                  End If
                '                  If mColumnaSumador2 <> 0 Then
                '                     .Cells(fl, mColumnaSumador2) = mTotalPagina2
                '                     .Cells(fl, mColumnaSumador2).NumberFormat = "#,##0.00"
                '                  End If
                '                  If mColumnaSumador3 <> 0 Then
                '                     .Cells(fl, mColumnaSumador3) = mTotalPagina3
                '                     .Cells(fl, mColumnaSumador3).NumberFormat = "#,##0.00"
                '                  End If
                '                  If mColumnaSumador4 <> 0 Then
                '                     .Cells(fl, mColumnaSumador4) = mTotalPagina4
                '                     .Cells(fl, mColumnaSumador4).NumberFormat = "#,##0.00"
                '                  End If
                '                  If mColumnaSumador5 <> 0 Then
                '                     .Cells(fl, mColumnaSumador5) = mTotalPagina5
                '                     .Cells(fl, mColumnaSumador5).NumberFormat = "#,##0.00"
                '                  End If
                '                  If mColumnaSumador6 <> 0 Then
                '                     .Cells(fl, mColumnaSumador6) = mTotalPagina6
                '                     .Cells(fl, mColumnaSumador6).NumberFormat = "#,##0.00"
                '                  End If
                '                  If mColumnaSumador7 <> 0 Then
                '                     .Cells(fl, mColumnaSumador7) = mTotalPagina7
                '                     .Cells(fl, mColumnaSumador7).NumberFormat = "#,##0.00"
                '                  End If
                '                  If mColumnaSumador8 <> 0 Then
                '                     .Cells(fl, mColumnaSumador8) = mTotalPagina8
                '                     .Cells(fl, mColumnaSumador8).NumberFormat = "#,##0.00"
                '                  End If
                '                  If mColumnaSumador9 <> 0 Then
                '                     .Cells(fl, mColumnaSumador9) = mTotalPagina9
                '                     .Cells(fl, mColumnaSumador9).NumberFormat = "#,##0.00"
                '                  End If
                '                  If mColumnaSumador10 <> 0 Then
                '                     .Cells(fl, mColumnaSumador10) = mTotalPagina10
                '                     .Cells(fl, mColumnaSumador10).NumberFormat = "#,##0.00"
                '                  End If
                '                  fl = fl + 1
                '               End If
                '
                '            Next
                '
                '            If SaltoCada = -1 Then
                '               If mColumnaSumador1 <> 0 Then
                '                  .Cells(fl, mColumnaSumador1) = mTotalPagina1
                '                  .Cells(fl, mColumnaSumador1).NumberFormat = "#,##0.00"
                '               End If
                '               If mColumnaSumador2 <> 0 Then
                '                  .Cells(fl, mColumnaSumador2) = mTotalPagina2
                '                  .Cells(fl, mColumnaSumador2).NumberFormat = "#,##0.00"
                '               End If
                '               If mColumnaSumador3 <> 0 Then
                '                  .Cells(fl, mColumnaSumador3) = mTotalPagina3
                '                  .Cells(fl, mColumnaSumador3).NumberFormat = "#,##0.00"
                '               End If
                '               If mColumnaSumador4 <> 0 Then
                '                  .Cells(fl, mColumnaSumador4) = mTotalPagina4
                '                  .Cells(fl, mColumnaSumador4).NumberFormat = "#,##0.00"
                '               End If
                '               If mColumnaSumador5 <> 0 Then
                '                  .Cells(fl, mColumnaSumador5) = mTotalPagina5
                '                  .Cells(fl, mColumnaSumador5).NumberFormat = "#,##0.00"
                '               End If
                '               If mColumnaSumador6 <> 0 Then
                '                  .Cells(fl, mColumnaSumador6) = mTotalPagina6
                '                  .Cells(fl, mColumnaSumador6).NumberFormat = "#,##0.00"
                '               End If
                '               If mColumnaSumador7 <> 0 Then
                '                  .Cells(fl, mColumnaSumador7) = mTotalPagina7
                '                  .Cells(fl, mColumnaSumador7).NumberFormat = "#,##0.00"
                '               End If
                '               If mColumnaSumador8 <> 0 Then
                '                  .Cells(fl, mColumnaSumador8) = mTotalPagina8
                '                  .Cells(fl, mColumnaSumador8).NumberFormat = "#,##0.00"
                '               End If
                '               If mColumnaSumador9 <> 0 Then
                '                  .Cells(fl, mColumnaSumador9) = mTotalPagina9
                '                  .Cells(fl, mColumnaSumador9).NumberFormat = "#,##0.00"
                '               End If
                '               If mColumnaSumador10 <> 0 Then
                '                  .Cells(fl, mColumnaSumador10) = mTotalPagina10
                '                  .Cells(fl, mColumnaSumador10).NumberFormat = "#,##0.00"
                '               End If
                '               fl = fl + 1
                '            End If
                '
                '
                '            .Rows("1:1").Select
                '            oEx.Selection.Insert Shift:=xlDown
                '            For i = 0 To UBound(mVector)
                '               oEx.Selection.Insert Shift:=xlDown
                '            Next
                '            For i = 0 To UBound(mVector)
                '               .Range("A" & i + 1).Select
                '               oEx.ActiveCell.FormulaR1C1 = mVector(i)
                '               oEx.Selection.Font.Size = 12
                '               If i = 0 Then oEx.Selection.Font.Bold = True
                '            Next
                '
                '            'If mPaginaInicial > 0 Then mPaginaInicial = mPaginaInicial - 1
                '            oEx.Run "InicializarEncabezados", glbEmpresa, _
                '                        glbDireccion & " " & glbLocalidad, glbTelefono1, _
                '                        glbDatosAdicionales1, mPaginaInicial, mParametrosEncabezado
                '
                '            With oEx.ActiveSheet.PageSetup
                '                .PrintTitleRows = "$1:$" & UBound(mVector) + 3
                '                .PrintTitleColumns = ""
                '            End With
                '
                '            If Not IsMissing(Macro) Then
                '               If Len(Macro) > 0 Then
                '                  If InStr(Macro, "|") = 0 Then
                '                     oEx.Run Macro
                '                  Else
                '                     mVector = VBA.Split(Macro, "|")
                '                     s = ""
                '                     For i = 1 To UBound(mVector): s = s & mVector(i) & "|": Next
                '                     If Len(s) > 0 Then s = mId(s, 1, Len(s) - 1)
                '                     oEx.Run mVector(0), glbStringConexion, s
                '                  End If
                '               End If
                '            End If
         
                '.Range("A1").Select
                '
                'oEx.Run "ArmarFormato"
         
            End With
      
        End With
      
    End With
   
    Set oEx = Nothing

End Sub

Private Sub Editar(ByVal Identificador As Long, _
                   ByVal TipoComprobante As String)

    Dim oF As Form
      
    Select Case TipoComprobante
            '      Case "Acopio"
            '         Set oF = New frmAcopios
            '      Case "Pedido"
            '         Set oF = New frmPedidos
            '      Case "L.Materiales"
            '         Set oF = New frmLMateriales
            '      Case "R.M."
            '         Set oF = New frmRequerimientos
            '      Case "Comparativa"
            '         Set oF = New frmComparativa
            '      Case "Recepcion"
            '         Set oF = New frmRecepciones
            '      Case "ComprobanteProveedor"
            '         Set oF = New frmComprobantesPrv
            '      Case Else
            '         MsgBox "Comprobante no editable"
            '         GoTo Salida:
    End Select
   
    '   With oF
    '      .Id = Identificador
    '      If TipoComprobante = "R.M." Then
    '         oF.Password = mPassword
    '      End If
    '      .Disparar = ActL
    '      .cmd(0).Enabled = False
    '      .Show vbModal, Me
    '   End With

Salida:

    Set oF = Nothing

End Sub

'//////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////

'GRID //////////////////////////////////////////////////////////////
'Private Sub Grid_ColumnClick(ByVal lCol As Long)
'    'Para que se ordene por la columna clickeada
'    'El column sort type debe estar cargado
'    Screen.MousePointer = vbHourglass
'
'    With Grid
'        .redraw = False
'
'        .SortObject.Clear
'        .SortObject.SortColumn(1) = lCol
'        .SortObject.SortType(1) = .ColumnSortType(lCol)
'
'        'Invertir el orden
'        If m_SortAsc Then
'            .SortObject.SortOrder(1) = CCLOrderDescending
'        Else
'            .SortObject.SortOrder(1) = CCLOrderAscending
'        End If
'        .Sort
'
'        m_SortAsc = Not m_SortAsc
'
'        'Setear Icono Columna
'        Dim i As Long
'        For i = 1 To .Columns
'            If i = lCol Then
'                If m_SortAsc Then
'                    .ColumnImage(i) = IDI_DOWN
'                Else
'                    .ColumnImage(i) = IDI_UP
'                End If
'            Else
'                .ColumnImage(i) = -1
'            End If
'        Next
'        '/:~
'
'        .redraw = True
'    End With
'
'    Screen.MousePointer = vbDefault
'End Sub

'Private Sub Grid_DblClick(ByVal lRow As Long, ByVal lCol As Long)
'    If m_LastButtonClick = 0 Then Update
'End Sub

'Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer, bDoDefault As Boolean)
'    If KeyCode = vbKeySpace Then
'        ToggleSelection (Grid.SelectedRow)
'    End If
'End Sub
'
'Private Sub Grid_KeyPress(KeyAscii As Integer)
'    If KeyAscii = 13 Then Update
'End Sub

'Private Sub Grid_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single, bDoDefault As Boolean)
'    Dim lRow As Long, _
'        lCol As Long
'    m_x = X + Grid.Left
'    m_y = Y + Grid.Top
'
'    If Button = vbRightButton Then
'        'Menu contextual
'        m_LastButtonClick = 1
'        With Grid
'            If .SelectedRow > 0 Then
'                .CellFromPoint X / Screen.TwipsPerPixelX, Y / Screen.TwipsPerPixelY, lRow, lCol
'                If lRow > 0 Then
'                    '.SelectedRow = lRow
'                    Set m_CellUnderMouse = .cell(lRow, lCol)
'                    ShowContextMenu
'                End If
'           End If
'        End With
'    ElseIf Button = vbLeftButton Then
'        m_LastButtonClick = 0
'    End If
'End Sub

'Private Sub SelectByRowItemData(ByVal Id As Long)
'On Error Resume Next
''Selecciona una fila a partir del RowItemData
'    Dim lRow As Long
'    lRow = vbal_FindRow(Grid, Id, vbal_sRowItemData)
'    If lRow <> -1 Then
'        Grid.SelectedRow = lRow
'        Grid.EnsureVisible lRow, 1
'    End If
'End Sub

Private Sub ConfigGrid()

    With Grid
        .Redraw = False
        
        ' Source of icons.  This can be vbAccelerator ImageList control, class or
        ' a VB ImageList
        .ImageList = ImageList1
        ' Row mode - select the entire row:
        .RowMode = True
        ' Allow more than one row to be selected:
        .MultiSelect = True
        ' Set the default row height:
        .DefaultRowHeight = 18
        ' Outlook style for the header control:
        .HeaderFlat = True
        ' As it says
        .StretchLastColumnToFit = True
           
        If .Columns <> 0 Then Exit Sub
        
        '.AddColumn "ICON"
        '.ColumnWidth(1) = 25
        '.ColumnFixedWidth(1) = True
        .StretchLastColumnToFit = True
        
        'Tienen que aparecer los PPs, los OI y SM generados por los PPs, y
        'los remitos de recepcion del proveedor...  Tambien
        'falta poner el Numero y la Fecha
        
        .AddColumn , "Partida1", ecgHdrTextALignCentre, , 50, False, , , , , , CCLSortNumeric
        .AddColumn , "Partida2", ecgHdrTextALignCentre, , 100, False, , , , , , CCLSortNumeric
        .AddColumn , "Partida3", ecgHdrTextALignCentre, , 100, False, , , , , , CCLSortNumeric
        
        .AddColumn , "Partida", ecgHdrTextALignCentre, , 200, , , , , , , CCLSortNumeric
        .AddColumn , "Tipo", ecgHdrTextALignCentre, , 50, , , , , , , CCLSortNumeric
        .AddColumn , "Numero", ecgHdrTextALignCentre, , 90, , , , , , , CCLSortNumeric
        .AddColumn , "Fecha", ecgHdrTextALignCentre, , 65, , , , , , , CCLSortDate
        
        .AddColumn , "IdStock", ecgHdrTextALignCentre, , 100, False, , , , , , CCLSortNumeric
        .AddColumn , "IdArticulo", ecgHdrTextALignCentre, , 50, False, , , , , , CCLSortNumeric
        .AddColumn , "Codigo", ecgHdrTextALignCentre, , 300, , , , , , , CCLSortNumeric
        .AddColumn , "Descripcion", ecgHdrTextALignCentre, , 80, , , , , , , CCLSortString
        .AddColumn , "Cant.", ecgHdrTextALignRight, , 200, , , , , "0.00", , CCLSortNumeric
        
        .AddColumn , "N°Parte", ecgHdrTextALignCentre, , 90, False, , , , , , CCLSortNumeric
        .AddColumn , "N°Ingreso", ecgHdrTextALignCentre, , 90, False, , , , , , CCLSortNumeric
        .AddColumn , "N°Salida", ecgHdrTextALignCentre, , 90, False, , , , , , CCLSortNumeric
        .AddColumn , "N°Recepcion", ecgHdrTextALignCentre, , 90, False, , , , , , CCLSortNumeric
        
        .AddColumn , "N°Orden Compra", ecgHdrTextALignCentre, , 90, , , , , , , CCLSortNumeric

        'Columna que solo sirve para ajustar la última
        .AddColumn , "", ecgHdrTextALignCentre, , 0, , , , , "$ 0.00", , CCLSortNumeric
        
        '.SetHeaders
        .AllowGrouping = True
        .HideGroupingBox = True
        '.ColumnIsGrouped(1) = True
        '.ColumnIsGrouped(2) = True
        '.ColumnIsGrouped(3) = True
        .AutoWidthColumn (GP_COL_CODART)
        .AutoWidthColumn (GP_COL_DESCART)
        .AutoWidthColumn (GP_COL_CANTIDAD)
        
        '.SortObject.GroupBy(
        '.AutoHeightRow
        
        '////////////////////////////////////
        '        .SortObject.Clear
        '        .SortObject.SortColumn(1) = GP_COL_PARTIDA
        '        .SortObject.SortType(1) = .ColumnSortType(GP_COL_PARTIDA)
        '        .SortObject.SortOrder(1) = CCLOrderDescending
        '
        '        .SortObject.SortColumn(2) = GP_COL_NIVEL2
        '        .SortObject.SortType(2) = .ColumnSortType(GP_COL_NIVEL2)
        '        .SortObject.SortOrder(2) = CCLOrderDescending
        '
        '        .SortObject.SortColumn(3) = GP_COL_NIVEL3
        '        .SortObject.SortType(3) = .ColumnSortType(GP_COL_NIVEL3)
        '        .SortObject.SortOrder(3) = CCLOrderDescending

        '////////////////////////////////////

        .Redraw = True
    End With

End Sub

Sub ReloadGrid(Optional Redraw As Boolean = True)
    On Error Resume Next
        
    Dim rs As New ADODB.Recordset
    Dim strSql As String
    Dim i As Long
    
    Screen.MousePointer = vbHourglass
    
    'FALTA EL TOP
        
    Dim oAp As ComPronto.Aplicacion
    Set oAp = Aplicacion
        
    Dim rs1 As ADOR.Recordset
    Dim rs2 As ADOR.Recordset
    
    Dim sPartidaElegida As String

    'sPartidaElegida = dcfields(11)
    With dblistPartidasFiltradas
       
        If Not .SelectedItem Is Nothing Then
        
            sPartidaElegida = .SelectedItem.Tag
        
            Dim Filas, Columnas, iFilas
            Dim s As String
        
            Filas = VBA.Split(.GetString, vbCrLf)
            s = ""

            '  For iFilas = LBound(Filas) + 1 To UBound(Filas)
            'Columnas = VBA.Split(Filas(iFilas), vbTab)
            '
            '   If IsNumeric(Columnas(2)) Then
            '      'Aplicacion.Tarea "OrdenesPago_MarcarComoPendiente", Columnas(2)
            '      Exit For
            '  End If

            '  Next
        
            'sPartidaElegida = .ListItems(.SelectedItem.Index).SubItems(5)
            Columnas = VBA.Split(Filas(1), vbTab)
            sPartidaElegida = Val(Columnas(1))
        End If

    End With
        
    If OptAscendencia(0) Then
        Set rs1 = oAp.ProduccionOrdenes.TraerFiltrado("_PartidasUsadas", sPartidaElegida)
    Else
        Set rs1 = oAp.ProduccionOrdenes.TraerFiltrado("_PartidasQueLoUsan", sPartidaElegida)
    End If
    
    If rs1 Is Nothing Then Exit Sub

    'If rs1 = 0 Then Exit Sub
    With Grid
        .Redraw = False
        .Clear
        
        '.SetHeaders
        
        '.AllowGrouping = False
        '.StretchLastColumnToFit = True
        '.ColumnIsGrouped(1) = True
        '.ColumnIsGrouped(2) = True
        '.ColumnIsGrouped(3) = True

        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        '        necesito agregar el renglon con la informacion de la partida seleccionada
        '        como eso no viene en el sp, lo hago por COM -pero sería bueno que lo hicieras por
        '        SQL, así si cambiás a la ListView no tenés mucho quilombo
        .AddRow
        i = .Rows
        '.RowItemData(i) = rs1!Partida
        
        Dim op As ProduccionOrden
        Dim xrs As ADOR.Recordset
        Set xrs = Aplicacion.ProduccionOrdenes.TraerTodos
        xrs.Filter = "Número='" & sPartidaElegida & "'"
        
        If xrs.RecordCount > 0 Then 'es una OP
        
            Set op = Aplicacion.ProduccionOrdenes.Item(xrs!IdProduccionOrden)
        
            .CellDetails i, GP_COL_PARTIDA, xrs!Número, DT_RIGHT, , vbButtonFace
            .CellDetails i, GP_COL_NIVEL2, "", DT_CENTER
            .CellDetails i, GP_COL_NIVEL3, "", DT_LEFT
            
            .CellDetails i, GP_COL_PARTIDATEXTO, xrs!Número & vbNullString, DT_LEFT, , vbButtonFace, , , 1
            .CellDetails i, GP_COL_TIPO, "", DT_LEFT, , vbButtonFace
            .CellDetails i, GP_COL_NUMERO, xrs!Número & vbNullString, DT_LEFT, , vbButtonFace
            .CellDetails i, GP_COL_FECHA, xrs.Fields("Inicio Previsto") & vbNullString, DT_LEFT, , vbButtonFace
            
            .CellDetails i, GP_COL_IDARTICULO, xrs!idArticuloGenerado, DT_RIGHT, , vbButtonFace
            .CellDetails i, GP_COL_CODART, xrs!Codigo, DT_RIGHT, , vbButtonFace
            .CellDetails i, GP_COL_DESCART, xrs.Fields("Art. Producido"), DT_RIGHT, , vbButtonFace
            .CellDetails i, GP_COL_CANTIDAD, xrs!Cantidad, DT_RIGHT, , vbButtonFace
        
            .CellDetails i, GP_COL_OC, listaDISTINCT(xrs!NumeroOC1, xrs!NumeroOC2, xrs!NumeroOC3, xrs!NumeroOC4, xrs!NumeroOC5), DT_RIGHT, , vbButtonFace
            '.CellDetails i, GP_COL_OC, xrs!IdDetalleOrdenCompraImputado1 & " " & xrs!IdDetalleOrdenCompraImputado2, DT_RIGHT, , vbButtonFace
        
        Else 'es una partida de material no producido
        
            Set xrs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_CompletoPorArticulo", Array(0, sPartidaElegida, 0, 0, 0, 0))
            'rsStock.Find "=" &
        
            .CellDetails i, GP_COL_PARTIDA, xrs!partida, DT_RIGHT, , vbButtonFace
            .CellDetails i, GP_COL_NIVEL2, "", DT_CENTER, , vbButtonFace
            .CellDetails i, GP_COL_NIVEL3, "", DT_LEFT, , vbButtonFace
            
            .CellDetails i, GP_COL_PARTIDATEXTO, xrs!partida & vbNullString, DT_LEFT, , vbButtonFace
            .CellDetails i, GP_COL_TIPO, "", DT_LEFT, , vbButtonFace
            .CellDetails i, GP_COL_NUMERO, xrs!partida & vbNullString, DT_LEFT, , vbButtonFace
            '.CellDetails i, GP_COL_FECHA, xrs.Fields("Inicio Previsto") & vbNullString, DT_LEFT
            
            .CellDetails i, GP_COL_IDARTICULO, xrs!IdArticulo, DT_RIGHT, , vbButtonFace
            .CellDetails i, GP_COL_CODART, xrs!Codigo, DT_RIGHT, , vbButtonFace
            .CellDetails i, GP_COL_DESCART, xrs.Fields("Descripcion"), DT_RIGHT, , vbButtonFace
            '.CellDetails i, GP_COL_CANTIDAD, xrs!Cantidad, DT_RIGHT
        
        End If
        
        .CellExtraIcon(i, GP_COL_PARTIDATEXTO) = 0
        
        Set xrs = Nothing
        
        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        
        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        
        While Not rs1.EOF
            .AddRow
            i = .Rows
            '.RowItemData(i) = rs1!Partida
            
            .CellDetails i, GP_COL_PARTIDA, rs1!partida, DT_RIGHT, , vbButtonFace
            .CellDetails i, GP_COL_NIVEL2, "", DT_CENTER
            .CellDetails i, GP_COL_NIVEL3, "", DT_LEFT
            
            .CellDetails i, GP_COL_PARTIDATEXTO, rs1!partida & vbNullString, DT_LEFT, , vbButtonFace, , , 20
            .CellDetails i, GP_COL_TIPO, "", DT_LEFT, , vbButtonFace
            .CellDetails i, GP_COL_NUMERO, rs1!NumeroOrdenProduccion & vbNullString, DT_LEFT, , vbButtonFace
            .CellDetails i, GP_COL_FECHA, rs1!Fechadia & vbNullString, DT_LEFT, , vbButtonFace
            
            .CellDetails i, GP_COL_IDSTOCK, rs1!IdStock & vbNullString, DT_LEFT, , vbButtonFace
            .CellDetails i, GP_COL_IDARTICULO, rs1!IdArticulo, DT_RIGHT, , vbButtonFace
            .CellDetails i, GP_COL_CODART, rs1!Codigo, DT_RIGHT, , vbButtonFace
            .CellDetails i, GP_COL_DESCART, rs1!descripcion, DT_RIGHT, , vbButtonFace
            .CellDetails i, GP_COL_CANTIDAD, rs1!Cantidad, DT_RIGHT, , vbButtonFace
            
            .CellDetails i, GP_COL_IDPP, rs1!idProduccionParte, DT_RIGHT, , vbButtonFace
            .CellDetails i, GP_COL_IDOI, rs1!NumeroOtroIngresoAlmacen, DT_RIGHT, , vbButtonFace
            .CellDetails i, GP_COL_IDSM, rs1!NumeroSalidaMateriales, DT_RIGHT, , vbButtonFace
            .CellDetails i, GP_COL_IDRP, rs1!NumeroRecepcion2, DT_RIGHT, , vbButtonFace
            
            .CellExtraIcon(i, GP_COL_PARTIDATEXTO) = 0
            
            If Not IsNull(rs1!idProduccionParte) Then
                .AddRow
                i = .Rows
                .CellDetails i, GP_COL_PARTIDA, rs1!partida, DT_RIGHT
                .CellDetails i, GP_COL_NIVEL2, "", rs1!partida, DT_CENTER
                .CellDetails i, GP_COL_NIVEL3, "", DT_LEFT
                .CellDetails i, GP_COL_TIPO, "PP", DT_LEFT
                .CellDetails i, GP_COL_NUMERO, rs1!idProduccionParte & vbNullString, DT_LEFT
            End If
            
            If Not IsNull(rs1!NumeroSalidaMateriales) Then
                .AddRow
                i = .Rows
                .CellDetails i, GP_COL_PARTIDA, rs1!partida, DT_RIGHT
                .CellDetails i, GP_COL_NIVEL2, "", rs1!partida, DT_CENTER
                .CellDetails i, GP_COL_NIVEL3, "", DT_LEFT
                .CellDetails i, GP_COL_TIPO, "SM", DT_LEFT
                .CellDetails i, GP_COL_NUMERO, rs1!NumeroSalidaMateriales & vbNullString, DT_LEFT
            End If
            
            If Not IsNull(rs1!NumeroRecepcion2) Then
                .AddRow
                i = .Rows
                .CellDetails i, GP_COL_PARTIDA, rs1!partida, DT_RIGHT
                .CellDetails i, GP_COL_NIVEL2, "", !partida, DT_CENTER
                .CellDetails i, GP_COL_NIVEL3, "", DT_LEFT
                .CellDetails i, GP_COL_TIPO, "RECEP", DT_LEFT
                .CellDetails i, GP_COL_NUMERO, rs1!NumeroRecepcion2 & vbNullString, DT_LEFT
            End If
            
            If Not IsNull(rs1!NumeroOtroIngresoAlmacen) Then
                .AddRow
                i = .Rows
                .CellDetails i, GP_COL_PARTIDA, rs1!partida, DT_RIGHT
                .CellDetails i, GP_COL_NIVEL2, "", !partida, DT_CENTER
                .CellDetails i, GP_COL_NIVEL3, "", DT_LEFT
                .CellDetails i, GP_COL_TIPO, "OI", DT_LEFT
                .CellDetails i, GP_COL_NUMERO, rs1!NumeroOtroIngresoAlmacen & vbNullString, DT_LEFT
            End If
            
            '            If Not IsNull(rs1!RemitoCliente) Then
            '                .AddRow
            '                i = .Rows
            '            .CellDetails i, GP_COL_PARTIDA, rs1!Partida, DT_RIGHT
            '            .CellDetails i, GP_COL_NIVEL2, "", !Partida, DT_CENTER
            '            .CellDetails i, GP_COL_NIVEL3, "", DT_LEFT
            '                .CellDetails i, GP_COL_TIPO, "REM", DT_LEFT
            '                .CellDetails i, GP_COL_NUMERO, rs1!NumeroOtroIngresoAlmacen & vbNullString, DT_LEFT
            '            End If
            
            If OptAscendencia(0) Then
                Set rs2 = oAp.ProduccionOrdenes.TraerFiltrado("_PartidasUsadas", rs1!partida)
            Else
                Set rs2 = oAp.ProduccionOrdenes.TraerFiltrado("_PartidasQueLoUsan", rs1!partida)
            End If

            If Not rs2 Is Nothing Then
                While Not rs2.EOF
                    .AddRow
                    i = .Rows
                    '.RowItemData(i) = rs2!Partida
                    
                    .CellDetails i, GP_COL_PARTIDA, rs1!partida, DT_RIGHT, , vbButtonFace
                    .CellDetails i, GP_COL_NIVEL2, rs2!partida, DT_CENTER, , vbButtonFace
                    .CellDetails i, GP_COL_NIVEL3, "", DT_LEFT
                    
                    .CellDetails i, GP_COL_PARTIDATEXTO, rs2!partida & vbNullString, DT_LEFT, , vbButtonFace, , , 40
                    .CellDetails i, GP_COL_TIPO, "", DT_LEFT, , vbButtonFace
                    .CellDetails i, GP_COL_NUMERO, rs2!NumeroOrdenProduccion & vbNullString, DT_LEFT, , vbButtonFace
                    .CellDetails i, GP_COL_FECHA, rs2!Fechadia & vbNullString, DT_LEFT, , vbButtonFace
                    
                    .CellDetails i, GP_COL_IDSTOCK, rs2!IdStock & vbNullString, DT_LEFT, , vbButtonFace
                    .CellDetails i, GP_COL_IDARTICULO, rs2!IdArticulo, DT_RIGHT, , vbButtonFace
                    .CellDetails i, GP_COL_CODART, rs2!Codigo, DT_RIGHT, , vbButtonFace
                    .CellDetails i, GP_COL_DESCART, rs2!descripcion, DT_RIGHT, , vbButtonFace
                    .CellDetails i, GP_COL_CANTIDAD, rs2!Cantidad, DT_RIGHT, , vbButtonFace
            
                    .CellDetails i, GP_COL_IDPP, rs2!idProduccionParte, DT_RIGHT, , vbButtonFace
                    .CellDetails i, GP_COL_IDSM, rs2!NumeroSalidaMateriales, DT_RIGHT, , vbButtonFace
                    .CellDetails i, GP_COL_IDRP, rs2!NumeroRecepcion2, DT_RIGHT, , vbButtonFace
                    .CellDetails i, GP_COL_IDOI, rs2!NumeroOtroIngresoAlmacen, DT_RIGHT, , vbButtonFace
                    
                    .CellExtraIcon(i, GP_COL_PARTIDATEXTO) = 0
                
                    If Not IsNull(rs2!idProduccionParte) Then
                        .AddRow
                        i = .Rows
                        .CellDetails i, GP_COL_PARTIDA, rs1!partida, DT_RIGHT
                        .CellDetails i, GP_COL_NIVEL2, rs2!partida, DT_CENTER
                        .CellDetails i, GP_COL_NIVEL3, "", DT_LEFT
                        .CellDetails i, GP_COL_TIPO, "PP", DT_LEFT
                        .CellDetails i, GP_COL_NUMERO, rs2!idProduccionParte & vbNullString, DT_LEFT
                    End If
                    
                    If Not IsNull(rs2!NumeroSalidaMateriales) Then
                        .AddRow
                        i = .Rows
                        .CellDetails i, GP_COL_PARTIDA, rs1!partida, DT_RIGHT
                        .CellDetails i, GP_COL_NIVEL2, rs2!partida, DT_CENTER
                        .CellDetails i, GP_COL_NIVEL3, "", DT_LEFT
                        .CellDetails i, GP_COL_TIPO, "SM", DT_LEFT
                        .CellDetails i, GP_COL_NUMERO, rs2!NumeroSalidaMateriales & vbNullString, DT_LEFT
                    End If
                    
                    If Not IsNull(rs2!NumeroRecepcion2) Then
                        .AddRow
                        i = .Rows
                        .CellDetails i, GP_COL_PARTIDA, rs1!partida, DT_RIGHT
                        .CellDetails i, GP_COL_NIVEL2, rs2!partida, DT_CENTER
                        .CellDetails i, GP_COL_NIVEL3, "", DT_LEFT
                        .CellDetails i, GP_COL_TIPO, "RECEP", DT_LEFT
                        .CellDetails i, GP_COL_NUMERO, rs2!NumeroRecepcion2 & vbNullString, DT_LEFT
                    End If
                    
                    If Not IsNull(rs2!NumeroOtroIngresoAlmacen) Then
                        .AddRow
                        i = .Rows
                        .CellDetails i, GP_COL_PARTIDA, rs1!partida, DT_RIGHT
                        .CellDetails i, GP_COL_NIVEL2, rs2!partida, DT_CENTER
                        .CellDetails i, GP_COL_NIVEL3, "", DT_LEFT
                        .CellDetails i, GP_COL_TIPO, "OI", DT_LEFT
                        .CellDetails i, GP_COL_NUMERO, rs2!NumeroOtroIngresoAlmacen & vbNullString, DT_LEFT
                    End If
                    
                    '                    If Not IsNull(rs2!RemitoCliente) Then
                    '                        .AddRow
                    '                        i = .Rows
                    '                    .CellDetails i, GP_COL_PARTIDA, rs1!Partida, DT_RIGHT
                    '                    .CellDetails i, GP_COL_NIVEL2, rs2!Partida, DT_CENTER
                    '                    .CellDetails i, GP_COL_NIVEL3, "", DT_LEFT
                    '                        .CellDetails i, GP_COL_TIPO, "REM", DT_LEFT
                    '                        .CellDetails i, GP_COL_NUMERO, rs2!NumeroOtroIngresoAlmacen & vbNullString, DT_LEFT
                    '                    End If
                    
                    rs2.MoveNext
                Wend
            
            End If
            
            rs1.MoveNext
        Wend
        
        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        
        .AutoWidthColumn (GP_COL_CODART)
        .AutoWidthColumn (GP_COL_DESCART)
        .AutoWidthColumn (GP_COL_CANTIDAD)
        
        '.SetHeaders
        '.Draw
        
        '        .HeaderDragReOrderColumns = True
        '        .HideGroupingBox = True
        '        .ColumnIsGrouped(1) = True
        '        .ColumnIsGrouped(2) = True
        '        .ColumnIsGrouped(3) = True
        '        .AllowGrouping = False
        '        .AllowGrouping = True
        
        '        .Sort
        '.SortObject.ClearNongrouped
        
        '.RowGroupingState( = ecgExpanded
           
        ' You can specify specifically at which column the text will start
        ' like this:
        '   .RowTextStartColumn = .ColumnIndex("from")
        ' If you do this you need to track the ColumnOrderChanged event to
        ' ensure you are at the right column if the user moves this column
        ' to the end of the grid.  If you don't specify this setting, the
        ' grid will automatically start drawing rowtext at the position
        ' of the first column included in the select (bIncludeInSelect
        ' parameter of AddColumn)
        '-que es lo del bIncludeInSelect????
         
        .Redraw = True
        
        '        .AllowGrouping = False
        '        .AllowGrouping = True
        '        .HeaderDragReOrderColumns = True
        '        .HideGroupingBox = True
        '        .ColumnIsGrouped(1) = True
        '        .ColumnIsGrouped(2) = True
        '        .ColumnIsGrouped(3) = True
        '.Sort
    
        '        '///////////////////////////////////////////////////
        '        '///////////////////////////////////////////////////
        '        'prueba
        '        For i = 1 To .Rows
        '            'If .RowVisible(i) = False Then
        '            '    Stop
        '            'End If
        '
        '            If .RowIsGroup(i) = True Then
        '                .RowGroupingState(i) = ecgExpanded
        '
        '
        '                If .RowGroupingLevel(i) >= 2 And Grid.celltext(i, GP_COL_NIVEL2) = "" Then
        '                    .RowVisible(i) = False
        '                End If
        '
        '                If .RowGroupingLevel(i) >= 3 And Grid.celltext(i, GP_COL_NIVEL3) = "" Then
        '                    .RowVisible(i) = False
        '                End If
        '
        '
        '            End If
        '        Next
        '        '///////////////////////////////////////////////////
        '        '///////////////////////////////////////////////////
    
    End With
    
    Set rs1 = Nothing
    Set rs2 = Nothing
    Set oAp = Nothing
    
    Screen.MousePointer = vbNormal

End Sub

Function listaDISTINCT(p1, p2, p3, p4, p5) As String
    Dim s As String
    
    If InStr(1, s, p1) = 0 Then s = s & p1 & " "
    If InStr(1, s, p2) = 0 Then s = s & p2 & " "
    If InStr(1, s, p3) = 0 Then s = s & p3 & " "
    If InStr(1, s, p4) = 0 Then s = s & p4 & " "
    If InStr(1, s, p5) = 0 Then s = s & p5 & " "
    
    listaDISTINCT = s
End Function

Function SiNoEstaConcateno()

End Function

'/:~ GRID

