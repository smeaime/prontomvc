VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.3#0"; "Controles1013.ocx"
Object = "{126E538A-EE41-4B22-A045-F8D5538F5D2B}#1.0#0"; "FileBrowser1.ocx"
Object = "{BE38695A-739A-4A6C-BF54-931FC1415984}#1.0#0"; "VividThumbNails.ocx"
Begin VB.Form frmConsultaSimpleConCheck 
   Caption         =   "Form1"
   ClientHeight    =   1995
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   4440
   LinkTopic       =   "Form1"
   ScaleHeight     =   1995
   ScaleWidth      =   4440
   StartUpPosition =   1  'CenterOwner
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   1
      ItemData        =   "frmConsultaSimpleConCheck.frx":0000
      Left            =   1935
      List            =   "frmConsultaSimpleConCheck.frx":000D
      TabIndex        =   32
      Top             =   4815
      Visible         =   0   'False
      Width           =   2085
   End
   Begin VB.Frame Frame3 
      Height          =   3165
      Left            =   3555
      TabIndex        =   21
      Top             =   3960
      Visible         =   0   'False
      Width           =   1455
      Begin VB.CheckBox Check3 
         Caption         =   "Check3"
         Height          =   195
         Index           =   9
         Left            =   90
         TabIndex        =   31
         Top             =   2835
         Width           =   1320
      End
      Begin VB.CheckBox Check3 
         Caption         =   "Check3"
         Height          =   195
         Index           =   8
         Left            =   90
         TabIndex        =   30
         Top             =   2565
         Width           =   1320
      End
      Begin VB.CheckBox Check3 
         Caption         =   "Check3"
         Height          =   195
         Index           =   7
         Left            =   90
         TabIndex        =   29
         Top             =   2295
         Width           =   1320
      End
      Begin VB.CheckBox Check3 
         Caption         =   "Check3"
         Height          =   195
         Index           =   6
         Left            =   90
         TabIndex        =   28
         Top             =   2025
         Width           =   1320
      End
      Begin VB.CheckBox Check3 
         Caption         =   "Check3"
         Height          =   195
         Index           =   5
         Left            =   90
         TabIndex        =   27
         Top             =   1725
         Width           =   1320
      End
      Begin VB.CheckBox Check3 
         Caption         =   "Check3"
         Height          =   195
         Index           =   4
         Left            =   90
         TabIndex        =   26
         Top             =   1425
         Width           =   1320
      End
      Begin VB.CheckBox Check3 
         Caption         =   "Check3"
         Height          =   195
         Index           =   3
         Left            =   90
         TabIndex        =   25
         Top             =   1125
         Width           =   1320
      End
      Begin VB.CheckBox Check3 
         Caption         =   "Check3"
         Height          =   195
         Index           =   2
         Left            =   90
         TabIndex        =   24
         Top             =   825
         Width           =   1320
      End
      Begin VB.CheckBox Check3 
         Caption         =   "Check3"
         Height          =   195
         Index           =   1
         Left            =   90
         TabIndex        =   23
         Top             =   525
         Width           =   1320
      End
      Begin VB.CheckBox Check3 
         Caption         =   "Check3"
         Height          =   195
         Index           =   0
         Left            =   90
         TabIndex        =   22
         Top             =   225
         Width           =   1320
      End
   End
   Begin VB.CommandButton cmd 
      Height          =   315
      Index           =   2
      Left            =   0
      TabIndex        =   20
      Top             =   0
      Visible         =   0   'False
      Width           =   495
   End
   Begin VB.Frame Frame2 
      Caption         =   "Archivo : "
      Height          =   1410
      Left            =   3510
      TabIndex        =   12
      Top             =   2070
      Visible         =   0   'False
      Width           =   2130
      Begin VB.OptionButton Option9 
         Caption         =   "Importar CAE ventas"
         Height          =   195
         Left            =   45
         TabIndex        =   19
         Top             =   1125
         Width           =   1995
      End
      Begin VB.OptionButton Option8 
         Caption         =   "Norm.70/07 Bs. As."
         Height          =   195
         Left            =   45
         TabIndex        =   18
         Top             =   900
         Width           =   1995
      End
      Begin VB.OptionButton Option7 
         Caption         =   "Embargos rentas"
         Height          =   195
         Left            =   45
         TabIndex        =   17
         Top             =   675
         Width           =   1635
      End
      Begin VB.OptionButton Option6 
         Caption         =   "SUSS"
         Height          =   195
         Left            =   990
         TabIndex        =   16
         Top             =   450
         Width           =   1095
      End
      Begin VB.OptionButton Option5 
         Caption         =   "ReproWeb"
         Height          =   195
         Left            =   990
         TabIndex        =   15
         Top             =   225
         Width           =   1095
      End
      Begin VB.OptionButton Option4 
         Caption         =   "RG 17"
         Height          =   195
         Left            =   45
         TabIndex        =   14
         Top             =   450
         Width           =   960
      End
      Begin VB.OptionButton Option3 
         Caption         =   "RG 830"
         Height          =   195
         Left            =   45
         TabIndex        =   13
         Top             =   225
         Width           =   960
      End
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   0
      ItemData        =   "frmConsultaSimpleConCheck.frx":002D
      Left            =   45
      List            =   "frmConsultaSimpleConCheck.frx":002F
      TabIndex        =   11
      Top             =   4815
      Visible         =   0   'False
      Width           =   1860
   End
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   0
      TabIndex        =   10
      Top             =   2115
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   0
      TabIndex        =   9
      Top             =   1800
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   2385
      TabIndex        =   8
      Top             =   1215
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Height          =   195
      Left            =   3195
      TabIndex        =   7
      Top             =   1035
      Visible         =   0   'False
      Width           =   330
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Height          =   195
      Left            =   3195
      TabIndex        =   6
      Top             =   765
      Visible         =   0   'False
      Width           =   330
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   5
      Top             =   1395
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1890
      TabIndex        =   4
      Top             =   1395
      Width           =   1485
   End
   Begin VB.TextBox text1 
      Height          =   285
      Left            =   1890
      TabIndex        =   3
      Top             =   360
      Width           =   1215
   End
   Begin VB.Frame Frame1 
      Height          =   510
      Left            =   135
      TabIndex        =   0
      Top             =   1080
      Visible         =   0   'False
      Width           =   3165
      Begin VB.OptionButton Option2 
         Height          =   195
         Left            =   1485
         TabIndex        =   2
         Top             =   225
         Width           =   1590
      End
      Begin VB.OptionButton Option1 
         Height          =   195
         Left            =   135
         TabIndex        =   1
         Top             =   225
         Width           =   1320
      End
   End
   Begin RichTextLib.RichTextBox RichTextBox2 
      Height          =   465
      Left            =   3555
      TabIndex        =   33
      Top             =   135
      Visible         =   0   'False
      Width           =   330
      _ExtentX        =   582
      _ExtentY        =   820
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmConsultaSimpleConCheck.frx":0031
   End
   Begin RichTextLib.RichTextBox RichTextBox1 
      Height          =   465
      Left            =   3195
      TabIndex        =   34
      Top             =   135
      Visible         =   0   'False
      Width           =   330
      _ExtentX        =   582
      _ExtentY        =   820
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmConsultaSimpleConCheck.frx":00BC
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   285
      Index           =   1
      Left            =   1890
      TabIndex        =   35
      Top             =   720
      Visible         =   0   'False
      Width           =   1260
      _ExtentX        =   2223
      _ExtentY        =   503
      _Version        =   393216
      Format          =   57147393
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   285
      Index           =   0
      Left            =   1890
      TabIndex        =   36
      Top             =   0
      Visible         =   0   'False
      Width           =   1260
      _ExtentX        =   2223
      _ExtentY        =   503
      _Version        =   393216
      Format          =   57147393
      CurrentDate     =   36377
   End
   Begin Controles1013.DbListView Lista 
      Height          =   600
      Left            =   45
      TabIndex        =   37
      Top             =   720
      Visible         =   0   'False
      Width           =   555
      _ExtentX        =   979
      _ExtentY        =   1058
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaSimpleConCheck.frx":0147
      MultiSelect     =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   285
      Index           =   2
      Left            =   2295
      TabIndex        =   38
      Top             =   1755
      Visible         =   0   'False
      Width           =   1260
      _ExtentX        =   2223
      _ExtentY        =   503
      _Version        =   393216
      Format          =   57147393
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   2115
      TabIndex        =   39
      Top             =   2385
      Visible         =   0   'False
      Width           =   1275
      _ExtentX        =   2249
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   1
      Left            =   2115
      TabIndex        =   40
      Top             =   2745
      Visible         =   0   'False
      Width           =   1275
      _ExtentX        =   2249
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin MSComctlLib.ImageList img16 
      Left            =   0
      Top             =   3105
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   11
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimpleConCheck.frx":0163
            Key             =   "Cerrado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimpleConCheck.frx":0FB5
            Key             =   "SinDefinicion"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimpleConCheck.frx":12CF
            Key             =   "Abierto_1"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimpleConCheck.frx":15E9
            Key             =   "Abierto_2"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimpleConCheck.frx":1A3B
            Key             =   "Abierto_3"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimpleConCheck.frx":1E8D
            Key             =   "Abierto_4"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimpleConCheck.frx":21A7
            Key             =   "Abierto_5"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimpleConCheck.frx":25F9
            Key             =   "Abierto_6"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimpleConCheck.frx":2913
            Key             =   "Abierto_7"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimpleConCheck.frx":2C2D
            Key             =   "Abierto_8"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaSimpleConCheck.frx":2F47
            Key             =   "Abierto_9"
         EndProperty
      EndProperty
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   45
      TabIndex        =   41
      Top             =   3645
      Visible         =   0   'False
      Width           =   3345
      _ExtentX        =   5900
      _ExtentY        =   582
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
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   2
      Left            =   2070
      TabIndex        =   42
      Top             =   3150
      Visible         =   0   'False
      Width           =   1275
      _ExtentX        =   2249
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin VividThumbNails.VividThumbs VividThumbs1 
      Height          =   1995
      Left            =   90
      TabIndex        =   43
      Top             =   5265
      Visible         =   0   'False
      Width           =   4425
      _ExtentX        =   7805
      _ExtentY        =   3519
      tWidth          =   40
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   825
      Left            =   90
      TabIndex        =   44
      Top             =   7380
      Visible         =   0   'False
      Width           =   4425
      _ExtentX        =   7805
      _ExtentY        =   1455
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmConsultaSimpleConCheck.frx":3261
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   1935
      Index           =   0
      Left            =   90
      TabIndex        =   45
      Top             =   8325
      Visible         =   0   'False
      Width           =   4650
      _ExtentX        =   8202
      _ExtentY        =   3413
      _Version        =   393216
      Style           =   1
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "Label3"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   555
      Left            =   135
      TabIndex        =   53
      Top             =   4140
      Visible         =   0   'False
      Width           =   2625
   End
   Begin VB.Label Label2 
      Height          =   240
      Index           =   5
      Left            =   585
      TabIndex        =   52
      Top             =   2745
      Visible         =   0   'False
      Width           =   1350
   End
   Begin VB.Label Label2 
      Height          =   240
      Index           =   4
      Left            =   630
      TabIndex        =   51
      Top             =   2430
      Visible         =   0   'False
      Width           =   1350
   End
   Begin VB.Label Label2 
      Height          =   240
      Index           =   3
      Left            =   630
      TabIndex        =   50
      Top             =   2115
      Visible         =   0   'False
      Width           =   1350
   End
   Begin VB.Label Label2 
      Height          =   240
      Index           =   2
      Left            =   675
      TabIndex        =   49
      Top             =   1800
      Visible         =   0   'False
      Width           =   1350
   End
   Begin VB.Label Label2 
      Height          =   240
      Index           =   1
      Left            =   270
      TabIndex        =   48
      Top             =   765
      Visible         =   0   'False
      Width           =   1350
   End
   Begin VB.Label Label2 
      Height          =   240
      Index           =   0
      Left            =   270
      TabIndex        =   47
      Top             =   45
      Visible         =   0   'False
      Width           =   1350
   End
   Begin VB.Label Label1 
      Height          =   240
      Left            =   270
      TabIndex        =   46
      Top             =   405
      Width           =   1350
   End
