VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmRecepcionesSAT 
   Caption         =   "Recepcion de materiales en PRONTO SAT"
   ClientHeight    =   6900
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11460
   LinkTopic       =   "Form1"
   ScaleHeight     =   6900
   ScaleWidth      =   11460
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtNumeroRecepcion2 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroRecepcion2"
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
      Left            =   2475
      TabIndex        =   13
      Top             =   45
      Width           =   1140
   End
   Begin VB.TextBox txtNumeroPedido 
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
      Height          =   315
      Left            =   1710
      TabIndex        =   12
      Top             =   420
      Width           =   1185
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   420
      Index           =   0
      Left            =   90
      TabIndex        =   11
      Top             =   6435
      Width           =   1200
   End
   Begin VB.TextBox txtNumeroRecepcion1 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroRecepcion1"
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
      TabIndex        =   10
      Top             =   45
      Width           =   735
   End
   Begin VB.TextBox txtNumeroRequerimiento 
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
      Height          =   315
      Left            =   1710
      TabIndex        =   9
      Top             =   765
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.TextBox txtNumeroRecepcionAlmacen 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroRecepcionAlmacen"
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
      Left            =   10125
      TabIndex        =   8
      Top             =   90
      Width           =   1185
   End
   Begin VB.TextBox txtFechaPedido 
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
      Height          =   315
      Left            =   4860
      TabIndex        =   7
      Top             =   450
      Width           =   1275
   End
   Begin VB.TextBox txtFechaRM 
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
      Height          =   315
      Left            =   4860
      TabIndex        =   6
      Top             =   765
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.TextBox txtSubnumero 
      DataField       =   "SubNumero"
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
      Left            =   3780
      TabIndex        =   5
      Top             =   45
      Width           =   330
   End
   Begin VB.TextBox txtSubNumeroPedido 
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
      Height          =   315
      Left            =   3060
      TabIndex        =   4
      Top             =   405
      Width           =   330
   End
   Begin VB.TextBox txtImpuestosInternos 
      Alignment       =   2  'Center
      DataField       =   "ImpuestosInternos"
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
      Height          =   315
      Left            =   1890
      TabIndex        =   3
      Top             =   6075
      Width           =   1275
   End
   Begin VB.TextBox txtPercepcionIIBB 
      Alignment       =   2  'Center
      DataField       =   "PercepcionIIBB"
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
      Height          =   315
      Left            =   4905
      TabIndex        =   2
      Top             =   6075
      Width           =   1275
   End
   Begin VB.TextBox txtPercepcionIVA 
      Alignment       =   2  'Center
      DataField       =   "PercepcionIVA"
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
      Height          =   315
      Left            =   7830
      TabIndex        =   1
      Top             =   6075
      Width           =   1275
   End
   Begin VB.TextBox txtImporteIVA 
      Alignment       =   2  'Center
      DataField       =   "ImporteIVA"
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
      Height          =   315
      Left            =   10080
      TabIndex        =   0
      Top             =   6075
      Width           =   1275
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1005
      Left            =   7155
      TabIndex        =   14
      Top             =   450
      Width           =   4200
      _ExtentX        =   7408
      _ExtentY        =   1773
      _Version        =   393217
      Enabled         =   0   'False
      ScrollBars      =   2
      TextRTF         =   $"frmRecepcionesSAT.frx":0000
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   10755
      Top             =   6435
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
            Picture         =   "frmRecepcionesSAT.frx":0082
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRecepcionesSAT.frx":0194
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRecepcionesSAT.frx":05E6
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRecepcionesSAT.frx":0A38
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaRecepcion"
      Height          =   330
      Index           =   0
      Left            =   4860
      TabIndex        =   15
      Top             =   45
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Enabled         =   0   'False
      Format          =   64815105
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   0
      Left            =   1710
      TabIndex        =   16
      Tag             =   "Proveedores"
      Top             =   1125
      Width           =   4470
      _ExtentX        =   7885
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3570
      Left            =   45
      TabIndex        =   17
      Top             =   1845
      Width           =   11355
      _ExtentX        =   20029
      _ExtentY        =   6297
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmRecepcionesSAT.frx":0E8A
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdTransportista"
      Height          =   315
      Index           =   2
      Left            =   1710
      TabIndex        =   18
      Tag             =   "Transportistas"
      Top             =   1485
      Width           =   1995
      _ExtentX        =   3519
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdTransportista"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Realizo"
      Height          =   315
      Index           =   1
      Left            =   7170
      TabIndex        =   19
      Tag             =   "Empleados"
      Top             =   1470
      Width           =   1725
      _ExtentX        =   3043
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservacionesItem 
      Height          =   285
      Left            =   9495
      TabIndex        =   20
      Top             =   -90
      Visible         =   0   'False
      Width           =   195
      _ExtentX        =   344
      _ExtentY        =   503
      _Version        =   393217
      TextRTF         =   $"frmRecepcionesSAT.frx":0EA6
   End
   Begin RichTextLib.RichTextBox rchObservacionesItemVisible 
      Height          =   600
      Left            =   1890
      TabIndex        =   21
      Top             =   5445
      Width           =   9510
      _ExtentX        =   16775
      _ExtentY        =   1058
      _Version        =   393217
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmRecepcionesSAT.frx":0F28
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Libero"
      Height          =   315
      Index           =   3
      Left            =   9585
      TabIndex        =   22
      Tag             =   "Empleados"
      Top             =   1470
      Visible         =   0   'False
      Width           =   1785
      _ExtentX        =   3149
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdComprador"
      Height          =   315
      Index           =   4
      Left            =   4680
      TabIndex        =   23
      Tag             =   "Empleados"
      Top             =   1485
      Visible         =   0   'False
      Width           =   1500
      _ExtentX        =   2646
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de pedido :"
      Height          =   240
      Index           =   1
      Left            =   90
      TabIndex        =   42
      Top             =   450
      Width           =   1560
   End
   Begin VB.Label lblData 
      Caption         =   "Proveedor :"
      Height          =   240
      Index           =   0
      Left            =   90
      TabIndex        =   41
      Top             =   1170
      Width           =   1560
   End
   Begin VB.Label lblLabels 
      Caption         =   "Remito de recepcion :"
      Height          =   240
      Index           =   14
      Left            =   90
      TabIndex        =   40
      Top             =   90
      Width           =   1560
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha :"
      Height          =   285
      Index           =   4
      Left            =   4275
      TabIndex        =   39
      Top             =   90
      Width           =   540
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Obs. :"
      Height          =   255
      Index           =   0
      Left            =   6300
      TabIndex        =   38
      Top             =   495
      Width           =   780
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha pedido :"
      Height          =   285
      Index           =   2
      Left            =   3735
      TabIndex        =   37
      Top             =   450
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha RM :"
      Height          =   240
      Index           =   3
      Left            =   3735
      TabIndex        =   36
      Top             =   810
      Visible         =   0   'False
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de RM :"
      Height          =   240
      Index           =   5
      Left            =   90
      TabIndex        =   35
      Top             =   810
      Visible         =   0   'False
      Width           =   1560
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Numero recepcion :"
      Height          =   240
      Index           =   6
      Left            =   8505
      TabIndex        =   34
      Top             =   135
      Width           =   1530
   End
   Begin VB.Label lblData 
      Caption         =   "Transportista :"
      Height          =   240
      Index           =   2
      Left            =   90
      TabIndex        =   33
      Top             =   1530
      Width           =   1560
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Emitio : "
      Height          =   240
      Index           =   1
      Left            =   6300
      TabIndex        =   32
      Top             =   1485
      Width           =   780
   End
   Begin VB.Line Line1 
      BorderWidth     =   3
      X1              =   3735
      X2              =   3645
      Y1              =   45
      Y2              =   360
   End
   Begin VB.Line Line2 
      BorderWidth     =   3
      X1              =   3015
      X2              =   2925
      Y1              =   405
      Y2              =   720
   End
   Begin VB.Label lblEstado 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   6255
      TabIndex        =   31
      Top             =   0
      Visible         =   0   'False
      Width           =   1980
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones del item seleccionado :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   420
      Index           =   20
      Left            =   90
      TabIndex        =   30
      Top             =   5490
      Width           =   1725
   End
   Begin VB.Label lblLabels 
      Caption         =   "Impuestos internos :"
      Height          =   240
      Index           =   7
      Left            =   135
      TabIndex        =   29
      Top             =   6120
      Width           =   1710
   End
   Begin VB.Label lblLabels 
      Caption         =   "Percepcion IIBB :"
      Height          =   240
      Index           =   11
      Left            =   3465
      TabIndex        =   28
      Top             =   6120
      Width           =   1305
   End
   Begin VB.Label lblLabels 
      Caption         =   "Percepcion IVA :"
      Height          =   240
      Index           =   12
      Left            =   6435
      TabIndex        =   27
      Top             =   6120
      Width           =   1260
   End
   Begin VB.Label lblLabels 
      Caption         =   "IVA :"
      Height          =   240
      Index           =   13
      Left            =   9405
      TabIndex        =   26
      Top             =   6120
      Width           =   540
   End
   Begin VB.Label lblData 
      Caption         =   "Libero : "
      Height          =   315
      Index           =   3
      Left            =   8955
      TabIndex        =   25
      Top             =   1485
      Visible         =   0   'False
      Width           =   570
   End
   Begin VB.Label lblData 
      Caption         =   "Comprador :"
      Height          =   240
      Index           =   4
      Left            =   3735
      TabIndex        =   24
      Top             =   1530
      Visible         =   0   'False
      Width           =   900
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Ver item"
         Index           =   0
      End
   End
