VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmReservas 
   Caption         =   "Reservas de stock"
   ClientHeight    =   6315
   ClientLeft      =   60
   ClientTop       =   630
   ClientWidth     =   11580
   Icon            =   "frmReservas.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6315
   ScaleWidth      =   11580
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame2 
      Caption         =   "Tipo de reserva :"
      Enabled         =   0   'False
      Height          =   1005
      Left            =   9855
      TabIndex        =   11
      Top             =   450
      Visible         =   0   'False
      Width           =   1635
      Begin VB.OptionButton Option2 
         Caption         =   "Automatica"
         Height          =   195
         Left            =   135
         TabIndex        =   13
         Top             =   630
         Width           =   1140
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Manual"
         Height          =   195
         Left            =   135
         TabIndex        =   12
         Top             =   315
         Width           =   1320
      End
   End
   Begin VB.TextBox txtNumeroReserva 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroReserva"
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
      Top             =   45
      Width           =   1095
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   90
      TabIndex        =   3
      Top             =   5490
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   420
      Index           =   1
      Left            =   1620
      TabIndex        =   4
      Top             =   5490
      Width           =   1470
   End
   Begin VB.CommandButton cmdImpre 
      Enabled         =   0   'False
      Height          =   420
      Left            =   3150
      Picture         =   "frmReservas.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   5490
      UseMaskColor    =   -1  'True
      Width           =   1470
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1050
      Left            =   1800
      TabIndex        =   2
      Top             =   450
      Width           =   7935
      _ExtentX        =   13996
      _ExtentY        =   1852
      _Version        =   393217
      TextRTF         =   $"frmReservas.frx":0DD4
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   6
      Top             =   6030
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
      Left            =   9270
      Top             =   5400
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
            Picture         =   "frmReservas.frx":0E56
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReservas.frx":0F68
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReservas.frx":13BA
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReservas.frx":180C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaReserva"
      Height          =   330
      Index           =   0
      Left            =   4365
      TabIndex        =   1
      Top             =   45
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   64225281
      CurrentDate     =   36377
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3885
      Left            =   45
      TabIndex        =   10
      Top             =   1530
      Width           =   11490
      _ExtentX        =   20267
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
      MouseIcon       =   "frmReservas.frx":1C5E
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Reserva de stock nro.:"
      Height          =   195
      Index           =   14
      Left            =   135
      TabIndex        =   9
      Top             =   90
      Width           =   1620
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   3600
      TabIndex        =   8
      Top             =   90
      Width           =   720
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Observaciones :"
      Height          =   240
      Index           =   0
      Left            =   135
      TabIndex        =   7
      Top             =   495
      Width           =   1620
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalles"
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
         Caption         =   "Anular"
         Index           =   3
      End
   End
   Begin VB.Menu MnuDetC 
      Caption         =   "Consultas"
      Begin VB.Menu MnuDetCon 
         Caption         =   "Stock actual"
         Index           =   0
      End
   End
End
Attribute VB_Name = "frmReservas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Reserva
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long
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

   If mvarId > 0 And Cual = -1 Then
      MsgBox "No puede modificar una reserva ya registrada, eliminela.", vbCritical
      Exit Sub
   End If
   
   Dim oF As frmDetReservas
   Dim oL As ListItem
   
   Set oF = New frmDetReservas
   
   With oF
      Set .Reserva = origen
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
            .Text = oF.DataCombo1(1).Text
'            .SubItems(1) = "" & of.txtPartida.Text
            .SubItems(2) = "" & oF.txtCantidad.Text
            If oF.mvarCantidadAdicional <> 0 Then
               .SubItems(3) = "" & oF.txtCantidad1.Text
               .SubItems(4) = "" & oF.txtCantidad2.Text
            End If
            .SubItems(5) = "" & Aplicacion.Unidades.Item(oF.mvarIdUnidad).Registro.Fields("Descripcion").Value
            .SubItems(6) = "" & oF.txtRetirada
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Sub EditarConsulta(ByVal Item As Long)

   Select Case Item
      
      Case 0
         Dim oF As frmConsulta1
         Set oF = New frmConsulta1
         With oF
            .Id = 1
            .Show vbModal, Me
         End With
         Unload oF
         Set oF = Nothing
         
   End Select
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
      
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar una reserva de stock sin detalles"
            Exit Sub
         End If
         
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim mNum As Long
         Dim oPar As ComPronto.Parametro
         
         With origen.Registro
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
            If Option1.Value Then
               .Fields("Tipo").Value = "M"
            Else
               .Fields("Tipo").Value = "A"
            End If
            .Fields("Observaciones").Value = rchObservaciones.Text
         End With
         
         If mvarId < 0 Then
            Set oPar = Aplicacion.Parametros.Item(1)
            With oPar.Registro
               mNum = .Fields("ProximoNumeroReservaStock").Value
               origen.Registro.Fields("NumeroReserva").Value = mNum
               .Fields("ProximoNumeroReservaStock").Value = mNum + 1
            End With
            oPar.Guardar
            Set oPar = Nothing
         Else
            est = Modificacion
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
            
         With actL2
            .ListaEditada = "Reservas"
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
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   Dim ListaVacia As Boolean
   
   mvarId = vnewvalue
   
   ListaVacia = False
   
   Set oAp = Aplicacion
   Set origen = oAp.Reservas.Item(vnewvalue)
   
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetReservas.TraerMascara
                     ListaVacia = True
                  Else
                     Set oRs = origen.DetReservas.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia = False
                     Else
                        Set oControl.DataSource = origen.DetReservas.TraerMascara
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
      Set oPar = oAp.Parametros.Item(1)
      origen.Registro.Fields("NumeroReserva").Value = oPar.Registro.Fields("ProximoNumeroReservaStock").Value
      Set oPar = Nothing
      Option1.Value = True
   Else
      DTFields(0).Enabled = False
      With origen.Registro
         If .Fields("Tipo").Value = "M" Then
            Option1.Value = True
         Else
            Option2.Value = True
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
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
   
