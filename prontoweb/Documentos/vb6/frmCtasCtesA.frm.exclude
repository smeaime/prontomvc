VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmCtasCtesA 
   Caption         =   "Resumen de cuentas corrientes acreedores"
   ClientHeight    =   7170
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11205
   Icon            =   "frmCtasCtesA.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7170
   ScaleWidth      =   11205
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Expresar en la moneda de origen del comprobante"
      Height          =   195
      Left            =   5265
      TabIndex        =   33
      Top             =   6930
      Width           =   3930
   End
   Begin VB.Frame Frame3 
      Height          =   465
      Left            =   5265
      TabIndex        =   31
      Top             =   6120
      Width           =   3930
      Begin VB.CheckBox Check3 
         Alignment       =   1  'Right Justify
         Caption         =   "x fechas :"
         Height          =   195
         Left            =   45
         TabIndex        =   34
         Top             =   180
         Width           =   1050
      End
      Begin MSComCtl2.DTPicker DTFields 
         Height          =   285
         Index           =   1
         Left            =   1215
         TabIndex        =   32
         Top             =   135
         Width           =   1290
         _ExtentX        =   2275
         _ExtentY        =   503
         _Version        =   393216
         Enabled         =   0   'False
         Format          =   22675457
         CurrentDate     =   36377
      End
      Begin MSComCtl2.DTPicker DTFields 
         Height          =   285
         Index           =   0
         Left            =   2610
         TabIndex        =   35
         Top             =   135
         Width           =   1290
         _ExtentX        =   2275
         _ExtentY        =   503
         _Version        =   393216
         Enabled         =   0   'False
         Format          =   22675457
         CurrentDate     =   36377
      End
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Mostrar desglose de deuda x condicion de compra"
      Height          =   195
      Left            =   5265
      TabIndex        =   30
      Top             =   6660
      Width           =   3930
   End
   Begin VB.TextBox txtTelefono 
      Enabled         =   0   'False
      Height          =   285
      Left            =   495
      Locked          =   -1  'True
      TabIndex        =   25
      Top             =   900
      Width           =   1845
   End
   Begin VB.TextBox txtEmail 
      Enabled         =   0   'False
      Height          =   285
      Left            =   2970
      Locked          =   -1  'True
      TabIndex        =   24
      Top             =   900
      Width           =   2115
   End
   Begin VB.TextBox txtContacto 
      Enabled         =   0   'False
      Height          =   285
      Left            =   5940
      Locked          =   -1  'True
      TabIndex        =   23
      Top             =   900
      Width           =   1980
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   1
      Left            =   2415
      Picture         =   "frmCtasCtesA.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   19
      Top             =   6660
      Width           =   705
   End
   Begin VB.Frame Frame1 
      Caption         =   "Moneda"
      Height          =   465
      Left            =   8010
      TabIndex        =   14
      Top             =   855
      Width           =   3120
      Begin VB.OptionButton Option6 
         Caption         =   "Otras"
         Height          =   195
         Left            =   2340
         TabIndex        =   29
         Top             =   180
         Width           =   690
      End
      Begin VB.OptionButton Option5 
         Caption         =   "Euros"
         Height          =   195
         Left            =   1575
         TabIndex        =   21
         Top             =   180
         Width           =   735
      End
      Begin VB.OptionButton Option4 
         Caption         =   "U$S"
         Height          =   195
         Left            =   900
         TabIndex        =   15
         Top             =   180
         Width           =   645
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Pesos"
         Height          =   195
         Left            =   90
         TabIndex        =   16
         Top             =   180
         Width           =   735
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Alcance : "
      Height          =   1005
      Left            =   9360
      TabIndex        =   11
      Top             =   6120
      Width           =   1725
      Begin VB.OptionButton Option2 
         Caption         =   "Solo lo pendiente"
         Height          =   195
         Left            =   90
         TabIndex        =   13
         Top             =   675
         Width           =   1545
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Todo"
         Height          =   195
         Left            =   90
         TabIndex        =   12
         Top             =   360
         Width           =   780
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Por &mayor"
      Height          =   420
      Index           =   1
      Left            =   1653
      TabIndex        =   5
      Top             =   6210
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Por &transacciones"
      Height          =   420
      Index           =   0
      Left            =   90
      TabIndex        =   4
      Top             =   6210
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   420
      Index           =   2
      Left            =   90
      TabIndex        =   3
      Top             =   6660
      Width           =   1470
   End
   Begin VB.TextBox txtSaldoCta 
      Alignment       =   1  'Right Justify
      Height          =   330
      Left            =   9495
      Locked          =   -1  'True
      TabIndex        =   2
      Top             =   495
      Width           =   1620
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   420
      Index           =   0
      Left            =   1665
      Picture         =   "frmCtasCtesA.frx":0CF4
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   6660
      UseMaskColor    =   -1  'True
      Width           =   705
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   1080
      TabIndex        =   0
      Tag             =   "Proveedores"
      Top             =   540
      Width           =   6810
      _ExtentX        =   12012
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   4290
      Left            =   90
      TabIndex        =   6
      Top             =   1755
      Width           =   11040
      _ExtentX        =   19473
      _ExtentY        =   7567
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmCtasCtesA.frx":135E
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   6615
      Top             =   1215
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   9
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCtasCtesA.frx":137A
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCtasCtesA.frx":148C
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCtasCtesA.frx":159E
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCtasCtesA.frx":16B0
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCtasCtesA.frx":17C2
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCtasCtesA.frx":18D4
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCtasCtesA.frx":19E6
            Key             =   "Excel"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCtasCtesA.frx":1E38
            Key             =   "Suma1"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCtasCtesA.frx":23D2
            Key             =   "Sumar"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   10
      Top             =   0
      Width           =   11205
      _ExtentX        =   19764
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
            Key             =   "Sumar"
            ImageKey        =   "Sumar"
         EndProperty
      EndProperty
      Begin VB.TextBox txtSumaToolbar 
         Alignment       =   2  'Center
         BackColor       =   &H80000000&
         BorderStyle     =   0  'None
         Height          =   285
         Left            =   2070
         TabIndex        =   36
         Top             =   45
         Width           =   2175
      End
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   1
      Left            =   9495
      TabIndex        =   20
      Tag             =   "Monedas"
      Top             =   1350
      Width           =   1635
      _ExtentX        =   2884
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox RichTextBox1 
      Height          =   195
      Left            =   7245
      TabIndex        =   22
      Top             =   1440
      Visible         =   0   'False
      Width           =   645
      _ExtentX        =   1138
      _ExtentY        =   344
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmCtasCtesA.frx":296C
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "TE :"
      Height          =   240
      Index           =   1
      Left            =   135
      TabIndex        =   28
      Top             =   945
      Width           =   300
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Email :"
      Height          =   240
      Index           =   3
      Left            =   2430
      TabIndex        =   27
      Top             =   945
      Width           =   480
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Contacto :"
      Height          =   240
      Index           =   4
      Left            =   5175
      TabIndex        =   26
      Top             =   945
      Width           =   705
   End
   Begin VB.Label lblImputacion 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   465
      Left            =   1935
      TabIndex        =   18
      Top             =   1260
      Visible         =   0   'False
      Width           =   4605
   End
   Begin VB.Label lblMoneda 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   135
      TabIndex        =   17
      Top             =   1260
      Width           =   1680
   End
   Begin VB.Label lblLabels 
      Caption         =   "Proveedor :"
      Height          =   300
      Index           =   6
      Left            =   135
      TabIndex        =   9
      Top             =   540
      Width           =   870
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Saldo cta. cte. :"
      Height          =   240
      Index           =   2
      Left            =   8010
      TabIndex        =   8
      Top             =   540
      Width           =   1380
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Otras monedas :"
      Height          =   240
      Index           =   0
      Left            =   8010
      TabIndex        =   7
      Top             =   1395
      Width           =   1380
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Tomar comprobante para reimputar"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Aplicar imputacion"
         Enabled         =   0   'False
         Index           =   1
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Cancelar reimputacion"
         Index           =   2
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Crear nueva transaccion"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Agrupar items seleccionados en una transaccion"
         Index           =   4
      End
   End
