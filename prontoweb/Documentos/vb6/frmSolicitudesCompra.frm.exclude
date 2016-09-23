VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmSolicitudesCompra 
   Caption         =   "Solicitud de compra"
   ClientHeight    =   5085
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11580
   Icon            =   "frmSolicitudesCompra.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5085
   ScaleWidth      =   11580
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "Ver RM's "
      Height          =   375
      Index           =   2
      Left            =   2160
      TabIndex        =   8
      Top             =   4635
      Width           =   930
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   375
      Index           =   1
      Left            =   1125
      TabIndex        =   5
      Top             =   4635
      Width           =   930
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   375
      Index           =   0
      Left            =   90
      TabIndex        =   4
      Top             =   4635
      Width           =   930
   End
   Begin VB.TextBox txtNumeroSolicitud 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroSolicitud"
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
      Left            =   1395
      TabIndex        =   0
      Top             =   45
      Width           =   1095
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaSolicitud"
      Height          =   330
      Index           =   0
      Left            =   3645
      TabIndex        =   1
      Top             =   45
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   68485121
      CurrentDate     =   36377
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   6210
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSolicitudesCompra.frx":076A
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSolicitudesCompra.frx":087C
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSolicitudesCompra.frx":0CCE
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSolicitudesCompra.frx":1120
            Key             =   "Original"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSolicitudesCompra.frx":1572
            Key             =   "ItemManual"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3795
      Left            =   45
      TabIndex        =   6
      Top             =   765
      Width           =   11445
      _ExtentX        =   20188
      _ExtentY        =   6694
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmSolicitudesCompra.frx":19C4
      OLEDragMode     =   1
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle de items"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Index           =   5
      Left            =   90
      TabIndex        =   7
      Top             =   540
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   4
      Left            =   2925
      TabIndex        =   3
      Top             =   90
      Width           =   585
   End
   Begin VB.Label lblLabels 
      Caption         =   "Solicitud nro. :"
      Height          =   240
      Index           =   14
      Left            =   135
      TabIndex        =   2
      Top             =   90
      Width           =   1095
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Modificar"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   1
      End
   End
End
Attribute VB_Name = "frmSolicitudesCompra"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.SolicitudCompra
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long
Private mvarGrabado As Boolean, mvarModificado As Boolean, mvarAnulada As Boolean
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
      MsgBox "No puede modificar una solicitud de compra ya registrada!", vbCritical
      Exit Sub
   End If
   
   Dim oF As frmDetSolicitudesCompra
   Dim oL As ListItem
   
   Set oF = New frmDetSolicitudesCompra
   
   With oF
      Set .SolicitudCompra = origen
      .Id = Cual
      .CantidadPendiente = Lista.SelectedItem.SubItems(4)
      .Show vbModal, Me
      If .Aceptado Then
         mvarModificado = True
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
            .SubItems(5) = "" & oF.txtCantidad.Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Dim mvarSale As Integer
   Dim mIdAutorizo As Long
   Dim oL As ListItem
   
   Select Case Index
   
      Case 0
      
         If mvarId < 0 And Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar una solicitud de compra sin detalles"
            Exit Sub
         End If
         
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim mvarImprime As Integer, mResp As Integer, i As Integer
         Dim mCumplido As Boolean, mConfirmado As Boolean
         Dim oRs As ADOR.Recordset
         Dim mNum As Long
         
         With origen.Registro
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
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
            mvarGrabado = True
         Else
            est = Modificacion
         End If
         
         mvarModificado = False
         
         If Not actL2 Is Nothing Then
            With actL2
               .ListaEditada = "SolicitudesCompraTodos,+SubSC2"
               .AccionRegistro = est
               .Disparador = mvarId
            End With
         End If
         
