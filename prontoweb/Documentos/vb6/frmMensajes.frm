VERSION 5.00
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmMensajes 
   Caption         =   "Mensajes a usuarios"
   ClientHeight    =   6075
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8235
   Icon            =   "frmMensajes.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6075
   ScaleWidth      =   8235
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtMensaje 
      Height          =   1095
      Left            =   180
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   450
      Width           =   7890
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   1
      Top             =   5535
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1845
      TabIndex        =   2
      Top             =   5535
      Width           =   1485
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3750
      Left            =   135
      TabIndex        =   3
      Top             =   1665
      Width           =   7935
      _ExtentX        =   13996
      _ExtentY        =   6615
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmMensajes.frx":076A
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Label Label1 
      Caption         =   "Mensaje :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   225
      TabIndex        =   4
      Top             =   135
      Width           =   960
   End
End
Attribute VB_Name = "frmMensajes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         EnviarMensaje
   End Select
   
   Unload Me

End Sub

Private Sub Form_Load()

   Lista.CheckBoxes = True
   Set Lista.DataSource = Aplicacion.Empleados.TraerFiltrado("_ParaMensajes")
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Sub EnviarMensaje()

   Dim oAp As ComPronto.Aplicacion
   Dim oF As Form
   Dim oL As ListItem
   Dim mCheck As Boolean
   
   On Error GoTo Salida
   
   If Len(txtMensaje.Text) = 0 Then
      MsgBox "No ha ingresado el mensaje!", vbExclamation
      Exit Sub
   End If
   
   mConfirma = MsgBox("Esta suguro de enviar el mensaje ?", vbYesNo, "Confirmacion y generacion de mensajes")
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
      MsgBox "No hay usuarios marcados!", vbExclamation
      Exit Sub
   End If
         
   Set oF = New frmInformacion
   oF.Label1.Caption = "PROCESAMIENTO DE ENVIO DE MENSAJE A USUARIOS"
   oF.Show , Me
   
   Set oAp = Aplicacion
   
   For Each oL In Lista.ListItems
      If oL.Checked Then
         'oAp.TablasGenerales.GuardarNovedadUsuario 5, oL.Tag, txtMensaje.Text
         oAp.Tarea "NovedadesUsuarios_GrabarNovedadNueva", _
                        Array(oL.Tag, 5, txtMensaje.Text, -1, Null, glbIdUsuario)
      End If
   Next

Salida:
   Unload oF
   Set oF = Nothing
   Set oAp = Nothing

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub txtMensaje_GotFocus()

   With txtMensaje
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtMensaje_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtMensaje
         If Len(Trim(.Text)) >= 100 And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
