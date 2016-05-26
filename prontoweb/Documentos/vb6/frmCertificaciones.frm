VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{F7D972E3-E925-4183-AB00-B6A253442139}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmCertificaciones 
   Caption         =   "Certificacion de obras"
   ClientHeight    =   6705
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   13245
   LinkTopic       =   "Form1"
   ScaleHeight     =   6705
   ScaleWidth      =   13245
   StartUpPosition =   3  'Windows Default
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Left            =   1755
      TabIndex        =   6
      Top             =   5715
      Visible         =   0   'False
      Width           =   690
      _ExtentX        =   1217
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin VB.PictureBox Split 
      Height          =   3750
      Left            =   3465
      MousePointer    =   9  'Size W E
      ScaleHeight     =   187.5
      ScaleMode       =   2  'Point
      ScaleWidth      =   2.25
      TabIndex        =   5
      Top             =   585
      Width           =   50
   End
   Begin VB.TextBox txtEdit 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   375
      Left            =   675
      TabIndex        =   3
      Top             =   5715
      Visible         =   0   'False
      Width           =   975
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   0
      Top             =   6315
      Width           =   13245
      _ExtentX        =   23363
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   5
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   9657
            Key             =   "Mensaje"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   9657
            Picture         =   "frmCertificaciones.frx":0000
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
            TextSave        =   "29/09/2009"
            Key             =   "Fecha"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   12420
      Top             =   5715
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   10
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":031A
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":042C
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":053E
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":0650
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":0762
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":0874
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":0986
            Key             =   "Excel"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":0DD8
            Key             =   "Project"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":1372
            Key             =   "Importar"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":190C
            Key             =   "Informe"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   13245
      _ExtentX        =   23363
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
            Object.ToolTipText     =   "Salida directa a Excel"
            ImageKey        =   "Excel"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Informe"
            Object.ToolTipText     =   "Informe de certificacion"
            ImageKey        =   "Informe"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Importar"
            Object.ToolTipText     =   "Importar desde Excel certificado"
            ImageKey        =   "Importar"
         EndProperty
      EndProperty
      Begin VB.TextBox Text1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000000&
         Height          =   285
         Index           =   1
         Left            =   1710
         Locked          =   -1  'True
         TabIndex        =   10
         Text            =   "Certificado nro. :"
         Top             =   45
         Width           =   1275
      End
      Begin VB.TextBox Text1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000000&
         Height          =   285
         Index           =   0
         Left            =   3960
         Locked          =   -1  'True
         TabIndex        =   9
         Text            =   "Archivo adjunto :"
         Top             =   45
         Width           =   1275
      End
      Begin FileBrowser1.FileBrowser FileBrowser1 
         Height          =   285
         Index           =   0
         Left            =   5265
         TabIndex        =   8
         Top             =   45
         Width           =   6000
         _ExtentX        =   10583
         _ExtentY        =   503
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
      Begin VB.TextBox txtNumero 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H80000000&
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
         Left            =   3015
         TabIndex        =   7
         Top             =   45
         Width           =   825
      End
   End
   Begin MSComctlLib.ImageList img16 
      Left            =   11835
      Top             =   5715
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   9
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":1EA6
            Key             =   "Abierto1"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":22F8
            Key             =   "Cerrado1"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":274A
            Key             =   "Cerrado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":2B9C
            Key             =   "Abierto"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":2FEE
            Key             =   "Obras"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":3588
            Key             =   "Etapas"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":3B22
            Key             =   "Rubros"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":40BC
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCertificaciones.frx":4656
            Key             =   "Opciones"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.TreeView Arbol 
      Height          =   3390
      Left            =   0
      TabIndex        =   4
      Top             =   810
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   5980
      _Version        =   393217
      HideSelection   =   0   'False
      Indentation     =   18
      LabelEdit       =   1
      LineStyle       =   1
      Style           =   7
      ImageList       =   "img16"
      Appearance      =   1
      OLEDropMode     =   1
   End
   Begin MSHierarchicalFlexGridLib.MSHFlexGrid fGrid 
      Height          =   5055
      Left            =   3510
      TabIndex        =   1
      Top             =   585
      Width           =   9630
      _ExtentX        =   16986
      _ExtentY        =   8916
      _Version        =   393216
      Rows            =   3
      BackColorBkg    =   -2147483643
      _NumberOfBands  =   1
      _Band(0).Cols   =   2
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
End
Attribute VB_Name = "frmCertificaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim WithEvents origen As ComPronto.CertificacionObra
Attribute origen.VB_VarHelpID = -1

Const COL_NODO = 0
Const COL_NODOPADRE = 1
Const COL_DESCRIPCION = 2
Const COL_ITEM = 3
Const COL_TIPO = 4
Const COL_CANTIDADAVAN = 5
Const COL_CANTIDAD = 6
Const COL_UNIMEDIDA = 7
Const COL_IMPORTE = 8
Const COL_ANO = 9
Const COL_DEPTH = 10
Const COL_LINEAGE = 11
Const COL_TOTAL = 12
Const COL_OBRA = 13
Const COL_IDARTICULO = 14

Const ANCHO_COL_ID = 0

Const TIPO_OBRA = 1
Const TIPO_PRESUPUESTO = 2
Const TIPO_ETAPA = 3
Const TIPO_ARTICULO = 4
Const TIPO_RUBRO = 5

