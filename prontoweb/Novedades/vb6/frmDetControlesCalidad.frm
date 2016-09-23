VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetControlesCalidad 
   Caption         =   "Item de control de calidad"
   ClientHeight    =   2805
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9495
   Icon            =   "frmDetControlesCalidad.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2805
   ScaleWidth      =   9495
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtTrasabilidad 
      DataField       =   "Trasabilidad"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   5085
      TabIndex        =   1
      Top             =   135
      Width           =   1905
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   4905
      TabIndex        =   8
      Top             =   2250
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   3150
      TabIndex        =   7
      Top             =   2250
      Width           =   1485
   End
   Begin VB.TextBox txtCantidad 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2070
      TabIndex        =   0
      Top             =   135
      Width           =   870
   End
   Begin VB.TextBox txtCantidadRechazada 
      Alignment       =   1  'Right Justify
      DataField       =   "CantidadRechazada"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2070
      TabIndex        =   2
      Top             =   510
      Width           =   870
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   870
      Left            =   2070
      TabIndex        =   6
      Top             =   1275
      Width           =   7305
      _ExtentX        =   12885
      _ExtentY        =   1535
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmDetControlesCalidad.frx":076A
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdRealizo"
      Height          =   315
      Index           =   6
      Left            =   2070
      TabIndex        =   4
      Tag             =   "Empleados"
      Top             =   915
      Width           =   3930
      _ExtentX        =   6932
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdMotivoRechazo"
      Height          =   315
      Index           =   2
      Left            =   5085
      TabIndex        =   3
      Tag             =   "MotivosRechazo"
      Top             =   510
      Width           =   4290
      _ExtentX        =   7567
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdMotivoRechazo"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   330
      Index           =   0
      Left            =   8100
      TabIndex        =   5
      Top             =   900
      Width           =   1260
      _ExtentX        =   2223
      _ExtentY        =   582
      _Version        =   393216
      Format          =   63963137
      CurrentDate     =   36377
   End
   Begin VB.Label lblLabels 
      Caption         =   "Trasabilidad :"
      Height          =   300
      Index           =   0
      Left            =   3555
      TabIndex        =   15
      Top             =   150
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha del control : "
      Height          =   240
      Index           =   4
      Left            =   6345
      TabIndex        =   14
      Top             =   945
      Width           =   1680
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad aceptada :"
      Height          =   300
      Index           =   8
      Left            =   90
      TabIndex        =   13
      Top             =   150
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones control :"
      Height          =   300
      Index           =   9
      Left            =   90
      TabIndex        =   12
      Top             =   1320
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Realizo :"
      Height          =   300
      Index           =   10
      Left            =   90
      TabIndex        =   11
      Top             =   915
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad rechazada :"
      Height          =   300
      Index           =   12
      Left            =   90
      TabIndex        =   10
      Top             =   525
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Motivo rechazo :"
      Height          =   300
      Index           =   13
      Left            =   3555
      TabIndex        =   9
      Top             =   510
      Width           =   1455
   End
End
Attribute VB_Name = "frmDetControlesCalidad"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetControlCalidad
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oCCalidad As ComPronto.CCalidad
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mvarIdEntidad As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim mvarCantidadAdicionalCC As Double
      
'         If IsNull(origen.Registro.Fields("Cantidad").Value) Or origen.Registro.Fields("Cantidad").Value = 0 Then
'            MsgBox "Falta ingresar la cantidad (unidades)", vbCritical
'            Exit Sub
'         End If
         
         mvarCantidadAdicionalCC = 0
         With oCCalidad.Registro
            If Not IsNull(.Fields("Cantidad1").Value) Then
               mvarCantidadAdicionalCC = .Fields("Cantidad1").Value
            End If
            If Not IsNull(.Fields("Cantidad1").Value) And Not IsNull(.Fields("Cantidad2").Value) Then
               mvarCantidadAdicionalCC = .Fields("Cantidad1").Value * .Fields("Cantidad2").Value
            End If
         End With

         With origen.Registro
            For Each dtp In DTFields
               If dtp.Enabled Then
                  .Fields(dtp.DataField).Value = dtp.Value
               End If
            Next
            For Each dc In DataCombo1
               If dc.Enabled Then
                  If Not IsNumeric(dc.BoundText) Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
                  .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
            .Fields("CantidadAdicional").Value = mvarCantidadAdicionalCC * .Fields("Cantidad").Value
            .Fields("Observaciones").Value = rchObservaciones.Text
            If Me.IdEntidad > 1000000 Then
               .Fields("IdDetalleOtroIngresoAlmacen").Value = Me.IdEntidad - 1000000
            Else
               .Fields("IdDetalleRecepcion").Value = Me.IdEntidad
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

Private Sub DataCombo1_GotFocus(Index As Integer)

   If mvarId = -1 Then SendKeys "%{DOWN}"

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim dtp As DTPicker
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset

   Set oAp = Aplicacion
   mvarId = vnewvalue
   Set origen = oCCalidad.DetControlesCalidad.Item(vnewvalue)
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
               If oControl.Tag = "Empleados" Then
                  Set oControl.RowSource = oAp.Empleados.TraerFiltrado("_PorSector", "Control de Calidad")
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   End With
   
   If mvarId = -1 Then
      For Each dtp In DTFields
         If dtp.Enabled Then
            dtp.Value = Date
         End If
      Next
      DataCombo1(6).BoundText = glbIdUsuario
   Else
      With origen.Registro
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
End Property

Public Property Get CCalidad() As ComPronto.CCalidad

   Set CCalidad = oCCalidad

End Property

Public Property Set CCalidad(ByVal vnewvalue As ComPronto.CCalidad)

   Set oCCalidad = vnewvalue

End Property

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

   Me.Top = Screen.Height - Me.Height - (Me.Height * 0.2)
   Me.Left = Int(Screen.Width / 2) - Int(Me.Width / 2)
   
   ReemplazarEtiquetas Me
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oBind = Nothing
   Set origen = Nothing
   Set oCCalidad = Nothing

End Sub

Private Sub txtCantidad_GotFocus()
   
   With txtCantidad
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidad_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCantidadRechazada_Change()

   If Len(Trim(txtCantidadRechazada.Text)) > 0 And Val(txtCantidadRechazada.Text) > 0 Then
      DataCombo1(2).Enabled = True
   Else
      DataCombo1(2).Enabled = False
   End If

End Sub

Private Sub txtCantidadRechazada_GotFocus()

   With txtCantidadRechazada
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCantidadRechazada_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtTrasabilidad_GotFocus()

   With txtTrasabilidad
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTrasabilidad_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Get IdEntidad() As Long

   IdEntidad = mvarIdEntidad

End Property

Public Property Let IdEntidad(ByVal vnewvalue As Long)

   mvarIdEntidad = vnewvalue

End Property
