VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmProgRecursos 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Programación de Recursos"
   ClientHeight    =   10215
   ClientLeft      =   45
   ClientTop       =   405
   ClientWidth     =   12990
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   ScaleHeight     =   10215
   ScaleWidth      =   12990
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtCajaDesplazada 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0FFFF&
      BorderStyle     =   0  'None
      Height          =   135
      Left            =   12720
      TabIndex        =   35
      Top             =   9240
      Visible         =   0   'False
      Width           =   135
   End
   Begin VB.CommandButton cmdCommand3 
      Caption         =   "v"
      Height          =   375
      Left            =   12840
      TabIndex        =   34
      Top             =   8640
      Visible         =   0   'False
      Width           =   255
   End
   Begin VB.CommandButton cmdCommand2 
      Caption         =   "^"
      Height          =   375
      Left            =   12840
      TabIndex        =   33
      Top             =   1920
      Visible         =   0   'False
      Width           =   255
   End
   Begin VB.OptionButton OptPeriodo 
      Caption         =   "Diario"
      Height          =   255
      Index           =   2
      Left            =   2400
      TabIndex        =   32
      Top             =   360
      Value           =   -1  'True
      Width           =   975
   End
   Begin VB.TextBox txtFrac 
      Height          =   285
      Left            =   120
      TabIndex        =   30
      Text            =   "1"
      Top             =   1080
      Visible         =   0   'False
      Width           =   495
   End
   Begin VB.ListBox List1 
      Height          =   1035
      Left            =   9720
      TabIndex        =   29
      Top             =   240
      Width           =   3150
   End
   Begin VB.CommandButton cmdEXCEL 
      Height          =   495
      Left            =   8880
      Picture         =   "frmProgRecursos.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   22
      Top             =   9600
      Width           =   615
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Buscar"
      Height          =   375
      Left            =   7800
      TabIndex        =   12
      Top             =   960
      Width           =   1335
   End
   Begin VB.OptionButton OptPeriodo 
      Caption         =   "Quincena"
      Height          =   255
      Index           =   0
      Left            =   2400
      TabIndex        =   6
      Top             =   720
      Width           =   1215
   End
   Begin VB.OptionButton OptPeriodo 
      Caption         =   "Mensual"
      Height          =   255
      Index           =   1
      Left            =   2400
      TabIndex        =   5
      Top             =   1080
      Width           =   1215
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "idProduccionSector"
      Height          =   315
      Index           =   0
      Left            =   4200
      TabIndex        =   4
      Top             =   600
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "idProduccionSector"
      Text            =   ""
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Salir"
      CausesValidation=   0   'False
      Height          =   495
      Index           =   2
      Left            =   11520
      TabIndex        =   3
      Top             =   9600
      Width           =   1335
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Guardar"
      Height          =   495
      Index           =   0
      Left            =   9960
      TabIndex        =   1
      Top             =   9600
      Width           =   1335
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Fecha"
      Height          =   330
      Index           =   1
      Left            =   720
      TabIndex        =   7
      Top             =   240
      Width           =   1485
      _ExtentX        =   2619
      _ExtentY        =   582
      _Version        =   393216
      CustomFormat    =   "d MMM  HH:00"
      DateIsNull      =   -1  'True
      Format          =   57278467
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaInicioPrevista"
      Height          =   330
      Index           =   2
      Left            =   720
      TabIndex        =   8
      Top             =   600
      Width           =   1485
      _ExtentX        =   2619
      _ExtentY        =   582
      _Version        =   393216
      CustomFormat    =   "d MMM  HH:00"
      Format          =   57278467
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Bindings        =   "frmProgRecursos.frx":03B6
      DataField       =   "idProduccionArea"
      Height          =   315
      Index           =   1
      Left            =   4200
      TabIndex        =   13
      Tag             =   "ProduccionAreas"
      Top             =   240
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProduccionArea"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProduccionProceso"
      Height          =   315
      Index           =   2
      Left            =   7080
      TabIndex        =   15
      Tag             =   "ProduccionProcesos"
      Top             =   240
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProduccionProceso"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdMaquina"
      Height          =   315
      Index           =   3
      Left            =   7080
      TabIndex        =   16
      Tag             =   "Articulos"
      Top             =   600
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaOrdenProduccion"
      Height          =   330
      Index           =   0
      Left            =   8040
      TabIndex        =   19
      Top             =   9720
      Visible         =   0   'False
      Width           =   1365
      _ExtentX        =   2408
      _ExtentY        =   582
      _Version        =   393216
      Format          =   57278465
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProduccionLinea"
      Height          =   315
      Index           =   4
      Left            =   4200
      TabIndex        =   23
      Tag             =   "ProduccionLineas"
      Top             =   960
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProduccionLinea"
      Text            =   ""
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Guardar y Salir"
      Height          =   495
      Index           =   1
      Left            =   9720
      TabIndex        =   2
      Top             =   9600
      Visible         =   0   'False
      Width           =   1335
   End
   Begin MSFlexGridLib.MSFlexGrid fGrid 
      Height          =   7935
      Left            =   120
      TabIndex        =   11
      Top             =   1440
      Width           =   12735
      _ExtentX        =   22463
      _ExtentY        =   13996
      _Version        =   393216
      Rows            =   10
      Cols            =   15
      WordWrap        =   -1  'True
      FocusRect       =   0
      HighLight       =   0
      GridLinesFixed  =   1
      ScrollBars      =   2
      SelectionMode   =   1
      MergeCells      =   1
      AllowUserResizing=   1
      Appearance      =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label lblFraccion 
      AutoSize        =   -1  'True
      Caption         =   "div x dia"
      Height          =   195
      Index           =   1
      Left            =   720
      TabIndex        =   31
      Top             =   1080
      Visible         =   0   'False
      Width           =   585
   End
   Begin VB.Shape Shape5 
      FillColor       =   &H0080FF80&
      FillStyle       =   0  'Solid
      Height          =   135
      Left            =   1800
      Top             =   9600
      Width           =   135
   End
   Begin VB.Label Label5 
      Caption         =   "Avance"
      Height          =   255
      Left            =   2040
      TabIndex        =   28
      Top             =   9600
      Width           =   975
   End
   Begin VB.Shape Shape4 
      Height          =   615
      Left            =   120
      Top             =   9480
      Visible         =   0   'False
      Width           =   3135
   End
   Begin VB.Label Label4 
      Caption         =   "Anulada"
      Height          =   255
      Left            =   2040
      TabIndex        =   27
      Top             =   9840
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.Shape Shape3 
      FillColor       =   &H00FFC0FF&
      FillStyle       =   0  'Solid
      Height          =   135
      Left            =   1800
      Top             =   9840
      Visible         =   0   'False
      Width           =   135
   End
   Begin VB.Label Label2 
      Caption         =   "En ejecución"
      Height          =   255
      Left            =   600
      TabIndex        =   26
      Top             =   9840
      Width           =   1815
   End
   Begin VB.Shape Shape2 
      FillColor       =   &H00FFC0C0&
      FillStyle       =   0  'Solid
      Height          =   135
      Left            =   360
      Top             =   9840
      Width           =   135
   End
   Begin VB.Shape Shape1 
      FillColor       =   &H00C0FFFF&
      FillStyle       =   0  'Solid
      Height          =   135
      Left            =   360
      Top             =   9600
      Width           =   135
   End
   Begin VB.Label lblAnulada 
      Caption         =   "Programable"
      Height          =   255
      Left            =   600
      TabIndex        =   25
      Top             =   9600
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Linea"
      Height          =   225
      Index           =   1
      Left            =   3600
      TabIndex        =   24
      Top             =   1080
      Width           =   720
   End
   Begin VB.Label lblAlarma 
      Caption         =   "HAY CONFLICTOS EN LA PROGRAMACION"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   3600
      TabIndex        =   21
      Top             =   9480
      Visible         =   0   'False
      Width           =   3375
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   255
      Index           =   4
      Left            =   7320
      TabIndex        =   20
      Top             =   9720
      Visible         =   0   'False
      Width           =   570
   End
   Begin VB.Label lblLabels 
      Caption         =   "Proceso"
      Height          =   225
      Index           =   2
      Left            =   6360
      TabIndex        =   18
      Top             =   360
      Width           =   960
   End
   Begin VB.Label lblLabels 
      Caption         =   "Maquina:"
      Height          =   225
      Index           =   0
      Left            =   6360
      TabIndex        =   17
      Top             =   720
      Width           =   1815
   End
   Begin VB.Label Label1 
      Caption         =   "Area"
      Height          =   255
      Left            =   3600
      TabIndex        =   14
      Top             =   360
      Width           =   975
   End
   Begin VB.Label lblReal 
      AutoSize        =   -1  'True
      Caption         =   "Final"
      Height          =   195
      Index           =   0
      Left            =   120
      TabIndex        =   10
      Top             =   720
      Width           =   330
   End
   Begin VB.Label lblInicioPrevisto 
      AutoSize        =   -1  'True
      Caption         =   "Inicio"
      Height          =   255
      Index           =   6
      Left            =   120
      TabIndex        =   9
      Top             =   360
      Width           =   375
   End
   Begin VB.Label Label3 
      Caption         =   "Sector"
      Height          =   255
      Left            =   3600
      TabIndex        =   0
      Top             =   720
      Width           =   975
   End
   Begin VB.Menu MnuDet 
      Caption         =   "MnuDet"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Duplicar"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   1
         Visible         =   0   'False
      End
   End
End
Attribute VB_Name = "frmProgRecursos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' #VBIDEUtils#**********************************
' * Programmer Name  : Waty Thierry
' * Web Site         : www.geocities.com/ResearchTriangle/6311/
' * E-Mail           : waty.thierry@usa.net
' * Date             : 14/06/99
' * Time             : 11:54
' **********************************************
' * Comments         : Get a temporary filename
' *
' *
' *************************************************