End
Attribute VB_Name = "frmConsultaSimpleConCheck"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public Ok As Boolean
Private mvarId As Long, mIdProveedor As Long
Private mParametros As String, mArbolItem As String
Private BienesGenerados As Boolean
Dim actL2 As ControlForm

Public Filas


Public mRecordset As Recordset

Public Property Let Id(ByVal vNewValue As Recordset)

   Set mRecordset = vNewValue
   
   Dim oL As ListItem
   
   
       Set Lista.DataSource = mRecordset
   
End Property

Private Sub Check1_Click()

'   If Check1.Value = 1 Then
 '     If Me.Id = 13 Then
'         Dim oL As ListItem
'         For Each oL In Lista.ListItems
'            oL.Checked = False
'         Next
'         Lista.Enabled = False
'      End If
'   Else
''         Lista.Enabled = True
 '     End If
'   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then

 Filas = VBA.Split(Lista.GetStringCheck, vbCrLf)
      'GenerarListaDeElegidos
      Ok = True

   ElseIf Index = 1 Then
      
      Ok = False

   End If

   Me.Hide
   
End Sub

Private Sub Combo1_Click(Index As Integer)

'   If Index = 0 Then
'      If Me.Id = 2 Then
'         Select Case Combo1(Index).ListIndex
'            Case 0
'               Set Lista.DataSource = Aplicacion.Pedidos.TraerFiltrado("_Exterior")
'               cmd(0).Enabled = True
'         End Select
'      ElseIf Me.Id = 16 Then
'         Me.Hide
'      End If
'   End If

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub dcfields_Change(Index As Integer)

