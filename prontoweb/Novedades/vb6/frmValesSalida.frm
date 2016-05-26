VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmValesSalida 
   Caption         =   "Solicitud de materiales a almacen"
   ClientHeight    =   6330
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11460
   Icon            =   "frmValesSalida.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6330
   ScaleWidth      =   11460
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "Anular"
      Height          =   420
      Index           =   3
      Left            =   7200
      TabIndex        =   35
      Top             =   5535
      Width           =   1200
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Copiar items"
      Height          =   420
      Index           =   2
      Left            =   3105
      TabIndex        =   33
      Top             =   5535
      Width           =   1470
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   1
      Left            =   6345
      Picture         =   "frmValesSalida.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   32
      Top             =   5535
      Width           =   795
   End
   Begin VB.TextBox txtNumeroValePreimpreso 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroValePreimpreso"
      Height          =   315
      Left            =   5130
      TabIndex        =   5
      Top             =   45
      Width           =   1635
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   0
      Left            =   8685
      TabIndex        =   28
      Top             =   900
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   1
      Left            =   8910
      TabIndex        =   27
      Top             =   900
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   2
      Left            =   9135
      TabIndex        =   26
      Top             =   900
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   3
      Left            =   9360
      TabIndex        =   25
      Top             =   900
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   4
      Left            =   9585
      TabIndex        =   24
      Top             =   900
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   5
      Left            =   9810
      TabIndex        =   23
      Top             =   900
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   6
      Left            =   10035
      TabIndex        =   22
      Top             =   900
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CommandButton cmdPegar 
      Height          =   420
      Left            =   4635
      Picture         =   "frmValesSalida.frx":0CF4
      Style           =   1  'Graphical
      TabIndex        =   11
      ToolTipText     =   "Pegar desde lista de materiales"
      Top             =   5535
      UseMaskColor    =   -1  'True
      Width           =   795
   End
   Begin VB.Frame Frame1 
      Height          =   780
      Left            =   6840
      TabIndex        =   1
      Top             =   0
      Visible         =   0   'False
      Width           =   1320
      Begin VB.OptionButton Option1 
         Caption         =   "Por obra"
         Height          =   195
         Left            =   90
         TabIndex        =   19
         Top             =   180
         Width           =   1140
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Por c.costo"
         Height          =   195
         Left            =   90
         TabIndex        =   18
         Top             =   495
         Width           =   1140
      End
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3120
      Left            =   45
      TabIndex        =   8
      Top             =   2295
      Width           =   11400
      _ExtentX        =   20108
      _ExtentY        =   5503
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmValesSalida.frx":1136
      OLEDragMode     =   1
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   0
      Left            =   5490
      Picture         =   "frmValesSalida.frx":1152
      Style           =   1  'Graphical
      TabIndex        =   12
      Top             =   5535
      UseMaskColor    =   -1  'True
      Width           =   795
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   420
      Index           =   1
      Left            =   1575
      TabIndex        =   10
      Top             =   5535
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   45
      TabIndex        =   9
      Top             =   5535
      Width           =   1470
   End
   Begin VB.TextBox txtNumeroValeSalida 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroValeSalida"
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
      Left            =   1755
      TabIndex        =   0
      Top             =   90
      Width           =   1275
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1050
      Left            =   1755
      TabIndex        =   7
      Top             =   1215
      Width           =   9600
      _ExtentX        =   16933
      _ExtentY        =   1852
      _Version        =   393217
      TextRTF         =   $"frmValesSalida.frx":17BC
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   13
      Top             =   6045
      Width           =   11460
      _ExtentX        =   20214
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   10845
      Top             =   630
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
            Picture         =   "frmValesSalida.frx":183E
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmValesSalida.frx":1950
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmValesSalida.frx":1DA2
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmValesSalida.frx":21F4
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaValeSalida"
      Height          =   330
      Index           =   0
      Left            =   1755
      TabIndex        =   4
      Top             =   450
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   22675457
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   0
      Left            =   4365
      TabIndex        =   2
      Tag             =   "Obras"
      Top             =   450
      Width           =   2400
      _ExtentX        =   4233
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCentroCosto"
      Height          =   315
      Index           =   1
      Left            =   9180
      TabIndex        =   3
      Tag             =   "CentrosCosto"
      Top             =   45
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdCentroCosto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Aprobo"
      Height          =   315
      Index           =   2
      Left            =   1755
      TabIndex        =   6
      Tag             =   "Empleados"
      Top             =   855
      Width           =   5010
      _ExtentX        =   8837
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin VB.Label lblEstado 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "Label1"
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
      Left            =   8235
      TabIndex        =   34
      Top             =   450
      Visible         =   0   'False
      Width           =   1905
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
      TabIndex        =   31
      Top             =   2025
      Width           =   1545
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero vale preimpreso :"
      Height          =   240
      Index           =   1
      Left            =   3195
      TabIndex        =   30
      Top             =   90
      Width           =   1890
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Autorizaciones : "
      Height          =   285
      Index           =   2
      Left            =   7020
      TabIndex        =   29
      Top             =   855
      Width           =   1575
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Aprobo : "
      Height          =   240
      Index           =   2
      Left            =   90
      TabIndex        =   21
      Top             =   900
      Width           =   1620
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "C.costo :"
      Height          =   240
      Index           =   1
      Left            =   8280
      TabIndex        =   20
      Top             =   90
      Visible         =   0   'False
      Width           =   720
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Observaciones :"
      Height          =   240
      Index           =   0
      Left            =   90
      TabIndex        =   17
      Top             =   1260
      Width           =   1620
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   90
      TabIndex        =   16
      Top             =   495
      Width           =   1620
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Numero de comprob.:"
      Height          =   240
      Index           =   14
      Left            =   90
      TabIndex        =   15
      Top             =   135
      Width           =   1620
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Obra :"
      Height          =   240
      Index           =   0
      Left            =   3195
      TabIndex        =   14
      Top             =   495
      Width           =   1125
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
         Caption         =   "Anular"
         Index           =   3
      End
   End
