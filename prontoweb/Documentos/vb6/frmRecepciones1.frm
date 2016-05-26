VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmRecepciones1 
   Caption         =   "Recepcion de materiales"
   ClientHeight    =   7305
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11475
   LinkTopic       =   "Form1"
   ScaleHeight     =   7305
   ScaleWidth      =   11475
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Buscar Salida"
      Height          =   420
      Index           =   5
      Left            =   7605
      TabIndex        =   40
      Top             =   6480
      Width           =   1200
   End
   Begin VB.Frame Frame1 
      Caption         =   "Tipo de origen : "
      Height          =   735
      Left            =   90
      TabIndex        =   35
      Top             =   135
      Width           =   3345
      Begin VB.OptionButton Option2 
         Caption         =   "Otras obras / internas"
         Height          =   195
         Left            =   990
         TabIndex        =   37
         Top             =   450
         Width           =   1860
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Proveedor"
         Height          =   195
         Left            =   990
         TabIndex        =   36
         Top             =   225
         Width           =   1320
      End
   End
   Begin VB.TextBox txtNumeroRecepcion2 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroRecepcion2"
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
      Left            =   6120
      TabIndex        =   13
      Top             =   540
      Width           =   1140
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   420
      Index           =   1
      Left            =   1305
      TabIndex        =   12
      Top             =   6480
      Width           =   1200
   End
   Begin VB.TextBox txtNumeroPedido 
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
      Height          =   315
      Left            =   1710
      TabIndex        =   11
      Top             =   960
      Width           =   1185
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   45
      TabIndex        =   10
      Top             =   6480
      Width           =   1200
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Buscar pedido"
      Height          =   420
      Index           =   2
      Left            =   6345
      TabIndex        =   9
      Top             =   6480
      Width           =   1200
   End
   Begin VB.TextBox txtNumeroRecepcion1 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroRecepcion1"
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
      Left            =   5355
      TabIndex        =   8
      Top             =   540
      Width           =   735
   End
   Begin VB.TextBox txtNumeroRecepcionAlmacen 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroRecepcionAlmacen"
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
      Left            =   9990
      TabIndex        =   7
      Top             =   540
      Width           =   1050
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
      Left            =   7155
      TabIndex        =   6
      Top             =   1350
      Width           =   2070
   End
   Begin VB.TextBox txtFechaPedido 
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
      Height          =   315
      Left            =   4860
      TabIndex        =   5
      Top             =   990
      Width           =   1275
   End
   Begin VB.TextBox txtSubnumero 
      DataField       =   "SubNumero"
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
      Left            =   7425
      TabIndex        =   4
      Top             =   540
      Width           =   330
   End
   Begin VB.TextBox txtSubNumeroPedido 
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
      Height          =   345
      Left            =   3105
      TabIndex        =   3
      Top             =   945
      Width           =   330
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   1
      Left            =   5085
      Picture         =   "frmRecepciones1.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   6480
      Width           =   1200
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   0
      Left            =   3825
      Picture         =   "frmRecepciones1.frx":058A
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   6480
      UseMaskColor    =   -1  'True
      Width           =   1200
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Anulacion"
      CausesValidation=   0   'False
      Height          =   420
      Index           =   4
      Left            =   2565
      TabIndex        =   0
      Top             =   6480
      Width           =   1200
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   735
      Left            =   6840
      TabIndex        =   14
      Top             =   1710
      Width           =   4560
      _ExtentX        =   8043
      _ExtentY        =   1296
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmRecepciones1.frx":0BF4
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   15
      Top             =   7020
      Width           =   11475
      _ExtentX        =   20241
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaRecepcion"
      Height          =   330
      Index           =   0
      Left            =   8820
      TabIndex        =   16
      Top             =   45
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   59244545
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   0
      Left            =   1710
      TabIndex        =   17
      Tag             =   "Proveedores"
      Top             =   1350
      Width           =   4470
      _ExtentX        =   7885
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3210
      Left            =   45
      TabIndex        =   18
      Top             =   2520
      Width           =   11355
      _ExtentX        =   20029
      _ExtentY        =   5662
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmRecepciones1.frx":0C76
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdTransportista"
      Height          =   315
      Index           =   2
      Left            =   1710
      TabIndex        =   19
      Tag             =   "Transportistas"
      Top             =   1755
      Width           =   4470
      _ExtentX        =   7885
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTransportista"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Realizo"
      Height          =   315
      Index           =   1
      Left            =   1710
      TabIndex        =   20
      Tag             =   "Empleados"
      Top             =   2145
      Width           =   1995
      _ExtentX        =   3519
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservacionesItem 
      Height          =   285
      Left            =   1710
      TabIndex        =   21
      Top             =   6030
      Visible         =   0   'False
      Width           =   195
      _ExtentX        =   344
      _ExtentY        =   503
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmRecepciones1.frx":0C92
   End
   Begin RichTextLib.RichTextBox rchObservacionesItemVisible 
      Height          =   600
      Left            =   1890
      TabIndex        =   22
      Top             =   5805
      Width           =   9510
      _ExtentX        =   16775
      _ExtentY        =   1058
      _Version        =   393217
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmRecepciones1.frx":0D14
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   3
      Left            =   4365
      TabIndex        =   38
      Tag             =   "Obras"
      Top             =   90
      Width           =   3435
      _ExtentX        =   6059
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   45
      Top             =   2385
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
            Picture         =   "frmRecepciones1.frx":0D96
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRecepciones1.frx":0EA8
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRecepciones1.frx":12FA
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRecepciones1.frx":174C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin VB.Label lblData 
      Caption         =   "Obra :"
      Height          =   240
      Index           =   3
      Left            =   3735
      TabIndex        =   39
      Top             =   135
      Width           =   525
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
      Left            =   45
      TabIndex        =   23
      Top             =   5805
      Width           =   1725
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de pedido :"
      Height          =   240
      Index           =   1
      Left            =   90
      TabIndex        =   34
      Top             =   990
      Width           =   1560
   End
   Begin VB.Label lblData 
      Caption         =   "Proveedor :"
      Height          =   240
      Index           =   0
      Left            =   90
      TabIndex        =   33
      Top             =   1395
      Width           =   1560
   End
   Begin VB.Label lblLabels 
      Caption         =   "Remito de recepcion :"
      Height          =   240
      Index           =   14
      Left            =   3735
      TabIndex        =   32
      Top             =   585
      Width           =   1560
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha :"
      Height          =   285
      Index           =   4
      Left            =   8235
      TabIndex        =   31
      Top             =   90
      Width           =   540
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Obs. :"
      Height          =   255
      Index           =   0
      Left            =   6300
      TabIndex        =   30
      Top             =   1755
      Width           =   465
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha pedido :"
      Height          =   285
      Index           =   2
      Left            =   3735
      TabIndex        =   29
      Top             =   990
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro.interno recepcion :"
      Height          =   240
      Index           =   6
      Left            =   8280
      TabIndex        =   28
      Top             =   585
      Width           =   1665
   End
   Begin VB.Label lblData 
      Caption         =   "Transportista :"
      Height          =   240
      Index           =   2
      Left            =   90
      TabIndex        =   27
      Top             =   1800
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
      Left            =   6300
      TabIndex        =   26
      Top             =   1395
      Width           =   780
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Emitio : "
      Height          =   240
      Index           =   1
      Left            =   90
      TabIndex        =   25
      Top             =   2205
      Width           =   1560
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   3
      X1              =   7380
      X2              =   7290
      Y1              =   540
      Y2              =   855
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   3
      X1              =   3015
      X2              =   2925
      Y1              =   945
      Y2              =   1260
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
      Left            =   9405
      TabIndex        =   24
      Top             =   1305
      Visible         =   0   'False
      Width           =   1980
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
      Begin VB.Menu MnuDetA 
         Caption         =   "Duplicar item"
         Index           =   3
      End
   End
End
Attribute VB_Name = "frmRecepciones1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Recepcion
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mIdAprobo As Long, mIdObraDefault As Long
Private mvarModificado As Boolean, mvarGrabado As Boolean, mvarTransportistaConEquipos As Boolean
Private mvarImpresionHabilitada As Boolean, mvarProveedorTransportista As Boolean
Private mvarRecepcionDesdeSalida As Boolean
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

'   If mvarId > 0 Then
'      MsgBox "No puede modificar los items de una recepcion ya registrada!", vbExclamation
'      Exit Sub
'   End If
   
   Dim oF As frmDetRecepciones1
   Dim oL As ListItem
   
   Set oF = New frmDetRecepciones1
   
   With oF
      Set .Recepcion = origen
      .RecepcionDesdeSalida = mvarRecepcionDesdeSalida
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         mvarModificado = True
         If Cual = -1 Then
            Set oL = Lista.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = Lista.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtNumeroPedido
            .SubItems(1) = "" & oF.txtNumeroItemPedido.Text
            .SubItems(2) = "" & oF.txtNumeroRequerimiento.Text
            .SubItems(3) = "" & oF.txtNumeroItemRequerimiento.Text
            .SubItems(6) = "" & oF.DataCombo1(3).Text
            .SubItems(7) = "" & oF.txtCantidad.Text
            .SubItems(8) = "" & oF.txtCantidad1.Text
            .SubItems(9) = "" & oF.txtCantidad2.Text
            .SubItems(10) = "" & Aplicacion.Unidades.TraerFiltrado("_PorId", oF.DataCombo1(0).BoundText).Fields("Abreviatura").Value
            .SubItems(11) = "" & Aplicacion.StockPorIdArticulo(oF.DataCombo1(1).BoundText)
            .SubItems(12) = "" & oF.txtRequerido.Text
            .SubItems(13) = "" & (Val(oF.txtCantidad.Text) + Val(oF.txtRecibido.Text))
            .SubItems(14) = "" & oF.txtCodigoArticulo.Text
            .SubItems(15) = "" & oF.DataCombo1(1).Text
            .SubItems(22) = "" & oF.DataCombo1(2).Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Sub EditarConsulta(ByVal Item As Long)

   Dim oF As Form
   
   Select Case Item
      Case 0
         Set oF = New frmConsultaPedidos
         With oF
            .Show vbModal, Me
         End With
         Unload oF
         
      Case 1
         Set oF = New frmConsultaRMPendientes
         With oF
            .Show vbModal, Me
         End With
         Unload oF
   End Select
   Set oF = Nothing
         
