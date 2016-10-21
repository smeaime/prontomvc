VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmConsultaBOM 
   Caption         =   "Lista de Materiales (BOM)"
   ClientHeight    =   6720
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11535
   LinkTopic       =   "Form1"
   ScaleHeight     =   6720
   ScaleWidth      =   11535
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtText1 
      Height          =   285
      Left            =   10200
      TabIndex        =   12
      Text            =   "Text1"
      Top             =   570
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.TextBox txtBusca 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   8280
      TabIndex        =   8
      Top             =   570
      Width           =   1140
   End
   Begin VB.TextBox txtCodigoArticulo 
      Alignment       =   2  'Center
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   300
      Left            =   825
      TabIndex        =   7
      Top             =   570
      Width           =   1560
   End
   Begin RichTextLib.RichTextBox rchTexto 
      Height          =   420
      Left            =   6480
      TabIndex        =   6
      Top             =   5820
      Visible         =   0   'False
      Width           =   1185
      _ExtentX        =   2090
      _ExtentY        =   741
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmConsultaBOM.frx":0000
   End
   Begin VB.CommandButton cmd 
      Caption         =   "BOM detallado"
      Height          =   420
      Index           =   0
      Left            =   45
      TabIndex        =   4
      Top             =   5865
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Salir"
      Height          =   420
      Index           =   3
      Left            =   9960
      TabIndex        =   3
      Top             =   5865
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "BOM resumido"
      Height          =   420
      Index           =   1
      Left            =   1575
      TabIndex        =   0
      Top             =   5865
      Width           =   1470
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   1
      Top             =   6330
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   5
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   8149
            Key             =   "Mensaje"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   8149
            Key             =   "Estado"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   1
            Alignment       =   1
            AutoSize        =   2
            Enabled         =   0   'False
            Object.Width           =   900
            MinWidth        =   18
            TextSave        =   "CAPS"
            Key             =   "Caps"
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   2
            AutoSize        =   2
            Object.Width           =   820
            MinWidth        =   18
            TextSave        =   "NUM"
            Key             =   "Num"
         EndProperty
         BeginProperty Panel5 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            Alignment       =   1
            AutoSize        =   2
            Object.Width           =   1693
            MinWidth        =   18
            TextSave        =   "01/11/2009"
            Key             =   "Fecha"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   4470
      Left            =   0
      TabIndex        =   2
      Top             =   1320
      Width           =   11490
      _ExtentX        =   20267
      _ExtentY        =   7885
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaBOM.frx":0082
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   2400
      TabIndex        =   9
      Tag             =   "Articulos"
      Top             =   570
      Width           =   4920
      _ExtentX        =   8678
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
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
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   8880
      Top             =   5760
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
            Picture         =   "frmConsultaBOM.frx":009E
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaBOM.frx":01B0
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaBOM.frx":02C2
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaBOM.frx":03D4
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaBOM.frx":04E6
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaBOM.frx":05F8
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaBOM.frx":070A
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   14
      Top             =   0
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
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
   Begin VB.Label lblCntidad 
      Caption         =   "Cantidad"
      Height          =   255
      Left            =   9480
      TabIndex        =   13
      Top             =   630
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Label lblLabels 
      Caption         =   "Buscar :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   225
      Index           =   14
      Left            =   7440
      TabIndex        =   11
      Top             =   660
      Width           =   780
   End
   Begin VB.Label Label4 
      Caption         =   "Codigo :"
      Height          =   240
      Left            =   105
      TabIndex        =   10
      Top             =   645
      Width           =   645
   End
   Begin VB.Label Label1 
      BackColor       =   &H00C0C0FF&
      Caption         =   "Label1"
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
      Left            =   90
      TabIndex        =   5
      Top             =   1095
      Visible         =   0   'False
      Width           =   8520
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Marcar como procesado"
         Index           =   0
      End
   End
End
Attribute VB_Name = "frmConsultaBOM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mParametros As String
Private mvarConculta As String
Private mvarIdConculta As Integer, mvarCual As Integer, mIdParametro As Integer
Private mvarRecordsetFuente As ADOR.Recordset

Public Property Get Id() As Integer

   Id = mvarIdConculta

End Property

