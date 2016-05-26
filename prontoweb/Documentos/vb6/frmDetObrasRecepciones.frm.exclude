VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetObrasRecepciones 
   Caption         =   "Item de recepciones de la obra"
   ClientHeight    =   4890
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6780
   Icon            =   "frmDetObrasRecepciones.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4890
   ScaleWidth      =   6780
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtFechaAprobo 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      Height          =   330
      Left            =   5310
      TabIndex        =   19
      Top             =   3915
      Width           =   1275
   End
   Begin VB.TextBox txtFechaRealizo 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      Height          =   330
      Left            =   5310
      TabIndex        =   18
      Top             =   3555
      Width           =   1275
   End
   Begin VB.Frame Frame1 
      Height          =   555
      Left            =   180
      TabIndex        =   11
      Top             =   630
      Width           =   5235
      Begin VB.OptionButton Option2 
         Caption         =   "Definitiva"
         Height          =   195
         Left            =   3825
         TabIndex        =   13
         Top             =   225
         Width           =   1140
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Provisoria"
         Height          =   195
         Left            =   2115
         TabIndex        =   12
         Top             =   225
         Width           =   1275
      End
      Begin VB.Label Label1 
         Caption         =   "Tipo de recepcion :"
         Height          =   240
         Left            =   180
         TabIndex        =   14
         Top             =   225
         Width           =   1500
      End
   End
   Begin VB.TextBox txtNumeroRecepcion 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroRecepcion"
      Height          =   330
      Left            =   2160
      TabIndex        =   2
      Top             =   225
      Width           =   1185
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   1
      Top             =   4365
      Width           =   1845
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   2070
      TabIndex        =   0
      Top             =   4365
      Width           =   1845
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdRealizo"
      Height          =   315
      Index           =   0
      Left            =   945
      TabIndex        =   3
      Tag             =   "Empleados"
      Top             =   3555
      Width           =   2940
      _ExtentX        =   5186
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaRecepcion"
      Height          =   285
      Index           =   0
      Left            =   5265
      TabIndex        =   4
      Top             =   225
      Width           =   1320
      _ExtentX        =   2328
      _ExtentY        =   503
      _Version        =   393216
      Format          =   59441153
      CurrentDate     =   36432
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1905
      Left            =   180
      TabIndex        =   5
      Top             =   1530
      Width           =   6405
      _ExtentX        =   11298
      _ExtentY        =   3360
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmDetObrasRecepciones.frx":076A
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdAprobo"
      Height          =   315
      Index           =   1
      Left            =   945
      TabIndex        =   15
      Tag             =   "Empleados"
      Top             =   3915
      Width           =   2940
      _ExtentX        =   5186
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Aprobo :"
      Height          =   255
      Index           =   2
      Left            =   180
      TabIndex        =   17
      Top             =   3960
      Width           =   690
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha aprobo :"
      Height          =   255
      Index           =   1
      Left            =   4005
      TabIndex        =   16
      Top             =   3960
      Width           =   1185
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de recepcion :"
      Height          =   345
      Index           =   0
      Left            =   180
      TabIndex        =   10
      Top             =   195
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Realizo :"
      Height          =   255
      Index           =   11
      Left            =   180
      TabIndex        =   9
      Top             =   3600
      Width           =   690
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de recepcion :"
      Height          =   300
      Index           =   3
      Left            =   3555
      TabIndex        =   8
      Top             =   240
      Width           =   1545
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha realizo :"
      Height          =   255
      Index           =   4
      Left            =   4005
      TabIndex        =   7
      Top             =   3600
      Width           =   1185
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle :"
      Height          =   165
      Index           =   9
      Left            =   225
      TabIndex        =   6
      Top             =   1350
      Width           =   645
   End
End
Attribute VB_Name = "frmDetObrasRecepciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetObraRecepcion
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
                  If Len(Trim(dc.BoundText)) = 0 And dc.Index <> 1 Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
                  If IsNumeric(dc.BoundText) Then
                     .Fields(dc.DataField).Value = dc.BoundText
                  End If
               End If
            Next
            If Option1.Value Then
               .Fields("TipoRecepcion").Value = "Provisoria"
            Else
               .Fields("TipoRecepcion").Value = "Definitiva"
            End If
            .Fields("Detalle").Value = rchObservaciones.Text
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
   Set origen = oObra.DetObrasRecepciones.Item(vNewValue)
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
      Option1.Value = True
      With origen.Registro
         .Fields("IdRealizo").Value = glbIdUsuario
         .Fields("FechaRealizo").Value = Date
      End With
      txtFechaRealizo.Text = Date
   Else
      With origen.Registro
         If IsNull(.Fields("TipoRecepcion").Value) Or _
               .Fields("TipoRecepcion").Value = "Provisoria" Then
            Option1.Value = True
         Else
            Option2.Value = True
         End If
         txtFechaRealizo.Text = .Fields("FechaRealizo").Value
         If Not IsNull(.Fields("FechaAprobo").Value) Then
            txtFechaAprobo.Text = .Fields("FechaAprobo").Value
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Detalle").Value), "", .Fields("Detalle").Value)
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

   If IsNumeric(DataCombo1(Index).BoundText) Then
      If Index = 1 Then
         PideAutorizacion
      End If
   End If

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

Private Sub PideAutorizacion()

   Dim oF As frmAutorizacion1
   Set oF = New frmAutorizacion1
   With oF
      .IdUsuario = DataCombo1(1).BoundText
      .Show vbModal, Me
   End With
   If Not oF.Ok Then
      With origen.Registro
         .Fields(DataCombo1(1).DataField).Value = Null
         .Fields("FechaAprobo").Value = Null
      End With
   Else
      With origen.Registro
         .Fields("FechaAprobo").Value = Date
'         mIdAprobo = IIf(IsNull(.Fields("Aprobo").Value), 0, .Fields("Aprobo").Value)
         txtFechaAprobo.Text = Date
      End With
   End If
   Unload oF
   Set oF = Nothing

End Sub


