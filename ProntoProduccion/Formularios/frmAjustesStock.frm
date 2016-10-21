VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.3#0"; "Controles1013.ocx"
Begin VB.Form frmAjustesStock 
   Caption         =   "Ajustes de stock"
   ClientHeight    =   6300
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11580
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   6300
   ScaleWidth      =   11580
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   1
      Left            =   4050
      Style           =   1  'Graphical
      TabIndex        =   32
      Top             =   5535
      Width           =   840
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   0
      Left            =   3150
      Style           =   1  'Graphical
      TabIndex        =   31
      Top             =   5535
      UseMaskColor    =   -1  'True
      Width           =   840
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Ajuste automatico de saldos negativos"
      Height          =   420
      Index           =   2
      Left            =   4950
      TabIndex        =   27
      Top             =   5535
      Width           =   2955
   End
   Begin VB.Frame Frame2 
      Caption         =   "Tipo de ajuste :"
      Height          =   555
      Left            =   8325
      TabIndex        =   24
      Top             =   135
      Width           =   3165
      Begin VB.OptionButton Option1 
         Caption         =   "Ajuste normal"
         Height          =   195
         Left            =   135
         TabIndex        =   26
         Top             =   270
         Width           =   1320
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Ajuste inventario"
         Height          =   195
         Left            =   1485
         TabIndex        =   25
         Top             =   270
         Width           =   1590
      End
   End
   Begin VB.TextBox txtNumeroMarbete 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroMarbete"
      Height          =   285
      Left            =   10095
      TabIndex        =   22
      Top             =   5580
      Width           =   1440
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   0
      Left            =   180
      TabIndex        =   20
      Top             =   1260
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   1
      Left            =   405
      TabIndex        =   19
      Top             =   1260
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   2
      Left            =   630
      TabIndex        =   18
      Top             =   1260
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   3
      Left            =   855
      TabIndex        =   17
      Top             =   1260
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   4
      Left            =   1080
      TabIndex        =   16
      Top             =   1260
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   5
      Left            =   1305
      TabIndex        =   15
      Top             =   1260
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   6
      Left            =   1530
      TabIndex        =   14
      Top             =   1260
      Visible         =   0   'False
      Width           =   150
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   825
      Left            =   1800
      TabIndex        =   3
      Top             =   495
      Width           =   6405
      _ExtentX        =   11298
      _ExtentY        =   1455
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmAjustesStock.frx":0000
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   420
      Index           =   1
      Left            =   1620
      TabIndex        =   6
      Top             =   5535
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   90
      TabIndex        =   5
      Top             =   5535
      Width           =   1470
   End
   Begin VB.TextBox txtNumeroAjusteStock 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroAjusteStock"
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
      Left            =   1800
      TabIndex        =   0
      Top             =   90
      Width           =   1095
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   7
      Top             =   6015
      Width           =   11580
      _ExtentX        =   20426
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   7830
      Top             =   5445
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
            Picture         =   "frmAjustesStock.frx":0082
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAjustesStock.frx":00E0
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAjustesStock.frx":013E
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAjustesStock.frx":019C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaAjuste"
      Height          =   330
      Index           =   0
      Left            =   3780
      TabIndex        =   1
      Top             =   90
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   57475073
      CurrentDate     =   36377
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3885
      Left            =   0
      TabIndex        =   4
      Top             =   1575
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   6853
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmAjustesStock.frx":01FA
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdRealizo"
      Height          =   315
      Index           =   0
      Left            =   9090
      TabIndex        =   2
      Tag             =   "Empleados"
      Top             =   810
      Width           =   2400
      _ExtentX        =   4233
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdAprobo"
      Height          =   315
      Index           =   1
      Left            =   9090
      TabIndex        =   12
      Tag             =   "Empleados"
      Top             =   1170
      Width           =   2400
      _ExtentX        =   4233
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   2
      Left            =   6120
      TabIndex        =   29
      Tag             =   "Obras"
      Top             =   90
      Width           =   2040
      _ExtentX        =   3598
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obra :"
      Height          =   255
      Index           =   3
      Left            =   5175
      TabIndex        =   30
      Top             =   135
      Width           =   870
   End
   Begin VB.Label lblEstado 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "MODO CODIGO DE BARRA"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   1845
      TabIndex        =   28
      Top             =   1350
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Numero de marbete : "
      Height          =   240
      Index           =   1
      Left            =   8460
      TabIndex        =   23
      Top             =   5625
      Width           =   1530
   End
   Begin VB.Label lblLabels 
      Caption         =   "Autorizaciones : "
      Height          =   240
      Index           =   2
      Left            =   180
      TabIndex        =   21
      Top             =   945
      Width           =   1530
   End
   Begin VB.Label lblLabels 
      Caption         =   "Aprobo :"
      Height          =   240
      Index           =   1
      Left            =   8370
      TabIndex        =   13
      Top             =   1215
      Width           =   645
   End
   Begin VB.Label lblLabels 
      Caption         =   "Realizo : "
      Height          =   240
      Index           =   5
      Left            =   8325
      TabIndex        =   11
      Top             =   855
      Width           =   705
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   240
      Index           =   0
      Left            =   180
      TabIndex        =   10
      Top             =   540
      Width           =   1530
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   3015
      TabIndex        =   9
      Top             =   135
      Width           =   720
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ajuste de stock nro. :"
      Height          =   240
      Index           =   14
      Left            =   180
      TabIndex        =   8
      Top             =   135
      Width           =   1500
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
Attribute VB_Name = "frmAjustesStock"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.AjusteStock
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mIdAprobo As Long
Dim actL2 As ControlForm
Private mvarModoCodigoBarra As Boolean, mvarGrabado As Boolean, mvarModificado As Boolean
Private mCadena As String
Private mvarIdUnidadCU As Long, mvarFormatCodBar As Long
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
'      MsgBox "No puede modificar un ajuste ya grabado, haga otro ajuste.", vbCritical
'      Exit Sub
'   End If
   
   Dim oF As frmDetAjustesStock
   Dim oL As ListItem
   
   Set oF = New frmDetAjustesStock
   
   With oF
      Set .AjusteStock = origen
      If IsNumeric(dcfields(2).BoundText) Then
         .Obra = dcfields(2).BoundText
      End If
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Not IsNumeric(dcfields(2).BoundText) And IsNumeric(.Obra) Then
            dcfields(2).BoundText = .Obra
         End If
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
            .Text = oF.txtCodigoArticulo.Text
            .SubItems(1) = "" & oF.DataCombo1(1).Text & " " & oF.lblColor.Caption
            .SubItems(2) = "" & oF.txtPartida.Text
            .SubItems(3) = "" & oF.txtCantidad.Text
            .SubItems(4) = "" & Aplicacion.StockPorIdArticulo(oF.DataCombo1(1).BoundText)
            If oF.mvarCantidadAdicional <> 0 Then
               .SubItems(5) = "" & oF.txtCantidad1.Text
               .SubItems(6) = "" & oF.txtCantidad2.Text
            End If
            .SubItems(7) = "" & Aplicacion.Unidades.Item(oF.DataCombo1(0).BoundText).Registro.Fields("Descripcion").Value
            .SubItems(8) = oF.DataCombo1(2).Text
            .SubItems(9) = oF.DataCombo1(3).Text
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
            MsgBox "No se puede almacenar un Ajuste de stock sin detalles"
            Exit Sub
         End If
         
         Dim dtp As DTPicker
         Dim dc As DataCombo
         Dim est As EnumAcciones
         Dim mNum As Long, mvarImprime As Integer, mvarSale As Integer
         Dim mvarAux1 As String, mvarAux2 As String, mvarArticulo As String
         Dim mvarStock As Double, mvarStock1 As Double
         Dim oPar As ComPronto.Parametro
         Dim oRs As ADOR.Recordset
         Dim oRsStk As ADOR.Recordset
         
         mvarAux1 = BuscarClaveINI("Inhabilitar stock negativo")
         mvarAux2 = BuscarClaveINI("Inhabilitar stock global negativo")
         If mvarAux1 = "SI" Or mvarAux2 = "SI" Then
            Set oRs = origen.DetAjustesStock.Registros
            If oRs.RecordCount > 0 Then
               With oRs
                  .MoveFirst
                  Do While Not .EOF
                     If Not .Fields("Eliminado").Value Then
                        Set oRsStk = Aplicacion.Articulos.TraerFiltrado("_StockTotalPorArticulo", _
                                       .Fields("IdArticulo").Value)
                        mvarStock = 0
                        If oRsStk.RecordCount > 0 Then
                           mvarStock = IIf(IsNull(oRsStk.Fields("Stock").Value), 0, oRsStk.Fields("Stock").Value)
                           mvarArticulo = IIf(IsNull(oRsStk.Fields("Articulo").Value), "", oRsStk.Fields("Articulo").Value)
                        End If
                        oRsStk.Close
                        Set oRsStk = Nothing
                        If mvarId < 0 Then
                           If mvarStock + IIf(IsNull(.Fields("CantidadUnidades").Value), 0, .Fields("CantidadUnidades").Value) < 0 Then
                              MsgBox "El articulo " & mvarArticulo & vbCrLf & _
                                       "dejaria el stock negativo, reingrese", vbExclamation
                              Exit Sub
                           End If
                        Else
                           Set oRsStk = Aplicacion.TablasGenerales.TraerUno("DetAjustesStock", .Fields(0).Value)
                           mvarStock1 = 0
                           If oRsStk.RecordCount > 0 Then
                              mvarStock1 = IIf(IsNull(oRsStk.Fields("CantidadUnidades").Value), 0, oRsStk.Fields("CantidadUnidades").Value)
                           End If
                           oRsStk.Close
                           Set oRsStk = Nothing
                           If mvarStock + IIf(IsNull(.Fields("CantidadUnidades").Value), 0, .Fields("CantidadUnidades").Value) - mvarStock1 < 0 Then
                              MsgBox "El articulo " & mvarArticulo & vbCrLf & _
                                       "dejaria el stock negativo, reingrese", vbExclamation
                              Exit Sub
                           End If
                        End If
                     End If
                     .MoveNext
                  Loop
               End With
            End If
            Set oRs = Nothing
         End If
         
         With origen.Registro
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
         
            For Each dc In dcfields
               If dc.Enabled And Len(dc.DataField) > 0 Then
                  If Len(Trim(dc.BoundText)) = 0 Then
                     MsgBox "Falta completar el campo " & IIf(mId(dc.DataField, 1, 2) = "Id", mId(dc.DataField, 3, 20), dc.DataField), vbCritical
                     Exit Sub
                  End If
                  If Len(Trim(dc.BoundText)) <> 0 Then .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
         
            If Option1.Value Then
               .Fields("TipoAjuste").Value = "N"
            Else
               If Len(Trim(txtNumeroMarbete.Text)) = 0 Or Not IsNumeric(txtNumeroMarbete.Text) Then
                  MsgBox "Numero de marbete incorrecto", vbExclamation
                  Exit Sub
               End If
               .Fields("TipoAjuste").Value = "I"
            End If
            .Fields("Observaciones").Value = rchObservaciones.Text

            If mvarId < 0 Then
               .Fields("IdUsuarioIngreso").Value = glbIdUsuario
               .Fields("FechaIngreso").Value = Now
            Else
               .Fields("IdUsuarioModifico").Value = glbIdUsuario
               .Fields("FechaModifico").Value = Now
            End If
         End With
         
         If mvarId < 0 Then
            Set oPar = Aplicacion.Parametros.Item(1)
            With oPar.Registro
               mNum = .Fields("ProximoNumeroAjusteStock").Value
               origen.Registro.Fields("NumeroAjusteStock").Value = mNum
               .Fields("ProximoNumeroAjusteStock").Value = mNum + 1
            End With
            oPar.Guardar
            Set oPar = Nothing
            mvarGrabado = True
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
            
         mvarModificado = False
         
         With actL2
            .ListaEditada = "AjustesStockTodos,+SubAJ2"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
         
         mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de ajuste de stock")
         If mvarImprime = vbYes Then
            cmdImpre_Click (0)
         End If
      
         Unload Me

      Case 1
      
         If mvarModificado Then
            mvarSale = MsgBox("Hay datos no grabados, desea salir igual ?", vbYesNo, "Salir")
            If mvarSale = vbNo Then
               Exit Sub
            End If
            mvarModificado = False
         End If
   
         Unload Me

      Case 2
      
         AjusteAutomatico
         
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oDet As DetAjusteStock
   Dim oRs As ADOR.Recordset
   Dim oRsAut As ADOR.Recordset
   Dim dtf As DTPicker
   Dim ListaVacia As Boolean
   Dim i As Integer, mCantidadFirmas As Integer
   Dim mIdObraDefault As Long
   Dim mAuxS1 As String
   Dim mAux1
   
   mvarId = vNewValue
   ListaVacia = False
   mvarModificado = False
   
   Set oAp = Aplicacion
   Set origen = oAp.AjustesStock.Item(vNewValue)
   
   If glbParametrizacionNivel1 Then
      lblFieldLabel(1).Visible = False
      txtNumeroMarbete.Visible = False
      Cmd(2).Visible = False
   End If
   
   Set oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
   mvarIdUnidadCU = oRs.Fields("IdUnidadPorUnidad").Value
   oRs.Close
   
   mAux1 = TraerValorParametro2("IdObraDefault")
   mIdObraDefault = IIf(IsNull(mAux1), 0, mAux1)
   
   mvarFormatCodBar = 1
   mAuxS1 = BuscarClaveINI("Modelo de registro de codigo de barras")
   If Len(mAuxS1) > 0 And IsNumeric(mAuxS1) Then mvarFormatCodBar = Val(mAuxS1)
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetAjustesStock.TraerMascara
                     ListaVacia = True
                  Else
                     Set oRs = origen.DetAjustesStock.TraerTodos
                     If Not oRs Is Nothing Then
                        If oRs.RecordCount <> 0 Then
                           Set oControl.DataSource = oRs
                           oRs.MoveFirst
                           Do While Not oRs.EOF
                              Set oDet = origen.DetAjustesStock.Item(oRs.Fields(0).Value)
                              oDet.Modificado = True
                              Set oDet = Nothing
                              oRs.MoveNext
                           Loop
                           ListaVacia = False
                        Else
                           Set oControl.DataSource = origen.DetAjustesStock.TraerMascara
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
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
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
      Set oPar = oAp.Parametros.Item(1)
      With origen.Registro
         .Fields("NumeroAjusteStock").Value = oPar.Registro.Fields("ProximoNumeroAjusteStock").Value
         .Fields("FechaRegistro").Value = Date
         .Fields("IdRealizo").Value = glbIdUsuario
      End With
      If mIdObraDefault <> 0 Then
         dcfields(2).BoundText = mIdObraDefault
         dcfields(2).Enabled = False
      End If
      If glbIdObraAsignadaUsuario > 0 Then dcfields(2).BoundText = glbIdObraAsignadaUsuario
      Set oPar = Nothing
      mvarGrabado = False
      mIdAprobo = 0
      Option1.Value = True
   Else
