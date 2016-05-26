VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetModificacionActivoFijo 
   Caption         =   "Item de modificacion al activo fijo"
   ClientHeight    =   3510
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7380
   Icon            =   "frmDetModificacionActivoFijo.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3510
   ScaleWidth      =   7380
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtVidaUtilRevaluo 
      Alignment       =   1  'Right Justify
      DataField       =   "VidaUtilRevaluo"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   5310
      TabIndex        =   21
      Top             =   2430
      Width           =   1230
   End
   Begin VB.TextBox txtImporteRevaluo 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteRevaluo"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   5310
      TabIndex        =   17
      Top             =   2070
      Width           =   1230
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   360
      Index           =   1
      Left            =   1755
      TabIndex        =   6
      Top             =   3015
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   360
      Index           =   0
      Left            =   135
      TabIndex        =   5
      Top             =   3015
      Width           =   1485
   End
   Begin VB.TextBox txtModificacionVidaUtilContable 
      Alignment       =   1  'Right Justify
      DataField       =   "ModificacionVidaUtilContable"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2115
      TabIndex        =   4
      Top             =   2520
      Visible         =   0   'False
      Width           =   1230
   End
   Begin VB.TextBox txtModificacionVidaUtilImpositiva 
      Alignment       =   1  'Right Justify
      DataField       =   "ModificacionVidaUtilImpositiva"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2115
      TabIndex        =   3
      Top             =   2115
      Visible         =   0   'False
      Width           =   1230
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "Importe"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2115
      TabIndex        =   2
      Top             =   1710
      Width           =   1230
   End
   Begin VB.TextBox txtDetalle 
      DataField       =   "Detalle"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2115
      TabIndex        =   1
      Top             =   1305
      Width           =   5100
   End
   Begin VB.Frame Frame1 
      Caption         =   "Concepto : "
      Height          =   600
      Left            =   90
      TabIndex        =   8
      Top             =   135
      Width           =   7125
      Begin VB.OptionButton Option4 
         Caption         =   "Revaluo tecnico"
         Height          =   195
         Left            =   5355
         TabIndex        =   16
         Top             =   270
         Width           =   1500
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Baja / Venta"
         Height          =   195
         Left            =   3780
         TabIndex        =   11
         Top             =   270
         Width           =   1410
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Adquisición"
         Height          =   195
         Left            =   135
         TabIndex        =   10
         Top             =   270
         Width           =   1320
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Modificacion / mejora"
         Height          =   195
         Left            =   1665
         TabIndex        =   9
         Top             =   270
         Width           =   1905
      End
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   360
      Index           =   0
      Left            =   2115
      TabIndex        =   0
      Top             =   855
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   635
      _Version        =   393216
      Format          =   63897601
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdRevaluo"
      Height          =   315
      Index           =   0
      Left            =   5310
      TabIndex        =   19
      Tag             =   "Revaluos"
      Top             =   1710
      Width           =   1905
      _ExtentX        =   3360
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdRevaluo"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Vida util al revaluo :"
      Height          =   255
      Index           =   7
      Left            =   3735
      TabIndex        =   22
      Top             =   2460
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Revaluo :"
      Height          =   255
      Index           =   5
      Left            =   3735
      TabIndex        =   20
      Top             =   1755
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe revaluo :"
      Height          =   255
      Index           =   3
      Left            =   3735
      TabIndex        =   18
      Top             =   2100
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Mod. vida util contable :"
      Height          =   255
      Index           =   2
      Left            =   135
      TabIndex        =   15
      Top             =   2550
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Mod. vida util impositiva :"
      Height          =   255
      Index           =   1
      Left            =   135
      TabIndex        =   14
      Top             =   2145
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Afectacion valor original :"
      Height          =   255
      Index           =   0
      Left            =   135
      TabIndex        =   13
      Top             =   1740
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle :"
      Height          =   255
      Index           =   4
      Left            =   135
      TabIndex        =   12
      Top             =   1335
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de modificacion :"
      Height          =   300
      Index           =   6
      Left            =   135
      TabIndex        =   7
      Top             =   900
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetModificacionActivoFijo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetArticuloActivosFijos
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oArticulo As ComPronto.Articulo
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim i As Integer
         
         If txtImporteRevaluo.Enabled And Len(txtImporteRevaluo.Text) = 0 Then
            MsgBox "Falta completar el importe del revaluo"
            Exit Sub
         End If
         
         If txtVidaUtilRevaluo.Enabled And Len(txtVidaUtilRevaluo.Text) = 0 Then
            MsgBox "Falta completar la vida util del revaluo"
            Exit Sub
         End If
         
         For Each dc In DataCombo1
            If dc.Enabled Then
               If Len(Trim(dc.BoundText)) = 0 Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
               origen.Registro.Fields(dc.DataField).Value = dc.BoundText
            End If
         Next
         For Each dtp In DTFields
            If dtp.Enabled Then
               origen.Registro.Fields(dtp.DataField).Value = dtp.Value
            Else
               origen.Registro.Fields(dtp.DataField).Value = Null
            End If
         Next
         
         With origen.Registro
            If Option1.Value Then
               .Fields("TipoConcepto").Value = "A"
            ElseIf Option2.Value Then
               .Fields("TipoConcepto").Value = "M"
            ElseIf Option3.Value Then
               .Fields("TipoConcepto").Value = "B"
            ElseIf Option4.Value Then
               .Fields("TipoConcepto").Value = "R"
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

