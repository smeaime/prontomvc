VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetObrasEquiposInstalados 
   Caption         =   "Item de equipos instalados para la obra"
   ClientHeight    =   2835
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10830
   Icon            =   "frmDetObrasEquiposInstalados.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2835
   ScaleWidth      =   10830
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdMateriales 
      Caption         =   "Ver mas datos"
      Height          =   330
      Left            =   9360
      TabIndex        =   10
      Top             =   945
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.TextBox txtBusca 
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
      Left            =   8325
      TabIndex        =   5
      Top             =   225
      Width           =   2265
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   45
      TabIndex        =   3
      Top             =   2295
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1665
      TabIndex        =   4
      Top             =   2295
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
      Left            =   2025
      TabIndex        =   2
      Top             =   975
      Width           =   1410
   End
   Begin VB.TextBox txtCodigoArticulo 
      Alignment       =   1  'Right Justify
      DataField       =   "CodigoArticulo"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2025
      TabIndex        =   0
      Top             =   180
      Width           =   1545
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   2025
      TabIndex        =   1
      Tag             =   "Articulos"
      Top             =   585
      Width           =   8610
      _ExtentX        =   15187
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaInstalacion"
      Height          =   285
      Index           =   0
      Left            =   2025
      TabIndex        =   11
      Top             =   1395
      Width           =   1440
      _ExtentX        =   2540
      _ExtentY        =   503
      _Version        =   393216
      Format          =   63111169
      CurrentDate     =   36432
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaDesinstalacion"
      Height          =   285
      Index           =   1
      Left            =   2025
      TabIndex        =   12
      Top             =   1800
      Width           =   1440
      _ExtentX        =   2540
      _ExtentY        =   503
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   63111169
      CurrentDate     =   36526
   End
   Begin RichTextLib.RichTextBox RichTextBox1 
      Height          =   1365
      Left            =   3870
      TabIndex        =   15
      Top             =   1350
      Width           =   6765
      _ExtentX        =   11933
      _ExtentY        =   2408
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmDetObrasEquiposInstalados.frx":076A
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Observaciones :"
      Height          =   195
      Index           =   2
      Left            =   3915
      TabIndex        =   16
      Top             =   1170
      Width           =   1185
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Fecha de desinstalacion :"
      Height          =   300
      Index           =   22
      Left            =   90
      TabIndex        =   14
      Top             =   1800
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Fecha de instalacion :"
      Height          =   300
      Index           =   21
      Left            =   90
      TabIndex        =   13
      Top             =   1395
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Buscar :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   14
      Left            =   7380
      TabIndex        =   9
      Top             =   270
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   300
      Index           =   2
      Left            =   90
      TabIndex        =   8
      Top             =   585
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   7
      Left            =   90
      TabIndex        =   7
      Top             =   990
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de articulo :"
      Height          =   300
      Index           =   4
      Left            =   90
      TabIndex        =   6
      Top             =   180
      Width           =   1815
   End
