VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmAsignaCCalidad 
   Caption         =   "Asigna control de calidad"
   ClientHeight    =   1365
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7845
   Icon            =   "frmAsignaCCalidad.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1365
   ScaleWidth      =   7845
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdOK 
      Caption         =   "Aceptar"
      Default         =   -1  'True
      Height          =   360
      Left            =   2745
      TabIndex        =   1
      Tag             =   "Aceptar"
      Top             =   765
      Width           =   1140
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancelar"
      Height          =   360
      Left            =   3975
      TabIndex        =   2
      Tag             =   "Cancelar"
      Top             =   765
      Width           =   1140
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   2115
      TabIndex        =   0
      Tag             =   "ControlesCalidad"
      Top             =   225
      Width           =   5595
      _ExtentX        =   9869
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdControlCalidad"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Control de calidad :"
      Height          =   300
      Index           =   11
      Left            =   135
      TabIndex        =   3
      Top             =   225
      Width           =   1815
   End
End
Attribute VB_Name = "frmAsignaCCalidad"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Ok As Boolean

Private Sub cmdCancel_Click()
   
   Ok = False
   Me.Hide

End Sub

Private Sub cmdOk_Click()
   
   If Not IsNumeric(DataCombo1(0).BoundText) Then
      MsgBox "Debe ingresar un control de calidad", vbExclamation
      Exit Sub
   End If
   
   Ok = True
   Me.Hide

End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)

   SendKeys "%{DOWN}"

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   Set DataCombo1(0).RowSource = Aplicacion.CargarLista(DataCombo1(0).Tag)

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub


