VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "msdatlst.ocx"
Object = "{BE38695A-739A-4A6C-BF54-931FC1415984}#1.0#0"; "VividThumbNails.ocx"
Begin VB.Form frmDetProduccionFichaProceso 
   Caption         =   "Item de proceso de Ficha de producción"
   ClientHeight    =   2205
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5280
   Icon            =   "frmDetProduccionFichaProceso.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   2205
   ScaleWidth      =   5280
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
      Top             =   480
      Width           =   870
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   2085
      TabIndex        =   2
      Top             =   1665
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   405
      Index           =   1
      Left            =   3660
      TabIndex        =   3
      Top             =   1665
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
      Width           =   3690
      _ExtentX        =   6509
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
      Top             =   840
      Width           =   3690
      _ExtentX        =   6509
      _ExtentY        =   1217
      _Version        =   393217
      BorderStyle     =   0
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmDetProduccionFichaProceso.frx":076A
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
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   5
      Left            =   135
      TabIndex        =   6
      Top             =   840
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Proceso"
      Height          =   300
      Index           =   2
      Left            =   120
      TabIndex        =   5
      Top             =   120
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Horas:"
      Height          =   300
      Index           =   7
      Left            =   135
      TabIndex        =   4
      Top             =   480
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetProduccionFichaProceso"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetProdFichaProceso
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oProduccionFicha As ComPronto.ProduccionFicha
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mClave As Long, mObra As Long
Private mvarIdUnidad As Long

Public Property Get ProduccionFicha() As ComPronto.ProduccionFicha

   Set ProduccionFicha = oProduccionFicha

End Property

Public Property Set ProduccionFicha(ByVal vnewvalue As ComPronto.ProduccionFicha)

   Set oProduccionFicha = vnewvalue

End Property



Friend Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim dc As DataCombo
         
         
        If Not IsNumeric(txtCantidad) Then
           MsgBox "Falta completar la cantidad de horas", vbCritical
           Exit Sub
        End If
    
     
         
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

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim dtp As DTPicker
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset

   Set oAp = Aplicacion
   
   mvarId = vnewvalue
   Set origen = oProduccionFicha.DetProduccionFichasProcesos.Item(vnewvalue)
   Me.IdNuevo = origen.Id
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            
            If oControl.Tag <> "ProduccionProcesos" Then
                Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            Else
                Set oControl.RowSource = oAp.TablasGenerales.TraerLista("ProduccionProcesos")
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
   Set oProduccionFicha = Nothing

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vnewvalue As Variant)

   mvarIdNuevo = vnewvalue

End Property

Public Property Get IdUnidad() As Long

   IdUnidad = mvarIdUnidad

End Property

Public Property Let IdUnidad(ByVal vnewvalue As Long)

   mvarIdUnidad = vnewvalue

End Property


Private Sub txtEquivalencia_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