'   If IsNumeric(dcfields(Index).BoundText) Then
'      Select Case Index
'         Case 0
'            If Me.Id = 19 Then
'               Set dcfields(1).RowSource = Aplicacion.Subcontratos.TraerFiltrado("_EtapasParaCombo", dcfields(Index).BoundText)
'            End If
'      End Select
'   End If

End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   SetDataComboDropdownListWidth 600
   
End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub FileBrowser1_Change(Index As Integer)

   If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
      FileBrowser1(Index).InitDir = FileBrowser1(Index).Text
   End If
   
End Sub

Private Sub Form_Activate()

   'If Me.Id = 3 Then InicializarSmallicons

End Sub

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

  ' Degradado Me
   
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   Set actL2 = Nothing

End Sub

Private Sub Form_Resize()

   'If Lista.Visible Then Ajustar

End Sub

Private Sub Lista_DblClick()

   If Not Lista.SelectedItem Is Nothing Then
      Select Case mvarId
         Case 1
            Dim oF As frmArticulos
            Set oF = New frmArticulos
            With oF
               .Id = Lista.SelectedItem.SubItems(2)
               .Disparar = Nothing
               .Cmd(0).Enabled = True
               .Show vbModal, Me
            End With
            Unload oF
            Set oF = Nothing
      End Select
   End If