'      DTFields(0).Enabled = False
      dcfields(0).Enabled = False
      dcfields(1).Enabled = False
      With origen.Registro
         If Not IsNull(.Fields("TipoAjuste").Value) And .Fields("TipoAjuste").Value = "I" Then
            Option2.Value = True
         Else
            Option1.Value = True
         End If
         If Not IsNull(.Fields("IdAprobo").Value) Then
            Check1(0).Value = 1
            mIdAprobo = .Fields("IdAprobo").Value
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
      mCantidadFirmas = 0
      Set oRsAut = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(EnumFormularios.AjusteStock, 0))
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
      Set oRsAut = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(EnumFormularios.AjusteStock, mvarId))
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
   
   If glbIdObraAsignadaUsuario > 0 Then dcfields(2).Enabled = False
   
   If ListaVacia Then
      Lista.ListItems.Clear
   End If
   
   Cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then Cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      Cmd(0).Enabled = True
   End If
'   If mvarId > 0 Then cmd(0).Enabled = False

   Set oRs = Nothing
   Set oAp = Nothing
   
   MostrarTotales
   
End Property

Private Sub cmdImpre_Click(Index As Integer)

   If Not mvarGrabado Or mvarModificado Then
      MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
      Exit Sub
   End If

   Dim mvarOK As Boolean
   Dim mCopias As Integer
   
   If Index = 0 Then
      Dim oF 'As frmCopiasImpresion
      'Set oF = New frmCopiasImpresion
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

