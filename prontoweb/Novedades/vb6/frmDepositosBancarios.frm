VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmDepositosBancarios 
   Caption         =   "Depositos bancarios"
   ClientHeight    =   6630
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9705
   Icon            =   "frmDepositosBancarios.frx":0000
   LinkTopic       =   "Form1"
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   6630
   ScaleWidth      =   9705
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtCotizacionMoneda 
      Alignment       =   1  'Right Justify
      DataField       =   "CotizacionMoneda"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   5040
      TabIndex        =   23
      Top             =   5805
      Width           =   1275
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Anular"
      Enabled         =   0   'False
      Height          =   420
      Index           =   2
      Left            =   2520
      TabIndex        =   17
      Top             =   5850
      Width           =   1155
   End
   Begin VB.TextBox txtEfectivo 
      Alignment       =   1  'Right Justify
      DataField       =   "Efectivo"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   8175
      TabIndex        =   16
      Top             =   5400
      Width           =   1155
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   1
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   2
      EndProperty
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
      Left            =   8190
      TabIndex        =   11
      Top             =   5805
      Width           =   1140
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   420
      Index           =   1
      Left            =   1305
      TabIndex        =   5
      Top             =   5850
      Width           =   1155
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   90
      TabIndex        =   4
      Top             =   5850
      Width           =   1155
   End
   Begin VB.TextBox txtNumeroDeposito 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroDeposito"
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
      Top             =   495
      Width           =   1425
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   690
      Left            =   90
      TabIndex        =   3
      Top             =   1260
      Width           =   9510
      _ExtentX        =   16775
      _ExtentY        =   1217
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmDepositosBancarios.frx":076A
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   6
      Top             =   6345
      Width           =   9705
      _ExtentX        =   17119
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaDeposito"
      Height          =   285
      Index           =   0
      Left            =   5040
      TabIndex        =   1
      Top             =   495
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   503
      _Version        =   393216
      Format          =   22347777
      CurrentDate     =   36377
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   1710
      Top             =   990
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
            Picture         =   "frmDepositosBancarios.frx":07EC
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDepositosBancarios.frx":08FE
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDepositosBancarios.frx":0D50
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDepositosBancarios.frx":11A2
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaBancaria"
      Height          =   315
      Index           =   0
      Left            =   5040
      TabIndex        =   2
      Tag             =   "Bancos"
      Top             =   855
      Width           =   4515
      _ExtentX        =   7964
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaBancaria"
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3345
      Left            =   90
      TabIndex        =   13
      Top             =   1980
      Width           =   9510
      _ExtentX        =   16775
      _ExtentY        =   5900
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmDepositosBancarios.frx":15F4
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   2340
      Top             =   990
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
            Picture         =   "frmDepositosBancarios.frx":1610
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDepositosBancarios.frx":1722
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDepositosBancarios.frx":1834
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDepositosBancarios.frx":1946
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDepositosBancarios.frx":1A58
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDepositosBancarios.frx":1B6A
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDepositosBancarios.frx":1C7C
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
      Width           =   9705
      _ExtentX        =   17119
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
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
      EndProperty
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCaja"
      Height          =   315
      Index           =   5
      Left            =   675
      TabIndex        =   19
      Tag             =   "Cajas"
      Top             =   5445
      Width           =   3210
      _ExtentX        =   5662
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCaja"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdMonedaEfectivo"
      Height          =   315
      Index           =   6
      Left            =   5040
      TabIndex        =   21
      Tag             =   "Monedas"
      Top             =   5445
      Width           =   1305
      _ExtentX        =   2302
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
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
   Begin VB.Label lblLabels 
      Caption         =   "Conv. a $ :"
      Height          =   255
      Index           =   6
      Left            =   3960
      TabIndex        =   24
      Top             =   5850
      Width           =   1005
   End
   Begin VB.Label lblLabels 
      Caption         =   "Mon. efectivo"
      Height          =   300
      Index           =   5
      Left            =   3960
      TabIndex        =   22
      Top             =   5445
      Width           =   1005
   End
   Begin VB.Label lblLabels 
      Caption         =   "Caja :"
      Height          =   300
      Index           =   15
      Left            =   135
      TabIndex        =   20
      Top             =   5445
      Width           =   465
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
      Left            =   8100
      TabIndex        =   18
      Top             =   495
      Visible         =   0   'False
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Deposito en efectivo :"
      Height          =   285
      Index           =   3
      Left            =   6435
      TabIndex        =   15
      Top             =   5445
      Width           =   1650
   End
   Begin VB.Label lblLabels 
      Caption         =   "Total depositado :"
      Height          =   285
      Index           =   2
      Left            =   6435
      TabIndex        =   12
      Top             =   5850
      Width           =   1650
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Numero de deposito :"
      Height          =   195
      Index           =   1
      Left            =   135
      TabIndex        =   10
      Top             =   540
      Width           =   1515
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   3420
      TabIndex        =   9
      Top             =   540
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Banco :"
      Height          =   240
      Index           =   7
      Left            =   3420
      TabIndex        =   8
      Top             =   900
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Observaciones :"
      Height          =   240
      Index           =   0
      Left            =   135
      TabIndex        =   7
      Top             =   990
      Width           =   1215
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   1
      End
   End
