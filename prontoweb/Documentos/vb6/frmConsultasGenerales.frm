VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmConsultasGenerales 
   ClientHeight    =   7230
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   Icon            =   "frmConsultasGenerales.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7230
   ScaleWidth      =   11880
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame3 
      Height          =   465
      Left            =   495
      TabIndex        =   23
      Top             =   7290
      Visible         =   0   'False
      Width           =   5010
      Begin VB.OptionButton Option5 
         Caption         =   "Todas las obras"
         Height          =   195
         Left            =   45
         TabIndex        =   25
         Top             =   135
         Width           =   1500
      End
      Begin VB.OptionButton Option6 
         Caption         =   "Elegir una obra"
         Height          =   240
         Left            =   1620
         TabIndex        =   24
         Top             =   135
         Width           =   1545
      End
      Begin MSDataListLib.DataCombo dcfields 
         Height          =   315
         Index           =   1
         Left            =   3690
         TabIndex        =   26
         Tag             =   "Obras"
         Top             =   90
         Width           =   1230
         _ExtentX        =   2170
         _ExtentY        =   556
         _Version        =   393216
         Enabled         =   0   'False
         ListField       =   "Titulo"
         BoundColumn     =   "IdObra"
         Text            =   ""
      End
      Begin VB.Label lblObra 
         Caption         =   "Obra :"
         Height          =   255
         Left            =   3150
         TabIndex        =   27
         Top             =   135
         Width           =   555
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   405
      Index           =   4
      Left            =   6975
      TabIndex        =   17
      Top             =   6390
      Width           =   1485
   End
   Begin VB.TextBox txtDatos 
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
      Index           =   2
      Left            =   5535
      Locked          =   -1  'True
      TabIndex        =   11
      Top             =   495
      Visible         =   0   'False
      Width           =   780
   End
   Begin VB.TextBox txtDatos 
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
      Index           =   1
      Left            =   4680
      Locked          =   -1  'True
      TabIndex        =   10
      Top             =   495
      Visible         =   0   'False
      Width           =   780
   End
   Begin VB.TextBox txtDatos 
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
      Index           =   0
      Left            =   3825
      Locked          =   -1  'True
      TabIndex        =   9
      Top             =   495
      Visible         =   0   'False
      Width           =   780
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Items &vencidos"
      Height          =   405
      Index           =   2
      Left            =   3825
      TabIndex        =   8
      Top             =   6390
      Visible         =   0   'False
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Ejecutar consulta"
      Height          =   405
      Index           =   3
      Left            =   5400
      TabIndex        =   4
      Top             =   6390
      Visible         =   0   'False
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Items del pedido"
      Height          =   405
      Index           =   0
      Left            =   630
      TabIndex        =   2
      Top             =   6390
      Visible         =   0   'False
      Width           =   1485
   End
   Begin VB.TextBox txtNumeroPedido 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   2385
      Locked          =   -1  'True
      TabIndex        =   1
      Top             =   495
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Todos los pedidos"
      Height          =   405
      Index           =   1
      Left            =   2220
      TabIndex        =   0
      Top             =   6390
      Visible         =   0   'False
      Width           =   1485
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   5
      Top             =   6840
      Width           =   11880
      _ExtentX        =   20955
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   4
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   16960
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
            TextSave        =   "01/09/2008"
            Key             =   "Fecha"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   9945
      Top             =   6300
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
            Picture         =   "frmConsultasGenerales.frx":076A
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultasGenerales.frx":087C
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultasGenerales.frx":098E
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultasGenerales.frx":0AA0
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultasGenerales.frx":0BB2
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultasGenerales.frx":0CC4
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultasGenerales.frx":0DD6
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   5460
      Left            =   0
      TabIndex        =   7
      Top             =   855
      Width           =   11850
      _ExtentX        =   20902
      _ExtentY        =   9631
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultasGenerales.frx":1228
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   11880
      _ExtentX        =   20955
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
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   7965
      TabIndex        =   15
      Tag             =   "LMateriales"
      Top             =   495
      Visible         =   0   'False
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdLMateriales"
      Text            =   ""
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin RichTextLib.RichTextBox rchObservacionesCumplido 
      Height          =   285
      Left            =   8955
      TabIndex        =   18
      Top             =   6390
      Visible         =   0   'False
      Width           =   150
      _ExtentX        =   265
      _ExtentY        =   503
      _Version        =   393217
      TextRTF         =   $"frmConsultasGenerales.frx":1244
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   285
      Index           =   0
      Left            =   1755
      TabIndex        =   19
      Top             =   6930
      Visible         =   0   'False
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   503
      _Version        =   393216
      Format          =   64094209
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   285
      Index           =   1
      Left            =   4500
      TabIndex        =   20
      Top             =   6930
      Visible         =   0   'False
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   503
      _Version        =   393216
      Format          =   64094209
      CurrentDate     =   36377
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha inicial :"
      Height          =   240
      Index           =   0
      Left            =   495
      TabIndex        =   22
      Top             =   6930
      Visible         =   0   'False
      Width           =   1200
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha final :"
      Height          =   240
      Index           =   1
      Left            =   3150
      TabIndex        =   21
      Top             =   6930
      Visible         =   0   'False
      Width           =   1290
   End
   Begin VB.Label lblLM 
      Caption         =   "L.Materiales : "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   7425
      TabIndex        =   16
      Top             =   495
      Visible         =   0   'False
      Width           =   465
   End
   Begin VB.Label lblDatos 
      Caption         =   "Cont.:"
      Height          =   315
      Index           =   2
      Left            =   7020
      TabIndex        =   14
      Top             =   495
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Label lblDatos 
      Caption         =   "Email :"
      Height          =   315
      Index           =   1
      Left            =   6705
      TabIndex        =   13
      Top             =   495
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Label lblDatos 
      Caption         =   "Telef.:"
      Height          =   315
      Index           =   0
      Left            =   6390
      TabIndex        =   12
      Top             =   495
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Label Label1 
      Caption         =   "Numero de pedido :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   90
      TabIndex        =   3
      Top             =   540
      Visible         =   0   'False
      Width           =   2175
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Dar por cumplido"
         Index           =   0
      End
   End
