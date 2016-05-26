VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmPresupuestoObrasNodos 
   Caption         =   "Item para presupuesto de obra"
   ClientHeight    =   2025
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8655
   LinkTopic       =   "Form1"
   ScaleHeight     =   2025
   ScaleWidth      =   8655
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "Medida del avance :"
      Height          =   735
      Left            =   6750
      TabIndex        =   20
      Top             =   855
      Width           =   1725
      Begin VB.OptionButton Option2 
         Caption         =   "Por cantidad"
         Height          =   195
         Left            =   135
         TabIndex        =   22
         Top             =   495
         Width           =   1320
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Por porcentaje"
         Height          =   195
         Left            =   135
         TabIndex        =   21
         Top             =   225
         Width           =   1455
      End
   End
   Begin VB.TextBox txtCodigoArticulo 
      Alignment       =   2  'Center
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
      Left            =   960
      TabIndex        =   10
      Top             =   2520
      Visible         =   0   'False
      Width           =   1410
   End
   Begin VB.TextBox txtDetalle 
      Height          =   330
      Left            =   960
      TabIndex        =   0
      Top             =   435
      Width           =   7530
   End
   Begin VB.TextBox txtItem 
      Alignment       =   2  'Center
      Height          =   330
      Left            =   960
      TabIndex        =   1
      Top             =   990
      Width           =   1140
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      ItemData        =   "frmPresupuestoObrasNodos.frx":0000
      Left            =   3915
      List            =   "frmPresupuestoObrasNodos.frx":004C
      TabIndex        =   8
      Text            =   "Combo2"
      Top             =   1845
      Visible         =   0   'False
      Width           =   1410
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   375
      Index           =   0
      Left            =   45
      TabIndex        =   4
      Top             =   1530
      Width           =   1140
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   375
      Index           =   1
      Left            =   1305
      TabIndex        =   5
      Top             =   1530
      Width           =   1140
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   2
      Left            =   960
      TabIndex        =   6
      Tag             =   "PresupuestoObrasRubros"
      Top             =   2040
      Visible         =   0   'False
      Width           =   1860
      _ExtentX        =   3281
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdPresupuestoObraRubro"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   3
      Left            =   2430
      TabIndex        =   11
      Tag             =   "Articulos"
      Top             =   2520
      Visible         =   0   'False
      Width           =   6135
      _ExtentX        =   10821
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   4
      Left            =   2925
      TabIndex        =   2
      Tag             =   "Unidades"
      Top             =   990
      Width           =   1230
      _ExtentX        =   2170
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "frmPresupuestoObrasNodos.frx":0098
      Left            =   4200
      List            =   "frmPresupuestoObrasNodos.frx":00C3
      TabIndex        =   7
      Text            =   "Combo1"
      Top             =   1620
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.TextBox txtCantidad 
      Alignment       =   1  'Right Justify
      Height          =   330
      Left            =   960
      TabIndex        =   9
      Top             =   1530
      Visible         =   0   'False
      Width           =   735
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   4860
      TabIndex        =   3
      Top             =   990
      Width           =   1725
      _ExtentX        =   3043
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipo"
      Text            =   ""
   End
   Begin VB.Label Label1 
      Caption         =   "Rubro :"
      Height          =   240
      Index           =   6
      Left            =   4275
      TabIndex        =   24
      Top             =   1035
      Width           =   510
   End
   Begin VB.Label Label1 
      Caption         =   "Unidad :"
      Height          =   240
      Index           =   5
      Left            =   2205
      TabIndex        =   23
      Top             =   1035
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "Rubro :"
      Height          =   240
      Index           =   1
      Left            =   120
      TabIndex        =   19
      Top             =   2070
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   240
      Index           =   3
      Left            =   120
      TabIndex        =   18
      Top             =   2580
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "Etapa:"
      Height          =   240
      Index           =   4
      Left            =   120
      TabIndex        =   17
      Top             =   495
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
      Left            =   90
      TabIndex        =   16
      Top             =   90
      Width           =   8430
   End
   Begin VB.Label Label1 
      Caption         =   "Nro.Item :"
      Height          =   240
      Index           =   3
      Left            =   135
      TabIndex        =   15
      Top             =   1035
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "Cantidad :"
      Height          =   240
      Index           =   2
      Left            =   120
      TabIndex        =   14
      Top             =   1620
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "Año :"
      Height          =   240
      Index           =   1
      Left            =   3240
      TabIndex        =   13
      Top             =   1890
      Visible         =   0   'False
      Width           =   465
   End
   Begin VB.Label Label1 
      Caption         =   "Mes :"
      Height          =   240
      Index           =   0
      Left            =   3360
      TabIndex        =   12
      Top             =   1665
      Visible         =   0   'False
      Width           =   735
   End
End
Attribute VB_Name = "frmPresupuestoObrasNodos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const TIPO_OBRA = 1
Const TIPO_ETAPA = 3
Const TIPO_ARTICULO = 4
Const TIPO_RUBRO = 5

Dim WithEvents origen As PresupuestoObraNodo
Attribute origen.VB_VarHelpID = -1

Private mvarIdObra As Long, mvarIdDetalleObraDestino As Long, mvarIdPresupuestoObraRubro As Long
Private mvarIdArticulo As Long, mvarIdPresupuestoObraNodo As Long

Public NodoPadre As Long, Tipo As Long, CodigoPresupuesto As Long
Public Aceptado As Boolean

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Dim i As Integer
         Dim r As Long
         
         If txtDetalle = "" And Tipo = TIPO_ETAPA Then
            MsgBox "Debe ingresar una etapa", vbExclamation
            Exit Sub
         End If
         
         If DataCombo1(0).Visible And Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe ingresar un rubro", vbExclamation
            Exit Sub
         End If
         
         If DataCombo1(4).Visible And Not IsNumeric(DataCombo1(4).BoundText) Then
            MsgBox "Debe ingresar una unidad de medida", vbExclamation
            Exit Sub
         End If
         
         Set origen = Aplicacion.PresupuestoObrasNodos.Item(IdPresupuestoObraNodo)
            
         With origen.Registro
            If NodoPadre = 0 Then
                .Fields("IdNodoPadre").Value = Null
            Else
                .Fields("IdNodoPadre").Value = NodoPadre
            End If
            .Fields("IdObra").Value = Me.IdObra
            .Fields("Descripcion").Value = txtDetalle.Text
            .Fields("IdUnidad").Value = IIf(DataCombo1(4).BoundText = "", Null, DataCombo1(4).BoundText)
            .Fields("IdPresupuestoObraRubro").Value = IIf(DataCombo1(0).BoundText = "", Null, DataCombo1(0).BoundText)
            If Option1.Value Then
               .Fields("UnidadAvance").Value = "%"
            Else
               .Fields("UnidadAvance").Value = "C"
            End If
            .Fields("Cantidad").Value = IIf(IsNull(.Fields("Cantidad").Value), 0, .Fields("Cantidad").Value)
            .Fields("Importe").Value = IIf(IsNull(.Fields("Importe").Value), 0, .Fields("Importe").Value)
            .Fields("Item").Value = txtItem.Text
            If mvarIdPresupuestoObraNodo = -1 Then .Fields("TipoNodo").Value = Tipo
         End With
    
         origen.Guardar
             
         Aceptado = True
      
      Case 1
      
   End Select
   
   Me.Hide

End Sub

Private Sub Combo1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Combo2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   'Set DataCombo1(0).RowSource = Aplicacion.TablasGenerales.TraerLista("PresupuestoObrasRubros")
   Set DataCombo1(0).RowSource = Aplicacion.Tipos.TraerFiltrado("_PorGrupoParaCombo", 1)
   Set DataCombo1(4).RowSource = Aplicacion.Unidades.TraerLista
   'Set DataCombo1(3).RowSource = Aplicacion.Articulos.TraerLista
   
   Dim oRs As ADOR.Recordset
   
   If Me.IdArticulo = -2 Then
      Label2.Caption = "ASIENTO"
   ElseIf Me.IdArticulo = -3 Then
      Label2.Caption = "Nodo DIRECTO"
   Else
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", Me.IdArticulo)
      If oRs.RecordCount > 0 Then Label2.Caption = oRs.Fields("Descripcion").Value
      oRs.Close
   End If
   
   If Me.IdPresupuestoObraNodo > 0 Then
      Set oRs = Aplicacion.TablasGenerales.TraerUno("PresupuestoObrasNodos", Me.IdPresupuestoObraNodo)
      If oRs.RecordCount > 0 Then
         'Combo1.ListIndex = iisnull(oRs.Fields("Mes").Value, 1) - 1
         'Combo2.ListIndex = oRs.Fields("Año").Value - 2001
         'txtCantidad.Text = IIf(IsNull(oRs.Fields("Cantidad").Value), 0, oRs.Fields("Cantidad").Value)
         'txtImporte.Text = IIf(IsNull(oRs.Fields("Importe").Value), 0, oRs.Fields("Importe").Value)
         txtDetalle.Text = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
         DataCombo1(0).BoundText = IIf(IsNull(oRs.Fields("IdPresupuestoObraRubro").Value), 0, oRs.Fields("IdPresupuestoObraRubro").Value)
         DataCombo1(4).BoundText = IIf(IsNull(oRs.Fields("IdUnidad").Value), 0, oRs.Fields("IdUnidad").Value)
         Tipo = oRs!TipoNodo
         If IIf(IsNull(oRs.Fields("UnidadAvance").Value), "%", oRs.Fields("UnidadAvance").Value) = "%" Then
            Option1.Value = True
         Else
            Option2.Value = True
         End If
         txtItem.Text = IIf(IsNull(oRs.Fields("Item").Value), "", oRs.Fields("Item").Value)
      End If
      oRs.Close
      Set oRs = Nothing
   Else
      Combo1.ListIndex = Month(Date) - 1
      Combo2.ListIndex = Year(Date) - 2001
      Option1.Value = True
   End If

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
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

Private Sub txtDetalle_GotFocus()

   With txtDetalle
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDetalle_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDetalle
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

Public Property Get IdObra() As Long

   IdObra = mvarIdObra

End Property

Public Property Let IdObra(ByVal vNewValue As Long)

   mvarIdObra = vNewValue

End Property

Public Property Get IdArticulo() As Long

   IdArticulo = mvarIdArticulo

End Property

Public Property Let IdArticulo(ByVal vNewValue As Long)

   mvarIdArticulo = vNewValue

End Property

Public Property Get IdDetalleObraDestino() As Long

   IdDetalleObraDestino = mvarIdDetalleObraDestino

End Property

Public Property Let IdDetalleObraDestino(ByVal vNewValue As Long)

   mvarIdDetalleObraDestino = vNewValue

End Property

Public Property Get IdPresupuestoObraRubro() As Long

   IdPresupuestoObraRubro = mvarIdPresupuestoObraRubro

End Property

Public Property Let IdPresupuestoObraRubro(ByVal vNewValue As Long)

   mvarIdPresupuestoObraRubro = vNewValue

End Property

Public Property Get IdPresupuestoObraNodo() As Long

   IdPresupuestoObraNodo = mvarIdPresupuestoObraNodo

End Property

Public Property Let IdPresupuestoObraNodo(ByVal vNewValue As Long)

   mvarIdPresupuestoObraNodo = vNewValue

End Property
