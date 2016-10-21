VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#3.0#0"; "Controles1013.ocx"
Object = "{126E538A-EE41-4B22-A045-F8D5538F5D2B}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmProduccionFicha 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ficha Técnica"
   ClientHeight    =   8490
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   12675
   Icon            =   "frmProduccionFicha.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   8490
   ScaleWidth      =   12675
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdCrearOP 
      Caption         =   "&Crear OP"
      Height          =   420
      Left            =   5880
      TabIndex        =   32
      Top             =   7920
      Width           =   1110
   End
   Begin VB.CommandButton CmdCopia 
      Caption         =   "&Copiar Ficha"
      Height          =   420
      Left            =   4680
      TabIndex        =   31
      Top             =   7920
      Width           =   1110
   End
   Begin VB.CheckBox chkACTIVA 
      Caption         =   "ACTIVA"
      Height          =   255
      Left            =   3720
      TabIndex        =   30
      Top             =   960
      Width           =   1455
   End
   Begin VB.CommandButton cmdBOMConsolidado 
      Caption         =   "BOM consolidado"
      Height          =   495
      Left            =   3360
      TabIndex        =   29
      Top             =   7800
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.CommandButton cmdBOMCon 
      Caption         =   "BOM con ramificaciones"
      Height          =   495
      Left            =   2040
      TabIndex        =   28
      Top             =   7800
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Eliminar"
      Height          =   420
      Index           =   1
      Left            =   9000
      TabIndex        =   24
      Top             =   7920
      Width           =   1110
   End
   Begin VB.TextBox txtCodigoArticulo 
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
      Height          =   315
      Left            =   960
      TabIndex        =   20
      Top             =   120
      Width           =   1545
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
      Left            =   10320
      TabIndex        =   16
      Top             =   120
      Width           =   2265
   End
   Begin VB.TextBox txtCantidad 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   960
      TabIndex        =   0
      Top             =   600
      Width           =   870
   End
   Begin Controles1013.DbListView ListaProcesos 
      Height          =   2415
      Left            =   120
      TabIndex        =   3
      Top             =   5400
      Width           =   12465
      _ExtentX        =   21987
      _ExtentY        =   4260
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   0
      MouseIcon       =   "frmProduccionFicha.frx":076A
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3375
      Left            =   120
      TabIndex        =   2
      Top             =   1680
      Width           =   12480
      _ExtentX        =   22013
      _ExtentY        =   5953
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   0
      MouseIcon       =   "frmProduccionFicha.frx":0786
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   1
      Left            =   12000
      Picture         =   "frmProduccionFicha.frx":07A2
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   7920
      Width           =   525
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   7800
      TabIndex        =   4
      Top             =   7920
      Width           =   1110
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   420
      Index           =   2
      Left            =   10200
      TabIndex        =   5
      Top             =   7920
      Width           =   1110
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   0
      Left            =   11400
      Picture         =   "frmProduccionFicha.frx":0D2C
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   7920
      UseMaskColor    =   -1  'True
      Visible         =   0   'False
      Width           =   525
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   8
      Top             =   8205
      Visible         =   0   'False
      Width           =   12675
      _ExtentX        =   22357
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdUnidad"
      Height          =   315
      Index           =   0
      Left            =   1920
      TabIndex        =   1
      Tag             =   "Unidades"
      Top             =   600
      Width           =   1185
      _ExtentX        =   2090
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdArticuloAsociado"
      Height          =   315
      Index           =   1
      Left            =   2520
      TabIndex        =   17
      Tag             =   "Articulos"
      Top             =   120
      Width           =   6810
      _ExtentX        =   12012
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   120
      Top             =   7560
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
            Picture         =   "frmProduccionFicha.frx":1396
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProduccionFicha.frx":14A8
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProduccionFicha.frx":18FA
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProduccionFicha.frx":1D4C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "idColor"
      Height          =   315
      Index           =   13
      Left            =   3720
      TabIndex        =   22
      Tag             =   "Colores"
      Top             =   600
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdColor"
      Text            =   ""
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   10320
      TabIndex        =   25
      Top             =   480
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   582
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   1
      Left            =   10320
      TabIndex        =   26
      Top             =   840
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   582
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
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   570
      Left            =   6240
      TabIndex        =   33
      Top             =   600
      Width           =   3135
      _ExtentX        =   5530
      _ExtentY        =   1005
      _Version        =   393217
      BorderStyle     =   0
      ScrollBars      =   2
      TextRTF         =   $"frmProduccionFicha.frx":219E
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obs.:"
      Height          =   255
      Index           =   0
      Left            =   5520
      TabIndex        =   34
      Top             =   720
      Width           =   780
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto"
      Height          =   300
      Index           =   0
      Left            =   9600
      TabIndex        =   27
      Top             =   600
      Width           =   1230
   End
   Begin VB.Label lblColor 
      Caption         =   "Color"
      Height          =   255
      Index           =   2
      Left            =   3240
      TabIndex        =   23
      Top             =   720
      Width           =   615
   End
   Begin VB.Label lblLabels 
      Caption         =   "Materiales/Mano de Obra:"
      Height          =   210
      Index           =   16
      Left            =   120
      TabIndex        =   21
      Top             =   1440
      Width           =   1905
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   225
      Index           =   9
      Left            =   120
      TabIndex        =   19
      Top             =   240
      Width           =   975
   End
   Begin VB.Label lblLabels 
      Caption         =   "Buscar"
      Height          =   255
      Index           =   6
      Left            =   9600
      TabIndex        =   18
      Top             =   240
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Procesos:"
      Height          =   210
      Index           =   8
      Left            =   120
      TabIndex        =   15
      Top             =   5160
      Width           =   1545
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   18480
      TabIndex        =   14
      Top             =   2400
      Visible         =   0   'False
      Width           =   570
   End
   Begin VB.Label Label1 
      Caption         =   "Estado???"
      Height          =   375
      Left            =   18480
      TabIndex        =   13
      Top             =   1920
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Label lblInicioPrevisto 
      AutoSize        =   -1  'True
      Caption         =   "Inicio Previsto:"
      Height          =   240
      Index           =   6
      Left            =   18480
      TabIndex        =   12
      Top             =   2760
      Visible         =   0   'False
      Width           =   1050
   End
   Begin VB.Label lblFinalPrevisto 
      AutoSize        =   -1  'True
      Caption         =   "Final Previsto:"
      Height          =   240
      Index           =   1
      Left            =   18480
      TabIndex        =   11
      Top             =   3120
      Visible         =   0   'False
      Width           =   1050
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   255
      Index           =   7
      Left            =   120
      TabIndex        =   10
      Top             =   720
      Width           =   975
   End
   Begin VB.Label lblEstado1 
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
      Height          =   240
      Left            =   15240
      TabIndex        =   9
      Top             =   2040
      Visible         =   0   'False
      Width           =   1950
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
   Begin VB.Menu MnuDetProc 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetProcA 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetProcA 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetProcA 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
End
Attribute VB_Name = "frmProduccionFicha"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public WithEvents origen As ComPronto.ProduccionFicha
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
 
Public FichaCopiar As ComPronto.ProduccionFicha
Public BorroSiCancela As Boolean

Private mTipoSalida As Integer, mOk As Integer, mvarIdMonedaPesos As Integer

Public mvarId As Long, mIdAprobo As Long, mvarIdUnidadCU As Long, mvarIdDepositoCentral As Long

Private mvarGrabado As Boolean, mvarModoCodigoBarra As Boolean, mvarSoloStockObra As Boolean

Private mvarImpresionHabilitada As Boolean, mvarNumerarPorPuntoVenta As Boolean

Private mvarTransportistaConEquipos As Boolean, mvarNoAnular As Boolean

Private mvarAnulada As String, mOpcionesAcceso As String, mCadena As String

Private mvarExigirEquipoDestino As String, mDescargaPorKit As String

Private mNivelAcceso As Integer

Private mvarPathAdjuntos As String

Const ACOL_CODART = 1
Const ACOL_DESCART = 2
Const ACOL_COLOR = 3
Const ACOL_CANT = 4
Const ACOL_PORCEN = 5
Const ACOL_TOLERA = 6
Const ACOL_UNI = 7
Const ACOL_PROCESO = 8

Const PCOL_PROCESO = 1
Const PCOL_HORAS = 2

Dim NivelRecursivo As Integer

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

Sub Editar(ByVal Cual As Long, _
           Optional Modo As Integer = vbModal)

    '   If Cual = -1 And mTipoSalida = 0 Then
    '      MsgBox "Solo puede agregar items por arrastre desde los vales pendientes!", vbCritical
    '      Exit Sub
    '   End If
   
    '   If Cual > 0 Then
    '      MsgBox "No puede modificar una ProduccionFicha ya registrada, eliminela.", vbCritical
    '      Exit Sub
    '   End If
   
    'If IsNull(origen.Registro.Fields("IdObra").Value) And Combo1(0).ListIndex <> 2 Then
    '   MsgBox "Antes de ingresar los detalles debe definir la obra", vbCritical
    '   Exit Sub
    'End If
   
    Dim oF As frmDetProduccionFicha
    Dim oL As ListItem
   
    Set oF = New frmDetProduccionFicha
   
    With oF
        Set .ProduccionFicha = origen
        .Id = Cual
        .TipoSalida = mTipoSalida
        .Show Modo, Me
    End With

    PostmodalEditar oF, Cual
End Sub

