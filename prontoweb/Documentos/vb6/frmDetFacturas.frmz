VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmDetFacturas 
   Caption         =   "Item de Factura"
   ClientHeight    =   8280
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10710
   Icon            =   "frmDetFacturas.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8280
   ScaleWidth      =   10710
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdAnticipo 
      Caption         =   "Cambiar por anticipo"
      Height          =   240
      Left            =   8685
      TabIndex        =   41
      Top             =   3015
      Visible         =   0   'False
      Width           =   1950
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Calcular segun % de certif."
      Height          =   240
      Left            =   3240
      TabIndex        =   40
      Top             =   3600
      Width           =   2220
   End
   Begin VB.CommandButton cmdBorrarObservaciones 
      Caption         =   "Borrar observaciones"
      Height          =   240
      Left            =   8685
      TabIndex        =   38
      Top             =   6030
      Width           =   1950
   End
   Begin VB.CommandButton cmdItems 
      Caption         =   "Traer todos los items pendientes de la OC marcada"
      Height          =   240
      Index           =   2
      Left            =   6570
      TabIndex        =   37
      Top             =   6435
      Width           =   4065
   End
   Begin VB.TextBox txtCodigoArticulo 
      Alignment       =   1  'Right Justify
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
      Left            =   2070
      TabIndex        =   0
      Top             =   2340
      Width           =   1770
   End
   Begin VB.CommandButton cmdItems 
      Caption         =   "Traer todos los items pendientes"
      Height          =   240
      Index           =   1
      Left            =   3780
      TabIndex        =   35
      Top             =   6435
      Width           =   2670
   End
   Begin VB.CommandButton cmdItems 
      Caption         =   "Traer todos los items"
      Height          =   285
      Index           =   0
      Left            =   8235
      TabIndex        =   34
      Top             =   0
      Width           =   2445
   End
   Begin VB.TextBox txtPorcentajeCertificacion 
      Alignment       =   1  'Right Justify
      DataField       =   "PorcentajeCertificacion"
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
      Left            =   2070
      TabIndex        =   4
      Top             =   3555
      Width           =   1095
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   45
      TabIndex        =   8
      Top             =   5130
      Width           =   1980
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   45
      TabIndex        =   9
      Top             =   5625
      Width           =   1980
   End
   Begin VB.TextBox txtCantidad 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   1
      EndProperty
      Height          =   315
      Left            =   2070
      TabIndex        =   2
      Top             =   3120
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Caption         =   "Tomar la descripcion de : "
      Height          =   555
      Left            =   5625
      TabIndex        =   39
      Top             =   3330
      Width           =   5010
      Begin VB.OptionButton Option2 
         Caption         =   "Solo las observaciones"
         Height          =   330
         Left            =   1845
         TabIndex        =   23
         Top             =   180
         Width           =   1455
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Solo el material"
         Height          =   330
         Left            =   180
         TabIndex        =   22
         Top             =   180
         Width           =   1455
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Material mas observaciones"
         Height          =   330
         Left            =   3420
         TabIndex        =   21
         Top             =   180
         Width           =   1455
      End
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
      Height          =   360
      Left            =   8145
      TabIndex        =   20
      Top             =   2295
      Width           =   2490
   End
   Begin VB.Frame Frame2 
      Caption         =   "Forma de cancelacion : "
      Height          =   465
      Left            =   4050
      TabIndex        =   17
      Top             =   2160
      Width           =   2985
      Begin VB.OptionButton Option4 
         Caption         =   "Por cantidad"
         Height          =   195
         Left            =   45
         TabIndex        =   19
         Top             =   225
         Width           =   1320
      End
      Begin VB.OptionButton Option5 
         Caption         =   "Por certificacion"
         Height          =   195
         Left            =   1395
         TabIndex        =   18
         Top             =   225
         Width           =   1455
      End
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
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
      Height          =   360
      Left            =   9180
      TabIndex        =   11
      Top             =   3960
      Width           =   1455
   End
   Begin VB.TextBox txtPrecioUnitario 
      Alignment       =   1  'Right Justify
      DataField       =   "PrecioUnitario"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   2070
      TabIndex        =   5
      Top             =   3975
      Width           =   1410
   End
   Begin VB.TextBox txtBonificacion 
      Alignment       =   1  'Right Justify
      DataField       =   "Bonificacion"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   7155
      TabIndex        =   7
      Top             =   3960
      Width           =   870
   End
   Begin VB.TextBox txtCosto 
      Alignment       =   1  'Right Justify
      DataField       =   "Costo"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   4365
      TabIndex        =   6
      Top             =   3960
      Width           =   1230
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   1
      Left            =   2070
      TabIndex        =   1
      Tag             =   "Articulos"
      Top             =   2700
      Width           =   8565
      _ExtentX        =   15108
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   0
      Left            =   3195
      TabIndex        =   3
      Tag             =   "Unidades"
      Top             =   3120
      Width           =   2310
      _ExtentX        =   4075
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1635
      Left            =   2070
      TabIndex        =   12
      Top             =   4410
      Width           =   8565
      _ExtentX        =   15108
      _ExtentY        =   2884
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmDetFacturas.frx":076A
   End
   Begin Controles1013.DbListView ListaOC 
      Height          =   1815
      Left            =   45
      TabIndex        =   10
      Top             =   270
      Width           =   10635
      _ExtentX        =   18759
      _ExtentY        =   3201
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmDetFacturas.frx":07EC
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaRM 
      Height          =   1500
      Left            =   45
      TabIndex        =   31
      Top             =   6660
      Width           =   10590
      _ExtentX        =   18680
      _ExtentY        =   2646
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmDetFacturas.frx":0808
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   45
      Top             =   4905
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
            Picture         =   "frmDetFacturas.frx":0824
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDetFacturas.frx":0936
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDetFacturas.frx":0D88
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDetFacturas.frx":11DA
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin VB.TextBox txtItem 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroItem"
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
      Left            =   2070
      TabIndex        =   24
      Top             =   1935
      Visible         =   0   'False
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "Color :"
      Height          =   270
      Index           =   12
      Left            =   5580
      TabIndex        =   43
      Top             =   3015
      Visible         =   0   'False
      Width           =   510
   End
   Begin VB.Label lblColor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   270
      Left            =   6165
      TabIndex        =   42
      Top             =   3015
      Visible         =   0   'False
      Width           =   2490
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de articulo :"
      Height          =   300
      Index           =   11
      Left            =   90
      TabIndex        =   36
      Top             =   2340
      Width           =   1815
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000005&
      BorderWidth     =   2
      Index           =   1
      X1              =   45
      X2              =   10620
      Y1              =   6345
      Y2              =   6345
   End
   Begin VB.Label lblLabels 
      Caption         =   "Items de remitos :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Index           =   10
      Left            =   45
      TabIndex        =   33
      Top             =   6435
      Width           =   1545
   End
   Begin VB.Label lblLabels 
      Caption         =   "Items de ordenes de compra :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Index           =   7
      Left            =   90
      TabIndex        =   32
      Top             =   45
      Width           =   2580
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de item :"
      Height          =   300
      Index           =   9
      Left            =   90
      TabIndex        =   30
      Top             =   1935
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Porc. de certificacion :"
      Height          =   300
      Index           =   8
      Left            =   90
      TabIndex        =   29
      Top             =   3555
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   255
      Index           =   6
      Left            =   90
      TabIndex        =   28
      Top             =   2745
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   300
      Index           =   3
      Left            =   90
      TabIndex        =   27
      Top             =   3120
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   300
      Index           =   2
      Left            =   90
      TabIndex        =   26
      Top             =   4455
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
      Height          =   300
      Index           =   14
      Left            =   7245
      TabIndex        =   25
      Top             =   2340
      Width           =   825
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe :"
      Height          =   255
      Index           =   5
      Left            =   8190
      TabIndex        =   16
      Top             =   4005
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Precio Unitario :"
      Height          =   300
      Index           =   1
      Left            =   90
      TabIndex        =   15
      Top             =   4005
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Bonificacion (%) :"
      Height          =   255
      Index           =   0
      Left            =   5760
      TabIndex        =   14
      Top             =   4005
      Width           =   1275
   End
   Begin VB.Label lblLabels 
      Caption         =   "Costo :"
      Height          =   255
      Index           =   4
      Left            =   3690
      TabIndex        =   13
      Top             =   4005
      Width           =   600
   End
