VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmDefinicionCuadroIngresosEgresos 
   Caption         =   "Definicion del cuadro de ingresos y egresos"
   ClientHeight    =   6900
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10365
   Icon            =   "frmDefinicionCuadroIngresosEgresos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6900
   ScaleWidth      =   10365
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtDescripcion 
      Height          =   285
      Left            =   1305
      TabIndex        =   2
      Top             =   405
      Width           =   5955
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Aceptar"
      Height          =   330
      Index           =   0
      Left            =   90
      TabIndex        =   1
      Top             =   6435
      Width           =   1365
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Cancelar"
      Height          =   330
      Index           =   1
      Left            =   1620
      TabIndex        =   0
      Top             =   6435
      Width           =   1365
   End
   Begin Controles1013.DbListView ListaIngresos 
      Height          =   2895
      Left            =   90
      TabIndex        =   3
      Top             =   990
      Width           =   4965
      _ExtentX        =   8758
      _ExtentY        =   5106
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmDefinicionCuadroIngresosEgresos.frx":076A
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaEgresos 
      Height          =   2895
      Left            =   5310
      TabIndex        =   6
      Top             =   990
      Width           =   4965
      _ExtentX        =   8758
      _ExtentY        =   5106
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmDefinicionCuadroIngresosEgresos.frx":0786
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaPlan 
      Height          =   2040
      Left            =   90
      TabIndex        =   8
      Top             =   4185
      Width           =   10185
      _ExtentX        =   17965
      _ExtentY        =   3598
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmDefinicionCuadroIngresosEgresos.frx":07A2
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   1305
      TabIndex        =   10
      Top             =   45
      Width           =   5955
      _ExtentX        =   10504
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin VB.Label Label4 
      Caption         =   "Plan de cuentas :"
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
      TabIndex        =   9
      Top             =   3960
      Width           =   1770
   End
   Begin VB.Label Label1 
      Caption         =   "Cuentas de egresos :"
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
      Left            =   5310
      TabIndex        =   7
      Top             =   765
      Width           =   1770
   End
   Begin VB.Label Label2 
      Caption         =   "Grupo :"
      Height          =   195
      Left            =   90
      TabIndex        =   5
      Top             =   90
      Width           =   1140
   End
   Begin VB.Label Label3 
      Caption         =   "Cuentas de ingreso :"
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
      TabIndex        =   4
      Top             =   765
      Width           =   1770
   End
   Begin VB.Menu MnuDet1 
      Caption         =   "DetalleIngresos"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   0
      End
   End
   Begin VB.Menu MnuDet2 
      Caption         =   "DetalleEgresos"
      Visible         =   0   'False
      Begin VB.Menu MnuDetB 
         Caption         =   "Eliminar"
         Index           =   0
      End
   End
End
Attribute VB_Name = "frmDefinicionCuadroIngresosEgresos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         GrabarDefinicion
   End Select
   
   Unload Me

End Sub

Private Sub DataCombo1_Click(Index As Integer, Area As Integer)

   If IsNumeric(DataCombo1(0).BoundText) Then
      
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DefinicionesCuadrosContables", "_UnRegistro", DataCombo1(0).BoundText)
      If oRs.RecordCount > 0 Then
         txtDescripcion.Text = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
      End If
      oRs.Close
      Set ListaIngresos.DataSource = Aplicacion.TablasGenerales.TraerFiltrado("DefinicionesCuadrosContables", "_Ingresos", DataCombo1(0).BoundText)
      Set ListaEgresos.DataSource = Aplicacion.TablasGenerales.TraerFiltrado("DefinicionesCuadrosContables", "_Egresos", DataCombo1(0).BoundText)
      Set oRs = Nothing
   End If

End Sub

Private Sub Form_Load()

   ListaPlan.Sorted = False
   Set ListaPlan.DataSource = Aplicacion.Cuentas.TraerFiltrado("_PorJerarquia", -1)
   Set DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerLista

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub ListaEgresos_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaEgresos_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetB_Click 0
   End If

End Sub

Private Sub ListaEgresos_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      PopupMenu MnuDet2, , , , MnuDetB(0)
   End If

End Sub