Private Declare Function GetTempPathA _
                Lib "kernel32" (ByVal nBufferLength As Long, _
                                ByVal lpBuffer As String) As Long
    
Private Declare Function GetTempFileNameA _
                Lib "kernel32" (ByVal lpszPath As String, _
                                ByVal lpPrefixString As String, _
                                ByVal wUnique As Long, _
                                ByVal lpTempFileName As String) As Long
     
Private Const UNIQUE_NAME = &H0

' *************************************************
' *************************************************
' *************************************************

Dim WithEvents origen As ComPronto.ProgRecurso
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm

Private mvarId As Long

Private mNivelAcceso As Integer, mOpcionesAcceso As String
Dim WithEvents ActL As ControlForm
Attribute ActL.VB_VarHelpID = -1

Const COL_IDMAQ = 1
Const COL_IDOPDETPROC = 2

Dim DragOPProcDet As Long
Dim DragModo As Long
Const K_BORDEIZQ = 0
Const K_BORDEDER = 2
Const K_MOVER = 1

Const DCFILTRO_AREA = 1
Const DCFILTRO_SECTOR = 0
Const DCFILTRO_LINEA = 4
Const DCFILTRO_PROCESO = 2
Const DCFILTRO_MAQUINA = 3

Dim bFuncionLlenarGrillaEjecutandose As Boolean

Dim COLSxDIA As Integer

Const ROWSxMAQ = 2 'renglones de grilla por cada maquina (estandar 2)
Const MAXMAQUINAS = 40 'maximo de maquinas en pantalla
Const ANCHO_NOMBRE_MAQUINAS_DEFAULT = 2500

Dim rsDirecto As ADOR.Recordset
Dim rsMaquinas As ADOR.Recordset

Dim ultimaPosYdondeSeApreto As Long
Dim ElBloqueQueAcabaDeMover As String

'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Sub LimpiarBloques()

    With fGrid
        '.Clear
        Dim r
        Dim c

        For r = 1 To .Rows - 1
            For c = 2 To .Cols - 1
                .TextMatrix(r, c) = ""
                
                .col = c
                .Row = r
                .CellBackColor = KC_BLANCO
                .CellAlignment = flexAlignLeftTop
            Next
        Next
        
        'metodo mas piola
        '  .FillStyle = flexFillRepeat
        '  .col = .FixedCols
        '  .Row = .FixedRows
        '  .ColSel = .Cols - 1
        '  .RowSel = .Rows - 1
        '  .CellBackColor = KC_BLANCO
        '  .CellForeColor = .ForeColor
    End With

End Sub

Public Function LlenarGrilla(Optional rs As ADOR.Recordset) As Boolean
    On Error GoTo ErrorHandler
    'On Error Resume Next
    
    Dim i As Integer
    Dim j As Integer
    Dim tempc As Long
    Dim tempr As Long
    Dim Fecha As Date
    Dim rsOPs As ADOR.Recordset
    Dim rsOPsDet As ADOR.Recordset
    
    Dim op As ProduccionOrden
    Dim OPDetProc As DetProdOrdenProceso
    
    i = 1
    Dim c As Long
    Dim r As Long
    
    lblAlarma.Visible = False
   
    'Set rsOPs = AplicacionProd.ProduccionOrdenes.TraerTodos '.TablasGenerales.TraerFiltrado("ProduccionOrdenes", "_PorIdTipoParaCombo", 3)
    
    bFuncionLlenarGrillaEjecutandose = True
    
    With fGrid
        .Redraw = False
        
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '           LIMPIAR
        'http://www.xtremevbtalk.com/showthread.php?postid=282585
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        Dim temptop
        temptop = .TopRow
        
        LimpiarBloques
        
        '.TopRow = temptop
        'EraseAllPictures
        
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        
        'MostrarTitulos
        
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        '//////              BLOQUES                              /////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        
        Dim inicio As Date
        Dim final As Date
        Dim tempinicio As Date
        Dim tempfinal As Date
        
        Dim ProcesoElegido As Integer

        If List1 <> "" Then
            If InStr(1, List1, "-") > 0 Then
                ProcesoElegido = Left(List1, InStr(1, List1, "-") - 1)
            Else
                ProcesoElegido = 0
            End If

        Else
            ProcesoElegido = 0
        End If
        
        
        
        
        
        
        
        
        'For r = .TopRow To .Rows - ROWSxMAQ * 1 - 1 Step ROWSxMAQ
        For r = 1 To (.Rows - ROWSxMAQ * 1 - 1) Step ROWSxMAQ
            
            'If fGrid.RowIsVisible(r) Then
        
            '///////////////////////////////////////
            'PROCESOS PROGRAMADOS
            '///////////////////////////////////////
            
            rsDirecto.Filter = "idMaquina=" & Left(.TextMatrix(r, 0), InStr(.TextMatrix(r, 0), "-") - 1)

            '" and FechaInicio<>null and idMaquina<>null and idMaquina<>-1)"
            If rsDirecto.RecordCount <> 0 Then
            
                If True Or rsDirecto!IdDetalleProduccionOrdenProceso <> ProcesoElegido Then
                
                    rsDirecto.MoveFirst

                    If rsDirecto.State = 0 Then
                        Stop
                        '.Redraw = True
                        Exit Function
                    End If
                
                    Do While Not rsDirecto.EOF
                
                        'Debug.Print rsDirecto!IdDetalleProduccionOrdenProceso
                        'If .TextMatrix(r, 0) = rsOPsDet!idMaquina Then
                        
                        
                        inicio = iisNull(iisNull(rsDirecto!FechaInicio, rsDirecto!FechaInicioPrevista), Now)
                        final = iisNull(iisNull(rsDirecto!fechafinal, rsDirecto!FechaFinalPrevista), Now)
                        
                        
                        
                        final = IIf(final > DTFields(2), DTFields(2), final)
                      
                        inicio = iisNull(inicio, DTFields(1))
                        final = iisNull(final, DTFields(1) + 1)
                      
                        Dim Color

                        'If rsDirecto!Programada = "SI" Then
                        If rsDirecto!PartesAsociados > 0 Then
                            Color = KC_AZUL
                        Else
                            Color = KC_AMARILLO
                        End If
                      
                        If FechaToCol(final) < FechaToCol(inicio) Then final = inicio
                      
                        If (final >= DTFields(1)) And (inicio <= DTFields(2)) Then 'dentro del rango mostrado.
                            If iisNull(rsDirecto!Anulada, "NO") <> "SI" Then 'And iisNull(rsDirecto!Cerro, "NO") <> "SI" Then
                                'Color = KC_GRIS
                                DibujaBloque FechaToCol(inicio), r, FechaToCol(final), r + ROWSxMAQ - 1, Color, rsDirecto!NumeroOrdenProduccion & "-" & rsDirecto!descripcion & " " & rsDirecto!IdDetalleProduccionOrdenProceso, rsDirecto!avance, iisNull(rsDirecto!Programada, "NO")
                            End If
                        End If
              
                        'End If
        
                        rsDirecto.MoveNext
                    Loop

                End If
            End If
        
            '///////////////////////////////////////
            'MAQUINAS PARADAS
            'Dibujar los bloques de parada de maquina y los programas fijos con otro color
            '///////////////////////////////////////
            'rsMaquinas.Filter = "idArticulo=" & Left(.TextMatrix(r, 0), InStr(.TextMatrix(r, 0), "-") - 1)
            'rsMaquinas.MoveFirst
            'With rsMaquinas
            '    Do While Not .EOF
            '
            '        If !FueraDeServicioFechaInicio Then
            '            DibujaBloque FechaToCol(!FueraDeServicioFechaInicio), r, FechaToCol(!FueraDeServicioRetornoEstimado) + COLSxDIA - 1, r + ROWSxMAQ - 1, KC_NEGRO, !FueraDeServicioConcepto, 0
            '        End If
            '        .MoveNext
            '    Loop
            'End With
            'End If

        Next
    
        
        
        
        '///////////////////////////////////////
        '///////////////////////////////////////
        '///////////////////////////////////////
        '///////////////////////////////////////
        '///////////////////////////////////////
        '///////////////////////////////////////
        '///////////////////////////////////////
        'FILA DE SIN ASIGNAR
        '///////////////////////////////////////
        '///////////////////////////////////////
        '///////////////////////////////////////
        
        r = fGrid.Rows - ROWSxMAQ
       
              
        '///////////////////////////////////////
        'parte II de FILA DE SIN ASIGNAR (mostrar arriba de todo el bloque elegido en la lista)
        '///////////////////////////////////////
        
        
        Dim celdaInicio As Long
        Dim celdaFinal As Long
        
        If ProcesoElegido > 0 Then
            If List1 <> "" Then 'mostrar arriba de todo el bloque elegido en la lista
                rsDirecto.Filter = "idDetalleProduccionOrdenProceso=" & ProcesoElegido '& " and (FechaInicio=null or idMaquina=null or idMaquina=-1)"

                If Not rsDirecto.EOF Then

                    If (IsNull(rsDirecto!FechaInicio) Or IsNull(rsDirecto!IdMaquina) Or rsDirecto!IdMaquina = -1) And iisNull(rsDirecto!avance, 0) = 0 Then
             
                        'acá el bloque termina teniendo el ancho de la OP entera. ARREGLAR
                        'FechaFinalPrevista - FechaInicioPrevista
            
                        inicio = iisNull(iisNull(rsDirecto!FechaInicio, rsDirecto!FechaInicioPrevista), DTFields(1))


                        If inicio < DTFields(1) Then inicio = DTFields(1)
                        final = DateAdd("h", rsDirecto("Horas"), inicio)
                        final = DateAdd("s", -1, final) 'para que sea justito antes y no ocupe el bloque siguiente
                        'final = DateAdd("n", -1, final)  'para que sea justito antes y no ocupe el bloque siguiente
                
                        rsDirecto!FechaInicioPrevista = inicio
                        rsDirecto!FechaFinalPrevista = final
              
                        'final = iisNull(rsDirecto!FechaFinal, rsDirecto!FechaFinalPrevista)
                        'final = IIf(final > DTFields(2), DTFields(2), final)
             
                        inicio = iisNull(inicio, DTFields(1))
                        final = iisNull(final, DTFields(1) + 1)
             
                        tempinicio = inicio 'horror. las uso así porque FechaToCol usa Byref, y si lo cambio, no anda bien el resto
                        tempfinal = final

                        If FechaToCol(tempfinal) < FechaToCol(tempinicio) Then
                            final = inicio
                        End If
        
                        'If rsDirecto!Programada = "SI" Then
                        '  Color = KC_GRIS
                        'Else
                        Color = KC_AMARILLO
                        'End If
                
                        celdaInicio = FechaToCol(inicio)
                        celdaFinal = FechaToCol(final)
                        DibujaBloque celdaInicio, r, celdaFinal, r + ROWSxMAQ - 1, Color, rsDirecto!NumeroOrdenProduccion & "-" & rsDirecto!descripcion & " " & rsDirecto!IdDetalleProduccionOrdenProceso, rsDirecto!avance, IIf(rsDirecto!PartesAsociados > 0, "SI", "NO"), , False
                    End If
                End If
            End If
        End If
        
        ElBloqueQueAcabaDeMover = ""
        
        '///////////////////////////////////////
        'FIN DE FILA DE SIN ASIGNAR
        '///////////////////////////////////////
        
        .TopRow = temptop
        'ConfiguraGrilla (False)
        .Redraw = True
        Debug.Print "redraw " & Time
        '.ZOrder 1 'al fondo
        '.Refresh
    End With

    'Me.Refresh 'ESTE ES EL SALVADOR!!!!! (si no, no se muestran bien los labels)
    
    bFuncionLlenarGrillaEjecutandose = False
    
    Exit Function
    