Sub PostmodalEditar(oF As frmDetProduccionFicha, _
                    ByVal Cual As Long)
    Dim oL As ListItem

    With oF

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

                .SubItems(ACOL_CODART) = oF.txtCodigoArticulo.Text
                .SubItems(ACOL_DESCART) = oF.DataCombo1(1).Text
                .SubItems(ACOL_CANT) = "" & oF.txtCantidad.Text
             
                If Val(txtCantidad) <> 0 Then
                    .SubItems(ACOL_PORCEN) = Int(100 / SumaCantidades * Val(.SubItems(ACOL_CANT))) & "%"
                End If
             
                .SubItems(ACOL_TOLERA) = "" & oF.txtTolerancia
                .SubItems(ACOL_UNI) = "" & oF.DataCombo1(0).Text 'uni

                .SubItems(ACOL_PROCESO) = "" & oF.DataCombo1(7).Text 'proc
                .SubItems(ACOL_COLOR) = "" & oF.DataCombo1(13).Text 'color
             
                '.subitems(ACOL_COLOR) = "" & oF.DataCombo1(0).Text
                '.subitems(ACOL_9) = "" & oF.DataCombo1(2).Text
                '.subitems(ACOL_CODART0) = "" & oF.DataCombo1(3).Text
            End With

        End If
    
        Unload oF
        Set oF = Nothing
    
        mvarNoAnular = True
    End With

End Sub

Function SumaCantidades() As Single
    Dim i As Long
    Dim oL As ListItem

    With Lista

        For i = 1 To .ListItems.Count
            Set oL = .ListItems(i)
            SumaCantidades = SumaCantidades + Val(oL.SubItems(ACOL_CANT))
        Next i

    End With
    
End Function

Sub EditarProcesos(ByVal Cual As Long, _
                   Optional Modo As Integer = vbModal)

    '   If Cual = -1 And mTipoSalida = 0 Then
    '      MsgBox "Solo puede agregar items por arrastre desde los vales pendientes!", vbCritical
    '      Exit Sub
    '   End If
   
    '   If Cual > 0 Then
    '      MsgBox "No puede modificar una ProduccionFicha ya registrada, eliminela.", vbCritical
    '      Exit Sub
    '   End If
   
    'If IsNull(origen.Registro.Fields("IdObra").Value) And Combo1(0).ListIndex <> 2 Then
    '   MsgBox "Antes de ingresar los detalles debe definir la obra", vbCritical
    '   Exit Sub
    'End If
   
    Dim oF As frmDetProduccionFichaProceso
    Dim oL As ListItem
   
    Set oF = New frmDetProduccionFichaProceso
   
    With oF
        Set .ProduccionFicha = origen
        '      If dcfields(14).Visible And IsNumeric(dcfields(14).BoundText) Then
        '         .IdDepositoOrigen = dcfields(14).BoundText
        '      Else
        '         .IdDepositoOrigen = 0
        '      End If
        .Id = Cual
        '      .TipoSalida = mTipoSalida
        .Show Modo, Me
    End With

    PostmodalEditarProceso oF, Cual
End Sub

Sub PostmodalEditarProceso(oF As frmDetProduccionFichaProceso, _
                           ByVal Cual As Long)
    Dim oL As ListItem

    With oF

        If .Aceptado Then
            If Cual = -1 Then
                Set oL = ListaProcesos.ListItems.Add
                oL.Tag = .IdNuevo
            Else
                Set oL = ListaProcesos.SelectedItem
            End If

            With oL

                If Cual = -1 Then
                    '.SmallIcon = "Nuevo"
                Else
                    '.SmallIcon = "Modificado"
                End If
             
                .SubItems(PCOL_PROCESO) = oF.DataCombo1(1).Text
                .SubItems(PCOL_HORAS) = "" & oF.txtCantidad.Text
            End With

        End If
    
        Unload oF
        Set oF = Nothing
    
        mvarNoAnular = True
    End With

End Sub

Friend Sub cmd_Click(Index As Integer)

    On Error GoTo Mal

    Select Case Index
   
        Case 0
      
            'If Len(Combo1(0).Text) = 0 Then
            '   MsgBox "No determino el tipo de salida"
            '   Exit Sub
            'End If
         
            'agregar validacion para no duplicar fichas
         
            dcfields(1).Text = dcfields(1).Text
         
            If Not IsNumeric(dcfields(1).BoundText) Then
                MsgBox "Debe ingresar el artículo", vbExclamation
                Exit Sub
            End If

            If Not IsNumeric(dcfields(13).BoundText) Then
               MsgBox "Debe ingresar el color", vbExclamation
               Exit Sub
            End If
         
            If mvarId = -1 Then
                Dim rs As ADOR.Recordset
                origen.Registro.Fields(dcfields(1).DataField).Value = dcfields(1).BoundText
                Set rs = Aplicacion.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", Array(dcfields(1).BoundText, dcfields(13).BoundText))

                If rs.RecordCount > 0 Then
                    'MsgBox "Ya existe una ficha con el mismo artículo y color"
                    'Exit Sub
                End If
                
                
            End If
         
            If Not IsNumeric(origen.Registro!descripcion) Then
                origen.Registro!descripcion = iisNull(TraerValorParametro2("ProximoNumeroProduccionFicha"), 1000)
                GuardarValorParametro2 "ProximoNumeroProduccionFicha", origen.Registro!descripcion + 1
            End If
            
            If Lista.ListItems.Count = 0 Then
                MsgBox "No se puede almacenar una Ficha de producción sin detalles"
                Exit Sub
            End If
         
            Dim dc As DataCombo
            Dim dtp As DTPicker
            Dim est As EnumAcciones
            Dim oRsDet As ADOR.Recordset
            Dim oRsStk As ADOR.Recordset
            Dim oRsAux As ADOR.Recordset
            Dim mvarCantidad As Double, mvarCantidadAdicional As Double
            Dim mvarCantidadUnidades As Double, mvarStock As Double, mvarStock1 As Double, mvarStock2 As Double
            Dim mvarCantConj As Double
            Dim mvarIdStock As Long, mNum As Long, mvarIdEquipoDestino As Long, mvarIdTipoRosca As Long
            Dim mvarNumero As Long, mvarNumeroAnt As Long
            Dim mvarImprime As Integer
            Dim mvarAux1 As String, mvarAux2 As String, mvarAux3 As String, mvarAux4 As String, mvarAux5 As String
            Dim mvarParaMantenimiento As String, mvarBasePRONTOMantenimiento As String, mvarError As String
            Dim mvarArticulo1 As String, mvarArticulo As String, mvarDestino As String, mvarFamilia As String
            Dim mvarRegistrarStock As Boolean
            Dim oPar As ComPronto.Parametro
         
            mvarNumeroAnt = 0 'Val(txtNumeroProduccionFicha.Text)
         
            'For Each dtp In DTFields
            '   origen.Registro.Fields(dtp.DataField).Value = dtp.Value
            'Next
         
            For Each dc In dcfields

                If dc.Tag <> "Colores" Then
                    If dc.Enabled And dc.Visible Then
                        If Not IsNumeric(dc.BoundText) And dc.Index <> 1 And dc.Index <> 2 And dc.Index <> 3 And dc.Index <> 7 And dc.Index <> 8 Then
                            MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                            Exit Sub
                        End If

                        If IsNumeric(dc.BoundText) Then
                            origen.Registro.Fields(dc.DataField).Value = dc.BoundText
                        End If
                    End If
                End If

            Next
         
            If chkACTIVA.Value Then
                origen.Registro.Fields("EstaActiva").Value = "SI"
                ProduccionModulo.DesactivarElRestoDeLasFichasQueUsenElMismoArticulo dcfields(1).BoundText, dcfields(13).BoundText
            Else
                origen.Registro.Fields("EstaActiva").Value = "NO"
            End If
         
            
            origen.Registro!Observaciones = rchObservaciones
            
            '·         El error que se copia más abajo lo emite la Ficha Técnica al intentar grabarla sin asignarle “color”.
         
            Set oRsDet = origen.DetProduccionFichas.Registros

            If oRsDet.RecordCount > 0 Then

                With oRsDet
                    .MoveFirst

                    Do While Not .EOF

                        If Not .Fields("Eliminado").Value Then
                            If IsNull(.Fields("IdArticulo").Value) Then
                                Set oRsDet = Nothing
                                MsgBox "Articulo no definido!", vbExclamation
                                Exit Sub
                            End If

                            If IsNull(.Fields("IdUnidad").Value) Then
                                Set oRsDet = Nothing
                                MsgBox "Unidad de medida no definida!", vbExclamation
                                Exit Sub
                            End If
                        
                        End If

                        .MoveNext
                    Loop

                End With

            End If

            Set oRsDet = Nothing
            Set oRsAux = Nothing
            Set oRsStk = Nothing
            '         End If
         
            If Len(mvarError) > 0 Then
                MsgBox "Se han detectado los siguientes errores : " & mvarError, vbExclamation
                Exit Sub
            End If
        
            If mvarId < 0 Then
                mvarGrabado = True
            End If
         
            Dim i As Long

            For i = 0 To 1
                origen.Registro.Fields("ArchivoAdjunto" & i + 1).Value = FileBrowser1(i).Text
            Next
         
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
            
                Set oRsAux = AplicacionProd.ProduccionFichas.TraerFiltrado("_PorId", mvarId)

                If oRsAux.RecordCount > 0 Then
                    oRsAux.MoveFirst
                End If

                oRsAux.Close
                Set oRsAux = Nothing
            Else
                est = Modificacion
            End If
            
            
            
            
            If Not actL2 Is Nothing Then
                With actL2
                    .ListaEditada = "FichaTecnica"
                    .AccionRegistro = est
                    .Disparador = mvarId
                End With
            End If
         
            
       BorroSiCancela = False
       
            Unload Me

        Case 1
   
            Dim mBorra As Integer
            mBorra = MsgBox("Esta seguro de eliminar los datos definitivamente ?", vbYesNo, "Eliminar")

            If mBorra = vbNo Then
                Exit Sub
            End If
        
            origen.Eliminar
        
            est = baja
            Aplicacion.Tarea "Log_InsertarRegistro", Array("ELIM", mvarId, 0, Now, 0, "Tabla : Rubros", GetCompName(), glbNombreUsuario)
            
            
       BorroSiCancela = False
            
            With actL2
       
                .AccionRegistro = est
                .Disparador = mvarId
            End With

        Case 2
            Dim oSrv As InterFazMTS.iCompMTS
            Set oSrv = CreateObject("MTSPronto.General")
            If BorroSiCancela Then oSrv.Eliminar "ProduccionFichas", mvarId
            Aplicacion.Tarea ("ProduccionFichas_ReestablecerContador")
            Set oSrv = Nothing
        Case 3
      
            AnularSalida
         
    End Select
   
    Unload Me
   
