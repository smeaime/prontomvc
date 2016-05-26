VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmCertificacionesNodos 
   Caption         =   "Item de certificacion de obra"
   ClientHeight    =   3255
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8745
   LinkTopic       =   "Form1"
   ScaleHeight     =   3255
   ScaleWidth      =   8745
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtItem 
      Alignment       =   2  'Center
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
      Left            =   5055
      TabIndex        =   18
      Top             =   540
      Width           =   1590
   End
   Begin VB.TextBox txtNumeroCertificado 
      Alignment       =   2  'Center
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
      Left            =   1050
      Locked          =   -1  'True
      TabIndex        =   16
      Top             =   540
      Width           =   1590
   End
   Begin VB.Frame Frame2 
      Caption         =   "Forma de medir avance :"
      Height          =   915
      Left            =   4140
      TabIndex        =   13
      Top             =   1845
      Width           =   2130
      Begin VB.OptionButton Option2 
         Caption         =   "Por unidad del item"
         Height          =   285
         Index           =   0
         Left            =   180
         TabIndex        =   15
         Top             =   270
         Width           =   1815
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Por porcentaje"
         Height          =   285
         Index           =   1
         Left            =   180
         TabIndex        =   14
         Top             =   607
         Width           =   1815
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Tipo de partida : "
      Height          =   1320
      Left            =   6435
      TabIndex        =   5
      Top             =   1845
      Width           =   2130
      Begin VB.OptionButton Option1 
         Caption         =   "Ampliacion de obra"
         Height          =   285
         Index           =   2
         Left            =   180
         TabIndex        =   8
         Top             =   945
         Width           =   1815
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Partida adicional"
         Height          =   285
         Index           =   1
         Left            =   180
         TabIndex        =   7
         Top             =   607
         Width           =   1815
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Partida contractual"
         Height          =   285
         Index           =   0
         Left            =   180
         TabIndex        =   6
         Top             =   270
         Width           =   1815
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   330
      Index           =   1
      Left            =   1395
      TabIndex        =   2
      Top             =   2790
      Width           =   1140
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   330
      Index           =   0
      Left            =   135
      TabIndex        =   1
      Top             =   2790
      Width           =   1140
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   330
      Left            =   1050
      TabIndex        =   0
      Top             =   1440
      Width           =   7530
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   2
      Left            =   1050
      TabIndex        =   9
      Tag             =   "Obras"
      Top             =   1035
      Width           =   7530
      _ExtentX        =   13282
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   0
      Left            =   1035
      TabIndex        =   11
      Tag             =   "Unidades"
      Top             =   1845
      Width           =   2085
      _ExtentX        =   3678
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro.Item :"
      Height          =   240
      Index           =   2
      Left            =   4185
      TabIndex        =   19
      Top             =   585
      Width           =   735
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro.Certif.:"
      Height          =   240
      Index           =   0
      Left            =   180
      TabIndex        =   17
      Top             =   585
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "Unidad :"
      Height          =   240
      Index           =   0
      Left            =   180
      TabIndex        =   12
      Top             =   1890
      Width           =   735
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obra : "
      Height          =   285
      Index           =   1
      Left            =   180
      TabIndex        =   10
      Top             =   1065
      Width           =   735
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H00C0E0FF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   180
      TabIndex        =   4
      Top             =   90
      Width           =   8430
   End
   Begin VB.Label Label1 
      Caption         =   "Etapa :"
      Height          =   240
      Index           =   4
      Left            =   180
      TabIndex        =   3
      Top             =   1485
      Width           =   735
   End
End
Attribute VB_Name = "frmCertificacionesNodos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const TIPO_OBRA = 1
Const TIPO_ETAPA = 3
Const TIPO_ARTICULO = 4
Const TIPO_RUBRO = 5

Dim WithEvents origen As ComPronto.CertificacionObra
Attribute origen.VB_VarHelpID = -1

Private mvarIdObra As Long, mvarIdCertificacionObras As Long, mvarNumeroCertificado As Long
Private mvarItem As String, mvarAdjunto1 As String
Public NodoPadre As Long, Tipo As Long, CodigoPresupuesto As Long
Public Aceptado As Boolean

