VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmCardex 
   Caption         =   "Cardex"
   ClientHeight    =   5895
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11850
   Icon            =   "frmCardex.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5895
   ScaleWidth      =   11850
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame5 
      Height          =   690
      Left            =   9765
      TabIndex        =   36
      Top             =   4455
      Width           =   1185
      Begin VB.OptionButton Option11 
         Caption         =   "Resumido"
         Height          =   195
         Left            =   45
         TabIndex        =   38
         Top             =   405
         Width           =   1005
      End
      Begin VB.OptionButton Option10 
         Caption         =   "Detallado"
         Height          =   195
         Left            =   45
         TabIndex        =   37
         Top             =   180
         Width           =   1005
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "Ubicaciones : "
      Height          =   1005
      Left            =   7245
      TabIndex        =   32
      Top             =   4455
      Width           =   2445
      Begin VB.OptionButton Option8 
         Caption         =   "Todas"
         Height          =   195
         Left            =   360
         TabIndex        =   35
         Top             =   225
         Width           =   825
      End
      Begin VB.OptionButton Option9 
         Caption         =   "Elegir una"
         Height          =   195
         Left            =   1350
         TabIndex        =   34
         Top             =   225
         Width           =   1050
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         Height          =   315
         Index           =   2
         Left            =   405
         TabIndex        =   33
         Top             =   540
         Width           =   1995
         _ExtentX        =   3519
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdUbicacion"
         Text            =   ""
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Depositos : "
      Height          =   465
      Left            =   1710
      TabIndex        =   28
      Top             =   4995
      Width           =   5460
      Begin VB.OptionButton Option6 
         Caption         =   "Todos"
         Height          =   195
         Left            =   675
         TabIndex        =   31
         Top             =   180
         Width           =   825
      End
      Begin VB.OptionButton Option7 
         Caption         =   "Elegir uno"
         Height          =   195
         Left            =   1665
         TabIndex        =   30
         Top             =   180
         Width           =   1050
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         Height          =   315
         Index           =   1
         Left            =   2835
         TabIndex        =   29
         Top             =   90
         Width           =   2535
         _ExtentX        =   4471
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdDeposito"
         Text            =   ""
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Obras : "
      Height          =   465
      Left            =   1710
      TabIndex        =   24
      Top             =   4455
      Width           =   5460
      Begin MSDataListLib.DataCombo DataCombo1 
         Height          =   315
         Index           =   0
         Left            =   2835
         TabIndex        =   27
         Top             =   90
         Width           =   2535
         _ExtentX        =   4471
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdObra"
         Text            =   ""
      End
      Begin VB.OptionButton Option5 
         Caption         =   "Elegir una"
         Height          =   195
         Left            =   1665
         TabIndex        =   26
         Top             =   180
         Width           =   1050
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Todas"
         Height          =   195
         Left            =   675
         TabIndex        =   25
         Top             =   180
         Width           =   825
      End
   End
   Begin VB.TextBox txtCodigoArticulo1 
      Alignment       =   2  'Center
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   300
      Left            =   5265
      TabIndex        =   5
      Top             =   900
      Visible         =   0   'False
      Width           =   1680
   End
   Begin VB.Frame Frame1 
      Height          =   825
      Left            =   3240
      TabIndex        =   2
      Top             =   405
      Width           =   1185
      Begin VB.OptionButton Option3 
         Caption         =   "Por rango"
         Height          =   195
         Left            =   90
         TabIndex        =   22
         Top             =   585
         Width           =   1005
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Elegir uno"
         Height          =   195
         Left            =   90
         TabIndex        =   20
         Top             =   360
         Width           =   1005
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Todos"
         Height          =   195
         Left            =   90
         TabIndex        =   19
         Top             =   135
         Width           =   780
      End
   End
   Begin VB.TextBox txtCodigoArticulo 
      Alignment       =   2  'Center
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   300
      Left            =   5265
      TabIndex        =   3
      Top             =   495
      Width           =   1680
   End
   Begin VB.TextBox txtId 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   10980
      TabIndex        =   15
      Top             =   4635
      Visible         =   0   'False
      Width           =   825
   End
   Begin VB.TextBox txtBusca 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   10620
      TabIndex        =   13
      Top             =   900
      Width           =   1140
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   405
      Index           =   1
      Left            =   45
      TabIndex        =   8
      Top             =   5040
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Mostrar cardex"
      Height          =   405
      Index           =   0
      Left            =   45
      TabIndex        =   7
      Top             =   4455
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   6975
      TabIndex        =   4
      Tag             =   "Articulos"
      Top             =   495
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
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
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   9
      Top             =   5505
      Width           =   11850
      _ExtentX        =   20902
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   4
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   16907
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
            TextSave        =   "26/10/2009"
            Key             =   "Fecha"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3120
      Left            =   0
      TabIndex        =   10
      Top             =   1260
      Width           =   11805
      _ExtentX        =   20823
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
      MouseIcon       =   "frmCardex.frx":076A
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   1035
      Top             =   4500
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
            Picture         =   "frmCardex.frx":0786
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCardex.frx":0898
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCardex.frx":09AA
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCardex.frx":0ABC
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCardex.frx":0BCE
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCardex.frx":0CE0
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCardex.frx":0DF2
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   12
      Top             =   0
      Width           =   11850
      _ExtentX        =   20902
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
            Object.Visible         =   0   'False
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageKey        =   "Buscar"
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   285
      Index           =   0
      Left            =   45
      TabIndex        =   0
      Top             =   855
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   503
      _Version        =   393216
      Format          =   16842753
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   285
      Index           =   1
      Left            =   1845
      TabIndex        =   1
      Top             =   855
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   503
      _Version        =   393216
      Format          =   16842753
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   1
      Left            =   6975
      TabIndex        =   6
      Tag             =   "Articulos"
      Top             =   900
      Visible         =   0   'False
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
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
   Begin VB.Label Label5 
      Caption         =   "Hasta :"
      Height          =   240
      Left            =   4545
      TabIndex        =   23
      Top             =   945
      Visible         =   0   'False
      Width           =   645
   End
   Begin VB.Label Label4 
      Caption         =   "Codigo :"
      Height          =   240
      Left            =   4545
      TabIndex        =   21
      Top             =   540
      Width           =   645
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      Caption         =   "al "
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
      Left            =   1395
      TabIndex        =   18
      Top             =   900
      Width           =   375
   End
   Begin VB.Label Label2 
      Caption         =   "Periodo :"
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
      TabIndex        =   17
      Top             =   495
      Width           =   1050
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Id articulo :"
      Height          =   240
      Index           =   0
      Left            =   11025
      TabIndex        =   16
      Top             =   4410
      Visible         =   0   'False
      Width           =   780
   End
   Begin VB.Label lblLabels 
      Caption         =   "Buscar :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   225
      Index           =   14
      Left            =   10665
      TabIndex        =   14
      Top             =   585
      Width           =   780
   End
   Begin VB.Label Label1 
      Caption         =   "Material :"
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
      Left            =   2115
      TabIndex        =   11
      Top             =   495
      Width           =   1050
   End
