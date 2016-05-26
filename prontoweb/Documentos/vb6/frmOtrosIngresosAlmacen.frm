VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmOtrosIngresosAlmacen 
   Caption         =   "Otros ingresos a almacen"
   ClientHeight    =   5280
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11505
   Icon            =   "frmOtrosIngresosAlmacen.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5280
   ScaleWidth      =   11505
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "Anular"
      Enabled         =   0   'False
      Height          =   420
      Index           =   2
      Left            =   6165
      TabIndex        =   31
      Top             =   4500
      Width           =   1470
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   0
      Left            =   3105
      Picture         =   "frmOtrosIngresosAlmacen.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   13
      Top             =   4500
      UseMaskColor    =   -1  'True
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   420
      Index           =   1
      Left            =   1575
      TabIndex        =   12
      Top             =   4500
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   45
      TabIndex        =   11
      Top             =   4500
      Width           =   1470
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   6
      Left            =   3105
      TabIndex        =   10
      Top             =   1260
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   5
      Left            =   2880
      TabIndex        =   9
      Top             =   1260
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   4
      Left            =   2655
      TabIndex        =   8
      Top             =   1260
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   3
      Left            =   2430
      TabIndex        =   7
      Top             =   1260
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   2
      Left            =   2205
      TabIndex        =   6
      Top             =   1260
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   1
      Left            =   1980
      TabIndex        =   5
      Top             =   1260
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   0
      Left            =   1755
      TabIndex        =   4
      Top             =   1260
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   0
      ItemData        =   "frmOtrosIngresosAlmacen.frx":0DD4
      Left            =   585
      List            =   "frmOtrosIngresosAlmacen.frx":0DE7
      TabIndex        =   3
      Top             =   45
      Width           =   1860
   End
   Begin VB.TextBox txtNumeroOtroIngresoAlmacen 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroOtroIngresoAlmacen"
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
      Left            =   3105
      TabIndex        =   2
      Top             =   45
      Width           =   1635
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   1
      Left            =   4635
      Picture         =   "frmOtrosIngresosAlmacen.frx":0E4F
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   4500
      Width           =   1470
   End
   Begin VB.CheckBox Check2 
      Caption         =   "Check2"
      Height          =   240
      Left            =   8325
      TabIndex        =   0
      Top             =   90
      Width           =   240
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1050
      Left            =   4950
      TabIndex        =   14
      Top             =   630
      Width           =   6495
      _ExtentX        =   11456
      _ExtentY        =   1852
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmOtrosIngresosAlmacen.frx":13D9
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   15
      Top             =   4995
      Width           =   11505
      _ExtentX        =   20294
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   9180
      Top             =   4410
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
            Picture         =   "frmOtrosIngresosAlmacen.frx":145B
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmOtrosIngresosAlmacen.frx":156D
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmOtrosIngresosAlmacen.frx":19BF
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmOtrosIngresosAlmacen.frx":1E11
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaOtroIngresoAlmacen"
      Height          =   330
      Index           =   0
      Left            =   5580
      TabIndex        =   16
      Top             =   45
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Enabled         =   0   'False
      Format          =   22675457
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   0
      Left            =   8595
      TabIndex        =   17
      Tag             =   "Obras"
      Top             =   45
      Width           =   2850
      _ExtentX        =   5027
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   2535
      Left            =   45
      TabIndex        =   18
      Top             =   1890
      Width           =   11400
      _ExtentX        =   20108
      _ExtentY        =   4471
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmOtrosIngresosAlmacen.frx":2263
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Aprobo"
      Height          =   315
      Index           =   1
      Left            =   1755
      TabIndex        =   19
      Tag             =   "Empleados"
      Top             =   855
      Width           =   2985
      _ExtentX        =   5265
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Emitio"
      Height          =   315
      Index           =   4
      Left            =   1755
      TabIndex        =   20
      Tag             =   "Empleados"
      Top             =   495
      Width           =   2985
      _ExtentX        =   5265
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservacionesItem 
      Height          =   195
      Left            =   8685
      TabIndex        =   21
      Top             =   4500
      Visible         =   0   'False
      Width           =   420
      _ExtentX        =   741
      _ExtentY        =   344
      _Version        =   393217
      TextRTF         =   $"frmOtrosIngresosAlmacen.frx":227F
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
      Left            =   2745
      TabIndex        =   32
      Top             =   1530
      Visible         =   0   'False
      Width           =   1950
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   195
      Index           =   0
      Left            =   4950
      TabIndex        =   30
      Top             =   450
      Width           =   1215
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   4950
      TabIndex        =   29
      Top             =   90
      Width           =   570
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Nro. :"
      Height          =   240
      Index           =   14
      Left            =   2610
      TabIndex        =   28
      Top             =   90
      Width           =   435
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Obra :"
      Height          =   240
      Index           =   0
      Left            =   7020
      TabIndex        =   27
      Top             =   90
      Width           =   1260
   End
   Begin VB.Label lblData 
      Caption         =   "Liberado por :"
      Height          =   240
      Index           =   1
      Left            =   90
      TabIndex        =   26
      Top             =   900
      Width           =   1620
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Autorizaciones : "
      Height          =   240
      Index           =   1
      Left            =   90
      TabIndex        =   25
      Top             =   1260
      Width           =   1620
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Tipo : "
      Height          =   240
      Index           =   2
      Left            =   90
      TabIndex        =   24
      Top             =   90
      Width           =   450
   End
   Begin VB.Label lblData 
      Caption         =   "Emitido por : "
      Height          =   240
      Index           =   4
      Left            =   90
      TabIndex        =   23
      Top             =   540
      Width           =   1620
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle de items :"
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
      Index           =   16
      Left            =   90
      TabIndex        =   22
      Top             =   1665
      Width           =   1545
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
Attribute VB_Name = "frmOtrosIngresosAlmacen"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.OtroIngresoAlmacen
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mTipoIngreso As Integer, mOk As Integer
Private mvarId As Long, mIdAprobo As Long
Private mvarGrabado As Boolean
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

   If IsNull(origen.Registro.Fields("IdObra").Value) Then
      MsgBox "Antes de ingresar los detalles debe definir la obra", vbCritical
      Exit Sub
   End If
   
   Dim oF As frmDetOtrosIngresosAlmacen
   Dim oL As ListItem
   
   Set oF = New frmDetOtrosIngresosAlmacen
   
   With oF
      Set .OtroIngresoAlmacen = origen
      .Id = Cual
      .TipoIngreso = mTipoIngreso
      .Show vbModal, Me
      If .Aceptado Then
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
            .Text = oF.txtCodigoArticulo.Text
            .SubItems(1) = oF.DataCombo1(1).Text
            .SubItems(2) = "" & oF.txtPartida.Text
            .SubItems(3) = "" & oF.txtCantidad.Text
            If oF.mvarCantidadAdicional <> 0 Then
               .SubItems(4) = "" & oF.txtCantidad1.Text
               .SubItems(5) = "" & oF.txtCantidad2.Text
            End If
            .SubItems(6) = "" & oF.DataCombo1(0).Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Private Sub Check2_Click()

   If Check2.Value = 1 And mvarId = -1 Then
