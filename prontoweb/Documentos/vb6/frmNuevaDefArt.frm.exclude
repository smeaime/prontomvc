VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmNuevaDefArt 
   Caption         =   "Copiar una definicion de articulo"
   ClientHeight    =   1590
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8115
   Icon            =   "frmNuevaDefArt.frx":0000
   ScaleHeight     =   1590
   ScaleWidth      =   8115
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   4185
      TabIndex        =   3
      Top             =   990
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   2385
      TabIndex        =   2
      Top             =   990
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   2925
      TabIndex        =   0
      Tag             =   "DefinicionArticulos"
      Top             =   270
      Width           =   5055
      _ExtentX        =   8916
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdDef"
      Text            =   ""
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Definicion a copiar : "
      Height          =   285
      Index           =   0
      Left            =   225
      TabIndex        =   1
      Top             =   270
      Width           =   2670
   End
End
Attribute VB_Name = "frmNuevaDefArt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim origen As ComPronto.DefinicionArt
Dim mvarId As Long
Dim oRs As ADOR.Recordset
Public Cancelado As Boolean

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Dim dc As DataCombo
         For Each dc In DataCombo1
            If Len(Trim(dc.BoundText)) = 0 Then
               MsgBox "Falta completar el campo " & dc.Tag, vbCritical
               Exit Sub
            End If
         Next
         mvarId = IIf(IsNumeric(DataCombo1(0).BoundText), DataCombo1(0).BoundText, 0)
         Cancelado = False
      Case 1
         Cancelado = True
   End Select
   
   Me.Hide

End Sub

Public Property Get Id() As Long
   
   Id = mvarId

End Property

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oAp.DefinicionesArt.Item(vnewvalue)
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               Set oControl.RowSource = oAp.DefinicionesArt.TraerFiltrado("_Copia")
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
   
   Set oAp = Nothing

End Property

Private Sub Form_Activate()

   DataCombo1(0).BoundText = mvarId
   
End Sub

Private Sub Form_Deactivate()

   Set origen = Nothing

End Sub

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set origen = Nothing

End Sub