Dim actL2 As ControlForm
Private ultimaopcion As String, mObra As String, mAdjunto1 As String
Private Cant_Columnas As Integer
Private mIdObra As Long, mNumeroCertificado As Long
Private mFechaInicialObra As Date, mFechaFinalObra As Date
Private mNivelAcceso As Integer, mOpcionesAcceso As String

Public Property Let NivelAcceso(ByVal mNivelA As EnumAccesos)
   
   mNivelAcceso = mNivelA
   
End Property

Public Property Get NivelAcceso() As EnumAccesos

   NivelAcceso = mNivelAcceso
   
End Property

Public Property Let OpcionesAcceso(ByVal mOpcionesA As String)
   
   mOpcionesAcceso = mOpcionesA
   
End Property

Public Property Get OpcionesAcceso() As String

   OpcionesAcceso = mOpcionesAcceso
   
End Property

Public Property Let Id(ByVal vNewValue As Long)

   Me.NumeroCertificado = vNewValue

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Ajustar()

   Dim Arriba As Long, Altura As Long, Ancho As Long
   
   Arriba = Toolbar1.Height
   Ancho = Me.ScaleWidth
   Altura = Me.ScaleHeight - Arriba - StatusBar1.Height
   
   On Error Resume Next
   
   With Split
      .Top = Arriba
      .Height = Altura
   End With
   
   With Arbol
      .Left = 0
      .Top = Arriba
      .Height = Altura
      If Split.Left >= 0 Then .Width = Split.Left
   End With
   
   With fGrid
      .Top = Arriba
      .Height = Altura
      .Left = Arbol.Left + Arbol.Width + Split.Width
      .Width = Ancho - .Left
  End With
   
End Sub

Private Sub CargarArbol()

   Dim oRs As ADOR.Recordset
   
   Set oRs = Aplicacion.CertificacionesObras.TraerFiltrado("_ParaArbol", Me.NumeroCertificado)
   
   With Arbol.Nodes
      .Clear
      .Add , , "O/", Me.Obra, "Obras", "Obras"
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If IsNull(oRs.Fields("IdNodoPadre").Value) Then
               .Add "O/", tvwChild, "O/" & oRs.Fields("IdCertificacionObras").Value & "/", oRs.Fields("Descripcion").Value, "Etapas", "Etapas"
            Else
               .Add "O/" & oRs.Fields("IdNodoPadre").Value & "/", tvwChild, "O/" & oRs.Fields("IdCertificacionObras").Value & "/", oRs.Fields("Descripcion").Value, "Etapas", "Etapas"
            End If
            oRs.MoveNext
        Loop
      End If
      .Item("O/").Expanded = True
   End With
   
   oRs.Close
   Set oRs = Nothing

End Sub

Private Sub Arbol_NodeClick(ByVal Node As MSComctlLib.Node)

   Dim mVector
   mVector = VBA.Split(Node.Key, "/")

   If Len(Node.Key) > 0 Then
      If mVector(UBound(mVector) - 1) = "O" Then
          MostrarNodo (Null)
      Else
          MostrarNodo (mVector(UBound(mVector) - 1))
      End If
   End If
   
   If Not Node.Expanded Then Node.Expanded = True

End Sub

Private Sub FileBrowser1_Change(Index As Integer)

   If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
      If Len(Trim(FileBrowser1(Index).Text)) > gblMaximaLongitudAdjuntos Then
         MsgBox "La longitud maxima para un archivo adjunto es de " & gblMaximaLongitudAdjuntos & " caracteres", vbInformation
         FileBrowser1(Index).Text = ""
      Else
         FileBrowser1(Index).InitDir = FileBrowser1(Index).Text
      End If
   End If
   
End Sub

Private Sub FileBrowser1_DblClick(Index As Integer)

   If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
      If Not Len(Trim(Dir(FileBrowser1(Index).Text))) <> 0 Then
         MsgBox "El archivo indicado no existe!", vbExclamation
         Exit Sub
      End If
      Call ShellExecute(Me.hwnd, "open", FileBrowser1(Index).Text, vbNullString, vbNullString, SW_SHOWNORMAL)
   End If

End Sub

Private Sub FileBrowser1_LostFocus(Index As Integer)

   If FileBrowser1(0).Text <> mAdjunto1 Then
      Aplicacion.Tarea "CertificacionesObras_ActualizarPorNumeroCertificado", Array(Me.NumeroCertificado, FileBrowser1(0).Text)
      mAdjunto1 = FileBrowser1(0).Text
   End If

End Sub

Private Sub Form_Load()

   Cant_Columnas = 14
   
   CambiarLenguaje Me, "esp", glbIdiomaActual
   ConfiguraGrilla
   MostrarNodo (0)
   CargarArbol

End Sub

Private Sub Form_Paint()
   
   Degradado Me

End Sub

Private Sub Form_Resize()
   
   Ajustar

End Sub

Sub MostrarNodo(Nodo As Variant)

    If IsNull(Nodo) Then Nodo = 0
    LlenarGrilla Nodo
    fGrid.ZOrder
    txtEdit.ZOrder

End Sub

Sub AgregarEtapa()
    
    EditarNodo -1, TIPO_ETAPA

End Sub

Sub AgregarItem()
    
    EditarNodo -1, TIPO_ARTICULO

End Sub

