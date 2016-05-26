VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetOrdenesPagoPA 
   Caption         =   "Detalle de pago anticipado"
   ClientHeight    =   2475
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4350
   Icon            =   "frmDetOrdenesPagoPA.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2475
   ScaleWidth      =   4350
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtAnticipoSinImpuestos 
      Alignment       =   1  'Right Justify
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
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   2790
      TabIndex        =   1
      Top             =   630
      Width           =   1455
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   2295
      TabIndex        =   5
      Top             =   1935
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   585
      TabIndex        =   4
      Top             =   1935
      Width           =   1485
   End
   Begin VB.TextBox txtAnticipo 
      Alignment       =   1  'Right Justify
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
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   2790
      TabIndex        =   0
      Top             =   180
      Width           =   1455
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   1
      Left            =   1335
      TabIndex        =   3
      Tag             =   "IBCondiciones"
      Top             =   1440
      Width           =   2940
      _ExtentX        =   5186
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdIBCondicion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   1335
      TabIndex        =   2
      Tag             =   "TiposRetencionGanancia"
      Top             =   1080
      Width           =   2940
      _ExtentX        =   5186
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoRetencionGanancia"
      Text            =   ""
   End
   Begin VB.Label lblData 
      Caption         =   "Categ. Ing. Br. :"
      Height          =   240
      Index           =   1
      Left            =   90
      TabIndex        =   9
      Top             =   1485
      Width           =   1170
   End
   Begin VB.Label lblData 
      Caption         =   "Categ. Ganan. :"
      Height          =   240
      Index           =   2
      Left            =   90
      TabIndex        =   8
      Top             =   1125
      Width           =   1170
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe del anticipo sin impuestos :"
      Height          =   300
      Index           =   1
      Left            =   90
      TabIndex        =   7
      Top             =   675
      Width           =   2625
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe del anticipo total :"
      Height          =   300
      Index           =   0
      Left            =   90
      TabIndex        =   6
      Top             =   225
      Width           =   2625
   End
End
Attribute VB_Name = "frmDetOrdenesPagoPA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Aceptado As Boolean
Private mvarRetenerGanancias As Boolean, mvarRetenerIIBB As Boolean
Private mvarIdProveedor As Long

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then
      
      If Len(txtAnticipo.Text) = 0 Or _
            Not IsNumeric(txtAnticipo.Text) Then
         MsgBox "El monto de anticipo deben ser numerico", vbExclamation
         Exit Sub
      End If
      If Val(txtAnticipo.Text) < 0 Then
         MsgBox "El monto de anticipo deben ser mayor a cero", vbExclamation
         Exit Sub
      End If
      If Len(txtAnticipoSinImpuestos.Text) = 0 Or _
            Not IsNumeric(txtAnticipoSinImpuestos.Text) Then
         MsgBox "Debe ingresar el monto del anticipo sin impuestos", vbExclamation
         Exit Sub
      End If
      If Val(txtAnticipoSinImpuestos.Text) < 0 Then
         MsgBox "El monto de anticipo deben ser mayor a cero", vbExclamation
         Exit Sub
      End If
'      If Val(txtAnticipoSinImpuestos.Text) > Val(txtAnticipo.Text) Then
'         MsgBox "El monto del anticipo sin impuestos no puede ser mayor al anticipo", vbExclamation
'         Exit Sub
'      End If
      If dcfields(0).Enabled And Not IsNumeric(dcfields(0).BoundText) Then
         MsgBox "Debe ingresar la categoria para ganancias", vbExclamation
         Exit Sub
      End If
      If dcfields(1).Enabled And Not IsNumeric(dcfields(1).BoundText) Then
         MsgBox "Debe ingresar la categoria para ingresos brutos", vbExclamation
         Exit Sub
      End If
      Aceptado = True
   Else
      Aceptado = False
   End If
   Me.Hide
   
End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   Set dcfields(0).RowSource = Aplicacion.CargarLista("TiposRetencionGanancia")
   Set dcfields(1).RowSource = Aplicacion.IBCondiciones.TraerLista
   
   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", mvarIdProveedor)
   If oRs.RecordCount > 0 Then
      If Not IsNull(oRs.Fields("IdTipoRetencionGanancia").Value) Then
         dcfields(0).BoundText = oRs.Fields("IdTipoRetencionGanancia").Value
      End If
      If Not IsNull(oRs.Fields("IdIBCondicionPorDefecto").Value) Then
         dcfields(1).BoundText = oRs.Fields("IdIBCondicionPorDefecto").Value
      End If
   End If
   oRs.Close
   Set oRs = Nothing
   
   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub txtAnticipo_GotFocus()

   With txtAnticipo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAnticipo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtAnticipoSinImpuestos_GotFocus()

   With txtAnticipoSinImpuestos
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAnticipoSinImpuestos_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Let RetenerGanancias(ByVal vNewValue As Boolean)

   mvarRetenerGanancias = vNewValue
   dcfields(0).Enabled = mvarRetenerGanancias

End Property

Public Property Let RetenerIIBB(ByVal vNewValue As Boolean)

   mvarRetenerIIBB = vNewValue
   dcfields(1).Enabled = mvarRetenerIIBB

End Property

Public Property Let Anticipo(ByVal vNewValue As Double)

   txtAnticipo.Text = vNewValue

End Property

Public Property Let IdProveedor(ByVal vNewValue As Long)

   mvarIdProveedor = vNewValue

End Property
