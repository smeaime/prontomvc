VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmSubcontratos 
   Caption         =   "Subcontratos"
   ClientHeight    =   6690
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   13620
   LinkTopic       =   "Form1"
   ScaleHeight     =   6690
   ScaleWidth      =   13620
   Begin VB.CommandButton cmdLista 
      Caption         =   "X"
      Height          =   240
      Left            =   135
      TabIndex        =   14
      Top             =   4770
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox Split1 
      Height          =   50
      Left            =   45
      MousePointer    =   7  'Size N S
      ScaleHeight     =   2.25
      ScaleMode       =   2  'Point
      ScaleWidth      =   174.75
      TabIndex        =   13
      Top             =   4410
      Visible         =   0   'False
      Width           =   3500
   End
   Begin VB.PictureBox Split 
      Height          =   3750
      Left            =   3510
      MousePointer    =   9  'Size W E
      ScaleHeight     =   187.5
      ScaleMode       =   2  'Point
      ScaleWidth      =   2.25
      TabIndex        =   8
      Top             =   585
      Width           =   50
   End
   Begin VB.TextBox txtEdit 
      BorderStyle     =   0  'None
      Height          =   375
      Left            =   765
      TabIndex        =   3
      Top             =   5715
      Visible         =   0   'False
      Width           =   975
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   2205
      Top             =   4995
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   14
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":0000
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":0112
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":0224
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":0336
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":0448
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":055A
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":066C
            Key             =   "Excel"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":0ABE
            Key             =   "Project"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":1058
            Key             =   "Importar"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":15F2
            Key             =   "Informe"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":1B8C
            Key             =   "DatosSubcontrato"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":2466
            Key             =   "Excel1"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":2D40
            Key             =   "Libre"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":361A
            Key             =   "HojaRuta"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList img16 
      Left            =   2790
      Top             =   4995
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
            Picture         =   "frmSubcontratos.frx":3EF4
            Key             =   "Abierto1"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":4346
            Key             =   "Cerrado1"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":4798
            Key             =   "Cerrado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":4BEA
            Key             =   "Abierto"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":503C
            Key             =   "Obras"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":55D6
            Key             =   "Etapas"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":5B70
            Key             =   "Rubros"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":610A
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubcontratos.frx":66A4
            Key             =   "Opciones"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   13620
      _ExtentX        =   24024
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel"
            Object.ToolTipText     =   "Exportar subcontrato a Excel"
            ImageKey        =   "Excel"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel1"
            Object.ToolTipText     =   "Etapas y consumos"
            ImageKey        =   "Excel1"
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "DatosSubcontrato"
            Object.ToolTipText     =   "Ver datos del subcontrato"
            ImageKey        =   "DatosSubcontrato"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "HojaRuta"
            Object.ToolTipText     =   "Hoja de ruta (Excel)"
            ImageKey        =   "HojaRuta"
         EndProperty
      EndProperty
      Begin VB.CheckBox Check1 
         Alignment       =   1  'Right Justify
         Caption         =   "Ver detalle de comprobantes"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   12555
         TabIndex        =   11
         Top             =   45
         Width           =   1275
      End
      Begin VB.TextBox txtFechas 
         Appearance      =   0  'Flat
         BackColor       =   &H80000000&
         Height          =   285
         Left            =   8145
         Locked          =   -1  'True
         TabIndex        =   10
         Top             =   45
         Width           =   4290
      End
      Begin VB.TextBox Text1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000000&
         Height          =   285
         Index           =   1
         Left            =   1665
         Locked          =   -1  'True
         TabIndex        =   9
         Text            =   "Subcontrato nro. :"
         Top             =   45
         Width           =   1275
      End
      Begin VB.TextBox txtProveedor 
         Appearance      =   0  'Flat
         BackColor       =   &H80000000&
         Height          =   285
         Left            =   3915
         TabIndex        =   7
         Top             =   45
         Width           =   4110
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
         TabIndex        =   6
         Top             =   45
         Width           =   780
      End
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   1
      Top             =   6300
      Width           =   13620
      _ExtentX        =   24024
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   5
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   10001
            Key             =   "Mensaje"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   10001
            Picture         =   "frmSubcontratos.frx":6C3E
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
            TextSave        =   "14/07/2009"
            Key             =   "Fecha"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Left            =   1845
      TabIndex        =   2
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
   Begin MSComctlLib.TreeView Arbol 
      Height          =   3390
      Left            =   90
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
      Left            =   3600
      TabIndex        =   5
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
   Begin Controles1013.DbListView ListaDetalle 
      Height          =   1185
      Left            =   3375
      TabIndex        =   12
      Top             =   5535
      Visible         =   0   'False
      Width           =   2085
      _ExtentX        =   3678
      _ExtentY        =   2090
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmSubcontratos.frx":6F58
      MultiSelect     =   0   'False
      OLEDragMode     =   1
      PictureAlignment=   5
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
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
Attribute VB_Name = "frmSubcontratos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim WithEvents origen As ComPronto.Subcontrato
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
Const COL_NUMERO = 14