Sub EditarNodo(ByVal Cual As Long, Optional Tipo As Long)
   
   Dim oF As New frmCertificacionesNodos

   With oF
      .IdCertificacionObras = Cual
      .NodoPadre = IIf(fGrid.TextMatrix(2, COL_NODO) = "", 0, fGrid.TextMatrix(2, COL_NODO))
      .NumeroCertificado = Me.NumeroCertificado
      .IdObra = Me.IdObra
      .Item = IIf(fGrid.TextMatrix(fGrid.row, COL_ITEM) = "", 0, fGrid.TextMatrix(fGrid.row, COL_ITEM))
      .Adjunto1 = FileBrowser1(0).Text
      If Cual = -1 Then .Tipo = Tipo
      .Show vbModal, Me
      If .Aceptado Then
         If Me.NumeroCertificado < 0 Then
            Me.NumeroCertificado = .NumeroCertificado
            Me.IdObra = .IdObra
         End If
         fGrid.TextMatrix(fGrid.row, COL_ITEM) = .Item
      End If
   End With
   Unload oF
   Set oF = Nothing

   MostrarNodo (IIf(fGrid.TextMatrix(2, COL_NODO) = "", 0, fGrid.TextMatrix(2, COL_NODO)))
   CargarArbol

End Sub

Sub EliminarNodo()
    
'    Dim oRs As ADOR.Recordset
'    Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("PresupuestoObrasNodos", "_PorNodoPadre", Array(fGrid.TextMatrix(fGrid.row, COL_NODO), mvarCodigoPresupuesto))
'    If oRs.RecordCount > 1 Then
'        MsgBox "La etapa no está vacía"
'        Exit Sub
'    End If
'
'    Set origen = Aplicacion.PresupuestoObrasNodos.Item(fGrid.TextMatrix(fGrid.row, COL_NODO))
'    origen.Eliminar
'    MostrarNodo (IIf(fGrid.TextMatrix(1, COL_NODO) = "", 0, fGrid.TextMatrix(1, COL_NODO)))

End Sub

Function Fgi(r As Integer, c As Integer) As Integer
   
   Fgi = c + fGrid.Cols * r

End Function

Private Sub fGrid_KeyDown(KeyCode As Integer, Shift As Integer)
    
'    If KeyCode = vbKeyF7 Or KeyCode = vbKeyInsert Then
'        AgregarNodo
'    End If

End Sub

Private Sub fGrid_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
   
   If Button = vbRightButton Then
      With fGrid
         If .MouseRow < .Rows And .MouseCol < .Cols Then
             .row = .MouseRow
             .col = .MouseCol
         End If

'         If .row < 2 Then
'             MnuDetA(0).Enabled = False
'         Else
'             MnuDetA(0).Enabled = True
'         End If
'         If fGrid.TextMatrix(1, COL_DEPTH) = "" Then
'             MnuDetA(0).Enabled = False
'             MnuDetA(1).Enabled = False
'         Else
'             MnuDetA(0).Enabled = True
'             MnuDetA(1).Enabled = True
'         End If
         PopupMenu MnuDet, , , , MnuDetA(0)
      End With
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
        AgregarEtapa
      Case 1
        EditarNodo (fGrid.TextMatrix(fGrid.row, COL_NODO))
      Case 2
        EliminarNodo ' (fGrid.TextMatrix(fGrid.row, COL_NODO))
   End Select

End Sub

Private Sub fGrid_Click()

   If IsNumeric(fGrid.TextMatrix(fGrid.row, COL_NODO)) Then
      Dim mNode As Node
      Dim mVector
      
      For Each mNode In Arbol.Nodes
         If Len(mNode.Key) > 0 Then
            mVector = VBA.Split(mNode.Key, "/")
            If IsNumeric(mVector(UBound(mVector) - 1)) Then
               If fGrid.TextMatrix(fGrid.row, COL_NODO) = mVector(UBound(mVector) - 1) Then
                  Arbol.Nodes.Item(mNode.Key).EnsureVisible
                  Arbol.Nodes.Item(mNode.Key).Selected = True
                  Exit For
               End If
            End If
         End If
      Next
   End If

End Sub

Private Sub fGrid_KeyPress(KeyAscii As Integer)
    
   Dim i As Integer
   With fGrid
      If .col = COL_DESCRIPCION Then
         If KeyAscii = 13 Then fGrid_DblClick
      ElseIf KeyAscii = 6546 Then 'F7
         'AgregarNodo
      ElseIf (.col = COL_CANTIDAD Or .col = COL_IMPORTE) And .row >= 2 Then
         MSHFlexGridEdit fGrid, txtEdit, KeyAscii
      ElseIf .col > Cant_Columnas Then
         i = (.col - Cant_Columnas) Mod 4
         If i = 1 Or i = 3 Then
            MSHFlexGridEdit fGrid, txtEdit, KeyAscii
         End If
      End If
   End With

End Sub

Sub fGrid_DblClick()
    
   Dim linaje As String
   Dim n As MSComctlLib.Node
   Dim vector
   Dim Nodo As Long, i As Long

   On Error Resume Next
   
   With fGrid
      If .row = 2 Then
         'Ir para atrás
         If .TextMatrix(.row, COL_NODOPADRE) <> "" Then
            Nodo = .TextMatrix(.row, COL_NODOPADRE)
            linaje = .TextMatrix(.row, COL_LINEAGE)
