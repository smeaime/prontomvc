VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmAsignaFacturaCompra 
   Caption         =   "Asignar factura de compra"
   ClientHeight    =   6735
   ClientLeft      =   60
   ClientTop       =   630
   ClientWidth     =   11115
   Icon            =   "frmAsignaFacturaCompra.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6735
   ScaleWidth      =   11115
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtItemsSeleccionados 
      Alignment       =   1  'Right Justify
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
      Height          =   330
      Left            =   8415
      Locked          =   -1  'True
      TabIndex        =   23
      Top             =   855
      Width           =   2625
   End
   Begin VB.CommandButton cmdAsignar 
      Caption         =   "Asignar items seleccionados"
      Height          =   450
      Left            =   3240
      TabIndex        =   22
      Tag             =   "Aceptar"
      Top             =   6210
      Width           =   1410
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
      Left            =   9360
      TabIndex        =   17
      Top             =   495
      Width           =   1680
   End
   Begin VB.TextBox txtNumeroFactura2 
      Alignment       =   1  'Right Justify
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   2610
      TabIndex        =   3
      Top             =   855
      Width           =   1320
   End
   Begin VB.TextBox txtImporteFactura 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
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
      Height          =   330
      Left            =   5940
      TabIndex        =   5
      Top             =   1260
      Width           =   1095
   End
   Begin VB.TextBox txtNumeroFactura1 
      Alignment       =   1  'Right Justify
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   1710
      TabIndex        =   2
      Top             =   855
      Width           =   870
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "Aceptar"
      Height          =   450
      Left            =   4770
      TabIndex        =   6
      Tag             =   "Aceptar"
      Top             =   6210
      Width           =   1410
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancelar"
      Height          =   450
      Left            =   6300
      TabIndex        =   7
      Tag             =   "Cancelar"
      Top             =   6210
      Width           =   1410
   End
   Begin VB.TextBox txtFechaComprobante 
      Alignment       =   2  'Center
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
      Height          =   330
      Left            =   5040
      Locked          =   -1  'True
      TabIndex        =   10
      Top             =   135
      Width           =   1455
   End
   Begin VB.TextBox txtNumeroComprobante 
      Alignment       =   1  'Right Justify
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
      Height          =   330
      Left            =   1710
      Locked          =   -1  'True
      TabIndex        =   8
      Top             =   135
      Width           =   1095
   End
   Begin Controles1013.DbListView Lista 
      Height          =   2265
      Left            =   45
      TabIndex        =   1
      Top             =   1620
      Width           =   10995
      _ExtentX        =   19394
      _ExtentY        =   3995
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmAsignaFacturaCompra.frx":076A
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   9990
      Top             =   6165
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
            Picture         =   "frmAsignaFacturaCompra.frx":0786
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAsignaFacturaCompra.frx":0898
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAsignaFacturaCompra.frx":0CEA
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAsignaFacturaCompra.frx":113C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   330
      Index           =   0
      Left            =   5085
      TabIndex        =   4
      Top             =   855
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   64421889
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   0
      Left            =   1710
      TabIndex        =   0
      Tag             =   "Proveedores"
      Top             =   495
      Width           =   6675
      _ExtentX        =   11774
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin Controles1013.DbListView ListaEntregas 
      Height          =   1905
      Left            =   0
      TabIndex        =   19
      Top             =   4230
      Width           =   10995
      _ExtentX        =   19394
      _ExtentY        =   3360
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmAsignaFacturaCompra.frx":158E
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdMoneda"
      Height          =   360
      Index           =   1
      Left            =   8415
      TabIndex        =   25
      Tag             =   "Monedas"
      Top             =   1215
      Width           =   2625
      _ExtentX        =   4630
      _ExtentY        =   635
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Moneda :"
      Height          =   285
      Index           =   9
      Left            =   7335
      TabIndex        =   26
      Top             =   1260
      Width           =   1035
   End
   Begin VB.Label lblLabels 
      Caption         =   "Items seleccionados :"
      Height          =   240
      Index           =   2
      Left            =   6525
      TabIndex        =   24
      Top             =   900
      Width           =   1830
   End
   Begin VB.Label lblTipo 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   7515
      TabIndex        =   21
      Top             =   90
      Width           =   3510
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Registro de facturas : "
      Height          =   195
      Index           =   0
      Left            =   90
      TabIndex        =   20
      Top             =   1395
      Width           =   1560
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
      Index           =   8
      Left            =   8550
      TabIndex        =   18
      Top             =   540
      Width           =   735
   End
   Begin VB.Label lblLabels 
      Caption         =   "Proveedor :"
      Height          =   285
      Index           =   7
      Left            =   90
      TabIndex        =   16
      Top             =   525
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Importe factura sin iva : "
      Height          =   240
      Index           =   6
      Left            =   4050
      TabIndex        =   15
      Top             =   1305
      Width           =   1830
   End
   Begin VB.Label lblLabels 
      Caption         =   "Factura numero : "
      Height          =   285
      Index           =   5
      Left            =   90
      TabIndex        =   14
      Top             =   900
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   4050
      TabIndex        =   13
      Top             =   900
      Width           =   990
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Entregas concretadas : "
      Height          =   195
      Index           =   3
      Left            =   45
      TabIndex        =   12
      Top             =   4005
      Width           =   1695
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha comprobante :"
      Height          =   240
      Index           =   1
      Left            =   3420
      TabIndex        =   11
      Top             =   180
      Width           =   1560
   End
   Begin VB.Label lblLabels 
      Caption         =   "Comprobante nro. :"
      Height          =   240
      Index           =   14
      Left            =   90
      TabIndex        =   9
      Top             =   180
      Width           =   1575
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Eliminar item"
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   0
      End
   End
