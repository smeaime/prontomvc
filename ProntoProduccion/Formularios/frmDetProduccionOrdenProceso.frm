VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{BE38695A-739A-4A6C-BF54-931FC1415984}#1.0#0"; "VividThumbNails.ocx"
Begin VB.Form frmDetProduccionOrdenProceso 
   Caption         =   "Item de proceso de orden de producción"
   ClientHeight    =   2565
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6420
   Icon            =   "frmDetProduccionOrdenProceso.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   2565
   ScaleWidth      =   6420
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtCantidad 
      Alignment       =   1  'Right Justify
      DataField       =   "Horas"
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
      Left            =   1440
      TabIndex        =   7
      Tag             =   "Horas"
      Top             =   480
      Width           =   870
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   3120
      TabIndex        =   2
      Top             =   2040
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   405
      Index           =   1
      Left            =   4800
      TabIndex        =   3
      Top             =   2040
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProduccionProceso"
      Height          =   315
      Index           =   1
      Left            =   1440
      TabIndex        =   0
      Tag             =   "ProduccionProcesos"
      Top             =   120
      Width           =   4890
      _ExtentX        =   8625
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProduccionProceso"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      DataField       =   "Observaciones"
      Height          =   690
      Left            =   1440
      TabIndex        =   1
      Top             =   1200
      Width           =   4890
      _ExtentX        =   8625
      _ExtentY        =   1217
      _Version        =   393217
      BorderStyle     =   0
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmDetProduccionOrdenProceso.frx":076A
   End
   Begin VividThumbNails.VividThumbs VividThumbs1 
      Height          =   4785
      Left            =   10845
      TabIndex        =   8
      Top             =   270
      Width           =   1995
      _ExtentX        =   3519
      _ExtentY        =   8440
      tWidth          =   40
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdMaquina"
      Height          =   315
      Index           =   0
      Left            =   1440
      TabIndex        =   10
      Tag             =   "Articulos"
      Top             =   840
      Width           =   3450
      _ExtentX        =   6085
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Maquina:"
      Height          =   225
      Index           =   0
      Left            =   120
      TabIndex        =   9
      Top             =   960
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   225
      Index           =   5
      Left            =   120
      TabIndex        =   6
      Top             =   1560
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Proceso"
      Height          =   225
      Index           =   2
      Left            =   120
      TabIndex        =   5
      Top             =   240
      Width           =   960
   End
   Begin VB.Label lblLabels 
      Caption         =   "Horas:"
      Height          =   225
      Index           =   7
      Left            =   120
      TabIndex        =   4
      Tag             =   "Horas"
      Top             =   600
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetProduccionOrdenProceso"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public WithEvents origen As ComPronto.DetProdOrdenProceso
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oProduccionOrden As ComPronto.ProduccionOrden
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long, mObra As Long
Private mvarIdUnidad As Long

Public Property Get ProduccionOrden() As ComPronto.ProduccionOrden

   Set ProduccionOrden = oProduccionOrden

End Property

Public Property Set ProduccionOrden(ByVal vNewValue As ComPronto.ProduccionOrden)

   Set oProduccionOrden = vNewValue

End Property



Friend Sub cmd_Click(Index As Integer)

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
      
         'If Len(txtEquivalencia.Text) = 0 Or Val(txtEquivalencia.Text) = 0 Then
         '   MsgBox "Falta ingresar la equivalencia", vbCritical
         '   Exit Sub
         'End If
         
         With origen.Registro
            origen.Registro.Fields("Observaciones").Value = rchObservaciones.Text
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

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim dtp As DTPicker
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset

   Set oAp = Aplicacion
   
   mvarId = vNewValue
   Set origen = oProduccionOrden.DetProduccionOrdenesProcesos.Item(vNewValue)
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
            
            If oControl.Tag = "ProduccionProcesos" Then
                Set oControl.RowSource = oAp.TablasGenerales.TraerLista("ProduccionProcesos")
            ElseIf oControl.Tag = "Articulos" Then
                Set oControl.RowSource = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorDescripcionTipoParaCombo", Array(0, "Equipo"))
            Else
                Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   End With
   
   Set oRs = oAp.Unidades.TraerFiltrado("_PorId", Me.IdUnidad)
   'If oRs.RecordCount > 0 Then
   '   lblUnidad.Caption = "Unidad standar : " & oRs.Fields("Descripcion").Value
   'End If
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


Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   ReemplazarEtiquetas Me

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   ''Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oBind = Nothing
   Set origen = Nothing
   Set oProduccionOrden = Nothing

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Public Property Get IdUnidad() As Long

   IdUnidad = mvarIdUnidad

End Property

Public Property Let IdUnidad(ByVal vNewValue As Long)

   mvarIdUnidad = vNewValue

End Property


Private Sub txtEquivalencia_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