'      origen.Registro.Fields("IdCentroCosto").Value = Null
'      dcfields(0).Enabled = True
'      Check3.Value = 0
'      dcfields(6).Enabled = False
   End If
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar un ingreso de materiales sin detalles"
            Exit Sub
         End If
         
         If Combo1(0).ListIndex = -1 Then
            MsgBox "No indico el tipo de otro ingreso"
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim oRsDet As ADOR.Recordset
         Dim oRsStk As ADOR.Recordset
         Dim mvarStock As Double, mvarCantidad As Double, mvarCantidadAdicional As Double
         Dim mvarCantidadUnidades As Double
         Dim mvarIdStock As Long
         Dim mvarImprime As Integer
         Dim mNum As Long
         Dim oPar As ComPronto.Parametro
         
         With origen.Registro
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
            
            For Each dc In dcfields
               If dc.Enabled Then
                  If Not IsNumeric(dc.BoundText) Then
                     MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
                     Exit Sub
                  End If
                  If IsNumeric(dc.BoundText) Then .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
            
            If Not IsNull(.Fields("Aprobo").Value) Then
               Set oRsDet = origen.DetOtrosIngresosAlmacen.TodosLosRegistros
               If oRsDet.RecordCount > 0 Then
                  With oRsDet
                     .MoveFirst
                     Do While Not .EOF
                        If IsNull(.Fields("IdArticulo").Value) Then
                           oRsDet.Close
                           Set oRsDet = Nothing
                           MsgBox "Articulo no definido!", vbExclamation
                           Exit Sub
                        End If
                        If IsNull(.Fields("Partida").Value) Then
                           oRsDet.Close
                           Set oRsDet = Nothing
                           MsgBox "Partida no definida!", vbExclamation
                           Exit Sub
                        End If
                        If IsNull(.Fields("IdUnidad").Value) Then
                           oRsDet.Close
                           Set oRsDet = Nothing
                           MsgBox "Unidad de medida no definida!", vbExclamation
                           Exit Sub
                        End If
                        If IsNull(.Fields("IdUbicacion").Value) Then
                           oRsDet.Close
                           Set oRsDet = Nothing
                           MsgBox "Ubicacion no definida en detalle!", vbExclamation
                           Exit Sub
                        End If
                        .MoveNext
                     Loop
                     Set oRsDet = Nothing
                  End With
               End If
            End If
            
            .Fields("TipoIngreso").Value = Combo1(0).ListIndex