End
Attribute VB_Name = "frmConsultasGenerales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mvarIdPedido As Long
Private mvarId As Integer

Public Property Let Pedido(ByVal vnewvalue As Long)

   mvarIdPedido = vnewvalue
   
   txtNumeroPedido.Text = Aplicacion.Pedidos.Item(mvarIdPedido).Registro("NumeroPedido").Value
   
End Property

Public Property Let Id(ByVal vnewvalue As Integer)

   mvarId = vnewvalue
   
End Property

Private Sub cmd_Click(Index As Integer)

   Dim oRs As ADOR.Recordset
   Dim mIdObra As Long
   
   Toolbar1.Enabled = True
   
   mIdObra = -1
   If Option6.Value Then
      If Not IsNumeric(dcfields(1).BoundText) Then
         MsgBox "Debe ingresar la obra", vbExclamation
         Exit Sub
      End If
      mIdObra = dcfields(1).BoundText
   End If
   
   Me.MousePointer = vbHourglass
   
   Select Case Index
      Case 0
         Select Case mvarId
            Case 5
               Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("SalidasMateriales", "_Recepciones_y_Envios", _
                           Array(DTFields(0).Value, DTFields(1).Value, mIdObra))
            Case Else
               Label1.Visible = True
               txtNumeroPedido.Visible = True
               Set oRs = Aplicacion.Pedidos.TraerFiltrado("_DetPendientes", mvarIdPedido)
         End Select
      Case 1
         Select Case mvarId
            Case 5
               Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Recepciones", "_Todos", _
                           Array(-1, DTFields(0).Value, DTFields(1).Value, mIdObra))
            Case Else
               Set oRs = Aplicacion.Pedidos.TraerFiltrado("_DetPendientesTodos")
         End Select
      Case 2
         Select Case mvarId
            Case 5
               Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("SalidasMateriales", "_Todos", _
                           Array(DTFields(0).Value, DTFields(1).Value, mIdObra))
            Case Else
               Set oRs = Aplicacion.Pedidos.TraerFiltrado("_DetPendientesTodosVencidos")
         End Select
      Case 3
         If Not IsNumeric(dcfields(0).BoundText) Then
            Me.MousePointer = vbDefault
            MsgBox "Debe definir primero una lista de materiales", vbExclamation
            Exit Sub
         End If
         Set oRs = CalcularDisponibilidades(dcfields(0).BoundText)
         Lista.Sorted = False
      Case 4
         If mvarId = 3 Then
            Unload Me
         Else
            Me.Hide
         End If
         Exit Sub
   End Select
   
   Set Lista.DataSource = oRs
   ReemplazarEtiquetasListas Lista
   Lista.Refresh
   Set oRs = Nothing
         
   StatusBar1.Panels(1).Text = " " & Lista.ListItems.Count & " elementos en la lista"
   
   Me.MousePointer = vbDefault