Const ANCHO_COL_ID = 0

Const TIPO_OBRA = 1
Const TIPO_PRESUPUESTO = 2
Const TIPO_ETAPA = 3
Const TIPO_ARTICULO = 4
Const TIPO_RUBRO = 5

Dim actL2 As ControlForm
Private ultimaopcion As String, mDescripcionSubcontrato As String
Private Cant_Columnas As Integer
Private mNumeroSubcontrato As Long, mIdProveedor As Long
Private mFechaInicial As Date, mFechaFinalizacion As Date
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

   Me.NumeroSubcontrato = vNewValue

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
      If ListaDetalle.Visible Then
         .Height = Altura * 0.7
      Else
         .Height = Altura
      End If
      .Left = Arbol.Left + Arbol.Width + Split.Width
      .Width = Ancho - .Left
  End With
   
   If ListaDetalle.Visible Then
      With Split1
         If Not .Visible Then
            .Top = fGrid.Top + fGrid.Height
            .Visible = True
         End If
         .Left = fGrid.Left
         .Width = fGrid.Width
      End With
      With ListaDetalle
         .Top = Split1.Top + Split1.Height
         .Height = (Altura * 0.3) - Split1.Height
         .Left = fGrid.Left
         .Width = fGrid.Width
      End With
      With cmdLista
         .Top = ListaDetalle.Top
         .Left = ListaDetalle.Left + ListaDetalle.Width - .Width
         .Visible = True
      End With
   End If
   
End Sub

Private Sub CargarArbol()

   Dim oRs As ADOR.Recordset
   
   Set oRs = Aplicacion.Subcontratos.TraerFiltrado("_ParaArbol", Me.NumeroSubcontrato)
   
   With Arbol.Nodes
      .Clear
      .Add , , "O/", Me.DescripcionSubcontrato, "Obras", "Obras"
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If IsNull(oRs.Fields("IdNodoPadre").Value) Then
               .Add "O/", tvwChild, "O/" & oRs.Fields("IdSubcontrato").Value & "/", oRs.Fields("Descripcion").Value, "Etapas", "Etapas"
            Else
               .Add "O/" & oRs.Fields("IdNodoPadre").Value & "/", tvwChild, "O/" & oRs.Fields("IdSubcontrato").Value & "/", oRs.Fields("Descripcion").Value, "Etapas", "Etapas"
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

Private Sub Check1_Click()

   If Check1.Value = 1 Then
      ListaDetalle.Visible = True
   Else
      Split1.Visible = False
      ListaDetalle.Visible = False
      cmdLista.Visible = False
   End If
   Ajustar

End Sub

Private Sub cmdLista_Click()

   Check1.Value = 0

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
      If ListaDetalle.Visible Then
         Set ListaDetalle.DataSource = Aplicacion.Subcontratos.TraerFiltrado("_Consumos", fGrid.TextMatrix(fGrid.row, COL_NODO))
      End If
   End If

End Sub

Private Sub Form_Load()

   Cant_Columnas = 14
   
   CambiarLenguaje Me, "esp", glbIdiomaActual
   
   Dim mSalir As Boolean
   If Me.NumeroSubcontrato <= 0 Then mSalir = Not EditarDatosSubcontrato
   
   If Not mSalir Then
      ConfiguraGrilla
      MostrarNodo (0)
      CargarArbol
   Else
      Unload Me
   End If

End Sub

Private Sub Form_Paint()
   
   Degradado Me

End Sub

Private Sub Form_Resize()
   
   Ajustar

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set origen = Nothing

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
   
   Dim oF As New frmSubcontratosNodos

   With oF
      .IdSubcontrato = Cual
      .NodoPadre = IIf(fGrid.TextMatrix(2, COL_NODO) = "", 0, fGrid.TextMatrix(2, COL_NODO))
      .NumeroSubcontrato = Me.NumeroSubcontrato
      If Cual = -1 Then .Tipo = Tipo
      .Show vbModal, Me
   End With
   Unload oF
   Set oF = Nothing

   MostrarNodo (IIf(fGrid.TextMatrix(2, COL_NODO) = "", 0, fGrid.TextMatrix(2, COL_NODO)))
   CargarArbol

