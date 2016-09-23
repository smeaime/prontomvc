VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmArticulosRequerimientos 
   Caption         =   "LM - LA - RM - RS"
   ClientHeight    =   5565
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   9.75
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmArticulosRequerimientos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5565
   ScaleWidth      =   11880
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame2 
      Caption         =   "LM's de la obra :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   465
      Left            =   4590
      TabIndex        =   10
      Top             =   495
      Width           =   3075
      Begin VB.OptionButton Option1 
         Caption         =   "Todas las LM"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   90
         TabIndex        =   12
         Top             =   225
         Width           =   1320
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Elegir una LM"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   1575
         TabIndex        =   11
         Top             =   225
         Width           =   1320
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   405
      Index           =   1
      Left            =   135
      TabIndex        =   4
      Top             =   4680
      Width           =   1485
   End
   Begin VB.TextBox txtObra 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   330
      Left            =   1350
      Locked          =   -1  'True
      TabIndex        =   2
      Top             =   585
      Width           =   1185
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Buscar"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   0
      Top             =   4185
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   2655
      TabIndex        =   3
      Tag             =   "Obras"
      Top             =   585
      Width           =   1860
      _ExtentX        =   3281
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
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
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   1800
      Top             =   4590
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
            Picture         =   "frmArticulosRequerimientos.frx":076A
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulosRequerimientos.frx":087C
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulosRequerimientos.frx":098E
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulosRequerimientos.frx":0AA0
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulosRequerimientos.frx":0BB2
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulosRequerimientos.frx":0CC4
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmArticulosRequerimientos.frx":0DD6
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   5
      Top             =   5175
      Width           =   11880
      _ExtentX        =   20955
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   5
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   7726
            Key             =   "Mensaje"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   7726
            Picture         =   "frmArticulosRequerimientos.frx":1228
            Key             =   "Estado"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   1
            Alignment       =   1
            AutoSize        =   2
            Enabled         =   0   'False
            Object.Width           =   1614
            MinWidth        =   18
            TextSave        =   "MAYÚS"
            Key             =   "Caps"
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   2
            AutoSize        =   2
            Object.Width           =   1111
            MinWidth        =   18
            TextSave        =   "NÚM"
            Key             =   "Num"
         EndProperty
         BeginProperty Panel5 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            Alignment       =   1
            AutoSize        =   2
            Object.Width           =   2170
            MinWidth        =   18
            TextSave        =   "01/09/2008"
            Key             =   "Fecha"
         EndProperty
      EndProperty
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
            ImageKey        =   "Imprimir"
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
   Begin Controles1013.DbListView Lista 
      Height          =   3120
      Left            =   0
      TabIndex        =   7
      Top             =   990
      Width           =   11850
      _ExtentX        =   20902
      _ExtentY        =   5503
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmArticulosRequerimientos.frx":1542
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   915
      Left            =   2565
      TabIndex        =   8
      Top             =   4185
      Width           =   9240
      _ExtentX        =   16298
      _ExtentY        =   1614
      _Version        =   393217
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmArticulosRequerimientos.frx":155E
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   1
      Left            =   7740
      TabIndex        =   13
      Tag             =   "LMateriales"
      Top             =   585
      Visible         =   0   'False
      Width           =   4065
      _ExtentX        =   7170
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
   Begin VB.Label Label2 
      Caption         =   "Obs. :"
      Height          =   285
      Left            =   1980
      TabIndex        =   9
      Top             =   4230
      Width           =   510
   End
   Begin VB.Label Label1 
      Caption         =   "Obra :"
      Height          =   240
      Left            =   90
      TabIndex        =   1
      Top             =   630
      Width           =   1185
   End
End
Attribute VB_Name = "frmArticulosRequerimientos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mvarIdObra As Long

Public Property Let Obra(ByVal vnewvalue As Long)

   mvarIdObra = vnewvalue
   
   Dim oAp As Aplicacion
   Set oAp = Aplicacion
   Set dcfields(0).RowSource = oAp.CargarLista(dcfields(0).Tag)
   Set dcfields(1).RowSource = oAp.LMateriales.TraerFiltrado("_ParaListaPorObra", mvarIdObra)
   Set oAp = Nothing
   
End Property

Private Sub cmd_Click(Index As Integer)

   StatusBar1.Enabled = True
   
   Select Case Index
      
      Case 0
      
         If Len(Trim(txtObra.Text)) = 0 Then
            MsgBox "Debe ingresar una obra!", vbExclamation
            Exit Sub
         End If
      
         If dcfields(1).Visible And Len(dcfields(1).Text) = 0 Then
            MsgBox "Debe elegir una lista de materiales!", vbExclamation
            Exit Sub
         End If
         
         Me.MousePointer = vbHourglass
         CalcularFaltante
         Me.MousePointer = vbDefault
         
      Case 1
         
         Me.Hide
   
   End Select
   
