VERSION 5.00
Begin VB.Form frmDetDefinicionFlujoCaja 
   Caption         =   "Item de definicion de flujo de caja"
   ClientHeight    =   1365
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5580
   Icon            =   "frmDetDefinicionFlujoCaja.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1365
   ScaleWidth      =   5580
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtPresupuesto 
      Alignment       =   1  'Right Justify
      DataField       =   "Presupuesto"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   4050
      TabIndex        =   2
      Top             =   225
      Width           =   1230
   End
   Begin VB.TextBox txtAño 
      Alignment       =   2  'Center
      DataField       =   "Año"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2160
      TabIndex        =   1
      Top             =   225
      Width           =   600
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   315
      TabIndex        =   3
      Top             =   765
      Width           =   990
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1395
      TabIndex        =   4
      Top             =   765
      Width           =   990
   End
   Begin VB.TextBox txtMes 
      Alignment       =   2  'Center
      DataField       =   "Mes"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   855
      TabIndex        =   0
      Top             =   225
      Width           =   600
   End
   Begin VB.Label lblLabels 
      Caption         =   "Presupuesto :"
      Height          =   255
      Index           =   2
      Left            =   2925
      TabIndex        =   7
      Top             =   270
      Width           =   1050
   End
   Begin VB.Label lblLabels 
      Caption         =   "Año :"
      Height          =   255
      Index           =   1
      Left            =   1620
      TabIndex        =   6
      Top             =   270
      Width           =   465
   End
   Begin VB.Label lblLabels 
      Caption         =   "Mes :"
      Height          =   255
      Index           =   0
      Left            =   315
      TabIndex        =   5
      Top             =   270
      Width           =   465
   End
End
Attribute VB_Name = "frmDetDefinicionFlujoCaja"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetDefinicionFlujoCajaPresu
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oDefinicionFlujoCaja As ComPronto.DefinicionFlujoCaja
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         If Val(txtMes.Text) < 0 Or Val(txtMes.Text) > 12 Then
            MsgBox "El numero de mes debe estar entre 1 y 12", vbCritical
            Exit Sub
         End If
         
         If Val(txtAño.Text) < 2000 Or Val(txtAño.Text) > 2020 Then
            MsgBox "El numero de año debe estar entre 2000 y 2020", vbCritical
            Exit Sub
         End If
         
         If Len(txtPresupuesto.Text) = 0 Then
            MsgBox "Debe ingresar el importe presupuestado", vbCritical
            Exit Sub
         End If
         
         With origen.Registro
         
         End With
         
         origen.Modificado = True
         Aceptado = True
   
      Case 1
      
         If mvarId = -1 Then
            origen.Eliminado = True
         End If
   
   End Select
   
   Me.Hide

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim dtp As DTPicker
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset

   Set oAp = Aplicacion
   mvarId = vNewValue
   Set origen = oDefinicionFlujoCaja.DetDefinicionesFlujoCajaPresu.Item(vNewValue)
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
            Set oControl.DataSource = origen
         End If
      Next
   End With
   
   If mvarId <= 0 Then
      With origen.Registro
         .Fields("Año").Value = Year(Date)
      End With
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
End Property

Public Property Get DefinicionFlujoCaja() As ComPronto.DefinicionFlujoCaja

   Set DefinicionFlujoCaja = oDefinicionFlujoCaja

End Property

Public Property Set DefinicionFlujoCaja(ByVal vNewValue As ComPronto.DefinicionFlujoCaja)

   Set oDefinicionFlujoCaja = vNewValue

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
   Set oDefinicionFlujoCaja = Nothing

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub txtAño_GotFocus()

   With txtAño
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAño_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtMes_GotFocus()

   With txtMes
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtMes_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPresupuesto_GotFocus()

   With txtPresupuesto
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPresupuesto_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