'   On Error GoTo Mal

   Dim oW As Word.Application
   
   Set oW = CreateObject("Word.Application")
   
   oW.Visible = True
   oW.Documents.Add (glbPathPlantillas & "\AjusteStock_" & glbEmpresaSegunString & ".dot")
   oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId
   oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
'   oW.Application.Run MacroName:="DatosDelPie"
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

   If IsNumeric(dcfields(Index).BoundText) And Len(dcfields(Index).DataField) > 0 Then
      If IsNull(origen.Registro.Fields(dcfields(Index).DataField).Value) Or origen.Registro.Fields(dcfields(Index).DataField).Value <> dcfields(Index).BoundText Then
         origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
         mvarModificado = True
      End If
   End If
   
End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   If Index = 1 And Me.Visible And IsNumeric(dcfields(Index).BoundText) Then
      If dcfields(Index).BoundText <> mIdAprobo Then
         PideAutorizacion
      End If
   End If

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   If Not mvarModoCodigoBarra Then Exit Sub
   
   If KeyAscii <> 13 Then
      mCadena = mCadena & Chr(KeyAscii)
      KeyAscii = 0
   ElseIf KeyAscii = 13 Then
      ProcesarCodigoBarras mCadena
      mCadena = ""
   ElseIf KeyAscii = 27 Then
      mvarModoCodigoBarra = False
      lblEstado.Visible = False
      DoEvents
      mCadena = ""
   End If

