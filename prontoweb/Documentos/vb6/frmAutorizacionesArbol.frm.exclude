VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmAutorizacionesArbol 
   Caption         =   "Esquema general de autorizacion"
   ClientHeight    =   8040
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11640
   Icon            =   "frmAutorizacionesArbol.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8040
   ScaleWidth      =   11640
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "Seleccionar &todo"
      Height          =   540
      Index           =   1
      Left            =   5895
      TabIndex        =   8
      Top             =   7425
      Width           =   1125
   End
   Begin VB.TextBox Text2 
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
      Left            =   6660
      Locked          =   -1  'True
      TabIndex        =   4
      Top             =   540
      Width           =   4920
   End
   Begin VB.TextBox Text1 
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   330
      Left            =   3240
      Locked          =   -1  'True
      TabIndex        =   3
      Top             =   540
      Width           =   3390
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   540
      Index           =   0
      Left            =   4725
      TabIndex        =   2
      Top             =   7425
      Width           =   1125
   End
   Begin MSComctlLib.TreeView Arbol 
      Height          =   6810
      Left            =   45
      TabIndex        =   0
      Top             =   495
      Width           =   3105
      _ExtentX        =   5477
      _ExtentY        =   12012
      _Version        =   393217
      Indentation     =   18
      LabelEdit       =   1
      LineStyle       =   1
      Style           =   7
      ImageList       =   "img16"
      Appearance      =   1
      OLEDropMode     =   1
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   7560
      Top             =   7380
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   26
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":076A
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":087C
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":098E
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":0AA0
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":0BB2
            Key             =   "Cut"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":0CC4
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":0DD6
            Key             =   "Paste"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":0EE8
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":0FFA
            Key             =   "Undo"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":110C
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":121E
            Key             =   "Sort Ascending"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":1330
            Key             =   "Sort Descending"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":1442
            Key             =   "Up One Level"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":1554
            Key             =   "View Large Icons"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":1666
            Key             =   "View Small Icons"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":1778
            Key             =   "View List"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":188A
            Key             =   "View Details"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":199C
            Key             =   "Properties"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":1AAE
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":1BC0
            Key             =   "Help What's This"
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":1CD2
            Key             =   "CopiarCampo"
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":2124
            Key             =   "ActualizaMateriales"
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":243E
            Key             =   "Excel"
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":2890
            Key             =   "Refrescar"
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":2BAA
            Key             =   "Parametros"
         EndProperty
         BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":2EC4
            Key             =   "Firma"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   6405
      Left            =   3195
      TabIndex        =   1
      Top             =   900
      Width           =   8385
      _ExtentX        =   14790
      _ExtentY        =   11298
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmAutorizacionesArbol.frx":31DE
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList img32 
      Left            =   8820
      Top             =   7380
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":31FA
            Key             =   "Abierto"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":364C
            Key             =   "Abierto1"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":3A9E
            Key             =   "Cerrado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":3EF0
            Key             =   "Cerrado1"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":4342
            Key             =   "Autorizaciones"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":4C1C
            Key             =   "Item"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":4F36
            Key             =   "Item1"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList img16 
      Left            =   8190
      Top             =   7380
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
            Picture         =   "frmAutorizacionesArbol.frx":5250
            Key             =   "Abierto1"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":56A2
            Key             =   "Cerrado1"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":5AF4
            Key             =   "Cerrado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":5F46
            Key             =   "Abierto"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":6398
            Key             =   "Autorizaciones"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":6C72
            Key             =   "Item"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAutorizacionesArbol.frx":6F8C
            Key             =   "Item1"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   11640
      _ExtentX        =   20532
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Filtrar datos"
            ImageKey        =   "Find"
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageKey        =   "Print"
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Firma"
            Object.ToolTipText     =   "Recordar firma"
            ImageKey        =   "Firma"
         EndProperty
      EndProperty
   End
   Begin VB.Label lblQuien 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   90
      TabIndex        =   9
      Top             =   7830
      Width           =   4425
   End
   Begin VB.Label Label2 
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFC0&
      Height          =   285
      Left            =   9450
      TabIndex        =   7
      Top             =   7515
      Width           =   2130
   End
   Begin VB.Label Label1 
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFC0&
      Height          =   285
      Left            =   45
      TabIndex        =   5
      Top             =   7515
      Width           =   4515
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Firmar documentos"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Marcar como visto"
         Index           =   1
      End
   End