'              i = 1
'              For Each n In Arbol.Nodes
'                  If n.Key = "O" & linaje Then Exit For
'                  i = i + 1
'              Next
'              Call Arbol_NodeClick(Arbol.Nodes(i))
            MostrarNodo (Nodo)
         End If
      Else
         If .TextMatrix(.row, COL_TIPO) = "<DIR>" Or .TextMatrix(.row, COL_DEPTH) <= 1 Then
            Nodo = .TextMatrix(.row, COL_NODO)
            linaje = "O" & .TextMatrix(.row, COL_LINEAGE) & .TextMatrix(.row, COL_NODO) & "/"
'              i = 0
'              For Each n In Arbol.Nodes
'                  If n.Key = linaje Then Exit For
'                  i = i + 1
'              Next
'              Call Arbol_NodeClick(Arbol.Nodes(i + 1))
            MostrarNodo (Nodo)
         Else
            EditarNodo (fGrid.TextMatrix(fGrid.row, COL_NODO))
         End If
      End If
   End With

End Sub

Sub fGrid_GotFocus()
   
   If txtEdit.Visible Then
      fGrid = txtEdit.Text
      txtEdit.Visible = False
      SaveCellChange
   ElseIf DataCombo1.Visible Then
      fGrid = DataCombo1.Text
      DataCombo1.Visible = False
      SaveCellChange
   End If

End Sub

Sub fGrid_LeaveCell()
   
   If txtEdit.Visible Then
      fGrid = txtEdit.Text
      txtEdit.Visible = False
      SaveCellChange
   ElseIf DataCombo1.Visible Then
      fGrid = DataCombo1.Text
      DataCombo1.Visible = False
      SaveCellChange
   End If

End Sub

Sub SaveCellChange()
    
   If fGrid.col = COL_CANTIDAD Or fGrid.col = COL_IMPORTE Then
      Set origen = Aplicacion.CertificacionesObras.Item(fGrid.TextMatrix(fGrid.row, COL_NODO))
      Select Case fGrid.col
          Case COL_CANTIDAD
              origen.Registro.Fields("Cantidad").Value = Val(txtEdit.Text)
          Case COL_IMPORTE
              origen.Registro.Fields("Importe").Value = Val(txtEdit.Text)
      End Select
      origen.Guardar
      Aplicacion.Tarea "CertificacionesObras_Recalcular", Me.NumeroCertificado
   
   ElseIf fGrid.col > Cant_Columnas Then
      Dim Mes As Integer, Año As Integer, Pos As Integer, i As Integer, j As Integer
      Dim C1 As Double, C2 As Double, I1 As Double, I2 As Double, mPrecio As Double, mCant As Double
      Dim mAvance As String
      
      C1 = -1
      C2 = -1
      I1 = -1
      I2 = -1
      
      Mes = mId(fGrid.TextMatrix(0, fGrid.col), 1, InStr(1, fGrid.TextMatrix(0, fGrid.col), "/") - 1)
      Año = mId(fGrid.TextMatrix(0, fGrid.col), InStr(1, fGrid.TextMatrix(0, fGrid.col), "/") + 1, 4)
      mAvance = fGrid.TextMatrix(fGrid.row, COL_CANTIDADAVAN)
      mPrecio = Val(fGrid.TextMatrix(fGrid.row, COL_IMPORTE))
      Pos = (fGrid.col - 1 - Cant_Columnas) Mod 4
      Select Case Pos
         Case 0
            C1 = Val(txtEdit.Text)
            If mAvance = "%" Then
               mPrecio = Val(fGrid.TextMatrix(fGrid.row, COL_TOTAL))
               I1 = Round(C1 / 100 * mPrecio, 2)
            Else
               I1 = Round(C1 * mPrecio, 2)
            End If
         Case 1
            I1 = Val(txtEdit.Text)
         Case 2
            C2 = Val(txtEdit.Text)
            If mAvance = "%" Then
               mPrecio = Val(fGrid.TextMatrix(fGrid.row, COL_TOTAL))
               I2 = Round(C2 / 100 * mPrecio, 2)
            Else
               I2 = Round(C2 * mPrecio, 2)
            End If
         Case 3
            I2 = Val(txtEdit.Text)
      End Select
      
      mCant = 0
      For i = Cant_Columnas + 1 To fGrid.Cols - 1
         j = (i - Cant_Columnas) Mod 4
         If (Pos = 0 And j = 1) Or (Pos = 2 And j = 3) Then
            mCant = mCant + Val(fGrid.TextMatrix(fGrid.row, i))
         End If
      Next
      If mAvance = "%" Then
         If mCant > 100 Then
            MsgBox "La suma de las cantidades proyectadas no puede superar el 100%, valor actual : " & mCant & " " & _
                  mAvance, vbExclamation
            GoTo Salida
         End If
      Else
         If mCant > Val(fGrid.TextMatrix(fGrid.row, COL_CANTIDAD)) Then
            MsgBox "La suma de las cantidades proyectadas no puede superar " & _
                  Val(fGrid.TextMatrix(fGrid.row, COL_CANTIDAD)) & ", valor actual : " & mCant & " " & mAvance, vbExclamation
            GoTo Salida
         End If
      End If
      
      Aplicacion.Tarea "CertificacionesObras_ActualizarDetalles", Array(fGrid.TextMatrix(fGrid.row, COL_NODO), Mes, Año, I1, C1, I2, C2)
      Aplicacion.Tarea "CertificacionesObras_Recalcular", Me.NumeroCertificado
   End If

Salida:
   MostrarNodo (IIf(fGrid.TextMatrix(2, COL_NODO) = "", 0, fGrid.TextMatrix(2, COL_NODO)))