End
Attribute VB_Name = "frmValesSalida"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.ValeSalida
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Public Ok As Boolean
Private mvarId As Long, mIdAprobo As Long
Private mDetalleRequerimientos As String, mvarExigirEquipoDestino As String
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

   If mvarId > 0 And Cual < 0 Then
      MsgBox "No puede modificar una solicitud de materiales a almacen ya registrada, eliminela.", vbCritical
      Exit Sub
   End If
   
   If Not Option2.Value Then
      If Not IsNumeric(dcfields(0).BoundText) Then
         MsgBox "Debe definir la obra antes de agregar materiales!", vbCritical
         Exit Sub
      End If
   End If
   
   Dim oF As frmDetValesSalida
   Dim oL As ListItem
   
   Set oF = New frmDetValesSalida
   
   With oF
      Set .ValeSalida = origen
      .Id = Cual
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
            .Text = oF.txtNumeroLMateriales.Text
            .SubItems(1) = "" & oL.Tag
            .SubItems(2) = "" & oF.txtNumeroItem.Text
            .SubItems(3) = "" & oF.txtNumeroReserva.Text
            .SubItems(4) = "" & oF.txtCodigoArticulo.Text
            .SubItems(5) = "" & oF.DataCombo1(1).Text
            .SubItems(6) = "" & oF.txtCantidad.Text
            If oF.mvarCantidadAdicional <> 0 Then
               .SubItems(7) = "" & oF.txtCantidad1.Text
               .SubItems(8) = "" & oF.txtCantidad2.Text
            End If
            .SubItems(9) = "" & oF.DataCombo1(0).Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
      
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar una solicitud de materiales a almacen sin detalles"
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim mNum As Long, mvarSeguro As Integer
         Dim mCantVale As Double, mCantidad As Double
         Dim mAuxS1 As String
         Dim oPar As ComPronto.Parametro
         Dim oRs As ADOR.Recordset
         Dim oRs1 As ADOR.Recordset
         
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
                  .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
            .Fields("Observaciones").Value = rchObservaciones.Text
         End With
         
         If mvarId < 0 Then
