VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetLMaterialesSubtitulos 
   Caption         =   "Ingreso de subtitulos"
   ClientHeight    =   2130
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7425
   Icon            =   "frmDetLMaterialesSubtitulos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2130
   ScaleWidth      =   7425
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   3870
      TabIndex        =   4
      Top             =   1530
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   2160
      TabIndex        =   3
      Top             =   1530
      Width           =   1485
   End
   Begin VB.TextBox txtDetalle 
      DataField       =   "Detalle"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   2475
      TabIndex        =   1
      Top             =   540
      Width           =   4740
   End
   Begin VB.TextBox txtItem 
      DataField       =   "NumeroItem"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   2475
      TabIndex        =   0
      Top             =   135
      Width           =   645
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "Despacha"
      Height          =   315
      Index           =   0
      Left            =   2475
      TabIndex        =   2
      Tag             =   "SiNo"
      Top             =   990
      Width           =   780
      _ExtentX        =   1376
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "SiNo"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Despacha ? :"
      Height          =   300
      Index           =   8
      Left            =   495
      TabIndex        =   7
      Top             =   990
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Subtitulo :"
      Height          =   300
      Index           =   2
      Left            =   495
      TabIndex        =   6
      Top             =   585
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item :"
      Height          =   300
      Index           =   3
      Left            =   495
      TabIndex        =   5
      Top             =   180
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetLMaterialesSubtitulos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetLMaterial
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oLMaterial As ComPronto.LMaterial
Private mvarIdUnidadCU As Integer
Public Aceptado As Boolean
Private mvarId As Long, mvarIdNuevo As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
         
         Dim dc As DataCombo
         
         For Each dc In DataCombo1
            If dc.Enabled Then
               If Len(Trim(dc.BoundText)) <> 0 Then
                  origen.Registro.Fields(dc.DataField).Value = dc.BoundText
               End If
            End If
         Next
         
         origen.Registro.Fields("NumeroOrden").Value = 0
         origen.Modificado = True
         Aceptado = True
         
         Me.Hide
      
      Case 1
         
         Me.Hide
   
   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oLMaterial.DetLMateriales.Item(vnewvalue)
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
                  Set oControl.RowSource = oAp.Acopios.TraerFiltrado("Items", LMaterial.Registro.Fields("IdAcopio").Value)
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
   
   If mvarId = -1 Then
      With origen.Registro
         .Fields("Despacha").Value = "NO"
         .Fields("NumeroItem").Value = LMaterial.DetLMateriales.ProximoConjunto
      End With
   End If
   
   Set oAp = Nothing
   
End Property

Public Property Get LMaterial() As ComPronto.LMaterial

   Set LMaterial = oLMaterial

End Property

Public Property Set LMaterial(ByVal vnewvalue As ComPronto.LMaterial)

   Set oLMaterial = vnewvalue

End Property

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vnewvalue As Variant)

   mvarIdNuevo = vnewvalue

End Property

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   ReemplazarEtiquetas Me

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set origen = Nothing
   Set oLMaterial = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub txtDetalle_GotFocus()

   With txtDetalle
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDetalle_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtItem_GotFocus()
   
   With txtItem
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtItem_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

