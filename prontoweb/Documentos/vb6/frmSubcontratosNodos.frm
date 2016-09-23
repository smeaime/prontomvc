VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmSubcontratosNodos 
   Caption         =   "Item de subcontrato"
   ClientHeight    =   3555
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8910
   LinkTopic       =   "Form1"
   ScaleHeight     =   3555
   ScaleWidth      =   8910
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtItem 
      Alignment       =   2  'Center
      DataField       =   "Item"
      Height          =   330
      Left            =   1575
      TabIndex        =   21
      Top             =   2520
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000000&
      Height          =   285
      Index           =   3
      Left            =   225
      Locked          =   -1  'True
      TabIndex        =   20
      Text            =   "Descripcion :"
      Top             =   495
      Width           =   1275
   End
   Begin VB.TextBox txtDescripcionSubcontrato 
      Appearance      =   0  'Flat
      BackColor       =   &H80000000&
      Height          =   285
      Left            =   1575
      TabIndex        =   19
      Top             =   495
      Width           =   6180
   End
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000000&
      Height          =   285
      Index           =   2
      Left            =   225
      Locked          =   -1  'True
      TabIndex        =   18
      Text            =   "Periodo :"
      Top             =   1215
      Width           =   1275
   End
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000000&
      Height          =   285
      Index           =   0
      Left            =   225
      Locked          =   -1  'True
      TabIndex        =   17
      Text            =   "Proveedor : "
      Top             =   855
      Width           =   1275
   End
   Begin VB.TextBox txtFechas 
      Appearance      =   0  'Flat
      BackColor       =   &H80000000&
      Height          =   285
      Left            =   1575
      Locked          =   -1  'True
      TabIndex        =   16
      Top             =   1215
      Width           =   3525
   End
   Begin VB.TextBox txtNumeroSubcontrato 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000000&
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
      Left            =   1575
      TabIndex        =   15
      Top             =   135
      Width           =   915
   End
   Begin VB.TextBox txtProveedor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000000&
      Height          =   285
      Left            =   1575
      TabIndex        =   14
      Top             =   855
      Width           =   6180
   End
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000000&
      Height          =   285
      Index           =   1
      Left            =   225
      Locked          =   -1  'True
      TabIndex        =   13
      Text            =   "Subcontrato nro. :"
      Top             =   135
      Width           =   1275
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   330
      Left            =   1575
      TabIndex        =   9
      Top             =   1665
      Width           =   7170
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   375
      Index           =   0
      Left            =   180
      TabIndex        =   8
      Top             =   3105
      Width           =   1140
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   375
      Index           =   1
      Left            =   1575
      TabIndex        =   7
      Top             =   3105
      Width           =   1140
   End
   Begin VB.Frame Frame1 
      Caption         =   "Tipo de partida : "
      Height          =   1320
      Left            =   6615
      TabIndex        =   3
      Top             =   2070
      Width           =   2130
      Begin VB.OptionButton Option1 
         Caption         =   "Partida contractual"
         Height          =   285
         Index           =   0
         Left            =   180
         TabIndex        =   6
         Top             =   270
         Width           =   1815
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Partida adicional"
         Height          =   285
         Index           =   1
         Left            =   180
         TabIndex        =   5
         Top             =   607
         Width           =   1815
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Ampliacion de obra"
         Height          =   285
         Index           =   2
         Left            =   180
         TabIndex        =   4
         Top             =   945
         Width           =   1815
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Forma de medir avance :"
      Height          =   915
      Left            =   4320
      TabIndex        =   0
      Top             =   2070
      Width           =   2130
      Begin VB.OptionButton Option2 
         Caption         =   "Por porcentaje"
         Height          =   285
         Index           =   1
         Left            =   180
         TabIndex        =   2
         Top             =   607
         Width           =   1815
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Por unidad del item"
         Height          =   285
         Index           =   0
         Left            =   180
         TabIndex        =   1
         Top             =   270
         Width           =   1815
      End
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   0
      Left            =   1575
      TabIndex        =   10
      Tag             =   "Unidades"
      Top             =   2115
      Width           =   2085
      _ExtentX        =   3678
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin VB.Label Label1 
      Caption         =   "Nro.Item :"
      Height          =   240
      Index           =   3
      Left            =   225
      TabIndex        =   22
      Top             =   2565
      Width           =   1275
   End
   Begin VB.Label Label1 
      Caption         =   "Etapa :"
      Height          =   240
      Index           =   4
      Left            =   225
      TabIndex        =   12
      Top             =   1710
      Width           =   1275
   End
   Begin VB.Label Label1 
      Caption         =   "Unidad :"
      Height          =   240
      Index           =   0
      Left            =   225
      TabIndex        =   11
      Top             =   2160
      Width           =   1275
   End
