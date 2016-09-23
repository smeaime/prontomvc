VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmLMVsLA 
   Caption         =   "Listas de materiales Vs Listas de acopio por obra"
   ClientHeight    =   5130
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11955
   Icon            =   "frmLMVsLA.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5130
   ScaleWidth      =   11955
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Buscar"
      Height          =   405
      Index           =   0
      Left            =   4230
      TabIndex        =   2
      Top             =   4230
      Width           =   1485
   End
   Begin VB.TextBox txtObra 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   330
      Left            =   2295
      Locked          =   -1  'True
      TabIndex        =   1
      Top             =   540
      Width           =   1185
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   405
      Index           =   1
      Left            =   6075
      TabIndex        =   0
      Top             =   4230
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   3600
      TabIndex        =   3
      Tag             =   "Obras"
      Top             =   540
      Width           =   3930
      _ExtentX        =   6932
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
      Left            =   45
      Top             =   4140
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
            Picture         =   "frmLMVsLA.frx":076A
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLMVsLA.frx":087C
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLMVsLA.frx":098E
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLMVsLA.frx":0AA0
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLMVsLA.frx":0BB2
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLMVsLA.frx":0CC4
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLMVsLA.frx":0DD6
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   4
      Top             =   4740
      Width           =   11955
      _ExtentX        =   21087
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   5
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   8520
            Key             =   "Mensaje"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   8520
            Picture         =   "frmLMVsLA.frx":1228
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
            TextSave        =   "01/09/2008"
            Key             =   "Fecha"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3255
      Left            =   45
      TabIndex        =   5
      Top             =   900
      Width           =   11850
      _ExtentX        =   20902
      _ExtentY        =   5741
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmLMVsLA.frx":1542
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   11955
      _ExtentX        =   21087
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
   Begin VB.Label Label1 
      Caption         =   "Numero de Obra :"
      Height          =   240
      Left            =   90
      TabIndex        =   6
      Top             =   585
      Width           =   1995
   End
End
Attribute VB_Name = "frmLMVsLA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mvarIdObra As Long

Public Property Let Obra(ByVal vnewvalue As Long)

   mvarIdObra = vnewvalue
   
   Set dcfields(0).RowSource = Aplicacion.CargarLista(dcfields(0).Tag)
   
End Property

Private Sub cmd_Click(Index As Integer)

   StatusBar1.Enabled = True
   
   Select Case Index
      
      Case 0
      
         If Len(Trim(txtObra.Text)) = 0 Then
            MsgBox "Debe ingresar una obra!", vbExclamation
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

   If IsNumeric(dcfields(Index).BoundText) Then
      If Index = 0 Then
         txtObra.Text = Aplicacion.Obras.Item(dcfields(Index).BoundText).Registro.Fields("NumeroObra").Value
         mvarIdObra = dcfields(Index).BoundText
      End If
   End If

End Sub

Private Sub Form_Load()

   StatusBar1.Enabled = False
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()
    
   Degradado Me

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

Public Sub CalcularFaltante()

   Dim oAp As Aplicacion
   Dim oRsLMat, oRsAco, oRsReq, oRsRes As ADOR.Recordset
   Dim AAplicar, AAplicar1 As Double
   Dim idDet As Long
   Dim VecX, VecT As String
   
   VecX = "0111010001133"
   VecT = "0102010002200"
   
   Set oAp = Aplicacion
   dcfields(0).BoundText = mvarIdObra
   txtObra.Text = Aplicacion.Obras.Item(mvarIdObra).Registro.Fields("NumeroObra").Value
   Set oRsLMat = CopiarTodosLosRegistros(oAp.Requerimientos.TraerFiltrado("_ItemsPorObra", mvarIdObra))
   Set oRsAco = oAp.Requerimientos.TraerFiltrado("_ItemsPorObra1", mvarIdObra)
   
   With oRsLMat
      
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            .Fields("Vector_T").Value = VecT
            .Fields("Vector_X").Value = VecX
            .Update
            .MoveNext
         Loop
      End If
   
      If oRsAco.RecordCount > 0 Then
         oRsAco.MoveFirst
         Do While Not oRsAco.EOF
            AAplicar = oRsAco.Fields("Cantidad").Value
            AAplicar1 = oRsAco.Fields("Cargado").Value
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  If .Fields("IdArticulo").Value = oRsAco.Fields("IdArticulo").Value Then
                     If .Fields("Cant.falt.").Value > AAplicar Then
                        .Fields("Cant.falt.").Value = .Fields("Cant.falt.").Value - AAplicar
                        AAplicar = 0
                        Exit Do
                     Else
                        AAplicar = AAplicar - .Fields("Cant.falt.").Value
                        .Fields("Cant.falt.").Value = 0
                        .Update
                     End If
                  End If
                  .MoveNext
               Loop
               .MoveFirst
               Do While Not .EOF
                  If .Fields("IdArticulo").Value = oRsAco.Fields("IdArticulo").Value Then
                     If .Fields("Total falt.").Value > AAplicar1 Then
                        .Fields("Total falt.").Value = .Fields("Total falt.").Value - AAplicar1
                        AAplicar1 = 0
                        Exit Do
                     Else
                        AAplicar1 = AAplicar1 - .Fields("Total falt.").Value
                        .Fields("Total falt.").Value = 0
                        .Delete
                        .Update
                     End If
                  End If
                  .MoveNext
               Loop
            End If
            oRsAco.MoveNext
         Loop
      End If
   
   End With
   
   If oRsLMat.RecordCount > 0 Then
      oRsLMat.MoveFirst
      Set Lista.DataSource = oRsLMat
   End If
   
   oRsAco.Close
   Set oRsAco = Nothing
'   oRsLMat.Close
   Set oRsLMat = Nothing
   Set oAp = Nothing

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

