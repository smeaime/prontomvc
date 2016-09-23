VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Begin VB.Form frmControlAuditoria 
   Caption         =   "Pronto Auditoria"
   ClientHeight    =   6000
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10425
   LinkTopic       =   "Form1"
   ScaleHeight     =   6000
   ScaleWidth      =   10425
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmd 
      Caption         =   "Salir"
      Height          =   330
      Index           =   1
      Left            =   45
      TabIndex        =   3
      Top             =   5265
      Width           =   1500
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Procesar"
      Height          =   375
      Index           =   0
      Left            =   45
      TabIndex        =   2
      Top             =   4860
      Width           =   1500
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Top             =   5625
      Width           =   10425
      _ExtentX        =   18389
      _ExtentY        =   661
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   4
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Width           =   7056
            MinWidth        =   7056
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   5292
            MinWidth        =   5292
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            Object.Width           =   1940
            MinWidth        =   1940
            TextSave        =   "27/06/2006"
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   5
            Object.Width           =   1058
            MinWidth        =   1058
            TextSave        =   "10:34"
         EndProperty
      EndProperty
   End
   Begin RichTextLib.RichTextBox rchInfo 
      Height          =   4290
      Left            =   45
      TabIndex        =   0
      Top             =   540
      Width           =   10320
      _ExtentX        =   18203
      _ExtentY        =   7567
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   3
      TextRTF         =   $"frmControlAuditoria.frx":0000
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   330
      Index           =   0
      Left            =   3420
      TabIndex        =   4
      Top             =   90
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   23527425
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   330
      Index           =   1
      Left            =   1755
      TabIndex        =   8
      Top             =   90
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   23527425
      CurrentDate     =   36526
   End
   Begin VB.Label lblLabels 
      Alignment       =   2  'Center
      Caption         =   "al "
      Height          =   240
      Index           =   1
      Left            =   3060
      TabIndex        =   9
      Top             =   135
      Width           =   315
   End
   Begin VB.Label lblControl2 
      BackColor       =   &H00C0C0FF&
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
      Left            =   2520
      TabIndex        =   7
      Top             =   5265
      Visible         =   0   'False
      Width           =   7830
   End
   Begin VB.Label lblControl1 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1635
      TabIndex        =   6
      Top             =   4860
      Visible         =   0   'False
      Width           =   8715
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fechas para control :"
      Height          =   285
      Index           =   0
      Left            =   90
      TabIndex        =   5
      Top             =   120
      Width           =   1575
   End
End
Attribute VB_Name = "frmControlAuditoria"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Auditar
      Case 1
         Unload Me
   End Select
   
End Sub