'            Set oPar = Aplicacion.Parametros.Item(1)
'            With oPar.Registro
'               mNum = .Fields("ProximoNumeroValeSalida").Value
'               origen.Registro.Fields("NumeroValeSalida").Value = mNum
'               .Fields("ProximoNumeroValeSalida").Value = mNum + 1
'            End With
'            oPar.Guardar
'            Set oPar = Nothing
         End If
         
         mCantidad = 0
         
         Set oRs = origen.DetValesSalida.Registros
         If oRs.RecordCount > 0 Then
            With oRs
               .MoveFirst
               Do While Not .EOF
                  If Not .Fields("Eliminado").Value Then
                     If IsNull(.Fields("IdArticulo").Value) Then
                        Set oRs = Nothing
                        MsgBox "Articulo no definido!", vbExclamation
                        Exit Sub
                     End If
                     If IsNull(.Fields("IdUnidad").Value) Then
                        Set oRs = Nothing
                        MsgBox "Unidad de medida no definida!", vbExclamation
                        Exit Sub
                     End If
                     If mvarExigirEquipoDestino = "SI" And _
                           IsNull(.Fields("IdEquipoDestino").Value) Then
                        Set oRs = Nothing
                        MsgBox "Equipo destino no definido en detalle!", vbExclamation
                        Exit Sub
                     End If
                     If Not IsNull(.Fields("Cantidad").Value) Then
                        mCantidad = mCantidad + .Fields("Cantidad").Value
                     End If
                     If mvarId <= 0 And Not IsNull(.Fields("IdDetalleRequerimiento").Value) Then
                        Set oRs1 = Aplicacion.Requerimientos.TraerFiltrado("_DatosRequerimiento", .Fields("IdDetalleRequerimiento").Value)
                        If oRs1.RecordCount > 0 Then
                           mCantVale = IIf(IsNull(oRs1.Fields("Entregado").Value), 0, oRs1.Fields("Entregado").Value) - _
                                       IIf(IsNull(oRs1.Fields("SalidaPorVales").Value), 0, oRs1.Fields("SalidaPorVales").Value)
                           If mCantVale <= 0 Then
                              mCantVale = IIf(IsNull(oRs1.Fields("Cantidad").Value), 0, oRs1.Fields("Cantidad").Value) - _
                                          IIf(IsNull(oRs1.Fields("SalidaPorVales").Value), 0, oRs1.Fields("SalidaPorVales").Value)
                           End If
                           If mCantVale < 0 Then mCantVale = 0
                           If .Fields("Cantidad").Value > mCantVale Then
                              mAuxS1 = "Al articulo " & oRs1.Fields("DescripcionArt").Value & vbCrLf & _
                                       "le faltan vales por " & mCantVale & ", este vale es por " & _
                                       .Fields("Cantidad").Value & "."
                              If BuscarClaveINI("No permitir vales por cantidades mayores a las requeridas") = "SI" Then
                                 MsgBox mAuxS1 & vbCrLf & "Corrija las cantidades o elimine el item", vbExclamation
                                 oRs1.Close
                                 Set oRs1 = Nothing
                                 Exit Sub
                              Else
                                 mvarSeguro = MsgBox(mAuxS1 & vbCrLf & "Esta seguro que desea continuar ?", vbYesNo, "Vale de salida")
                                 If mvarSeguro = vbNo Then
                                    oRs1.Close
                                    Set oRs1 = Nothing
                                    Exit Sub
                                 End If
                              End If
                           End If
                        End If
                        oRs1.Close
                        Set oRs1 = Nothing
                     End If
                  End If
                  .MoveNext
               Loop
            End With
         End If
         Set oRs = Nothing
         
         If mCantidad = 0 Then
            MsgBox "La cantidad total es cero, no puede registrar el vale", vbExclamation
            Exit Sub
         End If
         
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
         Else
            est = Modificacion
         End If
            
         If Not actL2 Is Nothing Then
            With actL2
               .ListaEditada = "ValesSalidaTodos,+SubVS2"
               .AccionRegistro = est
               .Disparador = mvarId
            End With
         End If
         
         Ok = True
         
         Unload Me

      Case 1
      
         Unload Me

      Case 2
      
         Dim Cadena As String
         Cadena = Lista.GetString
         If Len(Trim(Cadena)) > 0 Then
            Cadena = Replace(Cadena, "Id" & vbTab, "ValeSalida" & vbTab)
            With Clipboard
               .Clear
               .SetText Cadena
            End With
            MsgBox "Items copiados correctamente", vbInformation
         Else
            MsgBox "No hay informacion a copiar", vbExclamation
         End If
   
      Case 3
      
         AnularVale
         
   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oDet As DetValeSalida
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim oRsAut As ADOR.Recordset
   Dim dtf As DTPicker
   Dim ListaVacia As Boolean
   Dim i As Integer, mCantidadFirmas As Integer
   Dim mIdRequerimiento As Long
   Dim mCantVale As Double
   Dim mVector
   
   mvarId = vnewvalue
   Ok = False
   ListaVacia = False
   
   mvarExigirEquipoDestino = BuscarClaveINI("Exigir equipo destino en salida de materiales")
   If mvarExigirEquipoDestino = "" Then mvarExigirEquipoDestino = "NO"
   
   Set oAp = Aplicacion
   
   Set origen = oAp.ValesSalida.Item(vnewvalue)
   
   If glbParametrizacionNivel1 Then
      origen.NivelParametrizacion = 1
   End If
   
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetValesSalida.TraerMascara
                     ListaVacia = True
                  Else
                     Set oRs = origen.DetValesSalida.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           Set oDet = origen.DetValesSalida.Item(oRs.Fields(0).Value)
                           oDet.Modificado = True
                           Set oDet = Nothing
                           oRs.MoveNext
                        Loop
                        ListaVacia = False
                     Else
                        Set oControl.DataSource = origen.DetValesSalida.TraerMascara
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
      cmd(3).Enabled = False
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      Option1.Value = True
      Set oPar = oAp.Parametros.Item(1)
      With origen.Registro
         .Fields("NumeroValeSalida").Value = oPar.Registro.Fields("ProximoNumeroValeSalida").Value
         If glbIdObraAsignadaUsuario > 0 Then .Fields("IdObra").Value = glbIdObraAsignadaUsuario
      End With
      Set oPar = Nothing
      mIdAprobo = 0
      If Len(Me.DetalleRequerimientos) > 0 Then
         mVector = VBA.Split(Me.DetalleRequerimientos, ",")
         mIdRequerimiento = 0
         For i = 0 To UBound(mVector)
            Set oRs = oAp.Requerimientos.TraerFiltrado("_DatosRequerimiento", mVector(i))
            If oRs.RecordCount > 0 Then
               If mIdRequerimiento = 0 Then
                  mIdRequerimiento = oRs.Fields("IdRequerimiento").Value
                  Set oRsAut = oAp.Requerimientos.TraerFiltrado("_PorId", mIdRequerimiento)
                  If oRsAut.RecordCount > 0 Then
                     With origen.Registro
                        .Fields("IdObra").Value = oRsAut.Fields("IdObra").Value
                        rchObservaciones.Text = "Generacion de vale desde consulta de RM pendientes."
                        dcfields(0).Enabled = False
                     End With
                  End If
                  oRsAut.Close
               End If
               mCantVale = IIf(IsNull(oRs.Fields("Entregado").Value), 0, oRs.Fields("Entregado").Value) - _
                           IIf(IsNull(oRs.Fields("SalidaPorVales").Value), 0, oRs.Fields("SalidaPorVales").Value)
               If mCantVale <= 0 Then
                  mCantVale = IIf(IsNull(oRs.Fields("Cantidad").Value), 0, oRs.Fields("Cantidad").Value) - _
                              IIf(IsNull(oRs.Fields("SalidaPorVales").Value), 0, oRs.Fields("SalidaPorVales").Value)
               End If
               If mCantVale < 0 Then mCantVale = 0
               With origen.DetValesSalida.Item(-1)
                  With .Registro
                     .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                     .Fields("Cantidad").Value = mCantVale
                     .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     .Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
                     .Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
                     .Fields("IdDetalleRequerimiento").Value = mVector(i)
                     .Fields("IdEquipoDestino").Value = oRs.Fields("IdEquipoDestino").Value
                  End With
                  .Modificado = True
               End With
            End If
            oRs.Close
         Next
         ListaVacia = False
         Set Lista.DataSource = origen.DetValesSalida.RegistrosConFormato
      End If
   Else
      dcfields(2).Enabled = False
      DTFields(0).Enabled = False
      Frame1.Enabled = False
      txtNumeroValePreimpreso.Enabled = False
      With origen.Registro
         If Not IsNull(.Fields("IdObra").Value) Then
            Option1.Value = True
         Else
            Option2.Value = True
         End If
         If Not IsNull(.Fields("Cumplido").Value) And .Fields("Cumplido").Value = "SI" Then
            With lblEstado
               .Caption = "CUMPLIDO"
               .Visible = True
            End With
         End If
         If Not IsNull(.Fields("Cumplido").Value) And .Fields("Cumplido").Value = "AN" Then
            With lblEstado
               .Caption = "ANULADO"
               .Visible = True
            End With
            cmd(3).Enabled = False
         End If
         If Not IsNull(.Fields("Aprobo").Value) Then
            mIdAprobo = .Fields("Aprobo").Value
            Check1(0).Value = 1
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
      mCantidadFirmas = 0
      Set oRsAut = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(EnumFormularios.SolicitudMateriales, 0))
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
      Set oRsAut = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(EnumFormularios.SolicitudMateriales, mvarId))
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
   End If
   
   If ListaVacia Then
      Lista.ListItems.Clear
   End If
   
   If glbIdObraAsignadaUsuario > 0 Then dcfields(0).Enabled = False
   
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
   End If
   
   If lblEstado.Visible Then
      cmd(0).Enabled = False
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
End Property

Private Sub cmdImpre_Click(Index As Integer)

   Dim mvarOK As Boolean
   Dim mCopias As Integer
   Dim mFormulario As String, mCC As String, mCodigo As String
      
   mCopias = 0
   If Index = 0 Then
      Dim oF As frmCopiasImpresion
      Set oF = New frmCopiasImpresion
      With oF
         .txtCopias.Visible = False
         .lblCopias.Visible = False
         .lblImpresora.Visible = False
         .Combo1.Visible = False
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
   End If

   Me.MousePointer = vbHourglass

   On Error GoTo Mal

   Dim oW As Word.Application
   
   Set oW = CreateObject("Word.Application")
   
   oW.Visible = True
   With oW.Documents.Add(glbPathPlantillas & "\SolicitudMateriales_" & glbEmpresaSegunString & ".dot")
      oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId
      oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
      'oW.Application.Run MacroName:="DatosDelPie"
      If Index = 0 Then
         oW.ActiveDocument.PrintOut False, , , , , , , mCopias
         oW.ActiveDocument.Close False
      End If
      If Index = 0 Then oW.Quit
   End With

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

Private Sub cmdPegar_Click()

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset

   If Not Clipboard.GetFormat(vbCFText) Then
      MsgBox "No hay informacion en el portapapeles", vbCritical
      Exit Sub
   End If
   
   s = Clipboard.GetText(vbCFText)
   
   Filas = Split(s, vbCrLf)
   Columnas = Split(Filas(LBound(Filas)), vbTab)
   
   If UBound(Columnas) < 2 Then
      MsgBox "No hay informacion para copiar", vbCritical
      Exit Sub
   End If
   
   If InStr(1, Columnas(0), "LMateriales") <> 0 Then
   
      Set oAp = Aplicacion
      
      For iFilas = LBound(Filas) + 1 To UBound(Filas)
         Columnas = Split(Filas(iFilas), vbTab)
         Set oRs = oAp.TablasGenerales.TraerFiltrado("DetLMateriales", "_UnItem", Columnas(0))
         If oRs.RecordCount > 0 Then
            If Not IsNull(oRs.Fields("IdArticulo").Value) Then
               Set oRsAux = oAp.Articulos.Item(oRs.Fields("IdArticulo").Value).Registro