Public Property Let Id(ByVal vNewValue As Integer)

   Dim oAp As ComPronto.Aplicacion
   Dim oTab As ADOR.Recordset
   Dim mListaParametros
   
   mvarIdConculta = vNewValue
   mListaParametros = VBA.Split(Me.Parametros, "|")
   
   Select Case vNewValue
      Case 1
         mvarConculta = "ConsultaStockCompleto"
         Me.Caption = "Consulta de stock actual ( Completo )"
         cmd(2).Visible = False
      Case 2
         Me.Caption = "Consulta de obras, equipos y planos"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Visible = False
         Me.MousePointer = vbHourglass
         Set oAp = Aplicacion
         Set oTab = oAp.Obras.TraerFiltrado("_DetalladosPorEquiposPlanos")
         Lista.Sorted = False
         Set Lista.DataSource = oTab
         ReemplazarEtiquetasListas Lista
         Set oTab = Nothing
         Set oAp = Nothing
         mvarCual = 99
         Me.MousePointer = vbDefault
      Case 3
         Me.Caption = "Consulta de revisiones"
         cmd(0).Caption = "Acopios"
         cmd(1).Caption = "L.Materiales"
         cmd(2).Caption = "Todos"
      Case 4
         Me.Caption = "Desarrollo impuesto a las ganancias"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Visible = False
         Me.MousePointer = vbHourglass
         Set oAp = Aplicacion
         Set oTab = oAp.Ganancias.TraerFiltrado("_Desarrollo", Array(CLng(mListaParametros(0)), CDate(mListaParametros(1)), CDbl(mListaParametros(2))))
         Lista.Sorted = False
         Set Lista.DataSource = oTab
         ReemplazarEtiquetasListas Lista
         Set oTab = Nothing
         Set oAp = Nothing
         mvarCual = 99
         Toolbar1.Enabled = True
         Me.MousePointer = vbDefault
      Case 5
         Me.Caption = "Obras con detalle de polizas"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Visible = False
         Me.MousePointer = vbHourglass
         Set oAp = Aplicacion
         Set oTab = oAp.Obras.TraerFiltrado("_ConDetallePolizas")
         Lista.Sorted = False
         Set Lista.DataSource = oTab
         ReemplazarEtiquetasListas Lista
         Set oTab = Nothing
         Set oAp = Nothing
         mvarCual = 99
         Toolbar1.Enabled = True
         Me.MousePointer = vbDefault
      Case 6
         Me.Caption = "Items de ordenes de compra pendientes de remitir por cliente"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Visible = False
         Me.MousePointer = vbHourglass
         Set oAp = Aplicacion
         Set oTab = oAp.OrdenesCompra.TraerFiltrado("_ItemsPendientesDeRemitirPorIdCliente", Me.IdParametro)
         Lista.Sorted = False
         Set Lista.DataSource = oTab
         ReemplazarEtiquetasListas Lista
         Set oTab = Nothing
         Set oAp = Nothing
         mvarCual = 99
         Toolbar1.Enabled = True
         Me.MousePointer = vbDefault
      Case 7
         Me.Caption = "Items de ordenes de compra pendientes de facturar"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Visible = False
         Me.MousePointer = vbHourglass
         Set oAp = Aplicacion
         Set oTab = oAp.OrdenesCompra.TraerFiltrado("_ItemsPendientesDeFacturar")
         Lista.Sorted = False
         Set Lista.DataSource = oTab
         ReemplazarEtiquetasListas Lista
         Set oTab = Nothing
         Set oAp = Nothing
         mvarCual = 99
         Toolbar1.Enabled = True
         Me.MousePointer = vbDefault
      Case 8
         Me.Caption = "Items de remitos pendientes de facturar"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Visible = False
         Me.MousePointer = vbHourglass
         Set oAp = Aplicacion
         Set oTab = oAp.Remitos.TraerFiltrado("_ItemsPendientesDeFacturar")
         Lista.Sorted = False
         Set Lista.DataSource = oTab
         ReemplazarEtiquetasListas Lista
         Set oTab = Nothing
         Set oAp = Nothing
         mvarCual = 99
         Toolbar1.Enabled = True
         Me.MousePointer = vbDefault
      Case 9
         Me.Caption = "Costo promedio ponderado por articulo"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Visible = False
         cmd(3).Left = cmd(0).Left
         Me.MousePointer = vbHourglass
         Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("CostosPromedios", "_DetalladoPorIdArticulo", Me.IdParametro)
         Lista.Sorted = False
         Set Lista.DataSource = oTab
         ReemplazarEtiquetasListas Lista
         Set oTab = Nothing
         mvarCual = 99
         Toolbar1.Enabled = True
         Me.MousePointer = vbDefault
      Case 10
         Me.Caption = "Errores producidos en la importacion de datos desde PRESTO"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Visible = False
         Me.MousePointer = vbHourglass
         Lista.Sorted = False
         If Not Me.RecordsetFuente Is Nothing Then
            Set Lista.DataSource = Me.RecordsetFuente
            ReemplazarEtiquetasListas Lista
            mvarCual = 99
            Toolbar1.Enabled = True
         End If
         Me.MousePointer = vbDefault
      Case 11
         Me.Caption = "Recepciones pendientes de ingreso de comprobante"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Visible = False
         cmd(3).Left = cmd(0).Left
         Me.MousePointer = vbHourglass
         Set oTab = Aplicacion.Recepciones.TraerFiltrado("_PendientesDeComprobante", Me.IdParametro)
         Lista.Sorted = False
         Set Lista.DataSource = oTab
         ReemplazarEtiquetasListas Lista
         Set oTab = Nothing
         mvarCual = 99
         Me.MousePointer = vbDefault
      Case 12
         Me.Caption = "Errores en la importacion de conjuntos"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Visible = False
         cmd(3).Left = cmd(0).Left
         Lista.Visible = False
         Toolbar1.Visible = False
         With rchTexto
            .Left = Lista.Left
            .TOp = Lista.TOp
            .Width = Lista.Width
            .Height = Lista.Height
            .Visible = True
         End With
         mvarCual = 99
      Case 13
         Me.Caption = "Novedades producidas en la importacion de requerimientos"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Visible = False
         Me.MousePointer = vbHourglass
         Lista.Sorted = False
         If Not Me.RecordsetFuente Is Nothing Then
            Set Lista.DataSource = Me.RecordsetFuente
            ReemplazarEtiquetasListas Lista
            mvarCual = 99
            Toolbar1.Enabled = True
         End If
         Me.MousePointer = vbDefault
      Case 14
         Me.Caption = "Novedades producidas en la importacion de articulos"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Visible = False
         Me.MousePointer = vbHourglass
         Lista.Sorted = False
         If Not Me.RecordsetFuente Is Nothing Then
            Set Lista.DataSource = Me.RecordsetFuente
            ReemplazarEtiquetasListas Lista
            mvarCual = 99
            Toolbar1.Enabled = True
         End If
         Me.MousePointer = vbDefault
      Case 15
         Me.Caption = "Errores en la importacion de presupuestos de obra"
         cmd(0).Visible = False
         cmd(1).Visible = False
         cmd(2).Visible = False
         cmd(3).Left = cmd(0).Left
         Lista.Visible = False
         Toolbar1.Visible = False
         With rchTexto
            .Left = Lista.Left
            .TOp = Lista.TOp
            .Width = Lista.Width
            .Height = Lista.Height
            .Visible = True
         End With
         mvarCual = 99
   End Select
   