End Sub

Private Sub cmd_Click(Index As Integer)

   Dim mvarSale As Integer, mvarImprime As Integer
   Dim mvarAux1 As String
   Dim oF As Form
   
   Select Case Index
      Case 0
         If DTFields(0).Value <= gblFechaUltimoCierre And _
               Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
            MsgBox "La fecha no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation
            Exit Sub
         End If

         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar una Recepcion sin detalles"
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim oRs As ADOR.Recordset
         Dim mvarErr As String
         
         With origen.Registro
            For Each dtp In DTFields
               If dtp.Enabled Then
                  .Fields(dtp.DataField).Value = dtp.Value
               End If
            Next
            For Each dc In dcfields
               If dc.Enabled And dc.Visible And dc.Index <> 5 Then
                  If Not IsNumeric(dc.BoundText) Then
                     If Not (BuscarClaveINI("No exigir proveedor en recepciones") = "SI" And dc.Index = 0) And _
                        Not (BuscarClaveINI("No exigir comprador en recepciones") = "SI" And dc.Index = 4) Then
                        MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
                        Exit Sub
                     End If
                  End If
                  If IsNumeric(dc.BoundText) Then .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
            If BuscarClaveINI("Actualizar costo pedido en importaciones") = "SI" Then
               .Fields("ActualizarCostoImportacionDesdePedido").Value = "SI"
            End If
         End With
         
         If Len(Trim(txtNumeroRecepcion1.Text)) = 0 Or Len(Trim(txtNumeroRecepcion2.Text)) = 0 Then
            MsgBox "Debe completar el numero de recepcion!", vbExclamation
            Exit Sub
         End If
   
         If Len(Trim(txtSubnumero.Text)) = 0 And BuscarClaveINI("No exigir numero de recepcion") <> "SI" Then
            MsgBox "Debe ingresar la letra del subnumero de la recepcion", vbExclamation
            Exit Sub
         End If
         
         If IsNumeric(dcfields(0).BoundText) Then
            Set oRs = Aplicacion.Recepciones.TraerFiltrado("_xNroLetra", Array(txtNumeroRecepcion1.Text, txtNumeroRecepcion2.Text, txtSubnumero.Text, dcfields(0).BoundText))
            If oRs.RecordCount > 0 Then
               If mvarId < 0 Or (mvarId > 0 And oRs.Fields(0).Value <> mvarId) Then
                  oRs.Close
                  Set oRs = Nothing
                  MsgBox "Numero/Subnumero de recepcion ya existente!", vbExclamation
                  Exit Sub
               End If
            End If
            oRs.Close
         End If
         Set oRs = Nothing
         
         If Len(Trim(txtNumeroRecepcionAlmacen.Text)) = 0 Then
            MsgBox "Debe ingresar el numero de recepcion interno (o cero)", vbExclamation
            Exit Sub
         End If

         If Len(dcfields(5).Text) = 0 And dcfields(5).Visible And mvarTransportistaConEquipos Then
            MsgBox "Debe ingresar el equipo de transporte", vbExclamation
            Exit Sub
         End If

'         Set oRs = Aplicacion.Recepciones.TraerFiltrado("_PorNumeroInterno", txtNumeroRecepcionAlmacen.Text)
'         mvarErr = ""
'         If oRs.RecordCount > 0 Then
'            oRs.MoveFirst
'            Do While Not oRs.EOF
'               If mvarId < 0 Or (mvarId > 0 And oRs.Fields(0).Value <> mvarId) Then
'                  With origen.Registro
'                     If .Fields("IdProveedor").Value <> oRs.Fields("IdProveedor").Value Or _
'                        .Fields("NumeroRecepcion1").Value <> oRs.Fields("NumeroRecepcion1").Value Or _
'                        .Fields("NumeroRecepcion2").Value <> oRs.Fields("NumeroRecepcion2").Value Then
'                        mvarErr = mvarErr & Str(oRs.Fields("NumeroRecepcion1").Value) & "-" & _
'                                          Str(oRs.Fields("NumeroRecepcion2").Value) & "/" & _
'                                          oRs.Fields("SubNumero").Value & vbCrLf
'                        Exit Do
'                     End If
'                  End With
'               End If
'               oRs.MoveNext
'            Loop
'         End If
'         oRs.Close
'         Set oRs = Nothing
'         If Len(mvarErr) > 0 Then
'            MsgBox "Numero interno invalido, ya existe en el(los) remito(s) :" & vbCrLf & mvarErr, vbExclamation
'            Exit Sub
'         End If
         
         If Len(Trim(txtNumeroPedido.Text)) > 0 Then
            If Len(Trim(txtSubNumeroPedido.Text)) = 0 Then
               MsgBox "Debe ingresar el subnumero de pedido (barra)", vbExclamation
               Exit Sub
            End If
         End If
            
         If Len(Trim(txtSubNumeroPedido.Text)) > 0 Then
            If Len(Trim(txtNumeroPedido.Text)) = 0 Then
               MsgBox "Debe ingresar el numero de pedido si ingreso el subnumero (barra)", vbExclamation
               Exit Sub
            End If
         End If
         
         mvarAux1 = BuscarClaveINI("Inhabilitar ubicaciones en movimientos de stock")
         mvarErr = ""
         With origen.DetRecepciones.Registros
            If .Fields.Count > 0 Then
               If .RecordCount > 0 Then
                  .MoveFirst
                  Do While Not .EOF
                     If Not .Fields("Eliminado").Value Then
                        If IsNull(.Fields("Cantidad").Value) Or .Fields("Cantidad").Value = 0 Then
                           mvarErr = mvarErr + "Hay items que no tienen cantidad recibida" & vbCrLf
                           Exit Do
                        End If
                        If IsNull(.Fields("IdObra").Value) Then
                           mvarErr = mvarErr + "Hay items que no tienen indicada la obra" & vbCrLf
                           Exit Do
                        End If
                        If IsNull(.Fields("IdUbicacion").Value) And mvarAux1 <> "SI" Then
                           mvarErr = mvarErr + "Hay items que no tienen indicada la ubicacion" & vbCrLf
                           Exit Do
                        End If
                     End If
                     .MoveNext
                  Loop
               
                  If BuscarClaveINI("Control cierre de recepciones y pedidos") = "SI" Then
                     .MoveFirst
                     Do While Not .EOF
                        If Not .Fields("Eliminado").Value Then
                           If Not IsNull(.Fields("IdDetallePedido").Value) Then
                              Set oRs = Aplicacion.Pedidos.TraerFiltrado("_PendientesPorIdDetallePedido", _
                                          Array(.Fields("IdDetallePedido").Value, .Fields(0).Value))
                              If oRs.RecordCount > 0 Then
                                 If oRs.Fields("Entregado").Value + .Fields("CantidadCC").Value > oRs.Fields("Cantidad").Value Then
                                    mvarErr = mvarErr & "El pedido " & oRs.Fields("NumeroPedido").Value & " " & _
                                             "Item " & oRs.Fields("NumeroItem").Value & " es por " & _
                                             oRs.Fields("Cantidad").Value & " y las recepciones suman " & _
                                             oRs.Fields("Entregado").Value + .Fields("CantidadCC").Value & vbCrLf
                                 End If
                              End If
                              oRs.Close
                           End If
                        End If
                        .MoveNext
                     Loop
                  End If
               End If
            End If
         End With
         
         If Len(mvarErr) Then
            MsgBox "Errores encontrados :" & vbCrLf & mvarErr, vbExclamation
            Exit Sub
         End If
         
         With origen.Registro
            .Fields("SubNumero").Value = txtSubnumero.Text
            .Fields("Observaciones").Value = rchObservaciones.Text
            If mvarId < 0 Then
               .Fields("IdUsuarioIngreso").Value = glbIdUsuario
               .Fields("FechaIngreso").Value = Now
            Else
               .Fields("IdUsuarioModifico").Value = glbIdUsuario
               .Fields("FechaUltimaModificacion").Value = Now
            End If
         End With
         