End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)

   'F12 para inicializar el modo ingreso por codigo de barras
   If KeyCode = 123 Then
      If Not IsNumeric(dcfields(2).BoundText) Then
         MsgBox "Antes de ingresar los codigos de barra debe definir la obra", vbExclamation
         Exit Sub
      End If
      mvarModoCodigoBarra = True
      lblEstado.Visible = True
      Lista.SetFocus
      DoEvents
   ElseIf KeyCode = 27 And mvarModoCodigoBarra Then
      mCadena = ""
      mvarModoCodigoBarra = False
      lblEstado.Visible = False
      Set Lista.DataSource = origen.DetAjustesStock.RegistrosConFormato
      MostrarTotales
      DoEvents
   End If

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

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   If mvarModificado Then
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

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)
   
   If mvarModoCodigoBarra Then Exit Sub
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
         If mvarId > 0 Then
            MsgBox "No puede modificar un ajuste ya grabado, haga otro ajuste.", vbCritical
            Exit Sub
         End If
         With Lista.SelectedItem
            origen.DetAjustesStock.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         mvarModificado = True
      Case 3
         If mvarId > 0 Then
            MsgBox "No puede modificar un ajuste ya grabado, haga otro ajuste.", vbCritical
            Exit Sub
         End If
         If Not Lista.SelectedItem Is Nothing Then
            DuplicarItem
            mvarModificado = True
         End If
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

