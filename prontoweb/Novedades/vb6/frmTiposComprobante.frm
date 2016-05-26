VERSION 5.00
Begin VB.Form frmTiposComprobante 
   Caption         =   "Tipos de comprobante"
   ClientHeight    =   4260
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7035
   Icon            =   "frmTiposComprobante.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4260
   ScaleWidth      =   7035
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtNumeradorAuxiliar 
      Alignment       =   2  'Center
      DataField       =   "NumeradorAuxiliar"
      Height          =   285
      Left            =   5670
      TabIndex        =   1
      Top             =   1710
      Width           =   990
   End
   Begin VB.TextBox txtCodigoDgi 
      Alignment       =   2  'Center
      DataField       =   "CodigoDgi"
      Height          =   285
      Left            =   5670
      TabIndex        =   0
      Top             =   1350
      Width           =   990
   End
   Begin VB.Frame Frame4 
      Height          =   420
      Left            =   2475
      TabIndex        =   23
      Top             =   2835
      Width           =   1410
      Begin VB.OptionButton Option7 
         Caption         =   "SI"
         Height          =   195
         Left            =   90
         TabIndex        =   25
         Top             =   135
         Width           =   510
      End
      Begin VB.OptionButton Option8 
         Caption         =   "NO"
         Height          =   195
         Left            =   765
         TabIndex        =   24
         Top             =   135
         Width           =   555
      End
   End
   Begin VB.Frame Frame3 
      Height          =   420
      Left            =   2475
      TabIndex        =   19
      Top             =   2340
      Width           =   1410
      Begin VB.OptionButton Option6 
         Caption         =   "NO"
         Height          =   195
         Left            =   765
         TabIndex        =   21
         Top             =   135
         Width           =   555
      End
      Begin VB.OptionButton Option5 
         Caption         =   "SI"
         Height          =   195
         Left            =   90
         TabIndex        =   20
         Top             =   135
         Width           =   510
      End
   End
   Begin VB.Frame Frame2 
      Height          =   420
      Left            =   2475
      TabIndex        =   15
      Top             =   1845
      Width           =   1410
      Begin VB.OptionButton Option3 
         Caption         =   "SI"
         Height          =   195
         Left            =   90
         TabIndex        =   17
         Top             =   135
         Width           =   510
      End
      Begin VB.OptionButton Option4 
         Caption         =   "NO"
         Height          =   195
         Left            =   765
         TabIndex        =   16
         Top             =   135
         Width           =   555
      End
   End
   Begin VB.Frame Frame1 
      Height          =   420
      Left            =   2475
      TabIndex        =   11
      Top             =   1350
      Width           =   1410
      Begin VB.OptionButton Option2 
         Caption         =   "NO"
         Height          =   195
         Left            =   765
         TabIndex        =   13
         Top             =   135
         Width           =   555
      End
      Begin VB.OptionButton Option1 
         Caption         =   "SI"
         Height          =   195
         Left            =   90
         TabIndex        =   12
         Top             =   135
         Width           =   510
      End
   End
   Begin VB.TextBox txtCoeficiente 
      DataField       =   "Coeficiente"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   2490
      TabIndex        =   7
      Top             =   945
      Width           =   450
   End
   Begin VB.TextBox txtAbreviatura 
      DataField       =   "DescripcionAB"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   2490
      TabIndex        =   6
      Top             =   540
      Width           =   990
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   2490
      TabIndex        =   5
      Top             =   150
      Width           =   4185
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   5490
      TabIndex        =   3
      Top             =   3735
      Visible         =   0   'False
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   3780
      TabIndex        =   4
      Top             =   3735
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1800
      TabIndex        =   2
      Top             =   3735
      Width           =   1485
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Numerador auxiliar :"
      Height          =   255
      Index           =   8
      Left            =   4050
      TabIndex        =   28
      Top             =   1770
      Width           =   1455
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo DGI :"
      Height          =   255
      Index           =   7
      Left            =   4050
      TabIndex        =   27
      Top             =   1410
      Width           =   1455
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Exigir CAI :"
      Height          =   255
      Index           =   6
      Left            =   405
      TabIndex        =   26
      Top             =   2970
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Va al reg, compras (1361)"
      Height          =   255
      Index           =   5
      Left            =   405
      TabIndex        =   22
      Top             =   2475
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Va al CITI :"
      Height          =   255
      Index           =   4
      Left            =   405
      TabIndex        =   18
      Top             =   1935
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Va al libro IVA Compras :"
      Height          =   255
      Index           =   0
      Left            =   405
      TabIndex        =   14
      Top             =   1440
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Coeficiente :"
      Height          =   255
      Index           =   3
      Left            =   405
      TabIndex        =   10
      Top             =   960
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Abreviatura :"
      Height          =   255
      Index           =   2
      Left            =   405
      TabIndex        =   9
      Top             =   555
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripcion :"
      Height          =   255
      Index           =   1
      Left            =   405
      TabIndex        =   8
      Top             =   165
      Width           =   1815
   End
End
Attribute VB_Name = "frmTiposComprobante"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.TipoComprobante
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
   
         Dim est As EnumAcciones
         Dim dc As DataCombo
         
         With origen.Registro
            If Option1.Value Then
               .Fields("VaAlLibro").Value = "SI"
            Else
               .Fields("VaAlLibro").Value = "NO"
            End If
            If Option3.Value Then
               .Fields("VaAlCiti").Value = "SI"
            Else
               .Fields("VaAlCiti").Value = "NO"
            End If
            If Option5.Value Then
               .Fields("VaAlRegistroComprasAFIP").Value = "SI"
            Else
               .Fields("VaAlRegistroComprasAFIP").Value = "NO"
            End If
            If Option7.Value Then
               .Fields("ExigirCAI").Value = "SI"
            Else
               .Fields("ExigirCAI").Value = "NO"
            End If
         End With
         
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
            .ListaEditada = "TiposComprobante"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
      Case 1
   
         origen.Eliminar
         
         est = baja
            
         With actL2
            .ListaEditada = "TiposComprobante"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
   End Select
   
   Unload Me

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oAp.TiposComprobante.Item(vnewvalue)
   
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
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   If mvarId = -1 Then
      With origen.Registro
         
      End With
      Option2.Value = True
      Option4.Value = True
      Option6.Value = True
      Option8.Value = True
   Else
      With origen.Registro
         If Not IsNull(.Fields("VaAlLibro").Value) And _
               .Fields("VaAlLibro").Value = "SI" Then
            Option1.Value = True
         Else
            Option2.Value = True
         End If
         If Not IsNull(.Fields("VaAlCiti").Value) And _
               .Fields("VaAlCiti").Value = "SI" Then
            Option3.Value = True
         Else
            Option4.Value = True
         End If
         If Not IsNull(.Fields("VaAlRegistroComprasAFIP").Value) And _
               .Fields("VaAlRegistroComprasAFIP").Value = "SI" Then
            Option5.Value = True
         Else
            Option6.Value = True
         End If
         If Not IsNull(.Fields("ExigirCAI").Value) And _
               .Fields("ExigirCAI").Value = "SI" Then
            Option7.Value = True
         Else
            Option8.Value = True
         End If
      End With
   End If
   
   cmd(1).Enabled = False
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      If mvarId > 0 Then cmd(1).Enabled = True
   End If
   
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

Private Sub txtCodigoDgi_GotFocus()

   With txtCodigoDgi
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoDgi_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCodigoDgi
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtNumeradorAuxiliar_GotFocus()

   With txtNumeradorAuxiliar
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeradorAuxiliar_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