End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   If Index = 0 Then Set dcfields(1).RowSource = Nothing
   
   If IsNumeric(dcfields(Index).BoundText) Then
      If Index = 0 Then
         Dim oAp As Aplicacion
         Set oAp = Aplicacion
         txtObra.Text = oAp.Obras.Item(dcfields(Index).BoundText).Registro.Fields("NumeroObra").Value
         mvarIdObra = dcfields(Index).BoundText
         Set dcfields(1).RowSource = oAp.LMateriales.TraerFiltrado("_ParaListaPorObra", dcfields(0).BoundText)
         Set oAp = Nothing
      End If
   End If

End Sub

Private Sub Form_Activate()

   If Not dcfields(0).Visible Then
      Frame2.Left = dcfields(0).Left
      With dcfields(1)
         .Left = 5500
         .Width = 6000
      End With
   End If

End Sub

Private Sub Form_Load()

   StatusBar1.Enabled = False
   Option1.Value = True
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()
    
   Degradado Me

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_ItemClick(ByVal Item As MSComctlLib.IListItem)

   If Not Lista.SelectedItem Is Nothing Then
      rchObservaciones.TextRTF = Lista.TextoLargo(Lista.SelectedItem.Tag)
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

Public Sub CalcularFaltante()

   Dim oAp As Aplicacion
   Dim oRsLMat As ADOR.Recordset
   Dim oRsAco As ADOR.Recordset
   Dim oRsReq As ADOR.Recordset
   Dim oRsRes As ADOR.Recordset
   Dim AAplicar As Double, AAplicar1 As Double
   Dim idDet As Long, IdLM As Long
   
   Set oAp = Aplicacion
   dcfields(0).BoundText = mvarIdObra
   txtObra.Text = oAp.Obras.Item(mvarIdObra).Registro.Fields("NumeroObra").Value
   
   oAp.Tarea "LMateriales_CalcularFaltantes", mvarIdObra
   If dcfields(1).Visible Then
      IdLM = dcfields(1).BoundText
   Else
      IdLM = -1
   End If
   
   Set oRsLMat = oAp.LMateriales.TraerFiltrado("_Faltantes", IdLM)
   
