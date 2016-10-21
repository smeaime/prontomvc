VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmPlanificacionMateriales 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "MPS - Plan Maestro de Producción "
   ClientHeight    =   9090
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   13290
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   9090
   ScaleWidth      =   13290
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox chkLiberarOPs 
      Caption         =   "Liberar  OPs generadas"
      Height          =   255
      Left            =   7200
      TabIndex        =   23
      Top             =   8760
      Value           =   1  'Checked
      Width           =   2175
   End
   Begin VB.CheckBox chkMostrarOPs 
      Caption         =   "Mostrar OPs generadas"
      Height          =   255
      Left            =   7200
      TabIndex        =   22
      Top             =   8400
      Width           =   2055
   End
   Begin VB.Frame Frame1 
      Caption         =   "Período"
      Height          =   735
      Left            =   8040
      TabIndex        =   18
      Top             =   720
      Width           =   2655
      Begin VB.OptionButton OptPeriodo 
         Caption         =   "Mensual"
         Height          =   255
         Index           =   1
         Left            =   240
         TabIndex        =   20
         Top             =   240
         Width           =   1095
      End
      Begin VB.OptionButton OptPeriodo 
         Caption         =   "Semanal"
         Height          =   255
         Index           =   0
         Left            =   1320
         TabIndex        =   19
         Top             =   240
         Value           =   -1  'True
         Width           =   1095
      End
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "frmPlanificacionMateriales.frx":0000
      Left            =   1920
      List            =   "frmPlanificacionMateriales.frx":000D
      TabIndex        =   17
      Top             =   720
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.CommandButton cmd 
      Caption         =   "OCs Pendientes"
      Enabled         =   0   'False
      Height          =   540
      Index           =   7
      Left            =   1200
      TabIndex        =   16
      Top             =   8400
      Visible         =   0   'False
      Width           =   1110
   End
   Begin VB.CommandButton cmdEXCEL 
      Height          =   540
      Left            =   240
      Picture         =   "frmPlanificacionMateriales.frx":0037
      Style           =   1  'Graphical
      TabIndex        =   15
      ToolTipText     =   "Explosión del Producto"
      Top             =   8400
      Width           =   855
   End
   Begin VB.CommandButton cmdCommand1 
      Caption         =   "Buscar"
      Height          =   615
      Left            =   11040
      TabIndex        =   14
      Top             =   840
      Width           =   1335
   End
   Begin VB.TextBox Text1 
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
      Enabled         =   0   'False
      Height          =   315
      Left            =   1920
      TabIndex        =   13
      Top             =   240
      Width           =   1545
   End
   Begin VB.CommandButton cmdQuitar 
      Caption         =   "Quitar"
      Height          =   540
      Index           =   0
      Left            =   3600
      TabIndex        =   12
      Top             =   8400
      Visible         =   0   'False
      Width           =   1110
   End
   Begin VB.CommandButton cmdOPsPendientes 
      Caption         =   "OPs Pendientes"
      Enabled         =   0   'False
      Height          =   540
      Index           =   0
      Left            =   2400
      TabIndex        =   11
      Top             =   8400
      Visible         =   0   'False
      Width           =   1110
   End
   Begin VB.CommandButton cmdGenerar 
      Caption         =   "Generar MPR1"
      Height          =   540
      Index           =   2
      Left            =   10440
      TabIndex        =   10
      Top             =   8400
      Width           =   1230
   End
   Begin VB.TextBox txtEdit 
      BorderStyle     =   0  'None
      Height          =   375
      Left            =   3000
      TabIndex        =   9
      Top             =   6000
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Salir"
      CausesValidation=   0   'False
      Height          =   540
      Index           =   1
      Left            =   11880
      TabIndex        =   1
      Top             =   8400
      Width           =   1110
   End
   Begin MSFlexGridLib.MSFlexGrid fGrid 
      Height          =   6375
      Left            =   240
      TabIndex        =   0
      Top             =   1680
      Width           =   12855
      _ExtentX        =   22675
      _ExtentY        =   11245
      _Version        =   393216
      Rows            =   10
      Cols            =   15
      FixedCols       =   0
      BackColorSel    =   -2147483629
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
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   330
      Index           =   1
      Left            =   5520
      TabIndex        =   2
      Top             =   720
      Width           =   2325
      _ExtentX        =   4101
      _ExtentY        =   582
      _Version        =   393216
      CustomFormat    =   "ddd d/MM  HH:mm:ss"
      DateIsNull      =   -1  'True
      Format          =   61472768
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaInicioPrevista"
      Height          =   330
      Index           =   2
      Left            =   5520
      TabIndex        =   3
      Top             =   1080
      Width           =   2325
      _ExtentX        =   4101
      _ExtentY        =   582
      _Version        =   393216
      CustomFormat    =   "ddd d/MM  HH:mm:ss"
      Format          =   61472768
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdArticuloMaterial"
      Height          =   315
      Index           =   0
      Left            =   3480
      TabIndex        =   8
      Tag             =   "Articulos"
      Top             =   240
      Width           =   7290
      _ExtentX        =   12859
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
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
      Left            =   10920
      TabIndex        =   6
      Top             =   240
      Width           =   1425
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tipo de Material:"
      Height          =   300
      Index           =   2
      Left            =   240
      TabIndex        =   21
      Top             =   840
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Artículo Planificado:"
      Height          =   300
      Index           =   0
      Left            =   240
      TabIndex        =   7
      Top             =   360
      Width           =   1695
   End
   Begin VB.Label lblInicioPrevisto 
      AutoSize        =   -1  'True
      Caption         =   "Inicio"
      Height          =   255
      Index           =   6
      Left            =   4800
      TabIndex        =   5
      Top             =   840
      Width           =   375
   End
   Begin VB.Label lblReal 
      AutoSize        =   -1  'True
      Caption         =   "Final"
      Height          =   195
      Index           =   0
      Left            =   4800
      TabIndex        =   4
      Top             =   1200
      Width           =   330
   End
   Begin VB.Menu MnuDet 
      Caption         =   "AAA"
      Index           =   0
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "sdsdf"
         Index           =   0
      End
   End
End
Attribute VB_Name = "frmPlanificacionMateriales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const COL_ID1 = 0
Const COL_ID2 = 1
Const COL_FECHA = 2
Const COL_DOCUMENTO = 3
Const COL_CLIENTE = 4
Const COL_CANTIDAD = 5
Const COL_STOCKINICIAL = 6
Const COL_ACONSUMIR = 7
Const COL_INGRESOSPREVISTOS = 8
Const COL_STOCKFINAL = 9
Const COL_PEDIDOSPREVISTOS = 10
Const COL_OPPREVISTA = 11
Const COL_D = 12
Const COL_SS = 13
Const COL_NN = 14
Const COL_EOP = 15
Const COL_MAX = 15  '<----CAMBIÁ ESTE SI CAMBIAS LA CANTIDAD DE COLUMNAS....

Dim NivelRecursivo As Integer

Dim WithEvents origen As ComPronto.Plan
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mNivelAcceso As Integer, mOpcionesAcceso As String
Dim Proporcion As Double
Dim WithEvents ActL As ControlForm
Attribute ActL.VB_VarHelpID = -1
Dim PlanMaestro As Long

Public mvarId As Long
Private mIdAprobo As Long, mIdAprobo1 As Long

Dim dc0boundtext As String 'http://support.microsoft.com/?scid=kb%3Ben-us%3B257947&x=7&y=17


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


Friend Sub cmd_Click(index As Integer)
'On Error GoTo Mal
On Error Resume Next

   Dim est As EnumAcciones


   
   Select Case index
   
        Case 0
            With origen.Registro
                !Fecha = DTFields(1)
                !IdArticuloProducido = dc0boundtext
                !idArticuloMaterial = dc0boundtext 'dcfields(0).BoundText
                !GrillaSerializada = GuardarGrillaSerializada
            End With
            
            Select Case origen.Guardar
              Case ComPronto.MisEstados.Correcto
              Case ComPronto.MisEstados.ModificadoPorOtro
                 MsgBox "El Regsitro ha sido modificado"
              Case ComPronto.MisEstados.NoExiste
                 MsgBox "El registro ha sido eliminado"
              Case ComPronto.MisEstados.ErrorDeDatos
                 MsgBox "Error de ingreso de datos"
            End Select
        
           
              
            With actL2
              .ListaEditada = "Planes"
              .AccionRegistro = est
              .Disparador = mvarId
            End With
           ' Unload Me
   
        Case 1
            Unload Me
   
   
         Case 7
             Dim oF As frmOCsPendientes
             Set oF = New frmOCsPendientes
             With oF
                .Id = "Compras"
                .FiltroArticulo = dc0boundtext
                .FiltroMaterial = dc0boundtext 'dcfields(0).BoundText
                .Show vbModal, Me
             End With
             PostmodalOCPendientes oF
                     
            'End If
   'En el Plan de Materiales no me permite ingresar más de una OCs, si selecciono una segunda, me está quitando la primera.
   '-lo que está pasando es que no le desplaza el renglon para abajo... En definitiva,
   'que el planeador no funciona

   
   End Select
   
   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case -2147217900
         mvarResp = MsgBox("No puede borrar este registro porque se esta" & vbCrLf & "utilizando en otros archivos. Desea ver detalles?", vbYesNo + vbCritical)
         If mvarResp = vbYes Then
            MsgBox "Detalle del error : " & vbCrLf & Err.Number & " -> " & Err.Description
         End If
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
  End Select