ErrorHandler:
    bFuncionLlenarGrillaEjecutandose = False
    MsgBox "Se ha producido un error al procesar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical

    Exit Function
End Function

'/////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////

Sub DibujaBloque(X As Long, _
                 y As Long, _
                 X2 As Long, _
                 Y2 As Long, _
                 Color, _
                 Titulo As String, _
                 avance, _
                 Optional EstaProgramada As String = "NO", _
                 Optional Anulada As String = "NO", _
                 Optional CorrerTituloParaQueNoSeSolape As Boolean = True)
    'On Error Resume Next
    Dim r As Long
    Dim c As Long
    Dim bx1, bx2, by1, by2 'coordenadas en twips
        
    Dim flagYaOcupada As Boolean
        
    With fGrid

        If X >= .Cols Then Exit Sub
        If y >= .Rows Then Exit Sub
            
        If X2 >= .Cols Then X2 = .Cols - 1
        If Y2 >= .Rows Then Y2 = .Rows - 1
            
        '.col = X
        '.Row = y
        bx1 = .CellLeft
        by1 = .CellTop
            
        'flagYaOcupada = False
        'If .CellBackColor = KC_BLANCO Then
        '    flagYaOcupada = True
        'End If
            
        For c = X To X2
            For r = y To Y2

                'If r = y Or r = y2 Or C = x Or C = x2 Then
                '  ColorearCelda fGrid, r, C, KC_NEGRO
                'Else
                'If .RowIsVisible(r - 1) And .RowIsVisible(r + 1) Then
                
                Dim alarma As Boolean
                alarma = ColorearCelda(fGrid, r, c, Color, IIf(r = y, False, True))
                
                'End If
                      
                '.Row = r
                '.col = c
                '.CellForeColor = Color
                
                If IsNumeric(avance) And .TextMatrix(r, c) <> "" Then
                    'si el bloque no se puede mover, y la celda está ocupada, no escribo
                    Debug.Print ""
                Else
                    
                    If .TextMatrix(r, c) = ElBloqueQueAcabaDeMover And ElBloqueQueAcabaDeMover <> "" Then

                        'El bloque que se acaba de mover queda arriba de todo, pero si hay alarma lo coloreo
                        If alarma Then .TextMatrix(r, c) = "!" & ElBloqueQueAcabaDeMover
                    
                    Else

                        If alarma Then
                            .TextMatrix(r, c) = "!" & Titulo
                        Else
                            .TextMatrix(r, c) = Titulo
                        End If
                        
                    End If
                End If

                If r = y Then
                    .CellForeColor = KC_NEGRO 'ahora que hago el MergeCells, no hace falta mimetizar la leyenda de las celdas adyacentes para el renglon superior
                Else
                    '.CellForeColor = .CellBackColor
                End If

            Next
        Next
    
        .Row = y
        .col = X
        '.CellForeColor = KC_NEGRO
    
        If IsNumeric(avance) Then

            For c = X To (X + avance / 24 * COLSxDIA)

                'If .RowIsVisible(r - 1) And .RowIsVisible(r + 1) Then
                ColorearCelda fGrid, y + ROWSxMAQ - 1, c, KC_VERDE, True 'verde
                .Row = y + ROWSxMAQ - 1
                .col = X
                .CellForeColor = KC_VERDE
                    
                .TextMatrix(.Row, .col) = "!" & .TextMatrix(r, c)
                'End If
            Next
           
        End If
        
        '.Row = y
        '.Col = x
        '.CellForeColor = KC_NEGRO '(titulo de la esquina sup izq)
               
        '////////////
        'Para hacer el borde
        'este codigo es el que causa el scroll epileptico
        ' .Col = x
        ' .Row = y
        ' bx1 = .CellLeft
        ' by1 = .CellTop
        '
        ' .Col = x2
        ' .Row = y2
        ' bx2 = .CellLeft + .CellWidth
        ' by2 = .CellTop + .CellHeight
            
        'DrawPicture bx1 + .Left, by1 + .Top, bx2 + .Left, by2 + .Top
        '////////////
        
        'MostrarLabels Titulo, bx1, by1, X, y, X2, Y2
        
    End With

End Sub

Function ColorearCelda(Grid As MSFlexGrid, r As Long, c As Long, Color, bTextoInvisible As Boolean) As Boolean
    'On Error Resume Next
    Dim tempc As Integer
    Dim tempr As Integer

    ColorearCelda = False
        
    With Grid
        tempc = .col
        tempr = .Row
    
        'If Not .RowIsVisible(r - 2) Or Not .RowIsVisible(r + 2) Then Exit Sub
        .Row = r

        If .Cols <= c Then Exit Function
        .col = c
        
        If .CellBackColor = 0 Or .CellBackColor = KC_BLANCO Or .CellBackColor = KC_VERDE Or Color = KC_VERDE Or r >= .Rows - 2 Then 'está en la fila de "sin asignar"
            .CellBackColor = Color
            '.CellForeColor = Color
        Else
            .CellBackColor = KC_ROJO
            '.CellForeColor = KC_ROJO
            lblAlarma.Visible = True
            ColorearCelda = True
        End If
                
        If bTextoInvisible Then .CellForeColor = .CellBackColor
        .col = tempc
        .Row = tempr
    End With

End Function

Sub MostrarLabels(Titulo, _
                  bx1, _
                  by1, _
                  X As Long, _
                  y As Long, _
                  X2 As Long, _
                  Y2 As Long)
    
    Exit Sub
    
    Dim TextBox As TextBox
    Set TextBox = Controls.Add("VB.TextBox", "Control" & Controls.Count)
                
    With TextBox
        .Text = Left(Titulo, InStr(1, Titulo, " "))
        'Debug.Print "BLOQ " & Left(Titulo, InStr(1, Titulo, " ")) & Color
        .FontBold = True
        .BackColor = KC_AMARILLOCLARO    'Color 'kc_blanco
        .BorderStyle = 0
        '.Left = (bx2 - bx1 - 300) / 2 + bx1 + fGrid.Left
        '.Top = by1 + fGrid.Top
                    
        Dim l As Long
        Dim t As Long
        l = fGrid.Left + fGrid.ColWidth(0) + fGrid.ColWidth(1) + fGrid.ColWidth(2) + (X - 3) * fGrid.ColWidth(3) - 2
        t = (Int((y + 1) / 2) * 2 - fGrid.TopRow + 1) * fGrid.CellHeight + fGrid.TOp

        'If False And CorrerTituloParaQueNoSeSolape Then
        'CorreTextBoxXY l, t
                
        .Left = l
        .TOp = t
                    
        'If flagYaOcupada Then
        '    .Top = by1 + fGrid.Top 'sí, está ocupada... pero por cuántos????
        'Else
        'Else
                    
        '.Width = fGrid.CellWidth * 2 + 20 'ancho de la rayita?
        'saco la division entera y vuelvo a multiplicar
        .Width = (Int(TextWidth((Titulo)) / (fGrid.CellWidth + 10)) + 1) * (fGrid.CellWidth + 10)
    
        If .Width < (fGrid.CellWidth + 10) * (X2 - X + 1) And (X2 - X + 1) <= (fGrid.Cols - 2) Then
            .Width = (fGrid.CellWidth + 10) * (X2 - X + 1)
                        
        End If
                        
        .Height = fGrid.CellHeight * 1.5
                
        .Enabled = False
        .Visible = True
        .Appearance = 0
        .ZOrder
    End With

End Sub