'         If mvarId < 0 Then
'            Dim oPar As ComPronto.Parametro
'            Set oPar = Aplicacion.Parametros.Item(1)
'            With oPar.Registro
'               If .Fields("ProximoNumeroInternoRecepcion").Value = origen.Registro.Fields("NumeroRecepcionAlmacen").Value Then
'                  .Fields("ProximoNumeroInternoRecepcion").Value = .Fields("ProximoNumeroInternoRecepcion").Value + 1
'                  oPar.Guardar
'               End If
'            End With
'            Set oPar = Nothing
'         End If
         
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
            mvarGrabado = True
         Else
            est = Modificacion
         End If
            
         mvarModificado = False
         
         With actL2
            .ListaEditada = "RecepcionesTodas,RecepcionesUltimos3Meses,+SubRP2"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
         
         If mvarImpresionHabilitada Then
            mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de pedido")
            If mvarImprime = vbYes Then
               cmdImpre_Click (0)
            End If
         End If
   
         Unload Me

      Case 1
         If mvarModificado And cmd(0).Enabled Then
            mvarSale = MsgBox("Hay datos no grabados, desea salir igual ?", vbYesNo, "Salir")
            If mvarSale = vbNo Then
               Exit Sub
            End If
            mvarModificado = False
         End If
   
         Unload Me

      Case 2
         Set oF = New frmConsultaPedidos
         With oF
            .Show vbModal, Me
         End With
         Unload oF
         Set oF = Nothing
   
      Case 4
         AnulacionRecepcion
   
      Case 5
         Set oF = New frmConsulta3
         With oF
            .Id = 110
            .Show vbModal, Me
         End With
         Unload oF
         Set oF = Nothing
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oDet As DetRecepcion
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   Dim dc As DataCombo
   Dim ListaVacia As Boolean
   Dim mNumeroRecepcionAlmacen As Long
   Dim mAux1
   
   mvarId = vNewValue
   
   mvarModificado = False
   ListaVacia = False
   mvarImpresionHabilitada = True
   mvarProveedorTransportista = False
   mvarTransportistaConEquipos = False
   mvarRecepcionDesdeSalida = False
   
   mvarPermitirDistintosPedidos = BuscarClaveINI("Permitir distintos pedidos en recepciones")
   If BuscarClaveINI("Inhabilitar impresion de RE") = "SI" Then
      mvarImpresionHabilitada = False
   End If

   Set oAp = Aplicacion
   
   Set origen = oAp.Recepciones.Item(vNewValue)
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      mNumeroRecepcionAlmacen = IIf(IsNull(.Fields("ProximoNumeroInternoRecepcion").Value), 1, .Fields("ProximoNumeroInternoRecepcion").Value)
      gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)
   End With
   oRs.Close
   
   mAux1 = TraerValorParametro2("IdObraDefault")
   mIdObraDefault = IIf(IsNull(mAux1), 0, mAux1)
   
   Set oBind = New BindingCollection
   
   With oBind
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetRecepciones.TraerMascara
                     ListaVacia = True
                  Else
                     Set oRs = origen.DetRecepciones.TraerTodos
                     If Not oRs Is Nothing Then
                        If oRs.RecordCount <> 0 Then
                           Set oControl.DataSource = oRs
                           oRs.MoveFirst
                           Do While Not oRs.EOF
                              Set oDet = origen.DetRecepciones.Item(oRs.Fields(0).Value)
                              oDet.Modificado = True
                              Set oDet = Nothing
                              oRs.MoveNext
                           Loop
                           ListaVacia = False
                        Else
                           Set oControl.DataSource = origen.DetRecepciones.TraerMascara
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
      With origen.Registro
         .Fields("Realizo").Value = glbIdUsuario
         .Fields("NumeroRecepcionAlmacen").Value = mNumeroRecepcionAlmacen
         If BuscarClaveINI("Control estricto en numero de recepcion") = "SI" Then
            .Fields("SubNumero").Value = "A"
            txtSubnumero.Enabled = False
         End If
      End With
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      mvarGrabado = False
      cmd(4).Enabled = False
      mIdAprobo = 0
      EstadoControles False, 0
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
         End If
         If .Fields("Anulada").Value = "SI" Then
            mvarAnulada = "SI"
            lblEstado.Visible = True
            lblEstado.Caption = "ANULADA"
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
         mIdAprobo = IIf(IsNull(.Fields("Aprobo").Value), 0, .Fields("Aprobo").Value)
         If IsNull(.Fields("IdDepositoOrigen").Value) And dcfields(14).Enabled Then dcfields(14).Enabled = False
      End With
      txtNumeroRecepcion1.Enabled = False
      txtNumeroRecepcion2.Enabled = False
      txtSubnumero.Enabled = False
      txtNumeroPedido.Enabled = False
      txtSubNumeroPedido.Enabled = False
      txtNumeroRecepcionAlmacen.Enabled = False
      txtBusca.Enabled = False
      For Each dtf In DTFields
         dtf.Enabled = False
      Next
      For Each dc In dcfields
         dc.Enabled = False
      Next
      mvarGrabado = True
   End If
   
   If ListaVacia Then Lista.ListItems.Clear
   
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
   End If
   
   If DTFields(0).Value <= gblFechaUltimoCierre And Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
      cmd(0).Enabled = False
   End If
   
   If mvarAnulada = "SI" Then
      cmd(0).Enabled = False
      cmd(2).Enabled = False
      cmd(4).Enabled = False
   End If

   If Not mvarImpresionHabilitada Then
      cmdImpre(0).Enabled = False
      cmdImpre(1).Enabled = False
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   MostrarTotales
   
End Property

Private Sub cmdImpre_Click(Index As Integer)

   If Not mvarGrabado Then
      MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
      Exit Sub
   End If
   
   Dim mvarOK As Boolean
   Dim mCopias As Integer
   
   If Index = 0 Then
      Dim oF As frmCopiasImpresion
      Set oF = New frmCopiasImpresion
      With oF
         .txtCopias.Text = 2
         .Frame1.Visible = False
         .Show vbModal, Me
      End With
      mvarOK = oF.Ok
      mCopias = Val(oF.txtCopias.Text)
      Unload oF
      Set oF = Nothing
      If Not mvarOK Then Exit Sub
   Else
      mCopias = 1
   End If

   On Error GoTo Mal

   Dim oW As Word.Application
   
   Set oW = CreateObject("Word.Application")
   
   oW.Visible = True
   oW.Documents.Add (glbPathPlantillas & "\Recepcion_" & glbEmpresaSegunString & ".dot")
   oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId
   oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
   oW.Application.Run MacroName:="DatosDelPie"
   If Index = 0 Then
      oW.ActiveDocument.PrintOut False, , , , , , , mCopias
      oW.ActiveDocument.Close False
   End If
   If Index = 0 Then oW.Quit

Salida:
   Me.MousePointer = vbDefault
   Set oW = Nothing
   Exit Sub

Mal:
   If Index = 0 Then oW.Quit
   Me.MousePointer = vbDefault
   MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical
   Resume Salida

End Sub

Private Sub dcfields_Change(Index As Integer)

   Dim oRs As ADOR.Recordset
   Dim mIdAux As Long
   
   If IsNumeric(dcfields(Index).BoundText) Then
      If Me.Visible Then mvarModificado = True
      origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
      If Index = 0 And IsNumeric(dcfields(0).BoundText) Then
         If BuscarClaveINI("Control estricto en numero de recepcion") <> "SI" Then
            txtSubnumero.Text = Aplicacion.Recepciones.ProximaLetra(Val(txtNumeroRecepcion1.Text), Val(txtNumeroRecepcion2.Text), dcfields(0).BoundText)
         End If
'         Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", dcfields(Index).BoundText)
'         If oRs.RecordCount > 0 Then
'            If Not IsNull(oRs.Fields("IdTransportista").Value) Then
'               origen.Registro.Fields("IdTransportista").Value = oRs.Fields("IdTransportista").Value
'               dcfields(2).Enabled = False
'               Set dcfields(5).RowSource = Aplicacion.Articulos.TraerFiltrado("_PorIdTransportista", oRs.Fields("IdTransportista").Value)
'               mvarProveedorTransportista = True
'            Else
'               If mvarId <= 0 Then dcfields(2).Enabled = True
'            End If
'         End If
'         oRs.Close
      ElseIf Index = 2 Then
         Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorIdTransportista", dcfields(Index).BoundText)
         mIdAux = 0
         If Not IsNull(origen.Registro.Fields("IdEquipo").Value) Then mIdAux = origen.Registro.Fields("IdEquipo").Value
         mvarTransportistaConEquipos = False
         If oRs.RecordCount > 0 Then mvarTransportistaConEquipos = True
      End If
      Set oRs = Nothing
   End If

End Sub