End Sub

Private Sub Form_Load()

   Dim oControl As Control
   Dim oRs As ADOR.Recordset
   Dim mvarFechaDesde As Date, mvarFechaHasta As Date
   
   mvarFechaDesde = DateSerial(Year(Date), Month(Date) - 1, 1)
   mvarFechaHasta = DateAdd("m", 1, mvarFechaDesde)
   mvarFechaHasta = DateAdd("d", -1, mvarFechaHasta)
   
   Toolbar1.Enabled = False
   
   Select Case mvarId
      Case 1
         With Me
            .Caption = "Consulta de pedidos pendientes de recibir detallado (Todos los pedidos)"
'            .cmd(0).Visible = True
            .cmd(1).Visible = True
'            .cmd(0).Left = 100
            .cmd(1).Left = 1800
            .cmd(4).Left = 3500
         End With
      Case 2
         With Me
            .Caption = "Notas de pedido pendientes de recibir"
            .cmd(2).Visible = True
            .cmd(2).Left = 100
            .cmd(4).Left = 1800
         End With
         For Each oControl In Me.Controls
            With oControl
               If .Name = "txtDatos" Then
                  .Left = (.Index * 3800 + 1000)
                  .Top = 500
                  .Width = 2800
                  .Height = 300
                  .Visible = True
               End If
               If .Name = "lblDatos" Then
                  .Left = (.Index * 3800 + 200)
                  .Top = 500
                  .Width = 700
                  .Height = 300
                  .Visible = True
               End If
            End With
         Next
      Case 3
         With Me
            .Caption = "Disponibilidad de materiales (segun lista de materiales)"
            .cmd(3).Visible = True
            .cmd(3).Left = 100
            .cmd(4).Left = 1800
            .dcfields(0).Visible = True
            .dcfields(0).Left = 2000
            .dcfields(0).Width = 7000
            .lblLM.Visible = True
            .lblLM.Left = 100
            .lblLM.Width = 1800
         End With
         Set dcfields(0).RowSource = Aplicacion.CargarLista(dcfields(0).Tag)
      Case 5
         With Me
            .Caption = "Consulta de transporte de mercaderia"
            .cmd(0).Visible = True
            .cmd(0).Left = 100
            .cmd(0).Caption = "Todos"
            .cmd(1).Visible = True
            .cmd(1).Left = 1800
            .cmd(1).Caption = "Remitos recibidos"
            .cmd(2).Visible = True
            .cmd(2).Left = 3500
            .cmd(2).Caption = "Remitos enviados"
            .cmd(4).Left = 5200
         End With
         With Frame3
            .Left = cmd(4).Left + cmd(4).Width + 100
            .Top = cmd(4).Top
            .Visible = True
         End With
         Option5.Value = True
         With lblLabels(0)
            .Left = 0
            .Top = Toolbar1.Height + 10
            .Visible = True
         End With
         With DTFields(0)
            .Left = lblLabels(0).Left + lblLabels(0).Width + 100
            .Top = lblLabels(0).Top
            .Value = mvarFechaDesde
            .Visible = True
         End With
         With lblLabels(1)
            .Left = DTFields(0).Left + DTFields(0).Width + 100
            .Top = lblLabels(0).Top
            .Visible = True
         End With
         With DTFields(1)
            .Left = lblLabels(1).Left + lblLabels(1).Width + 100
            .Top = lblLabels(0).Top
            .Value = mvarFechaHasta
            .Visible = True
         End With
   End Select

   Set oRs = Nothing
   
   Set dcfields(1).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasParaCombo")
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()
    
   Degradado Me

