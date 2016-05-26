VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmConsultaReservas 
   Caption         =   "Reservas de stock por obra"
   ClientHeight    =   5115
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11820
   Icon            =   "frmConsultaReservas.frx":0000
   LinkTopic       =   "Form1"
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   5115
   ScaleWidth      =   11820
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "Tipo de busqueda :"
      Height          =   645
      Left            =   90
      TabIndex        =   5
      Top             =   4050
      Width           =   3570
      Begin VB.OptionButton Option2 
         Caption         =   "Todas las obras"
         Height          =   240
         Left            =   1530
         TabIndex        =   7
         Top             =   225
         Width           =   1950
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Por obra"
         Height          =   195
         Left            =   135
         TabIndex        =   6
         Top             =   225
         Width           =   1365
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Buscar"
      Height          =   405
      Index           =   0
      Left            =   4230
      TabIndex        =   2
      Top             =   4185
      Width           =   1485
   End
   Begin VB.TextBox txtObra 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   330
      Left            =   2655
      Locked          =   -1  'True
      TabIndex        =   1
      Top             =   495
      Width           =   1185
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   405
      Index           =   1
      Left            =   5940
      TabIndex        =   0
      Top             =   4185
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   3960
      TabIndex        =   3
      Tag             =   "Obras"
      Top             =   495
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
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   8
      Top             =   4725
      Width           =   11820
      _ExtentX        =   20849
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   4
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   16854
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
   Begin Controles1013.DbListView Lista 
      Height          =   3165
      Left            =   0
      TabIndex        =   9
      Top             =   855
      Width           =   11805
      _ExtentX        =   20823
      _ExtentY        =   5583
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaReservas.frx":076A
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   8595
      Top             =   4095
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
            Picture         =   "frmConsultaReservas.frx":0786
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaReservas.frx":0898
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaReservas.frx":09AA
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaReservas.frx":0ABC
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaReservas.frx":0BCE
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaReservas.frx":0CE0
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaReservas.frx":0DF2
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   10
      Top             =   0
      Width           =   11820
      _ExtentX        =   20849
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
   Begin VB.Label Label1 
      Caption         =   "Numero de Obra :"
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
      TabIndex        =   4
      Top             =   540
      Width           =   2445
   End
End
Attribute VB_Name = "frmConsultaReservas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mvarIdObra As Long

Public Property Let Obra(ByVal vnewvalue As Long)

   mvarIdObra = vnewvalue
   
   Set dcfields(0).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo")
   
End Property

Private Sub cmd_Click(Index As Integer)

   StatusBar1.Enabled = True
   
   Select Case Index
      
      Case 0
      
         If Option1.Value And Not IsNumeric(dcfields(0).BoundText) Then
            MsgBox "Debe ingresar una obra!", vbExclamation
            Exit Sub
         End If
      
         Dim oAp As Aplicacion
         Dim oRs As ADOR.Recordset
   
         Set oAp = Aplicacion
         
         If Option1.Value Then
            Set oRs = oAp.Reservas.TraerFiltrado("_PorObra", dcfields(0).BoundText)
         Else
            Set oRs = oAp.Reservas.TraerFiltrado("_Todas")
         End If
         
         Set Lista.DataSource = oRs
         ReemplazarEtiquetasListas Lista
   
'         oRs.Close
         Set oRs = Nothing
         Set oAp = Nothing
      
         StatusBar1.Panels(1).Text = " " & Lista.ListItems.Count & " elementos en la lista"

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

   Option1.Value = True
   StatusBar1.Enabled = flase
   ReemplazarEtiquetas Me
   
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

Private Sub Option1_Click()

   If Option1.Value Then
      Label1.Visible = True
      txtObra.Visible = True
      dcfields(0).Visible = True
   End If

End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      Label1.Visible = False
      txtObra.Visible = False
      dcfields(0).Visible = False
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

