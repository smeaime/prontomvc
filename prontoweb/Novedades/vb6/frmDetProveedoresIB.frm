VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetProveedoresIB 
   Caption         =   "Detalle de retencion para convenio multilateral"
   ClientHeight    =   2280
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6300
   Icon            =   "frmDetProveedoresIB.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2280
   ScaleWidth      =   6300
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   3330
      TabIndex        =   4
      Top             =   1710
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1485
      TabIndex        =   3
      Top             =   1710
      Width           =   1485
   End
   Begin VB.TextBox txtAlicuota 
      Alignment       =   1  'Right Justify
      DataField       =   "AlicuotaAAplicar"
      Height          =   285
      Left            =   2205
      TabIndex        =   1
      Top             =   585
      Width           =   1320
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaVencimiento"
      Height          =   330
      Index           =   0
      Left            =   2205
      TabIndex        =   2
      Top             =   990
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   582
      _Version        =   393216
      Format          =   62455809
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdIBCondicion"
      Height          =   315
      Index           =   0
      Left            =   2205
      TabIndex        =   0
      Tag             =   "IBCondiciones"
      Top             =   180
      Width           =   3930
      _ExtentX        =   6932
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdIBCondicion"
      Text            =   ""
   End
   Begin VB.Label lblData 
      Caption         =   "Jurisdiccion / Provincia :"
      Height          =   255
      Index           =   0
      Left            =   180
      TabIndex        =   7
      Top             =   225
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Alicuota a aplicar : "
      Height          =   255
      Index           =   3
      Left            =   180
      TabIndex        =   6
      Top             =   630
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de vencimiento : "
      Height          =   255
      Index           =   0
      Left            =   180
      TabIndex        =   5
      Top             =   1035
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetProveedoresIB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetProveedorIB
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
      
         If Len(txtAlicuota.Text) = 0 Then
            MsgBox "Debe ingresar la alicuota", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe ingresar jurisdiccion", vbExclamation
            Exit Sub
         End If
         
         Dim dtp As DTPicker
         Dim dc As DataCombo
         
         With origen.Registro
            
            For Each dtp In DTFields
               If dtp.Enabled Then
                  .Fields(dtp.DataField).Value = dtp.Value
               End If
            Next
            
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
   Set origen = oProveedor.DetProveedoresIB.Item(vNewValue)
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
         .Fields("FechaVencimiento").Value = Date
      End With
      DTFields(0).Value = Date
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

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

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
   Set oProveedor = Nothing

End Sub

Private Sub txtAlicuota_GotFocus()

   With txtAlicuota
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAlicuota_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