End
Attribute VB_Name = "frmDetFacturas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetFactura
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oFactura As ComPronto.Factura
Public Aceptado As Boolean
Private OC_Elegida As Boolean
Private mvarTipoIVA As Integer
Private mvarCotizacion As Double, mvarP_IVA1 As Double, mvarP_IVA2 As Double, mvarDecimales As Double, mAlicuotaIVA As Double
Private mvarPorcentajeBonificacionOC As Single
Private mvarEsMuestra As String, mvarTipoABC As String
Private mvarIdNuevo As Long, mvarId As Long, mIdDetalleOrdenCompra As Long, mIdCondicionVenta As Long, mIdMoneda As Long
Private mvarIdUnidad As Long
Private mvarIdObra As Long, mvarIdRubroAnticipos As Long

Private Sub Check1_Click()

   CalculaImporte

End Sub

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then
      If Len(txtCantidad.Text) = 0 Then
         MsgBox "Debe indicar la cantidad del item a facturar", vbExclamation
         Exit Sub
      End If
      
      If Len(txtPrecioUnitario.Text) = 0 Then
         MsgBox "Debe indicar el precio del item a facturar", vbExclamation
         Exit Sub
      End If
      
'      If Len(txtItem.Text) = 0 Then
'         MsgBox "Debe indicar el numero de item a facturar", vbExclamation
'         Exit Sub
'      End If
      
      If Not Option4.Value And Not Option5.Value Then
         MsgBox "Debe indicar si la venta es por cantidad o porcentaje de certificacion", vbExclamation
         Exit Sub
      End If
      
      If Option5.Value And Val(txtPorcentajeCertificacion.Text) = 0 Then
         MsgBox "Debe ingresar el porcentaje certificado", vbExclamation
         Exit Sub
      End If
      
      Dim dc As DataCombo
      Dim oL As ListItem
      Dim oDetRM As DetFacturaRemitos
      Dim oDetOC As DetFacturaOrdenesCompra
      
      For Each dc In DataCombo1
         If dc.Enabled Or dc.Index = 0 Then
            If Not IsNumeric(dc.BoundText) Then
               MsgBox "Falta completar el campo " & dc.Tag, vbCritical
               Exit Sub
            End If
         End If
         If IsNumeric(dc.BoundText) Then
            origen.Registro.Fields(dc.DataField).Value = dc.BoundText
         End If
      Next
      
      With origen
         With .Registro
            If IsNull(.Fields("Bonificacion").Value) Then .Fields("Bonificacion").Value = 0
            .Fields("Observaciones").Value = rchObservaciones.Text
         End With
         
         If Not mvarId = -1 Then .DetFacturasRemitos.BorrarTodosLosItems
         With .DetFacturasRemitos
            For Each oL In ListaRM.ListItems
               If oL.Checked Then
                  Set oDetRM = .Item(-1)
                  With oDetRM
                     .Registro.Fields("IdDetalleFactura").Value = Me.IdNuevo
                     .Registro.Fields("IdDetalleRemito").Value = oL.SubItems(1)
                     .Modificado = True
                  End With
                  Set oDetRM = Nothing
               End If
            Next
         End With
      
         If Not mvarId = -1 Then .DetFacturasOrdenesCompra.BorrarTodosLosItems
         With .DetFacturasOrdenesCompra
            For Each oL In ListaOC.ListItems
               If oL.Checked Then
                  Set oDetOC = .Item(-1)
                  With oDetOC
                     .Registro.Fields("IdDetalleFactura").Value = Me.IdNuevo
                     .Registro.Fields("IdDetalleOrdenCompra").Value = oL.SubItems(1)
                     .Modificado = True
                  End With
                  Set oDetOC = Nothing
               End If
            Next
         End With
      End With
      
      With origen
         If mvarId <= 0 Then .Registro.Fields(0).Value = Me.IdNuevo
         .Modificado = True
      End With
      Aceptado = True
   ElseIf Index = 1 Then
      If mvarId = -1 Then
         origen.Eliminado = True
      End If
   End If
   
   Me.Hide

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim oL As ListItem
   Dim ListaVacia1 As Boolean, ListaVacia2 As Boolean, RM_Elegida As Boolean
   Dim i As Long
   
   If BuscarClaveINI("Activar anticipos de venta") = "SI" Then
      cmdAnticipo.Visible = True
   End If
   
   If BuscarClaveINI("Tabla de colores ampliada") = "SI" Then
      lblLabels(12).Visible = True
      lblColor.Visible = True
   End If
   
   mvarId = vNewValue
   
   ListaVacia1 = False
   ListaVacia2 = False
   mIdDetalleOrdenCompra = 0
   OC_Elegida = False
   RM_Elegida = False
   
   Set oAp = Aplicacion
   
   mvarIdRubroAnticipos = 0
   Set oRs = oAp.Parametros.TraerFiltrado("_Parametros2BuscarClave", "IdRubroAnticipos")
   If oRs.RecordCount > 0 Then
      mvarIdRubroAnticipos = IIf(IsNull(oRs.Fields("Valor").Value), 0, Val(oRs.Fields("Valor").Value))
   End If
   oRs.Close
   
   Set origen = oFactura.DetFacturas.Item(vNewValue)
   Me.IdNuevo = origen.Id
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is DbListView Then
            If oControl.Name = "ListaRM" Then
               If mvarId = -1 Then
                  Set oControl.DataSource = origen.DetFacturasRemitos.TraerMascara
                  ListaVacia1 = True
               ElseIf mvarId < -1 Then
                  Set oRs = origen.DetFacturasRemitos.RegistrosConFormato
                  Set oControl.DataSource = oRs
                  If oControl.ListItems.Count > 0 Then
                     For i = 1 To oControl.ListItems.Count
                        oControl.ListItems(i).Checked = True
                     Next
                  End If
                  Set oRs = Nothing
               Else
                  Set oRs = origen.DetFacturasRemitos.TraerTodos
                  If oRs.RecordCount > 0 Then
                     RM_Elegida = True
                  End If
                  Set oControl.DataSource = oRs
                  Set oRs = Nothing
                  If RM_Elegida Then
                     For Each oL In ListaRM.ListItems
                        oL.Checked = True
                     Next
                  End If
               End If
            ElseIf oControl.Name = "ListaOC" Then
               If mvarId = -1 Then
                  Set oControl.DataSource = origen.DetFacturasOrdenesCompra.TraerMascara
                  ListaVacia2 = True
               ElseIf mvarId < -1 Then
                  Set oRs = origen.DetFacturasOrdenesCompra.Registros
                  If oRs.RecordCount > 0 Then
                     oRs.MoveFirst
                     mIdDetalleOrdenCompra = oRs.Fields("IdDetalleOrdenCompra").Value
                  End If
                  Set oRs = Nothing
                  If mIdDetalleOrdenCompra <> 0 Then
                     Set oControl.DataSource = oAp.OrdenesCompra.TraerFiltrado("_DetallesPendientesDeFacturarPorIdDetalleOrdenCompra", mIdDetalleOrdenCompra)
                     For Each oL In ListaOC.ListItems
                        oL.Checked = True
                     Next
                  Else
                     Set oControl.DataSource = origen.DetFacturasOrdenesCompra.TraerMascara
                     ListaVacia2 = True
                  End If
               Else
                  Set oRs = origen.DetFacturasOrdenesCompra.TraerTodos
                  If oRs.RecordCount > 0 Then
                     OC_Elegida = True
                  End If
                  Set oControl.DataSource = oRs
                  Set oRs = Nothing
                  If OC_Elegida Then
                     For Each oL In ListaOC.ListItems
                        oL.Checked = True
                     Next
                  End If
               End If
            End If
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Unidades" Then
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      mvarP_IVA1 = .Fields("Iva1").Value
      mvarP_IVA2 = .Fields("Iva2").Value
      mvarDecimales = .Fields("Decimales").Value
      mvarIdUnidad = .Fields("IdUnidad").Value
      .Close
   End With
   
   If ListaVacia1 Then
      ListaRM.ListItems.Clear
   End If
   
   If ListaVacia2 Then
      ListaOC.ListItems.Clear
   End If
 
   If Not IsNull(oFactura.Registro.Fields("IdMoneda").Value) Then
      Me.IdMoneda = oFactura.Registro.Fields("IdMoneda").Value
   Else
      Me.IdMoneda = 0
   End If
   
   If mvarId = -1 Then
      With origen.Registro
         .Fields("OrigenDescripcion").Value = 1
         .Fields("IdUnidad").Value = mvarIdUnidad
      End With
      Option1.Value = True
      cmdItems_Click 0
   Else
      With origen.Registro
         If Not IsNull(.Fields("OrigenDescripcion").Value) Then
            Select Case .Fields("OrigenDescripcion").Value
               Case 1
                  Option1.Value = True
               Case 2
                  Option2.Value = True
               Case 3
                  Option3.Value = True
            End Select
         Else
            Option1.Value = True
         End If
         If Not IsNull(.Fields("TipoCancelacion").Value) Then
            Select Case .Fields("TipoCancelacion").Value
               Case 1
                  Option4.Value = True
               Case 2
                  Option5.Value = True
            End Select
         Else
            Option4.Value = True
         End If
         Set oRs = oAp.Articulos.TraerFiltrado("_PorId", .Fields("IdArticulo").Value)
         If oRs.RecordCount > 0 Then
            txtCodigoArticulo.Text = oRs.Fields("Codigo").Value
         End If
         oRs.Close
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
      If mvarId > 0 Then
         For Each oControl In Me.Controls
            If TypeOf oControl Is CommandButton Or TypeOf oControl Is DbListView Or _
                  TypeOf oControl Is DataCombo Or TypeOf oControl Is TextBox Or _
                  TypeOf oControl Is Frame Or TypeOf oControl Is CheckBox Then
               oControl.Enabled = False
            End If
         Next
         Frame1.Enabled = True
         cmd(0).Enabled = True
         cmd(1).Enabled = True
      End If
      MostrarColor
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing

   If BuscarClaveINI("Desactivar unidades en circuito de compras") = "SI" Then
      DataCombo1(0).Enabled = False
   End If
   