'            If Not IsNull(.Fields("IdObra").Value) Then
'               .Fields("Cliente").Value = txtCliente.Text
'               .Fields("Direccion").Value = txtDireccion.Text
'               .Fields("Localidad").Value = txtLocalidad.Text
'               .Fields("CodigoPostal").Value = txtCodigoPostal.Text
'               .Fields("CondicionIva").Value = txtCondicionIva.Text
'               .Fields("Cuit").Value = txtCuit.Text
'            ElseIf Not IsNull(.Fields("IdProveedor").Value) Then
'               .Fields("Cliente").Value = Null
'               .Fields("Direccion").Value = txtDireccion.Text
'               .Fields("Localidad").Value = txtLocalidad.Text
'               .Fields("CodigoPostal").Value = txtCodigoPostal.Text
'               .Fields("CondicionIva").Value = txtCondicionIva.Text
'               .Fields("Cuit").Value = txtCuit.Text
'            End If
            .Fields("Observaciones").Value = rchObservaciones.Text
         End With
         
'         If mvarId < 0 Then
'            Set oPar = Aplicacion.Parametros.Item(1)
'            With oPar.Registro
'               If .Fields("ProximoNumeroOtroIngresoAlmacen").Value = origen.Registro.Fields("NumeroOtroIngresoAlmacen").Value Then
'                  .Fields("ProximoNumeroOtroIngresoAlmacen").Value = origen.Registro.Fields("NumeroOtroIngresoAlmacen").Value + 1
'               End If
'            End With
'            oPar.Guardar
'            Set oPar = Nothing
'            mvarGrabado = True
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
            
         With actL2
            .ListaEditada = "OtrosIngresosAlmacenTodos,+SubOI2"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
         
'         mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de solicitud de cotizacion")
'         If mvarImprime = vbYes Then
'            cmdImpre_Click (0)
'         End If
         
         Unload Me

      Case 1
         Unload Me

      Case 2
         AnularOtroIngresoAlmacen
         
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRsAut As ADOR.Recordset
   Dim oDet As DetOtroIngresoAlmacen
   Dim dtf As DTPicker
   Dim ListaVacia As Boolean
   Dim i As Integer, mCantidadFirmas As Integer
   Dim mIdObraDefault As Long
   Dim mAux1
   
   mvarId = vNewValue
   ListaVacia = False
   
   Set oAp = Aplicacion
   
   Set origen = oAp.OtrosIngresosAlmacen.Item(vNewValue)
   
   If glbParametrizacionNivel1 Then origen.NivelParametrizacion = 1
   
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
                     Set oControl.DataSource = origen.DetOtrosIngresosAlmacen.TraerMascara
                     ListaVacia = True
                  Else
                     Set oRs = origen.DetOtrosIngresosAlmacen.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           Set oDet = origen.DetOtrosIngresosAlmacen.Item(oRs.Fields(0).Value)
                           oDet.Modificado = True
                           Set oDet = Nothing
                           oRs.MoveNext
                        Loop
                        ListaVacia = False
                     Else
                        Set oControl.DataSource = origen.DetOtrosIngresosAlmacen.TraerMascara
                        ListaVacia = True
                     End If
                     oRs.Close
                  End If
            End Select
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Obras" Then
                  If glbSeñal1 Then
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", Date))
                  Else
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo")
                  End If
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
   
   Check1(0).Visible = True
   
   If mvarId = -1 Then
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      Check2.Value = 1
      Set oRs = oAp.Parametros.TraerTodos
      With origen.Registro
         .Fields("Emitio").Value = glbIdUsuario
         .Fields("NumeroOtroIngresoAlmacen").Value = oRs.Fields("ProximoNumeroOtroIngresoAlmacen").Value
         .Fields("IdObra").Value = mIdObraDefault
         If mIdObraDefault <> 0 Then dcfields(0).Enabled = False
         If glbIdObraAsignadaUsuario > 0 Then .Fields("IdObra").Value = glbIdObraAsignadaUsuario
      End With
      mvarGrabado = False
      mIdAprobo = 0
   Else
      With origen.Registro
         If Not IsNull(.Fields("TipoIngreso").Value) Then
            mTipoIngreso = .Fields("TipoIngreso").Value
            Combo1(0).ListIndex = mTipoIngreso
         Else
            mTipoIngreso = 0
         End If
         Combo1(0).Enabled = False
         If Not IsNull(.Fields("Aprobo").Value) Then
            Check1(0).Value = 1
            mIdAprobo = .Fields("Aprobo").Value
         End If
         If .Fields("Anulado").Value = "SI" Then
            lblEstado.Visible = True
            lblEstado.Caption = "ANULADO"
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
      mCantidadFirmas = 0
      Set oRsAut = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(EnumFormularios.OtroIngresoAlmacen, 0))
      If oRsAut.RecordCount > 0 Then
         oRsAut.MoveFirst
         Do While Not oRsAut.EOF
            mCantidadFirmas = mCantidadFirmas + 1
            Check1(mCantidadFirmas).Visible = True
            Check1(mCantidadFirmas).Tag = oRsAut.Fields(0).Value
            oRsAut.MoveNext
         Loop
      End If
      oRsAut.Close
      Set oRsAut = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(EnumFormularios.OtroIngresoAlmacen, mvarId))
      If oRsAut.RecordCount > 0 Then
         oRsAut.MoveFirst
         Do While Not oRsAut.EOF
            For i = 1 To mCantidadFirmas
               If Check1(i).Tag = oRsAut.Fields("OrdenAutorizacion").Value Then
                  Check1(i).Value = 1
                  Exit For
               End If
            Next
            oRsAut.MoveNext
         Loop
      End If
      oRsAut.Close
      Set oRsAut = Nothing
      mvarGrabado = True
   End If
   
   If ListaVacia Then
      Lista.ListItems.Clear
   End If
   
   If glbIdObraAsignadaUsuario > 0 Then
      dcfields(0).Enabled = False
      Check2.Value = 1
      Check2.Enabled = False
   End If
   
   cmd(0).Enabled = False
   cmd(2).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
   End If
   If mvarId > 0 Then
      cmd(0).Enabled = False
      If IsNull(origen.Registro.Fields("Anulado").Value) Then cmd(2).Enabled = True
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   MostrarTotales
   
End Property

Private Sub cmdImpre_Click(Index As Integer)

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
      If Not mvarOK Then
         Exit Sub
      End If
   Else
      mCopias = 1
   End If

   On Error GoTo Mal

   Dim oW As Word.Application
   
   Set oW = CreateObject("Word.Application")
   
   oW.Visible = True
   oW.Documents.Add (glbPathPlantillas & "\OtrosIngresosAlmacen_" & glbEmpresaSegunString & ".dot")
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

Private Sub Combo1_Click(Index As Integer)

   If Index = 0 Then
   
   End If
   
End Sub

Private Sub dcfields_Change(Index As Integer)

   Dim oRsObra As ADOR.Recordset
   Dim oRsCliente As ADOR.Recordset
   Dim oRsProv As ADOR.Recordset
   
   If IsNumeric(dcfields(Index).BoundText) Then
      origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
      Select Case Index
         Case 0
            Set oRsObra = Aplicacion.Obras.Item(dcfields(Index).BoundText).Registro
            If oRsObra.RecordCount > 0 Then
               If Not IsNull(oRsObra.Fields("IdCliente").Value) Then
                  Set oRsCliente = Aplicacion.Clientes.TraerFiltrado("_TT", oRsObra.Fields("IdCliente").Value)
                  With oRsCliente
                     If .RecordCount > 0 Then
'                        lblcliente.Caption = "Cliente : "
'                        If Not IsNull(.Fields("Razon Social").Value) Then
'                           txtCliente.Text = .Fields("Razon Social").Value
'                        Else
'                           txtCliente.Text = ""
'                        End If
'                        If Not IsNull(.Fields("Direccion de entrega").Value) Then
'                           txtDireccion.Text = .Fields("Direccion de entrega").Value
'                        ElseIf Not IsNull(.Fields("Direccion").Value) Then
'                           txtDireccion.Text = .Fields("Direccion").Value
'                        Else
'                           txtDireccion.Text = ""
'                        End If
'                        If Not IsNull(.Fields("Localidad (entrega)").Value) Then
'                           txtLocalidad.Text = .Fields("Localidad (entrega)").Value
'                           txtCodigoPostal.Text = ""
'                        ElseIf Not IsNull(.Fields("Localidad").Value) Then
'                           txtLocalidad.Text = .Fields("Localidad").Value
'                           If Not IsNull(.Fields("CodigoPostal").Value) Then
'                              txtCodigoPostal.Text = .Fields("CodigoPostal").Value
'                           Else
'                              txtCodigoPostal.Text = ""
'                           End If
'                        Else
'                           txtLocalidad.Text = ""
'                           txtCodigoPostal.Text = ""
'                        End If
'                        If Not IsNull(.Fields("Provincia (entrega)").Value) Then
'                           txtLocalidad.Text = txtLocalidad.Text & " - " & .Fields("Provincia (entrega)").Value
'                        ElseIf Not IsNull(.Fields("Provincia").Value) Then
'                           txtLocalidad.Text = txtLocalidad.Text & " - " & .Fields("Provincia").Value
'                        End If
'                        txtCondicionIva.Text = IIf(IsNull(.Fields("Condicion IVA").Value), "", .Fields("Condicion IVA").Value)
'                        txtCuit.Text = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
                     End If
                     oRsCliente.Close
                  End With
'                  With origen.Registro
'                     .Fields("IdProveedor").Value = Null
'                  End With
               End If
            End If
            oRsObra.Close
      End Select
   End If
   
   Set oRsObra = Nothing
   Set oRsCliente = Nothing
   Set oRsProv = Nothing

End Sub

Private Sub dcfields_GotFocus(Index As Integer)
   
   If Index <> 1 Then SendKeys "%{DOWN}"

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   If Index = 1 And Me.Visible And IsNumeric(dcfields(Index).BoundText) Then
      If dcfields(Index).BoundText <> mIdAprobo Then PideAutorizacion
   End If
   
End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   For Each oI In img16.ListImages
      With Estado.Panels.Add(, , oI.Key)
         .Picture = oI.Picture
      End With
   Next

   CambiarLenguaje Me, "esp", glbIdiomaActual

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
   
   MostrarTotales

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
'         If mvarId > 0 Then
'            MsgBox "No puede modificar un vale ya registrado!", vbCritical
'            Exit Sub
'         End If
         With Lista.SelectedItem
            origen.DetOtrosIngresosAlmacen.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
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

Private Sub PideAutorizacion()

   Dim oF As frmAutorizacion1
   Set oF = New frmAutorizacion1
   With oF
      .IdUsuario = dcfields(1).BoundText
      .Show vbModal, Me
   End With
   If Not oF.Ok Then
      With origen.Registro
         .Fields(dcfields(1).DataField).Value = Null
'         .Fields("FechaAprobacion").Value = Null
      End With
      Check1(0).Value = 0
      mIdAprobo = 0
   Else
      With origen.Registro
'         .Fields("FechaAprobacion").Value = Now
         mIdAprobo = .Fields("Aprobo").Value
      End With
      Check1(0).Value = 1
   End If
   Unload oF
   Set oF = Nothing

End Sub

Public Sub AnularOtroIngresoAlmacen()

   Dim oF As frmAutorizacion
   Dim mOk As Boolean
   Dim mIdAutorizaAnulacion As Integer
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.OtroIngresoAlmacen
      '.Administradores = True
      .Show vbModal, Me
      mOk = .Ok
      mIdAutorizaAnulacion = .IdAutorizo
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then
      Exit Sub
   End If
   
   Me.Refresh
   
   Dim mSeguro As Integer
   mSeguro = MsgBox("Esta seguro de anular el comprobante?", vbYesNo, "Anulacion")
   If mSeguro = vbNo Then
      Exit Sub
   End If

   With origen
      .Registro.Fields("Anulado").Value = "SI"
      .Registro.Fields("IdAutorizaAnulacion").Value = mIdAutorizaAnulacion
      .Registro.Fields("FechaAnulacion").Value = Now
      .Guardar
   End With

   Aplicacion.Tarea "OtrosIngresosAlmacen_AjustarStockPorAnulacion", mvarId
   
   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetOtrosIngresosAlmacen", "Otros", mvarId)
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

Public Sub MostrarTotales()

   Estado.Panels(1).Text = " " & origen.DetOtrosIngresosAlmacen.CantidadRegistros & " Items"

End Sub