Private Sub txtNumeroAjusteStock_GotFocus()

   With txtNumeroAjusteStock
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroAjusteStock_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtNumeroMarbete_GotFocus()

   With txtNumeroMarbete
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroMarbete_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtNumeroMarbete_Validate(Cancel As Boolean)

   If Len(txtNumeroMarbete.Text) Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.AjustesStock.TraerFiltrado("_PorMarbete", txtNumeroMarbete.Text)
      If oRs.RecordCount > 0 Then
         If mvarId < 0 Or mvarId <> oRs.Fields(0).Value Then
            MsgBox "Numero de marbete ya existente en el ajuste de stock numero " & oRs.Fields("NumeroAjusteStock").Value, vbExclamation
            Cancel = True
         End If
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
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
         mIdAprobo = .Fields("IdAprobo").Value
      End With
      Check1(0).Value = 1
   End If
   Unload oF
   Set oF = Nothing

End Sub

Public Sub DuplicarItem()

   Dim oLAnt As ListItem
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim i As Integer
         
   Set oLAnt = Lista.SelectedItem
   Set oL = Lista.ListItems.Add
         
   Set oRs = origen.DetAjustesStock.Item(oLAnt.Tag).Registro
   
   With origen.DetAjustesStock.Item(-1)
      For i = 1 To oRs.Fields.Count - 1
         .Registro.Fields(i).Value = oRs.Fields(i).Value
      Next
      .Registro.Fields("CantidadUnidades").Value = oRs.Fields("CantidadUnidades").Value * -1
      .Modificado = True
      oL.Tag = .Id
      With oL
         .SmallIcon = "Nuevo"
         .Text = oLAnt.Text
         For i = 1 To 8
            .SubItems(i) = oLAnt.SubItems(i)
         Next
         .SubItems(2) = "" & oRs.Fields("CantidadUnidades").Value * -1
      End With
   End With
   
   Set oL = Nothing
   Set oLAnt = Nothing
   Set oRs = Nothing
   
   MostrarTotales

