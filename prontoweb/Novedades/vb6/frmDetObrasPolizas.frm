VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetObrasPolizas 
   Caption         =   "Poliza de obras"
   ClientHeight    =   6135
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7395
   Icon            =   "frmDetObrasPolizas.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6135
   ScaleWidth      =   7395
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtMotivoDeContratacionSeguro 
      DataField       =   "MotivoDeContratacionSeguro"
      Height          =   690
      Left            =   2070
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   9
      Top             =   3330
      Width           =   5235
   End
   Begin VB.TextBox txtCondicionRecupero 
      DataField       =   "CondicionRecupero"
      Height          =   690
      Left            =   2070
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   8
      Top             =   2550
      Width           =   5235
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   90
      TabIndex        =   12
      Top             =   5580
      Width           =   1845
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   90
      TabIndex        =   11
      Top             =   5085
      Width           =   1845
   End
   Begin VB.TextBox txtNumeroPoliza 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroPoliza"
      Height          =   330
      Left            =   2070
      TabIndex        =   2
      Top             =   990
      Width           =   1950
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "Importe"
      Height          =   330
      Left            =   2070
      TabIndex        =   7
      Top             =   2115
      Width           =   1320
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdTipoPoliza"
      Height          =   315
      Index           =   0
      Left            =   2070
      TabIndex        =   0
      Tag             =   "TiposPoliza"
      Top             =   180
      Width           =   4515
      _ExtentX        =   7964
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoPoliza"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   1
      Left            =   2070
      TabIndex        =   1
      Tag             =   "Proveedores"
      Top             =   585
      Width           =   4515
      _ExtentX        =   7964
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaVigencia"
      Height          =   285
      Index           =   0
      Left            =   2070
      TabIndex        =   3
      Top             =   1395
      Width           =   1320
      _ExtentX        =   2328
      _ExtentY        =   503
      _Version        =   393216
      Format          =   62455809
      CurrentDate     =   36432
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaVencimientoCuota"
      Height          =   285
      Index           =   1
      Left            =   2070
      TabIndex        =   4
      Top             =   1755
      Width           =   1320
      _ExtentX        =   2328
      _ExtentY        =   503
      _Version        =   393216
      Format          =   62455809
      CurrentDate     =   36432
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaEstimadaRecupero"
      Height          =   285
      Index           =   2
      Left            =   5805
      TabIndex        =   5
      Top             =   1800
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   503
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   62455809
      CurrentDate     =   36432
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaRecupero"
      Height          =   285
      Index           =   3
      Left            =   5805
      TabIndex        =   6
      Top             =   2160
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   503
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   62455809
      CurrentDate     =   36432
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1905
      Left            =   2115
      TabIndex        =   10
      Top             =   4140
      Width           =   5235
      _ExtentX        =   9234
      _ExtentY        =   3360
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmDetObrasPolizas.frx":076A
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaFinalizacionCobertura"
      Height          =   285
      Index           =   4
      Left            =   5805
      TabIndex        =   24
      Top             =   1425
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   503
      _Version        =   393216
      Format          =   62455809
      CurrentDate     =   36432
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha finalizacion cobertura :"
      Height          =   255
      Index           =   10
      Left            =   3600
      TabIndex        =   25
      Top             =   1440
      Width           =   2130
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   9
      Left            =   90
      TabIndex        =   23
      Top             =   4140
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Motivo de contratacion :"
      Height          =   345
      Index           =   8
      Left            =   90
      TabIndex        =   22
      Top             =   3345
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Condicion de recupero :"
      Height          =   345
      Index           =   7
      Left            =   90
      TabIndex        =   21
      Top             =   2565
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha estimada de recupero :"
      Height          =   255
      Index           =   6
      Left            =   3600
      TabIndex        =   20
      Top             =   1800
      Width           =   2130
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de recupero :"
      Height          =   255
      Index           =   5
      Left            =   3600
      TabIndex        =   19
      Top             =   2160
      Width           =   2130
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de vto. cuota :"
      Height          =   300
      Index           =   4
      Left            =   90
      TabIndex        =   18
      Top             =   1755
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha vigencia :"
      Height          =   300
      Index           =   3
      Left            =   90
      TabIndex        =   17
      Top             =   1365
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Aseguradora :"
      Height          =   300
      Index           =   2
      Left            =   90
      TabIndex        =   16
      Top             =   570
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tipo de poliza :"
      Height          =   300
      Index           =   11
      Left            =   90
      TabIndex        =   15
      Top             =   180
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de poliza :"
      Height          =   345
      Index           =   0
      Left            =   90
      TabIndex        =   14
      Top             =   960
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe :"
      Height          =   300
      Index           =   1
      Left            =   90
      TabIndex        =   13
      Top             =   2160
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetObrasPolizas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetObraPoliza
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oObra As ComPronto.Obra
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim dc As DataCombo
         Dim dtp As DTPicker
         
         With origen.Registro
            For Each dtp In DTPicker1
               If dtp.Enabled Then .Fields(dtp.DataField).Value = dtp.Value
            Next
            For Each dc In DataCombo1
               If dc.Enabled Then
                  If Len(Trim(dc.BoundText)) = 0 Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
                  .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
'            .Fields("EnviarEmail").Value = 1
            .Fields("Observaciones").Value = rchObservaciones.Text
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

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   
   Set oAp = Aplicacion
   mvarId = vNewValue
   Set origen = oObra.DetObrasPolizas.Item(vNewValue)
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
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   If mvarId < 0 Then
      DTPicker1(0).Value = Date
      DTPicker1(1).Value = Date
      
   Else
      With origen.Registro
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
   End If
   
   Set oAp = Nothing
   
End Property

Public Property Get Obra() As ComPronto.Obra

   Set Obra = oObra

End Property

Public Property Set Obra(ByVal vNewValue As ComPronto.Obra)

   Set oObra = vNewValue

End Property

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub DataCombo1_Click(Index As Integer, Area As Integer)

   Dim oRs As ADOR.Recordset
            
   If IsNumeric(DataCombo1(Index).BoundText) Then
   
   End If
      
   Set oRs = Nothing

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

   Set oBind = Nothing
   Set origen = Nothing
   Set oObra = Nothing

End Sub

Private Sub txtCondicionRecupero_GotFocus()

   With txtCondicionRecupero
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCondicionRecupero_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCondicionRecupero
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtMotivoDeContratacionSeguro_GotFocus()

   With txtMotivoDeContratacionSeguro
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtMotivoDeContratacionSeguro_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtMotivoDeContratacionSeguro
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