'         mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de SolicitudCompra de materiales")
'         If mvarImprime = vbYes Then
'            cmdImpre_Click (0)
'         End If
      
         Unload Me

      Case 1
      
         If mvarModificado And Not mvarAnulada Then
            mvarSale = MsgBox("Hay datos no grabados, desea salir igual ?", vbYesNo, "Salir")
            If mvarSale = vbNo Then
               Exit Sub
            End If
            mvarModificado = False
         End If
   
         Unload Me

      Case 2

         Dim oF As Form
         Set oF = New frmConsulta2
         With oF
            .Id = 78
            .Show , Me
         End With
         Set oF = Nothing


   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oDet As DetSolicitudCompra
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset, oRsAut As ADOR.Recordset
   Dim oL As ListItem
   Dim dtf As DTPicker
   Dim dc As DataCombo
   Dim ListaVacia As Boolean
   Dim i As Integer
   
   mvarId = vnewvalue
   
   ListaVacia = False
   mvarModificado = False
   mvarAnulada = False
   
   Lista.Sorted = False
   
   Set oAp = Aplicacion
   
   Set origen = oAp.SolicitudesCompra.Item(vnewvalue)
   
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetSolicitudesCompra.TraerMascara
                     ListaVacia = True
                  Else
                     Set oRs = origen.DetSolicitudesCompra.TraerTodos
                     If Not oRs Is Nothing Then
                        If oRs.RecordCount <> 0 Then
                           Set oControl.DataSource = oRs
                           oRs.MoveFirst
                           Do While Not oRs.EOF
                              Set oDet = origen.DetSolicitudesCompra.Item(oRs.Fields(0).Value)
                              oDet.Modificado = True
                              Set oDet = Nothing
                              oRs.MoveNext
                           Loop
                           ListaVacia = False
                        Else
                           Set oControl.DataSource = origen.DetSolicitudesCompra.TraerMascara
                           ListaVacia = True
                        End If
                        oRs.Close
                     End If
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
      With origen.Registro
         .Fields("NumeroSolicitud").Value = oPar.Registro.Fields("ProximoNumeroSolicitudCompra").Value
         .Fields("Confecciono").Value = glbIdUsuario
      End With
      Set oPar = Nothing
      mvarGrabado = False
   Else
      With origen.Registro
      
      End With
      mvarGrabado = True
   End If
   
   If ListaVacia Then Lista.ListItems.Clear
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   cmd(0).Enabled = False
   cmd(3).Enabled = False
   If Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      cmd(3).Enabled = True
   ElseIf Me.NivelAcceso <= Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   End If
   
End Property

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub DTFields_Validate(Index As Integer, Cancel As Boolean)

   origen.Registro.Fields(DTFields(Index).DataField).Value = DTFields(Index).Value

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   If mvarModificado And Not mvarAnulada Then
      Dim mvarSale As Integer
      mvarSale = MsgBox("Hay datos no grabados, desea salir igual ?", vbYesNo, "Salir")
      If mvarSale = vbNo Then
         Cancel = 1
      End If
   End If

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
   ElseIf KeyCode = vbKeySpace Then
      MnuDetA_Click 0
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count = 0 Then
      Else
         PopupMenu MnuDet, , , , MnuDetA(0)
      End If
   End If

End Sub

Private Sub Lista_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long, NroItem As Long, idDet As Long
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then
      
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 1), "Req.") <> 0 Then
      
         If mvarId > 0 Then
            MsgBox "Esta solicitud ya fue ingresada, para agregar items nuevos " + _
                     "debe pedir una nueva solicitud.", vbExclamation
            Exit Sub
         End If
      
         Filas = Split(s, vbCrLf)
         
         For i = 1 To UBound(Filas)
         
            Columnas = Split(Filas(i), vbTab)
         
            Set oRs = Aplicacion.Requerimientos.TraerFiltrado("_DatosRequerimiento", Columnas(2))
            
            Do While Not oRs.EOF
               
               If oRs.Fields("PendienteSolicitud").Value > 0 Then
               
               With origen.DetSolicitudesCompra.Item(-1)
                  .Registro.Fields("IdDetalleRequerimiento").Value = oRs.Fields(0).Value
                  .Registro.Fields("Cantidad").Value = oRs.Fields("PendienteSolicitud").Value
                  .Modificado = True
                  idDet = .Id
               End With
               
               Set oL = Lista.ListItems.Add
               oL.Tag = idDet
               With oL
                  .SmallIcon = "Nuevo"
                  .Text = "" & oRs.Fields("NumeroRequerimiento").Value
                  .SubItems(1) = "" & idDet
                  .SubItems(2) = "" & oRs.Fields("NumeroItem").Value
                  .SubItems(3) = "" & oRs.Fields("Cantidad").Value
                  .SubItems(4) = "" & oRs.Fields("PendienteSolicitud").Value
                  .SubItems(5) = "" & oRs.Fields("PendienteSolicitud").Value
                  .SubItems(6) = "" & oRs.Fields("Unidad").Value
                  .SubItems(7) = "" & oRs.Fields("DescripcionArt").Value
               End With
               
               End If
               
               oRs.MoveNext
            
            Loop
            oRs.Close
         
         Next
         
         Set oRs = Nothing
         Set oRsAux = Nothing
            
         Clipboard.Clear
      
         mvarModificado = True
            
      Else
         
         MsgBox "Objeto invalido!"
         Exit Sub
      
      End If

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
         Effect = vbDropEffectCopy
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
         If Not Lista.SelectedItem Is Nothing Then
            Editar Lista.SelectedItem.Tag
         End If
      Case 1
         If Not Lista.SelectedItem Is Nothing Then
            With Lista.SelectedItem
               origen.DetSolicitudesCompra.Item(.Tag).Eliminado = True
               .SmallIcon = "Eliminado"
               .ToolTipText = .SmallIcon
            End With
            mvarModificado = True
         End If
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

