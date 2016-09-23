VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetProveedoresRubros 
   Caption         =   "Item de rubros por proveedor"
   ClientHeight    =   1740
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6210
   Icon            =   "frmDetProveedoresRubros.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1740
   ScaleWidth      =   6210
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1350
      TabIndex        =   2
      Top             =   1170
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   3330
      TabIndex        =   3
      Top             =   1170
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdRubro"
      Height          =   315
      Index           =   0
      Left            =   1125
      TabIndex        =   0
      Tag             =   "Rubros"
      Top             =   225
      Width           =   4965
      _ExtentX        =   8758
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdRubro"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSubrubro"
      Height          =   315
      Index           =   1
      Left            =   1125
      TabIndex        =   1
      Tag             =   "Subrubros"
      Top             =   630
      Width           =   4965
      _ExtentX        =   8758
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdSubrubro"
      Text            =   ""
   End
   Begin VB.Label lblData 
      Caption         =   "Subrubro :"
      Height          =   255
      Index           =   1
      Left            =   135
      TabIndex        =   5
      Top             =   675
      Width           =   870
   End
   Begin VB.Label lblData 
      Caption         =   "Rubro :"
      Height          =   255
      Index           =   0
      Left            =   135
      TabIndex        =   4
      Top             =   270
      Width           =   870
   End
End
Attribute VB_Name = "frmDetProveedoresRubros"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetProveedorRubros
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
      
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe ingresar el rubro", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(DataCombo1(1).BoundText) Then
            MsgBox "Debe ingresar el subrubro", vbExclamation
            Exit Sub
         End If
         
         Dim dc As DataCombo
         
         With origen.Registro
            
            For Each dc In DataCombo1
               If IsNumeric(dc.BoundText) Then
                  .Fields(dc.DataField).Value = dc.BoundText
               Else
                  MsgBox "Debe completar el campo " & lblData(dc.Index), vbExclamation
               End If
            Next
            
         End With
         
         origen.Modificado = True
         Aceptado = True
         
         Me.Hide

      Case 1
      
         Me.Hide
   
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   
   Set oAp = Aplicacion
   mvarId = vNewValue
   Set origen = oProveedor.DetProveedoresRubros.Item(vNewValue)
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
      
      End With
   Else
   
   End If
   
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

