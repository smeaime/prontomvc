VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmModificacionActivoFijo 
   Caption         =   "Modificacion al activo fijo"
   ClientHeight    =   6255
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11850
   Icon            =   "frmModificacionActivoFijo.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6255
   ScaleWidth      =   11850
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtEstado 
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
      Left            =   6120
      Locked          =   -1  'True
      TabIndex        =   38
      Top             =   810
      Width           =   1950
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Calcular valor actualizado en planilla ?"
      Height          =   240
      Index           =   0
      Left            =   8280
      TabIndex        =   36
      Top             =   1215
      Width           =   3525
   End
   Begin VB.TextBox txtUbicacion 
      DataField       =   "UbicacionActivoFijo"
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
      Left            =   3150
      TabIndex        =   35
      Top             =   1170
      Width           =   2220
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      DataField       =   "IdRubro"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
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
      Height          =   315
      Left            =   4050
      TabIndex        =   32
      Top             =   5805
      Visible         =   0   'False
      Width           =   1635
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Calcular amortizacion en planilla ?"
      Height          =   240
      Index           =   3
      Left            =   8280
      TabIndex        =   31
      Top             =   1575
      Width           =   3525
   End
   Begin VB.TextBox txtUltimoRevaluoContable 
      Alignment       =   1  'Right Justify
      DataField       =   "UltimoRevaluoContable"
      Height          =   300
      Left            =   10350
      TabIndex        =   26
      Top             =   450
      Width           =   1455
   End
   Begin VB.TextBox txtVidaUtilContableRestante 
      Alignment       =   1  'Right Justify
      DataField       =   "VidaUtilContableRestante"
      Height          =   300
      Left            =   7335
      TabIndex        =   22
      Top             =   1620
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.TextBox txtValorOrigenContable 
      Alignment       =   1  'Right Justify
      DataField       =   "ValorOrigenContable"
      Height          =   300
      Left            =   2205
      TabIndex        =   20
      Top             =   1980
      Width           =   1725
   End
   Begin VB.TextBox txtVidaUtilContable 
      Alignment       =   1  'Right Justify
      DataField       =   "VidaUtilContable"
      Height          =   300
      Left            =   2430
      TabIndex        =   18
      Top             =   1620
      Width           =   555
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Amortiza :"
      Height          =   240
      Index           =   2
      Left            =   90
      TabIndex        =   13
      Top             =   2385
      Width           =   1095
   End
   Begin VB.Frame Frame2 
      Caption         =   "Estado actual :"
      Height          =   1005
      Left            =   45
      TabIndex        =   9
      Top             =   495
      Width           =   1320
      Begin VB.OptionButton Option2 
         Caption         =   "Inactivo"
         Height          =   195
         Left            =   135
         TabIndex        =   11
         Top             =   675
         Width           =   915
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Activo"
         Height          =   195
         Left            =   135
         TabIndex        =   10
         Top             =   360
         Width           =   870
      End
   End
   Begin VB.TextBox txtNumeroActivoFijo 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroActivoFijo"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   3150
      TabIndex        =   6
      Top             =   450
      Width           =   1320
   End
   Begin VB.TextBox txtArticulo 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
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
      Height          =   315
      Left            =   3150
      TabIndex        =   5
      Top             =   90
      Width           =   8655
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   405
      Index           =   1
      Left            =   1665
      TabIndex        =   2
      Top             =   5760
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   90
      TabIndex        =   1
      Top             =   5760
      Width           =   1485
   End
   Begin VB.TextBox txtCodigoArticulo 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
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
      Height          =   315
      Left            =   1440
      TabIndex        =   0
      Top             =   90
      Width           =   1635
   End
   Begin Controles1013.DbListView Lista 
      Height          =   2940
      Left            =   45
      TabIndex        =   3
      Top             =   2745
      Width           =   11805
      _ExtentX        =   20823
      _ExtentY        =   5186
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmModificacionActivoFijo.frx":076A
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   6660
      Top             =   5715
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
            Picture         =   "frmModificacionActivoFijo.frx":0786
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmModificacionActivoFijo.frx":0898
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmModificacionActivoFijo.frx":09AA
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmModificacionActivoFijo.frx":0ABC
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmModificacionActivoFijo.frx":0BCE
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmModificacionActivoFijo.frx":0CE0
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmModificacionActivoFijo.frx":0DF2
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   7245
      Top             =   5715
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
            Picture         =   "frmModificacionActivoFijo.frx":1244
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmModificacionActivoFijo.frx":1356
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmModificacionActivoFijo.frx":17A8
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmModificacionActivoFijo.frx":1BFA
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdGrupoActivoFijo"
      Height          =   315
      Index           =   0
      Left            =   3150
      TabIndex        =   7
      Tag             =   "GruposActivosFijos"
      Top             =   810
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdGrupoActivoFijo"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaCompra"
      Height          =   285
      Index           =   0
      Left            =   6750
      TabIndex        =   14
      Top             =   450
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   503
      _Version        =   393216
      Format          =   64421889
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdCuentaAmortizacion"
      Height          =   315
      Index           =   1
      Left            =   4230
      TabIndex        =   16
      Tag             =   "Cuentas"
      Top             =   2340
      Width           =   3840
      _ExtentX        =   6773
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaPrimeraAmortizacionContable"
      Height          =   285
      Index           =   2
      Left            =   6750
      TabIndex        =   24
      Top             =   1980
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   503
      _Version        =   393216
      Format          =   64421889
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "Idsector"
      Height          =   315
      Index           =   3
      Left            =   6120
      TabIndex        =   29
      Tag             =   "Sectores"
      Top             =   1170
      Width           =   1995
      _ExtentX        =   3519
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "Idsector"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaUltimoRevaluo"
      Height          =   285
      Index           =   3
      Left            =   10350
      TabIndex        =   33
      Top             =   810
      Width           =   1470
      _ExtentX        =   2593
      _ExtentY        =   503
      _Version        =   393216
      Format          =   64421889
      CurrentDate     =   36377
   End
   Begin VB.Label lblData 
      Caption         =   "Estado :"
      Height          =   240
      Index           =   4
      Left            =   5445
      TabIndex        =   37
      Top             =   855
      Width           =   600
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de ultimo revaluo :"
      Height          =   240
      Index           =   0
      Left            =   8280
      TabIndex        =   34
      Top             =   855
      Width           =   1950
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   3
      X1              =   8145
      X2              =   8145
      Y1              =   450
      Y2              =   2655
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   2
      X1              =   45
      X2              =   8145
      Y1              =   1530
      Y2              =   1530
   End
   Begin VB.Label lblData 
      Caption         =   "Sector :"
      Height          =   240
      Index           =   3
      Left            =   5445
      TabIndex        =   30
      Top             =   1215
      Width           =   600
   End
   Begin VB.Label lblData 
      Caption         =   "Ubicacion actual :"
      Height          =   195
      Index           =   2
      Left            =   1440
      TabIndex        =   28
      Top             =   1215
      Width           =   1635
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ultimo revaluo contable :"
      Height          =   240
      Index           =   11
      Left            =   8280
      TabIndex        =   27
      Top             =   495
      Width           =   1950
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha 1ra. amortizacion contable :"
      Height          =   240
      Index           =   10
      Left            =   4050
      TabIndex        =   25
      Top             =   2025
      Width           =   2625
   End
   Begin VB.Label lblLabels 
      Caption         =   "Vida util conable restante  ( en meses ) :"
      Height          =   240
      Index           =   8
      Left            =   4050
      TabIndex        =   23
      Top             =   1665
      Visible         =   0   'False
      Width           =   3240
   End
   Begin VB.Label lblLabels 
      Caption         =   "Valor de origen contable :"
      Height          =   240
      Index           =   5
      Left            =   90
      TabIndex        =   21
      Top             =   2025
      Width           =   2070
   End
   Begin VB.Label lblLabels 
      Caption         =   "Vida util contable ( en meses ) :"
      Height          =   240
      Index           =   2
      Left            =   90
      TabIndex        =   19
      Top             =   1665
      Width           =   2295
   End
   Begin VB.Label lblData 
      Caption         =   "Cuenta contable para amortizaciones :"
      Height          =   240
      Index           =   1
      Left            =   1305
      TabIndex        =   17
      Top             =   2385
      Width           =   2880
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de compra del bien :"
      Height          =   240
      Index           =   4
      Left            =   4590
      TabIndex        =   15
      Top             =   495
      Width           =   2085
   End
   Begin VB.Label lblData 
      Caption         =   "Grupo activo fijo :"
      Height          =   240
      Index           =   0
      Left            =   1440
      TabIndex        =   12
      Top             =   855
      Width           =   1635
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de activo fijo :"
      Height          =   240
      Index           =   6
      Left            =   1440
      TabIndex        =   8
      Top             =   495
      Width           =   1635
   End
   Begin VB.Label Label1 
      Caption         =   "Material :"
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
      Left            =   90
      TabIndex        =   4
      Top             =   135
      Width           =   1275
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
Attribute VB_Name = "frmModificacionActivoFijo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Articulo
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mIdAprobo As Long
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

   Dim oF As frmDetModificacionActivoFijo
   Dim oL As ListItem
   
   Set oF = New frmDetModificacionActivoFijo
   
   With oF
      Set .Articulo = origen
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
            .Text = "" & oF.DTFields(0).Value
            If oF.Option1.Value Then
               .SubItems(1) = "Adquisición"
            ElseIf oF.Option2.Value Then
               .SubItems(1) = "Mejora"
            ElseIf oF.Option3.Value Then
               .SubItems(1) = "Baja"
            End If
            .SubItems(2) = "" & oF.txtDetalle.Text
            .SubItems(3) = "" & oF.txtImporte.Text
            .SubItems(4) = "" & oF.txtModificacionVidaUtilImpositiva.Text
            .SubItems(5) = "" & oF.txtModificacionVidaUtilContable.Text
            .SubItems(6) = "" & oF.DataCombo1(0).Text
            .SubItems(7) = "" & oF.DTFields(0).Value
            .SubItems(8) = "" & oF.txtImporteRevaluo.Text
            .SubItems(9) = "" & oF.txtVidaUtilRevaluo.Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Private Sub Check1_Click(Index As Integer)

   ControlCheck1 Index
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
      