End
Attribute VB_Name = "frmDepositosBancarios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DepositoBancario
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mIdMonedaCuenta As Long
Private mvarStock As Double
Private mvarGrabado As Boolean
Private mvarAnulada As String
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

   If mvarId > 0 Then
      MsgBox "No puede modificar un deposito bancario ya registrado!", vbCritical
      Exit Sub
   End If
   
   Dim oF As frmValoresADepositar
   Set oF = New frmValoresADepositar
   With oF
      .Show vbModal, Me
   End With
   Unload oF
   Set oF = Nothing
   
   CalculaDepositoBancario

End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         If DTFields(0).Value <= gblFechaUltimoCierre And _
               Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
            MsgBox "La fecha no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation
            Exit Sub
         End If

         If Lista.ListItems.Count = 0 And Len(txtEfectivo.Text) = 0 Then
            MsgBox "No se puede almacenar un Deposito sin detalles"
            Exit Sub
         End If
         
         If Not IsNumeric(txtNumeroDeposito.Text) Then
            MsgBox "El numero de boleta de deposito debe ser un numero"
            Exit Sub
         End If
         
         If Len(Trim(txtNumeroDeposito.Text)) = 0 Then
            MsgBox "Debe ingresar el numero de boleta de deposito"
            Exit Sub
         End If
         
         If DataCombo1(0).Enabled And Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe ingresar la cuenta de banco"
            Exit Sub
         End If
         
         If DataCombo1(5).Enabled And Not IsNumeric(DataCombo1(5).BoundText) Then
            MsgBox "Debe ingresar la cuenta de caja desde donde sale el efectivo"
            Exit Sub
         End If
         
         If DataCombo1(6).Enabled And Not IsNumeric(DataCombo1(6).BoundText) Then
            MsgBox "Debe ingresar la moneda correspondiente al deposito en efectivo"
            Exit Sub
         End If
         
         If txtCotizacionMoneda.Enabled And Val(txtCotizacionMoneda.Text) <= 0 Then
            MsgBox "Debe ingresar la equivalencia a pesos de la moneda"
            Exit Sub
         End If
         
         Dim oRs As ADOR.Recordset
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim mvarImprime As Integer
     
         Set oRs = Aplicacion.DepositosBancarios.TraerFiltrado("_Validar", _
                     Array(mvarId, DataCombo1(0).BoundText, txtNumeroDeposito.Text))
         If oRs.RecordCount > 0 Then
            oRs.Close
            Set oRs = Nothing
            MsgBox "Ya existe un deposito con el mismo numero a la misma cuenta", vbExclamation
            Exit Sub
         End If
         oRs.Close
         
         With origen.Registro
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
            For Each dc In DataCombo1
               If dc.Enabled Or dc.Index = 0 Then
                  If Not IsNumeric(dc.BoundText) Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
                  .Fields(dc.DataField).Value = dc.BoundText
               End If
            Next
            Set oRs = Aplicacion.CuentasBancarias.TraerFiltrado("_PorId", DataCombo1(0).BoundText)
            If oRs.RecordCount > 0 Then
               .Fields("IdBanco").Value = oRs.Fields("IdBanco").Value
            End If
            oRs.Close
            Set oRs = Nothing
            .Fields("Observaciones").Value = rchObservaciones.Text
         End With
         
         Me.MousePointer = vbHourglass
         
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
            .ListaEditada = "DepositosBancariosTodos,+SubDP2"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
         Me.MousePointer = vbDefault
         
