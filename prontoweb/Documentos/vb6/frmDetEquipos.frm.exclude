VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetEquipos 
   Caption         =   "Item de definicion de equipos ( planos )"
   ClientHeight    =   2295
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7095
   Icon            =   "frmDetEquipos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2295
   ScaleWidth      =   7095
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtDescripcion 
      Height          =   330
      Left            =   2205
      Locked          =   -1  'True
      TabIndex        =   5
      Top             =   1125
      Width           =   4515
   End
   Begin VB.TextBox txtNumeroPlano 
      Height          =   330
      Left            =   2205
      Locked          =   -1  'True
      TabIndex        =   4
      Top             =   675
      Width           =   2535
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1935
      TabIndex        =   1
      Top             =   1755
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   3645
      TabIndex        =   2
      Top             =   1755
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdPlano"
      Height          =   315
      Index           =   0
      Left            =   2205
      TabIndex        =   0
      Tag             =   "Planos"
      Top             =   270
      Width           =   4515
      _ExtentX        =   7964
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdPlano"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Descripcion :"
      Height          =   300
      Index           =   1
      Left            =   225
      TabIndex        =   7
      Top             =   1125
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de plano :"
      Height          =   300
      Index           =   0
      Left            =   225
      TabIndex        =   6
      Top             =   720
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Plano :"
      Height          =   300
      Index           =   11
      Left            =   225
      TabIndex        =   3
      Top             =   270
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetEquipos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetEquipo
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oEquipo As ComPronto.Equipo
Dim mvarIdUnidadCU As Integer
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim dc As DataCombo
         
         For Each dc In DataCombo1
            If dc.Enabled Then
               If Len(Trim(dc.BoundText)) = 0 Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
               origen.Registro.Fields(dc.DataField).Value = dc.BoundText
            End If
         Next
         
         With origen.Registro
            .Fields("EnviarEmail").Value = 1
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
   Set origen = oEquipo.DetEquipos.Item(vNewValue)
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
               If oControl.Tag = "DefExe1" Then
                  If Not IsNull(Equipo.Registro.Fields("IdAcopio").Value) Then
                     Set oControl.RowSource = oAp.Acopios.TraerFiltrado("Items", Equipo.Registro.Fields("IdAcopio").Value)
                  End If
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   Set oAp = Nothing
   
End Property

Public Property Get Equipo() As ComPronto.Equipo

   Set Equipo = oEquipo

End Property

Public Property Set Equipo(ByVal vNewValue As ComPronto.Equipo)

   Set oEquipo = vNewValue

End Property

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub DataCombo1_Click(Index As Integer, Area As Integer)

   Dim oRs As ADOR.Recordset
            
   If IsNumeric(DataCombo1(Index).BoundText) Then
      Set oRs = Aplicacion.Planos.Item(DataCombo1(Index).BoundText).Registro
      If oRs.RecordCount > 0 Then
         txtNumeroPlano.Text = oRs.Fields("NumeroPlano").Value
         txtDescripcion.Text = oRs.Fields("Descripcion").Value
      End If
      oRs.Close
   End If
      
   Set oRs = Nothing

End Sub

Private Sub Form_Activate()

   If mvarId > 0 Then
   
      Dim oRs As ADOR.Recordset
               
      If IsNumeric(DataCombo1(0).BoundText) Then
         Set oRs = Aplicacion.Planos.Item(DataCombo1(0).BoundText).Registro
         If oRs.RecordCount > 0 Then
            txtNumeroPlano.Text = oRs.Fields("NumeroPlano").Value
            txtDescripcion.Text = oRs.Fields("Descripcion").Value
         End If
         oRs.Close
      End If
         
      Set oRs = Nothing

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
   Set oEquipo = Nothing

End Sub
