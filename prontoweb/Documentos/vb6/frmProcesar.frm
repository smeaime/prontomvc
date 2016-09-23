VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Begin VB.Form frmProcesar 
   ClientHeight    =   2745
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10365
   Icon            =   "frmProcesar.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2745
   ScaleWidth      =   10365
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text2 
      Alignment       =   2  'Center
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
      Left            =   135
      TabIndex        =   8
      Top             =   1260
      Visible         =   0   'False
      Width           =   10005
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Calculo de costos PPP"
      Height          =   315
      Index           =   1
      Left            =   5940
      TabIndex        =   7
      Top             =   1620
      Width           =   4230
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Generacion de asientos y subdiarios contables"
      Height          =   315
      Index           =   0
      Left            =   135
      TabIndex        =   6
      Top             =   1620
      Width           =   4230
   End
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
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
      Height          =   570
      Left            =   135
      TabIndex        =   1
      Top             =   630
      Visible         =   0   'False
      Width           =   10005
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   720
      Index           =   5
      Left            =   4410
      TabIndex        =   0
      Top             =   1620
      Width           =   1485
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaRecibo"
      Height          =   330
      Index           =   0
      Left            =   2430
      TabIndex        =   2
      Top             =   180
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   23658497
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaRecibo"
      Height          =   330
      Index           =   1
      Left            =   5355
      TabIndex        =   3
      Top             =   180
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   23658497
      CurrentDate     =   36377
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   9
      Top             =   2355
      Width           =   10365
      _ExtentX        =   18283
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   6
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   7832
            MinWidth        =   5292
            Picture         =   "frmProcesar.frx":076A
            Key             =   "Estado"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   5539
            MinWidth        =   2999
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   1
            Alignment       =   1
            AutoSize        =   2
            Enabled         =   0   'False
            Object.Width           =   900
            MinWidth        =   18
            TextSave        =   "CAPS"
            Key             =   "Caps"
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   2
            AutoSize        =   2
            Enabled         =   0   'False
            Object.Width           =   820
            MinWidth        =   18
            TextSave        =   "NUM"
            Key             =   "Num"
         EndProperty
         BeginProperty Panel5 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            Alignment       =   1
            AutoSize        =   2
            Object.Width           =   1693
            MinWidth        =   18
            TextSave        =   "13/10/2006"
            Key             =   "Fecha"
         EndProperty
         BeginProperty Panel6 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   5
            AutoSize        =   2
            Object.Width           =   873
            MinWidth        =   19
            TextSave        =   "16:35"
         EndProperty
      EndProperty
   End
   Begin VB.Label lblLabels 
      Caption         =   "hasta el :"
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
      Index           =   4
      Left            =   3780
      TabIndex        =   5
      Top             =   225
      Width           =   1515
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de inicio :"
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
      Index           =   2
      Left            =   180
      TabIndex        =   4
      Top             =   225
      Width           =   2190
   End
End
Attribute VB_Name = "frmProcesar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Cmd_Click(Index As Integer)

   Dim oAp As ComPronto.Aplicacion
   Dim oArt As ComPronto.Articulo
   Dim oRs As ADOR.Recordset
         
   Select Case Index
      
      Case 0
         
         GeneracionContable
   
      Case 1
   
         Set oRs = Aplicacion.Articulos.TraerTodos
         
         If oRs.RecordCount > 0 Then
            
            Text1.Text = "Iniciando proceso ..."
            DoEvents
'            Aplicacion.Tarea "Productos_GeneracionDeTablaParaCostosPromedios"
'            Aplicacion.Tarea "Productos_GeneracionDeTablaParaRecalculoStock"
      
            oRs.MoveFirst
            Do While Not oRs.EOF
               Text1.Text = oRs.Fields("CodigoArticulo").Value & " - " & _
                           oRs.Fields("Descripcion").Value
               Text2.Text = "" & oRs.AbsolutePosition & " de " & oRs.RecordCount
               DoEvents
               Set oArt = Aplicacion.Articulos.Item(oRs.Fields(0).Value)
               With oArt
                  .GenerarCostoPromedio
               End With
               Set oArt = Nothing
               oRs.MoveNext
            Loop
         
         End If
         
         oRs.Close
         
   End Select

   Set oRs = Nothing
   Set oAp = Nothing
      
   Unload Me