End Sub

Private Sub Lista_Click()

   If Not Lista.SelectedItem Is Nothing Then
      txtDatos(0).Text = Lista.SelectedItem.SubItems(4)
      txtDatos(1).Text = Lista.SelectedItem.SubItems(5)
      txtDatos(2).Text = Lista.SelectedItem.SubItems(6)
   End If
   
End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If (mvarId = 1 Or mvarId = 2) And Lista.ListItems.Count > 0 Then
         PopupMenu MnuDet, , , , MnuDetA(0)
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

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         If Not Lista.SelectedItem Is Nothing Then
            DarPorCumplido
         End If
   End Select

End Sub

Private Sub Option5_Click()

   If Option5.Value Then
      If mvarId = 5 Then dcfields(1).Enabled = False
   End If

End Sub

Private Sub Option6_Click()

   If Option6.Value Then
      If mvarId = 5 Then dcfields(1).Enabled = True
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

Public Function CalcularDisponibilidades(ByVal IdLMat As Long) As ADOR.Recordset

   Dim oAp As ComPronto.Aplicacion
   
   Set oAp = Aplicacion
   
   oAp.Tarea "LMateriales_CalcularDisponibilidadesPorLM", IdLMat
   Set CalcularDisponibilidades = oAp.TablasGenerales.TraerFiltrado("LMateriales", "_DisponibilidadesPorLM", IdLMat)
   
   Set oAp = Nothing
   
   Exit Function
   