End Property

Private Sub cmdImpre_Click()

   Dim oW As Word.Application
   Dim oRs, oRsDet, oRsArt As ADOR.Recordset
   Dim i As Integer
   Dim mvarArticulo, mvarUnidad, mvarMedidas As String
   
   Me.MousePointer = vbHourglass
      
   Set oW = CreateObject("Word.Application")
   
   With oW
      
      .Visible = False
      
      With .Documents.Add(glbPathPlantillas & "\Reserva.dot")
   
         Set oRs = origen.Registro
         Set oRsDet = origen.DetReservas.TraerTodos
         
         ' Armar el detalle
         oW.Selection.HomeKey Unit:=wdStory
         oW.Selection.MoveDown Unit:=wdLine, Count:=3
         oW.Selection.MoveLeft Unit:=wdCell, Count:=1
          
          ' estot ubicado al final del texto fijo
         With oRsDet
            Do Until .EOF
               Set oRsArt = Aplicacion.Articulos.Item(oRsDet.Fields("IdArticulo").Value).Registro
               mvarArticulo = oRsArt.Fields("Descripcion").Value
               mvarMedidas = ""
               If Not IsNull(oRsArt.Fields("IdCuantificacion").Value) Then
                  If Not IsNull(oRsArt.Fields("Unidad11").Value) Then
                     mvarUnidad = Aplicacion.Unidades.Item(oRsArt.Fields("Unidad11").Value).Registro.Fields("Descripcion").Value
                  End If
                  Select Case oRsArt.Fields("IdCuantificacion").Value
                     Case 3
                        mvarMedidas = "" & oRsDet.Fields("Med.1").Value & " x " & oRsDet.Fields("Med.2").Value & " " & mvarUnidad
                     Case 2
                        mvarMedidas = "" & oRsDet.Fields("Med.1").Value & " " & mvarUnidad
                  End Select
               End If
               oRsArt.Close
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & .Fields("Cant.").Value
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & mvarMedidas
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & .Fields("Partida").Value
               oW.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:=mvarArticulo
               .MoveNext
            Loop
         End With
          
         'Registro de numero de paginas, fecha y hora
         oW.Application.Run MacroName:="DatosDelPie"
          
         'Volcado de datos de cabecera de la reserva de stock
         oW.ActiveDocument.FormFields("Numero").Result = oRs.Fields("NumeroReserva").Value
         oW.ActiveDocument.FormFields("Fecha").Result = oRs.Fields("FechaReserva").Value
          
         oRsDet.Close
         Set oRsDet = Nothing
         Set oRsArt = Nothing
          
         oW.ActiveDocument.PrintOut False
       
         .Close False
      
      End With
      
      .Quit
      
   End With
   
   Set oW = Nothing

   Me.MousePointer = vbDefault
      
End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   For Each oI In Img16.ListImages
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

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         Editar Lista.SelectedItem.Tag
      Case 2
         If mvarId > 0 Then
            MsgBox "No puede modificar una reserva ya registrada, eliminela.", vbCritical
            Exit Sub
         End If
         With Lista.SelectedItem
            origen.DetReservas.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
      Case 3
         With Lista.SelectedItem
            If Not IsNull(origen.DetReservas.Item(.Tag).Registro.Fields("Estado").Value) Then
               MsgBox "El item ya fue entregado, imposible anular!", vbCritical
               Exit Sub
            End If
            origen.DetReservas.Item(.Tag).Registro.Fields("Estado").Value = "AN"
            origen.DetReservas.Item(.Tag).Modificado = True
            .SubItems(7) = "AN"
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub MnuDetCon_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarConsulta Index
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

Private Sub txtNumeroReserva_GotFocus()

   With txtNumeroReserva
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroReserva_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub


