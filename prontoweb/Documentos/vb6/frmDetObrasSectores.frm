VERSION 5.00
Begin VB.Form frmDetObrasSectores 
   Caption         =   "Item de sectores de la obra"
   ClientHeight    =   1575
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6495
   LinkTopic       =   "Form1"
   ScaleHeight     =   1575
   ScaleWidth      =   6495
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtDescripcion 
      Alignment       =   2  'Center
      DataField       =   "Descripcion"
      Height          =   330
      Left            =   1440
      TabIndex        =   0
      Top             =   360
      Width           =   4785
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   2205
      TabIndex        =   2
      Top             =   945
      Width           =   1845
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   225
      TabIndex        =   1
      Top             =   945
      Width           =   1845
   End
   Begin VB.Label lblLabels 
      Caption         =   "Descripcion :"
      Height          =   300
      Index           =   0
      Left            =   315
      TabIndex        =   3
      Top             =   360
      Width           =   1050
   End
End
Attribute VB_Name = "frmDetObrasSectores"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetObraSector
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oObra As ComPronto.Obra
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         If Len(txtDescripcion.Text) = 0 Then
            MsgBox "Debe ingresar la descripcion del sector", vbExclamation
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         
         With origen.Registro
         End With
         
         origen.Modificado = True
         Aceptado = True
         
         Me.Hide

      Case 1
      
         If mvarId = -1 Then
            origen.Eliminado = True
         End If
         
         Me.Hide
   
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   
   Set oAp = Aplicacion
   mvarId = vNewValue
   Set origen = oObra.DetObrasSectores.Item(vNewValue)
   Me.IdNuevo = origen.Id
   Set oBind = New BindingCollection
   
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DTPicker Then
            If Len(oControl.DataField) Then .Add oControl, "Value", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   If mvarId < 0 Then
   Else
      With origen.Registro
      End With
   End If
   
   Set oAp = Nothing
   
End Property

Public Property Get Obra() As ComPronto.Obra

   Set Obra = oObra

End Property

Public Property Set Obra(ByVal vNewValue As ComPronto.Obra)

   Set oObra = vNewValue

End Property

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub Form_Load()

   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oBind = Nothing
   Set origen = Nothing
   Set oObra = Nothing

End Sub

Private Sub txtDescripcion_GotFocus()

   With txtDescripcion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDescripcion
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