End
Attribute VB_Name = "frmRecepcionesSAT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.RecepcionSAT
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mIdAprobo As Long
Private mvarModificado As Boolean, mvarGrabado As Boolean
Private mvarImpresionHabilitada As Boolean
Private mvarAnulada As String, mvarPermitirDistintosPedidos As String
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

Sub Editar(ByVal Cual As Long)

   Dim oF As frmDetRecepcionesSAT
   Set oF = New frmDetRecepcionesSAT
   With oF
      Set .RecepcionSAT = origen
      .Id = Cual
      .Show vbModal, Me
   End With
   Unload oF
   Set oF = Nothing
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Unload Me
   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oDet As DetRecepcionSAT
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   Dim dc As DataCombo
   Dim ListaVacia As Boolean
   Dim mNumeroRecepcionAlmacen As Long
   
   mvarId = vnewvalue
   
   mvarModificado = False
   ListaVacia = False
   mvarImpresionHabilitada = True
   
   Set oAp = Aplicacion
   
   Set origen = oAp.RecepcionesSAT.Item(vnewvalue)
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetRecepcionesSAT.TraerMascara
                     ListaVacia = True
                  Else
                     Set oRs = origen.DetRecepcionesSAT.TraerTodos
                     If Not oRs Is Nothing Then
                        If oRs.RecordCount <> 0 Then
                           Set oControl.DataSource = oRs
                           oRs.MoveFirst
                           Do While Not oRs.EOF
                              Set oDet = origen.DetRecepcionesSAT.Item(oRs.Fields(0).Value)
                              oDet.Modificado = True
                              Set oDet = Nothing
                              oRs.MoveNext
                           Loop
                           ListaVacia = False
                        Else
                           Set oControl.DataSource = origen.DetRecepcionesSAT.TraerMascara
                           ListaVacia = True
                        End If
                        oRs.Close
                     End If
                  End If
            End Select
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Proveedores" Then
                  Set oControl.RowSource = oAp.Proveedores.TraerFiltrado("_NormalesYEventualesParaCombo")
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   End With
   
   If mvarId = -1 Then
   Else
      With origen.Registro
         If Not IsNull(.Fields("IdPedido").Value) Then
            Set oRs = Aplicacion.Pedidos.Item(.Fields("IdPedido").Value).Registro
            If oRs.RecordCount > 0 Then
               txtNumeroPedido.Text = oRs.Fields("NumeroPedido").Value
               txtSubNumeroPedido.Text = oRs.Fields("SubNumero").Value
               txtFechaPedido.Text = oRs.Fields("FechaPedido").Value
            End If
            oRs.Close
         ElseIf Not IsNull(.Fields("IdRequerimiento").Value) Then
            Set oRs = Aplicacion.Requerimientos.Item(.Fields("IdRequerimiento").Value).Registro
            If oRs.RecordCount > 0 Then
               txtNumeroRequerimiento.Text = oRs.Fields("NumeroRequerimiento").Value
               txtFechaRM.Text = oRs.Fields("FechaRequerimiento").Value
            End If
            oRs.Close
         End If
         If .Fields("Anulada").Value = "SI" Then
            mvarAnulada = "SI"
            lblEstado.Visible = True
            lblEstado.Caption = "ANULADA"
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
         mIdAprobo = IIf(IsNull(.Fields("Aprobo").Value), 0, .Fields("Aprobo").Value)
      End With
      mvarGrabado = True
   End If
   
   If ListaVacia Then
      Lista.ListItems.Clear
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
End Property

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Lista_DblClick()

   If Lista.ListItems.Count = 0 Then
   Else
      Editar Lista.SelectedItem.Tag
   End If

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_ItemClick(ByVal Item As MSComctlLib.IListItem)

   rchObservacionesItemVisible.TextRTF = ""
   If Not Item Is Nothing Then
      If IsNumeric(Item.Tag) Then
         If Not IsNull(origen.DetRecepcionesSAT.Item(Item.Tag).Registro.Fields("Observaciones").Value) Then
            rchObservacionesItemVisible.TextRTF = origen.DetRecepcionesSAT.Item(Item.Tag).Registro.Fields("Observaciones").Value
         End If
      End If
   End If

End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeySpace Then
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

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar Lista.SelectedItem.Tag
   End Select

End Sub

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub PideAutorizacion()

   Dim oF As frmAutorizacion1
   Set oF = New frmAutorizacion1
   With oF
      .IdUsuario = dcfields(3).BoundText
      .Show vbModal, Me
   End With
   If Not oF.Ok Then
      With origen.Registro
         .Fields(dcfields(3).DataField).Value = Null
         .Fields("FechaLiberacion").Value = Null
      End With
      mIdAprobo = 0
   Else
      With origen.Registro
         .Fields("FechaLiberacion").Value = Now
         mIdAprobo = .Fields("Libero").Value
      End With
   End If
   Unload oF
   Set oF = Nothing

End Sub
