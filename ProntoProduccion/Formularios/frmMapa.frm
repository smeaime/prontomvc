VERSION 5.00
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.3#0"; "Controles1013.ocx"
Begin VB.Form frmMapa 
   Caption         =   "Mapa"
   ClientHeight    =   9435
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   12360
   LinkTopic       =   "Form1"
   ScaleHeight     =   9435
   ScaleWidth      =   12360
   Begin VB.CommandButton cmdActualizar 
      Caption         =   "actualizar"
      Height          =   855
      Left            =   360
      TabIndex        =   13
      Top             =   6120
      Width           =   1335
   End
   Begin VB.CommandButton cmdNuevaOP 
      Caption         =   "nueva OP"
      Height          =   375
      Left            =   7560
      TabIndex        =   11
      Top             =   120
      Width           =   1335
   End
   Begin VB.CommandButton cmdNuevoParte 
      Caption         =   "nuevo parte"
      Height          =   615
      Left            =   7200
      TabIndex        =   8
      Top             =   6360
      Width           =   1335
   End
   Begin Controles1013.DbListView listaOPs 
      Height          =   1815
      Left            =   5760
      TabIndex        =   0
      Top             =   480
      Width           =   4560
      _ExtentX        =   8043
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
      MouseIcon       =   "frmMapa.frx":0000
      OLEDragMode     =   1
      PictureAlignment=   5
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView listaPartes 
      Height          =   2055
      Left            =   2640
      TabIndex        =   1
      Top             =   7080
      Width           =   9435
      _ExtentX        =   16642
      _ExtentY        =   3625
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmMapa.frx":001C
      OLEDragMode     =   1
      PictureAlignment=   5
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView listaProcesosPendientes 
      Height          =   1695
      Left            =   5040
      TabIndex        =   9
      Top             =   3600
      Width           =   4905
      _ExtentX        =   8652
      _ExtentY        =   2990
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmMapa.frx":0038
      OLEDragMode     =   1
      PictureAlignment=   5
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView listaOCsinOP 
      Height          =   2535
      Left            =   240
      TabIndex        =   10
      Top             =   3120
      Width           =   3705
      _ExtentX        =   6535
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
      MouseIcon       =   "frmMapa.frx":0054
      OLEDragMode     =   1
      PictureAlignment=   5
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView listaFichas 
      Height          =   1215
      Left            =   240
      TabIndex        =   12
      Top             =   480
      Width           =   3315
      _ExtentX        =   5847
      _ExtentY        =   2143
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmMapa.frx":0070
      OLEDragMode     =   1
      PictureAlignment=   5
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Line Line4 
      X1              =   6720
      X2              =   6720
      Y1              =   5520
      Y2              =   6360
   End
   Begin VB.Line Line3 
      X1              =   6960
      X2              =   6960
      Y1              =   2400
      Y2              =   2760
   End
   Begin VB.Label lblProcesosY 
      Caption         =   "Procesos y Consumos de articulos pendientes"
      Height          =   495
      Left            =   5520
      TabIndex        =   7
      Top             =   3000
      Width           =   2295
   End
   Begin VB.Line Line2 
      X1              =   3120
      X2              =   3600
      Y1              =   2760
      Y2              =   2280
   End
   Begin VB.Line Line1 
      X1              =   3240
      X2              =   3960
      Y1              =   840
      Y2              =   1200
   End
   Begin VB.Label lblPartesAbiertos 
      Caption         =   "Partes abiertos"
      Height          =   255
      Left            =   2640
      TabIndex        =   6
      Top             =   6720
      Width           =   1815
   End
   Begin VB.Label lblProduccionesActivas 
      Caption         =   "Producciones activas"
      Height          =   255
      Left            =   5760
      TabIndex        =   5
      Top             =   120
      Width           =   1815
   End
   Begin VB.Label lbl 
      Caption         =   "---------------------->"
      Height          =   495
      Left            =   4080
      TabIndex        =   4
      Top             =   1560
      Width           =   1935
   End
   Begin VB.Label lblOrdenesDe 
      Caption         =   "items de Ordenes de compra pendientes"
      Height          =   495
      Left            =   480
      TabIndex        =   3
      Top             =   2400
      Width           =   1935
   End
   Begin VB.Label lblFichasFrecuentes 
      Caption         =   "Fichas frecuentes"
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   240
      Width           =   1815
   End
End
Attribute VB_Name = "frmMapa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_GotFocus()
    RefrescarConsultas
End Sub


Private Sub cmdNuevaOp_Click()
   Dim oF As Form

   Set oF = New frmProduccionOrden
   
      With oF
                 .NivelAcceso = frmPrincipal.ControlAccesoNivel("OrdendeProduccion")
        .OpcionesAcceso = frmPrincipal.ControlAccesoOpciones("OrdendeProduccion")
      .Id = -1
      If Not glbPermitirModificacionTabulados Then
         If ExisteControlEnFormulario(oF, "lblTabIndex") Then
            .lblTabIndex.Visible = False
         End If
      End If
      Me.MousePointer = vbDefault
      .Show , Me
   End With

Salida:

   Set oF = Nothing
   
   Me.MousePointer = vbDefault
End Sub

