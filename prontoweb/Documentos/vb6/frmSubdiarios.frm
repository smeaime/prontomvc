VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmSubdiarios 
   Caption         =   "Subdiarios"
   ClientHeight    =   6210
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10650
   Icon            =   "frmSubdiarios.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6210
   ScaleWidth      =   10650
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtPeriodo 
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
      Left            =   7290
      Locked          =   -1  'True
      TabIndex        =   7
      Top             =   540
      Width           =   2070
   End
   Begin VB.TextBox txtSubdiario 
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
      Left            =   1620
      Locked          =   -1  'True
      TabIndex        =   6
      Top             =   540
      Width           =   4455
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   420
      Index           =   0
      Left            =   90
      TabIndex        =   5
      Top             =   5445
      Width           =   1470
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
      Height          =   360
      Index           =   0
      Left            =   6930
      TabIndex        =   4
      Top             =   5445
      Width           =   1545
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
      Height          =   360
      Index           =   1
      Left            =   8550
      TabIndex        =   3
      Top             =   5445
      Width           =   1545
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   2
      Top             =   5925
      Width           =   10650
      _ExtentX        =   18785
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   10583
            MinWidth        =   10583
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   4470
      Left            =   45
      TabIndex        =   8
      Top             =   945
      Width           =   10545
      _ExtentX        =   18600
      _ExtentY        =   7885
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmSubdiarios.frx":076A
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   5400
      Top             =   5355
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
            Picture         =   "frmSubdiarios.frx":0786
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubdiarios.frx":0898
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubdiarios.frx":09AA
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubdiarios.frx":0ABC
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubdiarios.frx":0BCE
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubdiarios.frx":0CE0
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubdiarios.frx":0DF2
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   9
      Top             =   0
      Width           =   10650
      _ExtentX        =   18785
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
   Begin MSComctlLib.ImageList Img16 
      Left            =   4815
      Top             =   5355
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
            Picture         =   "frmSubdiarios.frx":1244
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubdiarios.frx":1356
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubdiarios.frx":17A8
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSubdiarios.frx":1BFA
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Mes y año :"
      Height          =   240
      Index           =   0
      Left            =   6300
      TabIndex        =   1
      Top             =   585
      Width           =   825
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Subdiario :"
      Height          =   240
      Index           =   5
      Left            =   720
      TabIndex        =   0
      Top             =   585
      Width           =   795
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
         Caption         =   "Editar comprobante"
         Index           =   3
      End
   End
End
Attribute VB_Name = "frmSubdiarios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Subdiario
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim WithEvents ActL As ControlForm
Attribute ActL.VB_VarHelpID = -1
Private mvarId As Long, mIdCuentaSubdiario As Long, Mes As Long, Anio As Long
Private mvarGrabado As Boolean
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

   If mNivelAcceso <> 1 Then
      MsgBox "Permiso insuficiente para la operacion", vbCritical
      Exit Sub
   End If
   
'   If Not IsNull(origen.Registro.Fields("IdCuentaSubdiario").Value) Then
'      MsgBox "No puede modificar un Subdiario generado desde un subdiario!", vbCritical
'      Exit Sub
'   End If
   
   Dim oF As frmDetSubdiarios
   Dim oL As ListItem
   Dim oRsSub As ADOR.Recordset
   
   Set oF = New frmDetSubdiarios
   
   With oF
      .IdCuentaSubdiario = mIdCuentaSubdiario
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oRsSub = Aplicacion.Subdiarios.TraerFiltrado("Sub", Array(Mes, Anio, mIdCuentaSubdiario))
            Lista.Sorted = False
            Set Lista.DataSource = oRsSub
            Set oRsSub = Nothing
            GoTo Salida
         Else
            Set oL = Lista.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtCodigo.Text
            .SubItems(1) = "" & oF.txtCT.Text
            .SubItems(2) = "" & oF.txtTC.Text
            .SubItems(3) = "" & Format(Val(oF.txtNumeroComprobante.Text), "General Number")
            .SubItems(4) = "" & oF.DTFields(0).Value
            If Val(oF.txtDebe.Text) <> 0 Then
               .SubItems(5) = "" & Format(Val(oF.txtDebe.Text), "Currency")
               .SubItems(6) = ""
            Else
               .SubItems(6) = "" & Format(Val(oF.txtHaber.Text), "Currency")
               .SubItems(5) = ""
            End If
         End With
      End If
   End With
   