Private Sub Form_Load()

   On Error Resume Next

   AnalizarStringConnection
   
   Set Aplicacion = CreateObject("ComPronto.Aplicacion")
   Aplicacion.StringConexion = glbStringConexion
   
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim i As Integer, SN As Integer
   
   Set oAp = Aplicacion
   
   Set oRs = oAp.TablasGenerales.TraerFiltrado("Empresa", "_Datos")
   With oRs
      glbEmpresa = IIf(IsNull(.Fields("Nombre").Value), "", .Fields("Nombre").Value)
      glbDetalleNombre = IIf(IsNull(.Fields("DetalleNombre").Value), "", .Fields("DetalleNombre").Value)
      glbDireccion = IIf(IsNull(.Fields("Direccion").Value), "", .Fields("Direccion").Value)
      glbLocalidad = IIf(IsNull(.Fields("Localidad").Value), "", .Fields("Localidad").Value)
      glbCodigoPostal = IIf(IsNull(.Fields("CodigoPostal").Value), "", .Fields("CodigoPostal").Value)
      glbProvincia = IIf(IsNull(.Fields("Provincia").Value), "", .Fields("Provincia").Value)
      glbTelefono1 = IIf(IsNull(.Fields("Telefono1").Value), "", .Fields("Telefono1").Value)
      glbTelefono2 = IIf(IsNull(.Fields("Telefono2").Value), "", .Fields("Telefono2").Value)
      glbEmail = IIf(IsNull(.Fields("Email").Value), "", .Fields("Email").Value)
      glbCuit = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
      glbCondicionIva = IIf(IsNull(.Fields("CondicionIva").Value), "", .Fields("CondicionIva").Value)
      glbDatosAdicionales1 = IIf(IsNull(.Fields("DatosAdicionales1").Value), "", .Fields("DatosAdicionales1").Value)
      glbDatosAdicionales2 = IIf(IsNull(.Fields("DatosAdicionales2").Value), "", .Fields("DatosAdicionales2").Value)
      glbDatosAdicionales3 = IIf(IsNull(.Fields("DatosAdicionales3").Value), "", .Fields("DatosAdicionales3").Value)
   End With
   oRs.Close
   
   Set oRs = oAp.TablasGenerales.TraerFiltrado("BD", "_Host")
   gblHOST = ""
   If oRs.RecordCount > 0 Then
      gblHOST = oRs.Fields(0).Value
   End If
   oRs.Close
   
   Set oRs = oAp.TablasGenerales.TraerFiltrado("BD", "_BaseDeDatos")
   gblBD = ""
   If oRs.RecordCount > 0 Then
      gblBD = oRs.Fields(0).Value
   End If
   oRs.Close
   
   Set oRs = oAp.Parametros.Item(1).Registro
   glbArchivoAyuda = ""
   If Not IsNull(oRs.Fields("ArchivoAyuda").Value) Then
      glbArchivoAyuda = oRs.Fields("ArchivoAyuda").Value
   End If
   mFechaFinal = DateSerial(2000, 1, 1)
   oRs.Close
   StatusBar1.Panels.Item(1).Text = "Host : " & gblHOST & " - BD : " & gblBD
   
   UsuarioSistema = GetCurrentUserName()
   UsuarioSistema = Mid(UsuarioSistema, 1, Len(UsuarioSistema) - 1)
   glbAdministrador = False
   glbInicialesUsuario = ""
   Set oRs = oAp.Empleados.TraerFiltrado("_usuarioNT", UsuarioSistema)
   With oRs
      If .RecordCount > 0 Then
         UsuarioSistema = UsuarioSistema & " [ " & IIf(IsNull(.Fields("Nombre").Value), " ", .Fields("Nombre").Value) & " ]"
         glbNombreUsuario = .Fields("Nombre").Value
         glbIdUsuario = oRs.Fields(0).Value
         glbInicialesUsuario = IIf(IsNull(oRs.Fields("Iniciales").Value), "", oRs.Fields("Iniciales").Value)
         If Not IsNull(oRs.Fields("Administrador").Value) Then
            If oRs.Fields("Administrador").Value = "SI" Then
               glbAdministrador = True
            End If
         End If
      Else
         glbIdUsuario = -1
      End If
      .Close
   End With
   StatusBar1.Panels.Item(0).Text = "Usuario actual : " & UsuarioSistema
   
   Me.Caption = "" & glbEmpresaSegunString & " Pronto Auditoria (Version " & App.Major & "." & App.Minor & ")"
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   DTFields(0).Value = Date

End Sub