'         mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion del DepositoBancario")
'         If mvarImprime = vbYes Then
'            cmdImpre_Click
'         End If
      
         Unload Me
      
      Case 1
      
         Unload Me

      Case 2
   
         AnularDeposito
         
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   
   mvarId = vNewValue
   mvarAnulada = "NO"
   mIdMonedaCuenta = 0
   
   Set oAp = Aplicacion
   
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   With oRs
      gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)
   End With
   oRs.Close
   Set oRs = Nothing
   
   Set origen = oAp.DepositosBancarios.Item(vNewValue)
   
   Set oBind = New BindingCollection
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            If vNewValue < 0 Then
               Set oControl.DataSource = origen.DetDepositosBancarios.TraerMascara
            Else
               Set oControl.DataSource = origen.DetDepositosBancarios.TraerTodos
            End If
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Bancos" Then
                  Set oControl.RowSource = oAp.Bancos.TraerFiltrado("_PorCuentasBancarias")
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
   
   If mvarId < 0 Then
      origen.Registro.Fields("CotizacionMoneda").Value = 1
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      Lista.ListItems.Clear
      mvarGrabado = False
   Else
      With origen.Registro
         If Not IsNull(.Fields("Anulado").Value) And .Fields("Anulado").Value = "SI" Then
            With lblEstado
               .Caption = "ANULADO"
               .Visible = True
            End With
            mvarAnulada = "SI"
         End If
         If IsNull(.Fields("CotizacionMoneda").Value) Then
            .Fields("CotizacionMoneda").Value = 1
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
      txtNumeroDeposito.Enabled = False
      DTFields(0).Enabled = False
      DataCombo1(0).Enabled = False
      rchObservaciones.Enabled = False
      txtEfectivo.Enabled = False
      mvarGrabado = True
   End If
   
   Set oAp = Nothing

   CalculaDepositoBancario

   cmd(0).Enabled = False
   cmd(2).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      If mvarId > 0 Then cmd(2).Enabled = True
   End If
   If mvarId > 0 Then cmd(0).Enabled = False
   
   If mvarAnulada = "SI" Then
      cmd(0).Enabled = False
      cmd(2).Enabled = False
   Else
      If DTFields(0).Value <= gblFechaUltimoCierre And _
            Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
         cmd(0).Enabled = False
         cmd(2).Enabled = False
      End If
   End If

End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      Dim oRs As ADOR.Recordset
      If Index = 0 Then
         Set oRs = Aplicacion.CuentasBancarias.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
         If oRs.RecordCount > 0 Then
            mIdMonedaCuenta = IIf(IsNull(oRs.Fields("IdMoneda").Value), 0, oRs.Fields("IdMoneda").Value)
         End If
         oRs.Close
         DataCombo1(Index).Enabled = False
      ElseIf Index = 6 Then
         If mvarId <= 0 Then
            origen.Registro.Fields("CotizacionMoneda").Value = Cotizacion(DTFields(0).Value, DataCombo1(6).BoundText)
         End If
      End If
      Set oRs = Nothing
   End If
   
End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)

   SendKeys "%{DOWN}"

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DTFields_Change(Index As Integer)

   If Index = 0 Then
      If mvarId <= 0 Then
         If IsNumeric(DataCombo1(6).BoundText) Then
            origen.Registro.Fields("CotizacionMoneda").Value = Cotizacion(DTFields(0).Value, DataCombo1(6).BoundText)
         End If
      End If
   End If
   