End
Attribute VB_Name = "frmCardex"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mClave As Long

Public Sub cmd_Click(index As Integer)

   StatusBar1.Enabled = True
   
   Select Case index
      
      Case 0
      
         If Option2.Value And Not IsNumeric(dcfields(0).BoundText) Then
            MsgBox "Debe ingresar un material!", vbExclamation
            Exit Sub
         End If
      
         Dim mIdArticulo As Long, mIdObra As Long, mIdDeposito As Long
         Dim mIdUbicacion As Long
         Dim mCodigo1 As String, mCodigo2 As String, mArgS1 As String, mArgS2 As String
         
         mCodigo1 = txtCodigoArticulo.Text
         mCodigo2 = txtCodigoArticulo1.Text
         
         If Option1.Value Then mIdArticulo = -1
         If Option2.Value Then mIdArticulo = dcfields(0).BoundText
         If Option3.Value Then mIdArticulo = -2
         
         mIdObra = -1
         If Option5.Value Then mIdObra = DataCombo1(0).BoundText
         
         mIdDeposito = -1
         If Option7.Value Then mIdDeposito = DataCombo1(1).BoundText
         
         mIdUbicacion = -1
         If Option9.Value And IsNumeric(DataCombo1(2).BoundText) Then mIdUbicacion = DataCombo1(2).BoundText
         
         mArgS1 = BuscarClaveINI("Mostrar costos en recepcion de materiales")
         
         mArgS2 = "SI"
         If Option11.Value Then mArgS2 = "NO"
         
         Lista.Sorted = False
         Set Lista.DataSource = Aplicacion.Articulos.TraerFiltrado("_Cardex", _
                     Array(mIdArticulo, DTFields(0).Value, DTFields(1).Value, _
                           mCodigo1, mCodigo2, mIdObra, mIdDeposito, mIdUbicacion, _
                           mArgS1, mArgS2))
         ReemplazarEtiquetasListas Lista
         StatusBar1.Panels(1).Text = " " & Lista.ListItems.Count & " elementos en la lista"

      Case 1
         
         Me.Hide
   
   End Select
   