'   Dim oAp As ComPronto.Aplicacion
'   Dim oRs, oRs1, oRsRes, oRsPed, oRsRec, oRsCal, oRsVal, oRsSal As ADOR.Recordset
'   Dim oFld As ADOR.Field
'   Dim i As Integer
'   Dim Reg As Long
'   Dim v_X, v_T As String
'
'   v_X = "0111111111111111111133"
'   v_T = "0111511114242133333300"
'
'   Set oAp = Aplicacion
'   Set oRs1 = oAp.LMateriales.TraerFiltrado("_Disponibilidades", IdLMat)
'
'   'Agregar campos adicionales al recordset
'   Set oRs = CreateObject("Ador.Recordset")
'
'   With oRs
'
'      For Each oFld In oRs1.Fields
'         .Fields.Append oFld.Name, oFld.Type, oFld.DefinedSize, oFld.Attributes
'         .Fields.Item(oFld.Name).Precision = oFld.Precision
'         .Fields.Item(oFld.Name).NumericScale = oFld.NumericScale
'      Next
'
'      .Fields.Append "Stock res.", adNumeric
'      .Fields.Item("Stock res.").Precision = 18
'      .Fields.Item("Stock res.").NumericScale = 2
'
'      .Fields.Append "Nro.pedido", adInteger
'
'      .Fields.Append "Cant.pedida", adNumeric
'      .Fields.Item("Cant.pedida").Precision = 18
'      .Fields.Item("Cant.pedida").NumericScale = 2
'
'      .Fields.Append "Unidad", adVarChar, 20
'
'      .Fields.Append "Fec.entrega", adDate
'
'      .Fields.Append "Cant.recibida", adNumeric
'      .Fields.Item("Cant.recibida").Precision = 18
'      .Fields.Item("Cant.recibida").NumericScale = 2
'
'      .Fields.Append "Fec.recepcion", adDate
'
'      .Fields.Append "Stock en calidad", adNumeric
'      .Fields.Item("Stock en calidad").Precision = 18
'      .Fields.Item("Stock en calidad").NumericScale = 2
'
'      .Fields.Append "Vales pedidos", adNumeric
'      .Fields.Item("Vales pedidos").Precision = 18
'      .Fields.Item("Vales pedidos").NumericScale = 2
'
'      .Fields.Append "Vales entregados", adNumeric
'      .Fields.Item("Vales entregados").Precision = 18
'      .Fields.Item("Vales entregados").NumericScale = 2
'
'      .Fields.Append "Vector_T", adVarChar, 30
'      .Fields.Append "Vector_X", adVarChar, 30
'
'      .Open
'
'   End With
'
'   With oRs1
'
'      If .RecordCount > 0 Then
'
'         .MoveFirst
'
'         Do While Not .EOF
'
'            'Cargo los datos iniciales del item de lista de materiales
'            oRs.AddNew
'            For i = 0 To .Fields.Count - 1
'               With .Fields(i)
'                  oRs.Fields(i).Value = .Value
'               End With
'            Next
'            If oRs.RecordCount = 1 Then
'               oRs.Fields("Vector_T").Value = v_T
'               oRs.Fields("Vector_X").Value = v_X
'            End If
'
'            oRs.Update
'
'            'Agrego las reservas de stock que tiene el item
'            Set oRsRes = oAp.LMateriales.TraerFiltrado("_DisponibilidadesRes", oRs1.Fields(0).Value)
'            If oRsRes.RecordCount > 0 Then
'               oRs.Fields(oRsRes.Fields(0).Name).Value = oRsRes.Fields(0).Value
'               oRs.Update
'            End If
'            oRsRes.Close
'
'            'Agrego los pedidos realizados
'            Set oRsPed = oAp.LMateriales.TraerFiltrado("_DisponibilidadesPed", oRs1.Fields(0).Value)
'            If oRsPed.RecordCount > 0 Then
'               oRsPed.MoveFirst
'               Reg = oRs.AbsolutePosition
'               For i = 1 To 4
'                  oRs.Fields(oRsPed.Fields(i).Name).Value = oRsPed.Fields(i).Value
'               Next
'               oRsPed.MoveNext
'               Do While Not oRsPed.EOF
'                  oRs.AddNew
'                  oRs.Fields(0).Value = .Fields(0).Value
'                  For i = 1 To 4
'                     oRs.Fields(oRsPed.Fields(i).Name).Value = oRsPed.Fields(i).Value
'                  Next
'                  oRsPed.MoveNext
'               Loop
'               oRs.Update
'               oRs.AbsolutePosition = Reg
'            End If
'            oRsPed.Close
'
'            'Agrego los recepciones
'            Set oRsRec = oAp.LMateriales.TraerFiltrado("_DisponibilidadesRec", oRs1.Fields(0).Value)
'            If oRsRec.RecordCount > 0 Then
'               oRsRec.MoveFirst
'               Reg = oRs.AbsolutePosition
'               For i = 0 To 1
'                  oRs.Fields(oRsRec.Fields(i).Name).Value = oRsRec.Fields(i).Value
'               Next
'               oRsRec.MoveNext
'               Do While Not oRsRec.EOF
'                  oRs.AddNew
'                  oRs.Fields(0).Value = .Fields(0).Value
'                  For i = 0 To 1
'                     oRs.Fields(oRsRec.Fields(i).Name).Value = oRsRec.Fields(i).Value
'                  Next
'                  oRsRec.MoveNext
'               Loop
'               oRs.Update
'               oRs.AbsolutePosition = Reg
'            End If
'            oRsRec.Close
'
'            'Agrego el stock en control de calidad
'            Set oRsCal = oAp.LMateriales.TraerFiltrado("_DisponibilidadesCal", oRs1.Fields(0).Value)
'            If oRsCal.RecordCount > 0 Then
'               oRs.Fields(oRsCal.Fields(0).Name).Value = oRsCal.Fields(0).Value
'               oRs.Update
'            End If
'            oRsCal.Close
'
'            'Agrego los vales emitidos para retiro de materiales
'            Set oRsVal = oAp.LMateriales.TraerFiltrado("_DisponibilidadesVal", oRs1.Fields(0).Value)
'            If oRsVal.RecordCount > 0 Then
'               oRs.Fields(oRsVal.Fields(0).Name).Value = oRsVal.Fields(0).Value
'               oRs.Update
'            End If
'            oRsVal.Close
'
'            'Agrego las salidas de materiales concretadas por item
'            Set oRsSal = oAp.LMateriales.TraerFiltrado("_DisponibilidadesSal", oRs1.Fields(0).Value)
'            If oRsSal.RecordCount > 0 Then
'               oRs.Fields(oRsSal.Fields(0).Name).Value = oRsSal.Fields(0).Value
'               oRs.Update
'            End If
'            oRsSal.Close
'
'            .MoveNext
'
'         Loop
'
'      End If
'
'      .Close
'
'   End With
'
'   Set CalcularDisponibilidades = oRs
'
'   Set oRs = Nothing
'   Set oRs1 = Nothing
'   Set oRsRes = Nothing
'   Set oRsPed = Nothing
'   Set oRsRec = Nothing
'   Set oRsVal = Nothing
'   Set oRsSal = Nothing
'   Set oAp = Nothing

