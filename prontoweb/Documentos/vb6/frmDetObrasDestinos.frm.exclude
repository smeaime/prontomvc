VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form frmDetObrasDestinos 
   Caption         =   "Item de destinos de  la obra"
   ClientHeight    =   3450
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6210
   LinkTopic       =   "Form1"
   ScaleHeight     =   3450
   ScaleWidth      =   6210
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Height          =   510
      Left            =   90
      TabIndex        =   9
      Top             =   2250
      Width           =   6000
      Begin VB.OptionButton Option3 
         Caption         =   "Ambos"
         Height          =   240
         Left            =   4860
         TabIndex        =   13
         Top             =   180
         Width           =   1005
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Indirecto"
         Height          =   240
         Left            =   3645
         TabIndex        =   12
         Top             =   180
         Width           =   1005
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Directo"
         Height          =   240
         Left            =   2430
         TabIndex        =   10
         Top             =   180
         Width           =   825
      End
      Begin VB.Label Label1 
         Caption         =   "Tipo de consumo que acepta :"
         Height          =   240
         Left            =   90
         TabIndex        =   11
         Top             =   180
         Width           =   2175
      End
   End
   Begin VB.TextBox txtInformacionAuxiliar 
      Alignment       =   2  'Center
      DataField       =   "InformacionAuxiliar"
      Height          =   330
      Left            =   90
      TabIndex        =   2
      Top             =   1800
      Width           =   1860
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Etapa a distribuir"
      Height          =   285
      Left            =   135
      TabIndex        =   7
      Top             =   1080
      Width           =   1815
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   90
      TabIndex        =   3
      Top             =   2925
      Width           =   1845
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   2025
      TabIndex        =   4
      Top             =   2925
      Width           =   1845
   End
   Begin VB.TextBox txtDestino 
      Alignment       =   2  'Center
      DataField       =   "Destino"
      Height          =   330
      Left            =   2115
      TabIndex        =   0
      Top             =   225
      Width           =   1725
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1500
      Left            =   2115
      TabIndex        =   1
      Top             =   630
      Width           =   3975
      _ExtentX        =   7011
      _ExtentY        =   2646
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmDetObrasDestinos.frx":0000
   End
   Begin VB.Label lblLabels 
      Caption         =   "Informacion auxiliar :"
      Height          =   255
      Index           =   1
      Left            =   135
      TabIndex        =   8
      Top             =   1530
      Width           =   1500
   End
   Begin VB.Label lblLabels 
      Caption         =   "Descripcion :"
      Height          =   255
      Index           =   9
      Left            =   135
      TabIndex        =   6
      Top             =   675
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de destino :"
      Height          =   300
      Index           =   0
      Left            =   135
      TabIndex        =   5
      Top             =   225
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetObrasDestinos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetObraDestino
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oObra As ComPronto.Obra
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         If Len(rchObservaciones.Text) = 0 Then
            MsgBox "Debe ingresar la descripcion de la etapa", vbExclamation
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         
         With origen.Registro
            .Fields("Detalle").Value = rchObservaciones.Text
            If Check1.Value = 1 Then
               .Fields("ADistribuir").Value = "SI"
            Else
               .Fields("ADistribuir").Value = Null
            End If
            If Option1.Value Then
               .Fields("TipoConsumo").Value = 1
            ElseIf Option2.Value Then
               .Fields("TipoConsumo").Value = 2
            Else
               .Fields("TipoConsumo").Value = 3
            End If
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
   Set origen = oObra.DetObrasDestinos.Item(vNewValue)
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
      Option3.Value = True
   Else
      With origen.Registro
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Detalle").Value), "", .Fields("Detalle").Value)
         If Not IsNull(.Fields("ADistribuir").Value) And .Fields("ADistribuir").Value = "SI" Then
            Check1.Value = 1
         End If
         If Not IsNull(.Fields("TipoConsumo").Value) Then
            If .Fields("TipoConsumo").Value = 1 Then
               Option1.Value = True
            ElseIf .Fields("TipoConsumo").Value = 2 Then
               Option2.Value = True
            Else
               Option3.Value = True
            End If
         Else
            Option3.Value = True
         End If
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

Private Sub txtDestino_GotFocus()

   With txtDestino
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDestino_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDestino
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtInformacionAuxiliar_GotFocus()

   With txtInformacionAuxiliar
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtInformacionAuxiliar_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtInformacionAuxiliar
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