End
Attribute VB_Name = "frmCtasCtesA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.CtaCteA
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim WithEvents ActL As ControlForm
Attribute ActL.VB_VarHelpID = -1
Dim actL2 As ControlForm
Dim mPorTransaccion As Boolean, mEnProcesoDeReimputacion As Boolean
Dim mSaldoAReimputarPesos As Double, mSaldoAReimputarDolar As Double
Dim mSaldoAReimputarEuro As Double
Dim mvarIdProveedor As Long, mIdCtaComprobanteReimputado As Long
Dim mSoloPendiente As String, mMoneda As String
Dim oRsCtaCte As ADOR.Recordset
Dim oFrmCondiciones As frm_Aux
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

Public Property Let Id(ByVal vnewvalue As String)

   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   
   Set oAp = Aplicacion
   Set origen = oAp.CtasCtesA.Item(vnewvalue)
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
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Monedas" Then
                  Set oControl.RowSource = oAp.Monedas.TraerFiltrado("_Resto")
               ElseIf oControl.Tag = "Proveedores" Then
                  Set oControl.RowSource = oAp.Proveedores.TraerFiltrado("_TodosParaCombo", Array("N", "T"))
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
   
   Set oAp = Nothing
   
   mvarIdProveedor = vnewvalue
   dcfields(0).BoundText = mvarIdProveedor
   
'   cmdImpre(0).Enabled = False
'   cmdImpre(1).Enabled = False
   mEnProcesoDeReimputacion = False
   mIdCtaComprobanteReimputado = 0
   mSaldoAReimputarPesos = 0
   mSaldoAReimputarDolar = 0
   mSaldoAReimputarEuro = 0
   
   Check1.Value = 0
   Check2.Value = 0
   InformacionCondiciones 0
   
End Property

Private Sub Check1_Click()

   If Check1.Value = 1 Then
      InformacionCondiciones 0
   Else
      If Not oFrmCondiciones Is Nothing Then
         Unload oFrmCondiciones
         Set oFrmCondiciones = Nothing
      End If
   End If

End Sub

Private Sub Check3_Click()

   If Check3.Value = 1 Then
      With DTFields(0)
         .Value = Date
         .Enabled = True
      End With
      With DTFields(1)
         .Value = DateSerial(2000, 1, 1)
         .Enabled = True
      End With
   Else
      DTFields(0).Enabled = False
      DTFields(1).Enabled = False
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         PorTransacciones mSoloPendiente, mMoneda
         Lista.ListItems.Clear
         Lista.Sorted = False
         If Not oRsCtaCte Is Nothing Then
            If oRsCtaCte.RecordCount > 0 Then Set Lista.DataSource = oRsCtaCte
            Lista.Refresh
         End If
         Set oRsCtaCte = Nothing
         mPorTransaccion = True
      Case 1
         If dcfields(1).Enabled And Len(dcfields(1).Text) = 0 Then
            MsgBox "No definio la moneda"
            Exit Sub
         End If
         PorMayor mMoneda
         Lista.ListItems.Clear
         Lista.Sorted = False
         If Not oRsCtaCte Is Nothing Then
            If oRsCtaCte.RecordCount > 0 Then Set Lista.DataSource = oRsCtaCte
         End If
         Set oRsCtaCte = Nothing
         mPorTransaccion = False
      Case 2
         Unload Me
   End Select
   
End Sub

