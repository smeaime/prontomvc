VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form frmDetEmpleados 
   Caption         =   "Fechas de ingreso - egreso de empleados"
   ClientHeight    =   1230
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6600
   Icon            =   "frmDetEmpleados.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1230
   ScaleWidth      =   6600
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "Egreso :"
      Height          =   825
      Left            =   3375
      TabIndex        =   6
      Top             =   45
      Width           =   1320
      Begin VB.OptionButton Option2 
         Caption         =   "Desactivar"
         Height          =   240
         Left            =   135
         TabIndex        =   8
         Top             =   495
         Width           =   1140
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Activar"
         Height          =   195
         Left            =   135
         TabIndex        =   7
         Top             =   225
         Width           =   870
      End
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1350
      TabIndex        =   1
      Top             =   675
      Width           =   1080
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   180
      TabIndex        =   0
      Top             =   675
      Width           =   1080
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaEgreso"
      Height          =   285
      Index           =   1
      Left            =   4815
      TabIndex        =   2
      Top             =   495
      Width           =   1365
      _ExtentX        =   2408
      _ExtentY        =   503
      _Version        =   393216
      Format          =   59506689
      CurrentDate     =   36526
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaIngreso"
      Height          =   285
      Index           =   0
      Left            =   1845
      TabIndex        =   3
      Top             =   180
      Width           =   1320
      _ExtentX        =   2328
      _ExtentY        =   503
      _Version        =   393216
      Format          =   59506689
      CurrentDate     =   36432
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Fecha de egreso : "
      Height          =   240
      Index           =   22
      Left            =   4815
      TabIndex        =   5
      Top             =   135
      Width           =   1320
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Fecha de ingreso :"
      Height          =   240
      Index           =   3
      Left            =   180
      TabIndex        =   4
      Top             =   180
      Width           =   1545
   End
End
Attribute VB_Name = "frmDetEmpleados"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetEmpleado
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oEmpleado As ComPronto.Empleado
Dim mvarIdUnidadCU As Integer
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim dtp As DTPicker
         
         For Each dtp In DTPicker1
            If dtp.Enabled Then origen.Registro.Fields(dtp.DataField).Value = dtp.Value
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
   Set origen = oEmpleado.DetEmpleados.Item(vNewValue)
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
   
   If mvarId = -1 Then
      DTPicker1(0).Value = Date
      DTPicker1(1).Enabled = False
      Option2.Value = True
   Else
      With origen.Registro
         If Not IsNull(.Fields("FechaIngreso").Value) Then
            DTPicker1(0).Value = .Fields("FechaIngreso").Value
         End If
         If Not IsNull(.Fields("FechaEgreso").Value) Then
            DTPicker1(1).Enabled = True
            Option1.Value = True
            DTPicker1(1).Value = .Fields("FechaEgreso").Value
         Else
            DTPicker1(1).Enabled = False
            Option2.Value = True
         End If
      End With
   End If
   
   Set oAp = Nothing
   
End Property

Public Property Get Empleado() As ComPronto.Empleado

   Set Empleado = oEmpleado

End Property

Public Property Set Empleado(ByVal vNewValue As ComPronto.Empleado)

   Set oEmpleado = vNewValue

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

Private Sub Option1_Click()

   If Option1.Value Then
      With DTPicker1(1)
         .Enabled = True
         .Value = Date
      End With
   End If
         
End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      DTPicker1(1).Enabled = False
      origen.Registro.Fields("FechaEgreso").Value = Null
   End If

End Sub