End Sub

Private Sub Lista_ItemCheck(ByVal Item As MSComctlLib.IListItem)

'   If Me.Id = 3 Then
'      If Item.Checked Then
'         Item.SmallIcon = "Cerrado"
'         Item.SubItems(4) = 0
'         Item.SubItems(5) = 5
'      Else
'         Item.SmallIcon = "SinDefinicion"
'         Item.SubItems(4) = 1
'         Item.SubItems(5) = 0
'      End If
'   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

'   If Button = vbRightButton Then
'      If Me.Id = 3 Then
'         If Not Lista.SelectedItem Is Nothing Then
'            If Lista.ListItems.Count > 0 Then
'               PopupMenu MnuDet
'            End If
'         End If
'      ElseIf Me.Id = 5 Then
'         PopupMenu MnuDet1
'      ElseIf Me.Id = 14 Then
'         PopupMenu MnuDet2
'      End If
'   End If

End Sub

Private Sub MnuDet1A_Click(Index As Integer)

'   If Me.Id = 5 Then
'      Select Case Index
'         Case 0
'            With Label2(0)
'               .TOp = cmd(1).TOp
'               .Left = cmd(1).Left + cmd(1).Width + 10
'               .Width = cmd(1).Width
'               .Caption = "Base datos :"
'               .Visible = True
'            End With
'            With dcfields(0)
'               .TOp = cmd(0).TOp
'               .Left = 300
'               .Width = cmd(0).Width * 1.5
'               If Not Lista.SelectedItem Is Nothing Then
'                  .Text = Lista.SelectedItem.SubItems(1)
'               End If
'               .Visible = True
'            End With
'            With Label2(1)
'               .TOp = Label2(0).TOp + Label2(0).Height + 10
'               .Left = Label2(0).Left
'               .Width = Label2(0).Width / 2
'               .Caption = "Orden :"
'               .Visible = True
'            End With
'            With text1
'               .TOp = Label2(1).TOp
'               .Left = Label2(1).Left + Label2(1).Width + 10
'               .Width = Label2(1).Width / 2
'               If Not Lista.SelectedItem Is Nothing Then
'                  .Text = Lista.SelectedItem.Text
'               End If
'               .Visible = True
'            End With
'            With Label2(2)
'               .TOp = Label2(1).TOp
'               .Left = text1.Left + text1.Width + 10
'               .Width = Label2(0).Width / 2
'               .Caption = "Numeral :"
'               .Visible = True
'            End With
'            With Text2
'               .TOp = Label2(2).TOp
'               .Left = Label2(2).Left + Label2(2).Width + 10
'               .Width = Label2(1).Width / 2
'               If Not Lista.SelectedItem Is Nothing Then
'                  .Text = Lista.SelectedItem.SubItems(2)
'               End If
'               .Visible = True
'            End With
'            With cmd(2)
'               .Caption = "Ok"
'               .TOp = cmd(0).TOp
'               .Left = 455
'               .Visible = True
'            End With
'            cmd(0).Enabled = False
'         Case 1
'            If Not Lista.SelectedItem Is Nothing Then
'               Lista.ListItems.Remove (Lista.object.SelectedItem.Index)
'            End If
'      End Select
'   End If

