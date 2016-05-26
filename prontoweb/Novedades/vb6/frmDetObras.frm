VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetObras 
   Caption         =   "Item de obra"
   ClientHeight    =   2610
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6930
   LinkTopic       =   "Form1"
   ScaleHeight     =   2610
   ScaleWidth      =   6930
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1845
      TabIndex        =   2
      Top             =   2025
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   3555
      TabIndex        =   3
      Top             =   2025
      Width           =   1485
   End
   Begin VB.TextBox txtObservaciones 
      Alignment       =   1  'Right Justify
      DataField       =   "Observaciones"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "###,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   1080
      Left            =   2205
      TabIndex        =   1
      Top             =   585
      Width           =   4515
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdEquipo"
      Height          =   315
      Index           =   0
      Left            =   2205
      TabIndex        =   0
      Tag             =   "Equipos"
      Top             =   225
      Width           =   4515
      _ExtentX        =   7964
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdEquipo"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Equipo :"
      Height          =   300
      Index           =   2
      Left            =   225
      TabIndex        =   5
      Top             =   225
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   7
      Left            =   225
      TabIndex        =   4
      Top             =   585
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetObras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComAesa.DetObra
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oObra As ComAesa.Obra
Public Aceptado As Boolean
Private mvarIdNuevo As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
         
         Dim dc As DataCombo
   
         For Each dc In DataCombo1
            If Len(Trim(dc.BoundText)) = 0 Then
               MsgBox "Falta completar el campo " & dc.Tag, vbCritical
               Exit Sub
            End If
            origen.Registro.Fields(dc.DataField).Value = dc.BoundText
         Next
         
         origen.Modificado = True
         Aceptado = True
   
   End Select
   
   Me.Hide

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComAesa.Aplicacion

   Set oAp = Aplicacion
   Set origen = oObra.DetObras.Item(vNewValue)
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
   
End Property

Public Property Get Obra() As ComAesa.Obra

   Set Obra = oObra

End Property

Public Property Set Obra(ByVal vNewValue As ComAesa.Obra)

   Set oObra = vNewValue

End Property

'Private Sub DataCombo1_GotFocus(Index As Integer)
'
'   With DataCombo1(Index)
'      .SelStart = 0
'      .SelLength = Len(.Text)
'   End With
'
'End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}"

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub txtObservaciones_GotFocus()
   
   With txtObservaciones
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtObservaciones_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}"

End Sub