End Sub

Sub EliminarNodo()
    
   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.Subcontratos.TraerFiltrado("_PorNodoPadre", fGrid.TextMatrix(fGrid.row, COL_NODO))
   If oRs.RecordCount > 0 Then
       MsgBox "La etapa no está vacía"
       GoTo Salida
   End If

   Set origen = Aplicacion.Subcontratos.Item(fGrid.TextMatrix(fGrid.row, COL_NODO))
   origen.Eliminar
   Aplicacion.Tarea "Subcontratos_Recalcular", Me.NumeroSubcontrato
   
   MostrarNodo (IIf(fGrid.TextMatrix(1, COL_NODO) = "", 0, fGrid.TextMatrix(1, COL_NODO)))
   CargarArbol

Salida:
   Set oRs = Nothing

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

Private Sub ListaDetalle_DblClick()

   If Len(ListaDetalle.SelectedItem.SubItems(1)) > 0 And Len(ListaDetalle.SelectedItem.SubItems(2)) > 0 Then
      EditarComprobante ListaDetalle.SelectedItem.SubItems(1), ListaDetalle.SelectedItem.SubItems(2)
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

Private Sub Split1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

'   If Button = vbLeftButton Then
'      With Split1
'         .Move .Left, .Top + Y
'      End With
'   End If

End Sub

Private Sub Split1_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbLeftButton Then Ajustar

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Key
      Case "Excel"
        InformeSubcontrato
      Case "Excel1"
        InformeSubcontrato1
      Case "DatosSubcontrato"
         EditarDatosSubcontrato
      Case "HojaRuta"
         HojaRuta
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
      Set origen = Aplicacion.Subcontratos.Item(fGrid.TextMatrix(fGrid.row, COL_NODO))
      Select Case fGrid.col
          Case COL_CANTIDAD
              origen.Registro.Fields("Cantidad").Value = Val(txtEdit.Text)
          Case COL_IMPORTE
              origen.Registro.Fields("Importe").Value = Val(txtEdit.Text)
      End Select
      origen.Guardar
      Aplicacion.Tarea "Subcontratos_Recalcular", Me.NumeroSubcontrato
   
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
      
      Aplicacion.Tarea "Subcontratos_ActualizarDetalles", Array(fGrid.TextMatrix(fGrid.row, COL_NODO), Mes, Año, I1, C1, I2, C2)
   End If

Salida:
   MostrarNodo (IIf(fGrid.TextMatrix(2, COL_NODO) = "", 0, fGrid.TextMatrix(2, COL_NODO)))

End Sub

