VERSION 5.00
Begin VB.Form frmPedidosOtrosConceptos 
   Caption         =   "Pedidos : Otros conceptos"
   ClientHeight    =   2655
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4935
   LinkTopic       =   "Form1"
   ScaleHeight     =   2655
   ScaleWidth      =   4935
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtDetalle 
      Appearance      =   0  'Flat
      BackColor       =   &H80000004&
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
      Index           =   4
      Left            =   225
      Locked          =   -1  'True
      TabIndex        =   13
      Top             =   1755
      Width           =   3375
   End
   Begin VB.TextBox txtDetalle 
      Appearance      =   0  'Flat
      BackColor       =   &H80000004&
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
      Index           =   3
      Left            =   225
      Locked          =   -1  'True
      TabIndex        =   12
      Top             =   1395
      Width           =   3375
   End
   Begin VB.TextBox txtDetalle 
      Appearance      =   0  'Flat
      BackColor       =   &H80000004&
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
      Index           =   2
      Left            =   225
      Locked          =   -1  'True
      TabIndex        =   11
      Top             =   1035
      Width           =   3375
   End
   Begin VB.TextBox txtDetalle 
      Appearance      =   0  'Flat
      BackColor       =   &H80000004&
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
      Index           =   1
      Left            =   225
      Locked          =   -1  'True
      TabIndex        =   10
      Top             =   675
      Width           =   3375
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   375
      Index           =   0
      Left            =   225
      TabIndex        =   5
      Top             =   2205
      Width           =   840
   End
   Begin VB.TextBox txtDetalle 
      Appearance      =   0  'Flat
      BackColor       =   &H80000004&
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
      Index           =   0
      Left            =   225
      Locked          =   -1  'True
      TabIndex        =   8
      Top             =   315
      Width           =   3375
   End
   Begin VB.TextBox txtImporteOtros 
      Alignment       =   1  'Right Justify
      DataField       =   "OtrosConceptos1"
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
      Index           =   0
      Left            =   3735
      TabIndex        =   0
      Top             =   315
      Width           =   990
   End
   Begin VB.TextBox txtImporteOtros 
      Alignment       =   1  'Right Justify
      DataField       =   "OtrosConceptos5"
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
      Index           =   4
      Left            =   3735
      TabIndex        =   4
      Top             =   1755
      Width           =   990
   End
   Begin VB.TextBox txtImporteOtros 
      Alignment       =   1  'Right Justify
      DataField       =   "OtrosConceptos4"
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
      Index           =   3
      Left            =   3735
      TabIndex        =   3
      Top             =   1395
      Width           =   990
   End
   Begin VB.TextBox txtImporteOtros 
      Alignment       =   1  'Right Justify
      DataField       =   "OtrosConceptos3"
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
      Index           =   2
      Left            =   3735
      TabIndex        =   2
      Top             =   1035
      Width           =   990
   End
   Begin VB.TextBox txtImporteOtros 
      Alignment       =   1  'Right Justify
      DataField       =   "OtrosConceptos2"
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
      Index           =   1
      Left            =   3735
      TabIndex        =   1
      Top             =   675
      Width           =   990
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
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
      Left            =   3735
      Locked          =   -1  'True
      TabIndex        =   6
      Top             =   2115
      Width           =   960
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Conceptos :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   1
      Left            =   225
      TabIndex        =   9
      Top             =   90
      Width           =   1035
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Importe :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   0
      Left            =   3735
      TabIndex        =   7
      Top             =   90
      Width           =   765
   End
End
Attribute VB_Name = "frmPedidosOtrosConceptos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim mPedido As ComPronto.Pedido
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
      
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim i As Integer
         Dim mAux1 As String
         
         With mPedido.Registro
            For i = 1 To 5
               If IsNull(.Fields("OtrosConceptos" & i).Value) Then
                  .Fields("OtrosConceptos" & i).Value = 0
               End If
            Next
         End With
      
         Unload Me
   
      Case 1
      
         Unload Me
   
   End Select

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim i As Integer
   
   mvarId = vnewvalue
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = mPedido
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = mPedido
            If Len(oControl.Tag) Then
               Set oControl.RowSource = Aplicacion.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = mPedido
         End If
      Next
   End With
   
   For i = 1 To 5
      txtDetalle(i - 1).Text = TraerValorParametro2("Pedidos_DescripcionOtrosConceptos" & i)
   Next
   
End Property

Public Property Set Pedido(ByRef vnewvalue As ComPronto.Pedido)

   Set mPedido = vnewvalue

End Property

Private Sub Form_Load()

   ReemplazarEtiquetas Me

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   Set oBind = Nothing

End Sub

Private Sub txtImporteOtros_Change(Index As Integer)

   CalcularTotal

End Sub

Private Sub txtImporteOtros_GotFocus(Index As Integer)

   With txtImporteOtros(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImporteOtros_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Sub CalcularTotal()

   Dim i As Integer
   Dim mvarTotalOtrosConceptos As Double
   
   mvarTotalOtrosConceptos = 0
   With mPedido.Registro
      For i = 1 To 5
         mvarTotalOtrosConceptos = mvarTotalOtrosConceptos + Val(txtImporteOtros(i - 1).Text)
      Next
   End With
   txtTotal.Text = Format(mvarTotalOtrosConceptos, "#,##0.00")

End Sub