Salida:

   Unload oF
   
   Set oF = Nothing
   
   CalculaSubdiario

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRsSub As ADOR.Recordset
   Dim IdCta As Long
   Dim tDebe As Double, tHaber As Double
   
   Set oAp = Aplicacion
   Set oRs = oAp.Subdiarios.Item(vnewvalue).Registro
   
   If Not IsNull(oRs.Fields("IdCuentaSubdiario").Value) Then
      Set oRsSub = oAp.TablasGenerales.TraerFiltrado("Titulos", "_PorId", oRs.Fields("IdCuentaSubdiario").Value)
      If oRsSub.RecordCount > 0 Then
         txtSubdiario.Text = IIf(IsNull(oRsSub.Fields("Titulo").Value), "", oRsSub.Fields("Titulo").Value)
      End If
      oRsSub.Close
      txtPeriodo.Text = NombreMes(Month(oRs.Fields("FechaComprobante").Value)) & " " & Year(oRs.Fields("FechaComprobante").Value)
   End If
   tDebe = 0
   tHaber = 0
   
   If oRs.RecordCount > 0 And Not IsNull(oRs.Fields("IdCuentaSubdiario").Value) Then
      mIdCuentaSubdiario = oRs.Fields("IdCuentaSubdiario").Value
      Mes = Month(oRs.Fields("FechaComprobante").Value)
      Anio = Year(oRs.Fields("FechaComprobante").Value)
      Set oRsSub = oAp.Subdiarios.TraerFiltrado("Sub", Array(Mes, Anio, mIdCuentaSubdiario))
      oRsSub.MoveFirst
      Do While Not oRsSub.EOF
         If Not IsNull(oRsSub.Fields("Debe").Value) Then
            tDebe = tDebe + oRsSub.Fields("Debe").Value
         End If
         If Not IsNull(oRsSub.Fields("Haber").Value) Then
            tHaber = tHaber + oRsSub.Fields("Haber").Value
         End If
         oRsSub.MoveNext
      Loop
      oRsSub.MoveFirst
      txtTotal(0).Text = Format(tDebe, "#,##0.00")
      txtTotal(1).Text = Format(tHaber, "#,##0.00")
      Lista.Sorted = False
      Set Lista.DataSource = oRsSub
      Lista.Refresh
      
      Estado.Panels(1).Text = " " & Lista.ListItems.Count & " elementos en la lista"
   
'      oRsSub.Close
      Set oRsSub = Nothing
   Else
      mIdCuentaSubdiario = 0
      Mes = 0
      Anio = 0
   End If
   oRs.Close
   
   Set oRs = Nothing
   Set oAp = Nothing

End Property

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         With actL2
            .ListaEditada = "+SubSd2"
            .AccionRegistro = EnumAcciones.Modificacion
            .Disparador = mIdCuentaSubdiario
         End With
         Unload Me
   End Select

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
'   For Each oI In Img16.ListImages
'      With Estado.Panels.Add(, , oI.Key)
'         .Picture = oI.Picture
'      End With
'   Next

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set ActL = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub Lista_DblClick()

   If Lista.ListItems.Count = 0 Then
      Editar -1
   Else
      EditarComprobante Lista.SelectedItem.SubItems(1), Lista.SelectedItem.SubItems(2)
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

Private Sub CalculaSubdiario()

   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.Subdiarios.TraerFiltrado("_TotalesPorIdCuentaSubdiario", Array(Mes, Anio, mIdCuentaSubdiario))
   txtTotal(0).Text = 0
   txtTotal(1).Text = 0
   If oRs.RecordCount > 0 Then
      txtTotal(0).Text = Format(IIf(IsNull(oRs.Fields("Debe").Value), 0, oRs.Fields("Debe").Value), "#,##0.00")
      txtTotal(1).Text = Format(IIf(IsNull(oRs.Fields("Haber").Value), 0, oRs.Fields("Haber").Value), "#,##0.00")
   End If
   oRs.Close
   Set oRs = Nothing
   
End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         Editar Lista.SelectedItem.Tag
      Case 2
'         If Not IsNull(origen.Registro.Fields("IdCuentaSubdiario").Value) Then
'            MsgBox "No puede modificar un Subdiario generado desde un subdiario!", vbCritical
'            Exit Sub
'         End If
         With Lista.SelectedItem
'            Origen.DetSubdiarios.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
      Case 3
         If Not Lista.SelectedItem Is Nothing Then
            EditarComprobante Lista.SelectedItem.SubItems(1), Lista.SelectedItem.SubItems(2)
         End If
   End Select

End Sub

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Key
      Case "Imprimir"
         ImprimirConExcel Lista, Me.txtSubdiario.Text & " " & NombreMes(Mes) & _
                        " del " & Anio, _
                        "ResumenSubdiario|" & mIdCuentaSubdiario & "," & Mes & "," & Anio, _
                        "SaltoDePaginaCada:-1" & _
                        "|SumadorPorHoja1:6" & _
                        "|SumadorPorHoja2:7" & _
                        "|Enc:SinFecha"
      Case "Buscar"
         FiltradoLista Lista
      Case "Excel"
         ExportarAExcel Lista, Me.txtSubdiario.Text & " " & NombreMes(Mes) & _
                        " del " & Anio, _
                        "ResumenSubdiario|" & mIdCuentaSubdiario & "," & Mes & "," & Anio, _
                        "SaltoDePaginaCada:-1" & _
                        "|SumadorPorHoja1:6" & _
                        "|SumadorPorHoja2:7" & _
                        "|Enc:SinFecha"
   End Select

End Sub

Private Sub EditarComprobante(ByVal TipoComprobante As Long, ByVal Identificador As Long)

   Dim oF As Form
      
   Select Case TipoComprobante
      Case 1
         Set oF = New frmFacturas
      Case 2
         Set oF = New frmRecibos
      Case 3
         Set oF = New frmNotasDebito
      Case 4
         Set oF = New frmNotasCredito
      Case 5
         Set oF = New frmDevoluciones
      Case 10, 11, 13, 18, 19
         Set oF = New frmComprobantesPrv
      Case 17
         Set oF = New frmOrdenesPago
      Case 28, 29
         Set oF = New frmValoresGastos
      Case 39
         Set oF = New FrmPlazosFijos
      
      Case Else
         MsgBox "Comprobante no editable"
         GoTo Salida:
   End Select
   
   With oF
      .Id = Identificador
      .Disparar = ActL
      .Show , Me
   End With

Salida:

   Set oF = Nothing

End Sub