End Sub




   
Sub PostmodalOCPendientes(oF As frmOCsPendientes)
   Dim oL As ListItem
   With oF
        If glbIdOC <> 0 Then
            With fGrid
                Dim r
                For r = 1 To .Rows - 1
                   If .TextMatrix(r, COL_DOCUMENTO) = "OC " & glbNumeroOC Then
                       MsgBox "En esta versión un documento no se puede repetir en el plan"
                       Exit Sub
                   End If
                Next
        
                 InsertarRenglon .Row
                .TextMatrix(.Row, COL_ID1) = glbIdOC
                .TextMatrix(.Row, COL_DOCUMENTO) = "OC " & glbNumeroOC
                .TextMatrix(.Row, COL_CLIENTE) = glbClienteRet
                .TextMatrix(.Row, COL_CANTIDAD) = glbCantRet
                '.TextMatrix(.row, COL_CONSUMO) = glbCantRet
                
            
                Dim rs As ADOR.Recordset
                'Set rs = Aplicacion.OrdenesCompra.TraerTodos
                'rs.Filter = "[Orden de Compra]=" & glbNumeroOC & ""
                
                
                
                '///////////////////////////////////////
                'METODO 1: Edicion usando objeto Compronto
                '///////////////////////////////////////
                
                Dim OC As ComPronto.OrdenCompra
                Dim DetOC As ComPronto.DetOrdenCompra
                
                Set OC = Aplicacion.OrdenesCompra.Item(glbIdOC)

                
                With OC.Registro
                    '!FechaOrdenCompra = fGrid.TextMatrix(fGrid.row, COL_FECHA)
                    '!NumeroOrdenCompra = mN
                    '!IdCliente = 22
                    !Observaciones = "Modificado por ProntoProduccion -- " & !Observaciones
                End With
            
                
                Dim oRs As ADOR.Recordset
                Set oRs = Aplicacion.Articulos.TraerFiltrado("_Busca", Left(glbIdArticuloRet, 50))
                
                
                If Not oRs.EOF Then
                    Set DetOC = OC.DetOrdenesCompra.Item(oRs!IdArticulo)
                    With DetOC.Registro
                        !FechaNecesidad = fGrid.TextMatrix(fGrid.Row, COL_FECHA)
                        !FechaEntrega = fGrid.TextMatrix(fGrid.Row, COL_FECHA)
                        '!IdColor = 33
                        !IdArticulo = oRs!IdArticulo
                        !Cantidad = glbCantRet
                        '!IdUnidad = K_UN1
                    End With
                    DetOC.Modificado = True
                    Debug.Print OC.Registro!NumeroOrdenCompra
                    OC.Guardar
                Else
                End If
            
                '///////////////////////////////////////
                'METODO 2: Edicion usando SP directo
                '///////////////////////////////////////
            
                'Aplicacion.Tarea "DetProduccionOrdenesProcesos_M", _
                            Array(!IdDetalleProduccionOrdenProceso, _
                                    !IdProduccionOrden, _
                                    !IdProduccionProceso, _
                                    iisNull(!Horas, 0), _
                                    iisNull(!FechaInicio, !FechaInicioPrevista), _
                                    iisNull(!FechaFinal, !FechaFinalPrevista), _
                                    iisNull(!HorasReales, 0), _
                                    !IdMaquina, "")

            
                '///////////////////////////////////////
                '///////////////////////////////////////
            
            
                            
                'Dim Plan As Plan
                'Dim Id As Long
                'Set Plan = AplicacionProd.Planes.Item(-1)
                'With Plan.Registro
                '    !Fecha = fGrid.TextMatrix(fGrid.Row, COL_FECHA)
                '    !Cantidad = fGrid.TextMatrix(fGrid.Row, COL_CANTIDAD)
                '    !Documento = fGrid.TextMatrix(fGrid.Row, COL_DOCUMENTO)
                '    !IdArticuloProducido = dcfields(11).BoundText
                '    !idArticuloMaterial = dcfields(0).BoundText
                '    !GrillaSerializada = GuardarGrillaSerializada
                'End With
                'Id = Plan.Guardar
                '.TextMatrix(.Row, COL_ID2) = Id
                'Set Plan = Nothing
    
                Set oF = Nothing
            End With
        End If
     Set oF = Nothing
    End With
    Recargar
    RecalcularColumnas
    PintaGrilla
End Sub






Friend Sub cmdOPsPendientes_Click(index As Integer)
On Error Resume Next
    Dim oF As Form

    Set oF = New frmOPsPendientes
    With oF
       .Id = "Compras"
       .FiltroArticulo = dcfields(11).BoundText
       .FiltroMaterial = dc0boundtext 'dcfields(0).BoundText
       
       .Show vbModal, Me
    End With
   
   PostmodalOPPendientes oF
End Sub



Sub PostmodalOPPendientes(oF As frmOPsPendientes)
   Dim oL As ListItem
   With oF

     If oF.IdProduccionOrdenElegida <> "" Then
         With fGrid
             Dim r
             For r = 1 To .Rows - 1
                If .TextMatrix(r, COL_DOCUMENTO) = "OP " & oF.NumeroProduccionOrdenElegida Then
                    MsgBox "En esta versión un documento no se puede repetir en el plan"
                    Exit Sub
                End If
             Next
             
             InsertarRenglon .Row
             .TextMatrix(.Row, COL_ID1) = oF.IdProduccionOrdenElegida
             .TextMatrix(.Row, COL_DOCUMENTO) = "OP " & oF.NumeroProduccionOrdenElegida
             .TextMatrix(.Row, COL_CLIENTE) = oF.ClienteElegida
             .TextMatrix(.Row, COL_CANTIDAD) = oF.Cantidad
             '.TextMatrix(.row, COL_CONSUMO) = glbCantRet
            
            Dim Orden As ComPronto.ProduccionOrden
            Set Orden = AplicacionProd.ProduccionOrdenes.Item(oF.IdProduccionOrdenElegida)
            With Orden.Registro
                !FechaInicioPrevista = fGrid.TextMatrix(fGrid.Row, COL_FECHA)
                '!Cantidad = 520
                !Observaciones = "Modificado por ProntoProduccion -- " & !Observaciones
            End With
            
            Debug.Print Orden.Registro!NumeroOrdenProduccion
            Orden.Guardar

         
             'Dim Plan As Plan
             'Dim Id As Long
             'Set Plan = AplicacionProd.Planes.Item(-1)
             'With Plan.Registro
             '    !Fecha = fGrid.TextMatrix(fGrid.Row, COL_FECHA)
             '    !Cantidad = fGrid.TextMatrix(fGrid.Row, COL_CANTIDAD)
             '    !Documento = fGrid.TextMatrix(fGrid.Row, COL_DOCUMENTO)
             '    !IdArticuloProducido = dcfields(11).BoundText
             '    !idArticuloMaterial = dcfields(0).BoundText
             '    !PlanMaestro = PlanMaestro
             'End With
             'Id = Plan.Guardar
             '.TextMatrix(.Row, COL_ID2) = Id
             'Set Plan = Nothing
         End With
     End If
     Set oF = Nothing
    End With

    Recargar
    RecalcularColumnas
    PintaGrilla
End Sub



Sub InsertarRenglon(Row As Long)
    Dim temprow As Long
    Dim r As Long
    Dim c As Long
    With fGrid
        temprow = .Row
        .Rows = .Rows + 1
        For r = .Rows - 2 To Row Step -1
            For c = 1 To .Cols - 1
                .TextMatrix(r + 1, c) = .TextMatrix(r, c)
                If r = Row And c <> COL_FECHA Then .TextMatrix(r, c) = ""
            Next
        Next
        .Row = temprow
    End With