Function CorreTextBoxXY(ByRef Left As Long, ByRef TOp As Long)
    'para que no se solapen, esta funcion desplaza los labels
    'On Error Resume Next
    Dim oControl As Control
    Dim oT As TextBox
    
    Exit Function
    
    For Each oControl In Me.Controls

        If TypeOf oControl Is TextBox Then
            Set oT = oControl

            With oT

                If Left >= .Left And Left <= .Left + .Width And TOp >= .TOp And TOp < .TOp + .Height Then
                    'top = .top + .Height
                    TOp = TOp + 100
                    Left = Left + 100
                End If

            End With

        End If

    Next

End Function

Sub MostrarTitulos()
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    Dim c As Long
    Dim r As Long

    With fGrid
            
        If rsMaquinas.RecordCount <= MAXMAQUINAS Then
            .Rows = (rsMaquinas.RecordCount + 1) * ROWSxMAQ + 1
            'lblMaxMaquinas.Visible = False
        Else
            .Rows = (MAXMAQUINAS + 1) * ROWSxMAQ + 1
            'lblMaxMaquinas = "Se muestran sólo las primeras " & MAXMAQUINAS & " máquinas"
            'lblMaxMaquinas.Visible = True
        End If
            
        .Cols = FechaToCol(DTFields(2) + 1) '+ COLSxDIA '+2 por la columna de ID y de MAQ. +1 por el dia siguiente
            
        '/////////////////
        'Anchos de columna
        If .ColWidth(0) < ANCHO_NOMBRE_MAQUINAS_DEFAULT Then .ColWidth(0) = ANCHO_NOMBRE_MAQUINAS_DEFAULT
        .ColWidth(COL_IDMAQ) = 0
    
        For c = 2 To .Cols - 1
            .ColWidth(c) = (.Width - .ColWidth(0)) / (.Cols - 2)
        Next
    
        '////////////////
                    
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        'Nombres de maquinas en las filas
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
            
        If rsMaquinas.RecordCount = 0 Then
            '.Redraw = True
            Exit Sub
        End If
    
        rsMaquinas.MoveFirst
    
        If True Then
            'Merge de celdas en los encabezados?  http://support.microsoft.com/kb/190225/es
                
            .MergeCells = flexMergeFree 'Set the MergeCells property.
            ' Set the rows and columns you want to merge.
            .MergeCol(0) = True 'First Column in grid
            
            'For c = 0 To .Cols - 1
            '    .MergeCol(c) = True
            'Next
            
            For r = 0 To .Rows - 1
                .MergeRow(r) = True
            Next
            
            '.MergeCol(3) = True 'Second Column in grid
    
            '.MergeRow(1) = True 'First Row in Grid
            '.MergeRow(2) = True 'First Row in Grid
            '.MergeRow(3) = True 'First Row in Grid
            '.MergeRow(4) = True 'First Row in Grid
            '.MergeRow(5) = True 'First Row in Grid
            '.MergeRow(6) = True 'First Row in Grid
    
            '.MergeRow(1) = True 'Second Row in Grid
            ' Set the fixed columns and rows.
            '.FixedCols = 1
            '.FixedRows = 1
        End If
            
        For r = 1 To (.Rows - ROWSxMAQ * 1 - 1) Step ROWSxMAQ
                  
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            'Hago entrar el nombre en los 2 renlgones
            Dim tit As String
            tit = rsMaquinas!IdArticuloOrig & "-" & rsMaquinas!descripcion
            Debug.Print TextWidth(tit), .ColWidth(0)
            Dim n As Integer
    
            For n = Len(tit) To 1 Step -1
    
                If TextWidth(Left(tit, n)) < .ColWidth(0) Then Exit For
            Next
    
            If False Then
                .TextMatrix(r, 0) = Left(tit, n)
                .TextMatrix(r + 1, 0) = mId(tit, n + 1)
            Else
                .TextMatrix(r, 0) = tit
                .TextMatrix(r + 1, 0) = tit
                '.TextMatrix(r + 1, 0) = ""
            End If
                
            'agrandar el ancho para que entre el nombre?
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
                  
            .TextMatrix(r, COL_IDMAQ) = rsMaquinas!IdArticuloOrig
            .TextMatrix(r + 1, COL_IDMAQ) = rsMaquinas!IdArticuloOrig
            '.TextMatrix(r + 2, COL_IDMAQ) = rsMaquinas!IdArticuloOrig
                  
            'ver si esta fuera de servicio
            With rsMaquinas
    
                If !FueraDeServicio = "SI" Then
                    If !FueraDeServicioRetornoEstimado >= DTFields(1) Then
                        DibujaBloque FechaToCol(!FueraDeServicioFechaInicio), r, FechaToCol(!FueraDeServicioRetornoEstimado), r + ROWSxMAQ - 1, KC_GRIS, !FueraDeServicioConcepto & " ", Null, "SI", "NO"
                    End If
                End If
    
            End With
                                  
            rsMaquinas.MoveNext
        Next
    
        .TextMatrix(r, 0) = "SIN ASIGNAR"
        .TextMatrix(r + 1, 0) = "SIN ASIGNAR"
        .TextMatrix(r, COL_IDMAQ) = -1
        .TextMatrix(r + 1, COL_IDMAQ) = -1
            
        If OptPeriodo(2) Then
            .TextMatrix(0, 0) = "MAQ\HORAS"
        Else
            .TextMatrix(0, 0) = "MAQ\DIAS"
        End If
            
        '////////////////
        '////////////////
        .ColAlignment(0) = flexAlignRightCenter
            
        'Nombres de los dias u horas en las columnas
            
        If COLSxDIA <= 1 Then
    
            'en dias de la semana
            For c = 2 To .Cols - 1 Step COLSxDIA
                .TextMatrix(0, c) = DatePart("d", DTFields(1) + (c - 2) / COLSxDIA)
            Next
    
        Else
                
            'en horas
            For c = 2 To .Cols - 1 Step .Cols / 18 'para que no muestre la hora en todas las columnas
                .TextMatrix(0, c) = DatePart("h", DateAdd("h", (c - 2) * 24 / COLSxDIA, DTFields(1))) '& "00"
            Next
    
        End If
        
        'rs.Filter = "FechaFinal>='" & Fecha & "' AND FechaInicio<='" & (Fecha + 1) & "'"
            
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
    End With

End Sub

'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////

Sub EraseAllPictures()
    Exit Sub
    
    On Error Resume Next
    Dim oControl As Control

    For Each oControl In Me.Controls

        If TypeOf oControl Is PictureBox Or TypeOf oControl Is TextBox Then
            Me.Controls.Remove oControl.Name
        End If

    Next

End Sub

Private Sub ClearSelectedRows()
    'http://www.xtremevbtalk.com/showthread.php?postid=282585
  
    Dim lCol As Long, lRow As Long
    Dim lColSel As Long, lRowSel As Long
    Dim lFillStyle As Long
  
    'If m_cSelectedRows.Count = 0 Then
    ' no previous selected rows
    ' Exit Sub
    'End If
  
    With fGrid
        .Redraw = False
    
        ' store the original settings
        lCol = .col
        lRow = .Row
        lColSel = .ColSel
        lRowSel = .RowSel
        lFillStyle = .FillStyle
    
        ' clear the selection
        .FillStyle = flexFillRepeat
        .col = .FixedCols
        .Row = .FixedRows
        .ColSel = .Cols - 1
        .RowSel = .Rows - 1
        .CellBackColor = .BackColor
        .CellForeColor = .ForeColor
    
        ' restore the settings
        .col = lCol
        .Row = lRow
        .ColSel = lColSel
        .RowSel = lRowSel
        .FillStyle = lFillStyle
    
        .Redraw = True
        .Refresh
    End With
  
    ' clear our collection
    'Do While m_cSelectedRows.Count > 0
    '  m_cSelectedRows.Remove 1
    'Loop
End Sub
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////

Private Sub fGrid_MouseDown(Button As Integer, _
                            Shift As Integer, _
                            X As Single, _
                            y As Single)
    'On Error Resume Next
    On Error GoTo Mal3
    
    If mvarId <> -1 Then Exit Sub

    With fGrid

        If .TextMatrix(.MouseRow, .MouseCol) <> "" Then
            DragOPProcDet = mId(.TextMatrix(.MouseRow, .MouseCol), InStrRev(.TextMatrix(.MouseRow, .MouseCol), " "))
            rsDirecto.Filter = ""
            rsDirecto.Find "idDetalleProduccionOrdenProceso=" & DragOPProcDet
            
            Dim temp As Date
            Dim dif As Long
            Dim inicio As Date
            Dim final As Date
            
            temp = DTFields(1) + (.MouseCol / COLSxDIA)
            dif = iisNull(rsDirecto!fechafinal, rsDirecto!FechaFinalPrevista) - iisNull(rsDirecto!FechaInicio, rsDirecto!FechaInicioPrevista) + 1
            
            inicio = iisNull(rsDirecto!FechaInicio, rsDirecto!FechaInicioPrevista)
            final = iisNull(rsDirecto!fechafinal, rsDirecto!FechaFinalPrevista)
            final = IIf(final > DTFields(2), DTFields(2), final)
                        
            Debug.Print "MouseDown", "DragOPProcDet " & DragOPProcDet, .MouseRow, .MouseCol, dif, vbCrLf
            'Debug.Print temp, iisNull(rsDirecto!FechaInicio, rsDirecto!FechaInicioPrevista) + dif
            'Debug.Print .MouseCol, FechaToCol(final)
            
            ultimaPosYdondeSeApreto = .MouseRow
            
            .Row = .MouseRow
            .col = .MouseCol
            
            If rsDirecto!PartesAsociados > 0 Then
                Me.MousePointer = vbDefault
                txtCajaDesplazada.Visible = False
                Me.MousePointer = vbNoDrop
            ElseIf .MouseCol = FechaToCol(inicio) And X < .CellLeft + (.CellWidth / 3) Then
                DragModo = K_BORDEIZQ
                Me.MousePointer = vbSizeWE
                txtCajaDesplazada.Visible = True
            ElseIf .MouseCol = FechaToCol(final) And X > .CellLeft + 2 * (.CellWidth / 3) Then
                DragModo = K_BORDEDER
                Me.MousePointer = vbSizeWE
                txtCajaDesplazada.Visible = True
            ElseIf .MouseCol >= FechaToCol(inicio) And .MouseCol <= FechaToCol(final) Then
                DragModo = K_MOVER
                Me.MousePointer = vbSizePointer
                txtCajaDesplazada.Visible = True
            Else
                Me.MousePointer = vbDefault
                txtCajaDesplazada.Visible = False
            End If

        Else
            Me.MousePointer = vbDefault
            txtCajaDesplazada.Visible = False
        End If

    End With

    Exit Sub