End Function

Private Sub DarPorCumplido()

   Dim mvarOK As Boolean
   Dim mvarIdAutorizo As Long
   Dim iFilas As Integer
   Dim Filas, Columnas
   
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
   If Not mvarOK Then
      MsgBox "Solo personal de COMPRAS puede dar por cumplido", vbExclamation
      Exit Sub
   End If
   
   Dim of1 As frmAsignarComoCumplido
   Dim oL As ListItem
   Dim oPed As ComPronto.Pedido
   Dim oDetP As ComPronto.DetPedido
   Dim oRs1 As ADOR.Recordset
   Dim mvarIdDioPorCumplido As Long
   
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
   
   If Not mvarOK Then
      Exit Sub
   End If
   
   Me.MousePointer = vbHourglass
   
   Filas = VBA.Split(Lista.GetString, vbCrLf)
   For iFilas = LBound(Filas) + 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(iFilas), vbTab)
      If IsNumeric(Columnas(21)) And Columnas(22) <> "SI" Then
         '.SubItems(21) = "SI"
         Set oPed = Aplicacion.Pedidos.Item(Columnas(21))
         Set oDetP = oPed.DetPedidos.Item(Columnas(27))
         oDetP.Registro.Fields("Cumplido").Value = "SI"
         oDetP.Registro.Fields("IdAutorizoCumplido").Value = mvarIdAutorizo
         oDetP.Registro.Fields("IdDioPorCumplido").Value = mvarIdDioPorCumplido
         oDetP.Registro.Fields("FechaDadoPorCumplido").Value = Now
         oDetP.Registro.Fields("ObservacionesCumplido").Value = rchObservacionesCumplido.Text
         oDetP.Modificado = True
'                     .SmallIcon = "Modificado"
         oPed.Guardar
         Set oDetP = Nothing
         Set oPed = Nothing
      End If
   Next
   
   Set oRs1 = Nothing
   
   Me.MousePointer = vbDefault
   
End Sub