End
Attribute VB_Name = "frmSubcontratosNodos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const TIPO_OBRA = 1
Const TIPO_ETAPA = 3
Const TIPO_ARTICULO = 4
Const TIPO_RUBRO = 5

Dim WithEvents origen As ComPronto.Subcontrato
Attribute origen.VB_VarHelpID = -1

Private mvarIdSubcontrato As Long, mvarNumeroSubcontrato As Long
Public NodoPadre As Long, Tipo As Long, CodigoPresupuesto As Long
Public Aceptado As Boolean

Private Sub cmd_Click(Index As Integer)

   Dim oRs As ADOR.Recordset
   Dim mAux1 As Variant
   
   Select Case Index
      Case 0
         If Len(txtDescripcion.Text) = 0 Then
            MsgBox "Debe ingresar una etapa", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe ingresar una unidad", vbExclamation
            Exit Sub
         End If
         
         Set origen = Aplicacion.Subcontratos.Item(Me.IdSubcontrato)
         With origen.Registro
            If NodoPadre = 0 Then
                .Fields("IdNodoPadre").Value = Null
            Else
                .Fields("IdNodoPadre").Value = NodoPadre
            End If
            Select Case Tipo
                Case TIPO_ETAPA
                    .Fields("Descripcion").Value = txtDescripcion.Text
                Case TIPO_ARTICULO
                    '.Fields("IdArticulo").Value = DataCombo1(3).BoundText
                Case TIPO_RUBRO
                    '.Fields("IdRubro").Value = DataCombo1(3).BoundText
            End Select
            If mvarIdSubcontrato = -1 Then .Fields("TipoNodo").Value = Tipo
            .Fields("IdUnidad").Value = DataCombo1(0).BoundText
            If Option1(0).Value Then
               .Fields("TipoPartida").Value = 1
            ElseIf Option1(1).Value Then
               .Fields("TipoPartida").Value = 2
            ElseIf Option1(2).Value Then
               .Fields("TipoPartida").Value = 3
            Else
               MsgBox "Falta definir el tipo de partida", vbExclamation
               Exit Sub
            End If
            If Option2(0).Value Then
               .Fields("UnidadAvance").Value = "U"
            ElseIf Option2(1).Value Then
               .Fields("UnidadAvance").Value = "%"
            Else
               MsgBox "Falta definir la forma de medir el avance", vbExclamation
               Exit Sub
            End If
         
            If Me.NumeroSubcontrato < 0 Then
               mAux1 = TraerValorParametro2("ProximoNumeroSubcontrato")
               txtNumeroSubcontrato.Text = IIf(IsNull(mAux1), 1, mAux1)
               .Fields("NumeroSubcontrato").Value = txtNumeroSubcontrato.Text
               GuardarValorParametro2 "ProximoNumeroSubcontrato", "" & txtNumeroSubcontrato.Text + 1
            Else
               .Fields("NumeroSubcontrato").Value = Val(txtNumeroSubcontrato.Text)
            End If
            .Fields("Item").Value = txtItem.Text
         End With
         origen.Guardar
         
         Me.NumeroSubcontrato = Val(txtNumeroSubcontrato.Text)
         
         Aceptado = True
      
      Case 1
         Aceptado = False
      
   End Select
   
   Me.Hide
   
   Set oRs = Nothing

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   Dim oRs As ADOR.Recordset
   Dim mAux1 As Variant
   
   Set DataCombo1(0).RowSource = Aplicacion.Unidades.TraerLista
   txtNumeroSubcontrato.Text = Me.NumeroSubcontrato
   MostrarDatosDelSubcontrato Me.NumeroSubcontrato
   
   If Me.IdSubcontrato > 0 Then
      Set oRs = Aplicacion.TablasGenerales.TraerUno("Subcontratos", Me.IdSubcontrato)
      If oRs.RecordCount > 0 Then
         txtDescripcion.Text = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
         Tipo = IIf(IsNull(oRs.Fields("TipoNodo").Value), 0, oRs.Fields("TipoNodo").Value)
         DataCombo1(0).BoundText = IIf(IsNull(oRs.Fields("IdUnidad").Value), 0, oRs.Fields("IdUnidad").Value)
         If IIf(IsNull(oRs.Fields("TipoPartida").Value), 0, oRs.Fields("TipoPartida").Value) = 1 Then
            Option1(0).Value = True
         ElseIf IIf(IsNull(oRs.Fields("TipoPartida").Value), 0, oRs.Fields("TipoPartida").Value) = 2 Then
            Option1(1).Value = True
         ElseIf IIf(IsNull(oRs.Fields("TipoPartida").Value), 0, oRs.Fields("TipoPartida").Value) = 3 Then
            Option1(2).Value = True
         End If
         If IIf(IsNull(oRs.Fields("UnidadAvance").Value), "", oRs.Fields("UnidadAvance").Value) = "U" Then
            Option2(0).Value = True
         ElseIf IIf(IsNull(oRs.Fields("UnidadAvance").Value), 0, oRs.Fields("UnidadAvance").Value) = "%" Then
            Option2(1).Value = True
         End If
         txtItem.Text = IIf(IsNull(oRs.Fields("Item").Value), "", oRs.Fields("Item").Value)
      End If
      oRs.Close
      Set oRs = Nothing
   End If

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Property Get NumeroSubcontrato() As Long

   NumeroSubcontrato = mvarNumeroSubcontrato

