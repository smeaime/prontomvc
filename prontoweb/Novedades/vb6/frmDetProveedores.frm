VERSION 5.00
Begin VB.Form frmDetProveedores 
   Caption         =   "Item contacto de proveedores"
   ClientHeight    =   2760
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6825
   Icon            =   "frmDetProveedores.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2760
   ScaleWidth      =   6825
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtContacto 
      DataField       =   "Contacto"
      Height          =   330
      Left            =   2160
      TabIndex        =   0
      Top             =   315
      Width           =   4515
   End
   Begin VB.TextBox txtPuesto 
      DataField       =   "Puesto"
      Height          =   330
      Left            =   2160
      TabIndex        =   1
      Top             =   720
      Width           =   4515
   End
   Begin VB.TextBox txtTelefono 
      DataField       =   "Telefono"
      Height          =   330
      Left            =   2160
      TabIndex        =   2
      Top             =   1125
      Width           =   4515
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   3600
      TabIndex        =   5
      Top             =   2160
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1755
      TabIndex        =   4
      Top             =   2160
      Width           =   1485
   End
   Begin VB.TextBox txtEmail 
      DataField       =   "Email"
      Height          =   330
      Left            =   2160
      TabIndex        =   3
      Top             =   1530
      Width           =   4515
   End
   Begin VB.Label lblLabels 
      Caption         =   "Contacto :"
      Height          =   300
      Index           =   3
      Left            =   180
      TabIndex        =   9
      Top             =   315
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Puesto :"
      Height          =   300
      Index           =   2
      Left            =   180
      TabIndex        =   8
      Top             =   720
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Telefono :"
      Height          =   300
      Index           =   0
      Left            =   180
      TabIndex        =   7
      Top             =   1125
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Email :"
      Height          =   300
      Index           =   1
      Left            =   180
      TabIndex        =   6
      Top             =   1530
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetProveedores"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetProveedor
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oProveedor As ComPronto.Proveedor
Private mvarIdUnidadCU As Integer
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         If Len(txtContacto.Text) = 0 Then
            MsgBox "Debe ingresar el nombre del contacto", vbExclamation
            Exit Sub
         End If
         
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
   Set origen = oProveedor.DetProveedores.Item(vNewValue)
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

Public Property Get Proveedor() As ComPronto.Proveedor

   Set Proveedor = oProveedor

End Property

Public Property Set Proveedor(ByVal vNewValue As ComPronto.Proveedor)

   Set oProveedor = vNewValue

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
   Set oProveedor = Nothing

End Sub

Private Sub txtContacto_GotFocus()

   With txtContacto
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtContacto_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtEmail_GotFocus()

   With txtEmail
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtEmail_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPuesto_GotFocus()

   With txtPuesto
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPuesto_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtTelefono_GotFocus()

   With txtTelefono
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTelefono_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