Public Sub AnalizarStringConnection()

   Dim mArchivoDefinicionConexion As String
   mArchivoDefinicionConexion = Dir(App.Path & "\Pronto", vbArchive)
   If mArchivoDefinicionConexion = "" Then
      Exit Sub
   End If
   
   Dim MydsEncrypt As dsEncrypt
   Dim mArchivoConexion As String, mConexion As String, mEmpresa As String
   Dim mString As String
   Dim i As Integer, mPos As Integer
   Dim mVariosString As Boolean
   Dim mVectorConexiones, mVectorConexion
   
   Set MydsEncrypt = New dsEncrypt
   MydsEncrypt.KeyString = ("EDS")
   
   mArchivoConexion = LeerArchivoSecuencial(App.Path & "\Pronto")
   Do While Len(mArchivoConexion) > 0 And _
         (Asc(Right(mArchivoConexion, 1)) = 10 Or Asc(Right(mArchivoConexion, 1)) = 13)
      mArchivoConexion = Mid(mArchivoConexion, 1, Len(mArchivoConexion) - 1)
   Loop
   mArchivoConexion = MydsEncrypt.Encrypt(mArchivoConexion)
   mVectorConexiones = VBA.Split(mArchivoConexion, vbCrLf)

   mVariosString = False
   mConexion = ""
   mEmpresa = ""
   For i = 0 To UBound(mVectorConexiones)
      If Len(mVectorConexiones(i)) > 0 Then
         mVectorConexion = VBA.Split(mVectorConexiones(i), "|")
         If Len(mVectorConexion(1)) > 0 Then
            If Len(mConexion) > 0 Then
               mVariosString = True
            Else
               mEmpresa = mVectorConexion(0)
               mConexion = mVectorConexion(1)
            End If
         End If
      End If
   Next
   
   If Not mVariosString Then
      
      mString = MydsEncrypt.Encrypt(mConexion)
      GuardarArchivoSecuencial GetWinDir & "\Pronto", mString
   
   Else
      
      Dim oRs As ADOR.Recordset
      Set oRs = CreateObject("Ador.Recordset")
      With oRs
         .Fields.Append "IdAux", adInteger
         .Fields.Append "Titulo", adVarChar, 250
         .Open
      End With
      For i = 0 To UBound(mVectorConexiones)
         If Len(mVectorConexiones(i)) > 0 Then
            mVectorConexion = VBA.Split(mVectorConexiones(i), "|")
            If Len(mVectorConexion(1)) > 0 Then
               oRs.AddNew
               oRs.Fields("IdAux").Value = i
               oRs.Fields("Titulo").Value = mVectorConexion(0)
               oRs.Update
            End If
         End If
      Next
   
      Dim of As frmStringConnection
      Set of = New frmStringConnection
      With of
         Set .RecordsetDeStrings = oRs
         .Show vbModal, Me
         If IsNumeric(.DataCombo1(0).BoundText) Then
            mPos = .DataCombo1(0).BoundText
         Else
            mPos = -1
         End If
      End With
      Unload of
      Set of = Nothing
      Set oRs = Nothing
   
      If mPos <> -1 Then
         mVectorConexion = VBA.Split(mVectorConexiones(mPos), "|")
         mEmpresa = mVectorConexion(0)
         mString = mVectorConexion(1)
         mString = MydsEncrypt.Encrypt(mString)
         GuardarArchivoSecuencial GetWinDir & "\Pronto", mString
      Else
         End
      End If
   
   End If

   Set MydsEncrypt = Nothing
   
   glbStringConexion = mString
   glbEmpresaSegunString = mEmpresa
   
End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set Aplicacion = Nothing

End Sub

