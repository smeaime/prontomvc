VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmNovedadesUsuario 
   Caption         =   "Novedades por usuario"
   ClientHeight    =   6705
   ClientLeft      =   60
   ClientTop       =   630
   ClientWidth     =   10770
   Icon            =   "frmNovedadesUsuario.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6705
   ScaleWidth      =   10770
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   420
      Index           =   1
      Left            =   1665
      TabIndex        =   5
      Top             =   5805
      Width           =   1470
   End
   Begin VB.TextBox txtUsuario 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   90
      TabIndex        =   4
      Text            =   "Text1"
      Top             =   495
      Width           =   4245
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Guardar"
      Height          =   420
      Index           =   0
      Left            =   90
      TabIndex        =   3
      Top             =   5805
      Width           =   1470
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   9810
      Top             =   5715
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
            Picture         =   "frmNovedadesUsuario.frx":076A
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNovedadesUsuario.frx":087C
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNovedadesUsuario.frx":098E
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNovedadesUsuario.frx":0AA0
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNovedadesUsuario.frx":0BB2
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNovedadesUsuario.frx":0CC4
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNovedadesUsuario.frx":0DD6
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   0
      Top             =   6315
      Width           =   10770
      _ExtentX        =   18997
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   5
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   7488
            Key             =   "Mensaje"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   7488
            Picture         =   "frmNovedadesUsuario.frx":1228
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
            TextSave        =   "30/10/2010"
            Key             =   "Fecha"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   10770
      _ExtentX        =   18997
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageKey        =   "Print"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel"
            Object.ToolTipText     =   "Salida a Excel"
            ImageKey        =   "Excel"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageKey        =   "Find"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   4875
      Left            =   45
      TabIndex        =   2
      Top             =   810
      Width           =   10680
      _ExtentX        =   18838
      _ExtentY        =   8599
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmNovedadesUsuario.frx":1542
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Opciones de confirmacion"
      Begin VB.Menu MnuDetA 
         Caption         =   "Marcar todo"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Desmarcar todo"
         Index           =   1
      End
   End
End
Attribute VB_Name = "frmNovedadesUsuario"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
         
         Dim oL As ListItem
         Dim mCheck, mvarOK As Boolean
         Dim mConfirma As Integer
         Dim oRs As ADOR.Recordset
         
         mConfirma = MsgBox("Esta suguro de procesar la informacion ?", vbYesNo, "Confirmacion de novedades")
         If mConfirma = vbNo Then
            Exit Sub
         End If
         
         mCheck = False
         
         If Lista.ListItems.Count > 0 Then
            For Each oL In Lista.ListItems
               If oL.Checked Then
                  mCheck = True
                  Exit For
               End If
            Next
         End If
         
         If Not mCheck Then
            MsgBox "No hay informacion a procesar!", vbExclamation
            Exit Sub
         End If
         
         Me.MousePointer = vbHourglass
         DoEvents
         
         Dim oAp As ComPronto.Aplicacion
         Dim oNov As ComPronto.NovedadUsuario
         Dim mNov As Integer
         
         Set oAp = Aplicacion
         
         mNov = 0
         
         If Lista.ListItems.Count > 0 Then
            For Each oL In Lista.ListItems
               If oL.Checked Then
                  Set oNov = oAp.NovedadesUsuario.Item(oL.Tag)
                  With oNov
                     .Registro.Fields("Confirmado").Value = "SI"
                     .Registro.Fields("FechaConfirmacion").Value = Now
                  End With
                  oNov.Guardar
                  mNov = mNov + 1
               End If
               StatusBar1.Panels(2).Text = " Procesado : " & mNov & " novedades a usuario"
            Next
         End If
         
         Set oRs = Nothing
         Set oNov = Nothing
         Set oAp = Nothing
         
         Me.MousePointer = vbDefault
      
         Unload Me
         
      Case 1
         
         Unload Me
   
   End Select
   
End Sub

Private Sub Form_Load()

   txtUsuario.Text = Aplicacion.Empleados.Item(glbIdUsuario).Registro.Fields("Nombre").Value
   Lista.Sorted = False
   Lista.CheckBoxes = True
   Set Lista.DataSource = Aplicacion.NovedadesUsuario.TraerFiltrado("_PorIdEmpleadoConEventosPendientes", glbIdUsuario)
   StatusBar1.Panels(1).Text = " " & Lista.ListItems.Count & " elementos en la lista"
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count > 0 Then
         PopupMenu MnuDet, , , , MnuDetA(0)
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Dim oL As ListItem
   
   Select Case Index
      Case 0
         For Each oL In Lista.ListItems
            oL.Checked = True
         Next
      Case 1
         For Each oL In Lista.ListItems
            oL.Checked = False
         Next
   End Select

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   On Error GoTo Mal
   
   Select Case Button.Key
      
      Case "Imprimir"
         
         ImprimirConExcel Lista
      
      Case "Buscar"
         
         FiltradoLista Lista
'         StatusBar1.Panels(2).Text = " " & Lista.ListItems.Count & " elementos en la lista"

      Case "Excel"
         
         ExportarAExcel Lista
      
   End Select

   GoTo Salida
   
Mal:

   If Err.Number = -2147217825 Then
      MsgBox "No puede utilizar la opcion BUSCAR en un campo numerico, use otro operador", vbExclamation
   Else
'      MsgBox "Se ha producido un error al buscar ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical
   End If
   Resume

Salida:

End Sub