Private Sub cmdImpre_Click(Index As Integer)

   Dim mvarOK As Boolean
   Dim mCopias As Integer
   Dim mPrinter As String, mPrinterAnt As String, mPlantilla As String
   
   mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
   If Index = 0 Then
      Dim oF As frmImpresion
      Set oF = New frmImpresion
      With oF
         .txtCopias.Text = 1
         .Show vbModal, Me
      End With
      mvarOK = oF.Ok
      mCopias = Val(oF.txtCopias.Text)
      mPrinter = oF.Combo1.Text
      Unload oF
      Set oF = Nothing
      If Not mvarOK Then
         Exit Sub
      End If
   Else
      mCopias = 1
   End If
   
   Dim oW As Word.Application
   Dim oL As ListItem
   Dim mDireccion As String, mTelefono As String, mContacto As String
   Dim i As Integer
   Dim oRs As ADOR.Recordset
   
   Me.MousePointer = vbHourglass
      
   On Error GoTo Mal
   
   If mPorTransaccion Then
      mPlantilla = glbPathPlantillas & "\CtaCte1.dot"
   Else
      mPlantilla = glbPathPlantillas & "\CtaCte2.dot"
   End If
   
   Set oW = CreateObject("Word.Application")
   
   With oW
      .Visible = True
      With .Documents.Add(mPlantilla)
         oW.Selection.HomeKey Unit:=wdStory
         oW.Selection.MoveDown Unit:=wdLine, Count:=5
         oW.Selection.MoveLeft Unit:=wdCell
          
         For Each oL In Lista.ListItems
            oW.Selection.MoveRight Unit:=wdCell
            oW.Selection.TypeText Text:="" & oL.Text
            oW.Selection.MoveRight Unit:=wdCell
            oW.Selection.TypeText Text:="" & oL.ListSubItems(3).Text
            oW.Selection.MoveRight Unit:=wdCell
            oW.Selection.TypeText Text:="" & oL.ListSubItems(4).Text
            oW.Selection.MoveRight Unit:=wdCell
            oW.Selection.TypeText Text:="" & oL.ListSubItems(5).Text
            oW.Selection.MoveRight Unit:=wdCell
            oW.Selection.TypeText Text:="" & oL.ListSubItems(6).Text
            oW.Selection.MoveRight Unit:=wdCell
            If mPorTransaccion Then
               oW.Selection.TypeText Text:="" & oL.ListSubItems(14).Text
               oW.Selection.MoveRight Unit:=wdCell
               If Check2.Value = 1 Then
                  If Len(Trim(oL.ListSubItems(8).Text)) <> 0 Then
                     oW.Selection.TypeText Text:="" & oL.ListSubItems(7).Text & " " & oL.ListSubItems(8).Text
                  End If
               Else
                  oW.Selection.TypeText Text:="" & oL.ListSubItems(7).Text
               End If
               oW.Selection.MoveRight Unit:=wdCell
               If Check2.Value = 1 Then
                  If Len(Trim(oL.ListSubItems(9).Text)) <> 0 Then
                     oW.Selection.TypeText Text:="" & oL.ListSubItems(7).Text & " " & oL.ListSubItems(9).Text
                  End If
               Else
                  oW.Selection.TypeText Text:="" & oL.ListSubItems(8).Text
               End If
               oW.Selection.MoveRight Unit:=wdCell
               If Check2.Value = 1 Then
                  oW.Selection.TypeText Text:="" & oL.ListSubItems(10).Text
               Else
                  oW.Selection.TypeText Text:="" & oL.ListSubItems(9).Text
               End If
            Else
               oW.Selection.TypeText Text:="" & oL.ListSubItems(12).Text
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & oL.ListSubItems(7).Text
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & oL.ListSubItems(8).Text
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & oL.ListSubItems(9).Text
            End If
         Next
          
         oW.Selection.Goto What:=wdGoToBookmark, Name:="Total"
         oW.Selection.TypeText Text:=Format(txtSaldoCta.Text, "#,##0.00")
         
         Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ConDatos", mvarIdProveedor)
         If oRs.RecordCount > 0 Then
            mDireccion = IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value) & " " & _
                        IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value) & " " & _
                        "(" & IIf(IsNull(oRs.Fields("CodigoPostal").Value), "", oRs.Fields("CodigoPostal").Value) & ") "
            If IIf(IsNull(oRs.Fields("Provincia").Value), "", UCase(oRs.Fields("Provincia").Value)) <> "CAPITAL FEDERAL" Then
               mDireccion = mDireccion & IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
            End If
            mTelefono = IIf(IsNull(oRs.Fields("Telefono1").Value), "", oRs.Fields("Telefono1").Value)
            mContacto = IIf(IsNull(oRs.Fields("Contacto").Value), "", oRs.Fields("Contacto").Value)
         End If
         oRs.Close
         Set oRs = Nothing
         
         oW.ActiveDocument.FormFields("Entidad").Result = "Proveedor :"
         oW.ActiveDocument.FormFields("RazonSocial").Result = dcfields(0).Text
         oW.ActiveDocument.FormFields("Direccion").Result = mDireccion
         oW.ActiveDocument.FormFields("Telefono").Result = mTelefono
         oW.ActiveDocument.FormFields("Contacto").Result = mContacto
         If Check2.Value = 1 Then
            oW.ActiveDocument.FormFields("Moneda").Result = "Resumen emitido en moneda original"
         Else
            oW.ActiveDocument.FormFields("Moneda").Result = "Resumen emitido en " & lblMoneda.Caption
         End If
         oW.ActiveDocument.FormFields("Saldo").Result = txtSaldoCta.Text
         If DTFields(0).Enabled Then
            oW.ActiveDocument.FormFields("Fecha").Result = "" & DTFields(0).Value
         Else
            oW.ActiveDocument.FormFields("Fecha").Result = Date
         End If
         
         'Registro de numero de paginas, fecha y hora
         oW.Application.Run MacroName:="DatosDelPie"
         oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
         
         If Index = 0 Then
            If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
            oW.Documents(1).PrintOut False, , , , , , , mCopias
            If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
            oW.Documents(1).Close False
            oW.Quit
         End If
      End With
   End With
   
Mal:

   Set oW = Nothing

   Me.MousePointer = vbDefault
      
End Sub

Private Sub dcfields_Change(Index As Integer)

   Lista.ListItems.Clear
   If IsNumeric(dcfields(Index).BoundText) Then
      Select Case Index
         Case 0
            Dim oRs As ADOR.Recordset
            mvarIdProveedor = dcfields(Index).BoundText
            Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", mvarIdProveedor)
            If oRs.RecordCount > 0 Then
               txtTelefono.Text = IIf(IsNull(oRs.Fields("Telefono1").Value), "", oRs.Fields("Telefono1").Value)
               txtEmail.Text = IIf(IsNull(oRs.Fields("Email").Value), "", oRs.Fields("Email").Value)
               txtContacto.Text = IIf(IsNull(oRs.Fields("Contacto").Value), "", oRs.Fields("Contacto").Value)
            End If
            oRs.Close
            Set oRs = Nothing
         Case 1
            lblMoneda.Caption = dcfields(Index).Text
      End Select
   End If
   
End Sub

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Public Sub PorTransacciones(ByVal SoloPendiente As String, ByVal Moneda As String)

   Dim oRsTotales As ADOR.Recordset
   Dim oRsSaldo As ADOR.Recordset
   Dim mTodo As Integer, mConsolidar As Integer
   Dim i As Long, Trs As Long
   Dim Sdo As Double
   Dim mTransaccionesSaldoCero As String
   Dim mVector_E As String, mVector_T As String, mVector_X As String

   Me.MousePointer = vbHourglass
   
   mTodo = -1
   If DTFields(0).Enabled Then mTodo = 0
   mConsolidar = -1
   If glbConsolidar Then mConsolidar = 0
   
   If Check2.Value = 1 Then
      Set oRsSaldo = Aplicacion.CtasCtesA.TraerFiltrado("Total", Array(mvarIdProveedor, mTodo, DTFields(0).Value, mConsolidar))
   Else
      If Moneda = "Pesos" Then
         Set oRsSaldo = Aplicacion.CtasCtesA.TraerFiltrado("Total", Array(mvarIdProveedor, mTodo, DTFields(0).Value, mConsolidar))
      ElseIf Moneda = "Dolares" Then
         Set oRsSaldo = Aplicacion.CtasCtesA.TraerFiltrado("Total_Dolares", Array(mvarIdProveedor, mTodo, DTFields(0).Value))
      ElseIf Moneda = "Euros" Then
         Set oRsSaldo = Aplicacion.CtasCtesA.TraerFiltrado("Total_Euros", Array(mvarIdProveedor, mTodo, DTFields(0).Value))
      Else
         GoTo Salida
      End If
   End If
   txtSaldoCta.Text = Format(0, "#,##0.00")
   If oRsSaldo.Fields.Count > 0 Then
      If oRsSaldo.RecordCount > 0 Then
         txtSaldoCta.Text = Format(oRsSaldo.Fields("SaldoCta").Value, "#,##0.00")
      End If
      oRsSaldo.Close
   End If
   Set oRsSaldo = Nothing
   
   If Check2.Value = 1 Then
      Set oRsCtaCte = Aplicacion.CtasCtesA.TraerFiltrado("PorTrs_MonedaOriginal", Array(mvarIdProveedor, mTodo, DTFields(0).Value, DTFields(1).Value))
   Else
      If Moneda = "Pesos" Then
         Set oRsCtaCte = Aplicacion.CtasCtesA.TraerFiltrado("PorTrs", Array(mvarIdProveedor, mTodo, DTFields(0).Value, DTFields(1).Value, mConsolidar, SoloPendiente))
      ElseIf Moneda = "Dolares" Then
         Set oRsCtaCte = Aplicacion.CtasCtesA.TraerFiltrado("PorTrs_Dolares", Array(mvarIdProveedor, mTodo, DTFields(0).Value, DTFields(1).Value))
      ElseIf Moneda = "Euros" Then
         Set oRsCtaCte = Aplicacion.CtasCtesA.TraerFiltrado("PorTrs_Euros", Array(mvarIdProveedor, mTodo, DTFields(0).Value, DTFields(1).Value))
      End If
   End If
   
   If Moneda <> "Pesos" Then
      Set oRsCtaCte = CopiarTodosLosRegistros(oRsCtaCte)
      Set oRsTotales = CopiarEstructura(oRsCtaCte)
      
      Sdo = 0
      mTransaccionesSaldoCero = ""
      
      With oRsCtaCte
         If .RecordCount > 0 Then
            .MoveFirst
            Trs = IIf(IsNull(.Fields("IdImputacion").Value), -1, .Fields("IdImputacion").Value)
            mVector_E = IIf(IsNull(.Fields("Vector_E").Value), "", .Fields("Vector_E").Value)
            mVector_T = IIf(IsNull(.Fields("Vector_T").Value), "", .Fields("Vector_T").Value)
            mVector_X = IIf(IsNull(.Fields("Vector_X").Value), "", .Fields("Vector_X").Value)
            If mTodo <> -1 Then CalcularSaldosTransaccion oRsCtaCte, Trs
            Do While Not .EOF
               If Trs <> IIf(IsNull(.Fields("IdImputacion").Value), -1, .Fields("IdImputacion").Value) Then
                  If mTodo <> -1 Then CalcularSaldosTransaccion oRsCtaCte, Trs
                  oRsTotales.AddNew
                  oRsTotales.Fields("IdImputacion").Value = Trs
                  oRsTotales.Fields("SaldoTrs").Value = Sdo
                  oRsTotales.Update
                  If Sdo = 0 Then mTransaccionesSaldoCero = mTransaccionesSaldoCero & Trs & "|"
                  Trs = IIf(IsNull(.Fields("IdImputacion").Value), -1, .Fields("IdImputacion").Value)
                  Sdo = 0
               End If
               Sdo = Sdo + IIf(IsNull(.Fields("Saldo Comp.").Value), 0, .Fields("Saldo Comp.").Value)
               If Not IsNull(.Fields("Observaciones").Value) Then
                  RichTextBox1.TextRTF = .Fields("Observaciones").Value
                  .Fields("Observaciones").Value = "" & RichTextBox1.Text
               Else
                  .Fields("Observaciones").Value = ""
               End If
               .Update
               .MoveNext
            Loop
            If mTodo <> -1 Then CalcularSaldosTransaccion oRsCtaCte, Trs
            oRsTotales.AddNew
            oRsTotales.Fields("IdImputacion").Value = Trs
            oRsTotales.Fields("SaldoTrs").Value = Sdo
            oRsTotales.Update
            If Sdo = 0 Then mTransaccionesSaldoCero = mTransaccionesSaldoCero & Trs & "|"
            
            oRsTotales.MoveFirst
            Do While Not oRsTotales.EOF
               .AddNew
               .Fields(0).Value = 0
               .Fields("IdImputacion").Value = oRsTotales.Fields("IdImputacion").Value
               .Fields("SaldoTrs").Value = oRsTotales.Fields("SaldoTrs").Value
               .Fields("Vector_E").Value = mVector_E
               .Fields("Vector_T").Value = mVector_T
               .Fields("Vector_X").Value = mVector_X
               .Fields("Cabeza").Value = "9"
               .Update
               oRsTotales.MoveNext
            Loop
            
            oRsTotales.Close
            Set oRsTotales = Nothing
            
            .Sort = "IdImputacion,Cabeza,Fecha,Numero"
            If SoloPendiente = "S" Then BorraTransacciones oRsCtaCte, mTransaccionesSaldoCero
         End If
      End With
   End If
   
