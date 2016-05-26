VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Object = "{F7D972E3-E925-4183-AB00-B6A253442139}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmCorreo 
   Caption         =   "Correo"
   ClientHeight    =   6705
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7215
   Icon            =   "frmCorreo.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6705
   ScaleWidth      =   7215
   StartUpPosition =   2  'CenterScreen
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   1305
      TabIndex        =   3
      Top             =   90
      Width           =   5820
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Cancelar"
      Height          =   330
      Index           =   1
      Left            =   1665
      TabIndex        =   0
      Top             =   6255
      Width           =   1365
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Enviar"
      Height          =   330
      Index           =   0
      Left            =   135
      TabIndex        =   1
      Top             =   6255
      Width           =   1365
   End
   Begin VB.TextBox txtBody 
      Height          =   1770
      Left            =   90
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   2
      Top             =   4365
      Width           =   7035
   End
   Begin VB.TextBox txtAsunto 
      Height          =   285
      Left            =   1305
      TabIndex        =   5
      Top             =   1530
      Width           =   5820
   End
   Begin VB.TextBox txtDestinatario 
      Height          =   1005
      Left            =   1305
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   4
      Top             =   450
      Width           =   5820
   End
   Begin Controles1013.DbListView Lista 
      Height          =   1815
      Left            =   90
      TabIndex        =   10
      Top             =   2205
      Width           =   7035
      _ExtentX        =   12409
      _ExtentY        =   3201
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmCorreo.frx":076A
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   6615
      Top             =   1845
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCorreo.frx":0786
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCorreo.frx":0898
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCorreo.frx":0CEA
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCorreo.frx":113C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   3330
      TabIndex        =   11
      Top             =   6255
      Visible         =   0   'False
      Width           =   3840
      _ExtentX        =   6773
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
   Begin VB.Label Label4 
      Caption         =   "Mensaje :"
      Height          =   195
      Left            =   90
      TabIndex        =   9
      Top             =   4095
      Width           =   735
   End
   Begin VB.Label Label3 
      Caption         =   "Archivos a enviar :"
      Height          =   195
      Left            =   90
      TabIndex        =   8
      Top             =   1980
      Width           =   1410
   End
   Begin VB.Label Label2 
      Caption         =   "Asunto :"
      Height          =   195
      Left            =   90
      TabIndex        =   7
      Top             =   1575
      Width           =   1140
   End
   Begin VB.Label Label1 
      Caption         =   "Destinatario :"
      Height          =   195
      Left            =   90
      TabIndex        =   6
      Top             =   135
      Width           =   1140
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar archivo adjunto"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar archivo adjunto"
         Index           =   1
      End
   End
End
Attribute VB_Name = "frmCorreo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Ok As Boolean
Private mEntries() As String
Private mEmail As String, mAttachment As String
Private mIdProveedor As Long

Private Sub cmd_Click(Index As Integer)
   
   Select Case Index
      Case 0
'         If Len(txtDestinatario.Text) > 0 Then
'            Me.Email = txtDestinatario.Text
'         Else
'            Me.Email = Combo1.Text
'         End If
         Ok = True
      Case 1
         Ok = False
   End Select
   
   Me.Hide
      
End Sub

Private Sub Combo1_Click()

   If Combo1.ListIndex >= 0 Then
      If Len(Me.Email) > 0 Then
         Me.Email = Me.Email & ";" & mEntries(Combo1.ListIndex + 1)
      Else
         Me.Email = mEntries(Combo1.ListIndex + 1)
      End If
      txtDestinatario.Text = Me.Email
   Else
      txtDestinatario.Text = ""
      Me.Email = ""
   End If

End Sub

Private Sub Combo1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Combo1_LostFocus()

'   If Combo1.ListIndex >= 0 Then
'      txtDestinatario.Text = mEntries(Combo1.ListIndex + 1)
'      Me.Email = mEntries(Combo1.ListIndex + 1)
'   Else
'      txtDestinatario.Text = ""
'      Me.Email = ""
'   End If

End Sub

Private Sub Form_Activate()

   If Len(txtDestinatario.Text) = 0 Then txtDestinatario.Text = Me.Email
   
End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Property Get Email() As String

   Email = mEmail
   
End Property

Public Property Let Email(ByVal vnewvalue As String)

   mEmail = vnewvalue
   
End Property