End Sub

Private Sub MnuDet2A_Click(Index As Integer)
'
'   If Me.Id = 13 Or Me.Id = 14 Then
'      Dim oL As ListItem
'      For Each oL In Lista.ListItems
'         If Index = 0 Then
'            oL.Checked = True
'         ElseIf Index = 1 Then
'            oL.Checked = False
'         End If
'      Next
'   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

'   If Me.Id = 3 Then
'      Dim oL As ListItem
'      For Each oL In Lista.ListItems
'         If oL.Selected Then
'            If Index = 0 Then
'               oL.SmallIcon = "Cerrado"
'               oL.SubItems(4) = 0
'               oL.SubItems(5) = 5
'            Else
'               oL.SmallIcon = "Abierto_" & Index
'               oL.SubItems(4) = 1
'               oL.SubItems(5) = Index
'            End If
'            oL.Checked = True
'         End If
'      Next
'   End If

End Sub

Private Sub Option1_Click()
   
'   If Option1.Value Then
'      If Me.Id = 10 Then
'         Label1.Visible = False
'         FileBrowser1(0).Visible = False
'
'      End If
'   End If

End Sub

Private Sub Option2_Click()

'   If Option2.Value Then
'      If Me.Id = 10 Then
'         Label1.Visible = True
'         FileBrowser1(0).Visible = True
'
'      End If
'   End If

