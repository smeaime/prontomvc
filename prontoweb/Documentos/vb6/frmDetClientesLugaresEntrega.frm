VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetClientesLugaresEntrega 
   Caption         =   "Item clientes lugares de entrega"
   ClientHeight    =   2295
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6765
   LinkTopic       =   "Form1"
   ScaleHeight     =   2295
   ScaleWidth      =   6765
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtDireccionEntrega 
      DataField       =   "DireccionEntrega"
      Height          =   330
      Left            =   2115
      TabIndex        =   0
      Top             =   270
      Width           =   4515
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   3555
      TabIndex        =   4
      Top             =   1755
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1710
      TabIndex        =   3
      Top             =   1755
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdLocalidadEntrega"
      Height          =   315
      Index           =   0
      Left            =   2115
      TabIndex        =   1
      Tag             =   "Localidades"
      Top             =   720
      Width           =   4500
      _ExtentX        =   7938
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdLocalidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProvinciaEntrega"
      Height          =   315
      Index           =   1
      Left            =   2115
      TabIndex        =   2
      Tag             =   "Provincias"
      Top             =   1140
      Width           =   4500
      _ExtentX        =   7938
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProvincia"
      Text            =   ""
   End
   Begin VB.Label lblData 
      Caption         =   "Provincia entrega :"
      Height          =   300
      Index           =   4
      Left            =   135
      TabIndex        =   7
      Top             =   1185
      Width           =   1815
   End
   Begin VB.Label lblData 
      Caption         =   "Localidad entrega :"
      Height          =   300
      Index           =   5
      Left            =   135
      TabIndex        =   6
      Top             =   750
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Direccion de entrega :"
      Height          =   300
      Index           =   3
      Left            =   135
      TabIndex        =   5
      Top             =   270
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetClientesLugaresEntrega"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetClienteLugarEntrega
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oCliente As ComPronto.Cliente
Private mvarIdUnidadCU As Integer
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         If Len(txtDireccionEntrega.Text) = 0 Then
            MsgBox "Debe ingresar la direccion de entrega", vbExclamation
            Exit Sub
         End If
         
         Dim dc As DataCombo
         
         For Each dc In DataCombo1
            If dc.Enabled And dc.Visible Then
               If Not IsNumeric(dc.BoundText) Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
               origen.Registro.Fields(dc.DataField).Value = dc.BoundText
            End If
         Next
      
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
   Set origen = oCliente.DetClientesLugaresEntrega.Item(vNewValue)
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
   
   Set oAp = Nothing
   
End Property

Public Property Get Cliente() As ComPronto.Cliente

   Set Cliente = oCliente

End Property

Public Property Set Cliente(ByVal vNewValue As ComPronto.Cliente)

   Set oCliente = vNewValue

End Property

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   If Index = 0 Then
      If IsNumeric(DataCombo1(Index).BoundText) Then
         Dim oRs As ADOR.Recordset
         Set oRs = Aplicacion.Localidades.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
         If oRs.RecordCount > 0 Then
            With origen.Registro
               .Fields("IdProvinciaEntrega").Value = oRs.Fields("IdProvincia").Value
            End With
         End If
         oRs.Close
         Set oRs = Nothing
      End If
   End If

End Sub

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
   Set oCliente = Nothing

End Sub

Private Sub txtDireccionEntrega_GotFocus()

   With txtDireccionEntrega
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDireccionEntrega_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDireccionEntrega
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