End Sub

Private Sub dcfields_Change(index As Integer)

   If Len(dcfields(index).BoundText) > 0 And IsNumeric(dcfields(index).BoundText) Then
      Lista.ListItems.Clear
      txtId.Text = dcfields(index).BoundText
      Dim oRs As ADOR.Recordset
      Select Case index
         Case 0, 1
            Set oRs = Aplicacion.Articulos.Item(dcfields(index).BoundText).Registro
            If oRs.RecordCount > 0 Then
               If index = 0 Then
                  txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
               Else
                  txtCodigoArticulo1.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
               End If
            End If
            oRs.Close
      End Select
      Set oRs = Nothing
   End If

End Sub

Private Sub dcfields_GotFocus(index As Integer)

'   If Len(dcfields(0).Text) = 0 Then SendKeys "%{DOWN}"

End Sub

Private Sub dcfields_KeyPress(index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub dcfields_MouseDown(index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)

   If index = 0 Then
      If Button = vbRightButton Then
         If glbMenuPopUpCargado Then
'            Dim cursorPos As POINTAPI
'            GetCursorPos cursorPos
'            TrackPopupMenu POP_hMenu, TPM_HORNEGANIMATION, cursorPos.x, cursorPos.y, 0, Me.hwnd, ByVal 0&
'            DoEvents
'            If POP_Key > 0 Then
'               dcfields(0).BoundText = POP_Key
'            End If
         Else
            MsgBox "No se ha cargado el menu de materiales", vbInformation
         End If
      End If
   End If

End Sub

Private Sub Form_Load()

   StatusBar1.Enabled = False
   
   If glbMenuPopUpCargado Then ActivarPopUp Me

'   Set dcfields(0).RowSource = Aplicacion.Articulos.TraerFiltrado("_ListaParaCardex")
   Set dcfields(0).RowSource = Aplicacion.Articulos.TraerLista
   Set dcfields(1).RowSource = Aplicacion.Articulos.TraerLista
   DTFields(0).Value = DateSerial(2000, 1, 1)
   DTFields(1).Value = Date
   Option2.Value = True
   
   Set DataCombo1(0).RowSource = Aplicacion.Obras.TraerLista
   If glbIdObraAsignadaUsuario > 0 Then
      Option5.Value = True
      With DataCombo1(0)
         .BoundText = glbIdObraAsignadaUsuario
         .Enabled = False
      End With
      Frame2.Enabled = False
   Else
      Option4.Value = True
   End If
   Option6.Value = True
   Option8.Value = True
   Option10.Value = True

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   If glbMenuPopUpCargado Then DesactivarPopUp Me

End Sub

Private Sub Form_Paint()

   'Degradado Me

End Sub

Private Sub Lista_DblClick()

   If Lista.ListItems.Count > 0 Then
      EditarComprobante Lista.SelectedItem.SubItems(1), Lista.SelectedItem.SubItems(2)
   End If

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      dcfields(0).Enabled = False
      txtCodigoArticulo.Enabled = False
      Label4.Caption = "Codigo :"
      dcfields(1).Visible = False
      txtCodigoArticulo1.Visible = False
      Label5.Visible = False
      txtBusca.Enabled = False
   End If

End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      dcfields(0).Enabled = True
      txtCodigoArticulo.Enabled = True
      Label4.Caption = "Codigo :"
      dcfields(1).Visible = False
      txtCodigoArticulo1.Visible = False
      Label5.Visible = False
      txtBusca.Enabled = True
   End If

End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      dcfields(0).Enabled = True
      txtCodigoArticulo.Enabled = True
      Label4.Caption = "Desde :"
      dcfields(1).Visible = True
      txtCodigoArticulo1.Visible = True
      Label5.Visible = True
      txtBusca.Enabled = True
   End If

End Sub

Private Sub Option4_Click()

   If Option4.Value Then
      With DataCombo1(0)
         .BoundText = 0
         .Enabled = False
      End With
   End If

End Sub

Private Sub Option5_Click()

   If Option5.Value Then
      DataCombo1(0).Enabled = True
   End If

End Sub

Private Sub Option6_Click()

   If Option6.Value Then
      DataCombo1(1).Enabled = False
   End If

End Sub

Private Sub Option7_Click()

   If Option7.Value Then
      Dim mIdObra As Long
      mIdObra = -1
      If Option5.Value And IsNumeric(DataCombo1(0).BoundText) Then
         mIdObra = DataCombo1(0).BoundText
      End If
      With DataCombo1(1)
         Set .RowSource = Aplicacion.Depositos.TraerFiltrado("_PorIdObraParaCombo", mIdObra)
         .Enabled = True
      End With
   End If

End Sub

Private Sub Option8_Click()

   If Option8.Value Then
      DataCombo1(2).Enabled = False
   End If

End Sub

Private Sub Option9_Click()

   If Option9.Value Then
      Dim mIdObra As Long, mIdDeposito As Long
      mIdObra = -1
      If Option5.Value And IsNumeric(DataCombo1(0).BoundText) Then
         mIdObra = DataCombo1(0).BoundText
      End If
      mIdDeposito = -1
      If Option7.Value And IsNumeric(DataCombo1(1).BoundText) Then
         mIdDeposito = DataCombo1(1).BoundText
      End If
      With DataCombo1(2)
         Set .RowSource = Aplicacion.Ubicaciones.TraerFiltrado("_PorObra", Array(mIdObra, mIdDeposito))
         .Enabled = True
      End With
   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Dim s As String
   Dim fl As Integer, cl As Integer
   Dim oEx As Excel.Application
   Dim oL As ListItem
   Dim oS As ListSubItem
   Dim oCol As ColumnHeader
   
   On Error GoTo Mal
   
   Select Case Button.Key
      
      Case "Imprimir"
         
         Set oEx = CreateObject("Excel.Application")
         
         With oEx
            
            .Visible = False
            
            With .Workbooks.Add(glbPathPlantillas & "\PlanillaA.xlt")
               
               With .ActiveSheet

                  .Name = "Cardex"
                  
                  cl = 1
                  
                  .Cells(2, cl) = "Movimientos correspondientes al material : " & dcfields(0).Text
                  
                  For Each oCol In Lista.ColumnHeaders
                     .Cells(4, cl) = oCol.Text
                     cl = cl + 1
                  Next
      
                  fl = 5
                  For Each oL In Lista.ListItems
                     cl = 1
                     If Len(Trim(oL.Text)) = 0 Then
                        .Cells(fl, cl) = "_"
                     Else
                        .Cells(fl, cl) = oL.Text
                     End If
                     For Each oS In oL.ListSubItems
                        cl = cl + 1
                        If Len(Trim(oS.Text)) = 0 Then
                           .Cells(fl, cl) = "_"
                        Else
                           .Cells(fl, cl) = oS.Text
                        End If
                     Next
                     fl = fl + 1
                  Next
                  
                  .Range("A1").Select
               
               End With
               
               oEx.Run "ArmarFormato"
               oEx.ActiveWindow.SelectedSheets.PrintOut Copies:=1, Collate:=True
    
              .Close False
            
            End With
            
            .Quit
         
         End With
         
         Set oEx = Nothing
         
      Case "Buscar"
         
         FiltradoLista Lista
         StatusBar1.Panels(1).Text = " " & Lista.ListItems.Count & " elementos en la lista"

      Case "Excel"
         
         s = "Cardex|Materiales : "
         If Option1.Value Then
            s = s & "Todos"
         ElseIf Option2.Value Then
            s = s & dcfields(0).Text
         Else
            s = s & "del " & txtCodigoArticulo & " al " & txtCodigoArticulo1
         End If
         
         s = s & "|Obras : "
         If Option4.Value Then
            s = s & "Todas"
         Else
            s = s & DataCombo1(0).Text
         End If
         
         s = s & "|Depositos : "
         If Option6.Value Then
            s = s & "Todos"
         Else
            s = s & DataCombo1(1).Text
         End If
         
         s = s & "|Ubicaciones : "
         If Option8.Value Then
            s = s & "Todas"
         Else
            s = s & DataCombo1(2).Text
         End If
         
         ExportarAExcel Lista, s
      
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

Private Sub txtBusca_GotFocus()

   With txtBusca
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBusca_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      If KeyAscii = 13 Then
         Dim oAp As ComPronto.Aplicacion
         Set oAp = Aplicacion
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set dcfields(0).RowSource = oAp.Articulos.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set dcfields(0).RowSource = oAp.Articulos.TraerLista
         End If
         Set oAp = Nothing
      End If
      dcfields(0).Text = ""
      dcfields(0).SetFocus
'      SendKeys "%{DOWN}"
   End If

End Sub

Private Sub txtCodigoArticulo_GotFocus()

   With txtCodigoArticulo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoArticulo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCodigoArticulo_Validate(Cancel As Boolean)

   If Len(txtCodigoArticulo.Text) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo.Text)
      If oRs.RecordCount > 0 Then
         dcfields(0).BoundText = oRs.Fields(0).Value
      Else
         If Not Option3.Value Then
            MsgBox "Codigo de material incorrecto", vbExclamation
            Cancel = True
            txtCodigoArticulo.Text = ""
            dcfields(0).Text = ""
         Else
            dcfields(0).Text = ""
         End If
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