Sub ConfiguraGrilla()
   
   Dim i As Integer, j As Integer, mCol As Integer
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
      .ColWidth(COL_LINEAGE) = ANCHO_COL_ID
      .ColWidth(COL_OBRA) = ANCHO_COL_ID
      .ColWidth(COL_NUMERO) = ANCHO_COL_ID
      
      .ColWidth(COL_DESCRIPCION) = 4000
      .ColWidth(COL_ITEM) = 800
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
      .TextMatrix(0, COL_LINEAGE) = "Lineage"
      .TextMatrix(0, COL_OBRA) = "IdObra"
      
      .TextMatrix(0, COL_DESCRIPCION) = "Descripción"
      .TextMatrix(0, COL_CANTIDADAVAN) = "Avance"
      .TextMatrix(0, COL_CANTIDAD) = "Cantidad"
      .TextMatrix(0, COL_IMPORTE) = "Precio"
      .TextMatrix(0, COL_UNIMEDIDA) = "Un."
      .TextMatrix(0, COL_TIPO) = "Tipo"
      .TextMatrix(0, COL_ITEM) = "Item"
      .TextMatrix(0, COL_TOTAL) = "Total"
   
      .ColAlignment(COL_DESCRIPCION) = flexAlignLeftCenter
   
      For i = 1 To 36
         mFecha = DateAdd("m", i - 1, Me.FechaInicial)
         For j = 1 To 4
            mCol = (i - 1) * 4 + j
            Select Case j
               Case 1
                  .TextMatrix(0, mCol + Cant_Columnas) = "" & Month(mFecha) & "/" & Year(mFecha)
                  .TextMatrix(1, mCol + Cant_Columnas) = "Cant. Presupuesto"
               Case 2
                  .TextMatrix(0, mCol + Cant_Columnas) = "" & Month(mFecha) & "/" & Year(mFecha)
                  .TextMatrix(1, mCol + Cant_Columnas) = "Imp. Presupuesto"
               Case 3
                  .TextMatrix(0, mCol + Cant_Columnas) = "" & Month(mFecha) & "/" & Year(mFecha)
                  .TextMatrix(1, mCol + Cant_Columnas) = "Cant. Real"
               Case 4
                  .TextMatrix(0, mCol + Cant_Columnas) = "" & Month(mFecha) & "/" & Year(mFecha)
                  .TextMatrix(1, mCol + Cant_Columnas) = "Imp. Real"
            End Select
            If mFecha <= Me.FechaFinalizacion Then
               .ColWidth(mCol + Cant_Columnas) = 1400
            Else
               .ColWidth(mCol + Cant_Columnas) = 0
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

   Set oRs = Aplicacion.Subcontratos.TraerFiltrado("_PorNodo", Array(Me.NumeroSubcontrato, Nodo))
   
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
            .TextMatrix(i, COL_NODO) = oRs.Fields("IdSubcontrato").Value
            '.CellBackColor = &HFFC0C0
            .TextMatrix(i, COL_NODOPADRE) = iisnull(oRs.Fields("IdNodoPadre").Value, 0)
            .TextMatrix(i, COL_DEPTH) = oRs.Fields("Depth").Value
            .TextMatrix(i, COL_LINEAGE) = oRs.Fields("Lineage").Value
            .TextMatrix(i, COL_NUMERO) = oRs.Fields("NumeroSubcontrato").Value
            .TextMatrix(i, COL_CANTIDAD) = iisnull(oRs.Fields("Cantidad").Value, 0)
            .TextMatrix(i, COL_UNIMEDIDA) = iisnull(oRs.Fields("Unidad").Value, "")
            .TextMatrix(i, COL_IMPORTE) = iisnull(oRs.Fields("Importe").Value, 0)
            .TextMatrix(i, COL_TOTAL) = iisnull(oRs.Fields("Cantidad").Value, 0) * iisnull(oRs.Fields("Importe").Value, 0)
            .TextMatrix(i, COL_DESCRIPCION) = iisnull(oRs.Fields("Descripcion").Value, "")
            .TextMatrix(i, COL_CANTIDADAVAN) = iisnull(oRs.Fields("UnidadAvance1").Value, "")
            .TextMatrix(i, COL_ITEM) = iisnull(oRs.Fields("Item").Value, "")
            .TextMatrix(i, COL_TIPO) = "<DIR>"
            If iisnull(.TextMatrix(i, COL_TOTAL), 0) <= 0 Then
               tempc = .col
               tempr = .row
               .row = i
               .col = COL_TOTAL
               .CellBackColor = &HFF&
               .col = tempc
               .row = tempr
            End If
            
            Set oRs1 = Aplicacion.Subcontratos.TraerFiltrado("_DetallePxQ", oRs.Fields(0).Value)
            If oRs1.RecordCount > 0 Then
               Do While Not oRs1.EOF
                 j = DateDiff("m", Me.FechaInicial, DateSerial(oRs1.Fields("Año").Value, oRs1.Fields("Mes").Value, 1))
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

Public Property Get NumeroSubcontrato() As Long

   NumeroSubcontrato = mNumeroSubcontrato

End Property

Public Property Let NumeroSubcontrato(ByVal vNewValue As Long)

   mNumeroSubcontrato = vNewValue
   
   If mNumeroSubcontrato > 0 Then MostrarDatosDelSubcontrato mNumeroSubcontrato

End Property

Public Property Get DescripcionSubcontrato() As String

   DescripcionSubcontrato = mDescripcionSubcontrato

End Property

Public Property Let DescripcionSubcontrato(ByVal vNewValue As String)

   mDescripcionSubcontrato = vNewValue

End Property

Public Property Get FechaInicial() As Date

   FechaInicial = mFechaInicial

End Property

Public Property Let FechaInicial(ByVal vNewValue As Date)

   mFechaInicial = vNewValue

End Property

Public Property Get FechaFinalizacion() As Date

   FechaFinalizacion = mFechaFinalizacion

End Property

Public Property Let FechaFinalizacion(ByVal vNewValue As Date)

   mFechaFinalizacion = vNewValue

End Property

Public Property Get IdProveedor() As Long

   IdProveedor = mIdProveedor

End Property

Public Property Let IdProveedor(ByVal vNewValue As Long)

   mIdProveedor = vNewValue

End Property

