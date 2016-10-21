VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#3.0#0"; "Controles1013.ocx"
Begin VB.Form frmConsultaCostos 
   Caption         =   "Costos"
   ClientHeight    =   6045
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   11715
   LinkTopic       =   "Form1"
   ScaleHeight     =   6045
   ScaleWidth      =   11715
   StartUpPosition =   3  'Windows Default
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProduccionOrden"
      Height          =   315
      Index           =   11
      Left            =   1800
      TabIndex        =   15
      Tag             =   "ProduccionOrdenes"
      Top             =   600
      Width           =   2370
      _ExtentX        =   4180
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProduccionOrden"
      Text            =   ""
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Detallado (RM)"
      Height          =   405
      Index           =   0
      Left            =   45
      TabIndex        =   9
      Top             =   5085
      Visible         =   0   'False
      Width           =   1305
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Resumido (RM)"
      Height          =   405
      Index           =   5
      Left            =   1395
      TabIndex        =   8
      Top             =   5085
      Visible         =   0   'False
      Width           =   1305
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Salir"
      Height          =   435
      Index           =   1
      Left            =   9720
      TabIndex        =   7
      Top             =   5160
      Width           =   1815
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Resumido (LA)"
      Height          =   405
      Index           =   3
      Left            =   1395
      TabIndex        =   6
      Top             =   5535
      Visible         =   0   'False
      Width           =   1305
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Detallado (LA)"
      Height          =   405
      Index           =   2
      Left            =   45
      TabIndex        =   5
      Top             =   5535
      Visible         =   0   'False
      Width           =   1305
   End
   Begin VB.Frame Frame2 
      Caption         =   "Tipo de seleccion : "
      Height          =   1185
      Left            =   2790
      TabIndex        =   0
      Top             =   5085
      Visible         =   0   'False
      Width           =   1860
      Begin VB.OptionButton Option1 
         Caption         =   "Pendientes"
         Height          =   195
         Left            =   360
         TabIndex        =   3
         Top             =   315
         Width           =   1140
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Todos"
         Height          =   195
         Left            =   360
         TabIndex        =   2
         Top             =   630
         Width           =   780
      End
      Begin VB.OptionButton Option3 
         Caption         =   "A la firma"
         Height          =   195
         Left            =   360
         TabIndex        =   1
         Top             =   945
         Width           =   1095
      End
   End
   Begin RichTextLib.RichTextBox rchObservacionesCumplido 
      Height          =   240
      Left            =   4635
      TabIndex        =   4
      Top             =   5130
      Visible         =   0   'False
      Width           =   150
      _ExtentX        =   265
      _ExtentY        =   423
      _Version        =   393217
      TextRTF         =   $"frmConsultaCostos.frx":0000
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   10
      Top             =   5655
      Width           =   11715
      _ExtentX        =   20664
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
            TextSave        =   "06/06/2011"
            Key             =   "Fecha"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3975
      Left            =   120
      TabIndex        =   11
      Top             =   1080
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   7011
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaCostos.frx":0082
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
            Picture         =   "frmConsultaCostos.frx":009E
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaCostos.frx":01B0
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaCostos.frx":02C2
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaCostos.frx":03D4
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaCostos.frx":04E6
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaCostos.frx":05F8
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaCostos.frx":070A
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   12
      Top             =   0
      Width           =   11715
      _ExtentX        =   20664
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
            Picture         =   "frmConsultaCostos.frx":0B5C
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaCostos.frx":0C6E
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaCostos.frx":10C0
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaCostos.frx":1512
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1170
      Left            =   2160
      TabIndex        =   13
      Top             =   5160
      Visible         =   0   'False
      Width           =   5550
      _ExtentX        =   9790
      _ExtentY        =   2064
      _Version        =   393217
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmConsultaCostos.frx":1964
   End
   Begin VB.Label lblOrdenDe 
      Caption         =   "Orden de Producción:"
      Height          =   225
      Index           =   1
      Left            =   120
      TabIndex        =   16
      Top             =   720
      Width           =   1680
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   5
      Left            =   4860
      TabIndex        =   14
      Top             =   5085
      Visible         =   0   'False
      Width           =   1185
   End
End
Attribute VB_Name = "frmConsultaCostos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mvarIdArticulo As Long

Public Property Let Articulo(ByVal vNewValue As Long)

   
End Property

Private Sub cmd_Click(Index As Integer)

   StatusBar1.Enabled = True
   
   Select Case Index
      
      Case 0
      
      
         BuscarPartidas
         
      Case 1
         
         Me.Hide
   
   End Select
   
End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
  
   If IsNumeric(dcfields(Index).BoundText) Then
      If Index = 11 Then
            
        Set oAp = Aplicacion
            
        Set Lista.DataSource = oAp.ProduccionOrdenes.TraerFiltrado("_CostosPorOP", dcfields(11).BoundText)
        
        Set oAp = Nothing
      
      End If
   End If

End Sub

Private Sub Form_Load()

   StatusBar1.Enabled = False
   
   CambiarLenguaje Me, "esp", glbIdiomaActual


   Set dcfields(11).RowSource = Aplicacion.ProduccionOrdenes.TraerFiltrado("_Producidos", 0)


End Sub

Private Sub Form_Paint()
    
   'Degradado Me

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long
   Dim iColumnas As Long
   Dim oL As ListItem

   If State = vbEnter Then
      If Data.GetFormat(ccCFText) Then ' si el dato es texto
         s = Data.GetData(ccCFText) ' tomo el dato
         Filas = Split(s, vbCrLf) ' armo un vector por filas
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

Public Sub BuscarPartidas()

   Set Lista.DataSource = Aplicacion.Articulos.TraerFiltrado("_StockPorPartida", mvarIdArticulo)
   ReemplazarEtiquetasListas Lista

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Key
      
      Case "Imprimir"
         
         ImprimirConExcel Lista, Me.Caption
      
      Case "Buscar"
         
         FiltradoLista Lista
         StatusBar1.Panels(2).Text = " " & Lista.ListItems.Count & " elementos en la lista"

      Case "Excel"
         
         ExportarAExcel Lista, Me.Caption
         
   End Select

End Sub

Private Sub txtBusca_GotFocus()

   With txtBusca
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBusca_KeyPress(KeyAscii As Integer)
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

   
End Sub