'         If Len(txtNumeroActivoFijo.Text) = 0 Or _
'               Not IsNumeric(txtNumeroActivoFijo.Text) Or _
'               Val(txtNumeroActivoFijo.Text) <= 0 Then
'            MsgBox "Debe ingresar el numero de identificacion del activo fijo", vbExclamation
'            Exit Sub
'         End If

         If Len(txtVidaUtilContable.Text) = 0 Or _
               Not IsNumeric(txtVidaUtilContable.Text) Or _
               Val(txtVidaUtilContable.Text) < 0 Then
            MsgBox "Debe ingresar la vida util contable", vbExclamation
            Exit Sub
         End If
         If Len(txtValorOrigenContable.Text) = 0 Or _
               Not IsNumeric(txtValorOrigenContable.Text) Then
            MsgBox "Debe ingresar el valor de origen contable", vbExclamation
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
      
         For Each dtp In DTFields
            If dtp.Enabled Then
               origen.Registro.Fields(dtp.DataField).Value = dtp.Value
            End If
         Next
         
         For Each dc In dcfields
            If dc.Enabled Then
               If Not IsNumeric(dc.BoundText) Then
                  MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
                  Exit Sub
               End If
               If IsNumeric(dc.BoundText) Then
                  origen.Registro.Fields(dc.DataField).Value = dc.BoundText
               End If
            End If
         Next
         
         With origen.Registro
            If Option1.Value Then
               .Fields("EstadoActivoFijo").Value = "SI"
            Else
               .Fields("EstadoActivoFijo").Value = "NO"
            End If
            .Fields("BienImpositivo").Value = "NO"
            .Fields("BienContable").Value = "SI"
            If Check1(0).Value = 1 Then
               .Fields("CalculaValorActualizado").Value = "SI"
            Else
               .Fields("CalculaValorActualizado").Value = "NO"
            End If
            If Check1(2).Value = 1 Then
               .Fields("Amortiza").Value = "SI"
            Else
               .Fields("Amortiza").Value = "NO"
            End If
            If Check1(3).Value = 1 Then
               .Fields("CalculaAmortizacion").Value = "SI"
            Else
               .Fields("CalculaAmortizacion").Value = "NO"
            End If
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
            .ListaEditada = "Articulos"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
         
         Unload Me

      Case 1
      
         Unload Me

   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   Dim ListaVacia As Boolean
   Dim i As Integer
   Dim mAuxS1 As String
   
   mvarId = vnewvalue
   ListaVacia = False
   
   Set oAp = Aplicacion
   Set origen = oAp.Articulos.Item(vnewvalue)
   
   mAuxS1 = BuscarClaveINI("IdRubro de equipos")
   If BuscarClaveINI("Dominios en obra") = "SI" And Len(mAuxS1) > 0 Then
      With origen.Registro
         If IIf(IsNull(.Fields("IdRubro").Value), -1, .Fields("IdRubro").Value) = Val(mAuxS1) Then
            Set oRs = oAp.Obras.TraerFiltrado("_ControlEquipoEnDominio", Array(-1, mvarId))
            If oRs.RecordCount > 0 Then
               .Fields("UbicacionActivoFijo").Value = oRs.Fields("NumeroObra").Value
            End If
            oRs.Close
            If Not IsNull(.Fields("IdAcabado").Value) Then
               Set oRs = oAp.Acabados.Item(.Fields("IdAcabado").Value).Registro
               If oRs.RecordCount > 0 Then
                  txtEstado.Text = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
               End If
               oRs.Close
            End If
            If InStr(1, "Robado, Dado de Baja, Perdido, Vendido, Scrap", txtEstado.Text) <> 0 Then
               Check1(3).Value = 0
            End If
            If InStr(1, "Robado, Dado de Baja, Perdido, Vendido, Scrap", txtEstado.Text) <> 0 And _
                  Len(txtUbicacion.Text) = 0 Then
               .Fields("UbicacionActivoFijo").Value = "Libre"
            End If
         End If
      End With
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
                     Set oControl.DataSource = origen.DetArticulosActivosFijos.TraerMascara
                     ListaVacia = True
                  Else
                     Set oRs = origen.DetArticulosActivosFijos.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia = False
                     Else
                        Set oControl.DataSource = origen.DetArticulosActivosFijos.TraerMascara
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
   Else
      With origen.Registro
         txtCodigoArticulo.Text = IIf(IsNull(.Fields("Codigo").Value), "", .Fields("Codigo").Value)
         txtArticulo.Text = IIf(IsNull(.Fields("Descripcion").Value), "", .Fields("Descripcion").Value)
         If IsNull(.Fields("FechaCompra").Value) Then
            .Fields("FechaCompra").Value = Date
         End If
         If IsNull(.Fields("EstadoActivoFijo").Value) Or _
               .Fields("EstadoActivoFijo").Value = "NO" Then
            Option2.Value = True
         Else
            Option1.Value = True
         End If
         If IsNull(.Fields("CalculaValorActualizado").Value) Or _
               .Fields("CalculaValorActualizado").Value = "NO" Then
            Check1(0).Value = 0
         Else
            Check1(0).Value = 1
         End If
         If IsNull(.Fields("Amortiza").Value) Or _
               .Fields("Amortiza").Value = "NO" Then
            Check1(2).Value = 0
         Else
            Check1(2).Value = 1
         End If
         If IsNull(.Fields("CalculaAmortizacion").Value) Or _
               .Fields("CalculaAmortizacion").Value = "NO" Then
            Check1(3).Value = 0
         Else
            Check1(3).Value = 1
         End If
      End With
   End If
   
   If ListaVacia Then
      Lista.ListItems.Clear
   End If
   
   ControlCheck1 2

   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
   End If

   Set oRs = Nothing
   Set oAp = Nothing
   
End Property

Private Sub Form_Load()

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

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         Editar Lista.SelectedItem.Tag
      Case 2
         With Lista.SelectedItem
            origen.DetArticulosActivosFijos.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
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

Public Sub ControlCheck1(ByVal Index As Integer)

   Select Case Index
   
      Case 2
         If Check1(2).Value = 0 Then
            With origen.Registro
               .Fields("IdCuentaAmortizacion").Value = Null
            End With
            dcfields(1).Enabled = False
         Else
            dcfields(1).Enabled = True
         End If
      
   End Select

End Sub

Private Sub txtUbicacion_GotFocus()

   With txtUbicacion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
End Sub

Private Sub txtUbicacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtUbicacion
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtUltimoRevaluoContable_GotFocus()

   With txtUltimoRevaluoContable
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
End Sub

Private Sub txtUltimoRevaluoContable_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
