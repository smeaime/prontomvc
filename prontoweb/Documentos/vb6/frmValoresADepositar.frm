VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmValoresADepositar 
   Caption         =   "Valores a depositar"
   ClientHeight    =   5490
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10440
   Icon            =   "frmValoresADepositar.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5490
   ScaleWidth      =   10440
   StartUpPosition =   3  'Windows Default
   Begin Controles1013.DbListView Lista 
      Height          =   4740
      Left            =   90
      TabIndex        =   1
      Top             =   90
      Width           =   10230
      _ExtentX        =   18045
      _ExtentY        =   8361
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmValoresADepositar.frx":076A
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   420
      Index           =   0
      Left            =   4410
      TabIndex        =   0
      Top             =   4995
      Width           =   1470
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   9720
      Top             =   4860
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
            Picture         =   "frmValoresADepositar.frx":0786
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmValoresADepositar.frx":0898
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmValoresADepositar.frx":0CEA
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmValoresADepositar.frx":113C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmValoresADepositar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Me.Hide
   End Select
   
End Sub

Private Sub Form_Load()

   Dim oAp As Aplicacion
   Dim oRsVal As ADOR.Recordset
   
   Set oAp = Aplicacion
   Set oRsVal = oAp.Valores.TraerFiltrado("_ADepositar")
   If oRsVal.RecordCount > 0 Then
      oRsVal.MoveFirst
      Set Lista.DataSource = oRsVal
   End If
   
   oRsVal.Close
   Set oRsVal = Nothing
   Set oAp = Nothing

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