Mal3:
    Me.MousePointer = vbDefault
    MsgBox "Se ha producido un error" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical

End Sub

Private Sub fGrid_MouseMove(Button As Integer, _
                            Shift As Integer, _
                            X As Single, _
                            y As Single)
    On Error Resume Next
    'On Error GoTo Mal2
   
    If mvarId <> -1 Then Exit Sub
   
    Dim temp As Date
    Dim dif As Long
    Dim inicio As Date
    Dim final As Date
   
    Static r As Long
   
    If Button = vbLeftButton Then

        '////////////////////////////////
        '////////////////////////////////
        'DRAG. esta moviendo el mouse mientras apreta el boton izquierdo.
        '////////////////////////////////
        '////////////////////////////////
        With fGrid
            .Row = .MouseRow
            .col = .MouseCol
            
            If .MouseCol > 0 Then 'no dejar que pise la primer columna
                
                Dim IdActual
                Dim CellText As String
                CellText = .TextMatrix(.MouseRow, .MouseCol)

                If CellText <> "" Then
                    Dim i
                    i = InStrRev(CellText, " ")

                    If i > 0 Then
                        IdActual = mId(CellText, i)
                    Else
                        IdActual = 0
                    End If

                Else
                    IdActual = 0
                End If
                
                If rsDirecto.Filter <> "idDetalleProduccionOrdenProceso=" & DragOPProcDet Then
                    rsDirecto.Filter = ""
                    rsDirecto.Find "idDetalleProduccionOrdenProceso=" & DragOPProcDet
                End If
    
                If rsDirecto.EOF Then Exit Sub
                
                If rsDirecto!Anulada = "SI" Then
                    Debug.Print "MouseMove", "Abortado por Anulada"
                    Exit Sub
                End If

                'If rsDirecto!Programable <> "SI" Then Exit Sub
                If rsDirecto!PartesAsociados > 0 Then
                    Debug.Print "MouseMove", "Abortado por partes asociados"
                    Exit Sub
                End If

                Debug.Print "MouseMove", "DragOPProcDet " & DragOPProcDet, .MouseRow, .MouseCol, vbCrLf
                
                'acá hay quilombo.
                ' cómo sé si un proceso se puede mover, si estoy pisando dinamicamente esos datos?
                
                'Debug.Print .MouseCol
                temp = ColToFecha(.MouseCol)
                        
                dif = iisNull(rsDirecto!fechafinal, rsDirecto!FechaFinalPrevista) - iisNull(rsDirecto!FechaInicio, rsDirecto!FechaInicioPrevista) + 1
                
                inicio = iisNull(rsDirecto!FechaInicio, rsDirecto!FechaInicioPrevista)
                final = iisNull(rsDirecto!fechafinal, rsDirecto!FechaFinalPrevista)
                final = IIf(final > DTFields(2), DTFields(2), final)
                    
                Debug.Print X, .CellLeft + (.CellWidth / 3), .MouseRow, .MouseCol, temp
                    
                Select Case DragModo

                    Case K_BORDEIZQ

                        If rsDirecto!FechaInicio = 0 Or temp <= rsDirecto!fechafinal Then
                            rsDirecto!FechaInicio = temp
                            rsDirecto.Update
                        End If

                    Case K_BORDEDER
                        
                        If temp >= rsDirecto!FechaInicio Then
                            rsDirecto!fechafinal = temp
                            rsDirecto.Update
                        End If

                    Case K_MOVER

                        If IsNumeric(.TextMatrix(.MouseRow, COL_IDMAQ)) Then
                            rsDirecto!IdMaquina = .TextMatrix(.MouseRow, COL_IDMAQ)
                        End If

                        rsDirecto!fechafinal = final - inicio + temp
                        rsDirecto!FechaInicio = temp
                        rsDirecto.Update
                        
                End Select

                'LlenarGrilla
                
                '////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////
                Dim X2 As Long
                Dim Y2 As Long
                Dim l As Long
                Dim t As Long
                Dim bx1, bx2, by1, by2 'coordenadas en twips

                'If X >= .Cols Then Exit Sub
                'If Y >= .Rows Then Exit Sub
                'If X2 >= .Cols Then X2 = .Cols - 1
                'If Y2 >= .Rows Then Y2 = .Rows - 1
                bx1 = .CellLeft
                by1 = .CellTop
                l = bx1 + fGrid.Left
                t = by1 + fGrid.TOp
                '.Left = l
                '.TOp = t
                X = FechaToCol(iisNull(rsDirecto!FechaInicio, rsDirecto!FechaInicioPrevista))
                X2 = FechaToCol(iisNull(rsDirecto!fechafinal, rsDirecto!FechaFinalPrevista))
                
                If X2 >= X Then
                    If DragModo = K_BORDEDER Or DragModo = K_BORDEIZQ Then
                        'si está cambiando el tamaño, el .top es fijo
                        txtCajaDesplazada.TOp = fGrid.TOp + 10 + (Int((ultimaPosYdondeSeApreto + 1) / 2) * 2 - fGrid.TopRow) * fGrid.RowHeight(3)
                    ElseIf DragModo = K_MOVER Then
                        'está moviendo con el puntero cruz, puede hacer lo que quiera
                        txtCajaDesplazada.TOp = fGrid.TOp + 10 + (Int((fGrid.Row + 1) / 2) * 2 - fGrid.TopRow) * fGrid.RowHeight(3)
                        
                    End If
                    
                    txtCajaDesplazada.Left = 2 + fGrid.Left + fGrid.ColWidth(0) + fGrid.ColWidth(1) + fGrid.ColWidth(2) + (X - 3) * fGrid.ColWidth(3) - 2
                
                    txtCajaDesplazada.Height = fGrid.CellHeight * 2
                    txtCajaDesplazada.Width = (fGrid.ColWidth(3) + 3) * (X2 - X + 1) - 4
                End If
                
                ElBloqueQueAcabaDeMover = rsDirecto!NumeroOrdenProduccion & "-" & rsDirecto!descripcion & " " & rsDirecto!IdDetalleProduccionOrdenProceso
                
                fGrid.ZOrder 1
                txtCajaDesplazada.ZOrder 0
                                
                '////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////
                
            End If

        End With

    ElseIf Button = 0 Then

        '////////////////////////////////
        '////////////////////////////////
        'NO DRAG. esta moviendo el mouse sin apretar el boton. No creo
        'que sea la primera vez que lo suelta despues de un drag, supongo
        'que pasará antes por MouseUp -Si pasa por mouseUp, ya pone la variable DragOPProcDet en
        ' -1, así que...
        '////////////////////////////////
        '////////////////////////////////
        With fGrid
            Dim cell

            If .MouseRow <= .Rows Then cell = .TextMatrix(.MouseRow, .MouseCol)

            If cell <> "" And .MouseRow > 0 Then 'el puntero está pasando (sin apretar el bton) por un bloque que se puede mover
            
                '/////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////
                'tomo los datos del bloque por donde está pasando el puntero
                '/////////////////////////////////////////////////////////////////////
                
                .Row = .MouseRow 'guachín, si comentas esto, cuando pases por encima de un bloque que quieras arrastrar, se te va a resetear el scroll
                .col = .MouseCol 'guachín, si comentas esto, cuando pases por encima de un bloque que quieras arrastrar, se te va a resetear el scroll
                        
                If InStrRev(cell, " ") > 0 Then
                    DragOPProcDet = Val(mId(cell, InStrRev(cell, " ")))
                Else
                    DragOPProcDet = 0
                End If
                
                If rsDirecto.Filter <> "idDetalleProduccionOrdenProceso=" & DragOPProcDet Then
                    rsDirecto.Filter = ""
                    rsDirecto.Find "idDetalleProduccionOrdenProceso=" & DragOPProcDet
                End If
                
                If rsDirecto.EOF Then
                    Me.MousePointer = vbDefault
                    Exit Sub
                End If
            
                temp = ColToFecha(.MouseCol)
                dif = iisNull(rsDirecto!fechafinal, rsDirecto!FechaFinalPrevista) - iisNull(rsDirecto!FechaInicio, rsDirecto!FechaInicioPrevista) + 1
                        
                inicio = iisNull(rsDirecto!FechaInicio, rsDirecto!FechaInicioPrevista)
                final = iisNull(rsDirecto!fechafinal, rsDirecto!FechaFinalPrevista)
                final = IIf(final > DTFields(2), DTFields(2), final)

                '/////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////
            
                'Debug.Print X, .CellLeft + (.CellWidth / 3), .MouseRow, .MouseCol
            
                'Debug.Print temp, iisNull(rsDirecto!FechaInicio, rsDirecto!FechaInicioPrevista) + dif
                'Debug.Print .MouseCol, (inicio - DTFields(1)) * COLSxDIA + 2, (final - DTFields(1)) * COLSxDIA + 3 + 1

                'lo del 2* y el /3 es para tomar el ultimo tercio de la celda como
                'lugar a partir del cual podes modificar el ancho
                '/////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////
                'Muestro el cursor correspondiente
                'Exit Sub
                
                Dim ci As Long
                Dim cf As Long
                ci = FechaToCol(inicio)
                cf = FechaToCol(final)
                                
                Dim bordeIzq
                Dim bordeDer
                bordeIzq = .CellLeft + (.CellWidth / 3)
                bordeDer = .CellLeft + 2 * (.CellWidth / 3)
                
                If rsDirecto!PartesAsociados > 0 Then
                    Me.MousePointer = vbNoDrop
                ElseIf .MouseCol = ci And X < bordeIzq Then
                    Me.MousePointer = vbSizeWE 'cursor <->
                ElseIf .MouseCol = cf And X > bordeDer Then
                    Me.MousePointer = vbSizeWE 'cursor <->
                ElseIf .MouseCol >= FechaToCol(inicio) And .MouseCol <= FechaToCol(final) Then
                    Me.MousePointer = vbSizePointer 'cursor +
                Else
                    Me.MousePointer = vbDefault
                End If
        
                '/////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////
        
            Else
            
                Me.MousePointer = vbDefault
            End If

        End With

    End If

    Exit Sub