Salida:
   
    Set oRsDet = Nothing
    Set oRsStk = Nothing
    Set oPar = Nothing
   
    Exit Sub
   
Mal:

    MsgBox "Se ha producido un problema al tratar de registrar los datos" & vbCrLf & Err.Description, vbCritical
    Resume Salida
   
End Sub




Public Property Let Id(ByVal vNewValue As Long)

    Dim oControl As Control
    Dim oAp As ComPronto.Aplicacion
    Dim oApProd As ComPronto.Aplicacion
    Dim oDet As DetProduccionFicha
    Dim oDetproc As DetProdFichaProceso
    Dim oRs As ADOR.Recordset
    Dim oRsAut As ADOR.Recordset
    Dim dtf As DTPicker
    Dim ListaVacia As Boolean
    Dim ListaProcVacia As Boolean
    Dim i As Integer, mCantidadFirmas As Integer
    Dim mAuxS1 As String
    Dim mAux1 As Variant
    Dim mVector
   
    mvarId = vNewValue
   
    ListaVacia = False
    mCadena = ""
    mvarModoCodigoBarra = False
    mvarAnulada = "NO"
    mvarImpresionHabilitada = True
    mvarSoloStockObra = False
    mvarTransportistaConEquipos = False
    mvarNoAnular = False
   
    Set oAp = Aplicacion
    Set oApProd = AplicacionProd
   
   If FichaCopiar Is Nothing Then
       Set origen = oApProd.ProduccionFichas.Item(vNewValue)
       Else
       Set origen = FichaCopiar
       End If
   
    If glbParametrizacionNivel1 Then
        origen.NivelParametrizacion = 1
    End If
   
    Set oRs = oAp.Parametros.Item(1).Registro
    mvarIdMonedaPesos = oRs.Fields("IdMoneda").Value
    mvarIdUnidadCU = oRs.Fields("IdUnidadPorUnidad").Value
    oRs.Close
   
    mDescargaPorKit = BuscarClaveINI("Mover stock por kit")

    If mDescargaPorKit = "" Then mDescargaPorKit = "NO"
         
    mvarExigirEquipoDestino = BuscarClaveINI("Exigir equipo destino en salida de materiales")

    If mvarExigirEquipoDestino = "" Then mvarExigirEquipoDestino = "NO"
   
    If BuscarClaveINI("Requerir deposito origen en salida de materiales") = "SI" Then
    End If
   
    origen.MostrarSoloStockDeObra = mvarSoloStockObra
   
    Set oBind = New BindingCollection

    With oBind
        Set .DataSource = origen
      
        For Each oControl In Me.Controls

            If TypeOf oControl Is CommandButton Then
            ElseIf TypeOf oControl Is DbListView Then

                Select Case oControl.Name

                    Case "Lista"

                        If vNewValue < 0 Then
                            Set oControl.DataSource = origen.DetProduccionFichas.TraerMascara
                            ListaVacia = True
                        Else
                            'If mvarSoloStockObra And Not IsNull(origen.Registro.Fields("IdObra").Value) Then
                            '   Set oRs = oAp.TablasGenerales.TraerFiltrado("DetProduccionFichas", "Sal", Array(mvarId, origen.Registro.Fields("IdObra").Value))
                            'Else
                            Set oRs = origen.DetProduccionFichas.TraerTodos

                            'End If
                            If oRs.RecordCount <> 0 Then
                                Set oControl.DataSource = oRs
                                oRs.MoveFirst

                                Do While Not oRs.EOF
                                    Set oDet = origen.DetProduccionFichas.Item(oRs.Fields(0).Value)
                                    oDet.Modificado = True
                                    Set oDet = Nothing
                                    oRs.MoveNext
                                Loop

                                ListaVacia = False
                            Else
                                Set oControl.DataSource = origen.DetProduccionFichas.TraerMascara
                                ListaVacia = True
                            End If

                            oRs.Close
                        End If

                    Case "ListaProcesos"

                        If vNewValue < 0 Then
                            Set oControl.DataSource = origen.DetProduccionFichasProcesos.TraerMascara
                            ListaProcVacia = True
                        Else
                            'If mvarSoloStockObra And Not IsNull(origen.Registro.Fields("IdObra").Value) Then
                            '   Set oRs = oAp.TablasGenerales.TraerFiltrado("DetProduccionFichasProcesos", "Sal", Array(mvarId, origen.Registro.Fields("IdObra").Value))
                            'Else
                            Set oRs = origen.DetProduccionFichasProcesos.TraerTodos

                            'End If
                            If oRs.RecordCount <> 0 Then
                                Set oControl.DataSource = oRs
                                oRs.MoveFirst

                                Do While Not oRs.EOF
                                    Set oDetproc = origen.DetProduccionFichasProcesos.Item(oRs.Fields(0).Value)
                                    oDetproc.Modificado = True
                                    Set oDetproc = Nothing
                                    oRs.MoveNext
                                Loop

                                ListaProcVacia = False
                            Else
                                Set oControl.DataSource = origen.DetProduccionFichasProcesos.TraerMascara
                                ListaProcVacia = True
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

                    ElseIf oControl.Tag = "PuntosVenta" Then
                        Set oControl.RowSource = oAp.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(50, "X"))
                    Else
                        Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
                    End If
                End If

            Else
                On Error Resume Next
            
                Dim t As String
                t = TypeName(oControl)

                If t <> "Frame" And t <> "OptionButton" And t <> "Menu" And t <> "OptionButton" And t <> "Frame" And t <> "OptionButton" And t <> "Frame" And t <> "OptionButton" And t <> "Frame" And t <> "OptionButton" And t <> "StatusBar" And t <> "ImageList" Then
                    Set oControl.DataSource = origen
                End If
         
            End If

        Next

    End With
   
    rchObservaciones = origen.Registro!Observaciones
    
    
    
    
    
    
    '-> Cuando voy la ficha tecnica no la puedo desactivar, el boton aceptar esta deshabilitado
'-> Cuando quiero crear una copia tira el siguiente error Error 3265 en tiempo de ejecución
    '-meterme solo con permisos de operador y ver que pasa
    
    
    
    
    'Set dcfields(1).RowSource = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_ProduciblesParaCombo", Array(0))
    Set dcfields(1).RowSource = Aplicacion.Articulos.TraerLista 'Por ahora saco el filtro de tipo hasta que se haga la union con la base pronto

    'TO DO Incorporar cálculo de porcentaje en Materiales. En una columna al
    'lado de la cantidad de cada ítem, agregar una columna que calcule la
    ' Cant.Item/Cantidad a producir y muestre este resultado en porcentaje.
   
    If mvarId = -1 Then

        Me.Caption = "Ficha Técnica n°" & TraerValorParametro2("ProximoNumeroProduccionFicha")
        
        With origen.Registro
            .Fields("Emitio").Value = glbIdUsuario
        End With

        mvarGrabado = False
        mIdAprobo = 0
        Cmd(3).Enabled = False
   
        'MARIANO: harcodeo la obra
        dcfields(0).BoundText = 1
   
        cmdCrearOP.Enabled = False
    Else
    
    
        Me.Caption = "Ficha Técnica n°" & IIf(IsNumeric(origen.Registro.Fields("Descripcion").Value), origen.Registro.Fields("Descripcion").Value, TraerValorParametro2("ProximoNumeroProduccionFicha"))
        
        
        With origen.Registro

            If Not IsNull(.Fields("Anulada").Value) And .Fields("Anulada").Value = "SI" Then

                With lblEstado1
                    .Caption = "ANULADA"
                    .Visible = True
                End With

                mvarAnulada = "SI"
            End If

            If Not IsNull(.Fields("TipoSalida").Value) Then
                mTipoSalida = .Fields("TipoSalida").Value
            Else
                mTipoSalida = 0
            End If

            If Not IsNull(.Fields("Aprobo").Value) Then
                mIdAprobo = .Fields("Aprobo").Value
            Else
                dcfields(1).Enabled = True
            End If

            If Not IsNull(.Fields("Acargo").Value) Then
            End If

        End With

        mCantidadFirmas = 0
        'Set oRsAut = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(EnumFormularios.ProduccionFicha, 0))
        'If oRsAut.RecordCount > 0 Then
        '   oRsAut.MoveFirst
        '   Do While Not oRsAut.EOF
        '      mCantidadFirmas = mCantidadFirmas + 1
        '      Check1(mCantidadFirmas).Visible = True
        '      Check1(mCantidadFirmas).Tag = oRsAut.Fields(0).Value
        '      oRsAut.MoveNext
        '   Loop
        'End If
        'oRsAut.Close
        'Set oRsAut = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(EnumFormularios.ProduccionFicha, mvarId))
        'If oRsAut.RecordCount > 0 Then
        '   oRsAut.MoveFirst
        '   Do While Not oRsAut.EOF
        '      For i = 1 To mCantidadFirmas
        '         If Check1(i).Tag = oRsAut.Fields("FichaAutorizacion").Value Then
        '            Check1(i).Value = 1
        '            Exit For
        '         End If
        '      Next
        '      oRsAut.MoveNext
        '   Loop
        'End If
        'oRsAut.Close
        'Set oRsAut = Nothing
        mvarGrabado = True
        RecalcularPorcentajes
    End If
   
    If ListaVacia Then
        Lista.ListItems.Clear
    End If

    If ListaProcVacia Then
        ListaProcesos.ListItems.Clear
    End If
   
    MuestraAdjuntos

    If origen.Registro.Fields("EstaActiva").Value = "NO" Then
        chkACTIVA.Value = 0
    Else
        chkACTIVA.Value = 1
    End If

    For i = 0 To 1
        FileBrowser1(i).Text = origen.Registro.Fields("ArchivoAdjunto" & i + 1).Value
    Next
   
    Cmd(0).Enabled = False
    CmdCopia.Enabled = False

    If Me.NivelAcceso = Medio Then
        'If mvarId <= 0 Then cmd(0).Enabled = True
        Cmd(0).Enabled = True
        If mvarId > 0 Then CmdCopia.Enabled = True
    ElseIf Me.NivelAcceso = Alto Then
        Cmd(0).Enabled = True
        If mvarId > 0 Then CmdCopia.Enabled = True
    End If
   
    'If mvarAnulada = "SI" Then
    '   cmd(0).Enabled = False
    '   cmd(2).Enabled = False
    '   cmd(3).Enabled = False
    'End If
   
    If Not mvarImpresionHabilitada Then
        cmdImpre(0).Enabled = False
        cmdImpre(1).Enabled = False
    End If
   
    Set oRs = Nothing
    Set oDet = Nothing
    Set oDetproc = Nothing
    Set oAp = Nothing
   
End Property

Private Sub cmdBOMCon_Click()

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
        
                'Exportar_Excel = False
                
                'En la plantilla del Excel que sale de este punto, te pido que veas la posibilidad de agregar un encabezado, pues sólo están los títulos de las columnas
                'pero no se sabe de que el el listado de Excel, ni la fecha, ni el artículo, etc.
            
                .Cells(1, 1).Value = "BOM - Lista de Materiales"
                .Cells(1, 2).Value = Date
                '.Cells(2, 1).Value = Now
            
                .Cells(5, "J").Value = "CANT."
                '.Cells(1, 3).Value = Articulo
            
                '////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////
                            
                'Acá tendría que hacer lo mismo para todos los materiales de 1 y 2 nivel
            
                Dim fichanivel1 As ComPronto.ProduccionFicha
                Dim fichanivel2 As ComPronto.ProduccionFicha
                Dim oDet As DetProduccionOrden
                Dim oRs As ADOR.Recordset
                Dim rs As ADOR.Recordset
                Dim rs1 As ADOR.Recordset
                Dim rs2 As ADOR.Recordset
                Dim i As Integer
            
                'me traigo la ficha del artículo
                Set rs = AplicacionProd.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", Array(BuscaIdArticulo(dcfields(1).BoundText), 0))

                If rs.RecordCount = 0 Then
                    MsgBox ("No se encontró la ficha")
                    Exit Sub
                End If
            
                NivelRecursivo = 0
                ExportaExcelFichaRecursiva rs!idProduccionFicha, 4, oEx.ActiveSheet, 1
           
                '////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////
            
                .Range("A1").Select
                oEx.Run "ArmarFormato"
      
                .Columns("B").ColumnWidth = 15
                .Columns("C:Z").ColumnWidth = 10
      
                .Rows("1:1").Select
                oEx.Selection.Insert Shift:=xlDown
        
            End With
        End With
    End With
    
    'Exportar_Excel = True

    Exit Sub

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

End Sub

Sub ExportaExcelFichaRecursiva(IdFicha, _
                               ByRef Fila, _
                               oEx As Object, _
                               Cantidad As Double)
    Dim oRs As ADOR.Recordset
    Dim mN As Long
    Dim c As Double
    Dim o As ComPronto.ProduccionFicha
    Dim oDet As ComPronto.DetProduccionFicha
    Dim Id As Long

    DoEvents
    NivelRecursivo = NivelRecursivo + 1
    Fila = Fila + 1
        
    Set o = AplicacionProd.ProduccionFichas.Item(IdFicha)
    
    With o.Registro
        oEx.Cells(Fila, NivelRecursivo + 1).Value = !descripcion
    End With
    
    Set o = AplicacionProd.ProduccionFichas.Item(IdFicha)
            
    'lleno los productos
    Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_DetalleDeFicha", IdFicha)

    If oRs.RecordCount <> 0 Then
        
        oRs.MoveFirst

        Do While Not oRs.EOF
 
            Fila = Fila + 1
           
            'actualizar cantidad en la lista y en el objeto
                                         
            If IsNull(oRs.Fields![Cant.].Value) Then
                MsgBox ("La cantidad del material " & oRs!Articulo & " en la ficha está en 0")
            ElseIf IsNull(o.Registro!Cantidad) Then
                MsgBox ("La cantidad total de la ficha está en 0")
            Else
                c = oRs.Fields![Cant.].Value * Cantidad
            End If
            
            'me traigo la ficha del artículo
            If AplicacionProd.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", Array(oRs!IdArticulo, iisNull(oRs!IdColor, 0))).RecordCount <> 0 Then

                'Debug.Print "Nivel " & NivelRecursivo & " - Ficha del articulo " & IdArticuloProducido & " llama a ficha --->" & oRs.Fields(2)
                'If IdArticuloProducido = oRs.Fields(2) Then
                'MsgBox ("La ficha del articulo " & IdArticuloProducido & " hace referencia a sí mismo")
                'Else
                If NivelRecursivo > 5 Then
                    'Stop
                Else
                    ExportaExcelFichaRecursiva AplicacionProd.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", Array(oRs!IdArticulo, iisNull(oRs!IdColor, 0)))!idProduccionFicha, Fila, oEx, c
                End If

            Else

                oEx.Cells(Fila, NivelRecursivo + 2).Value = oRs!Articulo
                oEx.Cells(Fila, 10).Value = c

            End If
           
            Set oDet = Nothing
            oRs.MoveNext
        Loop

    End If

    oRs.Close

    NivelRecursivo = NivelRecursivo - 1
End Sub

Private Sub cmdBOMConsolidado_Click()

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
        
                'Exportar_Excel = False
                
                'En la plantilla del Excel que sale de este punto, te pido que veas la posibilidad de agregar un encabezado, pues sólo están los títulos de las columnas
                'pero no se sabe de que el el listado de Excel, ni la fecha, ni el artículo, etc.
            
                .Cells(1, 1).Value = "BOM - Lista de Materiales"
                .Cells(1, 2).Value = Date
                '.Cells(2, 1).Value = Now
            
                .Cells(5, "J").Value = "CANT."
                '.Cells(1, 3).Value = Articulo
            
                '////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////
                            
                'Acá tendría que hacer lo mismo para todos los materiales de 1 y 2 nivel
            
                Dim fichanivel1 As ComPronto.ProduccionFicha
                Dim fichanivel2 As ComPronto.ProduccionFicha
                Dim oDet As DetProduccionOrden
                Dim oRs As ADOR.Recordset
                Dim rs As ADOR.Recordset
                Dim rs1 As ADOR.Recordset
                Dim rs2 As ADOR.Recordset
                Dim i As Integer
            
                'me traigo la ficha del artículo
                Set rs = AplicacionProd.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", Array(BuscaIdArticulo(dcfields(1).BoundText), 0))

                If rs.RecordCount = 0 Then
                    MsgBox ("No se encontró la ficha")
                    Exit Sub
                End If
            
                NivelRecursivo = 0
                ConsolidaExportaExcelFichaRecursiva rs!idProduccionFicha, 4, oEx.ActiveSheet, 1
           
                '////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////
            
                .Range("A1").Select
                oEx.Run "ArmarFormato"
      
                .Columns("B").ColumnWidth = 15
                .Columns("C:Z").ColumnWidth = 10
      
                .Rows("1:1").Select
                oEx.Selection.Insert Shift:=xlDown
        
            End With
        End With
    End With
    
    'Exportar_Excel = True

    Exit Sub

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

End Sub

Sub ConsolidaExportaExcelFichaRecursiva(IdFicha, _
                                        ByRef Fila, _
                                        oEx As Object, _
                                        Cantidad As Double)
    Dim oRs As ADOR.Recordset
    Dim mN As Long
    Dim c As Double
    Dim o As ComPronto.ProduccionFicha
    Dim oDet As ComPronto.DetProduccionFicha
    Dim Id As Long

    DoEvents
    NivelRecursivo = NivelRecursivo + 1
    Fila = Fila + 1
        
    Set o = AplicacionProd.ProduccionFichas.Item(IdFicha)
            
    'lleno los productos
    Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_DetalleDeFicha", IdFicha)

    If oRs.RecordCount <> 0 Then
        
        oRs.MoveFirst

        Do While Not oRs.EOF
 
            Fila = Fila + 1
           
            'actualizar cantidad en la lista y en el objeto
                                         
            If IsNull(oRs.Fields![Cant.].Value) Then
                MsgBox ("La cantidad del material " & oRs!Articulo & " en la ficha está en 0")
            ElseIf IsNull(o.Registro!Cantidad) Then
                MsgBox ("La cantidad total de la ficha está en 0")
            Else
                c = oRs.Fields![Cant.].Value * Cantidad
            End If
            
            'me traigo la ficha del artículo
            If AplicacionProd.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", Array(oRs!IdArticulo, iisNull(oRs!IdColor, 0))).RecordCount <> 0 Then

                'Debug.Print "Nivel " & NivelRecursivo & " - Ficha del articulo " & IdArticuloProducido & " llama a ficha --->" & oRs.Fields(2)
                'If IdArticuloProducido = oRs.Fields(2) Then
                'MsgBox ("La ficha del articulo " & IdArticuloProducido & " hace referencia a sí mismo")
                'Else
                If NivelRecursivo > 5 Then
                    'Stop
                Else
                    ConsolidaExportaExcelFichaRecursiva AplicacionProd.ProduccionFichas.TraerFiltrado("_ArticuloAsociado", Array(oRs!IdArticulo, iisNull(oRs!IdColor, 0)))!idProduccionFicha, Fila, oEx, c
                End If

            Else

                'como hago para no repetir??
                oEx.Cells(Fila, 2).Value = oRs!Articulo
                oEx.Cells(Fila, 10).Value = c

            End If
           
            Set oDet = Nothing
            oRs.MoveNext
        Loop

    End If

    oRs.Close

    NivelRecursivo = NivelRecursivo - 1