End
Attribute VB_Name = "frmAutorizacionesArbol"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim WithEvents ActL As ControlForm
Attribute ActL.VB_VarHelpID = -1
Private mFirmaActiva As Boolean
Private mPassword As String, mRespetarPrecedencia As String
Private mIdFirmante As Long

Private Sub ActL_ActLista(ByVal IdRegistro As Long, ByVal TipoAccion As EnumAcciones, ByVal NombreListaEditada As String, ByVal mvarIdRegistro As Long)

   Me.MousePointer = vbDefault
      
End Sub

Private Sub Arbol_NodeClick(ByVal Node As MSComctlLib.Node)

   Dim oRs As ADOR.Recordset
   Dim k_node As Long
   Dim mKey
   
   Me.MousePointer = vbHourglass
   
   Label1.Caption = ""
   
   If mId(Node.Key, 1, 1) = "I" Then
   
      mKey = VBA.Split(Node.Key, "|")
      k_node = CLng(mKey(2))
      
      If Text2.Text <> Node.Text Then
         mFirmaActiva = False
         mPassword = ""
         mIdFirmante = 0
         Label2.Caption = ""
      End If
      
      Text1.Text = Node.Parent.Text
      Text2.Text = Node.Text
      
      Set oRs = Aplicacion.Empleados.TraerFiltrado("_PorNombre", Node.Text)
      If oRs.RecordCount > 0 Then
         mIdFirmante = oRs.Fields(0).Value
      Else
         mIdFirmante = 0
      End If
      oRs.Close
      
      Set oRs = Aplicacion.AutorizacionesPorComprobante.TraerFiltrado("_DocumentosPorAutoriza", k_node)
      
      Lista.IconoGrande = Node.Image
      Lista.IconoPequeño = Node.Image
      
      If Not IsEmpty(oRs) Then
         Set Lista.DataSource = oRs
         Label1.Caption = "Hay " & Lista.ListItems.Count & " documentos en la lista."
      Else
         Lista.ListItems.Clear
      End If
   
   ElseIf mId(Node.Key, 1, 1) = "X" Then
   
      mKey = VBA.Split(Node.Key, "|")
      k_node = CLng(mKey(2))
      
      If Text2.Text <> Node.Text Then
         mFirmaActiva = False
         mPassword = ""
         mIdFirmante = 0
         Label2.Caption = ""
      End If
      
      Text1.Text = Node.Parent.Parent.Text
      Text2.Text = Node.Parent.Text
      
      Set oRs = Aplicacion.Empleados.TraerFiltrado("_PorNombre", Node.Parent.Text)
      If oRs.RecordCount > 0 Then
         mIdFirmante = oRs.Fields(0).Value
      Else
         mIdFirmante = 0
      End If
      oRs.Close
      
      Set oRs = Aplicacion.AutorizacionesPorComprobante.TraerFiltrado("_DocumentosPorAutorizaSuplentes", k_node)
      
      Lista.IconoGrande = Node.Image
      Lista.IconoPequeño = Node.Image
      
      If Not IsEmpty(oRs) Then
         Set Lista.DataSource = oRs
         Label1.Caption = "Hay " & Lista.ListItems.Count & " documentos en la lista."
      Else
         Lista.ListItems.Clear
      End If
   
   End If
   
   Set oRs = Nothing
   
   Me.MousePointer = vbDefault
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Unload Me
      Case 1
         If Lista.ListItems.Count > 0 Then
            Dim oL As ListItem
            For Each oL In Lista.ListItems
               oL.Selected = True
            Next
         End If
   End Select
   
End Sub

