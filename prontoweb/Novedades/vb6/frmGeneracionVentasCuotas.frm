VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmGeneracionVentasCuotas 
   Caption         =   "Generacion de cuotas"
   ClientHeight    =   7500
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11400
   Icon            =   "frmGeneracionVentasCuotas.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7500
   ScaleWidth      =   11400
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "Modalidad de generacion : "
      Height          =   690
      Left            =   5265
      TabIndex        =   24
      Top             =   6750
      Width           =   6045
      Begin VB.OptionButton Option2 
         Caption         =   "Generar chequera completa de cada operacion seleccionada"
         Height          =   375
         Left            =   3105
         TabIndex        =   26
         Top             =   225
         Width           =   2670
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Generar una cuota de cada operacion seleccionada"
         Height          =   375
         Left            =   270
         TabIndex        =   25
         Top             =   225
         Width           =   2265
      End
   End
   Begin VB.TextBox txtNumeroGeneracion 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
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
      Left            =   1890
      TabIndex        =   21
      Top             =   900
      Width           =   1260
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Desmarcar todos"
      Height          =   555
      Index           =   3
      Left            =   9765
      TabIndex        =   19
      Top             =   720
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Marcar todos"
      Height          =   555
      Index           =   2
      Left            =   9765
      TabIndex        =   18
      Top             =   90
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   510
      Index           =   1
      Left            =   1335
      TabIndex        =   17
      Top             =   6885
      Width           =   1200
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Generar"
      Height          =   510
      Index           =   0
      Left            =   90
      TabIndex        =   6
      Top             =   6885
      Width           =   1200
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   510
      Index           =   0
      Left            =   2580
      Picture         =   "frmGeneracionVentasCuotas.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   16
      Top             =   6885
      UseMaskColor    =   -1  'True
      Width           =   1200
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   510
      Index           =   1
      Left            =   3825
      Picture         =   "frmGeneracionVentasCuotas.frx":0DD4
      Style           =   1  'Graphical
      TabIndex        =   15
      Top             =   6885
      Width           =   1200
   End
   Begin VB.TextBox txtInteresSegundoVencimiento 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   8820
      TabIndex        =   5
      Top             =   540
      Width           =   720
   End
   Begin VB.TextBox txtInteresPrimerVencimiento 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   8820
      TabIndex        =   4
      Top             =   135
      Width           =   720
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   330
      Index           =   0
      Left            =   1890
      TabIndex        =   0
      Top             =   90
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   64421889
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   330
      Index           =   1
      Left            =   1890
      TabIndex        =   1
      Top             =   495
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   64421889
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   330
      Index           =   2
      Left            =   5175
      TabIndex        =   2
      Top             =   90
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   64421889
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   330
      Index           =   3
      Left            =   5175
      TabIndex        =   3
      Top             =   495
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   64421889
      CurrentDate     =   36377
   End
   Begin Controles1013.DbListView Lista 
      Height          =   5280
      Left            =   45
      TabIndex        =   13
      Top             =   1440
      Width           =   11265
      _ExtentX        =   19870
      _ExtentY        =   9313
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Checkboxes      =   -1  'True
      MouseIcon       =   "frmGeneracionVentasCuotas.frx":135E
      MultiSelect     =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdBanco"
      Height          =   315
      Index           =   0
      Left            =   5175
      TabIndex        =   23
      Tag             =   "Bancos"
      Top             =   900
      Width           =   4380
      _ExtentX        =   7726
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdBanco"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de generacion :"
      Height          =   240
      Index           =   7
      Left            =   90
      TabIndex        =   22
      Top             =   900
      Width           =   1755
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ente recaudador :"
      Height          =   240
      Index           =   6
      Left            =   3285
      TabIndex        =   20
      Top             =   945
      Width           =   1845
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Detalle de cuotas a generar : "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   9
      Left            =   90
      TabIndex        =   14
      Top             =   1260
      Width           =   2565
   End
   Begin VB.Label lblLabels 
      Caption         =   "% Interes 3er. vencimiento :"
      Height          =   285
      Index           =   5
      Left            =   6615
      TabIndex        =   12
      Top             =   540
      Width           =   2160
   End
   Begin VB.Label lblLabels 
      Caption         =   "% Interes 2do. vencimiento :"
      Height          =   285
      Index           =   3
      Left            =   6615
      TabIndex        =   11
      Top             =   135
      Width           =   2160
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha 2do. vencimiento :"
      Height          =   285
      Index           =   2
      Left            =   3285
      TabIndex        =   10
      Top             =   135
      Width           =   1845
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha 3er. vencimiento :"
      Height          =   285
      Index           =   0
      Left            =   3285
      TabIndex        =   9
      Top             =   540
      Width           =   1845
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de la operacion :"
      Height          =   285
      Index           =   4
      Left            =   90
      TabIndex        =   8
      Top             =   135
      Width           =   1755
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha 1er. vencimiento :"
      Height          =   240
      Index           =   1
      Left            =   90
      TabIndex        =   7
      Top             =   540
      Width           =   1755
   End