Salida:

'   cmdImpre(0).Enabled = True
'   cmdImpre(1).Enabled = True
   
   Me.MousePointer = vbDefault

End Sub

Public Sub PorMayor(ByVal Moneda As String)

   Dim oRsTotales As ADOR.Recordset
   Dim oRsSaldo As ADOR.Recordset
   Dim mTodo As Integer, mConsolidar As Integer
   Dim Trs As Long, i As Long
   Dim Sdo As Double
   Dim mFechasSinCotizacion As String

   Me.MousePointer = vbHourglass
   
   mTodo = -1
   If DTFields(0).Enabled Then mTodo = 0
   Check2.Value = 0
   mConsolidar = -1
   If glbConsolidar Then mConsolidar = 0
   
   txtSaldoCta.Text = ""
   
   If Moneda <> "Otras" Then
      If Moneda = "Pesos" Then
         Set oRsSaldo = Aplicacion.CtasCtesA.TraerFiltrado("Total", Array(mvarIdProveedor, mTodo, DTFields(0).Value, mConsolidar))
      ElseIf Moneda = "Dolares" Then
         Set oRsSaldo = Aplicacion.CtasCtesA.TraerFiltrado("Total_Dolares", Array(mvarIdProveedor, mTodo, DTFields(0).Value))
      ElseIf Moneda = "Euros" Then
         Set oRsSaldo = Aplicacion.CtasCtesA.TraerFiltrado("Total_Euros", Array(mvarIdProveedor, mTodo, DTFields(0).Value))
      Else
         GoTo Salida
      End If
      txtSaldoCta.Text = Format(0, "#,##0.00")
      If oRsSaldo.Fields.Count > 0 Then
         If oRsSaldo.RecordCount > 0 Then
            txtSaldoCta.Text = Format(oRsSaldo.Fields("SaldoCta").Value, "#,##0.00")
         End If
         oRsSaldo.Close
      End If
      Set oRsSaldo = Nothing
   End If
   
   If Moneda = "Pesos" Then
      Set oRsCtaCte = Aplicacion.CtasCtesA.TraerFiltrado("PorMayor", Array(mvarIdProveedor, mTodo, DTFields(0).Value, DTFields(1).Value, mConsolidar))
   ElseIf Moneda = "Dolares" Then
      Set oRsCtaCte = Aplicacion.CtasCtesA.TraerFiltrado("PorMayor_Dolares", Array(mvarIdProveedor, mTodo, DTFields(0).Value, DTFields(1).Value))
   ElseIf Moneda = "Euros" Then
      Set oRsCtaCte = Aplicacion.CtasCtesA.TraerFiltrado("PorMayor_Euros", Array(mvarIdProveedor, mTodo, DTFields(0).Value, DTFields(1).Value))
   Else
      Set oRsCtaCte = Aplicacion.CtasCtesA.TraerFiltrado("PorMayor_OtrasMonedas", Array(mvarIdProveedor, mTodo, DTFields(0).Value, dcfields(1).BoundText, DTFields(1).Value))
   End If
   Set oRsCtaCte = CopiarTodosLosRegistros(oRsCtaCte)
   
   Sdo = 0
   mFechasSinCotizacion = ""
   
   With oRsCtaCte
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If Moneda = "Otras" Then
               If IsNull(.Fields("CotizacionOtrasMonedas").Value) Then
                  mFechasSinCotizacion = mFechasSinCotizacion & .Fields("Fecha").Value & ", "
               End If
            End If
            Sdo = Sdo + IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value)
            Sdo = Sdo - IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value)
            .Fields("Sdo").Value = Sdo
            If Not IsNull(.Fields("Observaciones").Value) Then
               RichTextBox1.TextRTF = .Fields("Observaciones").Value
               .Fields("Observaciones").Value = "" & RichTextBox1.Text
            Else
               .Fields("Observaciones").Value = ""
            End If
            .Update
            .MoveNext
         Loop
         .MoveFirst
      End If
   End With
   
   If Moneda = "Otras" Then
      If Len(mFechasSinCotizacion) > 0 Then
         If Len(mFechasSinCotizacion) > 100 Then
            mFechasSinCotizacion = mId(mFechasSinCotizacion, 1, 100) & " y mas ..."
         Else
            mFechasSinCotizacion = mId(mFechasSinCotizacion, 1, Len(mFechasSinCotizacion) - 2)
         End If
         Set oRsCtaCte = Nothing
         MsgBox "Falta ingresar la cotizacion de la moneda " & dcfields(1).Text & " de los dias " & mFechasSinCotizacion, vbExclamation
      Else
         txtSaldoCta.Text = Format(Sdo, "#,##0.00")
      End If
   End If
   
Salida:

'   cmdImpre(0).Enabled = False
'   cmdImpre(1).Enabled = False
   
   Me.MousePointer = vbDefault

End Sub

Private Sub Form_Load()

   Option1.Value = True
   Option3.Value = True
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oRsCtaCte = Nothing
   Set actL2 = Nothing
   Set ActL = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   If Not oFrmCondiciones Is Nothing Then
      Unload oFrmCondiciones
      Set oFrmCondiciones = Nothing
   End If
   
End Sub