End Property

Public Property Get Factura() As ComPronto.Factura

   Set Factura = oFactura

End Property

Public Property Set Factura(ByVal vNewValue As ComPronto.Factura)

   Set oFactura = vNewValue

End Property

Private Sub cmdAnticipo_Click()

   CambiarPorAnticipo

End Sub

Private Sub cmdBorrarObservaciones_Click()

   rchObservaciones.Text = ""
   
End Sub

Private Sub cmdItems_Click(Index As Integer)

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim i As Integer
   Dim mIdDetalleRemito As Long
   
   Select Case Index
      Case 0
         If Not IsNull(oFactura.Registro.Fields("IdCliente").Value) Then
            Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_DetallesPendientesDeFacturarPorIdCliente", oFactura.Registro.Fields("IdCliente").Value)
            If oRs.RecordCount > 0 Then
               Set ListaOC.DataSource = oRs
               ListaOC.Refresh
               If mvarId < -1 Then
                  mIdDetalleOrdenCompra = 0
                  Set oRs1 = origen.DetFacturasOrdenesCompra.Registros
                  If oRs1.RecordCount > 0 Then
                     oRs1.MoveFirst
                     mIdDetalleOrdenCompra = oRs1.Fields("IdDetalleOrdenCompra").Value
                  End If
                  Set oRs1 = Nothing
                  If mIdDetalleOrdenCompra > 0 Then
                     For i = 1 To ListaOC.ListItems.Count
                        If ListaOC.ListItems(i).SubItems(1) = mIdDetalleOrdenCompra Then
                           ListaOC.ListItems(i).Checked = True
                           Exit For
                        End If
                     Next
                  End If
               End If
            End If
         End If
      Case 1
         If Not IsNull(oFactura.Registro.Fields("IdCliente").Value) Then
            ListaRM.ListItems.Clear
            Set oRs = Aplicacion.Remitos.TraerFiltrado("_DetallesPendientesDeFacturarPorIdCliente", oFactura.Registro.Fields("IdCliente").Value)
            If oRs.RecordCount > 0 Then
               Set ListaRM.DataSource = oRs
               ListaRM.Refresh
               If mvarId < -1 Then
                  mIdDetalleRemito = 0
                  Set oRs1 = origen.DetFacturasRemitos.Registros
                  If oRs1.RecordCount > 0 Then
                     oRs1.MoveFirst
                     Do While Not oRs1.EOF
                        mIdDetalleRemito = oRs1.Fields("IdDetalleRemito").Value
                        For i = 1 To ListaRM.ListItems.Count
                           If ListaRM.ListItems(i).SubItems(1) = mIdDetalleRemito Then
                              ListaRM.ListItems(i).Checked = True
                              Exit For
                           End If
                        Next
                        oRs1.MoveNext
                     Loop
                     oRs1.Close
                     Set oRs1 = Nothing
                  End If
               End If
            End If
         End If
      Case 2
         If Not IsNull(oFactura.Registro.Fields("IdCliente").Value) Then
            ListaRM.ListItems.Clear
            Set oRs = Aplicacion.Remitos.TraerFiltrado("_DetallesPendientesDeFacturarPorIdDetalleOrdenCompra", mIdDetalleOrdenCompra)
            If oRs.RecordCount > 0 Then
               Set ListaRM.DataSource = oRs
               ListaRM.Refresh
               If mvarId < -1 Then
                  mIdDetalleRemito = 0
                  Set oRs1 = origen.DetFacturasRemitos.Registros
                  If oRs1.RecordCount > 0 Then
                     oRs1.MoveFirst
                     Do While Not oRs1.EOF
                        mIdDetalleRemito = oRs1.Fields("IdDetalleRemito").Value
                        For i = 1 To ListaRM.ListItems.Count
                           If ListaRM.ListItems(i).SubItems(1) = mIdDetalleRemito Then
                              ListaRM.ListItems(i).Checked = True
                              Exit For
                           End If
                        Next
                        oRs1.MoveNext
                     Loop
                     oRs1.Close
                     Set oRs1 = Nothing
                  End If
               End If
            End If
         End If
   End Select

   Set oRs = Nothing
   