End Sub

Private Sub CmdCopia_Click()
    CrearCopiaDeFicha (mvarId)
End Sub

Private Sub cmdCrearOP_Click()
 Dim oF As frmProduccionOrden

   Set oF = New frmProduccionOrden

      With oF
              .NivelAcceso = frmPrincipal.ControlAccesoNivel("OrdendeProduccion")
        .OpcionesAcceso = frmPrincipal.ControlAccesoOpciones("OrdendeProduccion")

      .Id = -1
      
      dcfields(1).Text = dcfields(1).Text 'magic maaagic.... (el clasico truco para actualizar el boundtext)
      dcfields(13).Text = dcfields(13).Text 'magic maaagic....
      
       oF.dcfields(11).BoundText = Me.dcfields(1).BoundText 'art
       oF.dcfields(13).BoundText = Me.dcfields(13).BoundText 'color
       oF.CargarFicha
       
      
      Me.MousePointer = vbDefault
      .Show , Me
   End With

Salida:

   Set oF = Nothing

   Me.MousePointer = vbDefault
End Sub

Private Sub FileBrowser1_Change(Index As Integer)

    If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
        If Len(Trim(FileBrowser1(Index).Text)) > gblMaximaLongitudAdjuntos Then
            MsgBox "La longitud maxima para un archivo adjunto es de " & gblMaximaLongitudAdjuntos & " caracteres", vbInformation
            FileBrowser1(Index).Text = ""
        Else
            FileBrowser1(Index).InitDir = FileBrowser1(Index).Text
        End If
    End If
   
End Sub

Private Sub FileBrowser1_DblClick(Index As Integer)

    If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
        If Not Len(Trim(Dir(FileBrowser1(Index).Text))) <> 0 Then
            MsgBox "El archivo indicado no existe!", vbExclamation
            Exit Sub
        End If

        Call ShellExecute(Me.hwnd, "open", FileBrowser1(Index).Text, vbNullString, vbNullString, SW_SHOWNORMAL)
    End If

End Sub

Private Sub MuestraAdjuntos()

    Dim i As Integer
   
    'If IsNull(origen.Registro.Fields("Adjunto").Value) Or origen.Registro.Fields("Adjunto").Value = "NO" Then
    '   For i = 0 To 9
    '      lblAdjuntos(i).Visible = False
    '      FileBrowser1(i).Visible = False
    '      FileBrowser1(i).Text = ""
    '   Next
    '   Line1.Visible = False
    '   Me.Height = 6500
    'Else
      
    Dim oAp As ComPronto.Aplicacion
    Dim oPar As ComPronto.Parametro
    Set oPar = oAp.Parametros.Item(1)

    With oPar.Registro
        mvarIdUnidadCU = IIf(IsNull(.Fields("IdUnidadPorUnidad").Value), 0, .Fields("IdUnidadPorUnidad").Value)
        mvarPathAdjuntos = IIf(IsNull(.Fields("PathAdjuntos").Value), "", .Fields("PathAdjuntos").Value)
    End With

    Set oPar = Nothing
   
    For i = 0 To 1
        lblAdjuntos(i).Visible = True
        FileBrowser1(i).Visible = True

        If Len(Trim(FileBrowser1(i).Text)) = 0 Then
            FileBrowser1(i).Text = mvarPathAdjuntos
            FileBrowser1(i).InitDir = mvarPathAdjuntos
        End If

    Next

    '   Line1.Visible = True
    '   Me.Height = 8700
    'End If
      
End Sub

Friend Sub cmdImpre_Click(Index As Integer)
    On Error Resume Next

    If Not mvarGrabado Then
        MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
        Exit Sub
    End If
   
    Dim mvarOK As Boolean
    Dim mCopias As Integer
   
    If Index = 0 Then
        Dim oF 'As frmCopiasImpresion

        'Set oF = New frmCopiasImpresion
        With oF

            If Index <> 0 Then
                .Frame1.Visible = False
            End If

            .Show vbModal, Me
            mvarOK = .Ok
            mCopias = Val(.txtCopias.Text)
        End With

        Unload oF
        Set oF = Nothing

        If Not mvarOK Then
            Exit Sub
        End If

    Else
        mCopias = 1
    End If

    Dim oW As Word.Application
    Dim mPlanilla As String
   
    If mTipoSalida = 1 Then
        mPlanilla = BuscarClaveINI("Plantilla para salida de materiales a obra")

        If Len(Trim(mPlanilla)) = 0 Then mPlanilla = "ProduccionFicha"
    Else
        mPlanilla = "ProduccionFicha"
    End If
   
    Set oW = CreateObject("Word.Application")
   
    oW.Visible = True
    'oW.Documents.Add (glbPathPlantillas & "\" & mPlanilla & "_" & glbEmpresaSegunString & ".dot")
    oW.Documents.Add (glbPathPlantillas & "\" & mPlanilla & ".dot")
    oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=mvarId
    oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
    oW.Application.Run MacroName:="DatosDelPie"

    If Index = 0 Then
        oW.ActiveDocument.PrintOut False, , , , , , , mCopias
        oW.ActiveDocument.Close False
    End If

    If Index = 0 Then oW.Quit

Salida:

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
        Dim oPar As ComPronto.Parametro
        Dim oRs As ADOR.Recordset

        If mvarId = -1 Then
            If Not mvarNumerarPorPuntoVenta Then
                Set oPar = Aplicacion.Parametros.Item(1)
                Set oRs = Nothing
                Set oPar = Nothing
            End If

            '         DTFields(0).Enabled = True
            dcfields(0).Enabled = True
            dcfields(1).Enabled = True
            dcfields(4).Enabled = True
            dcfields(14).Enabled = True
            '         txtNumeroProduccionFicha.Enabled = True
            '         txtNumeroProduccionFicha2.Enabled = True
            cmdImpre(0).Enabled = True
            cmdImpre(1).Enabled = True
        End If

    Else

        With origen.Registro
        End With

    End If

    If glbIdObraAsignadaUsuario <> -1 Then

        With origen.Registro
            .Fields("IdObra").Value = glbIdObraAsignadaUsuario
            .Fields("Emitio").Value = glbIdUsuario
            .Fields("Aprobo").Value = glbIdUsuario
        End With

        dcfields(0).Enabled = False
        dcfields(1).Enabled = False
        dcfields(4).Enabled = False
    End If
   
End Sub

Private Sub dcfields_Change(Index As Integer)

    If Not IsNumeric(dcfields(Index).BoundText) Then Exit Sub
   
    Dim oRs As ADOR.Recordset
   
    Select Case Index

        Case 0
            origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText

        Case 1
            Dim oArt As ComPronto.Articulo
            Set oArt = Aplicacion.Articulos.Item(dcfields(1).BoundText)
            Set oRs = oArt.Registro
            txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)

        Case 2
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorIdTransportista", dcfields(Index).BoundText)
            mvarTransportistaConEquipos = False

            If oRs.RecordCount > 0 Then mvarTransportistaConEquipos = True
            Set dcfields(8).RowSource = oRs
      
    End Select

    Set oRs = Nothing

End Sub

Private Sub dcfields_GotFocus(Index As Integer)
   
    If Index <> 1 Then
        If dcfields(Index).Enabled Then
            SendKeys "%{DOWN}"
        Else
            SendKeys "{TAB}"
        End If
    End If

End Sub

Private Sub dcfields_KeyPress(Index As Integer, _
                              KeyAscii As Integer)
   
    If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub dcfields_Click(Index As Integer, _
                           Area As Integer)

    'If Index = 1 And Me.Visible And IsNumeric(dcfields(Index).BoundText) Then
    '   If dcfields(Index).BoundText <> mIdAprobo Then
    '      PideAutorizacion
    '   End If
    'End If
   
End Sub

Private Sub dcfields_Validate(Index As Integer, _
                              Cancel As Boolean)

    Dim oRsObra As ADOR.Recordset
    Dim oRsCliente As ADOR.Recordset
    Dim oRsProv As ADOR.Recordset
   
    If IsNumeric(dcfields(Index).BoundText) Then
        origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText

        If Not IsNumeric(dcfields(Index).BoundText) Then Exit Sub

        Select Case Index

            Case 0
                Set oRsObra = Aplicacion.Obras.Item(dcfields(Index).BoundText).Registro

                If oRsObra.RecordCount > 0 Then
                    If Not IsNull(oRsObra.Fields("IdCliente").Value) Then
                        Set oRsCliente = Aplicacion.Clientes.TraerFiltrado("_TT", oRsObra.Fields("IdCliente").Value)

                        With oRsCliente

                            If .RecordCount > 0 Then
                            End If

                            oRsCliente.Close
                        End With

                        With origen.Registro
                            .Fields("IdProveedor").Value = Null
                        End With

                    End If
                End If

                oRsObra.Close

            Case 5
                Set oRsProv = Aplicacion.Proveedores.TraerFiltrado("_TT", dcfields(Index).BoundText)

                With oRsProv

                    If oRsProv.RecordCount > 0 Then
                    End If

                    .Close
                End With

                '            With origen.Registro
                '               .Fields("IdObra").Value = Null
                '               Check2.Value = 0
                '            End With
            Case 6

            Case 14
                dcfields(Index).Enabled = False
        End Select

    Else
        dcfields(Index).Text = ""
    End If
   
    Set oRsObra = Nothing
    Set oRsCliente = Nothing
    Set oRsProv = Nothing

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

    If KeyAscii <> 13 And mvarModoCodigoBarra Then
        mCadena = mCadena & Chr(KeyAscii)
        KeyAscii = 0
    ElseIf KeyAscii = 13 And mvarModoCodigoBarra Then
        Dim oRs As ADOR.Recordset

        If Len(mCadena) > 0 And Len(mCadena) <= 20 Then
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", mCadena)

            If oRs.RecordCount > 0 Then

                With origen.DetProduccionFichas.Item(-1)
                    With .Registro
                        .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                        .Fields("IdObra").Value = origen.Registro.Fields("IdObra").Value
                        .Fields("Partida").Value = ""
                        .Fields("Cantidad").Value = 1

                        If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                            .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                        Else
                            .Fields("IdUnidad").Value = mvarIdUnidadCU
                        End If

                        If IsNumeric(dcfields(0).BoundText) Then
                            .Fields("IdObra").Value = dcfields(0).BoundText
                        End If

                        .Fields("Adjunto").Value = "NO"
                        .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacionStandar").Value
                        .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                        .Fields("CotizacionMoneda").Value = 1
                        .Fields("IdMoneda").Value = mvarIdMonedaPesos
                        .Fields("CostoUnitario").Value = oRs.Fields("CostoPPP").Value
                    End With

                    .Modificado = True
                End With

                Set Lista.DataSource = origen.DetProduccionFichas.RegistrosConFormato
            End If

            oRs.Close
        End If

        Set oRs = Nothing
        mCadena = ""
    ElseIf KeyAscii = 27 And mvarModoCodigoBarra Then
        mvarModoCodigoBarra = False

        DoEvents
        mCadena = ""
    End If