Private Sub Lista_DblClick()

   If Not Lista.SelectedItem Is Nothing Then
      If Len(Trim(Lista.SelectedItem.Tag)) <> 0 And Check2.Value = 0 Then
         If Val(Lista.SelectedItem.Tag) <> 0 Then
            Editar Lista.SelectedItem.SubItems(1), Lista.SelectedItem.SubItems(2)
         Else
            MsgBox "Comprobante no editable", vbInformation
         End If
      End If
   End If

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_ItemClick(ByVal Item As MSComctlLib.IListItem)

   If Not Lista.SelectedItem Is Nothing Then
      If Len(Trim(Lista.SelectedItem.Tag)) <> 0 Then
         InformacionCondiciones Lista.SelectedItem.Tag
      Else
         If Not oFrmCondiciones Is Nothing Then
            oFrmCondiciones.Lista.ListItems.Clear
         End If
      End If
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count = 0 Then
      Else
         If BuscarClaveINI("Habilitar aplicacion manual de cuentas corrientes") <> "SI" Then
            If Not mPorTransaccion Then
               Exit Sub
            Else
               MnuDetA(0).Visible = False
               MnuDetA(1).Visible = False
               MnuDetA(2).Visible = False
               MnuDetA(3).Visible = False
               PopupMenu MnuDet, , , , MnuDetA(4)
            End If
         Else
            If Not mPorTransaccion Then
               Exit Sub
            Else
               MnuDetA(0).Visible = True
               MnuDetA(1).Visible = True
               MnuDetA(2).Visible = True
               MnuDetA(3).Visible = True
               PopupMenu MnuDet, , , , MnuDetA(1)
            End If
         End If
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         If Not Lista.SelectedItem Is Nothing Then
            CargarComprobanteParaImputar Lista.SelectedItem
         End If
      Case 1
         If Not Lista.SelectedItem Is Nothing Then
            ImputarComprobante Lista.SelectedItem
         End If
      Case 2
         mSaldoAReimputarPesos = 0
         mSaldoAReimputarDolar = 0
         mSaldoAReimputarEuro = 0
         MnuDetA(0).Enabled = True
         MnuDetA(1).Enabled = False
         mEnProcesoDeReimputacion = False
         lblImputacion.Visible = False
      Case 3
         If Not Lista.SelectedItem Is Nothing Then
            CrearTransaccion Lista.SelectedItem
         End If
      Case 4
         If Not Lista.SelectedItem Is Nothing Then
            AgruparItemsEnTransaccion
         End If
   End Select

End Sub

Private Sub Option1_Click()

   If Option1.Value Then mSoloPendiente = "N"
   
End Sub

Private Sub Option2_Click()

   If Option2.Value Then mSoloPendiente = "S"

End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      mMoneda = "Pesos"
      lblMoneda.Caption = "PESOS"
      Lista.ListItems.Clear
      With dcfields(1)
         .Enabled = False
         .Text = ""
      End With
      cmd(0).Enabled = True
   End If
   
End Sub

Private Sub Option4_Click()

   If Option4.Value Then
      mMoneda = "Dolares"
      lblMoneda.Caption = "DOLARES"
      Lista.ListItems.Clear
      With dcfields(1)
         .Enabled = False
         .Text = ""
      End With
      cmd(0).Enabled = True
   End If
   
End Sub

Private Sub Option5_Click()

   If Option5.Value Then
      mMoneda = "Euros"
      lblMoneda.Caption = "EUROS"
      Lista.ListItems.Clear
      With dcfields(1)
         .Enabled = False
         .Text = ""
      End With
      cmd(0).Enabled = True
   End If
   
End Sub

Private Sub Option6_Click()

   If Option6.Value Then
      mMoneda = "Otras"
      lblMoneda.Caption = ""
      Lista.ListItems.Clear
      dcfields(1).Enabled = True
      cmd(0).Enabled = False
   End If
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Dim mvarSubTituloExcel As String
   mvarSubTituloExcel = "|CUENTA CORRIENTE.|Proveedor : " & dcfields(0).Text & _
                        "|Saldo : " & txtSaldoCta.Text & "  ( en " & lblMoneda.Caption & " )"
   If DTFields(0).Enabled Then
      mvarSubTituloExcel = mvarSubTituloExcel & "|Tomada entre : " & DTFields(1).Value & " " & DTFields(0).Value
   End If
   
   Select Case Button.Key
      
      Case "Imprimir"
         
         ImprimirConExcel Lista, mvarSubTituloExcel
      
      Case "Buscar"
         
         FiltradoLista Lista

      Case "Excel"
         
         ExportarAExcel Lista, mvarSubTituloExcel
      
      Case "Sumar"
         
         txtSumaToolbar.Text = "" & Format(TotalizarCampo(Lista), "#,##0.00")
         
   End Select

End Sub

Private Sub BorraTransacciones(ByRef oRs As ADOR.Recordset, ByVal TransaccionesABorrar As String)

   Dim i As Integer
   Dim mVectorTransaccionesABorrar
   
   mVectorTransaccionesABorrar = VBA.Split(TransaccionesABorrar, "|")
   
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            For i = 0 To UBound(mVectorTransaccionesABorrar)
               If IsNumeric(mVectorTransaccionesABorrar(i)) Then
                  If CLng(mVectorTransaccionesABorrar(i)) = IIf(IsNull(.Fields("IdImputacion").Value), -1, .Fields("IdImputacion").Value) Then
                     .Delete
                     .Update
                     Exit For
                  End If
               End If
            Next
            .MoveNext
         Loop
         If .RecordCount > 0 Then .MoveFirst
      End If
   End With

End Sub

Private Sub Editar(ByVal TipoComprobante As Long, ByVal Identificador As Long)

   Dim oF As Form
      
   Select Case TipoComprobante
      Case 16, 17
         Set oF = New frmOrdenesPago
      Case Else
         Set oF = New frmComprobantesPrv
   End Select
   
   With oF
      .Id = Identificador
      .Disparar = ActL
      .Show vbModal, Me
   End With

   'If TipoComprobante = 17 Then Cmd_Click (0)

Salida:

   Set oF = Nothing

End Sub

Public Sub CargarComprobanteParaImputar(ByVal oL As ListItem)

   If Not mPorTransaccion Then
      MsgBox "Para reasignar imputaciones debe estar en modo transaccion"
      Exit Sub
   End If
   
   Dim mIdCtaCte As Long
   Dim oRs As ADOR.Recordset
   
   mIdCtaCte = Val(oL.Tag)
   
   If mIdCtaCte <= 0 Then
      MsgBox "No hay saldo para imputar"
      Exit Sub
   End If
   
   Set oRs = Aplicacion.TiposComprobante.TraerFiltrado("_PorId", oL.SubItems(1))
   If oRs.Fields("Coeficiente").Value > 0 Then
      oRs.Close
      Set oRs = Nothing
      MsgBox "Solo puede cargar comprobantes cancelatorios (OP, NC, etc)", vbExclamation
      Exit Sub
   End If
   
   mSaldoAReimputarPesos = 0
   mSaldoAReimputarDolar = 0
   mSaldoAReimputarEuro = 0
   
   Set oRs = Aplicacion.CtasCtesA.TraerFiltrado("_PorIdConSigno", mIdCtaCte)
   If oRs.RecordCount > 0 Then
      mSaldoAReimputarPesos = oRs.Fields("Saldo").Value * oRs.Fields("Coeficiente").Value
      mSaldoAReimputarDolar = oRs.Fields("SaldoDolar").Value * oRs.Fields("Coeficiente").Value
      mSaldoAReimputarEuro = oRs.Fields("SaldoEuro").Value * oRs.Fields("Coeficiente").Value
   End If
   oRs.Close
   Set oRs = Nothing
   
   With lblImputacion
      .Caption = "Reimputacion : Comp. " & oL.Text & " " & oL.SubItems(3) & ", Sdo : " & _
         IIf(Option3.Value, mSaldoAReimputarPesos, mSaldoAReimputarDolar)
      .Visible = True
   End With
   
   mIdCtaComprobanteReimputado = mIdCtaCte
   MnuDetA(0).Enabled = False
   MnuDetA(1).Enabled = True
   mEnProcesoDeReimputacion = True