Private Sub Form_Load()

   Dim mSuplentes As String, mKey As String, mSoloUsuario As String
   Dim mSuplentesPorTitular As String
   
   mFirmaActiva = False
   mPassword = ""
   mIdFirmante = 0

   With Lista
      Set .Icons = img32
      Set .SmallIcons = img16
   End With
   
   mRespetarPrecedencia = BuscarClaveINI("Respetar precedencia en circuito de firmas")
   If mRespetarPrecedencia = "" Then mRespetarPrecedencia = "NO"
   
   mSuplentes = BuscarClaveINI("Ver firmas de suplentes")
   mSuplentesPorTitular = BuscarClaveINI("Ver todas las firmas de titulares como suplente")
   If Len(mSuplentesPorTitular) = 0 Then mSuplentesPorTitular = "NO"
   
   Dim oAp As ComPronto.Aplicacion
   Dim oAut As ComPronto.AutorizacionesPorComprobante
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim mNodo As Node
   Dim mProcesar As Boolean
   
   Set ActL = New ControlForm
   
   Set oAp = Aplicacion
   Set oAut = oAp.AutorizacionesPorComprobante
   
   oAut.Tarea "AutorizacionesPorComprobante_Generar", Array(mRespetarPrecedencia)
   
   mSoloUsuario = "NO"
   Set oRs = oAp.Parametros.TraerFiltrado("_Parametros2BuscarClave", "SoloUsuarioConectadoEnArbolAutorizaciones")
   If oRs.RecordCount > 0 Then
      mSoloUsuario = IIf(IsNull(oRs.Fields("Valor").Value), "NO", oRs.Fields("Valor").Value)
   End If
   oRs.Close
   If mSoloUsuario = "SI" Then
      lblQuien.Caption = "Solo usuario conectado"
   Else
      lblQuien.Caption = "Todos los firmantes"
   End If
   
   Set oRs = oAut.TraerFiltrado("_Sectores")
   
   Arbol.Nodes.Add , , "Autorizaciones", "Autorizaciones", "Autorizaciones", "Autorizaciones"
   
   If oRs.RecordCount > 0 Then
      oRs.MoveFirst
      Do While Not oRs.EOF
         Arbol.Nodes.Add "Autorizaciones", tvwChild, "S" & oRs.Fields(0).Value, IIf(IsNull(oRs.Fields(1).Value), "S/D", oRs.Fields(1).Value), "Item", "Item"
         Set oRs1 = oAut.TraerFiltrado("_AutorizaPorSector", oRs.Fields(0).Value)
         If oRs1.RecordCount > 0 Then
            oRs1.MoveFirst
            Do While Not oRs1.EOF
               If mSoloUsuario = "NO" Or (mSoloUsuario = "SI" And oRs1.Fields(0).Value = glbIdUsuario) Then
                  mProcesar = True
                  If mSuplentesPorTitular = "SI" Then mProcesar = EstaElSuplente(oRs1.Fields(0).Value)
                  If mProcesar Then
                     mKey = "I|" & oRs.Fields(0).Value & "|" & oRs1.Fields(0).Value
                     Arbol.Nodes.Add "S" & oRs.Fields(0).Value, tvwChild, mKey, oRs1.Fields(1).Value, "Item", "Item"
                     If mSuplentes = "SI" Then
                        Arbol.Nodes.Add mKey, tvwChild, "X|" & oRs.Fields(0).Value & "|" & oRs1.Fields(0).Value, "Firmas de suplentes", "Item1", "Item1"
                     End If
                  End If
               End If
               oRs1.MoveNext
            Loop
         End If
         oRs1.Close
         oRs.MoveNext
      Loop
      oRs.Close
      For Each mNodo In Arbol.Nodes
         mNodo.Expanded = True
      Next
   Else
      oRs.Close
      MsgBox "No hay documentos pendientes de autorizar", vbExclamation
      Set oRs = Nothing
      Set oRs1 = Nothing
      Set oAut = Nothing
      Set oAp = Nothing
'      Unload Me
   End If
   
   Set oRs = Nothing
   Set oRs1 = Nothing
   Set oAut = Nothing
   Set oAp = Nothing

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set ActL = Nothing

End Sub

Private Sub Lista_DblClick()

   If Not Lista.SelectedItem Is Nothing Then
      If InStr(1, Lista.ColumnHeaders(1).Text, "Tipo doc.") <> 0 Then
         Editar Lista.SelectedItem.SubItems(3), Lista.SelectedItem.Text
      Else
         If Len(Trim(Lista.SelectedItem.SubItems(16))) <> 0 Then
            Editar Lista.SelectedItem.SubItems(16), Lista.SelectedItem.Text
         End If
      End If
   End If
   
End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Not Lista.SelectedItem Is Nothing Then
         If Lista.ListItems.Count > 0 Then
            If InStr(1, Lista.ColumnHeaders(1).Text, "Tipo doc.") <> 0 Then
               MnuDetA(0).Enabled = False
               MnuDetA(1).Enabled = True
               PopupMenu MnuDet, , , , MnuDetA(1)
            Else
               MnuDetA(0).Enabled = True
               MnuDetA(1).Enabled = False
               PopupMenu MnuDet, , , , MnuDetA(0)
            End If
         End If
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         If Not Lista.SelectedItem Is Nothing Then
            FirmarDocumentos
         End If
      Case 1
         If Not Lista.SelectedItem Is Nothing Then
            DarPorVisto
         End If
   End Select

End Sub

Public Sub FirmarDocumentos()

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oF As frmAutorizacion
   Dim mvarOK As Boolean
   Dim i As Integer
   Dim mvarIdAutorizo As Long, mvarNumeroComprobante As Long
   Dim Filas, Columnas
   
   Set oAp = Aplicacion
   
   Filas = VBA.Split(Lista.GetString, vbCrLf)
   
   'Control de controles de calidad en Listas de Acopio
   mvarNumeroComprobante = 0
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      If Columnas(13) = EnumFormularios.ListaAcopio And Columnas(7) = 2 Then
         If Not oAp.Acopios.ControlesOK(oL.Tag) Then
            mvarNumeroComprobante = Columnas(2)
            Exit For
         End If
      End If
   Next
   If mvarNumeroComprobante > 0 Then
      MsgBox "La lista de acopio " & mvarNumeroComprobante & ", tiene uno o mas items sin control de calidad definido", vbExclamation
      GoTo Salida:
   End If
   
   'Control de fechas de necesidad en Listas de Acopio
   mvarNumeroComprobante = 0
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      If Columnas(13) = EnumFormularios.ListaAcopio And Columnas(7) = 3 Then
         If Not oAp.Acopios.FechasNecesidadOK(oL.Tag) Then
            mvarNumeroComprobante = Columnas(2)
            Exit For
         End If
      End If
   Next
   If mvarNumeroComprobante > 0 Then
      MsgBox "La lista de acopio " & mvarNumeroComprobante & ", tiene uno o mas items sin fecha de necesidad definida", vbExclamation
      GoTo Salida:
   End If
   
   'Control de controles de calidad en requerimientos
'   mvarNumeroComprobante = 0
'   For Each oL In Lista.ListItems
'      If oL.Selected Then
'         If oL.SubItems(12) = EnumFormularios.RequerimientoMateriales And oL.SubItems(6) = 2 Then
'            If Not oAp.Requerimientos.ControlesOK(oL.Tag) Then
'               mvarNumeroComprobante = oL.SubItems(1)
'               Exit For
'            End If
'         End If
'      End If
'   Next
'   If mvarNumeroComprobante > 0 Then
'      MsgBox "El requerimiento " & mvarNumeroComprobante & ", tiene uno o mas items sin control de calidad definido", vbExclamation
'      GoTo Salida:
'   End If
   
   'Control de fechas de necesidad en requerimientos
'   mvarNumeroComprobante = 0
'   For i = 1 To UBound(Filas)
'      Columnas = VBA.Split(Filas(i), vbTab)
'      If Columnas(13) = EnumFormularios.RequerimientoMateriales And Columnas(7) = 3 Then
'         If Not oAp.Requerimientos.FechasNecesidadOK(oL.Tag) Then
'            mvarNumeroComprobante = Columnas(2)
'            Exit For
'         End If
'      End If
'   Next
'   If mvarNumeroComprobante > 0 Then
'      MsgBox "El requerimiento " & mvarNumeroComprobante & ", tiene uno o mas items sin fecha de necesidad definida", vbExclamation
'      GoTo Salida:
'   End If
   
   Set oF = New frmAutorizacion
   
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      With oF
         .Empleado = Text2.Text
         .Formulario = Columnas(13)
         .Orden = Columnas(14)
         .SectorRM = Columnas(15)
         .IdObra = IIf(Columnas(16) = "", 0, Columnas(16))
         .Importe = (IIf(Columnas(5) = "", 0, Columnas(5)) - IIf(Columnas(20) = "", 0, Columnas(20))) * IIf(Columnas(18) = "", 1, Columnas(18))
         .Show vbModal, Me
         mvarOK = .Ok
         mvarIdAutorizo = .IdAutorizo
      End With
      Exit For
   Next
   
   Unload oF
   Set oF = Nothing
   
   If Not mvarOK Then
      GoTo Salida:
   End If
   
   'Si hay control de precedencias en las firmas, avisa al siguiente firmante
   If mRespetarPrecedencia = "SI" Then
      For i = 1 To UBound(Filas)
         Columnas = VBA.Split(Filas(i), vbTab)
         If Columnas(13) = EnumFormularios.NotaPedido Then
            Set oRs = Aplicacion.AutorizacionesPorComprobante.TraerFiltrado("_PorIdPedido", _
                           Array(Columnas(17), Columnas(7) + 1))
            If oRs.RecordCount > 0 Then
               oRs.MoveFirst
               If Not IsNull(oRs.Fields("Autoriza").Value) Then
                  Aplicacion.Tarea "NovedadesUsuarios_GrabarNovedadNueva", _
                           Array(oRs.Fields("Autoriza").Value, 2, _
                                 "Firmar Pedido: " & Columnas(2) & " del " & Columnas(3))
               End If
            End If
            oRs.Close
         End If
      Next
   End If
   
   Dim oAuts As ComPronto.AutorizacionesPorComprobante
   Dim oAut As ComPronto.AutorizacionPorComprobante
   Dim oNodo As Object
   
   Set oNodo = Arbol.SelectedItem
   
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      Set oAut = oAp.AutorizacionesPorComprobante.Item(-1)
      With oAut.Registro
         .Fields("IdFormulario").Value = Columnas(13)
         .Fields("IdComprobante").Value = Columnas(17)
         .Fields("OrdenAutorizacion").Value = Columnas(14)
         .Fields("IdAutorizo").Value = mvarIdAutorizo
         .Fields("FechaAutorizacion").Value = Now
      End With
      oAut.Guardar
      Set oAut = Nothing
   Next
   
   Set oAuts = oAp.AutorizacionesPorComprobante
   
   oAuts.Tarea "AutorizacionesPorComprobante_Generar", Array(mRespetarPrecedencia)
   
   Lista.ListItems.Clear
   Arbol_NodeClick oNodo

Salida:

   Set oAut = Nothing
   Set oAuts = Nothing
   Set oRs = Nothing
   Set oAp = Nothing
   
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
      Case Else
         MsgBox "Comprobante no editable"
         GoTo Salida:
   End Select
   
   With oF
      If TipoComprobante = "Pedido" Then
         If BuscarClaveINI("Visualizacion simplificada de pedidos a autorizar") = "SI" Then
            oF.VisualizacionSimplificada = True
         Else
            oF.VisualizacionSimplificada = False
         End If
      End If
      .Id = Identificador
      If TipoComprobante = "R.M." Then
         oF.Password = mPassword
      End If
      .Disparar = ActL
      .Show , Me
   End With

Salida:

   Set oF = Nothing

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Key
      
      Case "Imprimir"
         
         ImprimirConExcel Lista
      
      Case "Buscar"
         
         FiltradoLista Lista
'         StatusBar1.Panels(2).Text = Ultimo_Nodo & " " & Lista.ListItems.Count & " elementos en la lista"

      Case "Firma"
         
         If Not mIdFirmante > 0 Then
            MsgBox "Debe posicionar el cursor en algun firmante", vbExclamation
            Exit Sub
         End If
         
         Dim off As frmAutorizacion1
         Dim mvarOK As Boolean
         
         Set off = New frmAutorizacion1
         
         With off
            .IdUsuario = mIdFirmante
            .Show vbModal, Me
            mvarOK = .Ok
            mPassword = .Password
         End With
         
         Unload off
         Set off = Nothing
      
         If Not mvarOK Then
            Exit Sub
         End If

         mFirmaActiva = True
         Label2.Caption = "Firma activa"
   
   End Select

End Sub

Public Sub DarPorVisto()

   Dim oF As frmAutorizacion
   Dim mvarOK As Boolean
   
   Set oF = New frmAutorizacion
   With oF
      .Empleado = Text2.Text
      .ActivarEmpleadosPorNombre = True
      .Show vbModal, Me
      mvarOK = .Ok
   End With
   Unload oF
   Set oF = Nothing
   If Not mvarOK Then
      Exit Sub
   End If
   
   Dim oNodo As Object
   Dim Filas, Columnas
   
   Set oNodo = Arbol.SelectedItem
   
   Filas = VBA.Split(Lista.GetString, vbCrLf)
   
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      Aplicacion.Tarea "AutorizacionesPorComprobante_DarPorVisto", Columnas(2)
   Next
   
   Lista.ListItems.Clear
   Arbol_NodeClick oNodo

End Sub

Public Function EstaElSuplente(ByVal IdTitular As Long) As Boolean

   Dim oRs As ADOR.Recordset
   
   Set oRs = Aplicacion.AutorizacionesPorComprobante.TraerFiltrado("_SuplenteDelTitular", _
                  Array(IdTitular, glbIdUsuario))
   If oRs.RecordCount > 0 Then
      EstaElSuplente = True
   Else
      EstaElSuplente = False
   End If
   oRs.Close
   
   Set oRs = Nothing

End Function