Public Property Let Attachment(ByVal vnewvalue As String)

   mAttachment = vnewvalue
   
   Dim oRs As ADOR.Recordset
   Dim oL As ListItem
   Dim mVector
   Dim i As Integer
   
   Set oRs = CreateObject("ADOR.Recordset")
   With oRs
      .Fields.Append "Id", adInteger
      .Fields.Append "Archivo", adVarChar, 200
      .Open
   End With
   
   mVector = VBA.Split(mAttachment, ",")
   For i = 0 To UBound(mVector)
      oRs.AddNew
      oRs.Fields(0).Value = -1
      oRs.Fields(1).Value = mVector(i)
   Next

   Set Lista.DataSource = oRs
   
   Set oRs = Nothing

End Property

Public Property Get Attachment() As String

   Dim oL As ListItem
   mAttachment = ""
   For Each oL In Lista.ListItems
      If oL.Tag = -1 Then
         mAttachment = mAttachment & oL.Text & ","
      End If
   Next
   If Len(mAttachment) > 0 Then
      mAttachment = mId(mAttachment, 1, Len(mAttachment) - 1)
   End If
   Attachment = mAttachment
   
End Property

Public Sub CargarDirecciones()

   Dim m_oOLApp As Outlook.Application
   Dim mPrimerPaso As Boolean
   Dim i As Integer, mEntriesCount As Integer, pos As Integer, mEntriesPlus As Integer
   Dim oRs As ADOR.Recordset
   
   Ok = False
   mPrimerPaso = True
   pos = 0
   
   On Error GoTo CI_Error
   Set m_oOLApp = GetObject(, "Outlook.Application")
   
Carga:
   mEntriesPlus = 0
   If Me.IdProveedor > 0 Then
      Set oRs = Aplicacion.Proveedores.TraerFiltrado("_Emails", Me.IdProveedor)
      With oRs
         If .RecordCount > 0 Then
            mEntriesPlus = .RecordCount
            ReDim Preserve mEntries(mEntriesPlus)
            .MoveFirst
            Do While Not .EOF
               i = .AbsolutePosition
               mEntries(i) = .Fields("Email").Value
               Combo1.AddItem .Fields("Nombre").Value
               .MoveNext
            Loop
         End If
         .Close
      End With
      Set oRs = Nothing
   End If
   
'   mEntriesCount = m_oOLApp.Session.AddressLists.Item(1).AddressEntries.Count
'   ReDim Preserve mEntries(mEntriesCount + mEntriesPlus)
'   With m_oOLApp.Session.AddressLists.Item(1).AddressEntries
'      For i = 1 To mEntriesCount
'         mEntries(mEntriesPlus + i) = .Item(i).Address
'         Combo1.AddItem .Item(i).Name
'         If mEntries(mEntriesPlus + i) = mEmail Then pos = mEntriesPlus + i
'      Next
'   End With
'   If pos > 0 Then Combo1.ListIndex = pos
   GoTo Salir
   
Crear:
   If m_oOLApp Is Nothing Then
      Set m_oOLApp = CreateObject("Outlook.Application")
   End If
   GoTo Carga
   
CI_Error:
   If Err.Number = 429 And mPrimerPaso Then
      mPrimerPaso = False
      GoTo Crear
   End If
   GoTo Salir
   
Salir:
   Set m_oOLApp = Nothing

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyDelete Then
      MnuDetA_Click 1
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetA_Click 0
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count = 0 Then
         MnuDetA(1).Enabled = False
         PopupMenu MnuDet, , , , MnuDetA(0)
      Else
         MnuDetA(1).Enabled = True
         PopupMenu MnuDet, , , , MnuDetA(1)
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar "Nuevo"
      Case 1
         Editar "Eliminar"
   End Select

End Sub

Public Sub Editar(ByVal Accion As String)

   Select Case Accion
      
      Case "Nuevo"
         
         Dim oF As frmCorreo_Aux
         Dim oL As ListItem
         
         Set oF = New frmCorreo_Aux
   
         With oF
            .Show vbModal, Me
            If .Ok Then
               Set oL = Lista.ListItems.Add
               oL.Tag = -1
               With oL
                  .SmallIcon = "Nuevo"
                  .Text = oF.FileBrowser1(0).Text
               End With
            End If
         End With
   
         Unload oF
   
         Set oF = Nothing
   
      Case "Eliminar"
         
         If Not Lista.SelectedItem Is Nothing Then
            With Lista.SelectedItem
               .Tag = 0
               .SmallIcon = "Eliminado"
               .ToolTipText = .SmallIcon
            End With
         End If
   
   End Select

End Sub

Public Property Get IdProveedor() As Long

   IdProveedor = mIdProveedor

End Property

Public Property Let IdProveedor(ByVal vnewvalue As Long)

   mIdProveedor = vnewvalue

End Property

Private Sub txtDestinatario_LostFocus()

   Me.Email = txtDestinatario.Text

End Sub
