VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetLMaterialesRevision 
   Caption         =   "Item de lista de materiales ( Revisiones )"
   ClientHeight    =   5220
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7080
   Icon            =   "frmDetLMaterialesRevision.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5220
   ScaleWidth      =   7080
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtRevision 
      Alignment       =   2  'Center
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
      Height          =   315
      Left            =   3690
      Locked          =   -1  'True
      TabIndex        =   22
      Top             =   945
      Width           =   690
   End
   Begin VB.TextBox txtPosicion 
      Alignment       =   2  'Center
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
      Height          =   315
      Left            =   2925
      Locked          =   -1  'True
      TabIndex        =   21
      Top             =   945
      Width           =   690
   End
   Begin VB.TextBox txtConjunto 
      Alignment       =   2  'Center
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
      Height          =   315
      Left            =   2160
      Locked          =   -1  'True
      TabIndex        =   19
      Top             =   945
      Width           =   690
   End
   Begin VB.TextBox txtNumeroRevision 
      DataField       =   "NumeroRevision"
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
      Height          =   315
      Left            =   2160
      TabIndex        =   1
      Top             =   135
      Width           =   1590
   End
   Begin VB.Frame Frame1 
      Enabled         =   0   'False
      Height          =   555
      Left            =   4005
      TabIndex        =   0
      Top             =   180
      Width           =   2895
      Begin VB.OptionButton Option1 
         Caption         =   "Revision"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   180
         TabIndex        =   17
         Top             =   225
         Width           =   1230
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Avance"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   1530
         TabIndex        =   16
         Top             =   225
         Width           =   1095
      End
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
      Height          =   1575
      Left            =   2160
      TabIndex        =   3
      Top             =   1350
      Width           =   4740
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   8
      Top             =   4680
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1845
      TabIndex        =   9
      Top             =   4680
      Width           =   1485
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   360
      Index           =   0
      Left            =   2160
      TabIndex        =   2
      Top             =   495
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   635
      _Version        =   393216
      Format          =   59768833
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaRealizacion"
      Height          =   360
      Index           =   1
      Left            =   2160
      TabIndex        =   5
      Top             =   3375
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   635
      _Version        =   393216
      Format          =   59768833
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaAprobacion"
      Height          =   360
      Index           =   2
      Left            =   2160
      TabIndex        =   7
      Top             =   4185
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   635
      _Version        =   393216
      Format          =   59768833
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdRealizo"
      Height          =   315
      Index           =   0
      Left            =   2160
      TabIndex        =   4
      Tag             =   "Empleados"
      Top             =   3015
      Width           =   4740
      _ExtentX        =   8361
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdAprobo"
      Height          =   315
      Index           =   1
      Left            =   2160
      TabIndex        =   6
      Tag             =   "Empleados"
      Top             =   3825
      Width           =   4740
      _ExtentX        =   8361
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Conj. - Posicion - Revis. :"
      Height          =   300
      Index           =   3
      Left            =   180
      TabIndex        =   20
      Top             =   990
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de revision :"
      Height          =   300
      Index           =   7
      Left            =   180
      TabIndex        =   18
      Top             =   180
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha :"
      Height          =   300
      Index           =   0
      Left            =   180
      TabIndex        =   15
      Top             =   585
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle :"
      Height          =   300
      Index           =   1
      Left            =   180
      TabIndex        =   14
      Top             =   1395
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Realizo :"
      Height          =   300
      Index           =   2
      Left            =   180
      TabIndex        =   13
      Top             =   3015
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha realizacion :"
      Height          =   300
      Index           =   4
      Left            =   180
      TabIndex        =   12
      Top             =   3375
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Aprobo :"
      Height          =   300
      Index           =   5
      Left            =   180
      TabIndex        =   11
      Top             =   3825
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de aprobacion :"
      Height          =   300
      Index           =   6
      Left            =   180
      TabIndex        =   10
      Top             =   4185
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetLMaterialesRevision"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetLMaterialRevisiones
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oLMaterial As ComPronto.LMaterial
Public Aceptado As Boolean
Public Tipo As String
Private mvarTipo As String
Private mvarId As Long, mvarIdNuevo As Long, mvarIdDetalleLMateriales As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
      
         If DTFields(1).Value > DTFields(2).Value Then
            MsgBox "La fecha de realizacion no puede ser mayor a la de aprobacion", vbExclamation
            Exit Sub
         End If
         
         For Each dtp In DTFields
            If dtp.Enabled Then
               If oLMaterial.Registro.Fields("Fecha").Value > dtp.Value Then
                  MsgBox "Hay fechas de revision anteriores a la fecha de la lista de materiales", vbExclamation
                  Exit Sub
               End If
               origen.Registro.Fields(dtp.DataField).Value = dtp.Value
            End If
         Next
         
         With origen.Registro
            .Fields("IdLMateriales").Value = oLMaterial.Id
            If Option1.Value Then
               .Fields("TipoRegistro").Value = "R"
               Tipo = "R"
            Else
               .Fields("TipoRegistro").Value = "A"
               Tipo = "A"
            End If
            .Fields("IdDetalleLMateriales").Value = Me.IdDetalleLMateriales
         End With

         For Each dc In dcfields
            If IsNumeric(dc.BoundText) Then
               origen.Registro.Fields(dc.DataField).Value = dc.BoundText
            End If
         Next
   
         origen.Modificado = True
         Aceptado = True
   
      Case 1
         If mvarIdNuevo < 0 Then
            origen.Eliminado = True
         End If
   
   End Select
   
   Me.Hide

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim dtp As DTPicker

   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oLMaterial.DetLMaterialesRevisiones.Item(vNewValue)
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
'            .Add oControl, "text", oControl.DataField
            Set oControl.DataSource = origen
         End If
      Next
   End With
   
   If mvarId = -1 Then
      If Me.TipoRevision = "R" Then
         Option1.Value = True
      ElseIf Me.TipoRevision = "A" Then
         Option2.Value = True
      End If
      For Each dtp In DTFields
         If dtp.Enabled Then
            dtp.Value = Date
         End If
      Next
   Else
      If IsNull(origen.Registro.Fields("TipoRegistro").Value) Then
         Option1.Value = True
      ElseIf origen.Registro.Fields("TipoRegistro").Value = "R" Then
         Option1.Value = True
      ElseIf origen.Registro.Fields("TipoRegistro").Value = "A" Then
         Option2.Value = True
      End If
      Me.IdDetalleLMateriales = origen.Registro.Fields("IdDetalleLMateriales").Value
   End If

   If Option1.Value Then
      lblLabels(3).Visible = False
      txtConjunto.Visible = False
      txtPosicion.Visible = False
      txtRevision.Visible = False
   Else
      Set oRs = LMaterial.DetLMateriales.TraerFiltrado("_UnItem", Me.IdDetalleLMateriales)
      txtConjunto.Text = oRs.Fields("NumeroItem").Value
      txtPosicion.Text = oRs.Fields("NumeroOrden").Value
      txtRevision.Text = oRs.Fields("Revision").Value
      oRs.Close
   End If

   Set oRs = Nothing
   Set oAp = Nothing

End Property

Public Property Get LMaterial() As ComPronto.LMaterial

   Set LMaterial = oLMaterial

End Property

Public Property Set LMaterial(ByVal vNewValue As ComPronto.LMaterial)

   Set oLMaterial = vNewValue

End Property

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Public Property Let TipoRevision(ByVal vNewValue As String)

   mvarTipo = vNewValue

End Property

Public Property Get TipoRevision() As String

   TipoRevision = mvarTipo

End Property

Public Property Let IdDetalleLMateriales(ByVal vNewValue As Long)

   mvarIdDetalleLMateriales = vNewValue

End Property

Public Property Get IdDetalleLMateriales() As Long

   IdDetalleLMateriales = mvarIdDetalleLMateriales

End Property

Private Sub Form_Activate()

'   If Len(Trim(txtItem.Text)) = 0 Then
'      txtItem.Text = oLMaterial.DetLMateriales.Item(mvarIdDetLMaterial).DetLMaterialesRevisiones.UltimoItemDetalle
'      origen.Registro.Fields("NumeroItem").Value = 1
'   End If
   
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

Private Sub txtNumeroRevision_GotFocus()

   With txtNumeroRevision
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroRevision_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtNumeroRevision
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