'               Set oL = Lista.ListItems.Add()
               With origen.DetValesSalida.Item(-1)
                  .Registro.Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                  .Registro.Fields("Cantidad").Value = oRs.Fields("Cantidad").Value
                  .Registro.Fields("Cantidad1").Value = oRs.Fields("Cantidad1").Value
                  .Registro.Fields("Cantidad2").Value = oRs.Fields("Cantidad2").Value
                  .Registro.Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                  .Registro.Fields("IdDetalleLMateriales").Value = oRs.Fields("IdDetalleLMateriales").Value
                  
'                  oL.Tag = .Id
'                  oL.Text = "" & oAp.LMateriales.Item(oRs.Fields("IdLMateriales").Value).Registro.Fields("NumeroLMateriales").Value
'                  oL.SubItems(1) = "" & .Id
'                  oL.SubItems(2) = "" & IIf(IsNull(oRs.Fields("NumeroOrden").Value), 0, oRs.Fields("NumeroOrden").Value)
'                  oL.SubItems(3) = ""
'                  oL.SubItems(4) = "" & IIf(IsNull(oRsAux.Fields("Codigo").Value), "", oRsAux.Fields("Codigo").Value)
'                  oL.SubItems(5) = "" & IIf(IsNull(oRsAux.Fields("Descripcion").Value), "", oRsAux.Fields("Descripcion").Value)
'                  oL.SubItems(6) = "" & oRs.Fields("Cantidad").Value
'                  oL.SubItems(7) = "" & oRs.Fields("Cantidad1").Value
'                  oL.SubItems(8) = "" & oRs.Fields("Cantidad2").Value
'                  oL.SubItems(9) = "" & oAp.Unidades.Item(oRs.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value
                  
'                  oL.SmallIcon = "Nuevo"
                  .Modificado = True
               End With
               oRsAux.Close
            End If
            oRs.Close
         End If
      Next
      
      Clipboard.Clear
   
      Set oRsAux = Nothing
      Set oRs = Nothing
      Set oAp = Nothing
      
      Set Lista.DataSource = origen.DetValesSalida.RegistrosConFormato
      
   Else
      
      MsgBox "Objeto invalido!", vbCritical
      Exit Sub
   
   End If
   
End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   If Index = 2 And Me.Visible And IsNumeric(dcfields(Index).BoundText) Then
      If dcfields(Index).BoundText <> mIdAprobo Then
         PideAutorizacion
      End If
   End If
   
End Sub

Private Sub dcfields_GotFocus(Index As Integer)
   
   If Index <> 2 Then
      SendKeys "%{DOWN}"
   End If

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   End If
   
End Sub

Private Sub dcfields_LostFocus(Index As Integer)

   If IsNumeric(dcfields(Index).BoundText) Then
      origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
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

Private Sub Lista_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long, NroItem As Long, idDet As Long
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRsRM As ADOR.Recordset
   Dim oRsLMat As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRsArt As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then
      
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 2), "conjunto") <> 0 Then
      
         Filas = Split(s, vbCrLf)
         Columnas = Split(Filas(1), vbTab)
      
         If UBound(Columnas) < 2 Then
            MsgBox "No hay informacion para copiar", vbCritical
            Exit Sub
         End If
         
         Dim oF As frm_Aux
         Dim mOk As Boolean
         Dim mCantidadConjuntos As Integer
         
         Set oF = New frm_Aux
         With oF
            .Label1 = "Cant. conjuntos :"
            .Text1.Text = 1
            .Show vbModal, Me
            mOk = .Ok
            mCantidadConjuntos = Val(.Text1.Text)
         End With
         Unload oF
         Set oF = Nothing
         
         If Not mOk Then Exit Sub
         
         Set oAp = Aplicacion
         
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            Set oRsDet = oAp.Conjuntos.TraerFiltrado("_DetallesPorId", Columnas(0))
            Do While Not oRsDet.EOF
               If Not IsNull(oRsDet.Fields("IdArticulo").Value) Then
               Set oRsArt = oAp.Articulos.Item(oRsDet.Fields("IdArticulo").Value).Registro
               With origen.DetValesSalida.Item(-1)
                  .Registro.Fields("Cantidad").Value = oRsDet.Fields("Cantidad").Value * mCantidadConjuntos
                  .Registro.Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                  .Registro.Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                  .Registro.Fields("Cantidad1").Value = oRsDet.Fields("Cantidad1").Value
                  .Registro.Fields("Cantidad2").Value = oRsDet.Fields("Cantidad2").Value
                  .Modificado = True
                  idDet = .Id
               End With
               oRsArt.Close
               Set oRsArt = Nothing
               End If
               oRsDet.MoveNext
            Loop
            oRsDet.Close
            Set oRsDet = Nothing
         Next
         Set oAp = Nothing
         
         Set Lista.DataSource = origen.DetValesSalida.RegistrosConFormato
      
         Clipboard.Clear
      
      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "Numero de vale") <> 0 Then
      
         Filas = Split(s, vbCrLf)
         Columnas = Split(Filas(1), vbTab)
      
         If UBound(Columnas) < 2 Then
            MsgBox "No hay informacion para copiar", vbCritical
            Exit Sub
         End If
         
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            Set oRsDet = Aplicacion.ValesSalida.TraerFiltrado("_DetallesPorIdValeSalida", Columnas(2))
            Do While Not oRsDet.EOF
               With origen.DetValesSalida.Item(-1)
                  For i = 2 To oRsDet.Fields.Count - 1
                     If oRsDet.Fields(i).Name <> "Estado" And _
                           oRsDet.Fields(i).Name <> "Cumplido" And _
                           oRsDet.Fields(i).Name <> "IdDetalleValeSalidaOriginal" And _
                           oRsDet.Fields(i).Name <> "IdValeSalidaOriginal" And _
                           oRsDet.Fields(i).Name <> "IdOrigenTransmision" Then
                        .Registro.Fields(i).Value = oRsDet.Fields(i).Value
                     End If
                  Next
                  .Modificado = True
                  idDet = .Id
               End With
               oRsDet.MoveNext
            Loop
            oRsDet.Close
            Set oRsDet = Nothing
         Next
         
         Set Lista.DataSource = origen.DetValesSalida.RegistrosConFormato
      
         Clipboard.Clear
      
      Else
         
         MsgBox "Objeto invalido!"
         Exit Sub
      
      End If

   End If
   