End Property

Private Sub cmd_Click(Index As Integer)
On Error Resume Next
   Dim oAp As ComPronto.Aplicacion
   Dim oTab As ADOR.Recordset
   
   Toolbar1.Enabled = True
   
   Select Case Index
      
      Case 0
         
         Me.MousePointer = vbHourglass
         Set oAp = Aplicacion
        Set oTab = oAp.TablasGenerales.TraerFiltrado("ProduccionFichas", "_BOMArbolPorArticulo", dcfields(0).BoundText)
         Set Lista.DataSource = oTab
         ReemplazarEtiquetasListas Lista
'         oTab.Close
         Set oTab = Nothing
         Set oAp = Nothing
         mvarCual = 0
         Me.MousePointer = vbDefault
      
      Case 1
         
         Me.MousePointer = vbHourglass
         Set oAp = Aplicacion
         Set oTab = oAp.TablasGenerales.TraerFiltrado("ProduccionFichas", "_BOMSumarizadoPorArticulo", dcfields(0).BoundText)
         Set Lista.DataSource = oTab
         ReemplazarEtiquetasListas Lista
'         oTab.Close
         Set oTab = Nothing
         Set oAp = Nothing
         mvarCual = 1
         Me.MousePointer = vbDefault
      
      
      Case 3
         
         Me.Hide
         Unload Me
      
   End Select
   
End Sub



Private Sub Form_Activate()

   ReemplazarEtiquetas Me

End Sub

Private Sub Form_Load()

   If Me.Id <> 11 Then
      Toolbar1.Enabled = False
   End If
   Me.Parametros = ""
   
   CambiarLenguaje Me, "esp", glbIdiomaActual


   Set dcfields(0).RowSource = Aplicacion.Articulos.TraerLista


End Sub