End Sub

Sub MSHFlexGridEdit(MSHFlexGrid As Control, Edt As Control, KeyAscii As Integer)

   If TypeOf Edt Is TextBox Then
      Select Case KeyAscii
      ' A space means edit the current text.
         Case 0 To 32
            Edt = MSHFlexGrid
            Edt.SelStart = 1000
      ' Anything else means replace the current text.
         Case Else
            Edt = Chr(KeyAscii)
            Edt.SelStart = 1
      End Select
   End If

   ' Show Edt at the right place.
   With MSHFlexGrid
      Edt.Move .Left + ScaleX(.CellLeft, vbTwips, .Container.ScaleMode), _
         .Top + ScaleY(.CellTop, vbTwips, .Container.ScaleMode), _
          ScaleX(.CellWidth - 8, vbTwips, .Container.ScaleMode), _
         ScaleY(.CellHeight - 8, vbTwips, .Container.ScaleMode)
    End With

   Edt.Visible = True
   Edt.SetFocus

End Sub

Private Sub Split_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbLeftButton Then
      With Split
         .Move .Left + X
      End With
   End If

End Sub

Private Sub Split_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbLeftButton Then
      Ajustar
   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Key
      Case "Excel"
        InformeCertificacion1
      Case "Informe"
        InformeCertificacion
      Case "Importar"
        ImportarCertificado
   End Select

End Sub

Sub txtEdit_KeyPress(KeyAscii As Integer)
   
   ' Delete returns to get rid of beep.
   If KeyAscii = Asc(vbCr) Then KeyAscii = 0

End Sub

Sub txtEdit_KeyDown(KeyCode As Integer, Shift As Integer)
   
   EditKeyCode fGrid, txtEdit, KeyCode, Shift

End Sub

Sub EditKeyCode(MSHFlexGrid As Control, Edt As Control, KeyCode As Integer, Shift As Integer)

   ' Standard edit control processing.
   Select Case KeyCode
      Case 27   ' ESC: hide, return focus to MSHFlexGrid.
         Edt.Visible = False
         MSHFlexGrid.SetFocus
   
      Case 13   ' ENTER return focus to MSHFlexGrid.
         MSHFlexGrid.SetFocus
   
      Case 38      ' Up.
         MSHFlexGrid.SetFocus
         DoEvents
         If MSHFlexGrid.row > MSHFlexGrid.FixedRows Then
            MSHFlexGrid.row = MSHFlexGrid.row - 1
         End If
   
      Case 40      ' Down.
         MSHFlexGrid.SetFocus
         DoEvents
         If MSHFlexGrid.row < MSHFlexGrid.Rows - 1 Then
            MSHFlexGrid.row = MSHFlexGrid.row + 1
         End If
   End Select

End Sub

Sub ConfiguraGrilla()
   
   Dim i As Integer, j As Integer, k As Integer, mCol As Integer
   Dim mFecha As Date
   
   With fGrid
      .FixedRows = 2
      .FixedCols = 0
      .Cols = Cant_Columnas + 1 + 144
      
      .MergeCells = flexMergeRestrictRows
      
      .ColWidth(COL_NODO) = ANCHO_COL_ID
      .ColWidth(COL_NODOPADRE) = ANCHO_COL_ID
      .ColWidth(COL_ANO) = ANCHO_COL_ID
      .ColWidth(COL_DEPTH) = ANCHO_COL_ID
      .ColWidth(COL_IDARTICULO) = ANCHO_COL_ID
      .ColWidth(COL_LINEAGE) = ANCHO_COL_ID
      .ColWidth(COL_OBRA) = ANCHO_COL_ID
      .ColWidth(COL_ITEM) = 400
      
      .ColWidth(COL_DESCRIPCION) = 4000
      .ColWidth(COL_TIPO) = 800
      .ColWidth(COL_CANTIDADAVAN) = 400
      .ColWidth(COL_CANTIDAD) = 1200
      .ColWidth(COL_IMPORTE) = 1500
      .ColWidth(COL_UNIMEDIDA) = 400
      .ColWidth(COL_TOTAL) = 1500
      
      .TextMatrix(0, COL_NODO) = "Nodo"
      .TextMatrix(0, COL_NODOPADRE) = "Nodo padre"
      .TextMatrix(0, COL_ANO) = "Año"
      .TextMatrix(0, COL_DEPTH) = "Depth"
      .TextMatrix(0, COL_IDARTICULO) = "IdArticulo"
      .TextMatrix(0, COL_LINEAGE) = "Lineage"
      .TextMatrix(0, COL_DESCRIPCION) = "Descripción"
      .TextMatrix(0, COL_CANTIDADAVAN) = "Avance"
      .TextMatrix(0, COL_CANTIDAD) = "Cantidad"
      .TextMatrix(0, COL_IMPORTE) = "Precio"
      .TextMatrix(0, COL_UNIMEDIDA) = "Un."
      .TextMatrix(0, COL_TIPO) = "Tipo"
      .TextMatrix(0, COL_IDARTICULO) = "Artículo"
      .TextMatrix(0, COL_TOTAL) = "Total"
      .TextMatrix(0, COL_OBRA) = "IdObra"
      .TextMatrix(0, COL_ITEM) = "Item"
   
      .ColAlignment(COL_DESCRIPCION) = flexAlignLeftCenter
   
      For i = 1 To 36
         mFecha = DateAdd("m", i - 1, Me.FechaInicialObra)
         For j = 1 To 4
            mCol = (i - 1) * 4 + j
            Select Case j
               Case 1
                  .TextMatrix(0, mCol + Cant_Columnas) = "" & Month(mFecha) & "/" & Year(mFecha)
                  .TextMatrix(1, mCol + Cant_Columnas) = "% Presup."
                  For k = 2 To .Rows - 1
                     .row = k
                     .col = mCol + Cant_Columnas
                     .CellBackColor = &HFFFFC0
                  Next
               Case 2
                  .TextMatrix(0, mCol + Cant_Columnas) = "" & Month(mFecha) & "/" & Year(mFecha)
                  .TextMatrix(1, mCol + Cant_Columnas) = "Imp. Presupuesto"
               Case 3
                  .TextMatrix(0, mCol + Cant_Columnas) = "" & Month(mFecha) & "/" & Year(mFecha)
                  .TextMatrix(1, mCol + Cant_Columnas) = "% Real"
                  For k = 2 To .Rows - 1
                     .row = k
                     .col = mCol + Cant_Columnas
                     .CellBackColor = &HC0FFC0
                  Next
               Case 4
                  .TextMatrix(0, mCol + Cant_Columnas) = "" & Month(mFecha) & "/" & Year(mFecha)
                  .TextMatrix(1, mCol + Cant_Columnas) = "Imp. Real"
            End Select
            If mFecha > Me.FechaFinalObra Then
               .ColWidth(mCol + Cant_Columnas) = 0
            Else
               If j = 1 Or j = 3 Then
                  .ColWidth(mCol + Cant_Columnas) = 800
               Else
                  .ColWidth(mCol + Cant_Columnas) = 1400
               End If
            End If
            .row = 0
            .col = mCol + Cant_Columnas
            .CellAlignment = flexAlignCenterCenter
         Next
      Next
      .MergeRow(0) = True
   End With