End Sub

Private Sub Lista_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long
   Dim iColumnas As Long
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

Private Sub Lista_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
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
            MsgBox "No puede modificar un vale ya registrado!", vbCritical
            Exit Sub
         End If
         If Not Lista.SelectedItem Is Nothing Then
            With Lista.SelectedItem
               origen.DetValesSalida.Item(.Tag).Eliminado = True
               .SmallIcon = "Eliminado"
               .ToolTipText = .SmallIcon
            End With
         End If
      Case 3
         If Not Lista.SelectedItem Is Nothing Then
            AnularItems
         End If
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

Private Sub Option1_Click()

   If mvarId < 0 And Option1.Value Then
      dcfields(0).Enabled = True
      dcfields(1).Enabled = False
      origen.Registro.Fields("IdCentroCosto").Value = Null
   End If
   
End Sub

Private Sub Option2_Click()

   If mvarId < 0 And Option2.Value Then
      dcfields(0).Enabled = False
      dcfields(1).Enabled = True
      origen.Registro.Fields("IdObra").Value = Null
   End If
   
End Sub

Private Sub txtNumeroValePreimpreso_GotFocus()

   With txtNumeroValePreimpreso
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroValePreimpreso_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtNumeroValeSalida_GotFocus()

   With txtNumeroValeSalida
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroValeSalida_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub PideAutorizacion()

   Dim oF As frmAutorizacion1
   Set oF = New frmAutorizacion1
   With oF
      .IdUsuario = dcfields(2).BoundText
      .Show vbModal, Me
   End With
   If Not oF.Ok Then
      With origen.Registro
         .Fields(dcfields(2).DataField).Value = Null
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