End Sub

Private Sub Text1_GotFocus()

   With text1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Sub Ajustar()

   Dim Altura As Long
   Dim Ancho As Long
   
   Ancho = Me.ScaleWidth
   Altura = Me.ScaleHeight
   
   On Error Resume Next
   
   With Lista
      .TOp = 0
      .Left = 0
      .Height = Altura
      .Width = Ancho
   End With

End Sub

Public Property Get Id() As Recordset

   'Id = mvarId

End Property

Public Property Get Parametros() As String

   Parametros = mParametros

End Property

Public Property Let Parametros(ByVal vNewValue As String)

   mParametros = vNewValue

End Property

Private Sub GenerarBienesDeUso()

   Dim oAp As ComPronto.Aplicacion
   Dim oArt As ComPronto.Articulo
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim i As Integer, j As Integer
   Dim mCodigo As Long
   Dim mCantidad As Double, mValor As Double, mImporte As Double
   Dim mFechaAlta As Date, mFechaCompra As Date
   Dim mDocumentoAlta As String, mComprobanteCompra As String
   Dim mVector
   
   mVector = VBA.Split(Me.Parametros, "|")
   mCantidad = mVector(1)
   mImporte = Val(mVector(2))
   mDocumentoAlta = mVector(3)
   mFechaCompra = CDate(mVector(4))
   mComprobanteCompra = mVector(5)
   
   mValor = 0
   If mCantidad > 0 Then mValor = mImporte / mCantidad
   mCodigo = Val(text1.Text)
   mFechaAlta = Now
   
   Set oAp = Aplicacion

   Set oRs = oAp.Articulos.TraerFiltrado("_PorId", mVector(0))
   If oRs.RecordCount > 0 Then
      For i = 1 To mCantidad
         Set oArt = oAp.Articulos.Item(-1)
         With oArt
            With .Registro
               For j = 1 To oRs.Fields.Count - 1
                  .Fields(j).Value = oRs.Fields(j).Value
               Next
               .Fields("Codigo").Value = mCodigo
               .Fields("NumeroInventario").Value = mCodigo
               .Fields("Activo").Value = "SI"
               .Fields("DocumentoAlta").Value = mDocumentoAlta
               .Fields("ValorCompra").Value = mValor
               .Fields("CalculaAmortizacion").Value = "SI"
               .Fields("A�oAlta").Value = Year(Date)
               .Fields("ComprobanteCompra").Value = mComprobanteCompra
               .Fields("FechaPrimeraAmortizacionContable").Value = Date
               .Fields("ValorOrigenContable").Value = mValor
               .Fields("FechaCompra").Value = mFechaCompra
               .Fields("Amortiza").Value = "SI"
               .Fields("BienContable").Value = "SI"
               .Fields("ActivoFijo").Value = "SI"
               .Fields("FechaAlta").Value = mFechaAlta
               .Fields("UsuarioAlta").Value = glbNombreUsuario
            End With
            .Guardar
         End With
         Set oArt = Nothing
         mCodigo = mCodigo + 1
      Next
   End If
   oRs.Close
   
   Set oPar = oAp.Parametros.Item(1)
   oPar.Registro.Fields("ProximoCodigoArticulo").Value = mCodigo
   oPar.Guardar
   Set oPar = Nothing
   
   Set oRs = oAp.Articulos.TraerFiltrado("_PorFechaAlta", mFechaAlta)
   Set Lista.DataSource = oRs
   
   Set oRs = Nothing
   Set oAp = Nothing