End Sub

Public Sub ImputarComprobante(ByVal oL As ListItem)

   Dim mvarSeguro As Integer
   mvarSeguro = MsgBox("Desea reimputar el comprobante ?", vbYesNo, "Reimputacion de comprobantes")
   If mvarSeguro = vbNo Then
      Exit Sub
   End If
   
   Dim mIdCtaCte As Long
   Dim mSaldoPesos As Double, mSaldoDolar As Double, mSaldoEuro As Double
   Dim oRs As ADOR.Recordset
   
   mIdCtaCte = Val(oL.Tag)

   If mIdCtaCte <= 0 Then
      MsgBox "No hay saldo para imputar"
      Exit Sub
   End If
   
'   If mSaldo = 0 Then
'      MsgBox "No hay saldo para imputar"
'      Exit Sub
'   End If
   
   mSaldoPesos = 0
   mSaldoDolar = 0
   mSaldoEuro = 0
   
   Set oRs = Aplicacion.CtasCtesA.TraerFiltrado("_PorIdConSigno", mIdCtaCte)
   If oRs.RecordCount > 0 Then
      mSaldoPesos = oRs.Fields("Saldo").Value * oRs.Fields("Coeficiente").Value
      mSaldoDolar = oRs.Fields("SaldoDolar").Value * oRs.Fields("Coeficiente").Value
      mSaldoEuro = oRs.Fields("SaldoEuro").Value * oRs.Fields("Coeficiente").Value
   End If
   oRs.Close
   Set oRs = Nothing
   
   If (mSaldoPesos > 0 And mSaldoAReimputarPesos > 0) Or _
      (mSaldoPesos < 0 And mSaldoAReimputarPesos < 0) Or _
      (mSaldoDolar > 0 And mSaldoAReimputarDolar > 0) Or _
      (mSaldoDolar < 0 And mSaldoAReimputarDolar < 0) Or _
      (mSaldoEuro > 0 And mSaldoAReimputarEuro > 0) Or _
      (mSaldoEuro < 0 And mSaldoAReimputarEuro < 0) Then
      MsgBox "No se pueden aplicar comprobantes del mismo signo"
      Exit Sub
   End If

   If mSaldoAReimputarPesos < 0 Then
      If Abs(mSaldoAReimputarPesos) >= mSaldoPesos Then
         mSaldoAReimputarPesos = Abs(mSaldoAReimputarPesos) - mSaldoPesos
         mSaldoPesos = 0
      Else
         mSaldoPesos = mSaldoPesos - Abs(mSaldoAReimputarPesos)
         mSaldoAReimputarPesos = 0
      End If
   Else
      If mSaldoAReimputarPesos >= Abs(mSaldoPesos) Then
         mSaldoAReimputarPesos = mSaldoAReimputarPesos - Abs(mSaldoPesos)
         mSaldoPesos = 0
      Else
         mSaldoPesos = Abs(mSaldoPesos) - mSaldoAReimputarPesos
         mSaldoAReimputarPesos = 0
      End If
   End If
   
   If mSaldoAReimputarDolar < 0 Then
      If Abs(mSaldoAReimputarDolar) >= mSaldoDolar Then
         mSaldoAReimputarDolar = Abs(mSaldoAReimputarDolar) - mSaldoDolar
         mSaldoDolar = 0
      Else
         mSaldoDolar = mSaldoDolar - Abs(mSaldoAReimputarDolar)
         mSaldoAReimputarDolar = 0
      End If
   Else
      If mSaldoAReimputarDolar >= Abs(mSaldoDolar) Then
         mSaldoAReimputarDolar = mSaldoAReimputarDolar - Abs(mSaldoDolar)
         mSaldoDolar = 0
      Else
         mSaldoDolar = Abs(mSaldoDolar) - mSaldoAReimputarDolar
         mSaldoAReimputarDolar = 0
      End If
   End If
   
   If mSaldoAReimputarEuro < 0 Then
      If Abs(mSaldoAReimputarEuro) >= mSaldoEuro Then
         mSaldoAReimputarEuro = Abs(mSaldoAReimputarEuro) - mSaldoEuro
         mSaldoEuro = 0
      Else
         mSaldoEuro = mSaldoEuro - Abs(mSaldoAReimputarEuro)
         mSaldoAReimputarEuro = 0
      End If
   Else
      If mSaldoAReimputarEuro >= Abs(mSaldoEuro) Then
         mSaldoAReimputarEuro = mSaldoAReimputarEuro - Abs(mSaldoEuro)
         mSaldoEuro = 0
      Else
         mSaldoEuro = Abs(mSaldoEuro) - mSaldoAReimputarEuro
         mSaldoAReimputarEuro = 0
      End If
   End If
   
   Aplicacion.Tarea "CtasCtesA_ReimputarComprobante", _
      Array(mIdCtaComprobanteReimputado, _
            mSaldoAReimputarPesos, mSaldoAReimputarDolar, mSaldoAReimputarEuro, _
            mIdCtaCte, mSaldoPesos, mSaldoDolar, mSaldoEuro)
   
   PorTransacciones mSoloPendiente, mMoneda
   Lista.ListItems.Clear
   Lista.Sorted = False
   If Not oRsCtaCte Is Nothing Then
      If oRsCtaCte.RecordCount > 0 Then Set Lista.DataSource = oRsCtaCte
   End If
   Set oRsCtaCte = Nothing
   mPorTransaccion = True
   
   mSaldoAReimputarPesos = 0
   mSaldoAReimputarDolar = 0
   mSaldoAReimputarEuro = 0
   MnuDetA(0).Enabled = True
   MnuDetA(1).Enabled = False
   mEnProcesoDeReimputacion = False
   lblImputacion.Visible = False