End Sub

Public Function LlenarGrilla(ByVal Nodo As Long) As Boolean

   On Error GoTo ErrorHandler

   Dim i As Integer, j As Integer, mCol As Integer
   Dim tempc As Long, tempr As Long, PosI_R As Long, PosI_C As Long
   Dim EsRaiz As Boolean
   Dim oRs As ADODB.Recordset
   Dim oRs1 As ADODB.Recordset

   EsRaiz = False
   If Nodo = 0 Then EsRaiz = True

   Set oRs = Aplicacion.CertificacionesObras.TraerFiltrado("_PorNodo", Array(Me.NumeroCertificado, Nodo))
   
   With fGrid
      PosI_R = .row
      PosI_C = .col
      
      .Redraw = False
      .Clear

      .Rows = 3
      If Not oRs.EOF Then
         If EsRaiz Then
            .Rows = oRs.RecordCount + 3
            i = 3
         Else
            .Rows = oRs.RecordCount + 2
            i = 2
         End If
         Do While Not oRs.EOF
            .TextMatrix(i, COL_NODO) = oRs.Fields("IdCertificacionObras").Value
            '.CellBackColor = &HFFC0C0
            .TextMatrix(i, COL_NODOPADRE) = iisnull(oRs.Fields("IdNodoPadre").Value, 0)
            .TextMatrix(i, COL_DEPTH) = oRs.Fields("Depth").Value
            .TextMatrix(i, COL_LINEAGE) = oRs.Fields("Lineage").Value
            .TextMatrix(i, COL_OBRA) = oRs.Fields("IdObra").Value
            .TextMatrix(i, COL_ITEM) = IIf(IsNull(oRs.Fields("Item").Value), "", oRs.Fields("Item").Value)
            .TextMatrix(i, COL_CANTIDAD) = iisnull(oRs.Fields("Cantidad").Value, 0)
            .TextMatrix(i, COL_UNIMEDIDA) = iisnull(oRs.Fields("Unidad").Value, "")
            .TextMatrix(i, COL_IMPORTE) = iisnull(oRs.Fields("Importe").Value, 0)
            .TextMatrix(i, COL_TOTAL) = iisnull(oRs.Fields("Cantidad").Value, 0) * iisnull(oRs.Fields("Importe").Value, 0)
            .TextMatrix(i, COL_DESCRIPCION) = iisnull(oRs.Fields("Descripcion").Value, "")
            .TextMatrix(i, COL_CANTIDADAVAN) = iisnull(oRs.Fields("UnidadAvance1").Value, "")
            .TextMatrix(i, COL_TIPO) = "<DIR>"
            If iisnull(.TextMatrix(i, COL_TOTAL), 0) <= 0 Then
               .row = i
               .col = COL_TOTAL
               .CellBackColor = &HFF&
            End If
            
            Set oRs1 = Aplicacion.CertificacionesObras.TraerFiltrado("_DetallePxQ", oRs.Fields(0).Value)
            If oRs1.RecordCount > 0 Then
               Do While Not oRs1.EOF
                  j = DateDiff("m", Me.FechaInicialObra, DateSerial(oRs1.Fields("Año").Value, oRs1.Fields("Mes").Value, 1))
                  mCol = Cant_Columnas + (j * 4)
                  .TextMatrix(i, mCol + 1) = IIf(IsNull(oRs1.Fields("Cantidad").Value), "", oRs1.Fields("Cantidad").Value)
                  .TextMatrix(i, mCol + 2) = IIf(IsNull(oRs1.Fields("Importe").Value), "", oRs1.Fields("Importe").Value)
                  .TextMatrix(i, mCol + 3) = IIf(IsNull(oRs1.Fields("CantidadAvance").Value), "", oRs1.Fields("CantidadAvance").Value)
                  .TextMatrix(i, mCol + 4) = IIf(IsNull(oRs1.Fields("ImporteAvance").Value), "", oRs1.Fields("ImporteAvance").Value)
                  oRs1.MoveNext
              Loop
            End If
            oRs1.Close
            
            i = i + 1
            oRs.MoveNext
         Loop
      End If

      ConfiguraGrilla
      .TextMatrix(2, COL_DESCRIPCION) = "[..]"
      .Redraw = True
      .row = PosI_R
      .col = PosI_C
    End With
    
    Set oRs = Nothing
    Set oRs1 = Nothing

    Exit Function