Private Sub dcfields_GotFocus(Index As Integer)
   
   'SendKeys "%{DOWN}"

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub dcfields_Validate(Index As Integer, Cancel As Boolean)

   If Index = 0 Then
      If mvarId < 0 And Len(Trim(txtNumeroRecepcion1.Text)) <> 0 And Len(Trim(txtNumeroRecepcion2.Text)) <> 0 And Len(txtSubnumero.Text) And IsNumeric(dcfields(0).BoundText) Then
         If Aplicacion.Recepciones.Existe(Val(txtNumeroRecepcion1.Text), Val(txtNumeroRecepcion2.Text), txtSubnumero.Text, dcfields(0).BoundText) Then
            MsgBox "Recepcion ya existente!", vbExclamation
            Cancel = True
            Exit Sub
         End If
      End If
   End If

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   For Each oI In Img16.ListImages
      With Estado.Panels.Add(, , oI.Key)
         .Picture = oI.Picture
      End With
   Next

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   If mvarId > 0 Then
      MsgBox "Recepcion ya registrada, no pueden hacerse modificaciones!", vbExclamation
      Exit Sub
   End If
   
   Dim Filas
   Dim Columnas
   Dim s As String, mvarNumeroPedido As String
   Dim iFilas As Long, iColumnas As Long, mvarNumeroRequerimiento As Long, mvarNumeroAcopio As Long, mvarIdReq As Long
   Dim mDetalles As Integer, i As Integer
   Dim mImporte As Double, mvarCotizacion As Double
   Dim mItemExistente As Boolean
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oL As ListItem

   On Error Resume Next
   
   If Data.GetFormat(ccCFText) Then
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      mvarCotizacion = Cotizacion(DTFields(0).Value, glbIdMonedaDolar)
      If mvarCotizacion = 0 Then
         MsgBox "No hay cotizacion dolar", vbExclamation
         Exit Sub
      End If
      
      Set oAp = Aplicacion
      
      If InStr(1, Columnas(LBound(Columnas) + 2), "Item") <> 0 And InStr(1, Columnas(LBound(Columnas) + 3), "Fecha") <> 0 Then
         'Pedido detallado
         Columnas = Split(Filas(1), vbTab)
         mvarNumeroPedido = Columnas(1)
         For i = 2 To UBound(Filas)
            Columnas = Split(Filas(i), vbTab)
            If mvarNumeroPedido <> Columnas(1) And mvarPermitirDistintosPedidos <> "SI" Then
               MsgBox "Existe en la seleccion diferentes pedidos!" & vbCrLf & "(debe elegir items del mismo pedido)", vbExclamation
               Exit Sub
            End If
         Next
         
         mImporte = 0
         If Lista.ListItems.Count > 0 Then
            Set oRs = oAp.Pedidos.TraerFiltrado("_DatosPorIdDetalle", Columnas(27))
            If txtNumeroPedido.Text <> oRs.Fields("NumeroPedido").Value And _
                  mvarPermitirDistintosPedidos <> "SI" Then
               oRs.Close
               Set oRs = Nothing
               MsgBox "Existe en la seleccion diferentes pedidos!" & vbCrLf & "(debe elegir items del mismo pedido)", vbExclamation
               Exit Sub
            Else
               If Not IsNull(oRs.Fields("SubNumero").Value) Then
                  If txtSubNumeroPedido.Text <> oRs.Fields("SubNumero").Value And _
                        mvarPermitirDistintosPedidos <> "SI" Then
                     oRs.Close
                     Set oRs = Nothing
                     MsgBox "Existe en la seleccion diferentes pedidos!" & vbCrLf & "(debe elegir items del mismo pedido)", vbExclamation
                     Exit Sub
                  End If
               End If
            End If
            'mImporte = oRs.Fields("TotalPedido").Value
            oRs.Close
         End If
         
         For i = 1 To UBound(Filas)
            Columnas = Split(Filas(i), vbTab)
            Set oRs = oAp.Pedidos.TraerFiltrado("_DatosPorIdDetalle", Columnas(27))
            If oRs.RecordCount > 0 Then
               mImporte = oRs.Fields("TotalPedido").Value
               If Not CircuitoFirmasCompleto(NotaPedido, Columnas(21), mImporte) Then
                  If BuscarClaveINI("Permitir emision de pedido sin liberar") <> "SI" Then
                     MsgBox "El pedido no tiene completo el circuito de firmas", vbExclamation
                     GoTo Salida
                  End If
               End If
               If IsNull(oRs.Fields("Aprobo").Value) Then
                  If BuscarClaveINI("Permitir emision de pedido sin liberar") <> "SI" Then
                     oRs.Close
                     Set oRs = Nothing
                     MsgBox "El pedido todavia no esta autorizado!", vbExclamation
                     Exit Sub
                  End If
               Else
                  mItemExistente = False
                  If mvarPermitirDistintosPedidos <> "SI" Then
                     For Each oL In Lista.ListItems
                        If oL.SubItems(1) = oRs.Fields("NumeroItem").Value Then
                           mItemExistente = True
                        End If
                     Next
                  End If
                  If Not mItemExistente And oRs.Fields("Pendiente").Value > 0 Then
                     Set oL = Lista.ListItems.Add()
                     With origen.DetRecepciones.Item(-1)
                        .Registro.Fields("Cantidad").Value = oRs.Fields("Pendiente").Value
                        .Registro.Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                        .Registro.Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                        .Registro.Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
                        .Registro.Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
                        .Registro.Fields("IdDetallePedido").Value = oRs.Fields("IdDetallePedido").Value
                        .Registro.Fields("IdDetalleRequerimiento").Value = oRs.Fields("IdDetalleRequerimiento").Value
                        .Registro.Fields("IdControlCalidad").Value = oRs.Fields("IdControlCalidad").Value
                        .Registro.Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
                        .Registro.Fields("IdDetalleAcopios").Value = oRs.Fields("IdDetalleAcopios").Value
                        If mIdObraDefault > 0 Then
                           .Registro.Fields("IdObra").Value = mIdObraDefault
                        Else
                           .Registro.Fields("IdObra").Value = oRs.Fields("IdObra").Value
                        End If
                        .Registro.Fields("CostoUnitario").Value = oRs.Fields("PrecioBonificado").Value
                        .Registro.Fields("IdMoneda").Value = oRs.Fields("IdMoneda").Value
                        If oRs.Fields("IdMoneda").Value = 1 Then
                           .Registro.Fields("CotizacionDolar").Value = mvarCotizacion
                        Else
                           .Registro.Fields("CotizacionDolar").Value = oRs.Fields("CotizacionDolar").Value
                        End If
                        .Registro.Fields("CotizacionMoneda").Value = oRs.Fields("CotizacionMoneda").Value
                        .Registro.Fields("IdUbicacion").Value = oRs.Fields("IdUbicacionStandar").Value
                        .Registro.Fields("Partida").Value = ""
                        If Not IsNull(.Registro.Fields("IdControlCalidad").Value) Then
                           If oAp.ControlesCalidad.Item(.Registro.Fields("IdControlCalidad").Value).Registro.Fields("Inspeccion").Value <> "SI" Then
                              .Registro.Fields("Controlado").Value = "DI"
                              .Registro.Fields("CantidadCC").Value = .Registro.Fields("Cantidad").Value
                              .Registro.Fields("Cantidad1CC").Value = .Registro.Fields("Cantidad1").Value
                              .Registro.Fields("Cantidad2CC").Value = .Registro.Fields("Cantidad2").Value
                              .Registro.Fields("CantidadAdicionalCC").Value = .Registro.Fields("CantidadAdicional").Value
                           End If
                        End If
                        oL.Tag = .Id
                        oL.Text = "" & oRs.Fields("NumeroPedido").Value
                        oL.SubItems(1) = "" & oRs.Fields("NumeroItem").Value
                        oL.SubItems(2) = "" & oRs.Fields("NumeroRequerimiento").Value
                        oL.SubItems(3) = "" & oRs.Fields("IR").Value
                        oL.SubItems(4) = ""
                        oL.SubItems(5) = ""
                        oL.SubItems(6) = "" & oRs.Fields("Obra").Value
                        oL.SubItems(7) = "" & .Registro.Fields("Cantidad").Value
                        oL.SubItems(8) = "" & .Registro.Fields("Cantidad1").Value
                        oL.SubItems(9) = "" & .Registro.Fields("Cantidad2").Value
                        oL.SubItems(10) = "" & oAp.Unidades.Item(oRs.Fields("IdUnidad").Value).Registro.Fields("Abreviatura").Value
                        oL.SubItems(11) = "" & oAp.StockPorIdArticulo(oRs.Fields("IdArticulo").Value)
                        oL.SubItems(12) = "" & oRs.Fields("Cantidad").Value
                        oL.SubItems(13) = "" & oRs.Fields("Cantidad").Value
                        oL.SubItems(14) = "" & oRs.Fields("Codigo").Value
                        oL.SubItems(15) = "" & oRs.Fields("DescripcionArt").Value
                        oL.SmallIcon = "Nuevo"
                        .Modificado = True
                     End With
                  End If
                  txtNumeroPedido.Text = oRs.Fields("NumeroPedido").Value
                  txtSubNumeroPedido.Text = IIf(IsNull(oRs.Fields("SubNumero").Value), "", oRs.Fields("SubNumero").Value)
                  dcfields(0).BoundText = oRs.Fields("IdProveedor").Value
                  txtFechaPedido.Text = oRs.Fields("FechaPedido").Value
                  With origen.Registro
                     .Fields("IdPedido").Value = oRs.Fields("IdPedido").Value
                     .Fields("IdRequerimiento").Value = Null
                     .Fields("IdAcopio").Value = Null
                     .Fields("IdComprador").Value = oRs.Fields("IdComprador").Value
                     .Fields("IdDepositoOrigen").Value = Null
                  End With
                  dcfields(0).Enabled = False
                  txtNumeroPedido.Enabled = False
                  txtSubNumeroPedido.Enabled = False
               End If
            End If
            oRs.Close
         Next
      
      ElseIf InStr(1, Columnas(LBound(Columnas) + 2), "Fecha") <> 0 And _
            (InStr(1, Columnas(LBound(Columnas) + 3), "Proveedor") <> 0 Or _
             InStr(1, Columnas(LBound(Columnas) + 7), "Proveedor") <> 0) Then
         'Pedido Resumido
         Columnas = Split(Filas(1), vbTab)
         AgregarPedido Columnas(0)
         dcfields(14).Enabled = False
      
      ElseIf InStr(1, Columnas(8), "Cpte.tipo") <> 0 Then
         For i = 1 To UBound(Filas)
            Columnas = Split(Filas(i), vbTab)
            If Columnas(8) = "LA" Then
               Set oRs = oAp.Acopios.TraerFiltrado("_DatosAcopio", Columnas(0))
               If oRs.RecordCount > 0 Then
                  If IsNull(oRs.Fields("Aprobo").Value) Then
                     oRs.Close
                     MsgBox "la LA todavia no esta aprobada!", vbExclamation
                     GoTo Salida
                  Else
                     mItemExistente = False
                     For Each oL In Lista.ListItems
                        If oL.SubItems(5) = oRs.Fields("NumeroItem").Value Then
                           mItemExistente = True
                        End If
                     Next
                     If Not mItemExistente Then
                        Set oL = Lista.ListItems.Add()
                        With origen.DetRecepciones.Item(-1)
                           If oRs.Fields("Pendiente").Value > 0 Then
                              .Registro.Fields("Cantidad").Value = oRs.Fields("Pendiente").Value
                           Else
                              .Registro.Fields("Cantidad").Value = 0
                           End If
                           .Registro.Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                           .Registro.Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                           .Registro.Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
                           .Registro.Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
                           .Registro.Fields("IdDetalleAcopios").Value = oRs.Fields("IdDetalleAcopios").Value
                           .Registro.Fields("IdControlCalidad").Value = oRs.Fields("IdControlCalidad").Value
                           .Registro.Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
                           If mIdObraDefault > 0 Then
                              .Registro.Fields("IdObra").Value = mIdObraDefault
                           Else
                              .Registro.Fields("IdObra").Value = oRs.Fields("IdObra").Value
                           End If
                           .Registro.Fields("Partida").Value = ""
                           .Registro.Fields("CostoUnitario").Value = 0
                           .Registro.Fields("IdMoneda").Value = 1
                           .Registro.Fields("CotizacionDolar").Value = mvarCotizacion
                           .Registro.Fields("CotizacionMoneda").Value = 1
                           If Not IsNull(.Registro.Fields("IdControlCalidad").Value) Then
                              If oAp.ControlesCalidad.Item(.Registro.Fields("IdControlCalidad").Value).Registro.Fields("Inspeccion").Value <> "SI" Then
                                 .Registro.Fields("Controlado").Value = "DI"
                                 .Registro.Fields("CantidadCC").Value = .Registro.Fields("Cantidad").Value
                                 .Registro.Fields("Cantidad1CC").Value = .Registro.Fields("Cantidad1").Value
                                 .Registro.Fields("Cantidad2CC").Value = .Registro.Fields("Cantidad2").Value
                                 .Registro.Fields("CantidadAdicionalCC").Value = .Registro.Fields("CantidadAdicional").Value
                              End If
                           End If
                           oL.Tag = .Id
                           oL.Text = ""
                           oL.SubItems(1) = ""
                           oL.SubItems(2) = ""
                           oL.SubItems(3) = ""
                           oL.SubItems(4) = "" & oRs.Fields("NumeroAcopio").Value
                           oL.SubItems(5) = "" & oRs.Fields("NumeroItem").Value
                           oL.SubItems(6) = "" & oRs.Fields("Obra").Value
                           oL.SubItems(7) = "" & .Registro.Fields("Cantidad").Value
                           oL.SubItems(8) = "" & oRs.Fields("Cantidad1").Value
                           oL.SubItems(9) = "" & oRs.Fields("Cantidad2").Value
                           oL.SubItems(10) = "" & oAp.Unidades.Item(oRs.Fields("IdUnidad").Value).Registro.Fields("Abreviatura").Value
                           oL.SubItems(11) = "" & oAp.StockPorIdArticulo(oRs.Fields("IdArticulo").Value)
                           oL.SubItems(12) = "" & oRs.Fields("Cantidad").Value
                           oL.SubItems(13) = "" & oRs.Fields("Cantidad").Value
                           oL.SubItems(14) = "" & oRs.Fields("Codigo").Value
                           oL.SubItems(15) = "" & oRs.Fields("DescripcionArt").Value
                           oL.SmallIcon = "Nuevo"
                           .Modificado = True
                        End With
                     End If
                     With origen.Registro
                        .Fields("IdAcopio").Value = oRs.Fields("IdAcopio").Value
                        .Fields("IdRequerimiento").Value = Null
                        .Fields("IdPedido").Value = Null
                     End With
                     txtNumeroPedido.Text = ""
                     txtNumeroPedido.Enabled = False
                     txtSubNumeroPedido.Text = ""
                     txtSubNumeroPedido.Enabled = False
                     txtFechaPedido.Text = ""
                  End If
               End If
               oRs.Close
         
            ElseIf Columnas(8) = "RM" Then
               Set oRs = oAp.Requerimientos.TraerFiltrado("_DatosRequerimiento", Columnas(22))

               If oRs.RecordCount > 0 Then
                  mvarIdReq = oRs.Fields("IdRequerimiento").Value
                  Do While Not oRs.EOF
                     Set oL = Lista.ListItems.Add()
                     With origen.DetRecepciones.Item(-1)
                        If oRs.Fields("Pendiente").Value > 0 Then
                           .Registro.Fields("Cantidad").Value = oRs.Fields("Pendiente").Value
                        Else
                           .Registro.Fields("Cantidad").Value = 0
                        End If
                        .Registro.Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                        .Registro.Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                        .Registro.Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
                        .Registro.Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
                        .Registro.Fields("IdDetalleRequerimiento").Value = oRs.Fields("IdDetalleRequerimiento").Value
                        .Registro.Fields("IdControlCalidad").Value = oRs.Fields("IdControlCalidad").Value
                        .Registro.Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
                        If mIdObraDefault > 0 Then
                           .Registro.Fields("IdObra").Value = mIdObraDefault
                        Else
                           .Registro.Fields("IdObra").Value = oRs.Fields("IdObra").Value
                        End If
                        .Registro.Fields("Partida").Value = ""
                        .Registro.Fields("CostoUnitario").Value = 0
                        .Registro.Fields("IdMoneda").Value = 1
                        .Registro.Fields("CotizacionDolar").Value = mvarCotizacion
                        .Registro.Fields("CotizacionMoneda").Value = 1
                        If Not IsNull(.Registro.Fields("IdControlCalidad").Value) Then
                           If oAp.ControlesCalidad.Item(.Registro.Fields("IdControlCalidad").Value).Registro.Fields("Inspeccion").Value <> "SI" Then
                              .Registro.Fields("Controlado").Value = "DI"
                              .Registro.Fields("CantidadCC").Value = .Registro.Fields("Cantidad").Value
                              .Registro.Fields("Cantidad1CC").Value = .Registro.Fields("Cantidad1").Value
                              .Registro.Fields("Cantidad2CC").Value = .Registro.Fields("Cantidad2").Value
                              .Registro.Fields("CantidadAdicionalCC").Value = .Registro.Fields("CantidadAdicional").Value
                           End If
                        End If
                        If Not IsNull(oRs.Fields("IdComprador").Value) Then
                           origen.Registro.Fields("IdComprador").Value = oRs.Fields("IdComprador").Value
                        End If
                        oL.Tag = .Id
                        oL.Text = ""
                        oL.SubItems(1) = ""
                        oL.SubItems(2) = "" & oRs.Fields("NumeroRequerimiento").Value
                        oL.SubItems(3) = "" & oRs.Fields("NumeroItem").Value
                        oL.SubItems(4) = ""
                        oL.SubItems(5) = ""
                        oL.SubItems(6) = "" & oRs.Fields("Obra").Value
                        oL.SubItems(7) = "" & .Registro.Fields("Cantidad").Value
                        oL.SubItems(8) = "" & oRs.Fields("Cantidad1").Value
                        oL.SubItems(9) = "" & oRs.Fields("Cantidad2").Value
                        oL.SubItems(10) = "" & oAp.Unidades.Item(oRs.Fields("IdUnidad").Value).Registro.Fields("Abreviatura").Value
                        oL.SubItems(11) = "" & oAp.StockPorIdArticulo(oRs.Fields("IdArticulo").Value)
                        oL.SubItems(12) = "" & oRs.Fields("Cantidad").Value
                        oL.SubItems(13) = "" & oRs.Fields("Cantidad").Value
                        oL.SubItems(14) = "" & oRs.Fields("Codigo").Value
                        oL.SubItems(15) = "" & oRs.Fields("DescripcionArt").Value
                        oL.SmallIcon = "Nuevo"
                        .Modificado = True
                     End With
                     oRs.MoveNext
                  Loop
                  oRs.Close
               End If
            
            End If
      
         Next
         dcfields(14).Enabled = False
         mvarModificado = True
            
      ElseIf InStr(1, Columnas(1), "Tipo de salida") <> 0 Then
         'Salida de materiales
         For i = 1 To UBound(Filas)
            Columnas = Split(Filas(i), vbTab)
            Set oRs = oAp.SalidasMateriales.TraerFiltrado("_DatosPorIdDetalle", Columnas(2))
            If oRs.RecordCount > 0 Then
               oRs.MoveFirst
               Do While Not oRs.EOF
                  Set oL = Lista.ListItems.Add()
                  With origen.DetRecepciones.Item(-1)
                     .Registro.Fields("Cantidad").Value = oRs.Fields("Cantidad").Value
                     .Registro.Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     .Registro.Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                     .Registro.Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
                     .Registro.Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
                     .Registro.Fields("IdDetalleRequerimiento").Value = oRs.Fields("IdDetalleRequerimiento").Value
                     .Registro.Fields("Observaciones").Value = oRs.Fields("Observaciones").Value
                     .Registro.Fields("IdObra").Value = oRs.Fields("IdObraDestino").Value
                     .Registro.Fields("CostoUnitario").Value = oRs.Fields("CostoUnitario").Value
                     .Registro.Fields("IdMoneda").Value = oRs.Fields("IdMoneda").Value
                     If oRs.Fields("IdMoneda").Value = 1 Then
                        .Registro.Fields("CotizacionDolar").Value = mvarCotizacion
                     Else
                        .Registro.Fields("CotizacionDolar").Value = oRs.Fields("CotizacionDolar").Value
                     End If
                     .Registro.Fields("CotizacionMoneda").Value = oRs.Fields("CotizacionMoneda").Value
                     .Registro.Fields("IdUbicacion").Value = Null
                     .Registro.Fields("Partida").Value = ""
                     .Registro.Fields("IdDetalleSalidaMateriales").Value = oRs.Fields("IdDetalleSalidaMateriales").Value
                     oL.Tag = .Id
                     oL.Text = ""
                     oL.SubItems(1) = ""
                     oL.SubItems(2) = "" & oRs.Fields("NumeroRequerimiento").Value
                     oL.SubItems(3) = "" & oRs.Fields("NumeroItem").Value
                     oL.SubItems(4) = ""
                     oL.SubItems(5) = ""
                     oL.SubItems(6) = "" & oRs.Fields("ObraDestino").Value
                     oL.SubItems(7) = "" & .Registro.Fields("Cantidad").Value
                     oL.SubItems(8) = "" & .Registro.Fields("Cantidad1").Value
                     oL.SubItems(9) = "" & .Registro.Fields("Cantidad2").Value
                     oL.SubItems(10) = "" & oRs.Fields("Unidad").Value
                     oL.SubItems(11) = "" & oAp.StockPorIdArticulo(oRs.Fields("IdArticulo").Value)
                     oL.SubItems(12) = "" & oRs.Fields("Cantidad").Value
                     oL.SubItems(13) = "" & oRs.Fields("Cantidad").Value
                     oL.SubItems(14) = "" & oRs.Fields("Codigo").Value
                     oL.SubItems(15) = "" & oRs.Fields("Articulo").Value
                     oL.SmallIcon = "Nuevo"
                     .Modificado = True
                  End With
                  With origen.Registro
                     .Fields("IdPedido").Value = Null
                     .Fields("IdRequerimiento").Value = oRs.Fields("IdRequerimiento").Value
                     .Fields("IdAcopio").Value = Null
                     .Fields("IdComprador").Value = Null
                     .Fields("IdTransportista").Value = oRs.Fields("IdTransportista1").Value
                     .Fields("IdProveedor").Value = oRs.Fields("IdProveedor").Value
                     .Fields("NumeroRecepcion1").Value = oRs.Fields("NumeroSalidaMateriales2").Value
                     .Fields("NumeroRecepcion2").Value = oRs.Fields("NumeroSalidaMateriales").Value
                     .Fields("IdDepositoOrigen").Value = oRs.Fields("IdDepositoOrigen").Value
                     .Fields("SubNumero").Value = "A"
                  End With
                  oRs.MoveNext
               Loop
               If BuscarClaveINI("No exigir proveedor en recepciones") = "SI" Then dcfields(0).Enabled = False
               If BuscarClaveINI("No exigir comprador en recepciones") = "SI" Then dcfields(4).Enabled = False
            End If
            oRs.Close
         Next
         mvarRecepcionDesdeSalida = True
      Else
         MsgBox "Objeto invalido!", vbExclamation
      End If
      