End Sub



Private Sub cmdEXCEL_Click()
    Exportar_Excel "", fGrid
End Sub




Function GuardarGrillaSerializada() As String
    Dim r As Long
    Dim c As Long
    Dim gs As String
    
    With fGrid
        For r = 1 To .Rows - 1
            For c = 1 To .Cols - 1
                gs = gs & "|" & fGrid.TextMatrix(r, c)
            Next
        Next
    End With
    
    GuardarGrillaSerializada = gs
End Function



Sub CargarGrillaSerializada(gs As String)
    Dim r As Long
    Dim c As Long
    Dim i1 As Long
    Dim i2 As Long
    
    i1 = 1
    i2 = 1
    r = 1
    
    With fGrid
        'For r = 1 To .Rows - 1
        Do While i2 <> 0
            For c = 1 To .Cols - 1
                
                i2 = InStr(i1 + 1, gs, "|")
                If i2 = 0 Then Exit Sub
                If .Rows < r + 1 Then .Rows = r + 1
                .TextMatrix(r, c) = mId(gs, i1 + 1, i2 - i1 - 1)
                i1 = i2
            
            Next
            r = r + 1
        Loop
        'Next
    End With
End Sub




Public Sub cmdGenerar_Click(index As Integer)
'On Error Resume Next
        
    Me.MousePointer = vbHourglass
    DoEvents

    
    GenerarOPs
    GenerarRMs
    
    Me.MousePointer = vbDefault
    
    Recargar
   
    MsgBox ("Generacion terminada")
   
   cmd_Click 0
   'do while
   'Set oF = New frmProduccionOrden
 '
 '  With oF
 '     .Id = Identificador
 '     .Disparar = ActL
 '     .Show , Me
 '  End With
    cmdGenerar(2).Enabled = False
        
    fGrid.Enabled = False
    cmd(1).Enabled = False
    'cmd(0).Enabled = False

    Dim oControl As Control
    For Each oControl In Me.Controls
        oControl.Enabled = False
    Next
    cmd(1).Enabled = True
    cmdEXCEL.Enabled = True
End Sub

Sub GenerarRMs()
    Dim RM As ComPronto.Requerimiento
    Dim DetRM As ComPronto.DetRequerimiento
    
    Dim mN
    Dim oPar As ComPronto.Parametro
    Dim Id As Integer
        


    Dim i As Integer
    Dim n
    
    With fGrid
        For i = 1 To .Rows - 1
            n = iisEmpty(.TextMatrix(i, COL_PEDIDOSPREVISTOS), 0)
            If n > 0 Then
                   
                Set oPar = Aplicacion.Parametros.Item(1)
                With oPar.Registro
                    mN = .Fields("ProximoNumeroRequerimiento").Value
                    .Fields("ProximoNumeroRequerimiento").Value = mN + 1
                End With
                oPar.Guardar
                
                Set RM = Aplicacion.Requerimientos.Item(-1)
                With RM.Registro
                    !NumeroRequerimiento = mN
                    '!IdCliente =
                    !FechaRequerimiento = Now
                    !IdObra = Null '1 'glbIdObraAsignadaUsuario
                    '!IdColor =
                    
                    'En las RMs que se generan, agregar el usuario que libera el comprobante
                    !Aprobo = glbIdUsuario
                    !idSolicito = glbIdUsuario ' UsuarioSistema
                    
                    'que se configure la obra que se pone en las RMs generadas
                    !IdObra = TraerValorParametro2("IdObraDefault")


                    !idSector = glbIdSector
                    !Observaciones = "Generado por ProntoProduccion"
                End With
            
            
                Set DetRM = RM.DetRequerimientos.Item(-1)
                With DetRM.Registro
                    !IdArticulo = dc0boundtext 'dcfields(0).BoundText
                    !Cantidad = n
                    !FechaEntrega = fGrid.TextMatrix(i, COL_FECHA)
                    
                    Dim art As ComPronto.Articulo
                    Set art = Aplicacion.Articulos.Item(dc0boundtext) 'dcfields(0).BoundText)
                    If IsNull(art.Registro!IdUnidad) Then MsgBox ("No está indicado en el maestro de artículos la unidad de " & art.Registro!descripcion)
                    !IdUnidad = art.Registro!IdUnidad
                    
                    
                    
                    !Adjunto = "NO"
                    !MoP = "M"
                    !Cantidad1 = n
                    !Cantidad2 = n
                    
                    
                End With
                DetRM.Modificado = True
            
                RM.Guardar
                Id = RM.Registro.Fields("IdRequerimiento")


                If chkMostrarOPs <> 0 Then
                    'escupo en pantalla
                    Dim oF As Form
                    Set oF = New frmRequerimientos
                    With oF
                       .Id = Id
                       .Disparar = ActL
                       .Show , Me
                    End With
                End If
            End If
        Next
    End With
End Sub

Sub GenerarOPs()
    
   Dim oControl As Control
   Dim rs As ADOR.Recordset
   
   



    
    NivelRecursivo = 0
    
    
    If Not IsNumeric(dcfields(0).BoundText) Then
        MsgBox "Las OPs no se generarán porque no se eligió un producto terminado"
        Exit Sub
    End If
   
    Set rs = AplicacionProd.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", dcfields(0).BoundText)
    If Not IsNumeric(rs!idProduccionFicha) Then
        MsgBox "No hay ficha para este producto"
        Exit Sub
    End If
    
    

    
    With fGrid
      Dim i As Integer
      For i = 1 To .Rows - 1
         Dim n
         n = iisEmpty(.TextMatrix(i, COL_OPPREVISTA), 0)
         If n > 0 Then


            
            GeneroOPRecursiva dcfields(0).BoundText, -1, n, rs!IdUnidad, fGrid.TextMatrix(i, COL_FECHA)
            
            

         End If
      Next
    End With


End Sub




Function LeadTime(IdArticulo) As Date
    'LeadTime =
End Function