Public Sub AnularItems()

   Dim oL As ListItem
   Dim mIdDet As Long
   Dim mSeñal As Boolean
   
   mSeñal = False
   For Each oL In Lista.ListItems
      With oL
         If .Selected Then
            mIdDet = Val(oL.SubItems(1))
            If Not IsNull(origen.DetValesSalida.Item(mIdDet).Registro.Fields("Estado").Value) Then
               mSeñal = True
            Else
               origen.DetValesSalida.Item(mIdDet).Registro.Fields("Estado").Value = "AN"
               origen.DetValesSalida.Item(mIdDet).Modificado = True
               .SubItems(11) = "AN"
               .SmallIcon = "Eliminado"
               .ToolTipText = .SmallIcon
            End If
         End If
      End With
   Next
   If mSeñal Then
      MsgBox "Hay items que no se anularon por tener movimientos", vbCritical
   End If

End Sub

Public Property Get DetalleRequerimientos() As String

   DetalleRequerimientos = mDetalleRequerimientos

End Property

Public Property Let DetalleRequerimientos(ByVal vnewvalue As String)

   mDetalleRequerimientos = vnewvalue

End Property

Public Sub AnularVale()

   Dim oF As frmAutorizacion
   Dim mOk As Boolean
   Dim mUsuario As String
   Dim mIdAutorizaAnulacion As Integer
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.SolicitudMateriales
      '.Administradores = True
      .Show vbModal, Me
      mOk = .Ok
      mIdAutorizaAnulacion = .IdAutorizo
      mUsuario = .Autorizo
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then
      Exit Sub
   End If
   Me.Refresh
   
   Dim mSeguro As Integer
   mSeguro = MsgBox("Esta seguro de anular la salida?", vbYesNo, "Anulacion de vale de salida")
   If mSeguro = vbNo Then
      Exit Sub
   End If

   
   Dim oRs As ADOR.Recordset
   Dim mError As String
   mError = ""
   Set oRs = Aplicacion.ValesSalida.TraerFiltrado("_SalidasPorIdValeSalida", mvarId)
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            mError = mError & vbCrLf & "" & .Fields("Numero").Value & " del " & .Fields("Fecha").Value
            .MoveNext
         Loop
      End If
      .Close
   End With
   Set oRs = Nothing
   
   If Len(mError) > 0 Then
      MsgBox "Hay items del vale que estan apuntados por las siguientes " & _
            "salidas de materiales :" & mError & vbCrLf & _
            "La anulacion ha sido abortada", vbExclamation
      Exit Sub
   End If
   
   Dim of1 As frmAnulacion
   Dim mMotivoAnulacion As String
   Set of1 = New frmAnulacion
   With of1
      .Caption = "Motivo de anulacion"
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
   
   Dim oL As ListItem
   With origen
      For Each oL In Lista.ListItems
         With origen.DetValesSalida.Item(oL.Tag)
            .Registro.Fields("Estado").Value = "AN"
            .Modificado = True
         End With
      Next
      .Registro.Fields("Cumplido").Value = "AN"
      .Registro.Fields("IdUsuarioAnulo").Value = mIdAutorizaAnulacion
      .Registro.Fields("FechaAnulacion").Value = Now
      .Registro.Fields("MotivoAnulacion").Value = mMotivoAnulacion
      .Guardar
   End With

   With actL2
      .ListaEditada = "ValesSalidaTodos,+SubVS2"
      .AccionRegistro = Modificacion
      .Disparador = origen.Registro.Fields(0).Value
   End With
   
   Unload Me

End Sub