End Sub

Private Sub Form_Load()

   On Error Resume Next

   AnalizarStringConnection
   
   Set Aplicacion = CreateObject("ComPronto.Aplicacion")
   
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
   oRs.Close
   StatusBar1.Panels.Item(1).Text = "Host : " & gblHOST & " - BD : " & gblBD
   
   UsuarioSistema = GetCurrentUserName()
   UsuarioSistema = mId(UsuarioSistema, 1, Len(UsuarioSistema) - 1)
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
   
   Me.Caption = "" & glbEmpresaSegunString & " Pronto procesos especiales (Version " & App.Major & "." & App.Minor & ")"
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   DTFields(0).Value = DateSerial(2003, 2, 1)
   DTFields(1).Value = Now
   
End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set Aplicacion = Nothing

End Sub

Public Sub GeneracionContable()

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oFac As ComPronto.Factura
   Dim oDev As ComPronto.Devolucion
   Dim oDeb As ComPronto.NotaDebito
   Dim oCre As ComPronto.NotaCredito
   Dim oRec As ComPronto.Recibo
   Dim oIAc As ComPronto.ComprobanteProveedor
   Dim oOPg As ComPronto.OrdenPago
   Dim oDep As ComPronto.DepositoBancario
   Dim oGsB As ComPronto.Valor
   Dim oPlz As ComPronto.PlazoFijo
   
   Me.MousePointer = vbHourglass
   
   Text1.Visible = True
   
   Set oAp = Aplicacion
         
   'Borrado de Subdiarios y Asientos
   oAp.Tarea "Subdiarios_BorrarEntreFechas", Array(DTFields(0).Value, DTFields(1).Value)
   oAp.Tarea "Asientos_BorrarEntreFechas", Array(DTFields(0).Value, DTFields(1).Value)
   
   'Facturas
   Set oRs = oAp.Facturas.TraerFiltrado("_EntreFechasParaGeneracionContable", Array(DTFields(0).Value, DTFields(1).Value))
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            Text1.Text = "Factura : " & .Fields("Factura").Value & " del " & .Fields("Fecha Factura").Value
            DoEvents
            Set oFac = oAp.Facturas.Item(.Fields(0).Value)
            oFac.GuardarRegistroContable
            Set oFac = Nothing
            .MoveNext
         Loop
      End If
      .Close
   End With
         
   'Devoluciones
   Set oRs = oAp.Devoluciones.TraerFiltrado("_EntreFechasParaGeneracionContable", Array(DTFields(0).Value, DTFields(1).Value))
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            Text1.Text = "Credito por devolucion : " & .Fields("Devolucion").Value & " del " & .Fields("Fecha dev.").Value
            DoEvents
            Set oDev = oAp.Devoluciones.Item(.Fields(0).Value)
            oDev.GuardarRegistroContable
            Set oDev = Nothing
            .MoveNext
         Loop
      End If
      .Close
   End With
         
   'Notas de debito
   Set oRs = oAp.NotasDebito.TraerFiltrado("_EntreFechasParaGeneracionContable", Array(DTFields(0).Value, DTFields(1).Value))
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            Text1.Text = "Notas de debito : " & .Fields("Nota debito").Value & " del " & .Fields("Fecha debito").Value
            DoEvents
            Set oDeb = oAp.NotasDebito.Item(.Fields(0).Value)
            oDeb.GuardarRegistroContable
            Set oDeb = Nothing
            .MoveNext
         Loop
      End If
      .Close
   End With
         
   'Notas de credito
   Set oRs = oAp.NotasCredito.TraerFiltrado("_EntreFechasParaGeneracionContable", Array(DTFields(0).Value, DTFields(1).Value))
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            Text1.Text = "Notas de credito : " & .Fields("Nota credito").Value & " del " & .Fields("Fecha credito").Value
            DoEvents
            Set oCre = oAp.NotasCredito.Item(.Fields(0).Value)
            oCre.GuardarRegistroContable
            Set oCre = Nothing
            .MoveNext
         Loop
      End If
      .Close
   End With
         
   'Recibos de pago
   Set oRs = oAp.Recibos.TraerFiltrado("_EntreFechasParaGeneracionContable", Array(DTFields(0).Value, DTFields(1).Value))
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            Text1.Text = "Recibos de pago : " & .Fields("Recibo").Value & " del " & .Fields("Fecha recibo").Value
            DoEvents
            Set oRec = oAp.Recibos.Item(.Fields(0).Value)
            oRec.GuardarRegistroContable
            Set oRec = Nothing
            .MoveNext
         Loop
      End If
      .Close
   End With
         
   'Imputacion de acreedores
   Set oRs = oAp.ComprobantesProveedores.TraerFiltrado("Fecha", Array(DTFields(0).Value, DTFields(1).Value))
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            Text1.Text = "Imputacion de acreedores : " & .Fields("Tipo comp.").Value & " : " & .Fields("Numero").Value & " del " & .Fields("Fecha comp.").Value
            DoEvents
            Set oIAc = oAp.ComprobantesProveedores.Item(.Fields(0).Value)
            oIAc.GuardarRegistroContable
            Set oIAc = Nothing
            .MoveNext
         Loop
      End If
      .Close
   End With
         
   'Ordenes de pago
   Set oRs = oAp.OrdenesPago.TraerFiltrado("_EntreFechasParaGeneracionContable", Array(DTFields(0).Value, DTFields(1).Value))
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            Text1.Text = "Orden de pago : " & .Fields("Numero").Value & " del " & .Fields("Fecha Pago").Value
            DoEvents
            Set oOPg = oAp.OrdenesPago.Item(.Fields(0).Value)
            oOPg.GuardarRegistroContable
            Set oOPg = Nothing
            .MoveNext
         Loop
      End If
      .Close
   End With
         
   'Depositos bancarios
   Set oRs = oAp.DepositosBancarios.TraerFiltrado("_EntreFechas", Array(DTFields(0).Value, DTFields(1).Value))
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            Text1.Text = "Deposito bancario : " & .Fields("NumeroDeposito").Value & " del " & .Fields("FechaDeposito").Value
            DoEvents
            Set oDep = oAp.DepositosBancarios.Item(.Fields(0).Value)
            oDep.GuardarRegistroContable
            Set oDep = Nothing
            .MoveNext
         Loop
      End If
      .Close
   End With
         
   'Gastos bancarios
   Set oRs = oAp.Valores.TraerFiltrado("_EntreFechasSoloGastos", Array(DTFields(0).Value, DTFields(1).Value))
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            Text1.Text = "Gasto bancario : " & .Fields("NumeroComprobante").Value & " del " & .Fields("FechaComprobante").Value
            DoEvents
            Set oGsB = oAp.Valores.Item(.Fields(0).Value)
            oGsB.GuardarRegistroContable
            Set oGsB = Nothing
            .MoveNext
         Loop
      End If
      .Close
   End With
   
   'Plazos fijos
   Set oRs = oAp.PlazosFijos.TraerFiltrado("_EntreFechasParaGeneracionContable", Array(DTFields(0).Value, DTFields(1).Value))
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            Text1.Text = "Plazo fijo : " & .Fields("NumeroCertificado1").Value & " del " & .Fields("FechaInicioPlazoFijo").Value
            DoEvents
            Set oPlz = oAp.PlazosFijos.Item(.Fields(0).Value)
            oPlz.GuardarRegistroContable
            Set oPlz = Nothing
            .MoveNext
         Loop
      End If
      .Close
   End With
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   Me.MousePointer = vbDefault
         
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
      mArchivoConexion = mId(mArchivoConexion, 1, Len(mArchivoConexion) - 1)
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
   
      Dim oF As frmStringConnection
      Set oF = New frmStringConnection
      With oF
         Set .RecordsetDeStrings = oRs
         .Show vbModal, Me
         If IsNumeric(.DataCombo1(0).BoundText) Then
            mPos = .DataCombo1(0).BoundText
         Else
            mPos = -1
         End If
      End With
      Unload oF
      Set oF = Nothing
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
   
   glbEmpresaSegunString = mEmpresa
   
End Sub