Private Sub Form_Paint()

   'Degradado Me
   
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   Set mvarRecordsetFuente = Nothing
   
End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count > 0 Then
         If Me.Id = 11 Then
            PopupMenu MnuDet, , , , MnuDetA(0)
         End If
      End If
   End If

End Sub

Private Sub Lista_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single, State As Integer)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long
   Dim iColumnas As Long
   Dim oL As ListItem

   If mvarConculta = 1 And mvarCual = 0 Then
      If State = vbEnter Then
         If Data.GetFormat(ccCFText) Then '
            s = Data.GetData(ccCFText)
            Filas = Split(s, vbCrLf)
            Columnas = Split(Filas(LBound(Filas)), vbTab)
            Effect = vbDropEffectCopy
         End If
      End If
   End If
   
End Sub

Private Sub Lista_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         If Me.Id = 11 Then
            MarcarRecepcionComoProcesada
         End If
   End Select

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Key
      
      Case "Imprimir"
         
         If Me.Id = 9 Then
            ImprimirConExcel Lista, Me.Caption & " |" & Label1.Caption
         Else
            ImprimirConExcel Lista, Me.Caption
         End If
      
      Case "Buscar"
         
         FiltradoLista Lista
         StatusBar1.Panels(2).Text = " " & Lista.ListItems.Count & " elementos en la lista"

      Case "Excel"
         
         If Me.Id = 9 Then
            ExportarAExcel Lista, Me.Caption & " |" & Label1.Caption
         Else
            ExportarAExcel Lista, Me.Caption
         End If
         
   End Select

End Sub

Public Property Get Parametros() As String

   Parametros = mParametros

End Property

Public Property Let Parametros(ByVal vNewValue As String)

   mParametros = vNewValue

End Property

Public Property Get IdParametro() As Long

   IdParametro = mIdParametro

End Property

Public Property Let IdParametro(ByVal vNewValue As Long)

   mIdParametro = vNewValue

End Property

Public Property Get RecordsetFuente() As ADOR.Recordset

   Set RecordsetFuente = mvarRecordsetFuente
   
End Property

Public Property Set RecordsetFuente(ByVal vNewValue As ADOR.Recordset)

   Set mvarRecordsetFuente = vNewValue
   
End Property

Public Sub MarcarRecepcionComoProcesada()

   Dim Filas, Columnas
   Dim iFilas As Integer
   
   Filas = VBA.Split(Lista.GetString, vbCrLf)
   For iFilas = LBound(Filas) + 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(iFilas), vbTab)
      If IsNumeric(Columnas(12)) Then
         Aplicacion.Tarea "Recepciones_MarcarComoProcesadoCP", Array(Columnas(12))
      End If
   Next

End Sub


Private Sub txtBusca_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      If KeyAscii = 13 Then
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set dcfields(0).RowSource = Aplicacion.Articulos.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set dcfields(0).RowSource = Aplicacion.Articulos.TraerLista
         End If
      End If
      dcfields(0).SetFocus
      SendKeys "%{DOWN}"
   End If

End Sub


'//////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////
'Control fastidioso del combo de articulo/busqueda/codigo
'//////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////



Private Sub dcfields_Change(Index As Integer)

   If Not IsNumeric(dcfields(Index).BoundText) Then Exit Sub
   
   Dim oRs As ADOR.Recordset
   
   Select Case Index
      Case 0
        Dim oArt As ComPronto.Articulo
        Set oArt = Aplicacion.Articulos.Item(dcfields(0).BoundText)
        Set oRs = oArt.Registro
        txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)

      
   End Select
   Set oRs = Nothing

End Sub




Private Sub dcfields_GotFocus(Index As Integer)
   
   If Index <> 1 Then
      If dcfields(Index).Enabled Then
         SendKeys "%{DOWN}"
      Else
         SendKeys "{TAB}"
      End If
   End If

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCodigoArticulo_GotFocus()

   With txtCodigoArticulo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoArticulo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoArticulo_Validate(Cancel As Boolean)

   If Len(txtCodigoArticulo.Text) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo.Text)
      If oRs.RecordCount > 0 Then
         With origen.Registro
            .Fields("IdArticuloAsociado").Value = oRs.Fields(0).Value
            If Not IsNull(oRs.Fields("IdUnidad").Value) Then
               .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
            Else
               '.Fields("IdUnidad").Value = mvarIdUnidadCU
            End If
         End With
         'MostrarStockActual
      Else
         MsgBox "Codigo de material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo.Text = ""
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub


