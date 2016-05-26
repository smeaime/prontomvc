VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "Comctl32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmBuscarArticulo 
   Caption         =   "Busqueda de materiales"
   ClientHeight    =   6345
   ClientLeft      =   2925
   ClientTop       =   2475
   ClientWidth     =   9555
   LinkTopic       =   "Form1"
   ScaleHeight     =   6345
   ScaleWidth      =   9555
   StartUpPosition =   2  'CenterScreen
   Begin ComctlLib.TreeView tvwItems 
      Height          =   4530
      Left            =   30
      TabIndex        =   0
      Top             =   660
      Width           =   8505
      _ExtentX        =   15002
      _ExtentY        =   7990
      _Version        =   327682
      Style           =   7
      Appearance      =   1
      OLEDragMode     =   1
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   1
      Top             =   5955
      Width           =   9555
      _ExtentX        =   16854
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   7
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   5292
            MinWidth        =   5292
            Picture         =   "frmBuscarArticulo.frx":0000
            Key             =   "Estado"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   2999
            MinWidth        =   2999
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   5292
            MinWidth        =   5292
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   1
            Alignment       =   1
            AutoSize        =   2
            Enabled         =   0   'False
            Object.Width           =   900
            MinWidth        =   18
            TextSave        =   "CAPS"
            Key             =   "Caps"
         EndProperty
         BeginProperty Panel5 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   2
            AutoSize        =   2
            Object.Width           =   820
            MinWidth        =   18
            TextSave        =   "NUM"
            Key             =   "Num"
         EndProperty
         BeginProperty Panel6 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            Alignment       =   1
            AutoSize        =   2
            Object.Width           =   1693
            MinWidth        =   18
            TextSave        =   "16/09/2002"
            Key             =   "Fecha"
         EndProperty
         BeginProperty Panel7 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   5
            AutoSize        =   2
            Object.Width           =   873
            MinWidth        =   19
            TextSave        =   "12:33"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   630
      Top             =   5355
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   33
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":031A
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":042C
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":053E
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":0650
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":0762
            Key             =   "Cut"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":0874
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":0986
            Key             =   "Paste"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":0A98
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":0BAA
            Key             =   "Undo"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":0CBC
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":0DCE
            Key             =   "Sort Ascending"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":0EE0
            Key             =   "Sort Descending"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":0FF2
            Key             =   "Up One Level"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":1104
            Key             =   "View Large Icons"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":1216
            Key             =   "View Small Icons"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":1328
            Key             =   "View List"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":143A
            Key             =   "View Details"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":154C
            Key             =   "Properties"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":165E
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":1770
            Key             =   "Help What's This"
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":1882
            Key             =   "CopiarCampo"
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":1CD4
            Key             =   "ActualizaMateriales"
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":1FEE
            Key             =   "Excel"
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":2440
            Key             =   "Refrescar"
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":275A
            Key             =   "Parametros"
         EndProperty
         BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":2A74
            Key             =   "Empresa"
         EndProperty
         BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":2D8E
            Key             =   "RefrescarArbol"
         EndProperty
         BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":30A8
            Key             =   "EnviarCorreo1"
         EndProperty
         BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":585A
            Key             =   "EnviarCorreo"
         EndProperty
         BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":5B74
            Key             =   "LeerCorreo"
         EndProperty
         BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":5E8E
            Key             =   "EnviarMensaje"
         EndProperty
         BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":62E0
            Key             =   "Abrir"
         EndProperty
         BeginProperty ListImage33 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmBuscarArticulo.frx":6BBA
            Key             =   "Cerrar"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   9555
      _ExtentX        =   16854
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Abrir"
            Object.ToolTipText     =   "Abrir los nodos del arbol de materiales"
            ImageKey        =   "Abrir"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cerrar"
            Object.ToolTipText     =   "Cerrar los nodos del arbol de materiales"
            ImageKey        =   "Cerrar"
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmBuscarArticulo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Activate()

   StatusBar1.Panels.Item(1).Text = "Cargando menu de materiales"
   Me.Refresh
   
   CargaArbolConMateriales
'   HookForm Me
   CargaPopUpMenu
   
   StatusBar1.Panels.Item(1).Text = "Usuario actual : " & UsuarioSistema

End Sub

Private Sub Form_Load()

   Dim oAp As ComAesa.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim i, SN As Integer
   
   Set Aplicacion = CreateObject("ComAesa.Aplicacion")
   Set oAp = Aplicacion
   
   Set oRs = oAp.Articulos.TraerFiltrado("_ParaMenu")
   GrabarMenu oRs
   oRs.Close
   
   Set oRs = oAp.TablasGenerales.TraerFiltrado("BD", "_Host")
   gblHOST = ""
   If oRs.RecordCount > 0 Then
      gblHOST = oRs.Fields(0).Value
   End If
   oRs.Close
   
   Set oRs = oAp.TablasGenerales.TraerFiltrado("BD", "_BaseDeDatos")
   gblBD = ""
   If oRs.RecordCount > 0 Then
      gblBD = oRs.Fields(0).Value
   End If
   oRs.Close
   
   StatusBar1.Panels.Item(2).Text = "Host : " & gblHOST & " - BD : " & gblBD

   UsuarioSistema = GetCurrentUserName()
   UsuarioSistema = Mid(UsuarioSistema, 1, Len(UsuarioSistema) - 1)
   glbAdministrador = False
   glbInicialesUsuario = ""
   Set oRs = oAp.Empleados.TraerFiltrado("_usuarioNT", UsuarioSistema)
   With oRs
      If .RecordCount > 0 Then
         UsuarioSistema = UsuarioSistema & " [ " & IIf(IsNull(.Fields("Nombre").Value), " ", .Fields("Nombre").Value) & " ]"
         glbNombreUsuario = .Fields("Nombre").Value
         glbIdUsuario = oRs.Fields(0).Value
         glbInicialesUsuario = IIf(IsNull(oRs.Fields("Iniciales").Value), "", oRs.Fields("Iniciales").Value)
         If Not IsNull(oRs.Fields("Administrador").Value) Then
            If oRs.Fields("Administrador").Value = "SI" Then
               glbAdministrador = True
            End If
         End If
      Else
         glbIdUsuario = -1
      End If
      .Close
   End With
   
   Set oRs = Nothing
   Set oAp = Nothing

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Resize()

   Ajustar

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set Aplicacion = Nothing
   unHookForm

End Sub

Sub Ajustar()

   Dim Arriba As Long
   Dim Altura As Long
   Dim Ancho As Long
   
   Arriba = Toolbar1.Height
   Ancho = Me.ScaleWidth
   Altura = Me.ScaleHeight - Arriba - StatusBar1.Height
   
   On Error Resume Next
   
   With tvwItems
      .Left = 0
      .Top = Arriba
      .Height = Altura
      .Width = Ancho
   End With
   
End Sub

Private Sub CargaPopUpMenu()

   Me.MousePointer = vbHourglass
      
   Dim oRs As ADOR.Recordset
   Static mItem(15), mHoja As String
   Dim hw, menuheight, breakpoint, hMenu, mAux As Long
   Dim mRefMenu(15) As Long
   Dim i, X As Integer
   Dim mCorte(15) As String
   Dim mClave, mDesc, mDescripcion As String

   For i = 1 To 14
      mCorte(i) = ""
      mItem(i) = 0
   Next
   
   menuheight = GetSystemMetrics(SM_CYMENU)
   breakpoint = (GetSystemMetrics(SM_CYFULLSCREEN) - menuheight) \ menuheight
   
   hw = Me.hWnd
   hMenu = GetSystemMenu(hw, False)

   mRefMenu(1) = AddSubMenu("Materiales", hMenu)

   Set oRs = MenuMultinivel
   
   With oRs
      
      If .RecordCount() > 0 Then
         
         .MoveFirst
         
         Do While Not .EOF
            
            For i = 1 To 13
               
               mClave = "Campo" & Format(i, "00") & "_Clave"
               
               If Not IsNull(.Fields(mClave).Value) Then
                  
                  mDesc = "Campo" & Format(i, "00") & "_Descripcion"
                  If Not IsNull(.Fields(mDesc).Value) Then
                     mDescripcion = IIf(Len(.Fields(mDesc).Value) = 0, "s/d", .Fields(mDesc).Value)
                  Else
                     mDescripcion = "s/d"
                  End If
                  
                  If mCorte(i) <> mDescripcion Then
                     mItem(i) = mItem(i) + 1
                     If mItem(i) Mod breakpoint = 0 Then
                        mRefMenu(i) = AddSubMenu("Mas " & .Fields(mClave).Value, mRefMenu(i))
                     End If
                     If mCorte(i) = "" Then mAux = AddMenuItem(.Fields(mClave).Value, mRefMenu(i), -1)
                     mRefMenu(i + 1) = AddSubMenu(mDescripcion, mRefMenu(i))
                     mCorte(i) = mDescripcion
                     For X = i + 1 To 13
                        mCorte(X) = ""
                     Next
                     If i < 13 Then mItem(i + 1) = 0
                     mHoja = 0
                  End If
                  
                  If i < 13 Then
                     mClave = "Campo" & Format(i + 1, "00") & "_Clave"
                     If IsNull(.Fields(mClave).Value) Then
                        mHoja = mHoja + 1
                        If mHoja Mod breakpoint = 0 Then
                           mRefMenu(i + 1) = AddSubMenu("Mas materiales", mRefMenu(i + 1))
                        End If
                        mAux = AddMenuItem(.Fields("Articulo").Value, mRefMenu(i + 1), .Fields("IdArticulo").Value)
                     End If
                  End If
               
               End If
               
            Next
               
            .MoveNext
            
         Loop
         
      End If
      
      StatusBar1.Panels.Item(2).Text = "Hay " & oRs.RecordCount & " materiales."
      .Close
         
   End With

   Set oRs = Nothing

   Me.MousePointer = vbDefault

End Sub

Public Sub miMSG(ByVal uMSG As Long, ByVal wParam As Long, ByVal lParam As Long)
    
   If uMSG = WM_MENUSELECT Then
      
      Dim mClave As Long
      mClave = CLng(wParam And &HFFFF&)
      If mClave <= 0 Then
         Exit Sub
      End If
      
         Dim nodo As Node
         For Each nodo In tvwItems.Nodes
            With nodo
               If Len(Trim(.Tag)) > 0 And IsNumeric(.Tag) Then
                  If mClave = CLng(.Tag) Then
                     .Selected = True
                     .EnsureVisible
                     Exit For
                  End If
               End If
            End With
         Next
   End If
   
End Sub

Private Sub CargaArbolConMateriales()

   Me.MousePointer = vbHourglass
      
   Dim oRs As ADOR.Recordset
   Dim hw, hMenu, Niv As Long
   Dim ParentItem, NewItem, NewItem1, NewItem2, NewItem3, NewItem4, NewItem5, NewItem9 As Object
   Dim mItem As String
   
   tvwItems.Nodes.Add , , "Busqueda", "Busqueda"
'   tvwItems.Nodes(1).Tag = RootMenu
   tvwItems.Nodes(1).Selected = True
   Set ParentItem = tvwItems.SelectedItem

   Set oRs = LeerMenu

   If oRs.RecordCount() > 0 Then
      oRs.MoveFirst
      Do While Not oRs.EOF
         Niv = oRs.Fields("Nivel").Value
         If Len(Trim(oRs.Fields("Nombre").Value)) = 0 Then
            mItem = "S/D"
         Else
            mItem = oRs.Fields("Nombre").Value
         End If
         Select Case Niv
            Case 1
               Set NewItem1 = tvwItems.Nodes.Add(ParentItem, tvwChild, , mItem)
               NewItem1.EnsureVisible
'               NewItem1.Selected = True
               Set NewItem = NewItem1
            Case 2
               Set NewItem2 = tvwItems.Nodes.Add(NewItem1, tvwChild, , mItem)
               Set NewItem = NewItem2
            Case 3
               Set NewItem3 = tvwItems.Nodes.Add(NewItem2, tvwChild, , mItem)
               Set NewItem = NewItem3
            Case 4
               Set NewItem4 = tvwItems.Nodes.Add(NewItem3, tvwChild, , mItem)
               Set NewItem = NewItem4
            Case 5
               Set NewItem5 = tvwItems.Nodes.Add(NewItem4, tvwChild, , mItem)
               Set NewItem = NewItem5
            Case 9
               Set NewItem9 = tvwItems.Nodes.Add(NewItem, tvwChild, , mItem)
               NewItem9.Tag = oRs.Fields(0).Value
         End Select
         oRs.MoveNext
      Loop
      oRs.Close
   End If
   
   Set oRs = Nothing
   
   Me.MousePointer = vbDefault

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   On Error Resume Next
   
   Dim nodo As Node
   
   Select Case Button.Key
      
      Case "Abrir"
        
         For Each nodo In tvwItems.Nodes
            With nodo
               If .Children > 0 And Not .Expanded Then
                  .Expanded = True
               End If
            End With
         Next
   
      Case "Cerrar"
        
         For Each nodo In tvwItems.Nodes
            With nodo
               If .Children > 0 And .Expanded Then
                  .Expanded = False
               End If
            End With
         Next
   
      
   End Select

End Sub

Private Sub tvwItems_NodeClick(ByVal Node As ComctlLib.Node)

   tvwItems.Nodes(Node.Index).Selected = True

End Sub

Private Sub tvwItems_OLESetData(Data As ComctlLib.DataObject, DataFormat As Integer)

   Dim nodo As Node
   Dim s As String
   
   s = ""
   For Each nodo In tvwItems.Nodes
      With nodo
         If .Selected Then
            s = s & "Material" & vbTab & .Tag & vbTab & .Text & vbTab
         End If
      End With
   Next
   
   If Len(s) Then
      s = Left$(s, Len(s) - Len(vbCrLf))
      Data.SetData s, ccCFText
   End If

End Sub