End Sub

Private Sub Form_KeyUp(KeyCode As Integer, _
                       Shift As Integer)

    'F12 para inicializar el modo ingreso por codigo de barras
    If KeyCode = 123 Then
        mvarModoCodigoBarra = True

        DoEvents
    ElseIf KeyCode = 27 And mvarModoCodigoBarra Then
        mCadena = ""
        mvarModoCodigoBarra = False

        DoEvents
    End If

End Sub

Private Sub Form_Load()

    Dim oI As ListImage
   
    With Lista
        Set .SmallIcons = img16
        .IconoPequeño = "Original"
    End With
   
    With ListaProcesos
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

Private Sub Form_OLEDragDrop(Data As DataObject, _
                             Effect As Long, _
                             Button As Integer, _
                             Shift As Integer, _
                             X As Single, _
                             y As Single)

    If mvarId > 0 Then
        MsgBox "No puede modificar una salida ya registrada!", vbCritical
        Exit Sub
    End If
      
    Dim s As String
    Dim Filas
    Dim Columnas
    Dim iFilas As Long, iColumnas As Long, i As Long, j As Long
    Dim mvarIdDeposito As Long, mvarIdUbicacion As Long
    Dim mCostoATomar As String, mNumeroInventario As String
    Dim oL As ListItem
    Dim oAp As ComPronto.Aplicacion
    Dim oVal As ComPronto.ValeSalida
    Dim oRsVal As ADOR.Recordset
    Dim oRsDet As ADOR.Recordset
    Dim oRsAux As ADOR.Recordset
    Dim oRsAux1 As ADOR.Recordset

    mvarIdDeposito = 0

    If dcfields(14).Visible Then
        If Not IsNumeric(dcfields(14).BoundText) Then
            MsgBox "Indique primero el origen!", vbCritical
            Exit Sub
        Else
            mvarIdDeposito = dcfields(14).BoundText
            mvarIdUbicacion = 0
            Set oRsAux = Aplicacion.Ubicaciones.TraerFiltrado("_PorObra", Array(-1, mvarIdDeposito))

            If oRsAux.RecordCount = 1 Then mvarIdUbicacion = oRsAux.Fields(0).Value
            oRsAux.Close
        End If
    End If
   
    If Data.GetFormat(ccCFText) Then
      
        s = Data.GetData(ccCFText)
        Filas = Split(s, vbCrLf)
      
        Columnas = Split(Filas(0), vbTab)
      
        If UBound(Columnas) < 2 Then
            MsgBox "No hay informacion para copiar", vbCritical
            Exit Sub
        End If
      
        mCostoATomar = BuscarClaveINI("Costo para salida de materiales")

        If mCostoATomar = "" Then mCostoATomar = "CostoReposicion"
      
        If Columnas(1) = "Vale" Then
      
            For iFilas = 1 To UBound(Filas)
                Columnas = Split(Filas(iFilas), vbTab)
         
                Set oRsAux = Aplicacion.ValesSalida.TraerFiltrado("_PorId", Columnas(4))
                Set oRsVal = Aplicacion.TablasGenerales.TraerFiltrado("DetValesSalida", "Res", Columnas(4))
                  
                With origen.Registro
                    .Fields("IdObra").Value = oRsAux.Fields("IdObra").Value
                    .Fields("ValePreimpreso").Value = oRsAux.Fields("NumeroValePreimpreso").Value
                End With
            
                If oRsVal.RecordCount > 0 Then
                    oRsVal.MoveFirst

                    Do While Not oRsVal.EOF

                        If (IsNull(oRsVal.Fields("Cumplido").Value) Or oRsVal.Fields("Cumplido").Value <> "SI") And (IsNull(oRsVal.Fields("Estado").Value) Or oRsVal.Fields("Estado").Value <> "AN") Then
                            Set oRsDet = Aplicacion.TablasGenerales.TraerFiltrado("DetValesSalida", "_TodoMasPendientePorIdDetalle", oRsVal.Fields(0).Value)
                              
                            With origen.DetProduccionFichas.Item(-1)

                                For i = 2 To oRsDet.Fields.Count - 1
                                    For j = 2 To .Registro.Fields.Count - 1

                                        If .Registro.Fields(j).Name = oRsDet.Fields(i).Name Then
                                            .Registro.Fields(j).Value = oRsDet.Fields(i).Value
                                            Exit For
                                        End If

                                    Next
                                Next

                                With .Registro
                                    .Fields("IdDetalleValeSalida").Value = oRsDet.Fields("IdDetalleValeSalida").Value
                                    .Fields("Partida").Value = ""
                                    .Fields("IdObra").Value = oRsAux.Fields("IdObra").Value
                                    .Fields("Cantidad").Value = oRsDet.Fields("Pendiente").Value
                                    .Fields("Adjunto").Value = "NO"

                                    If mvarIdDepositoCentral = mvarIdDeposito Or mvarIdDeposito = 0 Then
                                        .Fields("IdUbicacion").Value = oRsDet.Fields("IdUbicacionStandar").Value
                                    Else

                                        If mvarIdUbicacion <> 0 Then .Fields("IdUbicacion").Value = mvarIdUbicacion
                                    End If

                                    .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                                    .Fields("CotizacionMoneda").Value = 1
                                    .Fields("IdMoneda").Value = mvarIdMonedaPesos
                                    .Fields("Observaciones").Value = oRsDet.Fields("ObservacionesRequerimiento").Value
                                    Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdArticulo").Value)
                                    mNumeroInventario = ""

                                    If oRsAux1.RecordCount > 0 Then
                                        If Right(IIf(IsNull(oRsAux1.Fields("Codigo").Value), "0000", oRsAux1.Fields("Codigo").Value), 4) = "9999" Then
                                            .Fields("CostoUnitario").Value = oRsDet.Fields("CostoRecepcion").Value
                                            .Fields("IdMoneda").Value = oRsDet.Fields("IdMonedaRecepcion").Value
                                            .Fields("CotizacionMoneda").Value = Cotizacion(Date, oRsDet.Fields("IdMonedaRecepcion").Value)
                                        Else

                                            If mCostoATomar = "CostoReposicion" Then
                                                .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoReposicion").Value
                                            Else
                                                .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoPPP").Value
                                            End If
                                        End If

                                        If Not IsNull(oRsDet.Fields("IdEquipoDestino").Value) Then
                                            oRsAux1.Close
                                            Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdEquipoDestino").Value)

                                            If oRsAux1.RecordCount > 0 Then
                                                mNumeroInventario = IIf(IsNull(oRsAux1.Fields("NumeroInventario").Value), "", oRsAux1.Fields("NumeroInventario").Value)
                                            End If
                                        End If
                                    End If

                                    oRsAux1.Close

                                    If Len(mNumeroInventario) > 0 Then
                                        Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorNumeroInventario", mNumeroInventario)

                                        If oRsAux1.RecordCount > 0 Then
                                            .Fields("IdEquipoDestino").Value = oRsAux1.Fields(0).Value
                                        End If

                                        oRsAux1.Close
                                    End If

                                    .Fields("DescargaPorKit").Value = mDescargaPorKit
                                End With

                                .Modificado = True
                            End With

                            oRsDet.Close
                        End If

                        oRsVal.MoveNext
                    Loop

                End If

                oRsAux.Close
            Next

            Set Lista.DataSource = origen.DetProduccionFichas.RegistrosConFormato
         
        ElseIf Columnas(1) = "Vale (Det.)" Then
      
            For iFilas = 1 To UBound(Filas)
                Columnas = Split(Filas(iFilas), vbTab)
            
                Set oRsAux = Aplicacion.ValesSalida.TraerFiltrado("_PorId", Columnas(8))
                Set oRsVal = Aplicacion.TablasGenerales.TraerUno("DetValesSalida", CLng(Columnas(12)))
            
                With origen.Registro
                    .Fields("IdObra").Value = oRsAux.Fields("IdObra").Value
                    .Fields("ValePreimpreso").Value = oRsAux.Fields("NumeroValePreimpreso").Value
                End With
            
                Do While Not oRsVal.EOF
                    Set oRsDet = Aplicacion.TablasGenerales.TraerFiltrado("DetValesSalida", "_TodoMasPendientePorIdDetalle", oRsVal.Fields(0).Value)

                    With origen.DetProduccionFichas.Item(-1)

                        For i = 2 To oRsDet.Fields.Count - 1
                            For j = 2 To .Registro.Fields.Count - 1

                                If .Registro.Fields(j).Name = oRsDet.Fields(i).Name Then
                                    .Registro.Fields(j).Value = oRsDet.Fields(i).Value
                                    Exit For
                                End If

                            Next
                        Next

                        With .Registro
                            .Fields("IdDetalleValeSalida").Value = oRsDet.Fields("IdDetalleValeSalida").Value
                            .Fields("Partida").Value = ""
                            .Fields("IdObra").Value = oRsAux.Fields("IdObra").Value
                            .Fields("Cantidad").Value = oRsDet.Fields("Pendiente").Value
                            .Fields("Adjunto").Value = "NO"

                            If mvarIdDepositoCentral = mvarIdDeposito Or mvarIdDeposito = 0 Then
                                .Fields("IdUbicacion").Value = oRsDet.Fields("IdUbicacionStandar").Value
                            Else

                                If mvarIdUbicacion <> 0 Then .Fields("IdUbicacion").Value = mvarIdUbicacion
                            End If

                            .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                            .Fields("CotizacionMoneda").Value = 1
                            .Fields("IdMoneda").Value = mvarIdMonedaPesos
                            .Fields("Observaciones").Value = oRsDet.Fields("ObservacionesRequerimiento").Value
                            Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdArticulo").Value)
                            mNumeroInventario = ""

                            If oRsAux1.RecordCount > 0 Then
                                If Right(IIf(IsNull(oRsAux1.Fields("Codigo").Value), "0000", oRsAux1.Fields("Codigo").Value), 4) = "9999" Then
                                    .Fields("CostoUnitario").Value = oRsDet.Fields("CostoRecepcion").Value
                                    .Fields("IdMoneda").Value = oRsDet.Fields("IdMonedaRecepcion").Value
                                    .Fields("CotizacionMoneda").Value = Cotizacion(Date, oRsDet.Fields("IdMonedaRecepcion").Value)
                                Else

                                    If mCostoATomar = "CostoReposicion" Then
                                        .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoReposicion").Value
                                    Else
                                        .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoPPP").Value
                                    End If
                                End If

                                If Not IsNull(oRsDet.Fields("IdEquipoDestino").Value) Then
                                    oRsAux1.Close
                                    Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdEquipoDestino").Value)

                                    If oRsAux1.RecordCount > 0 Then
                                        mNumeroInventario = IIf(IsNull(oRsAux1.Fields("NumeroInventario").Value), "", oRsAux1.Fields("NumeroInventario").Value)
                                    End If
                                End If
                            End If

                            oRsAux1.Close

                            If Len(mNumeroInventario) > 0 Then
                                Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_BD_ProntoMantenimientoPorNumeroInventario", mNumeroInventario)

                                If oRsAux1.RecordCount > 0 Then
                                    .Fields("IdEquipoDestino").Value = oRsAux1.Fields(0).Value
                                End If

                                oRsAux1.Close
                            End If

                            .Fields("DescargaPorKit").Value = mDescargaPorKit
                        End With

                        .Modificado = True
                    End With

                    oRsDet.Close
                    oRsVal.MoveNext
                Loop

                oRsAux.Close
            Next

            Set Lista.DataSource = origen.DetProduccionFichas.RegistrosConFormato
         
        ElseIf Columnas(1) = "Codigo material" Then
      
            For iFilas = LBound(Filas) + 1 To UBound(Filas)
                Columnas = VBA.Split(Filas(iFilas), vbTab)

                With origen.DetProduccionFichas.Item(-1)
                    With .Registro
                        .Fields("IdArticulo").Value = Columnas(3)
                        .Fields("IdUnidad").Value = mvarIdUnidadCU
                        .Fields("Partida").Value = ""
                        .Fields("IdObra").Value = origen.Registro.Fields("IdObra").Value
                        .Fields("Cantidad").Value = 1
                        .Fields("Adjunto").Value = "NO"
                        .Fields("IdUbicacion").Value = 1
                        .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                        .Fields("CotizacionMoneda").Value = 1
                        .Fields("IdMoneda").Value = mvarIdMonedaPesos
                        Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorId", Columnas(3))

                        If oRsAux1.RecordCount > 0 Then
                            If mCostoATomar = "CostoReposicion" Then
                                .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoReposicion").Value
                            Else
                                .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoPPP").Value
                            End If
                        End If

                        oRsAux1.Close
                        .Fields("DescargaPorKit").Value = mDescargaPorKit
                    End With

                    .Modificado = True
                End With

            Next
         
            Set Lista.DataSource = origen.DetProduccionFichas.RegistrosConFormato
         
        ElseIf Columnas(1) = "Nro.recep.alm." Then
      
            For iFilas = LBound(Filas) + 1 To UBound(Filas)
                Columnas = VBA.Split(Filas(iFilas), vbTab)
                Set oRsDet = Aplicacion.TablasGenerales.TraerFiltrado("Recepciones", "_DetallesPorIdRecepcion", Columnas(12))

                If oRsDet.RecordCount > 0 Then
                    oRsDet.MoveFirst

                    Do While Not oRsDet.EOF

                        With origen.DetProduccionFichas.Item(-1)
                            With .Registro
                                .Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                                .Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                                .Fields("Partida").Value = oRsDet.Fields("Partida").Value
                                .Fields("IdObra").Value = origen.Registro.Fields("IdObra").Value
                                .Fields("Cantidad").Value = oRsDet.Fields("Cantidad").Value
                                .Fields("Adjunto").Value = "NO"
                                .Fields("IdUbicacion").Value = oRsDet.Fields("IdUbicacion").Value
                                .Fields("CotizacionDolar").Value = Cotizacion(Date, glbIdMonedaDolar)
                                .Fields("CotizacionMoneda").Value = 1
                                .Fields("IdMoneda").Value = mvarIdMonedaPesos
                                Set oRsAux1 = Aplicacion.Articulos.TraerFiltrado("_PorId", oRsDet.Fields("IdArticulo").Value)

                                If oRsAux1.RecordCount > 0 Then
                                    If Right(IIf(IsNull(oRsAux1.Fields("Codigo").Value), "0000", oRsAux1.Fields("Codigo").Value), 4) = "9999" Then
                                        .Fields("CostoUnitario").Value = oRsDet.Fields("CostoUnitario").Value
                                    Else

                                        If mCostoATomar = "CostoReposicion" Then
                                            .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoReposicion").Value
                                        Else
                                            .Fields("CostoUnitario").Value = oRsAux1.Fields("CostoPPP").Value
                                        End If
                                    End If
                                End If

                                oRsAux1.Close

                                If Not IsNull(oRsDet.Fields("IdDetalleRequerimiento").Value) Then
                                    Set oRsAux1 = Aplicacion.Requerimientos.TraerFiltrado("_DatosRequerimiento", oRsDet.Fields("IdDetalleRequerimiento").Value)

                                    If oRsAux1.RecordCount > 0 Then
                                        .Fields("IdFichaTrabajo").Value = oRsAux1.Fields("IdFichaTrabajo").Value
                                    End If

                                    oRsAux1.Close
                                End If

                                .Fields("DescargaPorKit").Value = mDescargaPorKit
                            End With

                            .Modificado = True
                        End With

                        oRsDet.MoveNext
                    Loop

                End If

                oRsDet.Close
            Next
         
            Set Lista.DataSource = origen.DetProduccionFichas.RegistrosConFormato
         
        Else
         
            MsgBox "Informacion invalida!", vbCritical
      
        End If
      
        Set oRsDet = Nothing
        Set oRsVal = Nothing
        Set oRsAux = Nothing
        Set oRsAux1 = Nothing
        Set oVal = Nothing
        Set oAp = Nothing
            
    End If

