VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#3.0#0"; "Controles1013.ocx"
Begin VB.Form frmConsultaSimple 
   Caption         =   "Consulta"
   ClientHeight    =   5790
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   14385
   LinkTopic       =   "Form1"
   ScaleHeight     =   5790
   ScaleWidth      =   14385
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   2160
      TabIndex        =   2
      Text            =   "Text1"
      Top             =   0
      Visible         =   0   'False
      Width           =   2655
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "Salir"
      Height          =   420
      Index           =   3
      Left            =   12840
      TabIndex        =   0
      Top             =   5280
      Width           =   1470
   End
   Begin Controles1013.DbListView Lista 
      Height          =   4695
      Left            =   0
      TabIndex        =   1
      Top             =   480
      Width           =   14370
      _ExtentX        =   25347
      _ExtentY        =   8281
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaSimple.frx":0000
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   840
      Top             =   5160
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
            Picture         =   "frmConsultaSimple.frx":001C
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimple.frx":012E
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimple.frx":0240
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimple.frx":0352
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimple.frx":0464
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimple.frx":0576
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimple.frx":0688
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
      Width           =   14385
      _ExtentX        =   25374
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
End
Attribute VB_Name = "frmConsultaSimple"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mParametros As String
Private mvarConculta As String
Private mvarIdConculta As Recordset, mvarCual As Integer, mIdParametro As Integer
Private mvarRecordsetFuente As ador.Recordset

Public oL As ListItem

Private originalrs As Recordset

Public Property Get Id() As Recordset

   Set Id = mvarIdConculta

End Property

Public Property Let Id(ByRef oRs As Recordset)

   Dim oAp As ComPronto.Aplicacion
   Dim oTab As ador.Recordset
   Dim mListaParametros
   
   'mvarIdConculta = vNewValue
   mListaParametros = VBA.Split(Me.Parametros, "|")
   
   Select Case vNewValue
      Case 1
         mvarConculta = "ConsultaStockCompleto"
         Me.Caption = "Consulta de stock actual ( Completo )"
         cmd(2).Visible = False
         With Frame1
            .Caption = "Depositos : "
            .Visible = True
         End With
         With Option1
            .Caption = "Todos"
            .Value = True
         End With
         Option2.Caption = "x Deposito"
         'Set DataCombo1(0).RowSource = Aplicacion.Depositos.TraerLista
   End Select
   
   
   Set Lista.DataSource = oRs
   Set originalrs = oRs
End Property


Private Sub DataCombo1_Click(Index As Integer, Area As Integer)

End Sub

Public Sub Lista_DblClick()
On Error Resume Next
            
            Set oL = Lista.SelectedItem
                 
'                 IdProduccionOrdenElegida = Lista.SelectedItem.Tag
'        IdProcesoElegido = Lista.SelectedItem.SubItems(6)
'        IdArticuloElegido = Lista.SelectedItem.SubItems(5)
        
         
    'originalrs.Find("
         DoEvents
         Me.Hide

End Sub


Private Sub cmd_Click(Index As Integer)

   Dim oAp As ComPronto.Aplicacion
   Dim oTab As ador.Recordset
   
'   Toolbar1.Enabled = True
   
         
         Me.MousePointer = vbHourglass
         Set oAp = Aplicacion
'         Set Lista.DataSource = oTab
         ReemplazarEtiquetasListas Lista
'         oTab.Close
         Set oTab = Nothing
         Set oAp = Nothing
         mvarCual = 0
         Me.MousePointer = vbDefault
      
   Me.Hide
End Sub

Private Sub Form_Activate()

   ReemplazarEtiquetas Me

End Sub

Private Sub Form_Load()

   Me.Parametros = ""
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

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

Private Sub Lista_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then Lista_DblClick
    
End Sub

Private Sub Lista_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

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


End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Key
      
      Case "Imprimir"
         
      Case "Buscar"
         
         FiltradoLista Lista
         'StatusBar1.Panels(2).Text = " " & Lista.ListItems.Count & " elementos en la lista"

      Case "Excel"
         
         
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

Public Property Get RecordsetFuente() As ador.Recordset

   Set RecordsetFuente = mvarRecordsetFuente
   
End Property

Public Property Set RecordsetFuente(ByVal vNewValue As ador.Recordset)

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