Salida:
      
      Set oL = Nothing
      Set oRs = Nothing
      Set oAp = Nothing
      
      Clipboard.Clear
      MostrarTotales
   End If

End Sub

Private Sub Form_OLEDragOver(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

   Dim iFilas As Long, iColumnas As Long
   Dim s As String
   Dim Filas, Columnas
   Dim oL As ListItem

   If State = vbEnter Then
      If Data.GetFormat(ccCFText) Then ' si el dato es texto
         s = Data.GetData(ccCFText) ' tomo el dato
         Filas = Split(s, vbCrLf) ' armo un vector por filas
         Columnas = Split(Filas(LBound(Filas)), vbTab)
         Effect = vbDropEffectCopy
      End If
   End If

End Sub

Private Sub Form_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   If mvarModificado And cmd(0).Enabled Then
      Dim mvarSale As Integer
      mvarSale = MsgBox("Hay datos no grabados, desea salir igual ?", vbYesNo, "Salir")
      If mvarSale = vbNo Then
         Cancel = 1
      End If
   End If

End Sub

Private Sub Lista_DblClick()

   If Lista.ListItems.Count = 0 Then
      Editar -1
   Else
      Editar Lista.SelectedItem.Tag
   End If
   
   MostrarTotales

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_ItemClick(ByVal Item As MSComctlLib.IListItem)

   rchObservacionesItemVisible.TextRTF = ""
   If Not Item Is Nothing Then
      If IsNumeric(Item.Tag) Then
         If Not IsNull(origen.DetRecepciones.Item(Item.Tag).Registro.Fields("Observaciones").Value) Then
            rchObservacionesItemVisible.TextRTF = origen.DetRecepciones.Item(Item.Tag).Registro.Fields("Observaciones").Value
         End If
      End If
   End If

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
         If mvarId < 0 Then MnuDetA(2).Enabled = True
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
         If mvarId > 0 Then
            MsgBox "No puede modificar los items de una recepcion ya registrada!", vbExclamation
            Exit Sub
         End If
         Dim oL As ListItem
         Dim i As Integer
         If Not Lista.SelectedItem Is Nothing Then
'            For Each oL In Lista.ListItems
'               If oL.Selected Then
'                  origen.DetRecepciones.Item(oL.Tag).Eliminado = True
'                  oL.SmallIcon = "Eliminado"
'                  oL.ToolTipText = oL.SmallIcon
'                  mvarModificado = True
'               End If
'            Next
         
            Lista.Refresh
            For i = 1 To Lista.ListItems.Count
               If Lista.ListItems(i).Selected Then
                  origen.DetRecepciones.Item(Lista.ListItems(i).Tag).Eliminado = True
                  Lista.ListItems(i).SmallIcon = "Eliminado"
                  Lista.ListItems(i).ToolTipText = Lista.ListItems(i).SmallIcon
                  mvarModificado = True
               End If
            Next
         End If
      Case 3
         DuplicarItem
   End Select
   
   MostrarTotales

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

Private Sub Option1_Click()

   If Option1.Value Then EstadoControles True, 1

End Sub

Private Sub Option2_Click()

   If Option2.Value Then EstadoControles True, 2

End Sub

Private Sub txtNumeroPedido_GotFocus()

   With txtNumeroPedido
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroPedido_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtNumeroPedido_Validate(Cancel As Boolean)

   If Len(Trim(txtNumeroPedido.Text)) <> 0 And txtNumeroPedido.Enabled Then
      If Not Len(Trim(txtSubNumeroPedido.Text)) = 0 And IsNumeric(txtSubNumeroPedido.Text) Then
         Dim oRs As ADOR.Recordset
         Dim mSubNumero As Integer
         mSubNumero = Val(txtSubNumeroPedido.Text)
         Set oRs = Aplicacion.Pedidos.TraerFiltrado("_PorNumero", Array(txtNumeroPedido.Text, mSubNumero))
         If oRs.RecordCount > 0 Then
            AgregarPedido oRs.Fields("IdPedido").Value
         End If
         oRs.Close
         Set oRs = Nothing
      End If
   End If

End Sub

Private Sub txtNumeroRecepcion1_GotFocus()

   With txtNumeroRecepcion1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroRecepcion1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtNumeroRecepcion1
         If Len(Trim(.Text)) >= 4 And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If
   
End Sub

Private Sub txtNumeroRecepcion1_Validate(Cancel As Boolean)

   If Not IsNumeric(txtNumeroRecepcion1.Text) And BuscarClaveINI("No exigir numero de recepcion") <> "SI" Then
      MsgBox "Debe ingresar un numero valido!", vbExclamation
      Cancel = True
      Exit Sub
   End If
   
   If mvarId < 0 And Len(Trim(txtNumeroRecepcion1.Text)) <> 0 And Len(Trim(txtNumeroRecepcion2.Text)) <> 0 And Len(txtSubnumero.Text) And IsNumeric(dcfields(0).BoundText) Then
      If Aplicacion.Recepciones.Existe(Val(txtNumeroRecepcion1.Text), Val(txtNumeroRecepcion2.Text), txtSubnumero.Text, dcfields(0).BoundText) Then
         MsgBox "Recepcion ya existente!", vbExclamation
         Cancel = True
         Exit Sub
      End If
   End If

End Sub

Private Sub txtNumeroRecepcion2_GotFocus()

   With txtNumeroRecepcion2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroRecepcion2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtNumeroRecepcion2
         If Len(Trim(.Text)) >= 8 And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If
   
End Sub

Private Sub txtNumeroRecepcion2_Validate(Cancel As Boolean)

   If Not IsNumeric(txtNumeroRecepcion2.Text) And BuscarClaveINI("No exigir numero de recepcion") <> "SI" Then
      MsgBox "Debe ingresar un numero valido!", vbExclamation
      Cancel = True
      Exit Sub
   End If
   
   If mvarId < 0 And Len(Trim(txtNumeroRecepcion1.Text)) <> 0 And Len(Trim(txtNumeroRecepcion2.Text)) <> 0 And Len(txtSubnumero.Text) And IsNumeric(dcfields(0).BoundText) Then
      If Aplicacion.Recepciones.Existe(Val(txtNumeroRecepcion1.Text), Val(txtNumeroRecepcion2.Text), txtSubnumero.Text, dcfields(0).BoundText) Then
         MsgBox "Recepcion ya existente!", vbExclamation
         Cancel = True
         Exit Sub
      End If
   End If

End Sub

Private Sub txtNumeroRecepcionAlmacen_Change()

   If IsNull(origen.Registro.Fields("NumeroRecepcionAlmacen").Value) Or Val(txtNumeroRecepcionAlmacen.Text) <> origen.Registro.Fields("NumeroRecepcionAlmacen").Value Then
      mvarModificado = True
   End If
   
End Sub

Private Sub txtNumeroRecepcionAlmacen_GotFocus()

   With txtNumeroRecepcionAlmacen
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroRecepcionAlmacen_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

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
         Dim oRs As ADOR.Recordset
         Set oAp = Aplicacion
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set oRs = oAp.Proveedores.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set oRs = oAp.Proveedores.TraerLista
         End If
         Set dcfields(0).RowSource = oRs
         If oRs.RecordCount > 0 Then
            dcfields(0).BoundText = oRs.Fields(0).Value
         End If
         Set oRs = Nothing
         Set oAp = Nothing
      End If
      If dcfields(0).Enabled Then dcfields(0).SetFocus
'      SendKeys "%{DOWN}"
   End If

End Sub

Private Sub txtSubnumero_GotFocus()

   With txtSubnumero
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

   If Len(txtSubnumero.Text) = 0 And IsNumeric(dcfields(0).BoundText) Then
      txtSubnumero.Text = Aplicacion.Recepciones.ProximaLetra(Val(txtNumeroRecepcion1.Text), Val(txtNumeroRecepcion2.Text), dcfields(0).BoundText)
   End If

End Sub

Private Sub txtSubnumero_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtSubnumero
         If KeyAscii >= 97 And KeyAscii <= 122 Then
            KeyAscii = KeyAscii - 32
         Else
            If (KeyAscii < 65 Or KeyAscii > 90) And KeyAscii <> vbDelete And KeyAscii <> 8 Then
               KeyAscii = 0
            End If
         End If
         If Len(Trim(.Text)) > origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtSubNumeroPedido_GotFocus()

   With txtSubNumeroPedido
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtSubNumeroPedido_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtSubNumeroPedido_Validate(Cancel As Boolean)

   If Len(Trim(txtSubNumeroPedido.Text)) > 0 And txtSubNumeroPedido.Enabled Then
      If Not Len(Trim(txtNumeroPedido.Text)) = 0 And IsNumeric(txtNumeroPedido.Text) Then
         Dim oRs As ADOR.Recordset
         Dim mSubNumero As Integer
         mSubNumero = Val(txtSubNumeroPedido.Text)
         Set oRs = Aplicacion.Pedidos.TraerFiltrado("_PorNumero", Array(txtNumeroPedido.Text, mSubNumero))
         If oRs.RecordCount > 0 Then
            AgregarPedido oRs.Fields("IdPedido").Value
   '      Else
   '         MsgBox "Pedido inexistente o error en el subnumero", vbExclamation
   '         Cancel = True
         End If
         oRs.Close
         Set oRs = Nothing
      End If
   End If

End Sub

Public Sub AgregarPedido(ByVal IdPed As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim mItemExistente As Boolean
   Dim mDetalles As Integer, i As Integer
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim oL As ListItem
   Dim mRequerido As Double, mRecibido As Double
            
   Set oAp = Aplicacion
   Set oRs = oAp.Pedidos.Item(IdPed).Registro
   
   If Not IsNull(oRs.Fields("Cumplido").Value) And oRs.Fields("Cumplido").Value = "AN" Then
      MsgBox "El pedido esta anulado", vbExclamation
      GoTo Salida
   End If
   
   If Not CircuitoFirmasCompleto(NotaPedido, IdPed, oRs.Fields("TotalPedido").Value) Then
      If BuscarClaveINI("Permitir emision de pedido sin liberar") <> "SI" Then
         MsgBox "El pedido no tiene completo el circuito de firmas", vbExclamation
         GoTo Salida
      End If
   End If
   
   If oRs.RecordCount > 0 Then
      If Lista.ListItems.Count > 0 Then
         If txtNumeroPedido.Text <> oRs.Fields("NumeroPedido").Value And mvarPermitirDistintosPedidos <> "SI" Then
            oRs.Close
            MsgBox "Existe en la seleccion diferentes pedidos!" & vbCrLf & "(debe elegir items del mismo pedido)", vbExclamation
            GoTo Salida
         Else
            If Not IsNull(oRs.Fields("SubNumero").Value) Then
               If txtSubNumeroPedido.Text <> oRs.Fields("SubNumero").Value And mvarPermitirDistintosPedidos <> "SI" Then
                  oRs.Close
                  MsgBox "Existe en la seleccion diferentes pedidos!" & vbCrLf & "(debe elegir items del mismo pedido)", vbExclamation
                  GoTo Salida
               End If
            End If
         End If
      End If
      If IsNull(oRs.Fields("Aprobo").Value) And BuscarClaveINI("Permitir emision de pedido sin liberar") <> "SI" Then
         MsgBox "El pedido todavia no esta autorizado!", vbExclamation
      Else
         txtNumeroPedido.Enabled = False
         txtSubNumeroPedido.Enabled = False
         txtNumeroPedido.Text = oRs.Fields("NumeroPedido").Value
         txtSubNumeroPedido.Text = IIf(IsNull(oRs.Fields("SubNumero").Value), "", oRs.Fields("SubNumero").Value)
         dcfields(0).BoundText = oRs.Fields("IdProveedor").Value
         txtFechaPedido.Text = oRs.Fields("FechaPedido").Value
         With origen.Registro
            .Fields("IdPedido").Value = IdPed
            .Fields("IdRequerimiento").Value = Null
            .Fields("IdAcopio").Value = Null
            .Fields("IdComprador").Value = oRs.Fields("IdComprador").Value
            .Fields("IdDepositoOrigen").Value = Null
         End With
         dcfields(0).Enabled = False
         mDetalles = MsgBox("Desea cargar los detalles ?", vbYesNo, "Copiar desde pedido")
         If mDetalles = vbYes Then
            Set oRsDet = oAp.Pedidos.TraerFiltrado("_TodosLosDetalles", IdPed)
            If oRsDet.RecordCount > 0 Then
               Do While Not oRsDet.EOF
                  mItemExistente = False
                  For Each oL In Lista.ListItems
                     If oL.SubItems(1) = oRsDet.Fields("NumeroItem").Value Then mItemExistente = True
                  Next
                  If Not mItemExistente And oRsDet.Fields("Pendiente").Value > 0 And _
                        IIf(IsNull(oRsDet.Fields("Cumplido").Value), "NO", oRsDet.Fields("Cumplido").Value) <> "AN" Then
'                     Set oL = Lista.ListItems.Add()
                     With origen.DetRecepciones.Item(-1)
                        mRequerido = 0
                        mRecibido = 0
                        Set oRs1 = oAp.Recepciones.TraerFiltrado("_PendientesPorIdDetalle", Array(0, oRsDet.Fields("IdDetallePedido").Value, 0, 0))
                        If oRs1.RecordCount > 0 Then
                           oRs1.MoveFirst
                           If Not IsNull(oRs1.Fields("Cant.Orig.").Value) Then mRequerido = oRs1.Fields("Cant.Orig.").Value
                           If Not IsNull(oRs1.Fields("Recibido").Value) Then mRecibido = oRs1.Fields("Recibido").Value
                        End If
                        oRs1.Close
                        If oRsDet.Fields("Pendiente").Value > 0 Then
                           .Registro.Fields("Cantidad").Value = oRsDet.Fields("Pendiente").Value
                        Else
                           .Registro.Fields("Cantidad").Value = 0
                        End If
                        .Registro.Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                        .Registro.Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                        .Registro.Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
                        .Registro.Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
                        .Registro.Fields("IdDetallePedido").Value = oRsDet.Fields("IdDetallePedido").Value
                        .Registro.Fields("IdDetalleRequerimiento").Value = oRsDet.Fields("IdDetalleRequerimiento").Value
                        .Registro.Fields("IdControlCalidad").Value = oRsDet.Fields("IdControlCalidad").Value
                        .Registro.Fields("Observaciones").Value = oRsDet.Fields("Observaciones").Value
                        .Registro.Fields("IdDetalleAcopios").Value = oRsDet.Fields("IdDetalleAcopios").Value
                        If mIdObraDefault > 0 Then
                           .Registro.Fields("IdObra").Value = mIdObraDefault
                        Else
                           .Registro.Fields("IdObra").Value = oRsDet.Fields("IdObra").Value
                        End If
                        .Registro.Fields("CostoUnitario").Value = oRsDet.Fields("PrecioBonificado").Value
                        .Registro.Fields("IdMoneda").Value = oRs.Fields("IdMoneda").Value
                        .Registro.Fields("CotizacionDolar").Value = oRs.Fields("CotizacionDolar").Value
                        .Registro.Fields("CotizacionMoneda").Value = oRs.Fields("CotizacionMoneda").Value
                        .Registro.Fields("IdUbicacion").Value = oRsDet.Fields("IdUbicacionStandar").Value
                        .Registro.Fields("Partida").Value = ""
                        If Not IsNull(.Registro.Fields("IdControlCalidad").Value) Then
                           If oAp.ControlesCalidad.Item(.Registro.Fields("IdControlCalidad").Value).Registro.Fields("Inspeccion").Value <> "SI" Then
                              .Registro.Fields("Controlado").Value = "DI"
                              .Registro.Fields("CantidadCC").Value = .Registro.Fields("Cantidad").Value
                              .Registro.Fields("Cantidad1CC").Value = .Registro.Fields("Cantidad1").Value
                              .Registro.Fields("Cantidad2CC").Value = .Registro.Fields("Cantidad2").Value
                              .Registro.Fields("CantidadAdicionalCC").Value = .Registro.Fields("CantidadAdicional").Value
                           End If
                        End If
'                        oL.Tag = .Id
'                        oL.Text = "" & oRsDet.Fields("NumeroPedido").Value
'                        oL.SubItems(1) = "" & oRsDet.Fields("NumeroItem").Value
'                        oL.SubItems(2) = "" & oRsDet.Fields("NumeroRequerimiento").Value
'                        oL.SubItems(3) = "" & oRsDet.Fields("IR").Value
'                        oL.SubItems(4) = ""
'                        oL.SubItems(5) = ""
'                        oL.SubItems(6) = "" & oRsDet.Fields("Obra").Value
'                        oL.SubItems(7) = "" & .Registro.Fields("Cantidad").Value
'                        oL.SubItems(8) = "" & .Registro.Fields("Cantidad1").Value
'                        oL.SubItems(9) = "" & .Registro.Fields("Cantidad2").Value
'                        oL.SubItems(10) = "" & oAp.Unidades.Item(oRsDet.Fields("IdUnidad").Value).Registro.Fields("Abreviatura").Value
'                        oL.SubItems(11) = "" & oAp.StockPorIdArticulo(oRsDet.Fields("IdArticulo").Value)
'                        oL.SubItems(12) = "" & mRequerido
'                        oL.SubItems(13) = "" & (mRecibido + .Registro.Fields("Cantidad").Value)
'                        oL.SubItems(14) = "" & oRsDet.Fields("Codigo").Value
'                        oL.SubItems(15) = "" & oRsDet.Fields("DescripcionArt").Value
'                        oL.SmallIcon = "Nuevo"
                        .Modificado = True
                     End With
                  End If
                  oRsDet.MoveNext
               Loop
            End If
            oRsDet.Close
         End If
      End If
   End If
   oRs.Close
   
   Set Lista.DataSource = origen.DetRecepciones.RegistrosConFormato

Salida:
   Set oRsDet = Nothing
   Set oRs1 = Nothing
   Set oRs = Nothing
   Set oAp = Nothing
   MostrarTotales
   
End Sub

Public Sub AnulacionRecepcion()

   Dim mSeguro As Integer
   mSeguro = MsgBox("Esta seguro de anular la recepcion ?", vbYesNo, "Anulacion de recepcion")
   If mSeguro = vbNo Then
      Exit Sub
   End If

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim mvarIdUnidad As Long, mvarIdUbicacion As Long, mvarIdObra As Long
   Dim mSaldoVales As Double, mvarCantidadUnidades As Double, mvarStock1 As Double, mvarStock2 As Double
   Dim mError As String, mError1 As String, mvarAux2 As String, mvarAux5 As String, mvarPartida As String, mvarArticulo As String
   Dim mvarRegistrarStock As Boolean
   
   mvarAux2 = BuscarClaveINI("Inhabilitar stock negativo")
   mvarAux5 = BuscarClaveINI("Inhabilitar stock global negativo")
   
   mError = ""
   Set oRs = Aplicacion.Recepciones.TraerFiltrado("_ComprobantesProveedoresPorIdRecepcion", mvarId)
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            mError = mError & vbCrLf & IIf(IsNull(.Fields("Comprobante").Value), "", .Fields("Comprobante").Value) & " " & _
                        "del " & IIf(IsNull(.Fields("FechaComprobante").Value), "", .Fields("FechaComprobante").Value)
            .MoveNext
         Loop
      End If
      .Close
   End With
   Set oRs = Nothing
   If Len(mError) > 0 Then
      MsgBox "La recepcion no puede ser anulada porque se encuentra" & vbCrLf & _
               "incluida en los siguientes comprobantes de proveedores : " & mError, vbExclamation
      Exit Sub
   End If
   
   mError = ""
   mError1 = ""
   Set oRs = Aplicacion.Recepciones.TraerFiltrado("_DetallesPorIdRecepcion", mvarId)
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If Not IsNull(.Fields("IdDetalleRequerimiento").Value) Then
               Set oRs1 = Aplicacion.Requerimientos.TraerFiltrado("_DatosRequerimiento", .Fields("IdDetalleRequerimiento").Value)
               If oRs1.RecordCount > 0 Then
                  'mSaldoVales = oRs1.Fields("Cantidad").Value - oRs1.Fields("SalidaPorVales").Value
                  mSaldoVales = oRs1.Fields("Entregado").Value - oRs1.Fields("SalidaPorVales").Value
                  If mSaldoVales < .Fields("Cantidad").Value And oRs1.Fields("SalidaPorVales").Value <> 0 Then
                     mError = mError & vbCrLf & oRs1.Fields("DescripcionArt").Value & ", " & _
                                 "Requerido " & oRs1.Fields("Cantidad").Value & ", " & _
                                 "Recibido " & .Fields("Cantidad").Value & ", " & _
                                 "Vales por " & oRs1.Fields("SalidaPorVales").Value
                  End If
               End If
               oRs1.Close
            End If
            
            mvarRegistrarStock = True
            Set oRs1 = Aplicacion.Articulos.TraerFiltrado("_PorIdConDatos", .Fields("IdArticulo").Value)
            If oRs1.RecordCount > 0 Then
               If Not IsNull(oRs1.Fields("RegistrarStock").Value) And oRs1.Fields("RegistrarStock").Value = "NO" Then
                  mvarRegistrarStock = False
               End If
            End If
            oRs1.Close
            
            If mvarRegistrarStock And (mvarAux2 = "SI" Or mvarAux5 = "SI") Then
               mvarCantidadUnidades = IIf(IsNull(.Fields("Cantidad").Value), 0, .Fields("Cantidad").Value)
               mvarPartida = IIf(IsNull(.Fields("Partida").Value), "", .Fields("Partida").Value)
               mvarIdUnidad = IIf(IsNull(.Fields("IdUnidad").Value), 0, .Fields("IdUnidad").Value)
               mvarIdUbicacion = IIf(IsNull(.Fields("IdUbicacion").Value), 0, .Fields("IdUbicacion").Value)
               mvarIdObra = IIf(IsNull(.Fields("IdObra").Value), 0, .Fields("IdObra").Value)
               mvarStock1 = 0
               mvarStock2 = 0
               
               Set oRs1 = Aplicacion.Articulos.TraerFiltrado("_StockPorArticuloPartidaUnidadUbicacionObra", _
                            Array(.Fields("IdArticulo").Value, mvarPartida, mvarIdUnidad, mvarIdUbicacion, mvarIdObra))
               If oRs1.RecordCount > 0 Then
                  mvarStock1 = IIf(IsNull(oRs1.Fields("Stock").Value), 0, oRs1.Fields("Stock").Value)
                  mvarArticulo = IIf(IsNull(oRs1.Fields("Articulo").Value), "", oRs1.Fields("Articulo").Value)
               End If
               oRs1.Close
               
               Set oRs1 = Aplicacion.Articulos.TraerFiltrado("_StockTotalPorArticulo", .Fields("IdArticulo").Value)
               If oRs1.RecordCount > 0 Then
                  mvarStock2 = IIf(IsNull(oRs1.Fields("Stock").Value), 0, oRs1.Fields("Stock").Value)
               End If
               oRs1.Close
               
               If mvarAux2 = "SI" And mvarStock1 - mvarCantidadUnidades < 0 Then
                  mError1 = mError1 & vbCrLf & "El articulo " & mvarArticulo & ", quedaria con stock negativo segun datos ingresados :" & vbCrLf & _
                           "cantidad actual en stock para la partida, unidad, ubicacion y obra : " & mvarStock1 & " - " & _
                           "cantidad total actual en stock : " & mvarStock2
               End If
               If mvarAux5 = "SI" And mvarStock2 - mvarCantidadUnidades < 0 Then
                  mError1 = mError1 & vbCrLf & "El articulo " & mvarArticulo & ", quedaria con stock global insuficiente" & vbCrLf & _
                           "cantidad total actual en stock : " & mvarStock2
               End If
            End If
            
            .MoveNext
         Loop
      End If
      .Close
   End With
   Set oRs = Nothing
   Set oRs1 = Nothing
   
   If Len(mError) > 0 Then
      MsgBox "La recepcion no puede ser anulada porque para los siguientes articulos" & vbCrLf & _
               "existen vales de salida ya confeccionados, debe anularlos primero : " & mError, vbExclamation
      Exit Sub
   End If
   
   If Len(mError1) > 0 Then
      MsgBox "La recepcion no puede ser anulada, " & mError1, vbExclamation
      Exit Sub
   End If
   
   Dim oF As frmAutorizacion
   Dim mUsuario As String
   Dim mIdAnulo As Long
   Dim mOk As Boolean
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.RecepcionMateriales
      '.Administradores = True
      '.JefeCompras = True
      .Show vbModal, Me
      mOk = .Ok
      mUsuario = .Autorizo
      mIdAnulo = .IdAutorizo
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then Exit Sub
   Me.Refresh
   
   Dim of1 As frmAnulacion
   Dim mMotivoAnulacion As String
   Set of1 = New frmAnulacion
   With of1
      .Caption = "Motivo de anulacion de la recepcion"
      .Text1.Text = "Usuario : " & mUsuario & " - [" & Now & "]"
      .Show vbModal, Me
      mOk = .Ok
   End With
   mMotivoAnulacion = of1.rchAnulacion.Text
   Unload of1
   Set of1 = Nothing
   If Not mOk Then
      MsgBox "Anulacion cancelada!", vbExclamation
      Exit Sub
   End If
   Me.Refresh
   
   With origen
      .Registro.Fields("Anulada").Value = "OK"
      .Registro.Fields("IdUsuarioAnulo").Value = mIdAnulo
      .Registro.Fields("FechaAnulacion").Value = Now
      .Registro.Fields("MotivoAnulacion").Value = mMotivoAnulacion
      .Guardar
   End With
   
   Aplicacion.Tarea "Recepciones_AjustarStockRecepcionAnulada", mvarId
   
   Set oRs = Aplicacion.Recepciones.TraerFiltrado("_DetallesPorIdRecepcion", mvarId)
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If Not IsNull(.Fields("IdArticulo").Value) Then
               Aplicacion.Tarea "Articulos_RecalcularCostoPPP_PorIdArticulo", .Fields("IdArticulo").Value
            End If
            .MoveNext
         Loop
      End If
      .Close
   End With
   Set oRs = Nothing
   
   Unload Me

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

Public Sub DuplicarItem()

   Dim oRs As ADOR.Recordset
   Dim idDet As Long, i As Long
   
   Set oRs = origen.DetRecepciones.Item(Lista.SelectedItem.Tag).Registro
   
   With origen.DetRecepciones.Item(-1)
      For i = 2 To oRs.Fields.Count - 1
'         If oRs.Fields(i).Name <> "NumeroItem" Then
            .Registro.Fields(i).Value = oRs.Fields(i).Value
'         End If
      Next
      .Registro.Fields("Cantidad").Value = 0
      .Modificado = True
      idDet = .Id
   End With
   Set oRs = Nothing
   
   Set Lista.DataSource = origen.DetRecepciones.RegistrosConFormato

End Sub

Public Sub MostrarTotales()

   Estado.Panels(1).Text = " " & origen.DetRecepciones.CantidadRegistros & " Items"

End Sub

Public Sub EstadoControles(ByVal Estado As Boolean, ByVal Opcion As Integer)

   Dim oControl As Control

   For Each oControl In Me.Controls
      If TypeOf oControl Is CommandButton Then
      ElseIf TypeOf oControl Is DbListView Then
      ElseIf TypeOf oControl Is RichTextBox Then
         oControl.Enabled = Estado
      ElseIf TypeOf oControl Is DataCombo Then
         oControl.Enabled = Estado
      ElseIf TypeOf oControl Is TextBox Then
         oControl.Enabled = Estado
      ElseIf TypeOf oControl Is DTPicker Then
         oControl.Enabled = Estado
      End If
   Next

   If Opcion = 1 Then
      lblLabels(1).Visible = True
      txtNumeroPedido.Visible = True
      Line2.Visible = True
      txtSubNumeroPedido.Visible = True
      lblLabels(2).Visible = True
      txtFechaPedido.Visible = True
      lblData(0).Visible = True
      dcfields(0).Visible = True
      lblLabels(8).Visible = True
      txtBusca.Visible = True
      cmd(4).Visible = True
      cmd(5).Visible = False
   Else
      lblLabels(1).Visible = False
      txtNumeroPedido.Visible = False
      Line2.Visible = False
      txtSubNumeroPedido.Visible = False
      lblLabels(2).Visible = False
      txtFechaPedido.Visible = False
      lblData(0).Visible = False
      dcfields(0).Visible = False
      lblLabels(8).Visible = False
      txtBusca.Visible = False
      cmd(4).Visible = False
      With cmd(5)
         .Left = cmd(4).Left
         .Visible = True
      End With
   End If

End Sub