'   Set oRsLMat = CopiarTodosLosRegistros(oAp.Requerimientos.TraerFiltrado("_ItemsPorObra", mvarIdObra))
'   Set oRsAco = oAp.Requerimientos.TraerFiltrado("_ItemsPorObra1", mvarIdObra)
'   Set oRsReq = oAp.Requerimientos.TraerFiltrado("_ItemsPorObra2", mvarIdObra)
'   Set oRsRes = oAp.Requerimientos.TraerFiltrado("_ItemsPorObra3", mvarIdObra)
'
'   If oRsAco.RecordCount > 0 Then
'      oRsAco.MoveFirst
'      Do While Not oRsAco.EOF
'         AAplicar = oRsAco.Fields("Cantidad").Value
'         AAplicar1 = oRsAco.Fields("Cargado").Value
'         If oRsLMat.RecordCount > 0 Then
'            oRsLMat.MoveFirst
'            Do While Not oRsLMat.EOF
'               If oRsLMat.Fields("IdArticulo").Value = oRsAco.Fields("IdArticulo").Value Then
'                  If oRsLMat.Fields("Cant.falt.").Value > AAplicar Then
'                     oRsLMat.Fields("Cant.falt.").Value = oRsLMat.Fields("Cant.falt.").Value - AAplicar
'                     AAplicar = 0
'                     Exit Do
'                  Else
'                     AAplicar = AAplicar - oRsLMat.Fields("Cant.falt.").Value
'                     oRsLMat.Fields("Cant.falt.").Value = 0
'                     oRsLMat.Update
'                  End If
'               End If
'               oRsLMat.MoveNext
'            Loop
'            oRsLMat.MoveFirst
'            Do While Not oRsLMat.EOF
'               If oRsLMat.Fields("IdArticulo").Value = oRsAco.Fields("IdArticulo").Value Then
'                  If oRsLMat.Fields("Total falt.").Value > AAplicar1 Then
'                     oRsLMat.Fields("Total falt.").Value = oRsLMat.Fields("Total falt.").Value - AAplicar1
'                     AAplicar1 = 0
'                     Exit Do
'                  Else
'                     AAplicar1 = AAplicar1 - oRsLMat.Fields("Total falt.").Value
'                     oRsLMat.Fields("Total falt.").Value = 0
'                     oRsLMat.Delete
'                     oRsLMat.Update
'                  End If
'               End If
'               oRsLMat.MoveNext
'            Loop
'         End If
'         oRsAco.MoveNext
'      Loop
'   End If
'
'   If oRsReq.RecordCount > 0 Then
'      oRsReq.MoveFirst
'      Do While Not oRsReq.EOF
'         AAplicar = oRsReq.Fields("Cantidad").Value
'         AAplicar1 = oRsReq.Fields("Cargado").Value
'         If oRsLMat.RecordCount > 0 Then
'            oRsLMat.MoveFirst
'            Do While Not oRsLMat.EOF
'               If oRsLMat.Fields("IdArticulo").Value = oRsReq.Fields("IdArticulo").Value Then
'                  If oRsLMat.Fields("Cant.falt.").Value > AAplicar Then
'                     oRsLMat.Fields("Cant.falt.").Value = oRsLMat.Fields("Cant.falt.").Value - AAplicar
'                     AAplicar = 0
'                     Exit Do
'                  Else
'                     AAplicar = AAplicar - oRsLMat.Fields("Cant.falt.").Value
'                     oRsLMat.Fields("Cant.falt.").Value = 0
'                     oRsLMat.Update
'                  End If
'               End If
'               oRsLMat.MoveNext
'            Loop
'            oRsLMat.MoveFirst
'            Do While Not oRsLMat.EOF
'               If oRsLMat.Fields("IdArticulo").Value = oRsReq.Fields("IdArticulo").Value Then
'                  If oRsLMat.Fields("Total falt.").Value > AAplicar1 Then
'                     oRsLMat.Fields("Total falt.").Value = oRsLMat.Fields("Total falt.").Value - AAplicar1
'                     AAplicar1 = 0
'                     Exit Do
'                  Else
'                     AAplicar1 = AAplicar1 - oRsLMat.Fields("Total falt.").Value
'                     oRsLMat.Fields("Total falt.").Value = 0
'                     oRsLMat.Delete
'                     oRsLMat.Update
'                  End If
'               End If
'               oRsLMat.MoveNext
'            Loop
'         End If
'         oRsReq.MoveNext
'      Loop
'   End If
'
'   If oRsRes.RecordCount > 0 Then
'      oRsRes.MoveFirst
'      Do While Not oRsRes.EOF
'         AAplicar = oRsRes.Fields("CantidadUnidades").Value
'         AAplicar1 = oRsRes.Fields("Cargado").Value
'         If oRsLMat.RecordCount > 0 Then
'            oRsLMat.MoveFirst
'            Do While Not oRsLMat.EOF
'               If oRsLMat.Fields("IdArticulo").Value = oRsRes.Fields("IdArticulo").Value Then
'                  If oRsLMat.Fields("Cant.falt.").Value > AAplicar Then
'                     oRsLMat.Fields("Cant.falt.").Value = oRsLMat.Fields("Cant.falt.").Value - AAplicar
'                     AAplicar = 0
'                     Exit Do
'                  Else
'                     AAplicar = AAplicar - oRsLMat.Fields("Cant.falt.").Value
'                     oRsLMat.Fields("Cant.falt.").Value = 0
'                     oRsLMat.Update
'                  End If
'               End If
'               oRsLMat.MoveNext
'            Loop
'            oRsLMat.MoveFirst
'            Do While Not oRsLMat.EOF
'               If oRsLMat.Fields("IdArticulo").Value = oRsRes.Fields("IdArticulo").Value Then
'                  If oRsLMat.Fields("Total falt.").Value > AAplicar1 Then
'                     oRsLMat.Fields("Total falt.").Value = oRsLMat.Fields("Total falt.").Value - AAplicar1
'                     AAplicar1 = 0
'                     Exit Do
'                  Else
'                     AAplicar1 = AAplicar1 - oRsLMat.Fields("Total falt.").Value
'                     oRsLMat.Fields("Total falt.").Value = 0
'                     oRsLMat.Delete
'                     oRsLMat.Update
'                  End If
'               End If
'               oRsLMat.MoveNext
'            Loop
'         End If
'         oRsRes.MoveNext
'      Loop
'   End If
   
   Lista.ListItems.Clear
   If oRsLMat.RecordCount > 0 Then
      oRsLMat.MoveFirst
      Set Lista.DataSource = oRsLMat
      ReemplazarEtiquetasListas Lista
      StatusBar1.Panels(2).Text = " " & Lista.ListItems.Count & " elementos en la lista"
   Else
      MsgBox "No hay faltantes de materiales en esta obra", vbExclamation
   End If
   
'   oRsAco.Close
'   Set oRsAco = Nothing
'   oRsLMat.Close
   Set oRsLMat = Nothing
'   oRsReq.Close
'   Set oRsReq = Nothing
'   oRsRes.Close
'   Set oRsRes = Nothing
   Set oAp = Nothing

End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      dcfields(1).Visible = False
   End If
   
End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      dcfields(1).Visible = True
   End If
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   On Error GoTo Mal
   
   Select Case Button.Key
      
      Case "Imprimir"
         
         ImprimirConExcel Lista
      
      Case "Buscar"
         
         FiltradoLista Lista
         StatusBar1.Panels(2).Text = Ultimo_Nodo & " " & Lista.ListItems.Count & " elementos en la lista"

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