Private Sub txtCodigoArticulo1_GotFocus()

   With txtCodigoArticulo1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoArticulo1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtCodigoArticulo1_Validate(Cancel As Boolean)

   If Len(txtCodigoArticulo1.Text) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo1.Text)
      If oRs.RecordCount > 0 Then
         dcfields(1).BoundText = oRs.Fields(0).Value
      Else
         If Not Option3.Value Then
            MsgBox "Codigo de material incorrecto", vbExclamation
            Cancel = True
            txtCodigoArticulo.Text = ""
            dcfields(1).Text = ""
         Else
            dcfields(1).Text = ""
         End If
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

Private Sub EditarComprobante(ByVal TipoComprobante As Long, ByVal Identificador As Long)

   Dim oF As Form
      
   Select Case TipoComprobante
      Case 1
         'Set oF = New frmAjustesStock
      Case 2
         'Set oF = New frmSalidasMateriales
      Case 3
         'Set oF = New frmRecepciones
      Case 4
         'Set oF = New frmOtrosIngresosAlmacen
      Case 5
         'Set oF = New frmRemitos
      Case 6
         'Set oF = New frmDevoluciones
      
      Case Else
         MsgBox "Comprobante no editable"
         GoTo Salida:
   End Select
   
   With oF
      .Id = Identificador
      .Disparar = ActL
      .Show vbModal, Me
   End With

Salida:

   Set oF = Nothing

End Sub