Sub GeneroOPRecursiva(IdArticuloProducido, IdColor, Cantidad, IdUnidad, FechaInicioPrevista)
   Dim oDet As DetProduccionOrden
   Dim oDetproc As DetProdOrdenProceso
   Dim oRs As ADOR.Recordset
   Dim rs As ADOR.Recordset
    Dim mN As Long
    Dim Orden As ComPronto.ProduccionOrden
    Dim DetProduccionOrden As DetProduccionOrden
    Dim DetProduccionOrdenProceso As DetProdOrdenProceso
    Dim c As Double
   Dim o As ComPronto.ProduccionFicha
   Dim Id As Long

    DoEvents
    NivelRecursivo = NivelRecursivo + 1

            mN = TraerValorParametro2("ProximoNumeroProduccionOrden")
            GuardarValorParametro2 "ProximoNumeroProduccionOrden", "" & (mN + 1)
            
            Set Orden = AplicacionProd.ProduccionOrdenes.Item(-1)
                With Orden.Registro
                    !NumeroOrdenProduccion = mN
                    !idArticuloGenerado = IdArticuloProducido
                    '!IdStockGenerado = 2121
                    '!IdColor = 10
                    
                    !fechaOrdenProduccion = Now
                    
                    !FechaIngreso = Date
                    
                    !Cantidad = Cantidad
                    !IdUnidad = IdUnidad
            
                    
                    !FechaInicioPrevista = FechaInicioPrevista '- LeadTime(IdArticuloProducido)
                    '!FechaFinalPrevista = #2/1/2000#
                    '!FechaInicioReal = #1/1/2000#
                    '!FechaFinalReal = #2/1/2000#
                    
                    !Emitio = glbIdUsuario
                    If chkLiberarOPs <> 0 Then !Aprobo = glbIdUsuario
                    
                    !Observaciones = "Generado por ProntoProduccion"
                    'IdDepositoOrigen
                End With
            
            
                'traigo el articulo asociado
                'traigo la ficha
                Set rs = AplicacionProd.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", IdArticuloProducido)
                Set o = AplicacionProd.ProduccionFichas.Item(rs!idProduccionFicha)
    
                        
                        
                'lleno los procesos
                Dim TotalHoras As Double
                Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_DetalleProcesosDeFicha", (rs!idProduccionFicha))
                If oRs.RecordCount <> 0 Then
                   oRs.MoveFirst
                   Do While Not oRs.EOF
                      Set oDetproc = Orden.DetProduccionOrdenesProcesos.Item(-1)
                      oDetproc.Registro!IdProduccionProceso = oRs!IdProduccionProceso
                      oDetproc.Registro!Horas = oRs!Horas
            
                      c = Cantidad * oRs!Horas / o.Registro!Cantidad
                      oDetproc.Registro!Horas = c
                      TotalHoras = c + TotalHoras
            
                      oDetproc.Modificado = True
                      Set oDetproc = Nothing
                      oRs.MoveNext
                   Loop
                
                
                    Orden.Registro!FechaFinalPrevista = FechaInicioPrevista 'el final de esta es el inicio de la anterior
                    Orden.Registro!FechaInicioPrevista = DateAdd("h", -TotalHoras, FechaInicioPrevista)
                    
                End If
                oRs.Close
                    
                    
                'lleno los productos
                Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_DetalleDeFicha", (rs!idProduccionFicha))
                If oRs.RecordCount <> 0 Then
                    
                    oRs.MoveFirst
                    Do While Not oRs.EOF
                       
                       
                        Set oDet = Orden.DetProduccionOrdenes.Item(-1)
                        With oDet.Registro
                            !IdArticulo = oRs!IdArticulo
                            '!IdUnidad = K_UN1
                        End With
            
                       'actualizar cantidad en la lista y en el objeto
                                                     
                       If IsNull(oRs.Fields![Cant.].Value) Then
                            MsgBox ("La cantidad del material " & oRs!Articulo & " en la ficha está en 0")
                       ElseIf IsNull(o.Registro!Cantidad) Then
                            MsgBox ("La cantidad total de la ficha está en 0")
                       Else
                            c = Cantidad * oRs.Fields![Cant.].Value / o.Registro!Cantidad
                       End If
                       oDet.Registro!Cantidad = c
                       oDet.Modificado = True
                    
                    
                        'tengo que hacer la generacion de los artículos dependientes!!!!
                        'tambien hay que "calcular" el lead time... vos podes usar las horas de mano de obra...
                        'igual es chamuyo... cuando debe comprar o producir uno las cosas? para cuando te las piden menos
                        'el tiempo que tardás en producirlo o comprarlo... oh descubrimiento!
                        '-te faltaría lo del SS, el stock de seguridad...
                    
                    
                        'busco si el articulo tiene ficha.
                        
                        'me traigo la ficha del artículo
                        If AplicacionProd.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", Array(oRs!IdArticulo, iisNull(oRs!IdColor, 0))).RecordCount <> 0 Then
                            Debug.Print "Nivel " & NivelRecursivo & " - Ficha del articulo " & IdArticuloProducido & " llama a ficha --->" & oRs.Fields(2)
                            If IdArticuloProducido = oRs.Fields(2) Then
                                'MsgBox ("La ficha del articulo " & IdArticuloProducido & " hace referencia a sí mismo")
                            ElseIf NivelRecursivo > 5 Then
                                'Stop
                            Else
                            GeneroOPRecursiva oRs!IdArticulo, oRs!IdColor, c, oRs!IdUnidad, Orden.Registro!FechaInicioPrevista
                            End If
                        Else
                            'genero una rm del material
                            'RM (sadfasdfasf)
                            '-Pero la RM de la OP no la debería generar el objeto OP?
                        End If
                    
                       
                       
                       
                       Set oDet = Nothing
                       oRs.MoveNext
                    Loop
                End If
                oRs.Close
                         
                            
                            
            
            
         
            'Grabo
            Orden.Guardar
            Id = Orden.Registro.Fields("IdProduccionOrden")
            Set Orden = Nothing
        
        
           
            'Lo escupo en pantalla
           If chkMostrarOPs <> 0 Then
                Dim oF As Form
                Set oF = New frmProduccionOrden
                With oF
                   .Id = Id
                   .Disparar = ActL
                   .Show , Me
                End With
            End If


        NivelRecursivo = NivelRecursivo - 1
End Sub









Private Sub Combo1_Click()
    On Error Resume Next
    'o        Filtro por Tipo de Material: está funcionando mal, tanto para Artículo Producido, como para Material Planificado.
    'Stop


    'Sin usar filtro de ficha tecnica
    'Set dcfields(0).RowSource = Aplicacion.Articulos.TraerFiltrado("_PorDescripcionTipoParaCombo", _
    '           Array(iisEmpty(dcfields(11).BoundText), iisEmpty(Combo1, "")))
    
    
    'Usando filtro de ficha tecnica
    Set dcfields(0).RowSource = AplicacionProd.ProduccionFichas.TraerFiltrado("_MaterialesPorArticuloAsociadoParaCombo", _
                   Array(iisEmpty(dcfields(11).BoundText), 0, iisEmpty(Combo1, "")))
    
    
    
    dcfields(0).BoundColumn = "IdArticulo" 'error loco http://support.microsoft.com/?scid=kb%3Ben-us%3B238406&x=1&y=8
    dcfields(0).Text = dcfields(0).Text
End Sub

Private Sub dcfields_LostFocus(index As Integer)
On Error Resume Next
'    If Index = 11 And IsNumeric(dcfields(11).BoundText) Then
'
'        'Sin usar filtro de ficha tecnica
'        Set dcfields(0).RowSource = Aplicacion.Articulos.TraerFiltrado("_PorDescripcionTipoParaCombo", _
'                   Array(iisEmpty(dcfields(11).BoundText), iisEmpty(Combo1, "")))
'
'
'        'Usando filtro de ficha tecnica
'        Set dcfields(0).RowSource = AplicacionProd.ProduccionFichas.TraerFiltrado("_MaterialesPorArticuloAsociadoParaCombo", _
'                       Array(iisEmpty(dcfields(11).BoundText), 0, iisEmpty(Combo1, "")))
'
'
'        dcfields(0).BoundColumn = "IdArticulo" 'error loco http://support.microsoft.com/?scid=kb%3Ben-us%3B238406&x=1&y=8
'        dcfields(0).Text = dcfields(0).Text
'    End If
End Sub

Private Sub DTFields_Change(index As Integer)
    Dim oArt As ComPronto.Articulo
    Dim oRs As ADOR.Recordset
    Select Case index
        Case 1
            RecalculaFecha


    End Select
    Set oArt = Nothing
    Set oRs = Nothing
End Sub

Private Sub dcfields_Change(index As Integer)
On Error Resume Next
    Dim oArt As ComPronto.Articulo
    Dim oRs As ADOR.Recordset
    Select Case index
        Case 0
            dc0boundtext = dcfields(0).BoundText
            If IsNumeric(dcfields(0).BoundText) Then
                Set oArt = Aplicacion.Articulos.Item(dcfields(0).BoundText)
                Set oRs = oArt.Registro
                Text1.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
            End If
    
        Case 11
            If IsNumeric(dcfields(11).BoundText) Then
                Set oArt = Aplicacion.Articulos.Item(dcfields(11).BoundText)
                Set oRs = oArt.Registro
                'txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
            
            
                
                Set oRs = AplicacionProd.ProduccionFichas.TraerFiltrado("_ProporcionEntreProducidoyMaterial", _
                            Array(iisNull(dc0boundtext, -1), iisNull(dc0boundtext, -1))) ' dcfields(0).BoundText, -1)))
                   
                If oRs.RecordCount > 0 Then Proporcion = oRs(0)
            
            End If
    End Select
    Set oArt = Nothing
    Set oRs = Nothing
End Sub



Sub RecalculaFecha()
    If OptPeriodo(0) Then
        DTFields(2) = DateAdd("d", 7, DTFields(1))
    Else
        DTFields(2) = DateAdd("m", 1, DTFields(1))
    End If
End Sub


Private Sub Form_Unload(Cancel As Integer)


   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   

End Sub

Private Sub ActL_ActLista(ByVal IdRegistro As Long, _
                          ByVal TipoAccion As EnumAcciones, _
                          ByVal NombreListaEditada As String, _
                          ByVal IdRegistroOriginal As Long)

'   ActualizarLista IdRegistro, TipoAccion, NombreListaEditada, IdRegistroOriginal