End Sub

Public Sub GenerarComprobantesEnXML()

   Dim s As String, sXML As String, mPathSaliente As String, mArchivo As String
   Dim mNumeroPedido As String
   Dim i As Integer
   Dim oRs As ADOR.Recordset
   Dim oFld As Field
   Dim oXML As MSXML.DOMDocument
   Dim Filas, Columnas
   
   mPathSaliente = "C:\"
   s = Lista.GetStringCheck
   Filas = VBA.Split(s, vbCrLf)
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      Select Case Combo1(0).ListIndex
         Case 0
            'Set oRs = CopiarTodosLosRegistros(Aplicacion.Pedidos.TraerFiltrado("_PorIdParaCOMEX", Columnas(2)))
            mNumeroPedido = "" & oRs.Fields("Pedido").Value
            For Each oFld In oRs.Fields
               If oFld.type = adLongVarWChar And Not IsNull(oFld.Value) Then
                  RichTextBox1.TextRTF = oFld.Value
                  oFld.Value = RichTextBox1.Text
               End If
            Next
            oRs.Update
            mArchivo = mPathSaliente & "Pedido_" & mNumeroPedido & ".xml"
            sXML = ArmarXML(oRs)
            Set oXML = CreateObject("MSXML.DOMDocument")
            oXML.loadXML sXML
            oXML.Save mArchivo
            Set oXML = Nothing
      
            'Set oRs = CopiarTodosLosRegistros(Aplicacion.Pedidos.TraerFiltrado("_PorIdParaCOMEXDetalles", Columnas(2)))
            For Each oFld In oRs.Fields
               If oFld.type = adLongVarWChar And Not IsNull(oFld.Value) Then
                  RichTextBox1.TextRTF = oFld.Value
                  oFld.Value = RichTextBox1.Text
               End If
            Next
            oRs.Update
            mArchivo = mPathSaliente & "PedidoDetalle_" & mNumeroPedido & ".xml"
            sXML = ArmarXML(oRs)
            Set oXML = CreateObject("MSXML.DOMDocument")
            oXML.loadXML sXML
            oXML.Save mArchivo
            Set oXML = Nothing
      End Select
   Next
   
   Set oRs = Nothing

End Sub

Public Sub GuardarPermisosPorItem()

   Dim oL As ListItem
   For Each oL In Lista.ListItems
      Aplicacion.Tarea "EmpleadosAccesos_Actualizar", _
         Array(oL.SubItems(2), oL.SubItems(1), Me.ArbolItem, oL.SubItems(4), oL.SubItems(5))
   Next

End Sub

Public Sub InicializarSmallicons()

   Dim oL As ListItem
   For Each oL In Lista.ListItems
      If oL.SubItems(2) = -1 Then
         oL.SmallIcon = "SinDefinicion"
      Else
         If oL.SubItems(4) = 0 And oL.SubItems(5) > 0 Then
            oL.SmallIcon = "Cerrado"
            oL.Checked = True
         Else
            If Len(oL.SubItems(5)) = 0 Or oL.SubItems(5) <= 0 Then
               oL.SmallIcon = "SinDefinicion"
            Else
               oL.SmallIcon = "Abierto_" & oL.SubItems(5)
               oL.Checked = True
            End If
         End If
      End If
   Next

End Sub

Public Property Get ArbolItem() As String

   ArbolItem = mArbolItem

End Property

Public Property Let ArbolItem(ByVal vNewValue As String)

   mArbolItem = vNewValue

End Property