Private Sub ListaEgresos_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String, mErrores As String
   Dim iFilas As Long, iColumnas As Long
   Dim mError As Boolean
   Dim Filas
   Dim Columnas
   Dim oL As ListItem

   If Data.GetFormat(ccCFText) Then
      
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      For iFilas = 1 To UBound(Filas)
         Columnas = Split(Filas(iFilas), vbTab)
         mError = False
         For Each oL In ListaEgresos.ListItems
            If oL.Tag = Columnas(0) Then
               mError = True
               Exit For
            End If
         Next
         If Not mError Then
            Set oL = ListaEgresos.ListItems.Add
            With oL
               .Tag = Columnas(0)
               .Text = Columnas(1)
               .SubItems(1) = "" & Columnas(2)
            End With
         End If
      Next
      
   End If

End Sub

Private Sub ListaEgresos_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

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
         If Columnas(LBound(Columnas) + 1) <> "Descripcion" Then
            Effect = vbDropEffectNone
         Else
            Effect = vbDropEffectCopy
         End If
      End If
   End If

End Sub

Private Sub ListaEgresos_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub ListaIngresos_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaIngresos_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetA_Click 0
   End If

End Sub

Private Sub ListaIngresos_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      PopupMenu MnuDet1, , , , MnuDetA(0)
   End If

End Sub

Private Sub ListaIngresos_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String, mErrores As String
   Dim iFilas As Long, iColumnas As Long
   Dim mError As Boolean
   Dim Filas
   Dim Columnas
   Dim oL As ListItem

   If Data.GetFormat(ccCFText) Then
      
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      For iFilas = 1 To UBound(Filas)
         Columnas = Split(Filas(iFilas), vbTab)
         mError = False
         For Each oL In ListaIngresos.ListItems
            If oL.Tag = Columnas(0) Then
               mError = True
               Exit For
            End If
         Next
         If Not mError Then
            Set oL = ListaIngresos.ListItems.Add
            With oL
               .Tag = Columnas(0)
               .Text = Columnas(1)
               .SubItems(1) = "" & Columnas(2)
            End With
         End If
      Next
      
   End If

End Sub

Private Sub ListaIngresos_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

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
         If Columnas(LBound(Columnas) + 1) <> "Descripcion" Then
            Effect = vbDropEffectNone
         Else
            Effect = vbDropEffectCopy
         End If
      End If
   End If

End Sub

Private Sub ListaIngresos_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub GrabarDefinicion()

   Dim oL As ListItem
   
   Aplicacion.Tarea "DefinicionesCuadrosContables_Eliminar", DataCombo1(0).BoundText
   For Each oL In ListaIngresos.ListItems
      Aplicacion.Tarea "DefinicionesCuadrosContables_AgregarUnRegistro", _
            Array(DataCombo1(0).BoundText, txtDescripcion.Text, oL.Tag, 0)
   Next
   For Each oL In ListaEgresos.ListItems
      Aplicacion.Tarea "DefinicionesCuadrosContables_AgregarUnRegistro", _
            Array(DataCombo1(0).BoundText, txtDescripcion.Text, 0, oL.Tag)
   Next

End Sub

Private Sub ListaPlan_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Dim oL As ListItem
   On Error Resume Next
   Select Case Index
      Case 0
         For Each oL In ListaIngresos.ListItems
            If oL.Selected Then
               Aplicacion.Tarea "DefinicionesCuadrosContables_BorrarAsignacion", _
                     Array(DataCombo1(0).BoundText, oL.Tag, "I")
               ListaIngresos.ListItems.Remove (oL.Index)
            End If
         Next
   End Select

End Sub

Private Sub MnuDetB_Click(Index As Integer)

   Dim oL As ListItem
   On Error Resume Next
   Select Case Index
      Case 0
         For Each oL In ListaEgresos.ListItems
            If oL.Selected Then
               Aplicacion.Tarea "DefinicionesCuadrosContables_BorrarAsignacion", _
                     Array(DataCombo1(0).BoundText, oL.Tag, "E")
               ListaEgresos.ListItems.Remove (oL.Index)
            End If
         Next
   End Select

End Sub