End Sub
Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Public Property Let Id(ByVal vNewValue As Long)


   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   
   mvarId = vNewValue
   
   Set oAp = AplicacionProd
   Set origen = oAp.Planes.Item(vNewValue)
   Set oBind = New BindingCollection
   
   
   
   
   
   
   With oBind

      Set .DataSource = origen

      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then

         ElseIf TypeOf oControl Is DbListView Then
         ElseIf TypeOf oControl Is label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField

         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If oControl.Tag = "Maquinas" Then
                Set oControl.RowSource = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorDescripcionTipoParaCombo", Array(0, "Equipo"))
            ElseIf Len(oControl.Tag) Then
                Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next

   End With
   
   
  
   'Cuando se fuerza el valor de rowsource, hay que volver a poner el
   ' valor de boundcolumn!!! http://support.microsoft.com/?scid=kb%3Ben-us%3B238406&x=1&y=8
   
   'Set dcfields(11).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_ProduciblesParaCombo", Array(0))
   'Set dcfields(11).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorIdTipoParaCombo", 4)
   'Set dcfields(0).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionFicha", "_MaterialesPorArticuloAsociadoParaCombo", Array(dcfields(11).BoundText))
  
  'dcfields(0).BoundColumn = "IdArticulo"
  'dcfields(11).BoundColumn = "IdArticulo"
   
   Set dcfields(11).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_ProduciblesParaCombo", Array(0))
   Set dcfields(0).RowSource = Aplicacion.Articulos.TraerLista  '.TraerFiltrado("Articulos", "_ParaCombo")
   Set oAp = Nothing

    
   If vNewValue <> -1 Then
        DTFields(1) = origen.Registro!Fecha
        
        ConfiguraGrilla (True)
        RecalculaFecha
        
        PlanMaestro = vNewValue
        CargarGrillaSerializada origen.Registro!GrillaSerializada
   Else
        DTFields(1).MinDate = DateValue(Now) 'se queda solo con el día
        DTFields(2).MinDate = DateValue(Now) 'se queda solo con el día
        DTFields(0) = DateValue(Now)
        DTFields(1) = DateValue(Now)
        'PlanMaestro = planmaestronuevo()
        ConfiguraGrilla (True)
        RecalculaFecha
        Recargar
        PintaGrilla
        fGrid.Rows = 1
   End If
    
   
   If Me.NivelAcceso <= Medio Then
      If mvarId <= 0 Then
         cmd(0).Enabled = True
      ElseIf mvarId > 0 Then
         'If (IsNull(origen.Registro.Fields(mCampoAprobo).Value) Or _
               (Not IsNull(origen.Registro.Fields(mCampoAprobo).Value) And _
                BuscarClaveINI("Inmovilizar RM al liberar") <> "SI")) And _
                IIf(IsNull(origen.Registro.Fields("Cumplido").Value), "NO", origen.Registro.Fields("Cumplido").Value) <> "SI" Then
            cmd(0).Enabled = True
            'cmd(3).Enabled = True
         'End If
      End If
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      cmd(3).Enabled = True
   End If
   cmd(1).Enabled = True
   cmd(0).Enabled = True
   
   
   If vNewValue <> -1 Then
        'fGrid.Enabled = False
        txtEdit.Enabled = False
        cmd(1).Enabled = False
        cmd(0).Enabled = False
  
        For Each oControl In Me.Controls
            oControl.Enabled = False
        Next
        cmd(1).Enabled = True
        cmdEXCEL.Enabled = True
        PintaGrilla
        
   End If
   
   
   
   'fGrid.Enabled = True
   Set oAp = Nothing

End Property




'#Region Grilla

'////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////
'                       GRILLA
'http://msdn.microsoft.com/en-us/library/aa230201(VS.60).aspx
'Editing Cells in a Hierarchical FlexGrid Spreadsheet
'////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////


Function Fgi(r As Integer, c As Integer) As Integer
   Fgi = c + fGrid.Cols * r
End Function




Private Sub fGrid_KeyDown(KeyCode As Integer, Shift As Integer)
    'If KeyCode = vbKeyF7 Or KeyCode = vbKeyInsert Then
    '    AgregarNodo
    'End If
End Sub

Private Sub fGrid_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   'posicionarse en la celda de la grilla?

   
   If Button = vbRightButton Then
        With fGrid
            If .MouseRow < .Rows And .MouseCol < .Cols Then
                .Row = .MouseRow
                .col = .MouseCol
            End If
            
            If .Row < 2 Then
                MnuDetA(0).Enabled = False
            Else
                MnuDetA(0).Enabled = True
            End If
            
            'MnuDetA(0).Caption = "Modificar"
            'MnuDetA(1).Caption = "Agregar Etapa"
            'MnuDetA(2).Caption = "Agregar Item"
            'MnuDetA(3).Caption = "Cortar"
            'MnuDetA(4).Caption = "Copiar"
            'MnuDetA(5).Caption = "Pegar"
            'MnuDetA(6).Caption = "Eliminar"
            
        If fGrid.TextMatrix(1, COL_FECHA) = "" Then
            MnuDetA(0).Enabled = False
            'MnuDetA(1).Enabled = False
        Else
            MnuDetA(0).Enabled = True
            'MnuDetA(1).Enabled = True
        
        End If
            
            'PopupMenu MnuDet, , , , MnuDetA(0)
        End With
   End If
End Sub


Private Sub MnuDetA_Click(index As Integer)

   Select Case index
      Case 0
        If fGrid.TextMatrix(1, COL_FECHA) = "" Then Exit Sub 'estoy en el nivel de obra
        'AgregarEtapa
      Case 1
        If fGrid.TextMatrix(1, COL_FECHA) = "" Then Exit Sub 'estoy en el nivel de obra
        'AgregarItem
      Case 2
        'EditarNodo (fGrid.TextMatrix(fGrid.Row, COL_FECHA))
      Case 3
        If fGrid.TextMatrix(1, COL_FECHA) = "" Then Exit Sub
        'EliminarNodo ' (fGrid.TextMatrix(fGrid.row, COL_ID1))
   End Select

End Sub

Private Sub fGrid_KeyPress(KeyAscii As Integer)
    
    With fGrid
        If False Then '.col = COL_FECHA Then
            If KeyAscii = 13 Then
                fGrid_DblClick
            End If
            'KeyAscii = 0
        ElseIf KeyAscii = 6546 Then 'F7
            'AgregarNodo
        ElseIf .col = COL_OPPREVISTA Or .col = COL_PEDIDOSPREVISTOS Or .col = COL_CANTIDAD Then
            If (.col = COL_OPPREVISTA Or .col = COL_PEDIDOSPREVISTOS) And .TextMatrix(.Row, COL_DOCUMENTO) <> "" Then
                MsgBox "Debe elegir un renglon vacío"
                Exit Sub
            End If
            If .col = COL_CANTIDAD And .TextMatrix(.Row, COL_DOCUMENTO) = "" Then
                MsgBox "Solo puede cambiar la cantidad de documentos existentes"
                Exit Sub
            End If
            
            If txtEdit.Enabled = True Then MSHFlexGridEdit fGrid, txtEdit, KeyAscii
        End If
    End With
End Sub


Sub fGrid_DblClick()
On Error Resume Next
    Dim Id As Long
    Dim oF As Form
    
    With fGrid
        If .col = COL_DOCUMENTO Then
                    'Lo escupo en pantalla

            Id = Val(mId(.TextMatrix(.Row, COL_ID2), 3))
            
            Select Case Left$(.TextMatrix(.Row, COL_DOCUMENTO), 2)
                 Case "OP"
                
                     Set oF = New frmProduccionOrden
                     With oF
                        .Id = Id
                        .Disparar = ActL
                        .Show , Me
                     End With
                 
                 Case "RM"
                 
                     Set oF = New frmRequerimientos
                     With oF
                        .Id = Id
                        .Disparar = ActL
                        .Show , Me
                     End With
                     
                 Case "OC"
                     Set oF = New frmOrdenesCompra
                     With oF
                        .Id = Id
                        .Disparar = ActL
                        .Show , Me
                     End With
                 
                 Case "NP"
            End Select
        End If

    End With
End Sub


Sub MSHFlexGridEdit(MSHFlexGrid As Control, _
Edt As Control, KeyAscii As Integer)

   ' Use the character that was typed.
   Select Case KeyAscii

   ' A space means edit the current text.
   Case 0 To 32
      Edt = MSHFlexGrid
      Edt.SelStart = 1000

   ' Anything else means replace the current text.
   Case Else
      Edt = Chr(KeyAscii)
      Edt.SelStart = 1
   End Select

   ' Show Edt at the right place.
   With MSHFlexGrid
   Edt.Move .Left + ScaleX(.CellLeft, vbTwips, .Container.ScaleMode), _
      .TOp + ScaleY(.CellTop, vbTwips, .Container.ScaleMode), _
       ScaleX(.CellWidth - 8, vbTwips, .Container.ScaleMode), _
      ScaleY(.CellHeight - 8, vbTwips, .Container.ScaleMode)
    End With

   Edt.Visible = True

   ' And make it work.
   
   Edt.SetFocus
