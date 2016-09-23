VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmStringConnection 
   Caption         =   "Cadenas de conexion a la base de datos"
   ClientHeight    =   2460
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4605
   Icon            =   "frmStringConnection.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2460
   ScaleWidth      =   4605
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   2790
      TabIndex        =   2
      Top             =   1980
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Default         =   -1  'True
      Height          =   405
      Index           =   0
      Left            =   405
      TabIndex        =   1
      Top             =   1980
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   1740
      Index           =   0
      Left            =   45
      TabIndex        =   0
      Top             =   90
      Width           =   4515
      _ExtentX        =   7964
      _ExtentY        =   3069
      _Version        =   393216
      Style           =   1
      ListField       =   "Titulo"
      BoundColumn     =   "IdAux"
      Text            =   ""
   End
End
Attribute VB_Name = "frmStringConnection"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Ok As Boolean
Private oRs As ADOR.Recordset

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then
      If Len(DataCombo1(0).Text) = 0 Then
         MsgBox "Debe elegir una cadena de conexion", vbExclamation
         Exit Sub
      End If
      Ok = True
   Else
      Ok = False
   End If
   
   Me.Hide
   
End Sub

Public Property Get RecordsetDeStrings() As Object

   Set RecordsetDeStrings = oRs
   
End Property

Public Property Set RecordsetDeStrings(ByVal vnewvalue As Object)

   Set oRs = vnewvalue
   
End Property

Private Sub Form_Load()

   Set DataCombo1(0).RowSource = oRs

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   Set oRs = Nothing
   
End Sub
