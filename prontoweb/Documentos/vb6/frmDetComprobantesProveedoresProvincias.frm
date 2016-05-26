VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmDetComprobantesProveedoresProvincias 
   Caption         =   "Distribucion de IIBB por provincias"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4080
   Icon            =   "frmDetComprobantesProveedoresProvincias.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4080
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdOk 
      Caption         =   "OK"
      Enabled         =   0   'False
      Height          =   330
      Left            =   3600
      TabIndex        =   8
      Top             =   2205
      Width           =   420
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   3285
      TabIndex        =   7
      Top             =   1845
      Width           =   690
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   2250
      TabIndex        =   6
      Top             =   2655
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   360
      TabIndex        =   5
      Top             =   2655
      Width           =   1485
   End
   Begin VB.TextBox txtPorcentaje 
      Alignment       =   1  'Right Justify
      DataField       =   "Porcentaje"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   2790
      TabIndex        =   4
      Top             =   2205
      Width           =   690
   End
   Begin Controles1013.DbListView Lista 
      Height          =   2130
      Left            =   45
      TabIndex        =   0
      Top             =   45
      Width           =   3990
      _ExtentX        =   7038
      _ExtentY        =   3757
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmDetComprobantesProveedoresProvincias.frx":076A
      MultiSelect     =   0   'False
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProvinciaDestino"
      Height          =   315
      Index           =   0
      Left            =   630
      TabIndex        =   1
      Tag             =   "Provincias"
      Top             =   2205
      Width           =   1770
      _ExtentX        =   3122
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdProvincia"
      Text            =   ""
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   0
      Top             =   2565
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDetComprobantesProveedoresProvincias.frx":0786
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDetComprobantesProveedoresProvincias.frx":0898
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDetComprobantesProveedoresProvincias.frx":0CEA
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDetComprobantesProveedoresProvincias.frx":113C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin VB.Label lblLabels 
      Caption         =   "% :"
      Height          =   240
      Index           =   0
      Left            =   2475
      TabIndex        =   3
      Top             =   2250
      Width           =   270
   End
   Begin VB.Label lblLabels 
      Caption         =   "Prov.:"
      Height          =   240
      Index           =   19
      Left            =   90
      TabIndex        =   2
      Top             =   2250
      Width           =   495
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
End
Attribute VB_Name = "frmDetComprobantesProveedoresProvincias"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private mvarId As Long
Dim oComprobanteProveedor As ComPronto.ComprobanteProveedor

Sub Editar(ByVal Cual As Long)

   cmdOk.Enabled = True
   dcfields(0).Enabled = True
   txtPorcentaje.Enabled = True
   cmd(0).Enabled = False
   cmd(1).Enabled = False
   
   mvarId = Cual
   If Cual = -1 Then
      dcfields(0).BoundText = 0
      txtPorcentaje.Text = 100 - Val(txtTotal.Text)
   Else
      With oComprobanteProveedor.DetComprobantesProveedoresPrv.Item(Cual)
         With .Registro
            dcfields(0).BoundText = .Fields("IdProvinciaDestino").Value
            txtPorcentaje.Text = .Fields("Porcentaje").Value
         End With
      End With
   End If
   
End Sub

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then
      If Val(txtTotal.Text) <> 100 Then
         MsgBox "El total porcentual debe ser del 100%", vbExclamation
         Exit Sub
      End If
   End If
   Me.Hide
   
End Sub

Private Sub cmdOk_Click()

   Dim oL As ListItem
   
   With oComprobanteProveedor.DetComprobantesProveedoresPrv.Item(mvarId)
      With .Registro
         .Fields("IdProvinciaDestino").Value = dcfields(0).BoundText
         .Fields("Porcentaje").Value = txtPorcentaje.Text
      End With
      .Modificado = True
   End With
   Set Lista.DataSource = oComprobanteProveedor.DetComprobantesProveedoresPrv.RegistrosConFormato
   
   cmdOk.Enabled = False
   dcfields(0).Enabled = False
   txtPorcentaje.Enabled = False
   cmd(0).Enabled = True
   cmd(1).Enabled = True
   
   CalcularTotales

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   Set Lista.DataSource = oComprobanteProveedor.DetComprobantesProveedoresPrv.RegistrosConFormato
   Set dcfields(0).RowSource = Aplicacion.Provincias.TraerLista
   
   CalcularTotales
   
   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual
  
   mvarId = 0

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Lista_DblClick()

   If Lista.ListItems.Count = 0 Then
      Editar -1
   Else
      Editar Lista.SelectedItem.Tag
   End If

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyDelete Then
      MnuDetA_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetA_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetA_Click 1
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count = 0 Then
         MnuDetA(1).Enabled = False
         MnuDetA(2).Enabled = False
         PopupMenu MnuDet, , , , MnuDetA(0)
      Else
         MnuDetA(1).Enabled = True
         MnuDetA(2).Enabled = True
         PopupMenu MnuDet, , , , MnuDetA(1)
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         Editar Lista.SelectedItem.Tag
      Case 2
         With Lista.SelectedItem
            oComprobanteProveedor.DetComprobantesProveedoresPrv.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         CalcularTotales
   End Select

End Sub

Public Property Get ComprobanteProveedor() As ComPronto.ComprobanteProveedor

   Set ComprobanteProveedor = oComprobanteProveedor

End Property

Public Property Set ComprobanteProveedor(ByVal vNewValue As ComPronto.ComprobanteProveedor)

   Set oComprobanteProveedor = vNewValue

End Property

Private Sub Form_Unload(Cancel As Integer)

   Set oComprobanteProveedor = Nothing
   
End Sub

Private Sub txtPorcentaje_GotFocus()

   With txtPorcentaje
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcentaje_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Public Sub CalcularTotales()

   Dim oRs As ADOR.Recordset
   Dim mTotal As Single
   
   Set oRs = oComprobanteProveedor.DetComprobantesProveedoresPrv.Registros
   mTotal = 0
   With oRs
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               If Not .Fields("Eliminado").Value Then
                  mTotal = mTotal + IIf(IsNull(.Fields("Porcentaje").Value), 0, .Fields("Porcentaje").Value)
               End If
               .MoveNext
            Loop
         End If
      End If
   End With
   Set oRs = Nothing
   
   txtTotal.Text = mTotal

End Sub