End Sub

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      If Index = 1 Then
         Dim oRs As ADOR.Recordset
         Dim mIdRubro As Long
         
         Set oRs = UnidadesHabilitadas(DataCombo1(1).BoundText)
         If oRs.RecordCount > 0 Then
            Set DataCombo1(0).RowSource = oRs
         Else
            Set DataCombo1(0).RowSource = Aplicacion.Unidades.TraerLista
         End If
         
         With origen.Registro
            .Fields("IdArticulo").Value = DataCombo1(Index).BoundText
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", .Fields("IdArticulo").Value)
            If oRs.RecordCount > 0 Then
               If IsNull(oRs.Fields("IdRubro").Value) Then
                  MsgBox "El producto no tiene asignado el rubro", vbExclamation
                  .Fields("IdArticulo").Value = Null
                  oRs.Close
                  Set oRs = Nothing
                  Exit Sub
               End If
               mIdRubro = oRs.Fields("IdRubro").Value
               txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
               .Fields("Costo").Value = IIf(IsNull(oRs.Fields("CostoPPP").Value), 0, oRs.Fields("CostoPPP").Value)
               If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                  .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
               End If
            End If
            oRs.Close
            Set oRs = Aplicacion.Rubros.TraerFiltrado("_PorId", mIdRubro)
            If oRs.RecordCount > 0 Then
               If IsNull(oRs.Fields("IdCuenta").Value) Then
                  MsgBox "El rubro de este producto no tiene cuenta contable", vbExclamation
                  .Fields("IdArticulo").Value = Null
                  oRs.Close
                  Set oRs = Nothing
                  Exit Sub
               End If
            End If
            oRs.Close
         End With
         Set oRs = Nothing
         If mvarId = -1 Then
            TraePrecio
         ElseIf mvarId < 0 Then
            txtPrecioUnitario.Enabled = True
         End If
      End If
   End If