End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Activate()
   
   CalculaDepositoBancario

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

Private Sub Form_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String, mError As String
   Dim Filas, Columnas
   Dim iFilas As Long, iColumnas As Long
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then ' si el dato es texto
      s = Data.GetData(ccCFText) ' tomo el dato
      Filas = Split(s, vbCrLf) ' armo un vector por filas
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      If Not InStr(1, Columnas(LBound(Columnas) + 1), "Nro.Int.") <> 0 Then
         MsgBox "Sólo puede arrastrar aqui elementos de la lista de valores a depositar"
         Exit Sub
      End If
      
      Set oAp = Aplicacion
      
      mError = ""
      For iFilas = LBound(Filas) + 1 To UBound(Filas)
         Columnas = Split(Filas(iFilas), vbTab)
         If Not origen.DetDepositosBancarios.RegistroExistente(Columnas(2)) Then
            Set oRs = oAp.Valores.Item(Columnas(2)).Registro
            If mIdMonedaCuenta <> 0 And oRs.Fields("IdMoneda").Value <> mIdMonedaCuenta Then
               mError = mError & vbCrLf & "El valor " & IIf(IsNull(oRs.Fields("NumeroValor").Value), "", oRs.Fields("NumeroValor").Value) & _
                              " no tiene la misma moneda de la cuenta bancaria y no fue tomado"
            Else
               If oRs.Fields("FechaValor").Value > DTFields(0).Value Then
                  mError = mError & vbCrLf & "El valor " & IIf(IsNull(oRs.Fields("NumeroValor").Value), "", oRs.Fields("NumeroValor").Value) & _
                                 " tiene fecha posterior a la fecha del deposito, el aviso es solo informativo"
               End If
               Set oL = Lista.ListItems.Add()
               With origen.DetDepositosBancarios.Item(-1)
                  .Registro.Fields("IdValor").Value = Columnas(2)
                  oL.Tag = .Id
                  oL.Text = IIf(IsNull(oRs.Fields("NumeroInterno").Value), "", oRs.Fields("NumeroInterno").Value)
                  oL.SubItems(1) = IIf(IsNull(oRs.Fields("NumeroValor").Value), "", oRs.Fields("NumeroValor").Value)
                  oL.SubItems(2) = oRs.Fields("FechaValor").Value
                  If Not IsNull(oRs.Fields("IdCliente").Value) Then
                     oL.SubItems(3) = oAp.Clientes.Item(oRs.Fields("IdCliente").Value).Registro.Fields("RazonSocial").Value
                  End If
                  If Not IsNull(oRs.Fields("IdBanco").Value) Then
                     oL.SubItems(4) = oAp.Bancos.Item(oRs.Fields("IdBanco").Value).Registro.Fields("Nombre").Value
                  End If
                  oL.SubItems(5) = Format(oRs.Fields("Importe").Value, "#,##0.00")
                  .Modificado = True
               End With
            End If
            oRs.Close
            Set oRs = Nothing
         End If
      Next
      Set oAp = Nothing
   
      If Len(mError) > 0 Then MsgBox mError, vbInformation
   End If

End Sub

