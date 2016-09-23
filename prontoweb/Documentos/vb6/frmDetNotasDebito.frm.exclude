VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "msdatlst.ocx"
Begin VB.Form frmDetNotasDebito 
   Caption         =   "Item de nota de debito"
   ClientHeight    =   2880
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6150
   Icon            =   "frmDetNotasDebito.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2880
   ScaleWidth      =   6150
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtCuenta 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   2385
      TabIndex        =   16
      Top             =   540
      Width           =   3345
   End
   Begin VB.TextBox txtCodigoCuenta 
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
      Enabled         =   0   'False
      Height          =   315
      Left            =   1485
      TabIndex        =   14
      Top             =   540
      Width           =   870
   End
   Begin VB.Frame Frame1 
      Height          =   375
      Left            =   2835
      TabIndex        =   10
      Top             =   1665
      Width           =   2895
      Begin VB.OptionButton Option2 
         Caption         =   "NO"
         Height          =   195
         Left            =   2025
         TabIndex        =   12
         Top             =   135
         Width           =   555
      End
      Begin VB.OptionButton Option1 
         Caption         =   "SI"
         Height          =   195
         Left            =   1260
         TabIndex        =   11
         Top             =   135
         Width           =   510
      End
      Begin VB.Label lblLabels 
         Caption         =   "Gravado ?"
         Height          =   165
         Index           =   0
         Left            =   135
         TabIndex        =   13
         Top             =   135
         Width           =   915
      End
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
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1485
      TabIndex        =   3
      Top             =   1755
      Width           =   1275
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   3285
      TabIndex        =   5
      Top             =   2340
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1260
      TabIndex        =   4
      Top             =   2340
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdConcepto"
      Height          =   315
      Index           =   0
      Left            =   1485
      TabIndex        =   0
      Tag             =   "Conceptos"
      Top             =   180
      Width           =   4245
      _ExtentX        =   7488
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdConcepto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaBancaria"
      Height          =   315
      Index           =   4
      Left            =   1485
      TabIndex        =   1
      Tag             =   "CuentasBancarias"
      Top             =   945
      Width           =   4245
      _ExtentX        =   7488
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaBancaria"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCaja"
      Height          =   315
      Index           =   5
      Left            =   1485
      TabIndex        =   2
      Tag             =   "Cajas"
      Top             =   1305
      Width           =   4245
      _ExtentX        =   7488
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCaja"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta contable :"
      Height          =   255
      Index           =   1
      Left            =   135
      TabIndex        =   15
      Top             =   585
      Width           =   1275
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta banco :"
      Height          =   300
      Index           =   6
      Left            =   135
      TabIndex        =   9
      Top             =   945
      Width           =   1275
   End
   Begin VB.Label lblLabels 
      Caption         =   "Caja :"
      Height          =   300
      Index           =   15
      Left            =   135
      TabIndex        =   8
      Top             =   1320
      Width           =   1275
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe :"
      Height          =   255
      Index           =   7
      Left            =   135
      TabIndex        =   7
      Top             =   1800
      Width           =   1275
   End
   Begin VB.Label lblLabels 
      Caption         =   "Concepto :"
      Height          =   300
      Index           =   2
      Left            =   135
      TabIndex        =   6
      Top             =   180
      Width           =   1275
   End
End
Attribute VB_Name = "frmDetNotasDebito"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetNotaDebito
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oNotaDebito As ComPronto.NotaDebito
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long
Private mvarInterna As Boolean

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then
      
      Dim dc As DataCombo
      
      With origen.Registro
         For Each dc In DataCombo1
            If dc.Enabled Then
               If Len(Trim(dc.BoundText)) = 0 Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
               .Fields(dc.DataField).Value = dc.BoundText
            End If
         Next
         If Option1.Value Then
            .Fields("Gravado").Value = "SI"
         Else
            .Fields("Gravado").Value = "NO"
         End If
      End With
      
      origen.Modificado = True
      Aceptado = True
   
   End If
   
   Me.Hide

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion

   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oNotaDebito.DetNotasDebito.Item(vNewValue)
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
               If oControl.Tag = "CuentasBancarias" Then
                  Set oControl.RowSource = oAp.CuentasBancarias.TraerFiltrado("_TodasParaCombo")
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
      Option1.Value = True
   Else
      With origen.Registro
         If IsNull(.Fields("Gravado").Value) Or .Fields("Gravado").Value = "SI" Then
            Option1.Value = True
         Else
            Option2.Value = True
         End If
      End With
   End If
   
   If Me.Interna Then
      Option2.Value = True
      Frame1.Enabled = False
   End If
   
   Set oAp = Nothing

End Property

Public Property Get NotaDebito() As ComPronto.NotaDebito

   Set NotaDebito = oNotaDebito

End Property

Public Property Set NotaDebito(ByVal vNewValue As ComPronto.NotaDebito)

   Set oNotaDebito = vNewValue

End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      Dim oRs As ADOR.Recordset
      Select Case Index
         Case 0
            Set oRs = Aplicacion.Conceptos.TraerFiltrado("_PorIdConDatos", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then
               txtCodigoCuenta.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
               txtCuenta.Text = IIf(IsNull(oRs.Fields("Cuenta").Value), "", oRs.Fields("Cuenta").Value)
               If (Not IsNull(oRs.Fields("GravadoDefault").Value) And _
                     oRs.Fields("GravadoDefault").Value = "NO") Or Me.Interna Then
                  Option2.Value = True
               Else
                  Option1.Value = True
               End If
               If Not IsNull(oRs.Fields("EsCajaBanco").Value) And _
                     oRs.Fields("EsCajaBanco").Value = "BA" Then
                  DataCombo1(4).Enabled = True
               Else
                  origen.Registro.Fields("IdCuentaBancaria").Value = Null
                  DataCombo1(4).Enabled = False
               End If
            End If
            If Not IsNull(oRs.Fields("EsCajaBanco").Value) And _
                  oRs.Fields("EsCajaBanco").Value = "CA" Then
               DataCombo1(5).Enabled = True
            Else
               origen.Registro.Fields("IdCaja").Value = Null
               DataCombo1(5).Enabled = False
            End If
            oRs.Close
      End Select
      Set oRs = Nothing
   End If

End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)

   If mvarId = -1 Then SendKeys "%{DOWN}"

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

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

   Set oNotaDebito = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
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

Public Property Get Interna() As Boolean

   Interna = mvarInterna

End Property

Public Property Let Interna(ByVal vNewValue As Boolean)

   mvarInterna = vNewValue

End Property