End
Attribute VB_Name = "frmGeneracionVentasCuotas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private mvarId As Long
Private mvarCotizacion As Double
Private mvarGeneracionNueva As Boolean
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

Private Sub cmd_Click(Index As Integer)

   Dim oL As ListItem
   
   Select Case Index
   
      Case 0
      
         If mvarId <= 0 And mvarCotizacion = 0 Then
            MsgBox "No hay cotizacion, ingresela primero", vbExclamation
            Exit Sub
         End If
         
         If Val(txtNumeroGeneracion.Text) = 0 Then
            MsgBox "Debe ingresar un numero de generacion", vbExclamation
            Exit Sub
         End If
         
         If Len(txtInteresPrimerVencimiento.Text) = 0 Or _
               Not IsNumeric(txtInteresPrimerVencimiento.Text) Then
            MsgBox "Debe ingresar el % de interes para el 1er. vencimiento", vbExclamation
            Exit Sub
         End If
         
         If Len(txtInteresSegundoVencimiento.Text) = 0 Or _
               Not IsNumeric(txtInteresSegundoVencimiento.Text) Then
            MsgBox "Debe ingresar el % de interes para el 2do. vencimiento", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(dcfields(0).BoundText) Then
            MsgBox "Debe ingresar el ente recaudador", vbExclamation
            Exit Sub
         End If
         
         If Not Option1.Value And Not Option2.Value Then
            MsgBox "Debe indicar la modalidad de generacion", vbExclamation
            Exit Sub
         End If
         
         Dim oAp As ComPronto.Aplicacion
         Dim oVta As ComPronto.VentaEnCuotas
         Dim oPar As ComPronto.Parametro
         Dim oRs As ADOR.Recordset
         Dim Filas
         Dim Columnas
         Dim est As EnumAcciones
         Dim i As Integer, j As Integer, mvarImprime As Integer, mCuotaInicial As Integer
         Dim mCuotaFinal As Integer
         Dim mIdDet As Long
         Dim mModalidadDeGeneracion As String
         
         Me.MousePointer = vbHourglass
         DoEvents
   
         Set oAp = Aplicacion
         
         Filas = VBA.Split(Lista.GetStringCheck, vbCrLf)
         
         For i = LBound(Filas) + 1 To UBound(Filas)
            
            Columnas = VBA.Split(Filas(i), vbTab)
            
            If Option1.Value Then
               mCuotaInicial = Columnas(7)
               mCuotaFinal = Columnas(7)
               mModalidadDeGeneracion = "I"
            Else
               mCuotaInicial = Columnas(7)
               mCuotaFinal = Columnas(5)
               mModalidadDeGeneracion = "C"
            End If
            
            Set oVta = oAp.VentasEnCuotas.Item(Columnas(0))
            For j = mCuotaInicial To mCuotaFinal
               
               If Columnas(2) <= 0 Then
                  mIdDet = -1
               Else
                  mIdDet = Columnas(2)
               End If
            
               With oVta.DetVentasEnCuotas.Item(mIdDet)
                  With .Registro
                     .Fields("Cuota").Value = j
                     .Fields("NumeroGeneracion").Value = txtNumeroGeneracion.Text
                     .Fields("FechaGeneracion").Value = DTFields(0).Value
                     .Fields("FechaPrimerVencimiento").Value = DateAdd("m", j - Columnas(7), DTFields(1).Value)
                     .Fields("FechaSegundoVencimiento").Value = DateAdd("m", j - Columnas(7), DTFields(2).Value)
                     .Fields("FechaTercerVencimiento").Value = DateAdd("m", j - Columnas(7), DTFields(3).Value)
                     .Fields("InteresPrimerVencimiento").Value = txtInteresPrimerVencimiento.Text
                     .Fields("InteresSegundoVencimiento").Value = txtInteresSegundoVencimiento.Text
                     .Fields("IdBanco").Value = dcfields(0).BoundText
                     .Fields("ModalidadDeGeneracion").Value = mModalidadDeGeneracion
                     '.Fields("FechaRegistroParaND").Value = DateAdd("m", j - Columnas(7), DTFields(0).Value)
                     .Fields("FechaRegistroParaND").Value = DTFields(0).Value
                  End With
                  .Modificado = True
               End With
            Next
            oVta.Guardar
            oVta.GenerarDebitos
            Set oVta = Nothing
         
         Next
         
         If mvarId < 0 Then
            Set oPar = oAp.Parametros.Item(1)
            With oPar.Registro
               .Fields("NumeroGeneracionVentaEnCuotas").Value = txtNumeroGeneracion.Text + 1
            End With
            oPar.Guardar
            Set oPar = Nothing
         End If
         
         Set oRs = Nothing
         Set oAp = Nothing
         
         Me.MousePointer = vbDefault
         DoEvents
         
         If mvarId < 0 Then
            est = alta
            mvarId = txtNumeroGeneracion.Text
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "VentasCuotasGeneracion"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
         
         mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de cupones de pago")
         If mvarImprime = vbYes Then
            cmdImpre_Click (0)
         End If
         
         Unload Me

      Case 1
      
         Unload Me

      Case 2
         
         For Each oL In Lista.ListItems
            oL.Checked = True
         Next
      
      Case 3
         
         For Each oL In Lista.ListItems
            oL.Checked = False
         Next
   
   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim oL As ListItem
   Dim mvarIdBanco As Long
         
   Set oAp = Aplicacion
         
   mvarId = vnewvalue
   
   Set dcfields(0).RowSource = oAp.Bancos.TraerFiltrado("_HabilitadosParaCobroCuotas")
   
   If mvarId = -1 Then
      
      mvarGeneracionNueva = True
      
      mvarCotizacion = Cotizacion(Date, glbIdMonedaDolar)
      
      Set oPar = oAp.Parametros.Item(1)
      txtNumeroGeneracion.Text = IIf(IsNull(oPar.Registro.Fields("NumeroGeneracionVentaEnCuotas").Value), 1, oPar.Registro.Fields("NumeroGeneracionVentaEnCuotas").Value)
      mvarIdBanco = IIf(IsNull(oPar.Registro.Fields("IdBancoGestionCobroCuotas").Value), 0, oPar.Registro.Fields("IdBancoGestionCobroCuotas").Value)
      Set oPar = Nothing
      
      DTFields(0).Value = Date
      DTFields(1).Value = DateSerial(Year(Date), Month(Date), 10)
      DTFields(2).Value = DTFields(1).Value + 30
      DTFields(3).Value = DTFields(1).Value + 60
      dcfields(0).BoundText = mvarIdBanco
      
      Set Lista.DataSource = Aplicacion.VentasEnCuotas.TraerFiltrado("_CuotasAGenerar")
      
      cmdImpre(0).Enabled = False
      cmdImpre(1).Enabled = False
   
   Else
      
      mvarGeneracionNueva = False
      
      txtNumeroGeneracion.Text = mvarId
   
      Set oRs = oAp.VentasEnCuotas.TraerFiltrado("_CuotasGeneradasDetalladasPorNumero", mvarId)
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         DTFields(0).Value = oRs.Fields("FechaGeneracion").Value
         DTFields(1).Value = oRs.Fields("FechaPrimerVencimiento").Value
         DTFields(2).Value = oRs.Fields("FechaSegundoVencimiento").Value
         DTFields(3).Value = oRs.Fields("FechaTercerVencimiento").Value
         dcfields(0).BoundText = IIf(IsNull(oRs.Fields("IdBanco").Value), 0, oRs.Fields("IdBanco").Value)
         txtInteresPrimerVencimiento.Text = oRs.Fields("InteresPrimerVencimiento").Value
         txtInteresSegundoVencimiento.Text = oRs.Fields("InteresSegundoVencimiento").Value
      End If
      Set Lista.DataSource = oRs
      For Each oL In Lista.ListItems
         oL.Checked = True
      Next
      
   End If
   
   Set oL = Nothing
   Set oRs = Nothing
   Set oAp = Nothing
   
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
   End If
   If mvarId > 0 Then
      cmd(0).Enabled = False
   End If