End Sub

Public Sub AjusteAutomatico()

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim mvarIdObraStockDisponible, mvaIdArticulo As Long
   Dim mvarSaldo As Double
   
   mvarIdObraStockDisponible = 0
   Set oRs = Aplicacion.Parametros.TraerTodos
   If oRs.RecordCount > 0 Then
      If Not IsNull(oRs.Fields("IdObraStockDisponible").Value) Then
         mvarIdObraStockDisponible = oRs.Fields("IdObraStockDisponible").Value
      End If
   End If
   oRs.Close
   Set oRs = Nothing
   
   If mvarIdObraStockDisponible = 0 Then
      MsgBox "No ha definido el centro de costo para stock disponible (Parametros)", vbExclamation
      Exit Sub
   End If
   
   Me.MousePointer = vbHourglass
   DoEvents
   
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_RegistrosConStockNegativo")
   If oRs.RecordCount > 0 Then
      oRs.MoveFirst
      Do While Not oRs.EOF
         mvaIdArticulo = oRs.Fields("IdArticulo").Value
         'Set oRs1 = CopiarTodosLosRegistros(Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_RegistrosConStockDisponiblePorIdArticulo", mvaIdArticulo))
         Do While oRs.Fields("IdArticulo").Value = mvaIdArticulo
            mvarSaldo = Abs(oRs.Fields("CantidadUnidades").Value)
            If oRs1.RecordCount > 0 Then
               oRs1.MoveFirst
               Do While Not oRs1.EOF
                  If oRs1.Fields("CantidadUnidades").Value >= mvarSaldo Then
                     With origen.DetAjustesStock.Item(-1)
                        With .Registro
                           .Fields("IdArticulo").Value = oRs1.Fields("IdArticulo").Value
                           .Fields("Partida").Value = oRs1.Fields("Partida").Value
                           .Fields("IdUnidad").Value = oRs1.Fields("IdUnidad").Value
                           .Fields("IdUbicacion").Value = oRs1.Fields("IdUbicacion").Value
                           .Fields("IdObra").Value = oRs1.Fields("IdObra").Value
                           .Fields("CantidadUnidades").Value = mvarSaldo * -1
                        End With
                        .Modificado = True
                     End With
                     oRs1.Fields("CantidadUnidades").Value = oRs1.Fields("CantidadUnidades").Value - mvarSaldo
                     mvarSaldo = 0
                     Exit Do
                  Else
                     With origen.DetAjustesStock.Item(-1)
                        With .Registro
                           .Fields("IdArticulo").Value = oRs1.Fields("IdArticulo").Value
                           .Fields("Partida").Value = oRs1.Fields("Partida").Value
                           .Fields("IdUnidad").Value = oRs1.Fields("IdUnidad").Value
                           .Fields("IdUbicacion").Value = oRs1.Fields("IdUbicacion").Value
                           .Fields("IdObra").Value = oRs1.Fields("IdObra").Value
                           .Fields("CantidadUnidades").Value = oRs1.Fields("CantidadUnidades").Value * -1
                        End With
                        .Modificado = True
                     End With
                     mvarSaldo = mvarSaldo - oRs1.Fields("CantidadUnidades").Value
                     oRs1.Fields("CantidadUnidades").Value = 0
                  End If
                  oRs1.MoveNext
               Loop
            End If
            If mvarSaldo <> Abs(oRs.Fields("CantidadUnidades").Value) Then
               With origen.DetAjustesStock.Item(-1)
                  With .Registro
                     .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                     .Fields("Partida").Value = oRs.Fields("Partida").Value
                     .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacion").Value
                     .Fields("IdObra").Value = oRs.Fields("IdObra").Value
                     .Fields("CantidadUnidades").Value = Abs(oRs.Fields("CantidadUnidades").Value) - mvarSaldo
                  End With
                  .Modificado = True
               End With
            End If
            oRs.MoveNext
            If oRs.EOF Then Exit Do
         Loop
         oRs1.Close
      Loop
   End If
   oRs.Close
   
   Set oRs = Nothing
   Set oRs1 = Nothing
   
   Set Lista.DataSource = origen.DetAjustesStock.RegistrosConFormato
   MostrarTotales
   
   mvarModificado = True
   
   Me.MousePointer = vbDefault
   
End Sub