End Sub

Public Sub CrearTransaccion(ByVal oL As ListItem)

   Dim mvarSeguro As Integer
   mvarSeguro = MsgBox("Desea crear una transaccion nueva ?", vbYesNo, "Crear transaccion")
   If mvarSeguro = vbNo Then
      Exit Sub
   End If
   
   Dim mIdCtaCte As Long
   
   mIdCtaCte = Val(oL.Tag)

   Aplicacion.Tarea "CtasCtesA_CrearTransaccion", Array(mIdCtaCte, mIdCtaCte)
   
   PorTransacciones mSoloPendiente, mMoneda
   Lista.ListItems.Clear
   Lista.Sorted = False
   If Not oRsCtaCte Is Nothing Then
      If oRsCtaCte.RecordCount > 0 Then Set Lista.DataSource = oRsCtaCte
   End If
   Set oRsCtaCte = Nothing
   mPorTransaccion = True
   
End Sub

Public Sub InformacionCondiciones(ByVal IdCtaCte As Long)

   On Error Resume Next
   
   If Check1.Value = 1 Then
      If oFrmCondiciones Is Nothing Then
         Dim oControl As Control
         Set oFrmCondiciones = New frm_Aux
         With oFrmCondiciones
            For Each oControl In .Controls
               oControl.Visible = False
            Next
            .Width = .Width * 1.11
            .Height = .Height
            .Lista.Top = 0
            .Lista.Left = 0
            .Lista.Width = .Width
            .Lista.Height = .Height
            .Lista.Sorted = False
            .Lista.Visible = True
            .Caption = "Saldos x vencimiento"
            .Show , Me
         End With
      End If
      Dim oRs As ADOR.Recordset
      oFrmCondiciones.Lista.ListItems.Clear
      Set oRs = Aplicacion.TablasGenerales.DesgloseVencimientosComprobantes("A", IdCtaCte)
      If Not oRs Is Nothing Then
         If oRs.RecordCount > 0 Then oRs.MoveFirst
      End If
      Set oFrmCondiciones.Lista.DataSource = oRs
      Set oRs = Nothing
   End If

End Sub

Public Sub CalcularSaldosTransaccion(ByRef oRsCtaCte As ADOR.Recordset, ByVal Trs As Long)

   Dim mPosOriginal As Long, mPosTrs As Long, mIdCtaCte As Long
   Dim mSaldo As Double, mSaldoAux As Double
   
   mPosOriginal = 0
   With oRsCtaCte
      If .RecordCount > 0 Then
         mPosOriginal = .AbsolutePosition
         .MoveFirst
         Do While Not .EOF
            If Trs = IIf(IsNull(.Fields("IdImputacion").Value), -1, .Fields("IdImputacion").Value) Then
               mSaldo = IIf(IsNull(.Fields("Saldo Comp.").Value), 0, .Fields("Saldo Comp.").Value)
               If mSaldo <> 0 Then
                  mIdCtaCte = .Fields(0).Value
                  mPosTrs = .AbsolutePosition
                  .MoveFirst
                  Do While Not .EOF
                     If Trs = IIf(IsNull(.Fields("IdImputacion").Value), -1, .Fields("IdImputacion").Value) And _
                           IIf(IsNull(.Fields("Saldo Comp.").Value), 0, .Fields("Saldo Comp.").Value) <> 0 And _
                           mIdCtaCte <> .Fields(0).Value And mSaldo <> 0 Then
                        mSaldoAux = IIf(IsNull(.Fields("Saldo Comp.").Value), 0, .Fields("Saldo Comp.").Value)
                        If mSaldo > 0 And mSaldoAux < 0 Then
                           If Abs(mSaldo) > Abs(mSaldoAux) Then
                              mSaldo = mSaldo - Abs(mSaldoAux)
                              .Fields("Saldo Comp.").Value = 0
                           Else
                              .Fields("Saldo Comp.").Value = mSaldoAux + mSaldo
                              mSaldo = 0
                           End If
                        ElseIf mSaldo < 0 And mSaldoAux > 0 Then
                           If Abs(mSaldo) > Abs(mSaldoAux) Then
                              mSaldo = mSaldo + mSaldoAux
                              .Fields("Saldo Comp.").Value = 0
                           Else
                              .Fields("Saldo Comp.").Value = mSaldoAux + mSaldo
                              mSaldo = 0
                           End If
                        End If
                        .Update
                     End If
                     .MoveNext
                  Loop
                  .AbsolutePosition = mPosTrs
                  .Fields("Saldo Comp.").Value = mSaldo
                  .Update
               End If
            End If
            .MoveNext
         Loop
         If mPosOriginal > 0 Then
            .AbsolutePosition = mPosOriginal
         End If
      End If
   End With

End Sub

Public Sub AgruparItemsEnTransaccion()

   Dim Filas, Columnas
   Dim s As String
   Dim i As Integer
   Dim mIdImputacion As Long
   Dim mFecha As Date
   
   s = Lista.GetString
   
   Filas = VBA.Split(s, vbCrLf)
   If UBound(Filas) <= 1 Then
      MsgBox "Debe seleccionar al menos 2 items para agrupar", vbExclamation
      Exit Sub
   End If

   mIdImputacion = 0
   mFecha = DateSerial(1900, 1, 1)
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      If IsDate(Columnas(6)) And IsNumeric(Columnas(8)) Then
         If CDate(Columnas(6)) > mFecha And CDbl(Columnas(8)) <= 0 Then
            mFecha = CDate(Columnas(6))
            mIdImputacion = Val(Columnas(12))
         End If
      End If
   Next
   If mIdImputacion = 0 Then
      For i = 1 To UBound(Filas)
         Columnas = VBA.Split(Filas(i), vbTab)
         If Val(Columnas(11)) <> 0 Then
            mIdImputacion = Val(Columnas(12))
            Exit For
         End If
      Next
   End If
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      If Len(Columnas(18)) <> 0 Then Aplicacion.Tarea "CtasCtesA_CrearTransaccion", Array(Columnas(18), mIdImputacion)
   Next
   cmd_Click (0)

End Sub
