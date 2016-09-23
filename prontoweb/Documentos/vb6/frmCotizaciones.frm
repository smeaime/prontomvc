VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmCotizaciones 
   Caption         =   "Cotizaciones"
   ClientHeight    =   2715
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5415
   Icon            =   "frmCotizaciones.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2715
   ScaleWidth      =   5415
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtCotizacionLibre 
      Alignment       =   1  'Right Justify
      DataField       =   "CotizacionLibre"
      Height          =   330
      Left            =   2070
      TabIndex        =   1
      Top             =   1440
      Width           =   1260
   End
   Begin VB.TextBox txtCotizacion 
      Alignment       =   1  'Right Justify
      DataField       =   "Cotizacion"
      Height          =   330
      Left            =   2070
      TabIndex        =   0
      Top             =   1035
      Width           =   1260
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   2970
      TabIndex        =   3
      Top             =   2160
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   990
      TabIndex        =   2
      Top             =   2160
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   0
      Left            =   2070
      TabIndex        =   5
      Tag             =   "Monedas"
      Top             =   645
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   330
      Index           =   0
      Left            =   2070
      TabIndex        =   4
      Top             =   225
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   582
      _Version        =   393216
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   64487425
      CurrentDate     =   36377
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cotizacion libre :"
      Height          =   300
      Index           =   0
      Left            =   90
      TabIndex        =   9
      Top             =   1440
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de creacion :"
      Height          =   300
      Index           =   4
      Left            =   90
      TabIndex        =   8
      Top             =   225
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cotizacion aduana :"
      Height          =   300
      Index           =   1
      Left            =   90
      TabIndex        =   7
      Top             =   1035
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Moneda :"
      Height          =   300
      Index           =   3
      Left            =   90
      TabIndex        =   6
      Top             =   615
      Width           =   1815
   End
End
Attribute VB_Name = "frmCotizaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Cotizacion
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long
Dim actL2 As ControlForm
Private mNivelAcceso As Integer, mOpcionesAcceso As String

Public Property Let NivelAcceso(ByVal mNivelA As EnumAccesos)
   
   mNivelAcceso = mNivelA
   
End Property

Public Property Get NivelAcceso() As EnumAccesos

   NivelAcceso = mNivelAcceso
   
End Property

Public Property Let OpcionesAcceso(ByVal mOpcionesA As String)
   
   mOpcionesAcceso = mOpcionesA
   
End Property

Public Property Get OpcionesAcceso() As String

   OpcionesAcceso = mOpcionesAcceso
   
End Property

Private Sub cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
   
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim oRs As ADOR.Recordset
      
         If Len(Trim(txtCotizacionLibre.Text)) = 0 Then
            MsgBox "Falta completar el campo cotizacion libre", vbCritical
            Exit Sub
         End If
         
         For Each dtp In DTFields
            origen.Registro.Fields(dtp.DataField).Value = dtp.Value
         Next
         
         For Each dc In DataCombo1
            If Len(Trim(dc.BoundText)) = 0 Then
               MsgBox "Falta completar el campo " & dc.Tag, vbCritical
               Exit Sub
            End If
            origen.Registro.Fields(dc.DataField).Value = dc.BoundText
         Next
         
         Set oRs = Aplicacion.Cotizaciones.TraerFiltrado("_PorFechaMoneda", Array(DTFields(0).Value, DataCombo1(0).BoundText))
         If oRs.RecordCount > 0 Then
            If mvarId < 0 Or mvarId <> oRs.Fields(0).Value Then
               MsgBox "Ya existe una cotizacion en esta fecha y con esta moneda", vbExclamation
               oRs.Close
               Set oRs = Nothing
               Exit Sub
            End If
         End If
         oRs.Close
         Set oRs = Nothing
         
         Select Case origen.Guardar
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "+SubCo2"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
   End Select
   
   Unload Me

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oAp.Cotizaciones.Item(vnewvalue)
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
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
      Set oRs = oAp.Parametros.Item(1).Registro
      With origen.Registro
         .Fields("Fecha").Value = Date
         DTFields(0).Value = Date
         If Not IsNull(oRs.Fields("IdMonedaDolar").Value) Then
            .Fields("IdMoneda").Value = oRs.Fields("IdMonedaDolar").Value
         End If
      End With
      oRs.Close
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub txtCotizacion_GotFocus()

   With txtCotizacion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCotizacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCotizacionLibre_GotFocus()

   With txtCotizacionLibre
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCotizacionLibre_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