Public Function EditarDatosSubcontrato() As Boolean

   Dim oF As frmSubcontratosDatos
   Dim mOk As Boolean
   
   Set oF = New frmSubcontratosDatos
   With oF
      .NumeroSubcontrato = Me.NumeroSubcontrato
      .Show vbModal, Me
      mOk = .Aceptado
      If mOk Then
         Me.NumeroSubcontrato = .NumeroSubcontrato
         MostrarDatosDelSubcontrato Me.NumeroSubcontrato
      End If
   End With
   Unload oF
   Set oF = Nothing
   
   EditarDatosSubcontrato = True
   If Not mOk And Me.NumeroSubcontrato <= 0 Then EditarDatosSubcontrato = False

End Function

Public Sub MostrarDatosDelSubcontrato(NumeroSubcontrato As Long)

   Dim oRs As ADOR.Recordset
   
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("SubcontratosDatos", "_PorNumeroSubcontrato", NumeroSubcontrato)
   If oRs.RecordCount > 0 Then
      Me.IdProveedor = IIf(IsNull(oRs.Fields("IdProveedor").Value), -1, oRs.Fields("IdProveedor").Value)
      Me.DescripcionSubcontrato = IIf(IsNull(oRs.Fields("DescripcionSubcontrato").Value), "", oRs.Fields("DescripcionSubcontrato").Value)
      Me.FechaInicial = IIf(IsNull(oRs.Fields("FechaInicio").Value), Date, oRs.Fields("FechaInicio").Value)
      Me.FechaFinalizacion = IIf(IsNull(oRs.Fields("FechaFinalizacion").Value), Date, oRs.Fields("FechaFinalizacion").Value)
      txtProveedor.Text = IIf(IsNull(oRs.Fields("Proveedor").Value), "", oRs.Fields("Proveedor").Value)
      txtFechas.Text = "Periodo subcontrato : " & Me.FechaInicial & " al " & Me.FechaFinalizacion
   End If
   oRs.Close
   txtNumero.Text = NumeroSubcontrato

   Set oRs = Nothing

End Sub

Public Sub InformeSubcontrato()

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
         oEx.Run "SubcontratoObra", glbStringConexion, "" & mMes & "|" & mAño & "|" & Me.NumeroSubcontrato
      End With
   End With
   Set oEx = Nothing
   
End Sub

Public Sub InformeSubcontrato1()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      With .Workbooks.Add(glbPathPlantillas & "\ComprasTerceros.xlt")
         oEx.Run "SubcontratoObra1", glbStringConexion, "" & Me.NumeroSubcontrato
      End With
   End With
   Set oEx = Nothing
   
End Sub

Private Sub EditarComprobante(ByVal TipoComprobante As Long, ByVal Identificador As Long)

   Dim oF As Form
      
   Select Case TipoComprobante
      Case 1
         Set oF = New frmFacturas
      Case 2
         Set oF = New frmRecibos
      Case 3
         Set oF = New frmNotasDebito
      Case 4
         Set oF = New frmNotasCredito
      Case 5
         Set oF = New frmDevoluciones
      Case 9
         Set oF = New frmSalidasMateriales
      Case 10, 11, 13, 18, 19, 31, 34
         Set oF = New frmComprobantesPrv
      Case 14
         Set oF = New frmDepositosBancarios
      Case 17
         Set oF = New frmOrdenesPago
      Case 28, 29
         Set oF = New frmValoresGastos
      Case 38
         Set oF = New frmAsientos
      Case 39
         Set oF = New FrmPlazosFijos
      Case 1001
         Set oF = New frmAcopios
      Case 1002
         Set oF = New frmLMateriales
      Case 1003
         Set oF = New frmRequerimientos
      Case 1004
         Set oF = New frmPedidos
      Case 1005
         Set oF = New frmComparativa
      Case 1006
         Set oF = New frmAjustesStock
      
      Case Else
         MsgBox "Comprobante no editable"
         GoTo Salida:
   End Select
   
   With oF
      .Id = Identificador
      .Disparar = actL2
      .Show vbModal, Me
   End With

Salida:

   Set oF = Nothing

End Sub

Public Sub HojaRuta()

   Dim oEx As Excel.Application
   
   Set oEx = CreateObject("Excel.Application")
   With oEx
      .Visible = True
      With .Workbooks.Add(glbPathPlantillas & "\ComprasTerceros.xlt")
         oEx.Run "SubcontratoHojaRuta", glbStringConexion, "" & Me.NumeroSubcontrato, _
                     "" & glbEmpresaSegunString & "|" & glbPathPlantillas
      End With
   End With
   Set oEx = Nothing

End Sub
