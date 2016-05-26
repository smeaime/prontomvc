VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmConsultaPedidos 
   Caption         =   "Notas de pedido pendientes"
   ClientHeight    =   5505
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11130
   Icon            =   "frmConsultaPedidos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5505
   ScaleWidth      =   11130
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   6795
      TabIndex        =   8
      Top             =   4725
      Visible         =   0   'False
      Width           =   1140
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   9180
      TabIndex        =   7
      Top             =   4635
      Visible         =   0   'False
      Width           =   1905
      _ExtentX        =   3360
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPedido"
      Text            =   ""
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Solo un &Pedido"
      Height          =   405
      Index           =   2
      Left            =   4095
      TabIndex        =   6
      Top             =   4635
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Detallado"
      Height          =   405
      Index           =   1
      Left            =   1305
      TabIndex        =   5
      Top             =   4635
      Width           =   1125
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Resumido"
      Height          =   405
      Index           =   0
      Left            =   90
      TabIndex        =   4
      Top             =   4635
      Width           =   1125
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   405
      Index           =   3
      Left            =   2520
      TabIndex        =   0
      Top             =   4635
      Width           =   1125
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   1
      Top             =   5115
      Width           =   11130
      _ExtentX        =   19632
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   4
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   15637
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
      Height          =   4020
      Left            =   45
      TabIndex        =   2
      Top             =   495
      Width           =   11040
      _ExtentX        =   19473
      _ExtentY        =   7091
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaPedidos.frx":076A
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   8145
      Top             =   4545
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
            Picture         =   "frmConsultaPedidos.frx":0786
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaPedidos.frx":0898
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaPedidos.frx":09AA
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaPedidos.frx":0ABC
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaPedidos.frx":0BCE
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaPedidos.frx":0CE0
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaPedidos.frx":0DF2
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   11130
      _ExtentX        =   19632
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
      Caption         =   "Nro. Pedido :"
      Height          =   285
      Left            =   5760
      TabIndex        =   9
      Top             =   4725
      Visible         =   0   'False
      Width           =   915
   End
End
Attribute VB_Name = "frmConsultaPedidos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmd_Click(Index As Integer)

   Dim oRsPed As ADOR.Recordset
   
   Select Case Index
      
      Case 0
         
         If dcfields(0).Visible Then
            dcfields(0).Visible = False
         End If
         
         Me.Caption = "Pedidos pendientes (Resumido)"
         Set oRsPed = Aplicacion.Pedidos.TraerFiltrado("_Pendientes")
         Set Lista.DataSource = oRsPed
         ReemplazarEtiquetasListas Lista
         Set oRsPed = Nothing

      Case 1
         
         If dcfields(0).Visible Then
            dcfields(0).Visible = False
         End If
         
         Me.Caption = "Pedidos pendientes (Detallado)"
         Set oRsPed = Aplicacion.Pedidos.TraerFiltrado("_DetPendientesTodos")
         Set Lista.DataSource = oRsPed
         ReemplazarEtiquetasListas Lista
         Set oRsPed = Nothing

      Case 2
         
         Me.Caption = "Pedidos pendientes (Detallado, solo un pedido)"
'         If dcfields(0).Visible Then
'            If Not IsNumeric(dcfields(0).BoundText) Then
'               MsgBox "Debe elegir un pedido!", vbExclamation
'               Exit Sub
'            End If
'            Set oRsPed = Aplicacion.Pedidos.TraerFiltrado("_DetPendientes", dcfields(0).BoundText)
'            Set Lista.DataSource = oRsPed
'            ReemplazarEtiquetasListas Lista
'            Set oRsPed = Nothing
'         Else
'            dcfields(0).Visible = True
'            cmd(2).Caption = "Buscar pedido"
'         End If
         If Text1.Visible Then
            If Not IsNumeric(Text1.Text) Or Len(Text1.Text) = 0 Then
               MsgBox "Debe ingresar un pedido!", vbExclamation
               Exit Sub
            End If
            Set oRsPed = Aplicacion.Pedidos.TraerFiltrado("_DetPendientes", Array(-1, Text1.Text))
            Set Lista.DataSource = oRsPed
            ReemplazarEtiquetasListas Lista
            Set oRsPed = Nothing
         Else
            Text1.Visible = True
            Label1.Visible = True
            cmd(2).Caption = "Buscar pedido"
         End If
         
      Case 3
         
         Me.Hide
         Exit Sub
   
   End Select
   
   StatusBar1.Panels(1).Text = " " & Lista.ListItems.Count & " elementos en la lista"

End Sub

Private Sub Form_Load()

   Set dcfields(0).RowSource = Aplicacion.Pedidos.TraerFiltrado("_PendientesParaLista")

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