Private Sub Form_OLEDragOver(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

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

Private Sub Form_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

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
      MnuDetA_Click 1
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetA_Click 0
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count = 0 Then
         MnuDetA(1).Enabled = False
         PopupMenu MnuDet, , , , MnuDetA(0)
      Else
         MnuDetA(1).Enabled = True
         PopupMenu MnuDet, , , , MnuDetA(1)
      End If
   End If

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

Private Sub CalculaDepositoBancario()

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim tDeposito As Double
   
   tDeposito = 0
   
   Set oAp = Aplicacion
   
   Set oRs = origen.DetDepositosBancarios.Registros
   
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If Not oRs.Fields("Eliminado").Value Then
               tDeposito = tDeposito + oAp.Valores.Item(oRs.Fields("IdValor").Value).Registro.Fields("Importe").Value
            End If
            oRs.MoveNext
         Loop
      End If
      oRs.Close
   End If
   
   If tDeposito = 0 Then
      Set oRs = origen.DetDepositosBancarios.TraerTodos
      If oRs.Fields.Count > 0 Then
         If oRs.RecordCount > 0 Then
            oRs.MoveFirst
            Do While Not oRs.EOF
               tDeposito = tDeposito + IIf(IsNull(oAp.Valores.Item(oRs.Fields("IdValor").Value).Registro.Fields("Importe").Value), 0, oAp.Valores.Item(oRs.Fields("IdValor").Value).Registro.Fields("Importe").Value)
               oRs.MoveNext
            Loop
         End If
         oRs.Close
      End If
   End If
   
   tDeposito = tDeposito + Val(txtEfectivo.Text)
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   txtTotal.Text = tDeposito
   
End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         With Lista.SelectedItem
            origen.DetDepositosBancarios.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   On Error GoTo Mal
   
   Select Case Button.Key
      Case "Imprimir"
         ImprimirConExcel Lista, "DEPOSITO BANCARIO|" & "Banco : " & DataCombo1(0).Text & "|" & _
                                 "Numero : " & txtNumeroDeposito.Text & "|" & _
                                 "Fecha :" & DTFields(0).Value & "|" & _
                                 "Deposito en efectivo : " & txtEfectivo.Text & " " & _
                                 DataCombo1(6).Text & " - Caja : " & DataCombo1(5).Text & "|" & _
                                 "TOTAL DEPOSITO : " & txtTotal.Text
      
      Case "Buscar"
         FiltradoLista Lista
'         StatusBar1.Panels(2).Text = " " & Lista.ListItems.Count & " elementos en la lista"

      Case "Excel"
         ExportarAExcel Lista, "DEPOSITO BANCARIO|" & "Banco : " & DataCombo1(0).Text & "|" & _
                                 "Numero : " & txtNumeroDeposito.Text & "|" & _
                                 "Fecha :" & DTFields(0).Value & "|" & _
                                 "Deposito en efectivo : " & txtEfectivo.Text & " " & _
                                 DataCombo1(6).Text & " - Caja : " & DataCombo1(5).Text & "|" & _
                                 "TOTAL DEPOSITO : " & txtTotal.Text
   End Select

   Exit Sub
   
Mal:

   If Err.Number = -2147217825 Then
      MsgBox "No puede utilizar la opcion BUSCAR en un campo numerico, use otro operador", vbExclamation
   Else
      MsgBox "Se ha producido un error al buscar ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical
   End If

End Sub

Private Sub txtEfectivo_Change()

   If Val(txtEfectivo.Text) <> 0 Then
      DataCombo1(5).Enabled = True
      DataCombo1(6).Enabled = True
      txtCotizacionMoneda.Enabled = True
   Else
      DataCombo1(5).Enabled = False
      DataCombo1(6).Enabled = False
      txtCotizacionMoneda.Enabled = False
      With origen.Registro
         .Fields("IdCaja").Value = Null
         .Fields("IdMonedaEfectivo").Value = Null
         .Fields("CotizacionMoneda").Value = 1
         .Fields("Efectivo").Value = Null
      End With
   End If
   CalculaDepositoBancario
   
End Sub

Private Sub txtEfectivo_GotFocus()

   With txtEfectivo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtEfectivo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroDeposito_GotFocus()

   With txtNumeroDeposito
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroDeposito_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Sub AnularDeposito()

   Dim oF As frmAutorizacion
   Dim mOk As Boolean
   Dim mIdAutorizaAnulacion As Integer
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.DepositosBancarios
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
   mSeguro = MsgBox("Esta seguro de anular el deposito?", vbYesNo, "Anulacion de deposito bancario")
   If mSeguro = vbNo Then
      Exit Sub
   End If

   With origen
      .Registro.Fields("Anulado").Value = "OK"
      .Registro.Fields("IdAutorizaAnulacion").Value = mIdAutorizaAnulacion
      .Registro.Fields("FechaAnulacion").Value = Now
      .Guardar
   End With

   Unload Me

End Sub