Public Sub GenerarListaDeElegidos()
   Dim oRs As ADOR.Recordset
   Dim mCopias As Integer, i As Integer, j As Integer
   Dim lStatus As Long, mNumero As Long, mIdPresupuesto As Long, mSubNumero As Long
   Dim mFormulario As String, mPlantilla As String, s As String, mLista As String, mSubject As String, mBody As String
   Dim mAttachment As String, mPathArchivosExportados As String, mSeleccion As String
   Dim Columnas, mAux1
   Dim goMailOL As CEmailOL
   Dim Ids
   
   On Error GoTo Mal

   mCopias = 1
   mFormulario = "A4"
   mBody = ""
   mAttachment = ""
   
   
   
   ' modificacion porque la tabla de parametros no banca mas de 50 chars
   ' agregado del nombre de la empresa como uno de los parametros a la URL
   
   mAux1 = TraerValorParametro2("HostProntoWeb") 'http://www.bdlconsultores.com
   mBody = Trim(IIf(IsNull(mAux1), "", mAux1))
   
   mAux1 = TraerValorParametro2("PaginaSolicitudesCotizacion") '/Pronto/ProntoWeb/Presupuesto.aspx
   mBody = mBody & Trim(IIf(IsNull(mAux1), "", mAux1))
   
   
  
   
   Dim tempBody As String
   
  
   s = Me.Parametros
   Ids = VBA.Split(s, "|")
   For i = 0 To UBound(Ids)
      Set oRs = Aplicacion.Presupuestos.TraerFiltrado("_PorId", Ids(i))
      mNumero = 0
      If oRs.RecordCount > 0 Then
         mNumero = IIf(IsNull(oRs.Fields("Numero").Value), 0, oRs.Fields("Numero").Value)
         mSubNumero = IIf(IsNull(oRs.Fields("Subnumero").Value), 0, oRs.Fields("Subnumero").Value)
         mIdPresupuesto = oRs.Fields("IdPresupuesto").Value
      End If
      oRs.Close
      
      Filas = VBA.Split(Lista.GetStringCheck, vbCrLf)
      For j = 1 To UBound(Filas)
         Columnas = VBA.Split(Filas(j), vbTab)
         mLista = Columnas(4)
         mSubject = "" & glbEmpresa & " - Solicitud de cotizacion : " & Format(mNumero, "00000000") & "/" & mSubNumero
           
         'agrego el Id del comprobante y el nombre de la empresa
         tempBody = mBody & "?Id=" & mIdPresupuesto & "&Empresa=" & gblBD
         tempBody = Replace(tempBody, " ", "%20") 'reemplazo los espacios (no todos los exploradores se los bancan)
         lStatus = goMailOL.Send(mLista, True, mSubject, tempBody, mAttachment)
      Next
   Next

Salida:
   Set oRs = Nothing
   Set goMailOL = Nothing
   Exit Sub

Mal:
   MsgBox "Se ha producido un error ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical
   Resume Salida

End Sub

Public Sub GuardarDefinicionGruposParaAjustesEnSubdiarios()

   Dim oL As ListItem
   Dim mAjuste As String
   For Each oL In Lista.ListItems
      mAjuste = "NO"
      If oL.Checked Then mAjuste = "SI"
      Aplicacion.Tarea "TiposCuentaGrupos_ActualizarAjusteASubdiarios", Array(oL.Tag, mAjuste)
   Next

End Sub

Private Sub Text2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub VividThumbs1_ThumbClick(Filename As String, X As Single, Y As Single)

   If Len(Filename) > 0 Then
      If Not Len(Trim(Dir(Filename))) <> 0 Then
         MsgBox "El archivo indicado no existe!", vbExclamation
         Exit Sub
      End If
      Call ShellExecute(Me.hwnd, "open", Filename, vbNullString, vbNullString, SW_SHOWNORMAL)
   End If

End Sub

Public Property Get IdProveedor() As Long

   IdProveedor = mIdProveedor

End Property

Public Property Let IdProveedor(ByVal vNewValue As Long)

   mIdProveedor = vNewValue

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property