End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)

'   SendKeys "%{DOWN}"

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

'   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}",True

End Sub

Private Sub DataCombo1_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Index = 1 Then
      If Button = vbRightButton Then
         If glbMenuPopUpCargado Then
            Dim cursorpos As POINTAPI
            GetCursorPos cursorpos
            TrackPopupMenu POP_hMenu, TPM_HORNEGANIMATION, cursorpos.X, cursorpos.Y, 0, Me.hwnd, ByVal 0&
            DoEvents
            If POP_Key > 0 Then
               DataCombo1(1).BoundText = POP_Key
            End If
         Else
            MsgBox "No se ha cargado el menu de materiales", vbInformation
         End If
      End If
   End If

End Sub

Private Sub DataCombo1_Validate(Index As Integer, Cancel As Boolean)

   Dim oRs As ADOR.Recordset
   Dim mAlicuotaIVA_Material As Double
         
   If IsNumeric(DataCombo1(1).BoundText) Then
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(1).BoundText)
      mAlicuotaIVA_Material = IIf(IsNull(oRs.Fields("AlicuotaIVA").Value), 0, oRs.Fields("AlicuotaIVA").Value)
      oRs.Close
      Set oRs = Nothing
      If mAlicuotaIVA_Material <> Me.AlicuotaIVA And Me.AlicuotaIVA <> -1 Then
         MsgBox "El material tiene una alicuota de iva de " & mAlicuotaIVA_Material & " % y" & vbCrLf & _
            "la alicuota activa es de " & Me.AlicuotaIVA & " %.", vbExclamation
         origen.Registro.Fields("IdArticulo").Value = Null
         Cancel = True
         Exit Sub
      End If
      Me.AlicuotaIVA = mAlicuotaIVA_Material
   End If
   
