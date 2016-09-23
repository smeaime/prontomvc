VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetArticulosUnidades 
   Caption         =   "Item de unidad por articulo"
   ClientHeight    =   2085
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4125
   LinkTopic       =   "Form1"
   ScaleHeight     =   2085
   ScaleWidth      =   4125
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   225
      TabIndex        =   2
      Top             =   1530
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   2385
      TabIndex        =   3
      Top             =   1530
      Width           =   1485
   End
   Begin VB.TextBox txtEquivalencia 
      Alignment       =   1  'Right Justify
      DataField       =   "Equivalencia"
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
      Left            =   2655
      TabIndex        =   1
      Top             =   945
      Width           =   1185
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   0
      Left            =   1125
      TabIndex        =   0
      Tag             =   "Unidades"
      Top             =   495
      Width           =   2715
      _ExtentX        =   4789
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin VB.Label lblUnidad 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   270
      TabIndex        =   6
      Top             =   90
      Width           =   3570
   End
   Begin VB.Label lblLabels 
      Caption         =   "Equivalencia a unidad standar :"
      Height          =   255
      Index           =   0
      Left            =   225
      TabIndex        =   5
      Top             =   990
      Width           =   2310
   End
   Begin VB.Label lblLabels 
      Caption         =   "Unidad :"
      Height          =   255
      Index           =   4
      Left            =   225
      TabIndex        =   4
      Top             =   540
      Width           =   780
   End
End
Attribute VB_Name = "frmDetArticulosUnidades"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetArticuloUnidades
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oArticulo As ComPronto.Articulo
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long, mObra As Long
Private mvarIdUnidad As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim dc As DataCombo
         
         For Each dc In DataCombo1
            If dc.Enabled Then
               If Not IsNumeric(dc.BoundText) Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
               origen.Registro.Fields(dc.DataField).Value = dc.BoundText
            End If
         Next
      
         If Len(txtEquivalencia.Text) = 0 Or Val(txtEquivalencia.Text) = 0 Then
            MsgBox "Falta ingresar la equivalencia", vbCritical
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

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim dtp As DTPicker
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset

   Set oAp = Aplicacion
   
   mvarId = vnewvalue
   Set origen = oArticulo.DetArticulosUnidades.Item(vnewvalue)
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
   
   Set oRs = oAp.Unidades.TraerFiltrado("_PorId", Me.IdUnidad)
   If oRs.RecordCount > 0 Then
      lblUnidad.Caption = "Unidad standar : " & oRs.Fields("Descripcion").Value
   End If
   oRs.Close
   
   If mvarId = -1 Then
      With origen.Registro
      
      End With
   Else
      With origen.Registro
      
      End With
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
End Property

Public Property Get Articulo() As ComPronto.Articulo

   Set Articulo = oArticulo

End Property

Public Property Set Articulo(ByVal vnewvalue As ComPronto.Articulo)

   Set oArticulo = vnewvalue

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

   Set oBind = Nothing
   Set origen = Nothing
   Set oArticulo = Nothing

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vnewvalue As Variant)

   mvarIdNuevo = vnewvalue

End Property

Public Property Get IdUnidad() As Long

   IdUnidad = mvarIdUnidad

End Property

Public Property Let IdUnidad(ByVal vnewvalue As Long)

   mvarIdUnidad = vnewvalue

End Property

Private Sub txtEquivalencia_GotFocus()

   With txtEquivalencia
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtEquivalencia_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