End
Attribute VB_Name = "frmAsignaFacturaCompra"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Ok As Boolean
Private oRsFacturas As ADOR.Recordset
Private mIdComprobante As Long, mNumeroComprobante As Long, mIdAutorizo As Long
Private mFechaComprobante As Date
Private mCumplido As String, mItemsSeleccionados As String, mIdItemsSeleccionados As String
Private mTipoComprobante As EnumFormularios

Private Sub cmdAsignar_Click()

   If Len(Trim(txtNumeroFactura1.Text)) = 0 Then
      MsgBox "Complete el numero de factura", vbExclamation
      Exit Sub
   End If
   
   If Len(Trim(txtNumeroFactura2.Text)) = 0 Then
      MsgBox "Complete el numero de factura", vbExclamation
      Exit Sub
   End If
   
   If Len(Trim(txtImporteFactura.Text)) = 0 Then
      MsgBox "Debe ingresar el monto de la factura", vbExclamation
      Exit Sub
   End If
   
   If Not IsNumeric(dcfields(0).BoundText) Then
      MsgBox "Debe ingresar el proveedor", vbExclamation
      Exit Sub
   End If
   
   If Not IsNumeric(dcfields(1).BoundText) Then
      MsgBox "Debe ingresar la moneda", vbExclamation
      Exit Sub
   End If
   
   Dim Filas, FilasId
   Dim i As Integer
   Dim iDet As Long
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   
   Set oRs = Aplicacion.Empleados.Item(mIdAutorizo).Registro
   
   Filas = Split(mItemsSeleccionados, ",")
   FilasId = Split(mIdItemsSeleccionados, ",")
   
   For i = 0 To UBound(Filas)
      Set oL = Lista.ListItems.Add
      oL.Tag = Lista.ListItems.Count * -1
      With oL
         .SmallIcon = "Nuevo"
         .Text = "" & Filas(i)
         .SubItems(1) = "" & dcfields(0).Text
         .SubItems(2) = "" & txtNumeroFactura1.Text + "-" + txtNumeroFactura2.Text
         .SubItems(3) = "" & DTFields(0).Value
         .SubItems(4) = "" & txtImporteFactura.Text
         .SubItems(5) = "" & dcfields(1).Text
      End With
      With oRsFacturas
         .AddNew
         .Fields("IdFacturaCompra").Value = oL.Tag
         .Fields("TipoComprobante").Value = mTipoComprobante
         .Fields("IdComprobante").Value = mIdComprobante
         .Fields("IdDetalleComprobante").Value = FilasId(i)
         .Fields("NumeroItem").Value = Filas(i)
         .Fields("IdProveedor").Value = dcfields(0).BoundText
         .Fields("IdMoneda").Value = dcfields(1).BoundText
         .Fields("NumeroFactura1").Value = txtNumeroFactura1.Text
         .Fields("NumeroFactura2").Value = txtNumeroFactura2.Text
         .Fields("FechaFactura").Value = DTFields(0).Value
         .Fields("ImporteFactura").Value = txtImporteFactura.Text
         If Not IsNull(oRs.Fields("Iniciales").Value) Then
            .Fields("Usuario").Value = oRs.Fields("Iniciales").Value
         End If
         .Fields("FechaIngreso").Value = Now
         .Update
      End With
   Next

   oRs.Close
   Set oRs = Nothing
   
   cmdAsignar.Enabled = False
   
End Sub

Private Sub cmdCancel_Click()
   
   Ok = False
   Me.Hide

End Sub