End Sub

Private Sub Form_Activate()

   CalculaImporte

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With ListaOC
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
      .CheckBoxes = True
   End With

   With ListaRM
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
      .CheckBoxes = True
   End With

   If glbMenuPopUpCargado Then ActivarPopUp Me
   
   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()
   
   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oFactura = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
   If glbMenuPopUpCargado Then DesactivarPopUp Me
   
End Sub

Private Sub ListaOC_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaOC_ItemCheck(ByVal Item As MSComctlLib.IListItem)

   If Item.Checked Then
      If OC_Elegida Then
         MsgBox "Ya eligio un item de orden de compra, desmarquelo primero", vbExclamation
         Item.Checked = False
      Else
         OC_Elegida = True
         If IsNumeric(Item.ListSubItems(1)) Then
            Dim oRs As ADOR.Recordset
            Dim mAlicuotaIVA_Material As Double, mvarPrecio As Double, mPorcB As Double
            
            mIdDetalleOrdenCompra = Item.ListSubItems(1)
            Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_DetallePorIdDetalle", mIdDetalleOrdenCompra)
            If oRs.RecordCount > 0 Then
               mAlicuotaIVA_Material = IIf(IsNull(oRs.Fields("AlicuotaIVA").Value), 0, oRs.Fields("AlicuotaIVA").Value)
               If mAlicuotaIVA_Material <> Me.AlicuotaIVA And Me.AlicuotaIVA <> -1 Then
                  MsgBox "El material tiene una alicuota de iva de " & mAlicuotaIVA_Material & " % y" & vbCrLf & _
                     "la alicuota activa es de " & Me.AlicuotaIVA & " %.", vbExclamation
                  oRs.Close
                  Set oRs = Nothing
                  origen.Registro.Fields("IdArticulo").Value = Null
                  Item.Checked = False
                  OC_Elegida = False
                  Exit Sub
               End If
               Me.AlicuotaIVA = mAlicuotaIVA_Material
               DataCombo1(0).BoundText = oRs.Fields("IdUnidad").Value
               DataCombo1(1).BoundText = oRs.Fields("IdArticulo").Value
               Me.PorcentajeBonificacionOC = IIf(IsNull(oRs.Fields("PorcentajeBonificacionOC").Value), 0, oRs.Fields("PorcentajeBonificacionOC").Value)
               With origen.Registro
                  mvarPrecio = IIf(IsNull(oRs.Fields("Precio").Value), 0, oRs.Fields("Precio").Value)
                  mPorcB = IIf(IsNull(oRs.Fields("PorcentajeBonificacion").Value), 0, oRs.Fields("PorcentajeBonificacion").Value)
                  If mvarTipoABC = "B" And mvarTipoIVA <> 8 And _
                        BuscarClaveINI("Ordenes de compra iva incluido") <> "SI" Then
                     mvarPrecio = mvarPrecio + Round(mvarPrecio * mAlicuotaIVA_Material / 100, 2)
                  End If
                  .Fields("PrecioUnitario").Value = mvarPrecio
                  .Fields("PrecioUnitarioTotal").Value = mvarPrecio
                  .Fields("Bonificacion").Value = mPorcB
                  .Fields("OrigenDescripcion").Value = oRs.Fields("OrigenDescripcion").Value
                  .Fields("TipoCancelacion").Value = oRs.Fields("TipoCancelacion").Value
                  .Fields("Costo").Value = oRs.Fields("CostoPPP").Value
                  If Not IsNull(oRs.Fields("OrigenDescripcion").Value) Then
                     Select Case oRs.Fields("OrigenDescripcion").Value
                        Case 1
                           Option1.Value = True
                        Case 2
                           Option2.Value = True
                        Case 3
                           Option3.Value = True
                     End Select
                  Else
                     Option1.Value = True
                  End If
                  If oRs.Fields("TipoCancelacion").Value = 1 Then
                     Option4.Value = True
                     With Check1
                        .Value = 0
                        .Enabled = False
                     End With
                  Else
                     Option5.Value = True
                     With Check1
                        If BuscarClaveINI("Desactivar calculo de % de certificacion en item de factura de venta") = "SI" Then
                           .Value = 0
                        Else
                           .Value = 1
                        End If
                        .Enabled = True
                     End With
                  End If
                  If IsNumeric(Item.ListSubItems(12)) Then
                     If Option4.Value Then
                        .Fields("Cantidad").Value = Item.ListSubItems(12)
                        .Fields("PorcentajeCertificacion").Value = 0
                     Else
                        .Fields("Cantidad").Value = oRs.Fields("Cantidad").Value
                        If Not BuscarClaveINI("Desactivar calculo de % de certificacion en item de factura de venta") = "SI" Then
                           .Fields("PorcentajeCertificacion").Value = Item.ListSubItems(12)
                        End If
                     End If
                  End If
                  .Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
                  rchObservaciones.TextRTF = oRs.Fields("Observaciones").Value
               End With
               Me.IdCondicionVenta = oRs.Fields("IdCondicionVenta").Value
               Me.IdMoneda = oRs.Fields("IdMoneda").Value
               Me.IdObra = oRs.Fields("IdObra").Value
               oFactura.Registro.Fields("IdListaPrecios").Value = oRs.Fields("IdListaPrecios").Value
               lblColor.Caption = IIf(IsNull(oRs.Fields("Color").Value), "", oRs.Fields("Color").Value)
            End If
            oRs.Close
            Set oRs = Nothing
            CalculaImporte
         End If
      End If
   Else
      If OC_Elegida Then
         OC_Elegida = False
      End If
   End If
   