Public Sub ProcesarCodigoBarras(ByVal mCodigoBarras As String)

   Dim oRs As ADOR.Recordset
   Dim mCodArt As String, mPartida As String
   Dim mPeso As Double
   Dim mIdDetalle As Long, mnumerocaja As Long, mIdUbicacion As Long, mIdArticulo As Long
   Dim oL As ListItem
   
   Select Case mvarFormatCodBar
      Case 1
         If Len(mCodigoBarras) > 0 And Len(mCodigoBarras) <= 20 Then
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", mCodigoBarras)
            If oRs.RecordCount > 0 Then
               With origen.DetAjustesStock.Item(-1)
                  With .Registro
                     .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                     .Fields("Partida").Value = ""
                     .Fields("CantidadUnidades").Value = 1
                     If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                        .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     Else
                        .Fields("IdUnidad").Value = mvarIdUnidadCU
                     End If
                     .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacionStandar").Value
                     If IsNumeric(dcfields(2).BoundText) Then
                        .Fields("IdObra").Value = dcfields(2).BoundText
                     End If
                  End With
                  .Modificado = True
               End With
               Set Lista.DataSource = origen.DetAjustesStock.RegistrosConFormato
            End If
            oRs.Close
         End If
      
      Case 2
         If Len(mCodigoBarras) > 0 And Len(mCodigoBarras) <= 32 Then
            mCodArt = Trim(mId(mCodigoBarras, 1, 20))
            mPartida = Trim(mId(mCodigoBarras, 21, 6))
            mnumerocaja = 0
            mIdUbicacion = 0
            mIdArticulo = 0
            If mId(mCodigoBarras, 27, 1) = "C" Then
               mnumerocaja = mId(mCodigoBarras, 28, 5)
               Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorNumeroCaja", mnumerocaja)
               If oRs.RecordCount > 0 Then
                  mPeso = IIf(IsNull(oRs.Fields("CantidadUnidades").Value), 0, oRs.Fields("CantidadUnidades").Value)
                  mIdUbicacion = IIf(IsNull(oRs.Fields("IdUbicacion").Value), 0, oRs.Fields("IdUbicacion").Value)
                  mIdArticulo = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
               End If
               oRs.Close
            Else
               mPeso = CDbl(mId(mCodigoBarras, 28, 5)) / 100
            End If
            If mIdArticulo > 0 Then
               Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", mIdArticulo)
            Else
               Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", mCodArt)
            End If
            If oRs.RecordCount > 0 Then
               With origen.DetAjustesStock.Item(-1)
                  With .Registro
                     .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                     .Fields("Partida").Value = mPartida
                     .Fields("CantidadUnidades").Value = mPeso
                     If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                        .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                     Else
                        .Fields("IdUnidad").Value = mvarIdUnidadCU
                     End If
                     If IsNumeric(dcfields(2).BoundText) Then
                        .Fields("IdObra").Value = dcfields(2).BoundText
                     Else
                        .Fields("IdObra").Value = origen.Registro.Fields("IdObra").Value
                     End If
                     If mIdUbicacion > 0 Then
                        .Fields("IdUbicacion").Value = mIdUbicacion
                     Else
                        .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacionStandar").Value
                     End If
                     .Fields("NumeroCaja").Value = mnumerocaja
                  End With
                  .Modificado = True
                  mIdDetalle = .Id
               End With
            
               Set oL = Lista.ListItems.Add
               oL.Tag = mIdDetalle
               With oL
                  .SmallIcon = "Nuevo"
                  .Text = mCodArt
                  .SubItems(1) = "" & oRs.Fields("Descripcion").Value
                  .SubItems(2) = "" & mPartida
                  .SubItems(3) = "" & mPeso
                  '.SubItems(4) = "" & Aplicacion.StockPorIdArticulo(oF.DataCombo1(1).BoundText)
                  '.SubItems(7) = "" & Aplicacion.Unidades.Item(oF.DataCombo1(0).BoundText).Registro.Fields("Descripcion").Value
                  '.SubItems(8) = oF.DataCombo1(2).Text
                  '.SubItems(9) = oF.DataCombo1(3).Text
               End With
            End If
            oRs.Close
         End If
   
   End Select
   
   Set oRs = Nothing
   
   MostrarTotales

End Sub

Public Sub MostrarTotales()

   Estado.Panels(1).Text = " " & origen.DetAjustesStock.CantidadRegistros & " Items"

End Sub
