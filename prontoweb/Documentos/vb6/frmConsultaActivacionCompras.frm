VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmConsultaActivacionCompras 
   Caption         =   "Consulta de activacion de compra de materiales"
   ClientHeight    =   7110
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11940
   Icon            =   "frmConsultaActivacionCompras.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7110
   ScaleWidth      =   11940
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Ver solo lo pendiente de recibir :"
      Enabled         =   0   'False
      Height          =   285
      Left            =   9045
      TabIndex        =   15
      Top             =   6300
      Width           =   2715
   End
   Begin VB.Frame Frame1 
      Caption         =   "Obras :"
      Height          =   465
      Left            =   180
      TabIndex        =   12
      Top             =   540
      Width           =   2130
      Begin VB.OptionButton Option1 
         Caption         =   "Todas"
         Height          =   195
         Left            =   90
         TabIndex        =   14
         Top             =   225
         Width           =   870
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Elegir una"
         Height          =   195
         Left            =   990
         TabIndex        =   13
         Top             =   225
         Width           =   1050
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Buscar"
      Height          =   405
      Index           =   0
      Left            =   90
      TabIndex        =   9
      Top             =   6255
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   405
      Index           =   1
      Left            =   1665
      TabIndex        =   8
      Top             =   6255
      Width           =   1485
   End
   Begin VB.Frame Frame2 
      Caption         =   "Equipos :"
      Height          =   465
      Left            =   5265
      TabIndex        =   1
      Top             =   540
      Width           =   2130
      Begin VB.OptionButton Option4 
         Caption         =   "Elegir uno"
         Height          =   195
         Left            =   990
         TabIndex        =   3
         Top             =   225
         Width           =   1050
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Todos"
         Height          =   195
         Left            =   90
         TabIndex        =   2
         Top             =   225
         Width           =   870
      End
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   3600
      Top             =   6165
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
            Picture         =   "frmConsultaActivacionCompras.frx":076A
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaActivacionCompras.frx":087C
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaActivacionCompras.frx":098E
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaActivacionCompras.frx":0AA0
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaActivacionCompras.frx":0BB2
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaActivacionCompras.frx":0CC4
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaActivacionCompras.frx":0DD6
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11940
      _ExtentX        =   21061
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
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   2430
      TabIndex        =   4
      Top             =   720
      Width           =   2445
      _ExtentX        =   4313
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
   Begin Controles1013.DbListView Lista 
      Height          =   4965
      Left            =   45
      TabIndex        =   5
      Top             =   1125
      Width           =   11850
      _ExtentX        =   20902
      _ExtentY        =   8758
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaActivacionCompras.frx":1228
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   1
      Left            =   7515
      TabIndex        =   6
      Top             =   720
      Visible         =   0   'False
      Width           =   4065
      _ExtentX        =   7170
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEquipo"
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
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   10
      Top             =   6720
      Width           =   11940
      _ExtentX        =   21061
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   5
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   8017
            Key             =   "Mensaje"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   8017
            Picture         =   "frmConsultaActivacionCompras.frx":1244
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
            Object.Width           =   1693
            MinWidth        =   18
            TextSave        =   "01/09/2008"
            Key             =   "Fecha"
         EndProperty
      EndProperty
   End
   Begin VB.Label Label2 
      Caption         =   "Equipo :"
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
      Left            =   7560
      TabIndex        =   11
      Top             =   495
      Width           =   870
   End
   Begin VB.Label Label1 
      Caption         =   "Obra :"
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
      Left            =   2475
      TabIndex        =   7
      Top             =   495
      Width           =   690
   End
End
Attribute VB_Name = "frmConsultaActivacionCompras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mIdObra, mIdEquipo As Long
Private oRs As ADOR.Recordset

Private Sub Check1_Click()

   If Check1.Value = 1 Then
      Check1.Enabled = False
      SoloPendiente
   End If
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         If dcfields(0).Visible And Len(dcfields(0).Text) = 0 Then
            MsgBox "Debe elegir una obra!", vbExclamation
            Exit Sub
         End If
         
         If dcfields(1).Visible And Len(dcfields(1).Text) = 0 Then
            MsgBox "Debe elegir un equipo!", vbExclamation
            Exit Sub
         End If
         
         mIdObra = -1
         If dcfields(0).Visible Then
            mIdObra = dcfields(0).BoundText
         End If
         
         mIdEquipo = -1
         If dcfields(1).Visible Then
            mIdEquipo = dcfields(1).BoundText
         End If
         
         Dim oAp As ComPronto.Aplicacion
         
         Set oAp = Aplicacion
         
         oAp.Tarea "Obras_GenerarActivacionCompraMateriales", Array(mIdObra, mIdEquipo)
         Set oRs = oAp.Obras.TraerFiltrado("_ActivacionCompra")
         
         Lista.Sorted = False
         Set Lista.DataSource = oRs
         ReemplazarEtiquetasListas Lista
         
         StatusBar1.Panels(2).Text = " " & Lista.ListItems.Count & " elementos."
         
         Set oAp = Nothing
         
         StatusBar1.Enabled = True
         
         With Check1
            .Enabled = True
            .Value = 0
         End With
         
      Case 1
         
         Unload Me
   
   End Select
   
End Sub

Private Sub dcfields_Change(Index As Integer)

   If IsNumeric(dcfields(0).BoundText) Then
      If Index = 0 Then
         Dim oAp As ComPronto.Aplicacion
         Set oAp = Aplicacion
         Set dcfields(1).RowSource = oAp.Equipos.TraerFiltrado("_PorObraParaCombo", dcfields(0).BoundText)
         Set oAp = Nothing
         dcfields(1).Text = ""
      End If
   End If

End Sub

Private Sub Form_Load()

   StatusBar1.Enabled = False
   Option1.Value = True
   Option3.Value = True
   
   Dim oAp As ComPronto.Aplicacion
   Set oAp = Aplicacion
   Set dcfields(0).RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo")
   Set oAp = Nothing
   
   ReemplazarEtiquetas Me
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()
    
   Degradado Me

End Sub

Private Sub Form_Unload(Cancel As Integer)

'   If oRs.State = adStateOpen Then oRs.Close
   Set oRs = Nothing
   
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

Private Sub Option1_Click()

   If Option1.Value Then
      Label1.Visible = False
      dcfields(0).Visible = False
      Option3.Value = True
      Frame2.Enabled = False
      dcfields(0).Text = ""
      dcfields(1).Text = ""
   End If
   
End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      Label1.Visible = True
      dcfields(0).Visible = True
      Frame2.Enabled = True
   End If
   
End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      Label2.Visible = False
      dcfields(1).Visible = False
      dcfields(1).Text = ""
   End If
   
End Sub

Private Sub Option4_Click()

   If Option4.Value Then
      Label2.Visible = True
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

Private Sub SoloPendiente()

   Dim mIdABorrar As String
   
   mIdABorrar = ""
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If Not IsNull(.Fields("Tipo").Value) Then
               If .Fields("Cant.Faltante").Value <= 0 Then
                  If Not IsNull(.Fields("IdDetalleRequerimiento").Value) Then
                     mIdABorrar = mIdABorrar & "R" & .Fields("IdDetalleRequerimiento").Value & "|"
                  ElseIf Not IsNull(.Fields("IdDetalleAcopios").Value) Then
                     mIdABorrar = mIdABorrar & "A" & .Fields("IdDetalleAcopios").Value & "|"
                  End If
               End If
            End If
            .MoveNext
         Loop
         .MoveFirst
      End If
   End With
   
   If Len(mIdABorrar) > 0 Then
      BorrarEnCero mIdABorrar
      Set Lista.DataSource = oRs
      StatusBar1.Panels(2).Text = " " & Lista.ListItems.Count & " elementos."
      Check1.Enabled = False
   End If
   
End Sub

Private Sub BorrarEnCero(ByVal mIdABorrar As String)

   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If Not IsNull(.Fields("IdDetalleRequerimiento").Value) Then
               If InStr(1, mIdABorrar, "R" & .Fields("IdDetalleRequerimiento").Value) <> 0 Then
                  .Delete
                  .Update
               End If
            ElseIf Not IsNull(.Fields("IdDetalleAcopios").Value) Then
               If InStr(1, mIdABorrar, "A" & .Fields("IdDetalleAcopios").Value) <> 0 Then
                  .Delete
                  .Update
               End If
            End If
            .MoveNext
         Loop
         If .RecordCount > 0 Then .MoveFirst
      End If
   End With

End Sub