Mal2:
    Me.MousePointer = vbDefault
    MsgBox "Se ha producido un error" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical

End Sub

Private Sub fGrid_MouseUp(Button As Integer, _
                          Shift As Integer, _
                          X As Single, _
                          y As Single)
    'posicionarse en la celda de la grilla?

    If mvarId <> -1 Then Exit Sub

    Me.MousePointer = vbDefault
   
    With fGrid
   
        If Button = vbLeftButton Then
         
            Debug.Print "MouseUp", "DragOPProcDet " & DragOPProcDet, .MouseRow, .MouseCol, vbCrLf
         
            With fGrid
                DragOPProcDet = -1
                DragModo = -1
                txtCajaDesplazada.Visible = False
                
                Dim temptop
                temptop = .TopRow
                'If Not bFuncionLlenarGrillaEjecutandose Then
                LlenarGrilla
                '.TopRow = temptop
                'fGrid.ZOrder 1
            End With

        ElseIf Button = vbRightButton Then 'Hago una copia del bloque sobre el que esta parado
             
            'que al apretar el boton izquierdo aparezca un menupopup con la opcion de copiar y eliminar (y no que copie automaticamente como hace ahora)
         
            MnuDetA(0).Enabled = True
            MnuDetA(1).Enabled = True
            PopupMenu MnuDet, , , , MnuDetA(0)
         
            'Codigo para menu popup
            '             If .MouseRow < .Rows And .MouseCol < .Cols Then
            '                 .row = .MouseRow
            '                 .col = .MouseCol
            '             End If
            '
            '             If .row < 2 Then
            '                 MnuDetA(0).Enabled = False
            '             Else
            '                 MnuDetA(0).Enabled = True
            '             End If
            '
            '             PopupMenu MnuDet, , , , MnuDetA(0)
        End If
   
    End With
   
End Sub

Private Sub fGrid_Scroll()
    'para qué llamas a LlenarGrilla en el scroll????? no tiene sentido! si ya está todo pintado!
    '-los labels no....
    'MostrarLabels
    'If Not bFuncionLlenarGrillaEjecutandose Then LlenarGrilla
End Sub

'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////

Private Sub List1_Click()
    LlenarGrilla

    If fGrid.Rows > 12 Then
        fGrid.TopRow = fGrid.Rows - 10
    End If

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
            'ElseIf .col = COL_OPPREVISTA Or .col = COL_PEDIDOSPREVISTOS Or .col = COL_FECHA Or .col = COL_CANTIDAD Then
            '    MSHFlexGridEdit fGrid, txtEdit, KeyAscii
        End If

    End With

End Sub

Sub fGrid_DblClick()
    'Muestro la OP del proceso sobre el que se hizo doble click
    Dim s As String
    
    With fGrid
        s = .TextMatrix(.MouseRow, .MouseCol)
        
        If s <> "" Then
                
            Dim oF As frmProduccionOrden
            Set oF = New frmProduccionOrden

            With oF
                .NivelAcceso = frmPrincipal.ControlAccesoNivel("OrdendeProduccion")
                .OpcionesAcceso = frmPrincipal.ControlAccesoOpciones("OrdendeProduccion")

                Dim IdTemp As String
                IdTemp = Right(s, Len(s) - InStrRev(s, " "))

                If IsNumeric(IdTemp) Then
                    rsDirecto.Filter = "idDetalleProduccionOrdenProceso=" & IdTemp
                    .Id = rsDirecto!IdProduccionOrden
                    rsDirecto.Filter = ""
                        
                    'Muestro la OP del proceso sobre el que se hizo doble click
                    .Disparar = ActL
                    ReemplazarEtiquetas oF
                    Me.MousePointer = vbDefault
                    .Show , Me

                End If
                   
            End With

        End If

    End With
    
End Sub

Private Sub Form_MouseMove(Button As Integer, _
                           Shift As Integer, _
                           X As Single, _
                           y As Single)
    
    With fGrid
        
        If (X < .Left Or X > .Left + .Width) Or (y < .TOp Or y > .TOp + .Height) Then
            Me.MousePointer = vbDefault
        End If

    End With
    
End Sub

Sub MSHFlexGridEdit(MSHFlexGrid As Control, _
                    Edt As Control, _
                    KeyAscii As Integer)

    '////////////////////////////////////////////////////////////////////////////////////
    'http://msdn.microsoft.com/en-us/library/aa230201(VS.60).aspx
    'Editing Cells in a Hierarchical FlexGrid Spreadsheet
    '////////////////////////////////////////////////////////////////////////////////////
    
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
        Edt.Move .Left + ScaleX(.CellLeft, vbTwips, .Container.ScaleMode), .TOp + ScaleY(.CellTop, vbTwips, .Container.ScaleMode), ScaleX(.CellWidth - 8, vbTwips, .Container.ScaleMode), ScaleY(.CellHeight - 8, vbTwips, .Container.ScaleMode)
    End With

    Edt.Visible = True

    ' And make it work.
   
    Edt.SetFocus
End Sub

Function Fgi(r As Integer, c As Integer) As Integer
    Fgi = c + fGrid.Cols * r
End Function

Private Sub OptPeriodo_Click(Index As Integer)
    RecalculaFecha
    Command1_Click
    'o        Al cambiar el período de análisis de semana a mes,  en el mes no se ve el nombre del Proceso.
    'Stop
End Sub

Sub txtEdit_KeyPress(KeyAscii As Integer)

    ' Delete returns to get rid of beep.
    If KeyAscii = Asc(vbCr) Then KeyAscii = 0
End Sub

Sub EditKeyCode(MSHFlexGrid As Control, _
                Edt As Control, _
                KeyCode As Integer, _
                Shift As Integer)

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

'/////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////

'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Public Property Let Id(ByVal vNewValue As Long)
    'Dim rs As ADOR.Recordset
    'Set rs = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorIdTipoParaCombo", 3)
    'Set dcfields(11).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_ProduciblesParaCombo", Array(0))
    'Set dcfields(0).RowSource = Aplicacion.Articulos.TraerLista  '.TraerFiltrado("Articulos", "_ParaCombo")
    'Set oAp = Nothing

    Set DataCombo1(1).RowSource = Aplicacion.TablasGenerales.TraerLista("ProduccionAreas")
    Set DataCombo1(0).RowSource = Aplicacion.TablasGenerales.TraerLista("ProduccionSectores")
    Set DataCombo1(2).RowSource = Aplicacion.TablasGenerales.TraerLista("ProduccionProcesos")
    Set DataCombo1(4).RowSource = Aplicacion.TablasGenerales.TraerLista("ProduccionLineas")
    'Set DataCombo1(3).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorIdTipoParaCombo", 3)
    
    Set DataCombo1(3).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorDescripcionTipoParaCombo", Array(0, "Equipo"))
    Set rsMaquinas = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorDescripcionTipoParaCombo", Array(0, "Equipo"))
    
    DTFields(0) = Date
    
    'sacarle los minutos y segundos
    
    'DTFields(1) = DatePart( Add("h", 6, DateValue(DTFields(1)))  'hago que empiece a las 6 de la mañana
    DTFields(1) = Date
    
    COLSxDIA = txtFrac

    Dim oAp As ComPronto.Aplicacion
    Dim oControl As Control
   
    mvarId = vNewValue
   
    Set oAp = AplicacionProd
    Set origen = oAp.ProgRecursos.Item(vNewValue)
    Set oBind = New BindingCollection
   
    With oBind
      
        Set .DataSource = origen
      
        For Each oControl In Me.Controls

            If TypeOf oControl Is CommandButton Then
   
            ElseIf TypeOf oControl Is DbListView Then
            ElseIf TypeOf oControl Is Label Then

                If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
            ElseIf TypeOf oControl Is RichTextBox Then

                If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
     
            Else
                On Error Resume Next
                Set oControl.DataSource = origen
            End If

        Next
   
    End With
   
    With origen.Registro
    
        'If IsNull(.Fields("Obligatorio").Value) Or .Fields("Obligatorio").Value = "SI" Then
        '   chkObligatorio.Value = 1
        'Else
        '   chkObligatorio.Value = 0
        'End If
    
    End With
  
    Set DataCombo1(0).RowSource = Aplicacion.TablasGenerales.TraerLista("ProduccionSectores")
   
    Cmd(1).Enabled = True
    Cmd(0).Enabled = True

    If Me.NivelAcceso <= Medio Then
        If mvarId <= 0 Then
            Cmd(0).Enabled = True
        ElseIf mvarId > 0 Then
            Cmd(0).Enabled = True
            Cmd(3).Enabled = True
        End If

    ElseIf Me.NivelAcceso = Alto Then
        Cmd(0).Enabled = True
        Cmd(3).Enabled = True
    End If
   
    If vNewValue <> -1 Then
        Cmd(1).Enabled = False
        Cmd(0).Enabled = False

        For Each oControl In Me.Controls
            oControl.Enabled = False
        Next

        fGrid.Enabled = True
        
        Cmd(2).Enabled = True
        cmdEXCEL.Enabled = True
   
        txtFrac = origen.Registro!Fraccionado
        
        DTFields(1) = origen.Registro!FechaInicio
        DTFields(2) = origen.Registro!fechafinal
    Else
        DTFields(1).MinDate = Date
        DTFields(2).MinDate = Date
   
        RecalculaFecha
   
    End If
   
    'ConfiguraGrilla (True)
    Command1_Click
    'LlenarGrilla rs
    'Set rs = Nothing
   
    Set oAp = Nothing