End Sub

Private Sub ListaRM_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      origen.Registro.Fields("OrigenDescripcion").Value = 1
   End If
   
End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      origen.Registro.Fields("OrigenDescripcion").Value = 2
   End If
   
End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      origen.Registro.Fields("OrigenDescripcion").Value = 3
   End If
   
End Sub

Private Sub txtBonificacion_Change()

   CalculaImporte

End Sub

Private Sub txtBonificacion_GotFocus()
   
   With txtBonificacion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBonificacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Get Cotizacion() As Double

   Cotizacion = mvarCotizacion
   
End Property

Public Property Let Cotizacion(ByVal vNewValue As Double)

   mvarCotizacion = vNewValue
   
End Property

Public Property Let EsMuestra(ByVal vNewValue As String)

   mvarEsMuestra = vNewValue
   
End Property

Public Property Let TipoIVA(ByVal vNewValue As Integer)

   mvarTipoIVA = vNewValue
   
End Property

Private Function CalculaImporte()

   Dim mCantidad As Double, mPrecioUnitario As Double, mPrecioUnitarioTotal As Double
   Dim mBonificacion As Double, mPorcentajeCertificacion As Double
   
   If Not IsNull(origen.Registro.Fields("PrecioUnitarioTotal").Value) Then
      mPrecioUnitarioTotal = origen.Registro.Fields("PrecioUnitarioTotal").Value
   Else
      mPrecioUnitarioTotal = IIf(IsNull(origen.Registro.Fields("PrecioUnitario").Value), 0, origen.Registro.Fields("PrecioUnitario").Value)
   End If
   mCantidad = Val(txtCantidad.Text)
   mPrecioUnitario = Val(txtPrecioUnitario.Text)
   mBonificacion = Val(txtBonificacion.Text)
   mPorcentajeCertificacion = Val(txtPorcentajeCertificacion.Text)
   
   If Option5.Value Then
      If Check1.Enabled And Check1.Value = 0 Then
         If mPrecioUnitarioTotal <> 0 Then
            If Not BuscarClaveINI("Desactivar calculo de % de certificacion en item de factura de venta") = "SI" And mvarId = -1 Then
               mPorcentajeCertificacion = mPrecioUnitario / mPrecioUnitarioTotal * 100
               origen.Registro.Fields("PorcentajeCertificacion").Value = mPorcentajeCertificacion
            End If
         End If
      Else
         If mPorcentajeCertificacion <> 0 Then
            mPrecioUnitario = mPrecioUnitarioTotal * mPorcentajeCertificacion / 100
         End If
         origen.Registro.Fields("PrecioUnitario").Value = mPrecioUnitario
      End If
   End If
   
   txtImporte.Text = Format((mCantidad * mPrecioUnitario) * (1 - (mBonificacion / 100)), "Fixed")
   
End Function

Private Sub txtBusca_GotFocus()

   With txtBusca
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBusca_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      If KeyAscii = 13 Then
         Dim oRs As ADOR.Recordset
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set oRs = Aplicacion.Articulos.TraerLista
         End If
         Set DataCombo1(1).RowSource = oRs
         If oRs.RecordCount > 0 Then
            DataCombo1(1).BoundText = oRs.Fields(0).Value
         End If
         Set oRs = Nothing
      End If
      DataCombo1(1).SetFocus
      SendKeys "%{DOWN}"
   End If

End Sub

Private Sub txtCantidad_Change()

   CalculaImporte

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
      Dim mAlicuotaIVA_Material As Double
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo.Text)
      If oRs.RecordCount > 0 Then
         mAlicuotaIVA_Material = IIf(IsNull(oRs.Fields("AlicuotaIVA").Value), 0, oRs.Fields("AlicuotaIVA").Value)
         If mAlicuotaIVA_Material <> Me.AlicuotaIVA And Me.AlicuotaIVA <> -1 Then
            MsgBox "El material tiene una alicuota de iva de " & mAlicuotaIVA_Material & " % y" & vbCrLf & _
               "la alicuota activa es de " & Me.AlicuotaIVA & " %.", vbExclamation
            origen.Registro.Fields("IdArticulo").Value = Null
            oRs.Close
            Set oRs = Nothing
            Cancel = True
            Exit Sub
         End If
         Me.AlicuotaIVA = mAlicuotaIVA_Material
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

Private Sub txtCosto_GotFocus()
   
   With txtCosto
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCosto_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPorcentajeCertificacion_Change()

   CalculaImporte

End Sub

Private Sub txtPorcentajeCertificacion_GotFocus()

   With txtPorcentajeCertificacion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPorcentajeCertificacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPrecioUnitario_GotFocus()
   
   With txtPrecioUnitario
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPrecioUnitario_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPrecioUnitario_LostFocus()

   CalculaImporte

End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Public Sub TraePrecio()