End
Attribute VB_Name = "frmDetObrasEquiposInstalados"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetObraEquipoInstalado
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oObra As ComPronto.Obra
Private mvarIdUnidad As Integer, mvarIdUnidadCU As Integer
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         Dim dtp As DTPicker
         Dim dc As DataCombo
         
         With origen.Registro
            For Each dtp In DTPicker1
               .Fields(dtp.DataField).Value = dtp.Value
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
         
            If IsNull(.Fields("Cantidad").Value) Or _
                  .Fields("Cantidad").Value = 0 Then
               MsgBox "Falta ingresar la cantidad (unidades)", vbCritical
               Exit Sub
            End If
            
            .Fields("Observaciones").Value = RichTextBox1.Text
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
   Dim mIdFiltroDominios As Long
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset

   mIdFiltroDominios = Val(BuscarClaveINI("IdTipo para filtrar equipos instalados"))
   
   Set oAp = Aplicacion
   mvarId = vNewValue
   Set origen = oObra.DetObrasEquiposInstalados.Item(vNewValue)
   Me.IdNuevo = origen.Id
   Set oBind = New BindingCollection
   
   Set oPar = oAp.Parametros.Item(1)
   mvarIdUnidadCU = oPar.Registro.Fields("IdUnidadPorUnidad").Value
   Set oPar = Nothing
   
   mvarIdUnidad = mvarIdUnidadCU
   
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
               If oControl.Tag = "Articulos" Then
                  If mIdFiltroDominios <> 0 Then
                     Set oControl.RowSource = oAp.Articulos.TraerFiltrado("_PorIdTipoParaCombo", mIdFiltroDominios)
                  Else
                     Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
                  End If
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
      With origen.Registro
         .Fields("Cantidad").Value = 1
         .Fields("FechaInstalacion").Value = Date
         DTPicker1(0).Value = Date
      End With
   Else
      With origen.Registro
         RichTextBox1.Text = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
         If IsNull(.Fields("FechaInstalacion").Value) Then
            .Fields("FechaInstalacion").Value = Date
            DTPicker1(0).Value = Date
         End If
      End With
   End If
   
   If BuscarClaveINI("Obras_AccesoAMateriales") = "SI" Then
      cmdMateriales.Visible = True
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
End Property

Public Property Get Obra() As ComPronto.Obra

   Set Obra = oObra

End Property

Public Property Set Obra(ByVal vNewValue As ComPronto.Obra)

   Set oObra = vNewValue

End Property

Private Sub cmdMateriales_Click()

   Dim mIdArticulo As Long
   If IsNumeric(DataCombo1(1).BoundText) Then
      mIdArticulo = DataCombo1(1).BoundText
   Else
      mIdArticulo = -1
   End If
   Dim oF As frmArticulos
   Set oF = New frmArticulos
   With oF
      .NivelAcceso = EnumAccesos.Alto
      .Id = mIdArticulo
      .Show vbModal, Me
      If .Id > 0 And mIdArticulo = -1 Then
         Set DataCombo1(1).RowSource = Aplicacion.Articulos.TraerLista
         origen.Registro.Fields("IdArticulo").Value = .Id
      End If
   End With
   Unload oF
   Set oF = Nothing

End Sub

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) And _
         DataCombo1(Index).BoundText <> DataCombo1(Index).Text Then
         
      Select Case Index
         
         Case 1
      
            Dim oRs As ADOR.Recordset
            
            If IsNull(origen.Registro.Fields("FechaDesinstalacion").Value) Then
               Set oRs = Aplicacion.Obras.TraerFiltrado("_ControlEquipoEnDominio", Array(Obra.Registro.Fields(0).Value, DataCombo1(Index).BoundText))
               If oRs.RecordCount > 0 Then
                  MsgBox "El equipo ya esta en la obra " & oRs.Fields("Descripcion").Value, vbExclamation
                  origen.Registro.Fields("IdArticulo").Value = Null
                  oRs.Close
                  Set oRs = Nothing
                  Exit Sub
               End If
               oRs.Close
            End If
            
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(1).BoundText)
            If oRs.RecordCount > 0 Then
               txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
            End If
            oRs.Close
            Set oRs = Nothing
            
      End Select
      
   End If
      
End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

'   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

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

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub txtBusca_GotFocus()

   With txtBusca
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBusca_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      If KeyAscii = 13 Then
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set DataCombo1(1).RowSource = Aplicacion.Articulos.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set DataCombo1(1).RowSource = Aplicacion.Articulos.TraerLista
         End If
      End If
      DataCombo1(1).SetFocus
      SendKeys "%{DOWN}"
   End If

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

Private Sub txtCodigoArticulo_GotFocus()

   With txtCodigoArticulo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoArticulo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoArticulo_Validate(Cancel As Boolean)

   If Len(txtCodigoArticulo.Text) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo.Text)
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdArticulo").Value = oRs.Fields(0).Value
      Else
         MsgBox "Codigo de material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo.Text = ""
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