ErrorHandler:
    Exit Function

End Function

Public Property Get NumeroCertificado() As Long

   NumeroCertificado = mNumeroCertificado

End Property

Public Property Let NumeroCertificado(ByVal vNewValue As Long)

   mNumeroCertificado = vNewValue
   
   Dim oRs As ADOR.Recordset
   
   If mNumeroCertificado > 0 Then
      Set oRs = Aplicacion.CertificacionesObras.TraerFiltrado("_PorNumeroCertificado", mNumeroCertificado)
      If oRs.RecordCount > 0 Then
         Me.IdObra = IIf(IsNull(oRs.Fields("IdObra").Value), -1, oRs.Fields("IdObra").Value)
         mAdjunto1 = IIf(IsNull(oRs.Fields("Adjunto1").Value), "", oRs.Fields("Adjunto1").Value)
         FileBrowser1(0).Text = mAdjunto1
      End If
      oRs.Close
      txtNumero.Text = mNumeroCertificado
   End If
   
   Set oRs = Nothing

End Property

Public Property Get IdObra() As Long

   IdObra = mIdObra

End Property

Public Property Let IdObra(ByVal vNewValue As Long)

   mIdObra = vNewValue
   
   Dim oRs As ADOR.Recordset
   Dim mFechaInicial As Date, mFechaFinal As Date
   
   mFechaInicial = Date
   mFechaFinal = Date
   If mIdObra > 0 Then
      Set oRs = Aplicacion.Obras.TraerFiltrado("_PorId", mIdObra)
      If oRs.RecordCount > 0 Then
         If Not IsNull(oRs.Fields("FechaInicio").Value) Then mFechaInicial = oRs.Fields("FechaInicio").Value
         If Not IsNull(oRs.Fields("FechaEntrega").Value) Then mFechaFinal = oRs.Fields("FechaEntrega").Value
         Me.Obra = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
      End If
      oRs.Close
   End If
   Me.FechaInicialObra = DateSerial(Year(mFechaInicial), Month(mFechaInicial), 1)
   Me.FechaFinalObra = mFechaFinal
   
   Set oRs = Nothing

End Property

Public Property Get Obra() As String

   Obra = mObra

End Property

Public Property Let Obra(ByVal vNewValue As String)

   mObra = vNewValue

End Property

Public Property Get FechaInicialObra() As Date

   FechaInicialObra = mFechaInicialObra

End Property

Public Property Let FechaInicialObra(ByVal vNewValue As Date)

   mFechaInicialObra = vNewValue

End Property

Public Property Get FechaFinalObra() As Date

   FechaFinalObra = mFechaFinalObra

End Property

Public Property Let FechaFinalObra(ByVal vNewValue As Date)

   mFechaFinalObra = vNewValue

End Property

Public Sub InformeCertificacion()

   Dim oEx As Excel.Application
   Dim oF As frm_Aux
   Dim mMes As Integer, mAño As Integer
   Dim mOk As Boolean
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Mes"
      .Label1.Caption = "Mes :"
      With .Label2(1)
         .Caption = "Año :"
         .Visible = True
      End With
      .Text1.Text = Month(Date)
      With .Text2
         .Left = oF.DTFields(1).Left
         .Top = oF.DTFields(1).Top
         .Width = oF.Text1.Width
         .Text = Year(Date)
         .Visible = True
      End With
      .Show vbModal, Me
      mOk = .Ok
      If .Ok Then
         mMes = Val(.Text1.Text)
         mAño = Val(.Text2.Text)
      End If
   End With
   Set oF = Nothing
   
   If Not mOk Then Exit Sub
   
   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      With .Workbooks.Add(glbPathPlantillas & "\ComprasTerceros.xlt")
         oEx.Run "CertificadoObra", glbStringConexion, Me.IdObra, "" & mMes & "|" & mAño & "|" & Me.NumeroCertificado
      End With
   End With
   Set oEx = Nothing
   
End Sub

Public Sub InformeCertificacion1()

   Dim oEx As Excel.Application

   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      With .Workbooks.Add(glbPathPlantillas & "\ComprasTerceros.xlt")
         oEx.Run "CertificadoObra1", glbStringConexion, "" & Me.IdObra & "|" & Me.NumeroCertificado
      End With
   End With
   Set oEx = Nothing
   
End Sub

