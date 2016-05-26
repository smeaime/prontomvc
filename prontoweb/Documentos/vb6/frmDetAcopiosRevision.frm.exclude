VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetAcopiosRevision 
   Caption         =   "Item de lista de acopio ( Revisiones )"
   ClientHeight    =   4245
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7320
   Icon            =   "frmDetAcopiosRevision.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4245
   ScaleWidth      =   7320
   StartUpPosition =   2  'CenterScreen
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
      Height          =   720
      Left            =   2250
      TabIndex        =   2
      Top             =   1035
      Width           =   4740
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
      Left            =   2250
      TabIndex        =   0
      Top             =   225
      Width           =   1590
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   3780
      TabIndex        =   8
      Top             =   3600
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   2070
      TabIndex        =   7
      Top             =   3600
      Width           =   1485
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   360
      Index           =   0
      Left            =   2250
      TabIndex        =   1
      Top             =   585
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   635
      _Version        =   393216
      Format          =   64552961
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaRealizacion"
      Height          =   360
      Index           =   1
      Left            =   2250
      TabIndex        =   4
      Top             =   2250
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   635
      _Version        =   393216
      Format          =   64552961
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaAprobacion"
      Height          =   360
      Index           =   2
      Left            =   2250
      TabIndex        =   6
      Top             =   3060
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   635
      _Version        =   393216
      Format          =   64552961
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdRealizo"
      Height          =   315
      Index           =   0
      Left            =   2250
      TabIndex        =   3
      Tag             =   "Empleados"
      Top             =   1890
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
      Left            =   2250
      TabIndex        =   5
      Tag             =   "Empleados"
      Top             =   2700
      Width           =   4740
      _ExtentX        =   8361
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de aprobacion :"
      Height          =   300
      Index           =   6
      Left            =   270
      TabIndex        =   15
      Top             =   3060
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Aprobo :"
      Height          =   300
      Index           =   5
      Left            =   270
      TabIndex        =   14
      Top             =   2700
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha realizacion :"
      Height          =   300
      Index           =   4
      Left            =   270
      TabIndex        =   13
      Top             =   2250
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Realizo :"
      Height          =   300
      Index           =   2
      Left            =   270
      TabIndex        =   12
      Top             =   1890
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle :"
      Height          =   300
      Index           =   1
      Left            =   270
      TabIndex        =   11
      Top             =   1080
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha :"
      Height          =   300
      Index           =   0
      Left            =   270
      TabIndex        =   10
      Top             =   675
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de revision :"
      Height          =   300
      Index           =   7
      Left            =   270
      TabIndex        =   9
      Top             =   270
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetAcopiosRevision"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetAcopioRevisiones
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oAcopio As ComPronto.Acopio
Public Aceptado As Boolean
Private mvarId As Long, mvarIdNuevo As Long

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
               If oAcopio.Registro.Fields("Fecha").Value > dtp.Value Then
                  MsgBox "Hay fechas de revision anteriores a la fecha de la lista de acopio", vbExclamation
                  Exit Sub
               End If
               origen.Registro.Fields(dtp.DataField).Value = dtp.Value
            End If
         Next
         
         With origen.Registro
'            .Fields("IdDetalleAcopio").Value = mvarIdDetAcopio
            .Fields("IdAcopio").Value = oAcopio.Id
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

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim dtp As DTPicker

   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oAcopio.DetAcopiosRevisiones.Item(vnewvalue)
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
   
   If mvarId = -1 Then
      For Each dtp In DTFields
         If dtp.Enabled Then
            dtp.Value = Date
         End If
      Next
   End If

   Set oAp = Nothing
   
End Property

Public Property Get Acopio() As ComPronto.Acopio

   Set Acopio = oAcopio

End Property

Public Property Set Acopio(ByVal vnewvalue As ComPronto.Acopio)

   Set oAcopio = vnewvalue

End Property

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Activate()

'   If Len(Trim(txtItem.Text)) = 0 Then
'      txtItem.Text = oAcopio.DetAcopios.Item(mvarIdDetAcopio).DetAcopiosRevisiones.UltimoItemDetalle
'      origen.Registro.Fields("NumeroItem").Value = 1
'   End If
   
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