Private Sub cmd_Click(Index As Integer)

   Dim oRs As ADOR.Recordset
   Dim mAux1 As Variant
   
   Select Case Index
      Case 0
         If Len(txtNumeroCertificado.Text) = 0 Then
            MsgBox "Debe ingresar un numero de certificado", vbExclamation
            Exit Sub
         End If
         
         If Len(txtItem.Text) = 0 Then
            MsgBox "Debe ingresar un numero de item", vbExclamation
            Exit Sub
         End If
         
         If Len(txtDescripcion.Text) = 0 Then
            MsgBox "Debe ingresar una etapa", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe ingresar una unidad", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(DataCombo1(2).BoundText) Then
            MsgBox "Debe ingresar una obra", vbExclamation
            Exit Sub
         End If
         
         If Me.NumeroCertificado < 0 Then
            Set oRs = Aplicacion.CertificacionesObras.TraerFiltrado("_PorNodo", Array(txtNumeroCertificado.Text, 0))
            If oRs.RecordCount > 0 Then
               oRs.Close
               Set oRs = Nothing
               MsgBox "Este numero de certificado ya existe", vbExclamation
               Exit Sub
            End If
            oRs.Close
         End If
         
         Set origen = Aplicacion.CertificacionesObras.Item(Me.IdCertificacionObras)
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
            If mvarIdCertificacionObras = -1 Then .Fields("TipoNodo").Value = Tipo
            .Fields("IdObra").Value = DataCombo1(2).BoundText
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
            .Fields("Item").Value = txtItem.Text
            .Fields("Adjunto1").Value = Me.Adjunto1
            
            If Me.NumeroCertificado < 0 Then
               mAux1 = TraerValorParametro2("ProximoNumeroCertificado")
               txtNumeroCertificado.Text = IIf(IsNull(mAux1), 1, mAux1)
               .Fields("NumeroCertificado").Value = txtNumeroCertificado.Text
               GuardarValorParametro2 "ProximoNumeroCertificado", "" & txtNumeroCertificado.Text + 1
            Else
               .Fields("NumeroCertificado").Value = txtNumeroCertificado.Text
            End If
         End With
         origen.Guardar
         
         Me.IdObra = DataCombo1(2).BoundText
         Me.NumeroCertificado = txtNumeroCertificado.Text
         Me.Item = txtItem.Text
         
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
   Set DataCombo1(2).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo")
   If Me.NumeroCertificado > 0 Then
      With DataCombo1(2)
         .BoundText = Me.IdObra
         .Enabled = False
      End With
      txtNumeroCertificado.Text = Me.NumeroCertificado
   Else
      mAux1 = TraerValorParametro2("ProximoNumeroCertificado")
      txtNumeroCertificado.Text = IIf(IsNull(mAux1), 1, mAux1)
   End If
   
   If Me.IdCertificacionObras > 0 Then
      Set oRs = Aplicacion.TablasGenerales.TraerUno("CertificacionesObras", Me.IdCertificacionObras)
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

Public Property Get NumeroCertificado() As Long

   NumeroCertificado = mvarNumeroCertificado

End Property

Public Property Let NumeroCertificado(ByVal vNewValue As Long)

   mvarNumeroCertificado = vNewValue

End Property

Public Property Get IdObra() As Long

   IdObra = mvarIdObra

End Property

Public Property Let IdObra(ByVal vNewValue As Long)

   mvarIdObra = vNewValue

End Property

Public Property Get IdCertificacionObras() As Long

   IdCertificacionObras = mvarIdCertificacionObras

End Property

Public Property Let IdCertificacionObras(ByVal vNewValue As Long)

   mvarIdCertificacionObras = vNewValue

End Property

Public Property Get Item() As String

   Item = mvarItem

End Property

Public Property Let Item(ByVal vNewValue As String)

   mvarItem = vNewValue

End Property

Public Property Get Adjunto1() As String

   Adjunto1 = mvarAdjunto1

End Property

Public Property Let Adjunto1(ByVal vNewValue As String)

   mvarAdjunto1 = vNewValue

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
