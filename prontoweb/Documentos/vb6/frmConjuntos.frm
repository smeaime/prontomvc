VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmConjuntos 
   Caption         =   "Conjuntos"
   ClientHeight    =   6855
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11640
   Icon            =   "frmConjuntos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6855
   ScaleWidth      =   11640
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   4
      Left            =   10440
      Locked          =   -1  'True
      TabIndex        =   24
      Top             =   6210
      Width           =   1095
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   3
      Left            =   10440
      Locked          =   -1  'True
      TabIndex        =   22
      Top             =   5895
      Width           =   1095
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   2
      Left            =   7245
      Locked          =   -1  'True
      TabIndex        =   20
      Top             =   6210
      Width           =   870
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Eliminar"
      Height          =   420
      Index           =   2
      Left            =   2340
      TabIndex        =   19
      Top             =   5985
      Width           =   1065
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   1
      Left            =   5760
      Locked          =   -1  'True
      TabIndex        =   17
      Top             =   6210
      Width           =   1230
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   0
      Left            =   5760
      Locked          =   -1  'True
      TabIndex        =   15
      Top             =   5895
      Width           =   1230
   End
   Begin VB.TextBox txtCodigoConjunto 
      DataField       =   "CodigoConjunto"
      Height          =   285
      Left            =   9135
      TabIndex        =   12
      Top             =   855
      Width           =   1410
   End
   Begin VB.TextBox txtRealizo 
      Enabled         =   0   'False
      Height          =   285
      Left            =   9135
      TabIndex        =   11
      Top             =   1215
      Width           =   2400
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   90
      TabIndex        =   2
      Top             =   5985
      Width           =   1065
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   420
      Index           =   1
      Left            =   1215
      TabIndex        =   1
      Top             =   5985
      Width           =   1065
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1050
      Left            =   1845
      TabIndex        =   0
      Top             =   900
      Width           =   6405
      _ExtentX        =   11298
      _ExtentY        =   1852
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmConjuntos.frx":076A
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   3
      Top             =   6570
      Width           =   11640
      _ExtentX        =   20532
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaRegistro"
      Height          =   330
      Index           =   0
      Left            =   9135
      TabIndex        =   4
      Top             =   450
      Width           =   1425
      _ExtentX        =   2514
      _ExtentY        =   582
      _Version        =   393216
      Enabled         =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   60489729
      CurrentDate     =   36377
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3885
      Left            =   45
      TabIndex        =   5
      Top             =   1980
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
      MouseIcon       =   "frmConjuntos.frx":07EC
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdArticulo"
      Height          =   315
      Index           =   2
      Left            =   1890
      TabIndex        =   9
      Tag             =   "Articulos"
      Top             =   495
      Width           =   6360
      _ExtentX        =   11218
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   10215
      Top             =   1620
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConjuntos.frx":0808
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConjuntos.frx":091A
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConjuntos.frx":0A2C
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConjuntos.frx":0B3E
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConjuntos.frx":0C50
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConjuntos.frx":0D62
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConjuntos.frx":0E74
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   14
      Top             =   0
      Width           =   11640
      _ExtentX        =   20532
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageKey        =   "Print"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel"
            Object.ToolTipText     =   "Salida a Excel"
            ImageKey        =   "Excel"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageKey        =   "Find"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Ayuda"
            Object.ToolTipText     =   "Ayuda"
            ImageKey        =   "Help"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   9585
      Top             =   1620
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
            Picture         =   "frmConjuntos.frx":12C6
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConjuntos.frx":13D8
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConjuntos.frx":182A
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConjuntos.frx":1C7C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Costo Rep.$ (Cot.):"
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
      Index           =   9
      Left            =   8370
      TabIndex        =   25
      Top             =   6255
      Width           =   1995
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Costo Rep.u$s :"
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
      Index           =   8
      Left            =   8370
      TabIndex        =   23
      Top             =   5940
      Width           =   1995
   End
   Begin VB.Label lblLabels 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      Caption         =   "Cotiz.u$s"
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
      Index           =   7
      Left            =   7155
      TabIndex        =   21
      Top             =   5940
      Width           =   1050
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Total costo Rep. :"
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
      Index           =   3
      Left            =   3825
      TabIndex        =   18
      Top             =   6255
      Width           =   1860
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Total costo PPP :"
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
      Index           =   6
      Left            =   3825
      TabIndex        =   16
      Top             =   5940
      Width           =   1860
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Codigo : "
      Height          =   240
      Index           =   1
      Left            =   8370
      TabIndex        =   13
      Top             =   855
      Width           =   720
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Height          =   240
      Index           =   2
      Left            =   225
      TabIndex        =   10
      Top             =   540
      Width           =   1530
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   8370
      TabIndex        =   8
      Top             =   495
      Width           =   705
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   240
      Index           =   0
      Left            =   225
      TabIndex        =   7
      Top             =   945
      Width           =   1530
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Realizo : "
      Height          =   240
      Index           =   5
      Left            =   8370
      TabIndex        =   6
      Top             =   1215
      Width           =   705
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
Attribute VB_Name = "frmConjuntos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Conjunto
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mIdAprobo As Long
Private mvarSubTituloExcel As String
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

   Dim oF As frmDetConjuntos
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim mCostoPPP As Double, mCostoRep As Double, mCantidad As Double
   
   Set oF = New frmDetConjuntos
   
   With oF
      Set .Conjunto = origen
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = Lista.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = Lista.SelectedItem
         End If
         Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", oF.DataCombo1(1).BoundText)
         mCostoPPP = IIf(IsNull(oRs.Fields("CostoPPP").Value), 0, oRs.Fields("CostoPPP").Value)
         mCostoRep = IIf(IsNull(oRs.Fields("CostoReposicion").Value), 0, oRs.Fields("CostoReposicion").Value)
         mCantidad = Val(oF.txtCantidad.Text)
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtCodigoArticulo.Text
            .SubItems(1) = "" & oF.DataCombo1(1).Text
            .SubItems(2) = "" & Format(mCantidad, "#,##0.000")
            .SubItems(3) = "" & oF.txtCantidad1.Text
            .SubItems(4) = "" & oF.txtCantidad2.Text
            .SubItems(5) = "" & oF.DataCombo1(0).Text
            .SubItems(6) = "" & Format(mCostoPPP, "#,##0.00")
            .SubItems(7) = "" & Format(mCostoPPP * mCantidad, "#,##0.00")
            .SubItems(8) = "" & Format(mCostoRep, "#,##0.00")
            .SubItems(9) = "" & Format(mCostoPPP * mCantidad, "#,##0.00")
            .SubItems(10) = "" & mCostoPPP * mCantidad
            .SubItems(11) = "" & mCostoRep * mCantidad
         End With
         oRs.Close
      End If
   End With
   
   Unload oF
   Set oF = Nothing
   
   Set oRs = Nothing
   
   CalcularTotales
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
      
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar un conjunto sin detalles"
            Exit Sub
         End If
         
         If Not IsNumeric(dcfields(2).BoundText) Then
            MsgBox "No definio el articulo o kit"
            Exit Sub
         End If
         
         Dim dtp As DTPicker
         Dim dc As DataCombo
         Dim est As EnumAcciones
         Dim mNum As Long
         Dim oPar As ComPronto.Parametro
         
         With origen.Registro
         
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
         
            For Each dc In dcfields
               If dc.Enabled Then
                  If Not IsNumeric(dc.BoundText) Then
                     MsgBox "Falta completar el campo " & IIf(mId(dc.DataField, 1, 2) = "Id", mId(dc.DataField, 3, 20), dc.DataField), vbCritical
                     Exit Sub
                  Else
                     .Fields(dc.DataField).Value = dc.BoundText
                  End If
               End If
            Next
         
            .Fields("Observaciones").Value = rchObservaciones.Text
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
         
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "Conjuntos"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
         
         Unload Me

      Case 1
      
         Unload Me

      Case 2
      
         Dim mvarSeguro As Integer
         mvarSeguro = MsgBox("Esta seguro de eliminar el conjunto?", vbYesNo, "Eliminacion del Conjunto")
         If mvarSeguro = vbNo Then
            Exit Sub
         End If
         
         Dim mOk As Boolean
         Dim oF As frmAutorizacion
         Set oF = New frmAutorizacion
         With oF
            .Empleado = 0
            .Administradores = True
            .Show vbModal, Me
            mOk = .Ok
         End With
         Unload oF
         Set oF = Nothing
         If Not mOk Then
            MsgBox "Eliminacion cancelada", vbExclamation
            Exit Sub
         End If

         Aplicacion.Tarea "Conjuntos_Eliminar", Array(mvarId)
         Aplicacion.Tarea "Articulos_RecalcularStock"
         
         With actL2
            .ListaEditada = "ConjuntosTodos,ConjuntosFinales,ConjuntosDependientes"
            .AccionRegistro = EnumAcciones.baja
            .Disparador = mvarId
         End With
         
         Unload Me

   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   Dim ListaVacia As Boolean
   Dim i As Integer, mCantidadFirmas As Integer
   
   mvarId = vNewValue
   ListaVacia = False
   
   Set oAp = Aplicacion
   Set origen = oAp.Conjuntos.Item(vNewValue)
   
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetConjuntos.TraerMascara
                     ListaVacia = True
                  Else
                     Set oRs = origen.DetConjuntos.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia = False
                     Else
                        Set oControl.DataSource = origen.DetConjuntos.TraerMascara
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
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
   
   If mvarId = -1 Then
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      With origen.Registro
         .Fields("FechaRegistro").Value = Date
         .Fields("IdRealizo").Value = glbIdUsuario
      End With
      mIdAprobo = 0
   Else
      With origen.Registro
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
   End If
   
   If Not IsNull(origen.Registro.Fields("IdRealizo").Value) Then
      txtRealizo.Text = oAp.Empleados.Item(origen.Registro.Fields("IdRealizo").Value).Registro.Fields("Nombre").Value
   End If
   
   If ListaVacia Then
      Lista.ListItems.Clear
   End If
   
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   CalcularTotales
   