End Property

Public Property Let NumeroSubcontrato(ByVal vNewValue As Long)

   mvarNumeroSubcontrato = vNewValue

End Property

Public Property Get IdSubcontrato() As Long

   IdSubcontrato = mvarIdSubcontrato

End Property

Public Property Let IdSubcontrato(ByVal vNewValue As Long)

   mvarIdSubcontrato = vNewValue

End Property

Private Sub txtDescripcion_GotFocus()

   With txtDescripcion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDescripcion
         If Len(Trim(.Text)) >= 50 And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Public Sub MostrarDatosDelSubcontrato(NumeroSubcontrato As Long)

   Dim oRs As ADOR.Recordset
   
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("SubcontratosDatos", "_PorNumeroSubcontrato", NumeroSubcontrato)
   If oRs.RecordCount > 0 Then
      txtDescripcionSubcontrato.Text = IIf(IsNull(oRs.Fields("DescripcionSubcontrato").Value), "", oRs.Fields("DescripcionSubcontrato").Value)
      txtProveedor.Text = IIf(IsNull(oRs.Fields("Proveedor").Value), "", oRs.Fields("Proveedor").Value)
      txtFechas.Text = "" & IIf(IsNull(oRs.Fields("FechaInicio").Value), "", oRs.Fields("FechaInicio").Value) & _
                        " al " & IIf(IsNull(oRs.Fields("FechaFinalizacion").Value), "", oRs.Fields("FechaFinalizacion").Value)
   End If
   oRs.Close

   Set oRs = Nothing

End Sub

Private Sub txtItem_GotFocus()

   With txtItem
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtItem_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtItem
         If Len(Trim(.Text)) >= 50 And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
