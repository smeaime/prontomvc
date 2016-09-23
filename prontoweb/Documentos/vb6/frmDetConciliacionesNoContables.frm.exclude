VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form frmDetConciliacionesNoContables 
   Caption         =   "Items en extracto no contabilizados"
   ClientHeight    =   2445
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7275
   Icon            =   "frmDetConciliacionesNoContables.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2445
   ScaleWidth      =   7275
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   405
      Index           =   1
      Left            =   3735
      TabIndex        =   7
      Top             =   1800
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1980
      TabIndex        =   6
      Top             =   1800
      Width           =   1485
   End
   Begin VB.TextBox txtIngresos 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1710
      TabIndex        =   4
      Top             =   1305
      Width           =   1095
   End
   Begin VB.TextBox txtEgresos 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   5175
      TabIndex        =   5
      Top             =   1305
      Width           =   1095
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
      Left            =   2025
      TabIndex        =   0
      Top             =   225
      Width           =   5145
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaIngreso"
      Height          =   360
      Index           =   0
      Left            =   2025
      TabIndex        =   1
      Top             =   720
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   635
      _Version        =   393216
      Format          =   59768833
      CurrentDate     =   36526
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaRegistroContable"
      Height          =   360
      Index           =   2
      Left            =   6165
      TabIndex        =   3
      Top             =   2790
      Visible         =   0   'False
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   635
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   59768833
      CurrentDate     =   36526
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaCaducidad"
      Height          =   360
      Index           =   1
      Left            =   5670
      TabIndex        =   2
      Top             =   720
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   635
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   59768833
      CurrentDate     =   36526
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ingresos :"
      Height          =   300
      Index           =   8
      Left            =   630
      TabIndex        =   13
      Top             =   1305
      Width           =   915
   End
   Begin VB.Label lblLabels 
      Caption         =   "Egresos :"
      Height          =   300
      Index           =   10
      Left            =   4095
      TabIndex        =   12
      Top             =   1305
      Width           =   915
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha registro contable :"
      Height          =   255
      Index           =   2
      Left            =   4230
      TabIndex        =   11
      Top             =   2835
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de caducidad :"
      Height          =   255
      Index           =   1
      Left            =   3735
      TabIndex        =   10
      Top             =   765
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de ingreso :"
      Height          =   255
      Index           =   0
      Left            =   90
      TabIndex        =   9
      Top             =   765
      Width           =   1815
   End
   Begin VB.Label lblData 
      Caption         =   "Detalle :"
      Height          =   255
      Index           =   0
      Left            =   90
      TabIndex        =   8
      Top             =   270
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetConciliacionesNoContables"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetConciliacionNoContable
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oConciliacion As ComPronto.Conciliacion
Public Aceptado As Boolean
Private mFechaFinalResumen As Date, mFechaInicialResumen As Date
Private mvarIdNuevo As Long, mvarId As Long

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then
      
      If (Len(txtIngresos.Text) = 0 Or Not IsNumeric(txtIngresos.Text)) And _
            (Len(txtEgresos.Text) = 0 Or Not IsNumeric(txtEgresos.Text)) Then
         MsgBox "Debe indicar el importe (Ingresos o Egresos)", vbExclamation
         Exit Sub
      End If
      
'      If DTFields(0).Value > Me.FechaFinalResumen Then
'         MsgBox "La fecha de ingreso del movimiento no puede ser posterior" & vbCrLf & _
'                  "a la fecha final del resumen.", vbExclamation
'         Exit Sub
'      End If
'
'      If DTFields(0).Value < Me.FechaInicialResumen Then
'         MsgBox "La fecha de ingreso del movimiento no puede ser anterior" & vbCrLf & _
'                  "a la fecha inicial del resumen.", vbExclamation
'         Exit Sub
'      End If
'
'      If DTFields(1).Value < Me.FechaInicialResumen Then
'         MsgBox "La fecha de caducidad del movimiento no puede ser anterior" & vbCrLf & _
'                  "a la fecha inicial del resumen.", vbExclamation
'         Exit Sub
'      End If
      
      Dim oRs As ADOR.Recordset
      
      With origen.Registro
'         .Fields("FechaIngreso").Value = DTFields(0).Value
'         .Fields("FechaCaducidad").Value = DTFields(1).Value
'         .Fields("FechaRegistroContable").Value = DTFields(2).Value
         .Fields("Ingresos").Value = Val(txtIngresos.Text)
         .Fields("Egresos").Value = Val(txtEgresos.Text)
      End With
      
      Set oRs = Nothing
      
      origen.Modificado = True
      Aceptado = True
   
   End If
   
   Me.Hide
 
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oConciliacion.DetConciliacionesNoContables.Item(vNewValue)
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
'      DTFields(0).Value = Date
'      DTFields(1).Value = Null
'      DTFields(2).Value = Null
   Else
      With origen.Registro
'         DTFields(0).Value = .Fields("FechaIngreso").Value
'         DTFields(1).Value = .Fields("FechaCaducidad").Value
'         DTFields(2).Value = .Fields("FechaRegistroContable").Value
         txtIngresos.Text = IIf(IsNull(.Fields("Ingresos").Value), "", .Fields("Ingresos").Value)
         txtEgresos.Text = IIf(IsNull(.Fields("Egresos").Value), "", .Fields("Egresos").Value)
      End With
   End If
   
   Set oAp = Nothing

End Property

Public Property Get Conciliacion() As ComPronto.Conciliacion

   Set Conciliacion = oConciliacion

End Property

Public Property Set Conciliacion(ByVal vNewValue As ComPronto.Conciliacion)

   Set oConciliacion = vNewValue

End Property

Private Sub DTFields_Click(Index As Integer)

   If IsNull(origen.Registro.Fields(DTFields(Index).DataField).Value) Then
      origen.Registro.Fields(DTFields(Index).DataField).Value = Date
      DTFields(Index).Value = Date
   End If
   
End Sub

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

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub Form_Unload(Cancel As Integer)

   Set oConciliacion = Nothing
   Set origen = Nothing
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

Private Sub txtEgresos_GotFocus()

   With txtEgresos
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtEgresos_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtIngresos_GotFocus()

   With txtIngresos
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtIngresos_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Public Property Get FechaFinalResumen() As Date

   FechaFinalResumen = mFechaFinalResumen

End Property

Public Property Let FechaFinalResumen(ByVal vNewValue As Date)

   mFechaFinalResumen = vNewValue

End Property

Public Property Get FechaInicialResumen() As Date

   FechaInicialResumen = mFechaInicialResumen

End Property

Public Property Let FechaInicialResumen(ByVal vNewValue As Date)

   mFechaInicialResumen = vNewValue

End Property