End Property

Public Sub cmd_Click(Index As Integer)
    On Error GoTo Mal
    Dim est As EnumAcciones

    Select Case Index
   
        Case 0, 1
        
            If rsDirecto.RecordCount = 0 Then
                MsgBox "No hay programacion para grabar"
                Exit Sub
            End If
            
            If lblAlarma.Visible = True Then
                Dim mvarResp2
                mvarResp2 = MsgBox("Hay conflictos en la programación. Desea continuar?", vbYesNo + vbCritical)

                If mvarResp2 = vbNo Then Exit Sub
            End If
            
            Me.MousePointer = vbHourglass
   
            With rsDirecto
                .Filter = ""
                .MoveFirst

                Do While Not rsDirecto.EOF
                
                    If iisNull(!IdMaquina, 0) > 0 Then
                        Aplicacion.Tarea "DetProduccionOrdenesProcesos_M", Array(!IdDetalleProduccionOrdenProceso, !IdProduccionOrden, !IdProduccionProceso, iisNull(!Horas, 0), iisNull(!FechaInicio, !FechaInicioPrevista), iisNull(!fechafinal, !FechaFinalPrevista), iisNull(!HorasReales, 0), !IdMaquina, "", iisNull(!Orden, -1), iisNull(!IdProduccionParteQueCerroEsteProceso, -1))
        
                        Dim Orden As ComPronto.ProduccionOrden
                        Set Orden = AplicacionProd.ProduccionOrdenes.Item(!IdProduccionOrden)

                        If !FechaInicio < Orden.Registro!FechaInicioPrevista Then Orden.Registro!FechaInicioPrevista = !FechaInicio
                        If !fechafinal > Orden.Registro!FechaFinalPrevista Then Orden.Registro!FechaFinalPrevista = !fechafinal
                        Orden.Registro!Programada = "SI"
                        Orden.Guardar
    
                    End If

                    rsDirecto.MoveNext
                Loop

            End With
            
            origen.Registro!Fecha = Date
            origen.Registro!FechaInicio = DTFields(1)
            origen.Registro!fechafinal = DTFields(2)
            origen.Registro!Fraccionado = txtFrac

            GuardoRecordsetSerializado
        
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
                .ListaEditada = "ProgRecursos"
                .AccionRegistro = est
                .Disparador = mvarId
            End With
            
            Me.MousePointer = vbDefault
   
        Case 2
            Unload Me
    End Select
   
    If Index = 1 Then Unload Me
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

Private Sub Command1_Click()
    'Filtro por Area. No está funcionando bien, por el Area Administración muestra máquinas no asignadas al sector
    
    If mvarId = -1 Then
        Set rsDirecto = Aplicacion.TablasGenerales.TraerFiltrado("DetProduccionOrdenesProcesos", "_PorFechaParaProgramadorDeRecursos", Array(DTFields(1), DTFields(2), iisEmpty(DataCombo1(DCFILTRO_AREA).BoundText, -1), iisEmpty(DataCombo1(DCFILTRO_SECTOR).BoundText, -1), iisEmpty(DataCombo1(DCFILTRO_LINEA).BoundText, -1), iisEmpty(DataCombo1(DCFILTRO_PROCESO).BoundText, -1), iisEmpty(DataCombo1(DCFILTRO_MAQUINA).BoundText, -1)))
    Else
        CargoRecordsetSerializado
    End If
   
    '         Las OP sólo entran en este plan cuando están en estado “Abierta”, ahora entran al plan sólo con estar en estado “Nueva”.

    Set rsMaquinas = Aplicacion.TablasGenerales.TraerFiltrado("Maquinas", "_PorAreaSectorLineaProcesoMaquina", Array(iisEmpty(DataCombo1(1).BoundText, -1), iisEmpty(DataCombo1(0).BoundText, -1), iisEmpty(DataCombo1(4).BoundText, -1), iisEmpty(DataCombo1(2).BoundText, -1), iisEmpty(DataCombo1(3).BoundText, -1)))
   
    Dim rs As ADOR.Recordset
    Set rs = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorDescripcionTipoParaCombo", Array(0, "Equipo"))
   
    fGrid.Clear
    MostrarTitulos
   
    LlenarGrilla rs
    RellenaListaDeProcesosSinAsignar
    Set rs = Nothing
End Sub

'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
Private Sub DTFields_Change(Index As Integer)
    
    Dim tope As Date
    tope = DateAdd("d", -1, DTFields(2))

    If DTFields(1) > tope Then DTFields(1) = tope
             
    'If OptPeriodo(2) Then
    'un día
        
    '       DTFields(1) = DateAdd("h", DatePart("h", Time), DateValue(DTFields(1)))
        
    '      DTFields(2) = DateAdd("d", 1, DTFields(1))
        
    '          End If
        
    Command1_Click
End Sub

Sub RecalculaFecha()

    If OptPeriodo(0) Then
        'quincena
        DTFields(2) = DateAdd("d", 15, DTFields(1))
        txtFrac = 1
    ElseIf OptPeriodo(1) Then
        'mes
        DTFields(2) = DateAdd("m", 1, DTFields(1))
        txtFrac = 1
    ElseIf OptPeriodo(2) Then
        'un día
        
        DTFields(1) = DateAdd("h", DatePart("h", Time), DateValue(DTFields(1)))
        
        DTFields(2) = DateAdd("d", 1, DTFields(1))
        txtFrac = 24
    End If

End Sub

Private Sub txtFrac_Change()
    COLSxDIA = txtFrac
End Sub

'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////

Function FechaToCol(ByRef Fecha As Date) As Long

    If Fecha < DTFields(1) Then
        Fecha = DTFields(1)
    ElseIf Fecha > DTFields(2) Then
        Fecha = DTFields(2)
    End If
    
    'to do: arreglar este truquito
    If COLSxDIA = 24 Then
        'mostrando por horas
        'FechaToCol = Round((Fecha - DTFields(1)) * COLSxDIA + 2)
        FechaToCol = DateDiff("h", DTFields(1), Fecha) + 2
        'FechaToCol = Int((Fecha - DTFields(1)) * COLSxDIA + 2)
    Else
        'mostrando por dias. Si es en modo diario me conviene redondear, no usar directo el int() -por?
        FechaToCol = Round((Fecha - DTFields(1)) * COLSxDIA + 2)
    End If

End Function

Function ColToFecha(col As Long) As Date
    ColToFecha = (col - 2) / COLSxDIA + DTFields(1)
End Function

'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////

Private Sub cmdEXCEL_Click()
    Exportar_Excel "", fGrid
End Sub