End Property

Private Sub cmdImpre_Click()

   Dim oW As Word.Application
   
   Set oW = CreateObject("Word.Application")
   
   Set oW = Nothing

End Sub

Private Sub dcfields_Change(Index As Integer)

   If IsNumeric(dcfields(Index).BoundText) Then
      If IsNull(origen.Registro.Fields(dcfields(Index).DataField).Value) Or origen.Registro.Fields(dcfields(Index).DataField).Value <> dcfields(Index).BoundText Then
         origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
      End If
   End If
   
End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
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
   Dim iFilas As Long
   Dim iColumnas As Long
   Dim oL As ListItem

   If Data.GetFormat(ccCFText) Then
      s = Data.GetData(ccCFText)
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      If Not InStr(1, Columnas(LBound(Columnas) + 1), "Codigo") <> 0 Then
         MsgBox "Sólo puede arrastrar aqui elementos de la lista de Productos"
         Exit Sub
      End If
      For iFilas = LBound(Filas) + 1 To UBound(Filas)
         Columnas = Split(Filas(iFilas), vbTab)
         Set oL = Lista.ListItems.Add()
         With origen.DetConjuntos.Item(-1)
            .Registro.Fields("IdArticulo").Value = Columnas(3)
            oL.Tag = .Id
            oL.Text = Columnas(1)
            oL.SubItems(1) = Columnas(2)
            oL.SubItems(2) = "0"
            oL.SubItems(3) = "0"
            oL.SubItems(4) = "0"
            oL.SubItems(5) = ""
            oL.SmallIcon = "Nuevo"
            .Modificado = True
         End With
      Next
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
         If Columnas(LBound(Columnas) + 1) <> "Descripcion" Then
            Effect = vbDropEffectNone
         Else
            Effect = vbDropEffectCopy
         End If
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
         With Lista.SelectedItem
            origen.DetConjuntos.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         CalcularTotales
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

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Key
      
      Case "Imprimir"
         
         mvarSubTituloExcel = "|Conjunto : " & dcfields(2).Text & " - Codigo : " & txtCodigoConjunto.Text & " - Fecha de creacion : " & DTFields(0).Value
         ImprimirConExcel Lista, Me.Caption & mvarSubTituloExcel
      
      Case "Buscar"
         
         FiltradoLista Lista