End Sub

Private Sub Form_OLEDragOver(Data As DataObject, _
                             Effect As Long, _
                             Button As Integer, _
                             Shift As Integer, _
                             X As Single, _
                             y As Single, _
                             State As Integer)

    Dim s As String
    Dim Filas, Columnas
    Dim iFilas As Long, iColumnas As Long
    Dim oL As ListItem

    If State = vbEnter Then
        If Data.GetFormat(ccCFText) Then
            s = Data.GetData(ccCFText)
            Filas = Split(s, vbCrLf)
            Columnas = Split(Filas(LBound(Filas)), vbTab)
            Effect = vbDropEffectCopy
        End If
    End If

End Sub

Private Sub Form_OLEGiveFeedback(Effect As Long, _
                                 DefaultCursors As Boolean)

    If Effect = vbDropEffectNone Then
        DefaultCursors = False
    End If

End Sub

Private Sub Form_Paint()

    ''Degradado Me
   
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    
            Dim oSrv As InterFazMTS.iCompMTS
            Set oSrv = CreateObject("MTSPronto.General")
            If BorroSiCancela Then oSrv.Eliminar "ProduccionFichas", mvarId
            Aplicacion.Tarea ("ProduccionFichas_ReestablecerContador")
            Set oSrv = Nothing
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

Private Sub Lista_KeyUp(KeyCode As Integer, _
                        Shift As Integer)
   
    If KeyCode = vbKeyDelete Then
        MnuDetA_Click 2
    ElseIf KeyCode = vbKeyInsert Then
        MnuDetA_Click 0
    ElseIf KeyCode = vbKeySpace Then
        MnuDetA_Click 1
    End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, _
                          Shift As Integer, _
                          X As Single, _
                          y As Single)

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

Private Sub ListaProcesos_DblClick()

    If ListaProcesos.ListItems.Count = 0 Then
        EditarProcesos -1
    Else
        EditarProcesos ListaProcesos.SelectedItem.Tag
    End If

End Sub