End Sub











Private Sub OptPeriodo_Click(index As Integer)
    RecalculaFecha
End Sub

Private Sub txtBusca_KeyPress(KeyAscii As Integer)
   If KeyAscii = Asc(vbCr) Then
      If KeyAscii = 13 Then
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set dcfields(0).RowSource = Aplicacion.Articulos.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set dcfields(0).RowSource = Aplicacion.Articulos.TraerLista
         End If
      End If
      dcfields(0).SetFocus
      SendKeys "%{DOWN}"
   End If
End Sub

Sub txtEdit_KeyPress(KeyAscii As Integer)
   ' Delete returns to get rid of beep.
   If KeyAscii = Asc(vbCr) Then KeyAscii = 0
End Sub

Sub txtEdit_KeyDown(KeyCode As Integer, _
Shift As Integer)
   EditKeyCode fGrid, txtEdit, KeyCode, Shift
End Sub

Sub EditKeyCode(MSHFlexGrid As Control, Edt As _
Control, KeyCode As Integer, Shift As Integer)

   ' Standard edit control processing.
   Select Case KeyCode

   Case 27   ' ESC: hide, return focus to MSHFlexGrid.
      Edt.Visible = False
      MSHFlexGrid.SetFocus

   Case 13   ' ENTER return focus to MSHFlexGrid.
      MSHFlexGrid.SetFocus

   Case 38      ' Up.
      MSHFlexGrid.SetFocus
      DoEvents
      If MSHFlexGrid.Row > MSHFlexGrid.FixedRows Then
         MSHFlexGrid.Row = MSHFlexGrid.Row - 1
      End If

   Case 40      ' Down.
      MSHFlexGrid.SetFocus
      DoEvents
      If MSHFlexGrid.Row < MSHFlexGrid.Rows - 1 Then
         MSHFlexGrid.Row = MSHFlexGrid.Row + 1
      End If
   End Select
End Sub


Sub fGrid_GotFocus()
   If txtEdit.Visible = False Then Exit Sub
   fGrid = txtEdit
   txtEdit.Visible = False
   SaveCellChange
End Sub

Sub fGrid_LeaveCell()
   If txtEdit.Visible = False Then Exit Sub
   fGrid = txtEdit
   txtEdit.Visible = False
   SaveCellChange
End Sub

Sub SaveCellChange()
On Error Resume Next
    Dim Id As Long

    With fGrid
    Select Case .col
        Case COL_CANTIDAD
        
        Case COL_FECHA
            Dim Orden As ComPronto.ProduccionOrden
            Set Orden = AplicacionProd.ProduccionOrdenes.Item(.TextMatrix(.Row, COL_ID1))
            With Orden.Registro
                !FechaInicioPrevista = txtEdit
                !Observaciones = "Modificador por ProntoProduccion"
            End With
            Orden.Guardar
            Set Orden = Nothing
        Case COL_PEDIDOSPREVISTOS
            Dim Plan As Plan
            
            If IsNumeric(.TextMatrix(.Row, COL_ID2)) Then
                Set Plan = AplicacionProd.Planes.Item(.TextMatrix(.Row, COL_ID2))
            Else
                Set Plan = AplicacionProd.Planes.Item(-1)
            End If
            
            With Plan.Registro
                !Cantidad = iisEmpty(txtEdit, 0)
            End With
            'Id = Plan.Guardar
            
            .TextMatrix(.Row, COL_ID2) = Id
            Set Plan = Nothing
    End Select
    End With

    RecalcularColumnas

End Sub

Sub RecalcularColumnas()
    On Error Resume Next
    Dim i As Integer
    Dim tempc As Integer
    Dim tempr As Integer
    
    
   
    
    With fGrid
         For i = 2 To .Rows - 1
        
            'planmat la coulmna "OPPrev" debe producir el Material Planificado, y NO el Producido
            .TextMatrix(i - 1, COL_STOCKFINAL) = iisEmpty(.TextMatrix(i - 1, COL_STOCKINICIAL), 0) - iisEmpty(.TextMatrix(i - 1, COL_ACONSUMIR), 0) + iisEmpty(.TextMatrix(i - 1, COL_INGRESOSPREVISTOS), 0) + iisEmpty(.TextMatrix(i - 1, COL_OPPREVISTA), 0)
            .TextMatrix(i, COL_STOCKINICIAL) = Val(.TextMatrix(i - 1, COL_STOCKFINAL)) + iisEmpty(.TextMatrix(i - 1, COL_PEDIDOSPREVISTOS), 0)
            'If iisEmpty(.TextMatrix(i, COL_OPPREVISTA), 0) > 0 Then .TextMatrix(i, COL_ACONSUMIR) = (Val(iisEmpty(.TextMatrix(i, COL_CANTIDAD), 0)) + iisEmpty(.TextMatrix(i, COL_OPPREVISTA), 0))
            '.TextMatrix(i, COL_INGRESOSPREVISTOS) = .TextMatrix(i - 1, COL_STOCKINICIAL)
        
            
            .TextMatrix(i - 1, COL_STOCKFINAL) = Format(.TextMatrix(i - 1, COL_STOCKFINAL), "#,##0.00")
            .TextMatrix(i, COL_STOCKINICIAL) = Format(.TextMatrix(i, COL_STOCKINICIAL), "#,##0.00")
            .TextMatrix(i, COL_ACONSUMIR) = Format(.TextMatrix(i, COL_ACONSUMIR), "#,##0.00")
        
            
            
            If iisNull(.TextMatrix(i - 1, COL_STOCKFINAL), 0) < 0 Then
                '.TextMatrix(i, COL_IMPDESVIO) = 0
                tempc = .col
                tempr = .Row
            
                .Row = i - 1
                .col = COL_STOCKFINAL
                .CellBackColor = &HFF&
            
                .col = tempc
                .Row = tempr
            Else
                ColorearCelda fGrid, i - 1, COL_STOCKFINAL, &H8000000E
            End If
        Next
    
        
        'el ultimo renglon...
        .TextMatrix(i - 1, COL_STOCKFINAL) = iisEmpty(.TextMatrix(i - 1, COL_STOCKINICIAL), 0) - iisEmpty(.TextMatrix(i - 1, COL_ACONSUMIR), 0) + iisEmpty(.TextMatrix(i - 1, COL_INGRESOSPREVISTOS), 0)
        .TextMatrix(i - 1, COL_STOCKFINAL) = Format(.TextMatrix(i - 1, COL_STOCKFINAL), "#,##0.00")
        


        If iisNull(.TextMatrix(i - 1, COL_STOCKFINAL), 0) < 0 Then
            '.TextMatrix(i, COL_IMPDESVIO) = 0
            tempc = .col
            tempr = .Row
        
            .Row = i - 1
            .col = COL_STOCKFINAL
            .CellBackColor = &HFF&
        
            .col = tempc
            .Row = tempr
        Else
            ColorearCelda fGrid, i - 1, COL_STOCKFINAL, &H8000000E
        End If
    
    End With

End Sub

Sub ColorearCelda(Grid As MSFlexGrid, r As Long, c As Long, Color)
    Dim tempc As Integer
    Dim tempr As Integer
    With Grid
        tempc = .col
        tempr = .Row
    
        .Row = r
        .col = c
        .CellBackColor = Color
    
        .col = tempc
        .Row = tempr
    End With
End Sub