'         StatusBar1.Panels(2).Text = " " & Lista.ListItems.Count & " elementos en la lista"

      Case "Excel"
         
         mvarSubTituloExcel = "|Conjunto : " & dcfields(2).Text & " - Codigo : " & txtCodigoConjunto.Text & " - Fecha de creacion : " & DTFields(0).Value
         ExportarAExcel Lista, Me.Caption & mvarSubTituloExcel
      
   End Select

End Sub

Public Sub CalcularTotales()

   Dim oL As ListItem
   Dim mTotalPPP As Double, mTotalRep As Double, mTotalRepDolar As Double
   
   mTotalPPP = 0
   mTotalRep = 0
   mTotalRepDolar = 0
   For Each oL In Lista.ListItems
      If Not oL.SmallIcon = "Eliminado" Then
         mTotalPPP = mTotalPPP + Val(oL.SubItems(10))
         mTotalRep = mTotalRep + Val(oL.SubItems(11))
         mTotalRepDolar = mTotalRepDolar + Val(oL.SubItems(14))
      End If
   Next
   
   txtTotal(0).Text = Format(mTotalPPP, "#,##0.00")
   txtTotal(1).Text = Format(mTotalRep, "#,##0.00")
   txtTotal(2).Text = Cotizacion(Date, glbIdMonedaDolar)
   txtTotal(3).Text = Format(mTotalRepDolar, "#,##0.00")
   txtTotal(4).Text = Format(mTotalRepDolar * Val(txtTotal(2).Text), "#,##0.00")

End Sub