End Property

Private Sub cmdImpre_Click(Index As Integer)

   Dim mvarOK As Boolean
   Dim mPrinter As String, mPrinterAnt As String
   
   mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
   
   If Index = 0 Then
      Dim oF As frmImpresion
      Set oF = New frmImpresion
      With oF
         .lblCopias.Visible = False
         .txtCopias.Visible = False
         .Show vbModal, Me
      End With
      mvarOK = oF.Ok
      mPrinter = oF.Combo1.Text
      Unload oF
      Set oF = Nothing
      If Not mvarOK Then
         Exit Sub
      End If
   End If
   
   Dim oW As Word.Application
   Dim mItems As String
   Dim i As Integer
   Dim Filas, Columnas
   
   On Error GoTo Mal
   
   mItems = ""
   If Not mvarGeneracionNueva Then
      Filas = VBA.Split(Lista.GetStringCheck, vbCrLf)
      For i = LBound(Filas) + 1 To UBound(Filas)
         Columnas = VBA.Split(Filas(i), vbTab)
         mItems = mItems & Columnas(2) & ","
      Next
      If Len(mItems) > 0 Then mItems = mId(mItems, 1, Len(mItems) - 1)
   End If
   
   Set oW = CreateObject("Word.Application")
   
   With oW
      .Visible = True
      .Documents.Add (glbPathPlantillas & "\VentaEnCuotas.dot")
      .Application.Run MacroName:="Emision", varg1:=glbStringConexion, _
                              varg2:=mvarId, varg3:=mPrinter, varg4:=mItems
      If Index = 0 Then
         oW.Documents(1).Close False
         oW.Quit
      End If
   End With
   
   GoTo Salida
   
Mal:
   Me.MousePointer = vbDefault
   MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical

Salida:
   Set oW = Nothing
   Me.MousePointer = vbDefault
   
End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub txtInteresPrimerVencimiento_GotFocus()

   With txtInteresPrimerVencimiento
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtInteresPrimerVencimiento_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtInteresSegundoVencimiento_GotFocus()

   With txtInteresSegundoVencimiento
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtInteresSegundoVencimiento_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