Sub ConfiguraGrilla(Optional Redimensionar As Boolean = True)
    With fGrid
        If Redimensionar Then
            .FixedRows = 1
            .FixedCols = 0
            .Cols = COL_MAX + 1
        End If
        
        

        .ColWidth(COL_ID1) = 0
        .ColWidth(COL_ID2) = 0
        
        .ColWidth(COL_FECHA) = 1100
        .ColWidth(COL_DOCUMENTO) = 1200
        .ColWidth(COL_CLIENTE) = 1550
        .ColWidth(COL_CANTIDAD) = 0 ' 725
        .ColWidth(COL_STOCKINICIAL) = 1200
        .ColWidth(COL_ACONSUMIR) = 1100
        .ColWidth(COL_INGRESOSPREVISTOS) = 1100
        .ColWidth(COL_STOCKFINAL) = 1200
        .ColWidth(COL_PEDIDOSPREVISTOS) = 1300
        .ColWidth(COL_OPPREVISTA) = 1300

        .ColWidth(COL_D) = 0 ' 400
        .ColWidth(COL_SS) = 0 ' 400
        .ColWidth(COL_NN) = 0 '400
        .ColWidth(COL_EOP) = 0 ' 400
        
        .TextMatrix(0, COL_FECHA) = "Fecha"
        .TextMatrix(0, COL_DOCUMENTO) = "Documento" ' (OPs y OCs)"
        .TextMatrix(0, COL_CLIENTE) = "Cliente"
        .TextMatrix(0, COL_CANTIDAD) = "Cant."
        .TextMatrix(0, COL_STOCKINICIAL) = "Stk Inic."
        .TextMatrix(0, COL_ACONSUMIR) = "- Consumo"
        .TextMatrix(0, COL_INGRESOSPREVISTOS) = "+ Ingreso"
        .TextMatrix(0, COL_STOCKFINAL) = "= Stk Final"
        .TextMatrix(0, COL_PEDIDOSPREVISTOS) = "Comprar(RM)" 'istos (Requerimiento de Materiales)"
        .TextMatrix(0, COL_OPPREVISTA) = "Producir(OP)" 'istas (Ordenes de Produccion)"
                
        .ColAlignment(COL_FECHA) = flexAlignLeftCenter
    
    
        'http://www.webandmacros.com/MRPcasopractico1.htm
        .TextMatrix(0, COL_D) = "D"
        .TextMatrix(0, COL_SS) = "SS"
        .TextMatrix(0, COL_NN) = "NN"
        .TextMatrix(0, COL_EOP) = "EOP"
    
    
    End With
End Sub



Public Function LlenarGrilla(rs As ADODB.Recordset) As Boolean
On Error GoTo ErrorHandler
    
    Dim i As Integer
    Dim j As Integer
    Dim tempc As Long
    Dim tempr As Long
    Dim Fecha As Date
    
    i = 1
    
    
    With fGrid
        .Redraw = False
        .Clear
        
        .Cols = COL_MAX + 1
        .Rows = DTFields(2) - DTFields(1) + 2

        'el primer renglon tiene el stock
        rs.MoveFirst
        '.TextMatrix(2, COL_STOCKINICIAL) = iisNull(rs.Fields("StockInicial").Value, "")
        .TextMatrix(2, COL_STOCKINICIAL) = Format(iisNull(rs.Fields("StockInicial").Value, ""), "#,##0.00")
        
        Dim ponerfecha As Boolean
        ponerfecha = True
        For Fecha = FechaCorta(DTFields(1)) To FechaCorta(DTFields(2))
        
            rs.Filter = "FECHA>='" & Fecha & "' AND FECHA<'" & (Fecha + 1) & "'"
                            
            'If Not rs.EOF Then
                
                Do While Not rs.EOF
                    If .Rows >= i Then .Rows = i + 1
                    
                    .TextMatrix(i, COL_ID1) = rs.Fields("id").Value
                    .TextMatrix(i, COL_ID2) = rs.Fields("id").Value
                    'If ponerfecha Then
                        .TextMatrix(i, COL_FECHA) = rs.Fields("Fecha").Value
                    '    ponerfecha = False
                    'Else
                    '    .TextMatrix(i, COL_FECHA) = ""
                    'End If
                    .TextMatrix(i, COL_DOCUMENTO) = iisNull(rs.Fields("Documento").Value, "")
                    .TextMatrix(i, COL_CLIENTE) = iisNull(rs.Fields("Cliente").Value, "")
                    .TextMatrix(i, COL_CANTIDAD) = iisNull(rs.Fields("Cantidad").Value, "")
                    .TextMatrix(i, COL_STOCKINICIAL) = iisNull(rs.Fields("StockInicial").Value, "")
                    .TextMatrix(i, COL_ACONSUMIR) = iisNull(rs.Fields("AConsumir").Value, "")
                    .TextMatrix(i, COL_INGRESOSPREVISTOS) = iisNull(rs.Fields("IngresosPrevistos").Value, "")
                    .TextMatrix(i, COL_STOCKFINAL) = iisNull(rs.Fields("StockFinal").Value, "")
                    .TextMatrix(i, COL_PEDIDOSPREVISTOS) = iisNull(rs.Fields("PedidosPrevistos").Value, "")
                    .TextMatrix(i, COL_OPPREVISTA) = iisNull(rs.Fields("OPPrevista").Value, "")
                    
                    
                    '///////////////////////////
                    'coloreo columnas
                   
                    If iisNull(.TextMatrix(i, COL_STOCKFINAL), 0) < 0 Then
                        '.TextMatrix(i, COL_IMPDESVIO) = 0
                        tempc = .col
                        tempr = .Row
                    
                        .Row = i
                        .col = COL_STOCKFINAL
                        .CellBackColor = &HFF&
                    
                        .col = tempc
                        .Row = tempr
                    End If
                   '////////////////////////////
                    
                    i = i + 1
                    rs.MoveNext
                Loop
            
            
            'Else
                'renglon vacio
                
                If .Rows >= i Then .Rows = i + 1
                rs.Filter = ""
                
                If rs.EOF Then
                    .TextMatrix(i, COL_STOCKINICIAL) = 0
                Else
                    .TextMatrix(i, COL_STOCKINICIAL) = Format(iisNull(rs.Fields("StockInicial").Value, ""), "#,##0.00")
                End If
                
                'If ponerfecha Then
                    .TextMatrix(i, COL_FECHA) = Fecha
                '    ponerfecha = False
                'Else
                '    .TextMatrix(i, COL_FECHA) = ""
                'End If
                
                i = i + 1
                ponerfecha = True
            'End If
        Next
        
        
        PintaGrilla
        
        
        
        ConfiguraGrilla (False)
        .Redraw = True
    
    End With
    
    
    Exit Function
    
ErrorHandler:
    Exit Function
End Function


Sub PintaGrilla()
    Dim i
    Dim tempr
    
    With fGrid
        For i = 1 To .Rows - 1
             tempr = .Row
             .Row = i
             .col = COL_FECHA
             .CellBackColor = KC_GRIS
             .col = COL_DOCUMENTO
             .CellBackColor = KC_GRIS
             .col = COL_CLIENTE
             .CellBackColor = KC_GRIS
             '.Col = COL_CANTIDAD
             '.CellBackColor = KC_AMARILLO
             '.Col = COL_STOCKINICIAL
             '.CellBackColor = KC_AMARILLO
             '.Col = COL_ACONSUMIR
             '.CellBackColor = KC_AMARILLO
             '.Col = COL_INGRESOSPREVISTOS
             '.CellBackColor = KC_AMARILLO
             '.Col = COL_STOCKFINAL
             '.CellBackColor = KC_AMARILLO
             .col = COL_PEDIDOSPREVISTOS
             .CellBackColor = KC_GRIS
             .col = COL_OPPREVISTA
             .CellBackColor = KC_GRIS
            .Row = tempr
        Next
    End With
End Sub

Public Sub cmdCommand1_Click()
    If Not IsNumeric(dc0boundtext) Then
        MsgBox "Debe elegir un material para planificar"
        Exit Sub
    End If


'·         Cuando una OP está en estado “NUEVA” no debe mostrarse
'Stop
    Recargar
    dcfields(0).Enabled = False
    'dcfields(11).Enabled = False

    cmd(7).Enabled = True
    cmdOPsPendientes(0).Enabled = True
End Sub

Sub Recargar()
   Dim oAp As ComPronto.Aplicacion
   
   Set oAp = AplicacionProd

  
   
'o        No está mostrando las OP generadas en el período que se le solicita
'(por lo menos cuando hice la op manualmente). A su vez, una OP sólo puede mostrarse
'en el Plan cuando ya está “liberada” y por lo tanto toma “Estado: ABIERTA”.
   'Stop
   
   cmd(1).Enabled = True
   'cmd(0).Enabled = True
   
   
   Dim oRs As ADOR.Recordset
   If IsNumeric(dc0boundtext) Then ' dcfields(0).BoundText) Then
         Set oRs = AplicacionProd.Planes.TraerFiltrado("_Periodo", _
                    Array(dc0boundtext, dc0boundtext, DTFields(1), DTFields(2)))
         Debug.Print "ProduccionPlanes_TX_Periodo " & dc0boundtext & "," & dc0boundtext & ",'" & DTFields(1) & "','" & DTFields(2) & "'"
         
         LlenarGrilla oRs
        
        
        Set oRs = AplicacionProd.ProduccionFichas.TraerFiltrado("_ProporcionEntreProducidoyMaterial", _
                    Array(dc0boundtext, dc0boundtext))   'dcfields(0).BoundText))
           
        If oRs.RecordCount > 0 Then Proporcion = iisNull(oRs(0), 0)
          
        RecalcularColumnas
   End If
   
   Set oAp = Nothing

End Sub


Public Function Exportar_Excel( _
    Path_Libro As String, _
    FlexGrid As MSFlexGrid) As Boolean

    On Error GoTo errSub

    
    
    
    Dim oEx As Excel.Application
    
    
    
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      
      .Visible = True
      
      With .Workbooks.Add(glbPathPlantillas & "\Planilla.xlt")
         
         With .ActiveSheet

            'Para las filas y columnas del FlexGrid y la Hoja
            Dim Fila As Integer
            Dim Columna As Integer
        
            'If Path_Libro = vbNullString Then
            '    ' Falta la ruta del libro
            '    MsgBox " Falta el Path del archivo de Excel "
            '    Exit Function
            'End If
        
            Exportar_Excel = False
        
                
            'En la plantilla del Excel que sale de este punto, te pido que veas la posibilidad de agregar un encabezado, pues sólo están los títulos de las columnas
            'pero no se sabe de que el el listado de Excel, ni la fecha, ni el artículo, etc.
            
            .Cells(1, 1).Value = "Planificación de Materiales"
            .Cells(1, 2).Value = Now
            '.Cells(1, 3).Value = Articulo
            

            
            '               mTitulo = "ESTADO DE REQUERIMIENTOS"
            '   If Option2.Value Then
            '      mTitulo = mTitulo & " - Obra : " & dcfields(0).Text & "   "
            '   End If
            '   If Option4.Value Then
            '      mTitulo = mTitulo & " - RM Nro. : " & txtNumeroRequerimiento.Text & "   "
            '   End If
            '   If Option6.Value Then
            '      mTitulo = mTitulo & " - LA Nro. : " & txtNumeroAcopio.Text & "   "
            '   End If
            '   If Check1.Value = 1 Then
            '      mTitulo = mTitulo & "[ Seguimiento de equipo : " & dcfields(1).Text & " ]  "
            '   End If
            '
            '   For Each oL In Lista.ListItems: oL.Selected = True: Next
            '
            '   Set oEx = CreateObject("Excel.Application")
            '   With oEx
            '      .Visible = True
            '      With .Workbooks.Add(mPlantilla)
            '         With .ActiveSheet
            '            .Cells(2, 2) = mTitulo
            '            fl = 6
            '            For Each oL In Lista.ListItems
            '
            '               rchAuxiliar.TextRTF = Lista.TextoLargo(oL.Tag)
            '               s = rchAuxiliar.Text
            '               s = Replace(s, Chr(13) + Chr(10) + Chr(13) + Chr(10), "")
            '
            '               .Cells(fl, 1) = oL.SubItems(4)
            '               .Cells(fl, 2) = oL.SubItems(5)
            '               .Cells(fl, 3) = CDate(oL.SubItems(6))
            '               .Cells(fl, 4) = oL.SubItems(1)
            '               .Cells(fl, 5) = oL.SubItems(9)
            '               .Cells(fl, 6) = oL.SubItems(8)
            '
            '               .Cells(fl, 7) = CDate(oL.SubItems(11))
            '               .Cells(fl, 8) = CDate(oL.SubItems(14))
            '               .Cells(fl, 9) = oL.SubItems(15)
            '               oEx.Cells(fl, 9).Select
            '               With oEx.Selection
            '                   .VerticalAlignment = xlTop

            
        
            ' Recorremos el FlexGrid por filas y columnas
            For Fila = 1 To FlexGrid.Rows
                For Columna = 2 To FlexGrid.Cols - 1
                
                    ' Agrega el Valor en la celda indicada  del Excel
                    .Cells(Fila + 1, Columna - 1).Value = _
                                FlexGrid.TextMatrix(Fila - 1, Columna)
            
                Next Columna
        
            Next Fila
        
            .Cells(2, "H").Value = "--> Stk Final"
            
            '////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////
                            
'            'Acá tendría que hacer lo mismo para todos los materiales de 1 y 2 nivel
'
'            Dim fichanivel1 As ComPronto.ProduccionFicha
'            Dim fichanivel2 As ComPronto.ProduccionFicha
'            Dim oDet As DetProduccionOrden
'            Dim oRs As ADOR.Recordset
'            Dim rs As ADOR.Recordset
'            Dim rs1 As ADOR.Recordset
'            Dim rs2 As ADOR.Recordset
'            Dim i As Integer
'
'            'me traigo la ficha del artículo
'            Set rs = AplicacionProd.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", dc0boundtext)
'            If rs.RecordCount = 0 Then
'                MsgBox ("No se encontró la ficha")
'                Exit Function
'            End If
'            Set fichanivel1 = AplicacionProd.ProduccionFichas.Item(rs!idProduccionFicha)
'            Set rs1 = fichanivel1.DetProduccionFichas.TraerTodos
'
'
'
'            Do While Not rs1.EOF
'                i = i + 1
'
'                ChorizoPlanificacion rs1!IdArticulo, oEx.ActiveSheet, Fila, Columna, i * 20, FlexGrid ' tiro un chorizo con el estado del articulo
'
'
'                'me traigo la ficha del artículo
'                Set rs = AplicacionProd.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", rs1!IdArticulo)
'                If rs.RecordCount <> 0 Then
'
'                    Set fichanivel2 = AplicacionProd.ProduccionFichas.Item(rs!idProduccionFicha)
'                    Set rs2 = fichanivel2.DetProduccionFichas.TraerTodos
'
'                    Do While Not rs2.EOF
'                        i = i + 1
'                        'tiro un chorizo con el estado del articulo
'                        ChorizoPlanificacion rs2!IdArticulo, oEx.ActiveSheet, Fila, Columna, i * 20, FlexGrid     ' tiro un chorizo con el estado del articulo
'
'                        rs2.MoveNext
'                    Loop
'                End If
'
'
'                rs1.MoveNext
'            Loop
            
            
           
            '////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////
            
            
            .Range("A1").Select
            oEx.Run "ArmarFormato"
      
            .Rows("1:1").Select
            oEx.Selection.Insert Shift:=xlDown

        
        
        
         End With
    End With
   End With


    
    Exportar_Excel = True

Exit Function

'Error

errSub:

'Cierra la hoja y el la aplicación Excel
'If Not o_Libro Is Nothing Then: o_Libro.Close False
'If Not o_Excel Is Nothing Then: o_Excel.Quit

'Liberar los objetos
'Set o_Excel = Nothing
'Set o_Libro = Nothing
'Set o_Hoja = Nothing

If Err.Number <> 0 Then
    MsgBox Err.Number & " - " & Err.Description
End If

End Function




Sub ChorizoPlanificacion(ByVal IdArticulo As Long, ByRef sheet As Object, ByRef Fila As Integer, ByRef Columna As Integer, desplazamiento As Integer, FlexGrid As MSFlexGrid)
    With sheet
        
        'cómo debe cambiar esto segun el articulo que se pase?
        Dim art As ComPronto.Articulo
        Set art = Aplicacion.Articulos.Item(IdArticulo)
        
        .Cells(desplazamiento, 2) = art.Registro!descripcion
        
        For Fila = 1 To FlexGrid.Rows
            For Columna = 2 To FlexGrid.Cols - 1
            
                ' Agrega el Valor en la celda indicada  del Excel
                .Cells(Fila + 1 + desplazamiento, Columna - 1).Value = _
                            FlexGrid.TextMatrix(Fila - 1, Columna)
        
        
                'EOP del nivel anterior es el NN del nuevo
                'Si la disponibilidad es mayor que 0; NN =NB-D+SS
                'Si la disponibilidad es igual a 0; NN=NB
                
                
            Next Columna
    
        Next Fila
    End With


End Sub






Private Sub fGrid_SelChange()
    HighlightRow fGrid.Row, fGrid
End Sub

Public Sub HighlightRow(Row As Long, Grid As MSFlexGrid)
'      With Grid
'            If Row >= 0 And Row < .Rows Then
'                 .Row = Row
'                 .RowSel = Row
'                 .col = 0
'                 .ColSel = .Cols - 1
'            End If
'     End With
End Sub

Function FechaCorta(D As Date) As Date
    FechaCorta = CDate(DatePart("yyyy", D) & "/" & DatePart("m", D) & "/" & DatePart("d", D))
End Function