Private Sub ListaProcesos_FinCarga()

    CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaProcesos_KeyUp(KeyCode As Integer, _
                                Shift As Integer)
   
    If KeyCode = vbKeyDelete Then
        MnuDetProcA_Click 2
    ElseIf KeyCode = vbKeyInsert Then
        MnuDetProcA_Click 0
    ElseIf KeyCode = vbKeySpace Then
        MnuDetProcA_Click 1
    End If

End Sub

Private Sub ListaProcesos_MouseUp(Button As Integer, _
                                  Shift As Integer, _
                                  X As Single, _
                                  y As Single)

    If Button = vbRightButton Then
        If ListaProcesos.ListItems.Count = 0 Then
            MnuDetProcA(1).Enabled = False
            MnuDetProcA(2).Enabled = False
            PopupMenu MnuDetProc, , , , MnuDetProcA(0)
        Else
            MnuDetProcA(1).Enabled = True
            MnuDetProcA(2).Enabled = True
            PopupMenu MnuDetProc, , , , MnuDetProcA(1)
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

            'If mvarId > 0 Then
            '   MsgBox "No puede modificar un vale ya registrado!", vbCritical
            '   Exit Sub
            'End If
            With Lista.SelectedItem
                origen.DetProduccionFichas.Item(.Tag).Eliminado = True
                .SmallIcon = "Eliminado"
                .ToolTipText = .SmallIcon
            End With

            mvarNoAnular = True

        Case 3
            AsignarDetalles
    End Select

End Sub

Private Sub MnuDetProcA_Click(Index As Integer)

    Select Case Index

        Case 0
            EditarProcesos -1

        Case 1
            EditarProcesos ListaProcesos.SelectedItem.Tag

        Case 2

            'If mvarId > 0 Then
            '   MsgBox "No puede modificar un vale ya registrado!", vbCritical
            '   Exit Sub
            'End If
            With ListaProcesos.SelectedItem
                origen.DetProduccionFichasProcesos.Item(.Tag).Eliminado = True
                .SmallIcon = "Eliminado"
                .ToolTipText = .SmallIcon
            End With

            mvarNoAnular = True
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
        .IdUsuario = dcfields(1).BoundText
        .Show vbModal, Me
    End With

    If Not oF.Ok Then

        With origen.Registro
            .Fields(dcfields(1).DataField).Value = Null
            '         .Fields("FechaAprobacion").Value = Null
        End With

        mIdAprobo = 0
    Else

        With origen.Registro
            '         .Fields("FechaAprobacion").Value = Now
            mIdAprobo = IIf(IsNull(.Fields("Aprobo").Value), 0, .Fields("Aprobo").Value)
        End With

    End If

    Unload oF
    Set oF = Nothing

End Sub

Public Sub AnularSalida()

    If mvarNoAnular Then
        MsgBox "Para anular una salida, no debe realizar ninguna operacion con los items" & vbCrLf & "previamente a la anulacion, vuelva a llamar la salida y anule directamente", vbInformation
        Exit Sub
    End If
   
    Dim oF As frmAutorizacion
    Dim mOk As Boolean
    Dim mUsuario As String
    Dim mIdAutorizaAnulacion As Integer
    Set oF = New frmAutorizacion

    With oF
        .Empleado = 0
        '.IdFormulario = EnumFormularios.ProduccionFicha
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
    mSeguro = MsgBox("Esta seguro de anular la salida?", vbYesNo, "Anulacion de salida")

    If mSeguro = vbNo Then
        Exit Sub
    End If

    Dim of1 As frmAnulacion
    Dim mMotivoAnulacion As String
    Set of1 = New frmAnulacion

    With of1
        .Caption = "Motivo de anulacion de la salida"
        .text1.Text = "Usuario : " & mUsuario & " - [" & Now & "]"
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
        .Registro.Fields("Anulada").Value = "SI"
        .Registro.Fields("IdUsuarioAnulo").Value = mIdAutorizaAnulacion
        .Registro.Fields("FechaAnulacion").Value = Now
        .Registro.Fields("MotivoAnulacion").Value = mMotivoAnulacion
        .Guardar
    End With
   
    With actL2
        .ListaEditada = "FichaTecnica"
        .AccionRegistro = Modificacion
        .Disparador = origen.Registro.Fields(0).Value
    End With
   
    Unload Me

End Sub

Public Sub AsignarDetalles()

    Dim iFilas As Integer
    Dim mIdUbicacion As Long, mIdEquipoDestino As Long, mIdFichaTrabajo As Long, mIdDetalleObraDestino As Long
    Dim mOk As Boolean
    Dim Filas, Columnas
    Dim oF As frm_Aux
    Dim oDet As DetProduccionFicha
    Dim oDetproc As DetProdFichaProceso
    Dim oRs As ADOR.Recordset
   
    Set oF = New frm_Aux

    With oF
        .Caption = "Asignacion de EQ, OT y UB"
        .text1.Visible = False

        With .Label2(0)
            .Caption = "Ubicacion :"
            .Visible = True
        End With

        With .dcfields(0)
            .TOp = oF.DTFields(0).TOp
            .Left = oF.DTFields(0).Left
            .Width = oF.DTFields(0).Width * 2
            .BoundColumn = "IdUbicacion"
            Set .RowSource = Aplicacion.Ubicaciones.TraerLista
            .Visible = True
        End With

        With .Label1
            .Caption = "Equipo destino :"
            .Visible = True
        End With

        With .dcfields(1)
            .TOp = oF.text1.TOp
            .Left = oF.text1.Left
            .Width = oF.DTFields(0).Width * 2
            .BoundColumn = "IdArticulo"

            If IsNumeric(dcfields(0).BoundText) Then
                Set oRs = Aplicacion.Articulos.TraerFiltrado("_ParaMantenimiento_ParaCombo", Array(0, dcfields(0).BoundText))

                If oRs.RecordCount = 0 Then
                    Set oRs = Aplicacion.Articulos.TraerFiltrado("_ParaMantenimiento_ParaCombo", Array(0, 0))
                End If
            End If

            Set .RowSource = oRs
            Set oRs = Nothing
            .Visible = True
        End With

        With .Label2(1)
            .Caption = "Ord.Trabajo :"
            .Visible = True
        End With

        .Width = .Width * 1.5
        .Show vbModal, Me
        mOk = .Ok
        mIdUbicacion = 0

        If IsNumeric(.dcfields(0).BoundText) Then mIdUbicacion = .dcfields(0).BoundText
        mIdEquipoDestino = 0

        If IsNumeric(.dcfields(1).BoundText) Then mIdEquipoDestino = .dcfields(1).BoundText
        mIdDetalleObraDestino = 0
        Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorIdConDatos", mIdEquipoDestino)

        If oRs.RecordCount > 0 Then
            mIdDetalleObraDestino = IIf(IsNull(oRs.Fields("IdDetalleObraDestino").Value), 0, oRs.Fields("IdDetalleObraDestino").Value)
        End If

        oRs.Close
        mIdFichaTrabajo = 0

        If IsNumeric(.dcfields(2).BoundText) Then mIdFichaTrabajo = .dcfields(2).BoundText
    End With

    Unload oF
    Set oF = Nothing
   
    If Not mOk Then Exit Sub
   
    Me.MousePointer = vbHourglass

    DoEvents
   
    Filas = VBA.Split(Lista.GetString, vbCrLf)

    For iFilas = LBound(Filas) + 1 To UBound(Filas)
        Columnas = VBA.Split(Filas(iFilas), vbTab)
        Set oDet = origen.DetProduccionFichas.Item(Columnas(0))

        With oDet
            With .Registro

                If mIdUbicacion > 0 Then .Fields("IdUbicacion").Value = mIdUbicacion
                If mIdEquipoDestino > 0 Then .Fields("IdEquipoDestino").Value = mIdEquipoDestino
                If mIdFichaTrabajo > 0 Then .Fields("IdFichaTrabajo").Value = mIdFichaTrabajo
                If mIdDetalleObraDestino > 0 Then .Fields("IdDetalleObraDestino").Value = mIdDetalleObraDestino
            End With

            .Modificado = True
        End With

        Set oDet = Nothing
    Next

    Set Lista.DataSource = origen.DetProduccionFichas.RegistrosConFormato

    Me.MousePointer = vbDefault

    DoEvents

End Sub

Private Sub txtBusca_GotFocus()

    With txtBusca
        .SelStart = 0
        .SelLength = Len(.Text)
    End With

End Sub

Sub RecalcularPorcentajes()
    Dim i As Long
    Dim oL As ListItem

    With Lista

        For i = 1 To .ListItems.Count
            Set oL = .ListItems(i)

            If Val(txtCantidad) <> 0 Then
                oL.SubItems(ACOL_PORCEN) = Int(100 / SumaCantidades * Val(oL.SubItems(ACOL_CANT))) & "%"
            End If

        Next i

    End With

End Sub

Private Sub txtBusca_KeyPress(KeyAscii As Integer)

    If KeyAscii = Asc(vbCr) Then
        If KeyAscii = 13 Then
            If Len(Trim(txtBusca.Text)) <> 0 Then
                Set dcfields(1).RowSource = Aplicacion.Articulos.TraerFiltrado("_Busca", txtBusca.Text)
            Else
                Set dcfields(1).RowSource = Aplicacion.Articulos.TraerLista
            End If
        End If

        dcfields(1).SetFocus
        SendKeys "%{DOWN}"
    End If

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
        Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo.Text)

        If oRs.RecordCount > 0 Then

            With origen.Registro
                .Fields("IdArticuloAsociado").Value = oRs.Fields(0).Value

                If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                    .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                Else
                    '.Fields("IdUnidad").Value = mvarIdUnidadCU
                End If

            End With

            'MostrarStockActual
        Else
            MsgBox "Codigo de material incorrecto", vbExclamation
            Cancel = True
            txtCodigoArticulo.Text = ""
        End If

        oRs.Close
        Set oRs = Nothing
    End If
   
End Sub