Public Property Let Id(ByVal vnewvalue As Long)

   Dim dtp As DTPicker
   Dim oControl As Control
   Dim i As Integer
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset

   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oArticulo.DetArticulosActivosFijos.Item(vnewvalue)
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
            If Len(oControl.DataField) Then .Add oControl, "value", oControl.DataField
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
      For Each dtp In DTFields
         If dtp.Enabled Then
            dtp.Value = Date
         End If
      Next
      Option2.Value = True
   Else
      With origen.Registro
         If Not IsNull(.Fields("TipoConcepto").Value) Then
            Select Case .Fields("TipoConcepto").Value
               Case "A"
                  Option1.Value = True
               Case "M"
                  Option2.Value = True
               Case "B"
                  Option3.Value = True
               Case "R"
                  Option4.Value = True
            End Select
         Else
            Option2.Value = True
         End If
      End With
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
End Property

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vnewvalue As Variant)

   mvarIdNuevo = vnewvalue

End Property

Public Property Get Articulo() As ComPronto.Articulo

   Set Articulo = oArticulo

End Property

Public Property Set Articulo(ByVal vnewvalue As ComPronto.Articulo)

   Set oArticulo = vnewvalue

End Property

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

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

Private Sub Option1_Click()

   If Option1.Value Then
      With origen.Registro
         .Fields("IdRevaluo").Value = Null
         .Fields("ImporteRevaluo").Value = 0
         .Fields("VidaUtilRevaluo").Value = 0
      End With
      DataCombo1(0).Enabled = False
      txtImporteRevaluo.Enabled = False
      txtVidaUtilRevaluo.Enabled = False
   End If

End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      With origen.Registro
         .Fields("IdRevaluo").Value = Null
         .Fields("ImporteRevaluo").Value = 0
         .Fields("VidaUtilRevaluo").Value = 0
      End With
      DataCombo1(0).Enabled = False
      txtImporteRevaluo.Enabled = False
      txtVidaUtilRevaluo.Enabled = False
   End If

End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      With origen.Registro
         .Fields("IdRevaluo").Value = Null
         .Fields("ImporteRevaluo").Value = 0
         .Fields("VidaUtilRevaluo").Value = 0
      End With
      DataCombo1(0).Enabled = False
      txtImporteRevaluo.Enabled = False
      txtVidaUtilRevaluo.Enabled = False
   End If

End Sub

Private Sub Option4_Click()

   If Option4.Value Then
      DataCombo1(0).Enabled = True
      txtImporteRevaluo.Enabled = True
      txtVidaUtilRevaluo.Enabled = True
      If Not IsNull(oArticulo.Registro.Fields("VidaUtilContable").Value) And mvarId = -1 Then
         txtVidaUtilRevaluo.Text = oArticulo.Registro.Fields("VidaUtilContable").Value
      End If
   End If
   
End Sub

Private Sub txtDetalle_GotFocus()

   With txtDetalle
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDetalle_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDetalle
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtImporte_GotFocus()

   With txtImporte
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImporte_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtModificacionVidaUtilContable_GotFocus()

   With txtModificacionVidaUtilContable
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtModificacionVidaUtilContable_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtModificacionVidaUtilImpositiva_GotFocus()

   With txtModificacionVidaUtilImpositiva
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtModificacionVidaUtilImpositiva_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