'   If mvarEsMuestra = "SI" Then
'      Exit Sub
'   End If
   
   Dim mvarPartes As String
   Dim mvarIVA As Double
   Dim mvarVector
   
   'mvarPartes = TraerPrecios(Me.Factura.Registro.Fields("IdCliente").Value, DataCombo1(0).BoundText)
'   If Len(mvarPartes) = 0 Then
'      mvarPartes = TraerPrecios(0, DataCombo1(0).BoundText)
'   End If
   
   With origen.Registro
'      If Len(mvarPartes) > 0 Then
'         mvarVector = VBA.Split(mvarPartes, "|")
'         .Fields("PrecioUnitario").Value = CDbl(mvarVector(2))
'         .Fields("ParteDolar").Value = CDbl(mvarVector(0))
'         .Fields("PartePesos").Value = CDbl(mvarVector(1))
'         If mvarTipoIVA = 4 Or mvarTipoIVA = 6 Or mvarTipoIVA = 7 Or mvarTipoIVA = 8 Then
'            .Fields("PrecioUnitario").Value = .Fields("PrecioUnitario").Value + _
'                     Round(.Fields("PrecioUnitario").Value * mvarP_IVA1 / 100, mvarDecimales)
'            .Fields("PartePesos").Value = .Fields("PartePesos").Value + _
'                     Round((.Fields("PartePesos").Value + (.Fields("ParteDolar").Value * mvarCotizacion)) * mvarP_IVA1 / 100, mvarDecimales)
'            If mvarTipoIVA = 7 Then
'               .Fields("PrecioUnitario").Value = .Fields("PrecioUnitario").Value + _
'                        Round(.Fields("PrecioUnitario").Value * mvarP_IVA2 / 100, mvarDecimales)
'               .Fields("PartePesos").Value = .Fields("PartePesos").Value + _
'                        Round((.Fields("PartePesos").Value + (.Fields("ParteDolar").Value * mvarCotizacion)) * mvarP_IVA2 / 100, mvarDecimales)
'            End If
'         End If
'      Else
         .Fields("PrecioUnitario").Value = 0
         .Fields("ParteDolar").Value = 0
         .Fields("PartePesos").Value = 0
'      End If
      If .Fields("PrecioUnitario").Value <> 0 Then
         txtPrecioUnitario.Enabled = False
      Else
         txtPrecioUnitario.Enabled = True
      End If
   End With
   
   CalculaImporte
   
End Sub

Public Property Get IdCondicionVenta() As Long

   IdCondicionVenta = mIdCondicionVenta
   
End Property

Public Property Let IdCondicionVenta(ByVal vNewValue As Long)

   mIdCondicionVenta = vNewValue
   
End Property

Public Property Get AlicuotaIVA() As Double

   AlicuotaIVA = mAlicuotaIVA
   
End Property

Public Property Let AlicuotaIVA(ByVal vNewValue As Double)

   mAlicuotaIVA = vNewValue
   
End Property

Public Property Get IdMoneda() As Long

   IdMoneda = mIdMoneda
   
End Property

Public Property Let IdMoneda(ByVal vNewValue As Long)

   mIdMoneda = vNewValue
   
End Property

Public Property Get TipoABC() As String

   TipoABC = mvarTipoABC
   
End Property

Public Property Let TipoABC(ByVal vNewValue As String)

   mvarTipoABC = vNewValue
   
End Property

Public Property Get IdObra() As Long

   IdObra = mvarIdObra
   
End Property

Public Property Let IdObra(ByVal vNewValue As Long)

   mvarIdObra = vNewValue
   
End Property

Public Property Get PorcentajeBonificacionOC() As Single

   PorcentajeBonificacionOC = mvarPorcentajeBonificacionOC
   
End Property

Public Property Let PorcentajeBonificacionOC(ByVal vNewValue As Single)

   mvarPorcentajeBonificacionOC = vNewValue
   
End Property

Public Sub CambiarPorAnticipo()

   Dim oRs As ADOR.Recordset
   Dim mEsta As Boolean, mOk As Boolean
   Dim mIdArticulo As Long
   Dim oF As frm_Aux
   
   If mvarIdRubroAnticipos <> 0 Then
      Set oF = New frm_Aux
      With oF
         .Text1.Visible = False
         With .Label1
            .Caption = "Articulo :"
            .Width = .Width / 2
         End With
         With .dcfields(0)
            .Top = oF.Text1.Top
            .Left = oF.Label1.Left + oF.Label1.Width + 20
            .Width = .Width * 2
            .BoundColumn = "IdArticulo"
            Set .RowSource = Aplicacion.Articulos.TraerFiltrado("_PorIdRubroParaCombo", mvarIdRubroAnticipos)
            .Visible = True
         End With
         .Show vbModal, Me
         mOk = .Ok
         mIdArticulo = 0
         If IsNumeric(.dcfields(0).BoundText) Then mIdArticulo = .dcfields(0).BoundText
      End With
      Unload oF
      Set oF = Nothing
      If Not mOk Or mIdArticulo = 0 Then Exit Sub
         
      With origen
         .Registro.Fields("IdArticulo").Value = mIdArticulo
         .Modificado = True
      End With
   End If

End Sub

Public Sub MostrarColor()

   lblColor.Caption = origen.Color

End Sub