Private Sub cmdOk_Click()
   
   Dim oAp As ComPronto.Aplicacion
   Dim est As EnumAcciones
   Dim dc As DataCombo
   Dim mSiNo As Integer
   
   Set oAp = Aplicacion
      
   oAp.FacturasCompra.Guardar oRsFacturas
   
   Set oAp = Nothing
   
   If mCumplido = "SI" Then
      mSiNo = vbYes
   Else
      mSiNo = vbNo
   End If
   
   mSiNo = MsgBox("Desea dar el item por cumplido ?", vbYesNo, "Estado del item de Comprobanteuerimiento")
   If mSiNo = vbYes Then
      mCumplido = "SI"
   Else
      mCumplido = "NO"
   End If
   
   Ok = True
   Me.Hide

End Sub

Private Sub dcfields_GotFocus(Index As Integer)

   If Len(dcfields(Index).Text) = 0 Then
      SendKeys "%{DOWN}"
   End If

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Public Property Let TipoComprobante(ByVal vnewvalue As EnumFormularios)

   mTipoComprobante = vnewvalue

   Select Case mTipoComprobante
      Case EnumFormularios.RequerimientoMateriales
         lblTipo.Caption = "REQUERIMIENTO"
      Case EnumFormularios.ListaAcopio
         lblTipo.Caption = "LISTA DE ACOPIO"
   End Select

End Property

Public Property Let IdComprobante(ByVal vnewvalue As Long)

   mIdComprobante = vnewvalue

End Property

Public Property Let NumeroComprobante(ByVal vnewvalue As Long)

   mNumeroComprobante = vnewvalue

End Property

Public Property Let FechaComprobante(ByVal vnewvalue As Date)

   mFechaComprobante = vnewvalue

End Property

Public Property Let IdAutorizo(ByVal vnewvalue As Long)

   mIdAutorizo = vnewvalue

End Property

Public Property Let Cumplido(ByVal vnewvalue As String)

   mCumplido = vnewvalue

End Property

Public Property Get Cumplido() As String

   Cumplido = mCumplido
   
End Property

Public Property Let ItemsSeleccionados(ByVal vnewvalue As String)

   mItemsSeleccionados = vnewvalue

End Property

Public Property Let IdItemsSeleccionados(ByVal vnewvalue As String)

   mIdItemsSeleccionados = vnewvalue

   Dim dc As DataCombo
   
   txtNumeroComprobante.Text = mNumeroComprobante
   txtFechaComprobante.Text = mFechaComprobante
   txtItemsSeleccionados.Text = mItemsSeleccionados
   DTFields(0).Value = Date
   
   Set oRsFacturas = Aplicacion.FacturasCompra.Registros(mTipoComprobante, mIdComprobante)
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
      .ListItems.Clear
      Set .DataSource = Aplicacion.FacturasCompra.TraerFiltrado("_DetallePorComprobante", Array(mTipoComprobante, mIdComprobante))
      .Refresh
   End With
   
   With ListaEntregas
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
      .ListItems.Clear
      Set .DataSource = Aplicacion.Requerimientos.TraerFiltrado("_EntregasConcretadas", mIdComprobante)
      .Refresh
   End With
   
   For Each dc In dcfields
      Set dc.RowSource = Aplicacion.CargarLista(dc.Tag)
   Next
   
End Property

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oRsFacturas = Nothing
   
End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetA_Click 0
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count = 0 Then
      Else
         PopupMenu MnuDet, , , , MnuDetA(0)
      End If
   End If

End Sub

Private Sub ListaEntregas_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         If Not Lista.SelectedItem Is Nothing Then
            With Lista.SelectedItem
               If oRsFacturas.RecordCount > 0 Then
                  oRsFacturas.MoveFirst
                  Do While Not oRsFacturas.EOF
                     If oRsFacturas.Fields(0).Value = .Tag Then
                        oRsFacturas.Fields("Eliminado").Value = True
                        Exit Do
                     End If
                     oRsFacturas.MoveNext
                  Loop
               End If
               .SmallIcon = "Eliminado"
               .ToolTipText = .SmallIcon
            End With
         End If
   End Select

End Sub

Private Sub txtBusca_GotFocus()

   With txtBusca
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBusca_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      If KeyAscii = 13 Then
         Dim oAp As ComPronto.Aplicacion
         Set oAp = Aplicacion
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set dcfields(0).RowSource = oAp.Proveedores.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set dcfields(0).RowSource = oAp.Proveedores.TraerLista
         End If
         Set oAp = Nothing
      End If
      dcfields(0).SetFocus
      SendKeys "%{DOWN}"
   End If

End Sub

Private Sub txtImporteFactura_GotFocus()

   With txtImporteFactura
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImporteFactura_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroFactura1_GotFocus()

   With txtNumeroFactura1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroFactura1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroFactura2_GotFocus()

   With txtNumeroFactura2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroFactura2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

