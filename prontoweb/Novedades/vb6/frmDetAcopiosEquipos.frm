VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetAcopiosEquipos 
   Caption         =   "Detalle de equipo"
   ClientHeight    =   2070
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7950
   Icon            =   "frmDetAcopiosEquipos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2070
   ScaleWidth      =   7950
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtTag 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   2385
      TabIndex        =   4
      Top             =   855
      Width           =   1545
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   4095
      TabIndex        =   3
      Top             =   1485
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   2385
      TabIndex        =   2
      Top             =   1485
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdEquipo"
      Height          =   315
      Index           =   0
      Left            =   2385
      TabIndex        =   0
      Tag             =   "Equipos"
      Top             =   405
      Width           =   5280
      _ExtentX        =   9313
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdEquipo"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Revision :"
      Height          =   300
      Index           =   5
      Left            =   405
      TabIndex        =   5
      Top             =   870
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Equipo :"
      Height          =   300
      Index           =   1
      Left            =   405
      TabIndex        =   1
      Top             =   405
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetAcopiosEquipos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetAcopioEquipos
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oAcopio As ComPronto.Acopio
Public Aceptado As Boolean
Private mvarIdNuevo As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim dc As DataCombo
      
         For Each dc In DataCombo1
            If Not IsNumeric(dc.BoundText) Then
               MsgBox "Falta completar el campo " & dc.Tag, vbCritical
               Exit Sub
            End If
            origen.Registro.Fields(dc.DataField).Value = dc.BoundText
         Next
      
         origen.Modificado = True
         Aceptado = True
   
   End Select
   
   Me.Hide

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion

   Set oAp = Aplicacion
   Set origen = oAcopio.DetAcopiosEquipos.Item(vnewvalue)
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
               If oControl.Tag = "Equipos" Then
                  Set oControl.RowSource = oAp.Obras.TraerFiltrado("Equipos", oAcopio.Registro.Fields("IdObra").Value)
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

Public Property Get Acopio() As ComPronto.Acopio

   Set Acopio = oAcopio

End Property

Public Property Set Acopio(ByVal vnewvalue As ComPronto.Acopio)

   Set oAcopio = vnewvalue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      Select Case Index
         Case 0
            Dim oRs As ADOR.Recordset
            Set oRs = Aplicacion.Equipos.Item(DataCombo1(Index).BoundText).Registro
            If Not IsNull(oRs.Fields("Tag").Value) Then
               txtTag.Text = Aplicacion.Equipos.Item(DataCombo1(Index).BoundText).Registro.Fields("Tag").Value
            End If
            oRs.Close
            Set oRs = Nothing
      End Select
   End If

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vnewvalue As Variant)

   mvarIdNuevo = vnewvalue

End Property

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oAcopio = Nothing
   Set oBind = Nothing
   Set origen = Nothing
   
End Sub