Private Sub cmdNuevoParte_Click()
   Dim oF As Form

             Set oF = New frmProduccionParte
   With oF
           .NivelAcceso = frmPrincipal.ControlAccesoNivel("PartedeProduccion")
        .OpcionesAcceso = frmPrincipal.ControlAccesoOpciones("PartedeProduccion")
      .Id = -1
      If Not glbPermitirModificacionTabulados Then
         If ExisteControlEnFormulario(oF, "lblTabIndex") Then
            .lblTabIndex.Visible = False
         End If
      End If
      If oF.habilitado Then
        Me.MousePointer = vbDefault
        .Show , Me
        End If
   End With

Salida:

   Set oF = Nothing
   
   Me.MousePointer = vbDefault
End Sub


Sub RefrescarConsultas()
    Dim Desde, Hasta

    Desde = Now - 30
    Hasta = Now
    
    Dim oRs As Recordset
    
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    
    Set oRs = AplicacionProd.ProduccionPartes.TraerFiltrado("Fecha", Array(Desde, Hasta))

    oRs.Filter = "[Estado]='Abierto'"

    listaPartes.ListItems.Clear
    'If Not mOrdena Then Lista.Sorted = False
    If Not IsEmpty(oRs) And Not oRs Is Nothing Then
       Set listaPartes.DataSource = oRs
       listaPartes.Refresh
    End If
    listaPartes.FullRowSelect = True

    
    
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
   
    Set oRs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("Fecha", Array(Desde, Hasta))
    
    listaOPs.ListItems.Clear
    'If Not mOrdena Then Lista.Sorted = False
    If Not IsEmpty(oRs) And Not oRs Is Nothing Then
       Set listaOPs.DataSource = oRs
       listaOPs.Refresh
    End If
    listaOPs.FullRowSelect = True
    

    
    
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
   
      'Filtrar:  que el botón OCs muestre las OCs que corresponden para el Material o Terminado a evaluar, idem para las OPs.
    'Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_ItemsPendientesDeProducirModuloProduccion", Array(Val(FiltroArticulo), Val(FiltroMaterial)))
    Set oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_ItemsPendientesDeProducirModuloProduccion", Array(-1, -1))
       
    listaOCsinOP.ListItems.Clear
    'If Not mOrdena Then Lista.Sorted = False
    If Not IsEmpty(oRs) And Not oRs Is Nothing Then
       Set listaOCsinOP.DataSource = oRs
       listaOCsinOP.Refresh
    End If
    listaOCsinOP.FullRowSelect = True

    
    
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
   
    Set oRs = TraerRecordsetConLosProcesosPendientes(AplicacionProd)
    
    listaProcesosPendientes.ListItems.Clear
    'If Not mOrdena Then Lista.Sorted = False
    If Not IsEmpty(oRs) And Not oRs Is Nothing Then
       Set listaProcesosPendientes.DataSource = oRs
       listaProcesosPendientes.Refresh
    End If
    listaProcesosPendientes.FullRowSelect = True

    
    
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
   
    Set oRs = AplicacionProd.ProduccionFichas.TraerTodos
    
    listaFichas.ListItems.Clear
    'If Not mOrdena Then Lista.Sorted = False
    If Not IsEmpty(oRs) And Not oRs Is Nothing Then
       Set listaFichas.DataSource = oRs
       listaFichas.Refresh
    End If
    listaFichas.FullRowSelect = True



End Sub

Private Sub Form_Load()
    RefrescarConsultas
End Sub

Private Sub listaOPs_DblClick()
    Dim oF As Form

    If listaOPs.SelectedItem Is Nothing Then Exit Sub
    If Len(Trim(listaOPs.SelectedItem.Tag)) = 0 Then Exit Sub

   
    Set oF = New frmProduccionOrden

    With oF
      
                       .NivelAcceso = frmPrincipal.ControlAccesoNivel("OrdendeProduccion")
        .OpcionesAcceso = frmPrincipal.ControlAccesoOpciones("OrdendeProduccion")
      .Id = listaOPs.SelectedItem.Tag
      If Not glbPermitirModificacionTabulados Then
         If ExisteControlEnFormulario(oF, "lblTabIndex") Then
            .lblTabIndex.Visible = False
         End If
      End If
      ReemplazarEtiquetas oF
      Me.MousePointer = vbDefault
      .Show , Me
   End With
   
End Sub


Private Sub listaPartes_DblClick()



    If Not listaPartes.SelectedItem Is Nothing Then
    If Len(Trim(listaPartes.SelectedItem.Tag)) <> 0 Then
    Dim oF As Form

    Set oF = New frmProduccionParte
    
    With oF
        .NivelAcceso = frmPrincipal.ControlAccesoNivel("PartedeProduccion")
        .OpcionesAcceso = frmPrincipal.ControlAccesoOpciones("PartedeProduccion")
            .Id = listaPartes.SelectedItem.Tag
      
      If Not glbPermitirModificacionTabulados Then
         If ExisteControlEnFormulario(oF, "lblTabIndex") Then
            .lblTabIndex.Visible = False
         End If
      End If
      
      
      If oF.habilitado Then
        Me.MousePointer = vbDefault
        .Show , Me
        End If
    End With

Salida:

   Set oF = Nothing
   
   Me.MousePointer = vbDefault
   End If
   End If

End Sub