Public Sub Auditar()

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim mFechaDesde As Date, mFechaHasta As Date, mFechaDesdeValidar As Date
   Dim mFechaFinal As Date
   Dim mSaldo As Double, mSaldoContable As Double
   Dim s As String, mBanco As String, mComprobante As String
   Dim mIdCuentaBanco As Long, mTipoComprobante As Long, mIdComprobante As Long
   Dim mIdCuentaBancaria As Long
   Dim mProcesado As Boolean, mError As Boolean
   
   mFechaDesde = DateSerial(1980, 1, 1)
   mFechaHasta = DTFields(0).Value
   mFechaDesdeValidar = DateSerial(2003, 8, 1)
   mFechaFinal = DTFields(1).Value
   
   s = ""
   
   lblControl1.Visible = True
   lblControl2.Visible = True
   
   ' CONTROL DE CAJAS
   Set oRs = Aplicacion.Cajas.TraerFiltrado("_TodosSF")
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando cajas ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         lblControl2.Caption = "" & oRs.Fields("Descripcion").Value
         
         mSaldo = 0
         Set oRs1 = Aplicacion.Cajas.TraerFiltrado("_PosicionFinancieraAFechaPorIdCajaEnPesos", _
                        Array(oRs.Fields("IdCaja").Value, mFechaHasta))
         If oRs1.RecordCount > 0 Then
            mSaldo = IIf(IsNull(oRs1.Fields("Saldo").Value), 0, oRs1.Fields("Saldo").Value)
         End If
         oRs1.Close
         
         mSaldoContable = 0
         Set oRs1 = Aplicacion.Cuentas.TraerFiltrado("_MayorPorIdCuentaEntreFechas", _
                        Array(oRs.Fields("IdCuenta").Value, mFechaDesde, mFechaHasta))
         If oRs1.RecordCount > 0 Then
            mSaldoContable = IIf(IsNull(oRs1.Fields("Saldo").Value), 0, oRs1.Fields("Saldo").Value)
         End If
         oRs1.Close
         
         s = s & "Caja: " & oRs.Fields("Descripcion").Value & " - " & _
                 "Sdo.Caja :" & Format(mSaldo, "#,##0.00") & " - " & _
                 "Sdo.Cont.:" & Format(mSaldoContable, "#,##0.00") & " - " & _
                 "Diferencia :" & Format(mSaldo - mSaldoContable, "#,##0.00") & vbCrLf
         rchInfo.Text = s
         rchInfo.SetFocus
         SendKeys "^{END}"
         DoEvents
         
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   s = s & vbCrLf
   
   
   ' CONTROL DE BANCOS
   Set oRs = Aplicacion.CuentasBancarias.TraerFiltrado("_TodosSF")
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando bancos ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         Set oRs1 = Aplicacion.Bancos.TraerFiltrado("_PorId", oRs.Fields("IdBanco").Value)
         mIdCuentaBanco = oRs1.Fields("IdCuenta").Value
         mBanco = oRs1.Fields("Nombre").Value
         lblControl2.Caption = "" & mBanco
         oRs1.Close
         
         mSaldo = 0
         Set oRs1 = Aplicacion.Bancos.TraerFiltrado("_PosicionFinancieraAFechaPorIdCuentaBancariaEnPesos", _
                        Array(oRs.Fields("IdCuentaBancaria").Value, mFechaHasta))
         If oRs1.RecordCount > 0 Then
            mSaldo = IIf(IsNull(oRs1.Fields("Saldo").Value), 0, oRs1.Fields("Saldo").Value)
         End If
         oRs1.Close
         
         mSaldoContable = 0
         Set oRs1 = Aplicacion.Cuentas.TraerFiltrado("_MayorPorIdCuentaEntreFechas", _
                        Array(mIdCuentaBanco, mFechaDesde, mFechaHasta))
         If oRs1.RecordCount > 0 Then
            mSaldoContable = IIf(IsNull(oRs1.Fields("Saldo").Value), 0, oRs1.Fields("Saldo").Value)
         End If
         oRs1.Close
         
         s = s & "Banco: " & mBanco & " - " & _
                 "Sdo.Cta.:" & Format(mSaldo, "#,##0.00") & " - " & _
                 "Sdo.Cont.:" & Format(mSaldoContable, "#,##0.00") & " - " & _
                 "Diferencia :" & Format(mSaldo - mSaldoContable, "#,##0.00") & vbCrLf
         rchInfo.Text = s
         rchInfo.SetFocus
         SendKeys "^{END}"
         DoEvents
         
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   s = s & vbCrLf
   
   
   ' CONTROL DE EXISTENCIA DE COMPROBANTES : DESDE SUBDIARIOS A COMPROBANTES
   Set oRs = Aplicacion.Subdiarios.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando subdiarios ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         lblControl2.Caption = "Procesando dia : " & oRs.Fields("FechaComprobante").Value
         DoEvents
         mProcesado = True
         If Not IsNull(oRs.Fields("IdComprobante").Value) Then
            Select Case oRs.Fields("IdTipoComprobante").Value
               Case 1
                  Set oRs1 = Aplicacion.Facturas.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "FACTURA VENTA"
               Case 2
                  Set oRs1 = Aplicacion.Recibos.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "RECIBO"
               Case 3
                  Set oRs1 = Aplicacion.NotasDebito.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "NOTAS DE DEBITO"
               Case 4
                  Set oRs1 = Aplicacion.NotasCredito.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "NOTAS DE CREDITO"
               Case 5
                  Set oRs1 = Aplicacion.Devoluciones.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "DEVOLUCION"
               Case 10
                  Set oRs1 = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "NOTAS DE CREDITO PROV"
               Case 11, 40
                  Set oRs1 = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "FACTURA COMPRA"
               Case 13
                  Set oRs1 = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "NOTAS DE CREDITO PROV (INT)"
               Case 14
                  Set oRs1 = Aplicacion.DepositosBancarios.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "DEPOSITO"
               Case 17
                  Set oRs1 = Aplicacion.OrdenesPago.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "ORDEN DE PAGO"
               Case 18
                  Set oRs1 = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "NOTAS DE DEBITO PROV"
               Case 19
                  Set oRs1 = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "NOTAS DE DEBITO PROV (INT)"
               Case 28
                  Set oRs1 = Aplicacion.Valores.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "DEBITO BANCARIO"
               Case 29
                  Set oRs1 = Aplicacion.Valores.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "CREDITO BANCARIO"
               Case 31, 34
                  Set oRs1 = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "DEVOLUCION FONDO FIJO"
               Case 39
                  Set oRs1 = Aplicacion.PlazosFijos.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "PLAZO FIJO"
               Case 42, 43
                  Set oRs1 = Aplicacion.ComprobantesProveedores.TraerFiltrado("_PorId", oRs.Fields("IdComprobante").Value)
                  mComprobante = "TICKET"
               
               Case Else
                  mComprobante = "SIN DEFINIR"
                  mProcesado = False
            End Select
         Else
            mComprobante = "SIN DEFINIR"
            mProcesado = False
         End If
         mError = False
         If mProcesado Then
            If oRs1.RecordCount = 0 Then
               mComprobante = mComprobante & " " & oRs.Fields("NumeroComprobante").Value & _
                                             " del " & oRs.Fields("FechaComprobante").Value
               mError = True
            End If
            oRs1.Close
         Else
            mComprobante = mComprobante & " (Tipo " & oRs.Fields("IdTipoComprobante").Value & _
                                          ") " & oRs.Fields("NumeroComprobante").Value & _
                                          " del " & oRs.Fields("FechaComprobante").Value
            mError = True
         End If
         
         If mError And oRs.Fields("FechaComprobante").Value >= mFechaDesdeValidar Then
            s = s & mComprobante & ", no fue encontrado" & vbCrLf
            rchInfo.Text = s
            rchInfo.SetFocus
            SendKeys "^{END}"
            DoEvents
         End If
         
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   s = s & vbCrLf
   
   
   ' CONTROL DE EXISTENCIA DE COMPROBANTES : DESDE COMPROBANTES A SUBDIARIOS
   ' FACTURAS DE VENTA
   mTipoComprobante = 1
   Set oRs = Aplicacion.Facturas.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando facturas de venta ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If (IsNull(oRs.Fields("Anulada").Value) Or oRs.Fields("Anulada").Value <> "SI") And _
               oRs.Fields("FechaFactura").Value >= mFechaFinal Then
            mComprobante = "FACTURA DE VENTA " & oRs.Fields("TipoABC").Value & " - " & _
                           Format(oRs.Fields("NumeroFactura").Value, "00000000") & " del " & _
                           oRs.Fields("FechaFactura").Value
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.Subdiarios.TraerFiltrado("_PorIdComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaFactura").Value >= mFechaDesdeValidar Then
               s = s & mComprobante & ", no fue encontrado en el subdiario" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   ' RECIBOS
   mTipoComprobante = 2
   Set oRs = Aplicacion.Recibos.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando recibos ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If (IsNull(oRs.Fields("Anulado").Value) Or oRs.Fields("Anulado").Value <> "SI") And _
               oRs.Fields("FechaRecibo").Value >= mFechaFinal Then
            mComprobante = "RECIBO " & Format(oRs.Fields("NumeroRecibo").Value, "00000000") & " del " & _
                           oRs.Fields("FechaRecibo").Value
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.Subdiarios.TraerFiltrado("_PorIdComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaRecibo").Value >= mFechaDesdeValidar Then
               s = s & mComprobante & ", no fue encontrado en el subdiario" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   ' NOTAS DE DEBITO
   mTipoComprobante = 3
   Set oRs = Aplicacion.NotasDebito.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando notas de debito ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If (IsNull(oRs.Fields("Anulada").Value) Or oRs.Fields("Anulada").Value <> "SI") And _
               oRs.Fields("FechaNotaDebito").Value >= mFechaFinal Then
            mComprobante = "NOTA DE DEBITO " & Format(oRs.Fields("NumeroNotaDebito").Value, "00000000") & " del " & _
                           oRs.Fields("FechaNotaDebito").Value
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.Subdiarios.TraerFiltrado("_PorIdComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaNotaDebito").Value >= mFechaDesdeValidar Then
               s = s & mComprobante & ", no fue encontrado en el subdiario" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   ' NOTAS DE CREDITO
   mTipoComprobante = 4
   Set oRs = Aplicacion.NotasCredito.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando notas de credito ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If (IsNull(oRs.Fields("Anulada").Value) Or oRs.Fields("Anulada").Value <> "SI") And _
               oRs.Fields("FechaNotaCredito").Value >= mFechaFinal Then
            mComprobante = "NOTA DE CREDITO " & Format(oRs.Fields("NumeroNotaCredito").Value, "00000000") & " del " & _
                           oRs.Fields("FechaNotaCredito").Value
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.Subdiarios.TraerFiltrado("_PorIdComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaNotaCredito").Value >= mFechaDesdeValidar Then
               s = s & mComprobante & ", no fue encontrado en el subdiario" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   ' DEVOLUCIONES
   mTipoComprobante = 5
   Set oRs = Aplicacion.Devoluciones.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando devoluciones ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If (IsNull(oRs.Fields("Anulada").Value) Or oRs.Fields("Anulada").Value <> "SI") And _
               oRs.Fields("FechaDevolucion").Value >= mFechaFinal Then
            mComprobante = "DEVOLUCION " & Format(oRs.Fields("NumeroDevolucion").Value, "00000000") & " del " & _
                           oRs.Fields("FechaDevolucion").Value
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.Subdiarios.TraerFiltrado("_PorIdComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaDevolucion").Value >= mFechaDesdeValidar Then
               s = s & mComprobante & ", no fue encontrado en el subdiario" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   ' COMPROBANTES DE PROVEEDORES
   Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando comprobantes de proveedores ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If (IsNull(oRs.Fields("Confirmado").Value) Or oRs.Fields("Confirmado").Value <> "NO") And _
               oRs.Fields("FechaComprobante").Value >= mFechaFinal Then
            mTipoComprobante = oRs.Fields("IdTipoComprobante").Value
            Set oRs1 = Aplicacion.TiposComprobante.TraerFiltrado("_PorId", mTipoComprobante)
            mComprobante = "" & oRs1.Fields("Descripcion").Value & " " & _
                           oRs.Fields("Letra").Value & " - " & _
                           Format(oRs.Fields("NumeroComprobante1").Value, "0000") & " - " & _
                           Format(oRs.Fields("NumeroComprobante2").Value, "00000000") & " del " & _
                           oRs.Fields("FechaComprobante").Value
            oRs1.Close
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.Subdiarios.TraerFiltrado("_PorIdComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaComprobante").Value >= mFechaDesdeValidar Then
               s = s & mComprobante & ", no fue encontrado en el subdiario" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   ' DEPOSITOS BANCARIOS
   mTipoComprobante = 14
   Set oRs = Aplicacion.DepositosBancarios.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando depositos bancarios ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If (IsNull(oRs.Fields("Anulado").Value) Or oRs.Fields("Anulado").Value <> "SI") And _
               oRs.Fields("FechaDeposito").Value >= mFechaFinal Then
            mComprobante = "DEPOSITO BANCARIO " & Format(oRs.Fields("NumeroDeposito").Value, "00000000") & " del " & _
                           oRs.Fields("FechaDeposito").Value
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.Subdiarios.TraerFiltrado("_PorIdComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaDeposito").Value >= mFechaDesdeValidar Then
               s = s & mComprobante & ", no fue encontrado en el subdiario" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   ' ORDENES DE PAGO
   mTipoComprobante = 17
   Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando ordenes de pago ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If (IsNull(oRs.Fields("Anulada").Value) Or oRs.Fields("Anulada").Value <> "SI") And _
               oRs.Fields("FechaOrdenPago").Value >= mFechaFinal Then
            mComprobante = "ORDEN DE PAGO " & Format(oRs.Fields("NumeroOrdenPago").Value, "00000000") & " del " & _
                           oRs.Fields("FechaOrdenPago").Value
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.Subdiarios.TraerFiltrado("_PorIdComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And _
                  oRs.Fields("FechaOrdenPago").Value >= mFechaDesdeValidar And _
                  IIf(IsNull(oRs.Fields("Acreedores").Value), 0, oRs.Fields("Acreedores").Value) <> 0 And _
                  IIf(IsNull(oRs.Fields("Valores").Value), 0, oRs.Fields("Valores").Value) <> 0 Then
               s = s & mComprobante & ", no fue encontrado en el subdiario" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   ' DEBITOS Y CREDITOS BANCARIOS
   Set oRs = Aplicacion.Valores.TraerFiltrado("_TodosSF_HastaFecha_DebitosYCreditos", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando debitos y creditos bancarios ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If oRs.Fields("FechaComprobante").Value >= mFechaFinal Then
            mTipoComprobante = oRs.Fields("IdTipoComprobante").Value
            mIdComprobante = oRs.Fields(0).Value
            mIdCuentaBancaria = oRs.Fields("IdCuentaBancaria").Value
            Set oRs1 = Aplicacion.TiposComprobante.TraerFiltrado("_PorId", mTipoComprobante)
            mComprobante = "" & oRs1.Fields("Descripcion").Value & " " & _
                           Format(oRs.Fields("NumeroComprobante").Value, "0000") & " - " & _
                           oRs.Fields("FechaComprobante").Value & " (Id:" & mIdComprobante & ")"
            oRs1.Close
            Set oRs1 = Aplicacion.CuentasBancarias.TraerFiltrado("_PorIdConCuenta", mIdCuentaBancaria)
            mComprobante = mComprobante & " - Banco:" & oRs1.Fields("Banco").Value & " - " & _
                           "Cta.:" & oRs1.Fields("Cuenta").Value
            oRs1.Close
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.Subdiarios.TraerFiltrado("_PorIdComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaComprobante").Value >= mFechaDesdeValidar Then
               s = s & mComprobante & ", no fue encontrado en el subdiario" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   ' PLAZOS FIJOS
   mTipoComprobante = 39
   Set oRs = Aplicacion.PlazosFijos.TraerFiltrado("_TodosSF_HastaFecha_Inicio", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando plazos fijos (inicio) ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If (IsNull(oRs.Fields("Anulado").Value) Or oRs.Fields("Anulado").Value <> "SI") And _
               oRs.Fields("FechaInicioPlazoFijo").Value >= mFechaFinal Then
            mComprobante = "PLAZO FIJO " & oRs.Fields("NumeroCertificado2").Value & " del " & _
                           oRs.Fields("FechaInicioPlazoFijo").Value
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.Subdiarios.TraerFiltrado("_PorIdComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaInicioPlazoFijo").Value >= mFechaDesdeValidar Then
               s = s & mComprobante & ", no fue encontrado en el subdiario" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   s = s & vbCrLf
   
   
   ' CONTROL DE CUENTAS CORRIENTES
   ' FACTURAS DE VENTA
   mTipoComprobante = 1
   Set oRs = Aplicacion.Facturas.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando ctas. ctes. - facturas de venta ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If IsNull(oRs.Fields("Anulada").Value) Or oRs.Fields("Anulada").Value <> "SI" Then
            mComprobante = "FACTURA DE VENTA " & oRs.Fields("TipoABC").Value & " - " & _
                           Format(oRs.Fields("NumeroFactura").Value, "00000000") & " del " & _
                           oRs.Fields("FechaFactura").Value
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaFactura").Value >= mFechaDesdeValidar Then
               s = s & "CTA.CTE. " & mComprobante & ", no fue encontrado" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   ' RECIBOS
   mTipoComprobante = 2
   Set oRs = Aplicacion.Recibos.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando ctas. ctes. - recibos ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If (IsNull(oRs.Fields("Anulado").Value) Or oRs.Fields("Anulado").Value <> "SI") And _
               oRs.Fields("Tipo").Value = "CC" Then
            mComprobante = "RECIBO " & Format(oRs.Fields("NumeroRecibo").Value, "00000000") & " del " & _
                           oRs.Fields("FechaRecibo").Value
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaRecibo").Value >= mFechaDesdeValidar Then
               s = s & "CTA.CTE. " & mComprobante & ", no fue encontrado" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   ' NOTAS DE DEBITO
   mTipoComprobante = 3
   Set oRs = Aplicacion.NotasDebito.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando ctas. ctes. - notas de debito ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If (IsNull(oRs.Fields("Anulada").Value) Or oRs.Fields("Anulada").Value <> "SI") And _
               IIf(IsNull(oRs.Fields("AplicarEnCtaCte").Value), "SI", oRs.Fields("AplicarEnCtaCte").Value) = "SI" Then
            mComprobante = "NOTA DE DEBITO " & Format(oRs.Fields("NumeroNotaDebito").Value, "00000000") & " del " & _
                           oRs.Fields("FechaNotaDebito").Value
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaNotaDebito").Value >= mFechaDesdeValidar Then
               s = s & "CTA.CTE. " & mComprobante & ", no fue encontrado" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   ' NOTAS DE CREDITO
   mTipoComprobante = 4
   Set oRs = Aplicacion.NotasCredito.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando ctas. ctes. - notas de credito ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If (IsNull(oRs.Fields("Anulada").Value) Or oRs.Fields("Anulada").Value <> "SI") And _
               IIf(IsNull(oRs.Fields("AplicarEnCtaCte").Value), "SI", oRs.Fields("AplicarEnCtaCte").Value) = "SI" Then
            mComprobante = "NOTA DE CREDITO " & Format(oRs.Fields("NumeroNotaCredito").Value, "00000000") & " del " & _
                           oRs.Fields("FechaNotaCredito").Value
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaNotaCredito").Value >= mFechaDesdeValidar Then
               s = s & "CTA.CTE. " & mComprobante & ", no fue encontrado" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   ' DEVOLUCIONES
   mTipoComprobante = 5
   Set oRs = Aplicacion.Devoluciones.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando ctas. ctes. - devoluciones ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If IsNull(oRs.Fields("Anulada").Value) Or oRs.Fields("Anulada").Value <> "SI" Then
            mComprobante = "DEVOLUCION " & Format(oRs.Fields("NumeroDevolucion").Value, "00000000") & " del " & _
                           oRs.Fields("FechaDevolucion").Value
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaDevolucion").Value >= mFechaDesdeValidar Then
               s = s & "CTA.CTE. " & mComprobante & ", no fue encontrado" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   s = s & vbCrLf
   
   
   ' CONTROL DE CUENTAS CORRIENTES ACREEDORES
   ' COMPROBANTES DE PROVEEDORES
   Set oRs = Aplicacion.ComprobantesProveedores.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando ctas. ctes. - comprobantes de proveedores ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If Not IsNull(oRs.Fields("IdProveedor").Value) And _
               (IsNull(oRs.Fields("Confirmado").Value) Or oRs.Fields("Confirmado").Value <> "NO") Then
            mTipoComprobante = oRs.Fields("IdTipoComprobante").Value
            Set oRs1 = Aplicacion.TiposComprobante.TraerFiltrado("_PorId", mTipoComprobante)
            mComprobante = "" & oRs1.Fields("Descripcion").Value & " " & _
                           oRs.Fields("Letra").Value & " - " & _
                           Format(oRs.Fields("NumeroComprobante1").Value, "0000") & " - " & _
                           Format(oRs.Fields("NumeroComprobante2").Value, "00000000") & " del " & _
                           oRs.Fields("FechaComprobante").Value
            oRs1.Close
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.CtasCtesA.TraerFiltrado("_BuscarComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaComprobante").Value >= mFechaDesdeValidar Then
               s = s & "CTA.CTE. " & mComprobante & ", no fue encontrado" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   ' ORDENES DE PAGO
   mTipoComprobante = 17
   Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_TodosSF_HastaFecha", mFechaHasta)
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando ctas. ctes. - ordenes de pago ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         If (IsNull(oRs.Fields("Anulada").Value) Or oRs.Fields("Anulada").Value <> "SI") And _
               oRs.Fields("Tipo").Value = "CC" Then
            mComprobante = "ORDEN DE PAGO " & Format(oRs.Fields("NumeroOrdenPago").Value, "00000000") & " del " & _
                           oRs.Fields("FechaOrdenPago").Value
            mIdComprobante = oRs.Fields(0).Value
            lblControl2.Caption = "Procesando : " & mComprobante
            DoEvents
            Set oRs1 = Aplicacion.CtasCtesA.TraerFiltrado("_BuscarComprobante", Array(mIdComprobante, mTipoComprobante))
            If oRs1.RecordCount = 0 And oRs.Fields("FechaOrdenPago").Value >= mFechaDesdeValidar Then
               s = s & "CTA.CTE. " & mComprobante & ", no fue encontrado" & vbCrLf
               rchInfo.Text = s
               rchInfo.SetFocus
               SendKeys "^{END}"
               DoEvents
            End If
            oRs1.Close
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   s = s & vbCrLf
   
   
   ' CONTROL DE STOCK
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_ControlContraCardex")
   If oRs.RecordCount > 0 Then
      lblControl1.Caption = "Controlando stocks ..."
      oRs.MoveFirst
      Do While Not oRs.EOF
         s = s & "Articulo : " & IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value) & " " & _
               IIf(IsNull(oRs.Fields("Descripcion").Value), "", Mid(oRs.Fields("Descripcion").Value, 1, 30)) & " " & _
               "Cardex : " & oRs.Fields("CantidadCalculada").Value & ", " & _
               "Stock : " & oRs.Fields("CantidadStock").Value & ", " & _
               "Dif.: " & oRs.Fields("CantidadCalculada").Value - oRs.Fields("CantidadStock").Value & "." & vbCrLf
         rchInfo.Text = s
         rchInfo.SetFocus
         SendKeys "^{END}"
         DoEvents
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   Set oRs = Nothing
   Set oRs1 = Nothing

   lblControl1.Visible = False
   lblControl2.Visible = False

End Sub