Public Sub ImportarCertificado()

   Dim oAp As ComPronto.Aplicacion
   Dim oCert As ComPronto.CertificacionObra
   Dim oRsAux1 As ADOR.Recordset
   Dim oEx As Excel.Application
   Dim oF As Form
   Dim mOk As Boolean
   Dim mArchivo As String, mError As String, mObra As String, mItem As String, mItem1 As String, mCodigo As String
   Dim mDescripcion As String, mFecha As String, mLineage As String
   Dim fl As Integer, i As Integer, mMes As Integer, mAño As Integer, mNumeroCertificado As Integer
   Dim mIdObra As Long, mIdUnidad As Long, mIdCertificacionObras As Long, mIdNodoPadre As Long
   Dim mImporte As Double, mCantidad As Double, mPorcentaje As Double, mTotal As Double
   Dim mVector

'   On Error GoTo Mal

   Set oF = New frmPathPresto
   With oF
      .Id = 18
      .Show vbModal
      mOk = .Ok
      mArchivo = .FileBrowser1(0).Text
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then Exit Sub

   Set oF = New frmAviso
   With oF
      .Label1 = "Iniciando EXCEL ..."
      .Show
      .Refresh
      DoEvents
   End With

   oF.Label1 = oF.Label1 & vbCrLf & "Importando certificado ..."
   oF.Label2 = ""
   oF.Label3 = ""
   DoEvents

   Set oAp = Aplicacion
   
   mError = ""
   
   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      .WindowState = xlMinimized
      Me.Refresh
      
      With .Workbooks.Open(mArchivo)
         'oEx.Sheets("Economico").Select
         With .ActiveSheet
            mObra = .Cells(3, 4)
            Set oRsAux1 = oAp.Obras.TraerFiltrado("_PorNumero", mObra)
            mIdObra = 0
            If oRsAux1.RecordCount > 0 Then
               mIdObra = oRsAux1.Fields(0).Value
            Else
               oRsAux1.Close
               MsgBox "Obra no definida o inexistente, la importacion no puede realizarse", vbExclamation
               GoTo Salida
            End If
            oRsAux1.Close
            
            If IsNumeric(.Cells(4, 4)) Then
               mNumeroCertificado = Val(.Cells(4, 4))
            Else
               MsgBox "No existe numero de certificado, la importacion no puede realizarse", vbExclamation
               GoTo Salida
            End If
            
            fl = 8
            Do While True
               If Len(Trim(.Cells(fl, 1))) > 0 Then
                  mItem = .Cells(fl, 2)
                  mDescripcion = .Cells(fl, 3)
                  mCantidad = Val(.Cells(fl, 4))
                  mImporte = Val(.Cells(fl, 5))
                  mVector = VBA.Split(mItem, ".")
                  mItem1 = ""
                  For i = 0 To UBound(mVector)
                     mItem1 = mItem1 & mVector(i) & "."
                  Next
                  If Len(mItem1) > 0 Then mItem1 = mId(mItem1, 1, Len(mItem1) - 1)
                  
                  oF.Label2 = "Item : " & mItem & " " & mDescripcion
                  DoEvents
                  
                  mIdCertificacionObras = -1
                  Set oRsAux1 = oAp.CertificacionesObras.TraerFiltrado("_PorNumeroCertificado", Array(mNumeroCertificado, mIdObra, mItem))
                  If oRsAux1.RecordCount > 0 Then
                     mIdCertificacionObras = oRsAux1.Fields(0).Value
                  End If
                  oRsAux1.Close
                  
                  Set oCert = oAp.CertificacionesObras.Item(mIdCertificacionObras)
                  With oCert
                     With .Registro
                        If mIdCertificacionObras <= 0 Then
                           If UBound(mVector) = 1 Then
                              .Fields("IdNodoPadre").Value = Null
                           Else
                              mIdNodoPadre = 0
                              Set oRsAux1 = oAp.CertificacionesObras.TraerFiltrado("_PorNumeroCertificado", Array(mNumeroCertificado, mIdObra, mItem1))
                              If oRsAux1.RecordCount > 0 Then
                                 mIdNodoPadre = oRsAux1.Fields(0).Value
                              End If
                              oRsAux1.Close
                              .Fields("IdNodoPadre").Value = mIdNodoPadre
                           End If
                           .Fields("Lineage").Value = mLineage
                           .Fields("Depth").Value = UBound(mVector)
                           .Fields("TipoNodo").Value = 3
                           .Fields("IdObra").Value = mIdObra
                           .Fields("Descripcion").Value = mDescripcion
                           .Fields("TipoPartida").Value = 1
                           .Fields("IdUnidad").Value = Null
                           .Fields("UnidadAvance").Value = "%"
                           .Fields("NumeroCertificado").Value = mNumeroCertificado
                           .Fields("Item").Value = mItem
                           .Fields("Adjunto1").Value = Null
                        End If
                        .Fields("Cantidad").Value = mCantidad
                        .Fields("Importe").Value = mImporte
                     End With
                     .Guardar
                  End With
                  Set oCert = Nothing
               Else
                  Exit Do
               End If
               fl = fl + 1
            Loop
         End With
         .Close False
      End With
      .Quit
   End With
   
Salida:

   Unload oF
   Set oF = Nothing

   If Len(mError) > 0 Then
      mError = "El proceso ha concluido con los siguientes errores :" & vbCrLf & mError
      Set oF = New frmConsulta1
      With oF
         .Id = 15
         oF.rchTexto.Text = mError
         .Show vbModal, Me
      End With
      Unload oF
      Set oF = Nothing
   End If

   Set oRsAux1 = Nothing
   Set oEx = Nothing
   Set oAp = Nothing

   Exit Sub

Mal:

   MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   Resume Salida

End Sub
