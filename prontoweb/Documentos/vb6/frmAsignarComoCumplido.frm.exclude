VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmAsignarComoCumplido 
   Caption         =   "Asignar como cumplido"
   ClientHeight    =   2685
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5835
   Icon            =   "frmAsignarComoCumplido.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2685
   ScaleWidth      =   5835
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdOK 
      Caption         =   "Aceptar"
      Height          =   450
      Left            =   1350
      TabIndex        =   1
      Tag             =   "Aceptar"
      Top             =   1980
      Width           =   1410
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancelar"
      Height          =   450
      Left            =   3105
      TabIndex        =   2
      Tag             =   "Cancelar"
      Top             =   1980
      Width           =   1410
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   1
      Left            =   1980
      TabIndex        =   0
      Tag             =   "Empleados"
      Top             =   180
      Width           =   3750
      _ExtentX        =   6615
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservacionesCumplido 
      Height          =   1095
      Left            =   1980
      TabIndex        =   3
      Top             =   585
      Width           =   3750
      _ExtentX        =   6615
      _ExtentY        =   1931
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmAsignarComoCumplido.frx":076A
   End
   Begin VB.Label lblData 
      Caption         =   "Dado por cumplido por : "
      Height          =   240
      Index           =   1
      Left            =   90
      TabIndex        =   5
      Top             =   225
      Width           =   1800
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   240
      Index           =   5
      Left            =   90
      TabIndex        =   4
      Top             =   630
      Width           =   1800
   End
End
Attribute VB_Name = "frmAsignarComoCumplido"
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
   
   Dim dc As DataCombo
   
   For Each dc In dcfields
      If dc.Enabled Then
         If Not IsNumeric(dc.BoundText) Then
            MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
            Exit Sub
         End If
      End If
   Next
         
   Ok = True
   Me.Hide

End Sub

Private Sub dcfields_GotFocus(Index As Integer)

   If Len(dcfields(Index).Text) = 0 Then
      SendKeys "%{DOWN}"
   End If

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   Set dcfields(1).RowSource = Aplicacion.Empleados.TraerLista

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