Public Function Exportar_Excel(Path_Libro As String, _
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
                
                ' Recorremos el FlexGrid por filas y columnas
                For Fila = 1 To FlexGrid.Rows - 1 Step 2
                    For Columna = 0 To FlexGrid.Cols - 1
                        
                        If Columna = 0 Then
                            'nombre de maquina
                            .Cells(Int(Fila / 2) + 2, Columna + 1).Value = FlexGrid.TextMatrix(Fila - 1, Columna)
                        ElseIf Fila = 1 Then
                            'fila de fechas
                            Dim hora As Date
                            hora = DatePart("h", ColToFecha(CLng(Columna)))
                            
                            If COLSxDIA = 24 Then
                                .Cells(2, Columna + 1).Value = ColToFecha(CLng(Columna))
                                .Cells(2, Columna + 1).NumberFormat = "h:mm"
                            End If
                            
                            If Columna = 1 Or (hora Mod 24 = 0) Or COLSxDIA <> 24 Then
                                'si es la primera columna de hora, o es las 12am o 12pm, muestro formato con dia
                                .Cells(1, Columna + 1).Value = ColToFecha(CLng(Columna))
                                .Cells(1, Columna + 1).NumberFormat = "ddd d/m "   ' & Chr(10) & " h:mm"
                            Else
                                .Cells(1, Columna + 1).Value = "."
                            End If
                            
                        ElseIf Columna > 3 Then

                            ' Agrega el Valor en la celda indicada  del Excel
                            If InStr(1, FlexGrid.TextMatrix(Fila - 1, Columna), " ") <> 0 Then
                                .Cells(Int(Fila / 2) + 2, Columna - 1).Value = Left(FlexGrid.TextMatrix(Fila - 1, Columna), InStr(1, FlexGrid.TextMatrix(Fila - 1, Columna), " "))
                                        
                            Else
                                .Cells(Int(Fila / 2) + 2, Columna - 1).Value = FlexGrid.TextMatrix(Fila - 1, Columna)
                        
                            End If
                            
                        End If

                    Next Columna
        
                Next Fila
            
                .Cells(1, 1).Value = "Máquinas \ Días"
                .Cells(2, 1).Value = "" ' "Máquinas \Horas"
                '.Cells(1, 2).Value = "."
            
                .Range("B1").Select
                oEx.Run "ArmarFormato"
      
                .Columns("A").ColumnWidth = 30
                '.Rows("A").WrapText = True
                .Columns("A").WrapText = True
                .Columns("B:AZ").ColumnWidth = 12
                .Rows("1:200").RowHeight = 40
                
                .Rows("1:1").Select
                oEx.Selection.Insert Shift:=xlDown
                
                'For Columna = 0 To FlexGrid.Cols - 1
                '        If Columna = 1 Or (hora Mod 24 = 0) Then
                '            'si es la primera columna de hora, o es las 12am o 12pm, muestro formato con dia
                '            .Cells(2, Columna + 1).Value = ColToFecha(CLng(Columna))
                '            .Cells(2, Columna + 1).NumberFormat = "ddd d/m "   ' & Chr(10) & " h:mm"
                '        End If
                'Next Columna

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

Sub GuardoRecordsetSerializado()
    'http://www.2enetworx.com/dev/articles/caching2.asp
    'On Error Resume Next
    Dim s As String
    Dim fso As New FileSystemObject
    Dim txtfile As TextStream
    
    Dim Filename As String
    Filename = GetTempFileName '"RsSerial.txt"
    
    '/////////////////////////////////
    'rs-->archivo
    '/////////////////////////////////
    
    If FileExists(Filename) Then Kill Filename
    'fso.DeleteFile (fileName)
    
    rsDirecto.Save Filename, adPersistXML
    '/////////////////////////////////
    
    '/////////////////////////////////
    'arhivo-->string
    '/////////////////////////////////
    
    Set txtfile = fso.OpenTextFile(Filename)         ' (App.Path & "\" & txtSecuencia & ".txt", True)
    s = txtfile.ReadAll
    
    'Do While Not txtfile.AtEndOfStream
    '    s = s & txtfile.ReadLine & vbCrLf
    'Loop
    
    txtfile.Close
    '/////////////////////////////////
    
    '/////////////////////////////////
    'string-->registro
    '/////////////////////////////////
    origen.Registro!GrillaSerializada = s 'acá está el problema... ya cambié de varchar a varbinary y sigue igual...
    '/////////////////////////////////
    '/////////////////////////////////
    
    '/////////////////////////////////
    'pruebas
    '/////////////////////////////////
    '    Set rsDirecto = Nothing
    '    Set rsDirecto = New ador.Recordset
    '
    '    Set txtfile = fso.CreateTextFile("prueba.txt", True)      ' (App.Path & "\" & txtSecuencia & ".txt", True)
    '    txtfile.Write s 'origen.Registro!GrillaSerializada
    '    txtfile.Close
    '
    '    Set txtfile = fso.CreateTextFile("prueba2.txt", True)      ' (App.Path & "\" & txtSecuencia & ".txt", True)
    '    txtfile.Write origen.Registro!GrillaSerializada
    '    txtfile.Close
    '
    '    'set rsdirecto=
    '    rsDirecto.Open "RsSerial.txt" 'para probar si funciona
    '    rsDirecto.Open "prueba.txt" 'para probar si funciona
    '    rsDirecto.Open "prueba2.txt" 'para probar si funciona
    '/////////////////////////////////

End Sub

Sub CargoRecordsetSerializado()
    'On Error Resume Next
    Dim s As String
    Dim fso As New FileSystemObject
    Dim txtfile As TextStream
      
    Dim Filename As String
    Filename = GetTempFileName ' "RsSerial.txt"
      
    'registro -->archivo
    Set txtfile = fso.CreateTextFile(Filename, True)      ' (App.Path & "\" & txtSecuencia & ".txt", True)
    txtfile.Write origen.Registro!GrillaSerializada
    txtfile.Close

    'archivo-->rs
   
    Set rsDirecto = Nothing
    Set rsDirecto = New ADOR.Recordset
    rsDirecto.Open Filename
End Sub

Public Function GetTempFileName() As String

    Dim sTmp    As String
    Dim sTmp2   As String

    sTmp2 = GetTempPath
    sTmp = Space(Len(sTmp2) + 256)
    Call GetTempFileNameA(sTmp2, app.EXEName, UNIQUE_NAME, sTmp)
    GetTempFileName = Left$(sTmp, InStr(sTmp, Chr$(0)) - 1)

End Function

Private Function GetTempPath() As String
  
    Dim sTmp       As String
    Dim i          As Integer

    i = GetTempPathA(0, "")
    sTmp = Space(i)

    Call GetTempPathA(i, sTmp)
    GetTempPath = AddBackslash(Left$(sTmp, i - 1))

End Function

Private Function AddBackslash(s As String) As String

    If Len(s) > 0 Then
        If Right$(s, 1) <> "\" Then
            AddBackslash = s + "\"
        Else
            AddBackslash = s
        End If

    Else
        AddBackslash = "\"
    End If

End Function

Public Function FileExists(sFullPath As String) As Boolean
    Dim oFile As New Scripting.FileSystemObject
    FileExists = oFile.FileExists(sFullPath)
End Function

Sub RellenaListaDeProcesosSinAsignar()
    rsDirecto.Filter = "FechaInicio=null or idMaquina=null or idMaquina=-1"

    If rsDirecto.RecordCount <> 0 Then
        rsDirecto.MoveFirst
        List1.Clear
        List1.AddItem "Procesos sin programar:"

        Do While Not rsDirecto.EOF

            'If iisNull(rsDirecto!avance, 0) = 0 Then
            If rsDirecto!PartesAsociados = 0 Then
                List1.AddItem rsDirecto!IdDetalleProduccionOrdenProceso & "-" & rsDirecto!NumeroOrdenProduccion & "-" & rsDirecto!descripcion
            End If

            rsDirecto.MoveNext
        Loop

    End If

End Sub

'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////

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

'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////

Sub CopiaBloque()

    With fGrid
        Dim s As String
        s = .TextMatrix(.MouseRow, .MouseCol)
         
        If s <> "" Then

            With rsDirecto
                         
                .Filter = "idDetalleProduccionOrdenProceso=" & Right(s, Len(s) - InStr(1, s, " "))
                 
                If rsDirecto!avance > 0 Then
                    MsgBox ("No se pueden duplicar procesos con avance")
                    .Filter = ""
                    Exit Sub
                End If
                 
                'Duplico el bloquecito
                
                '///////////////////////////////////////
                '///////////////////////////////////////
                'METODO 1: Cabeza usando .tarea
                
                'Aplicacion.Tarea "DetProduccionOrdenesProcesos_A", _
                 Array(!IdProduccionOrden, _
                 !IdProduccionProceso, _
                 iisNull(!Horas, 0), _
                 iisNull(!FechaInicio, !FechaInicioPrevista), _
                 iisNull(!FechaFinal, !FechaFinalPrevista), _
                 iisNull(!HorasReales, 0), _
                 !IdMaquina, "")
                '///////////////////////////////////////
                '///////////////////////////////////////
                                
                '///////////////////////////////////////
                '///////////////////////////////////////
                'METODO 2: Usando el objeto
                Dim Orden As ComPronto.ProduccionOrden
                Dim DetProduccionOrden As DetProduccionOrden
                Dim DetProduccionOrdenProceso As DetProdOrdenProceso

                Set Orden = AplicacionProd.ProduccionOrdenes.Item(rsDirecto!IdProduccionOrden)
                
                Set DetProduccionOrdenProceso = Orden.DetProduccionOrdenesProcesos.Item(-1)

                With DetProduccionOrdenProceso.Registro
                    !FechaInicio = iisNull(rsDirecto!FechaInicio, rsDirecto!FechaInicioPrevista)
                    !fechafinal = iisNull(rsDirecto!fechafinal, rsDirecto!FechaFinalPrevista)
                    !IdProduccionProceso = rsDirecto!IdProduccionProceso
                    !Horas = rsDirecto!Horas
                    !IdMaquina = rsDirecto!IdMaquina
                End With

                DetProduccionOrdenProceso.Modificado = True
            
                Orden.Guardar
                Set Orden = Nothing
                Set DetProduccionOrdenProceso = Nothing
                '///////////////////////////////////////
                '///////////////////////////////////////
                 
                .Filter = ""
            End With
         
        End If
             
        Command1_Click 'refresco
    End With

End Sub

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
    Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
    Set actL2 = actl1
   
End Property

Private Sub Form_Paint()

    ''Degradado Me
   
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

Private Sub MnuDetA_Click(Index As Integer)

    Select Case Index

        Case 0
            CopiaBloque

            'If fGrid.TextMatrix(1, COL_FECHA) = "" Then Exit Sub 'estoy en el nivel de obra
            'AgregarEtapa
        Case 1

            'If fGrid.TextMatrix(1, COL_FECHA) = "" Then Exit Sub 'estoy en el nivel de obra
            'AgregarItem
        Case 2

            'EditarNodo (fGrid.TextMatrix(fGrid.Row, COL_FECHA))
        Case 3
            'If fGrid.TextMatrix(1, COL_FECHA) = "" Then Exit Sub
            'EliminarNodo ' (fGrid.TextMatrix(fGrid.row, COL_ID1))
    End Select

End Sub

'/////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////

Sub ConfiguraGrilla(Optional Redimensionar As Boolean = True)

    With fGrid

        If Redimensionar Then
            .FixedRows = 1
            .FixedCols = 0
            '.Cols = COL_OPPREVISTA + 1
        End If

        '.ColWidth(COL_ID1) = 0
        .ColWidth(COL_IDMAQ) = 0
        .ColWidth(COL_IDOPDETPROC) = 0
                
        '.ColAlignment(COL_FECHA) = flexAlignLeftCenter
    End With

End Sub

