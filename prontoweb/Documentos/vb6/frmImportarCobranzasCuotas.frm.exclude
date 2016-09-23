VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Object = "{F7D972E3-E925-4183-AB00-B6A253442139}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmImportarCobranzasCuotas 
   Caption         =   "Importacion de cobranza de cuotas"
   ClientHeight    =   6450
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11715
   Icon            =   "frmImportarCobranzasCuotas.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6450
   ScaleWidth      =   11715
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Importar"
      Height          =   420
      Index           =   0
      Left            =   90
      TabIndex        =   2
      Top             =   5940
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   420
      Index           =   1
      Left            =   1710
      TabIndex        =   1
      Top             =   5940
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Grabar comprobantes"
      Enabled         =   0   'False
      Height          =   420
      Index           =   2
      Left            =   9855
      TabIndex        =   0
      Top             =   5940
      Width           =   1785
   End
   Begin Controles1013.DbListView Lista 
      Height          =   4875
      Left            =   45
      TabIndex        =   3
      Top             =   945
      Width           =   11625
      _ExtentX        =   20505
      _ExtentY        =   8599
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmImportarCobranzasCuotas.frx":076A
      OLEDragMode     =   1
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   2205
      TabIndex        =   4
      Top             =   90
      Width           =   9375
      _ExtentX        =   16536
      _ExtentY        =   582
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
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   10
      Left            =   2205
      TabIndex        =   6
      Tag             =   "PuntosVenta"
      Top             =   495
      Width           =   870
      _ExtentX        =   1535
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdPuntoVenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   6345
      TabIndex        =   8
      Tag             =   "BancosCuentas"
      Top             =   495
      Width           =   5235
      _ExtentX        =   9234
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaBancaria"
      Text            =   ""
   End
   Begin VB.Label lblData 
      Caption         =   "Banco / Cuenta acreditada en los pagos : "
      Height          =   255
      Index           =   2
      Left            =   3195
      TabIndex        =   9
      Top             =   540
      Width           =   3075
   End
   Begin VB.Label lblLabels 
      Caption         =   "Punto de venta cobranza :"
      Height          =   240
      Index           =   21
      Left            =   90
      TabIndex        =   7
      Top             =   540
      Width           =   1995
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Archivo de importacion : "
      Height          =   240
      Index           =   0
      Left            =   90
      TabIndex        =   5
      Top             =   135
      Width           =   1995
   End
End
Attribute VB_Name = "frmImportarCobranzasCuotas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mvarId As Long
Private mProcesoOK As Boolean
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

   On Error GoTo Mal
   
   Select Case Index
      
      Case 0
         
         If Len(FileBrowser1(0).Text) = 0 Then
            MsgBox "Debe indicar el nombre del archivo a importar", vbExclamation
            Exit Sub
         End If
         
         If Len(Trim(Dir(FileBrowser1(0).Text))) = 0 Then
            MsgBox "Archivo de cobranzas inexiste, reingrese", vbExclamation
            Exit Sub
         End If

         Dim oRs As ADOR.Recordset
         Dim oRsAux As ADOR.Recordset
         Dim s As String, mBanco As String, mCliente As String, mArticulo As String
         Dim mVector_X As String, mVector_T As String, mError As String
         Dim i As Integer, mCodigo As Integer, mCuota As Integer
         Dim mIdBanco As Long, mIdDetalleVentaEnCuotas As Long, mIdCliente As Long
         Dim mIdArticulo As Long, mIdVentaEnCuotas As Long
         Dim mImporteCobrado As Double
         Dim mFechaCobranza As Date
         Dim Filas
         
         Set oRs = CreateObject("ADOR.Recordset")
         With oRs
            .Fields.Append "Id", adInteger, , adFldIsNullable
            .Fields.Append "Codigo", adInteger, , adFldIsNullable
            .Fields.Append "IdBanco", adInteger, , adFldIsNullable
            .Fields.Append "IdVentaEnCuotas", adInteger, , adFldIsNullable
            .Fields.Append "IdDetalleVentaEnCuotas", adInteger, , adFldIsNullable
            .Fields.Append "Ente recaudador", adVarChar, 50, adFldIsNullable
            .Fields.Append "Fecha cobranza", adDate, , adFldIsNullable
            .Fields.Append "Importe cobrado", adNumeric, , adFldIsNullable
            .Fields.Item("Importe cobrado").Precision = 18
            .Fields.Item("Importe cobrado").NumericScale = 2
            .Fields.Append "ImporteCobrado", adNumeric, , adFldIsNullable
            .Fields.Item("ImporteCobrado").Precision = 18
            .Fields.Item("ImporteCobrado").NumericScale = 2
            .Fields.Append "Codigo barra", adVarChar, 50, adFldIsNullable
            .Fields.Append "IdCliente", adInteger, , adFldIsNullable
            .Fields.Append "Cliente", adVarChar, 50, adFldIsNullable
            .Fields.Append "IdArticulo", adInteger, , adFldIsNullable
            .Fields.Append "Bien / Producto", adVarChar, 100, adFldIsNullable
            .Fields.Append "Cuota", adInteger, , adFldIsNullable
            .Fields.Append "Observaciones", adVarChar, 100, adFldIsNullable
            .Fields.Append "Vector_T", adVarChar, 50
            .Fields.Append "Vector_X", adVarChar, 50
         End With
         oRs.Open
         
         mVector_X = "011111161111111133"
         mVector_T = "029991649593901500"
         
         s = LeerArchivoSecuencial(FileBrowser1(0).Text)
         Filas = Split(s, vbCrLf)
         
         mCodigo = CInt(mId(Filas(LBound(Filas)), 2, 2))
         mIdBanco = 0
         mBanco = ""
         Set oRsAux = Aplicacion.Bancos.TraerFiltrado("_PorCodigo", mCodigo)
         If oRsAux.RecordCount > 0 Then
            mIdBanco = oRsAux.Fields(0).Value
            mBanco = oRsAux.Fields("Nombre").Value
         End If
         oRsAux.Close
         
         For i = LBound(Filas) To UBound(Filas)
            
            If mId(Filas(i), 1, 1) = "2" Then
               
               mError = ""
               mIdDetalleVentaEnCuotas = CLng(mId(Filas(i), 24, 8))
               mFechaCobranza = DateSerial(CInt(mId(Filas(i), 8, 4)), _
                                           CInt(mId(Filas(i), 6, 2)), _
                                           CInt(mId(Filas(i), 4, 2)))
               mImporteCobrado = CDbl(mId(Filas(i), 15, 9)) / 100
               
               mIdCliente = 0
               mCliente = ""
               mIdArticulo = 0
               mArticulo = ""
               mCuota = 0
               Set oRsAux = Aplicacion.VentasEnCuotas.TraerFiltrado("_DatosPorIdDetalleVentaEnCuotas", mIdDetalleVentaEnCuotas)
               If oRsAux.RecordCount > 0 Then
                  If Not IsNull(oRsAux.Fields("FechaCobranza").Value) And _
                        oRsAux.Fields("FechaCobranza").Value = mFechaCobranza Then
                     mError = mError & "Registro ya procesado. "
                  End If
                  mIdVentaEnCuotas = oRsAux.Fields("IdVentaEnCuotas").Value
                  mIdCliente = oRsAux.Fields("IdCliente").Value
                  mCliente = oRsAux.Fields("Cliente").Value
                  mIdArticulo = oRsAux.Fields("IdArticulo").Value
                  mArticulo = oRsAux.Fields("Articulo").Value
                  mCuota = oRsAux.Fields("Cuota").Value
               Else
                  mError = mError & "No se encontro la cuota. "
               End If
               oRsAux.Close
               
               With oRs
                  .AddNew
                  .Fields("Id").Value = mIdDetalleVentaEnCuotas
                  .Fields("Codigo").Value = mCodigo
                  .Fields("IdBanco").Value = mIdBanco
                  .Fields("IdVentaEnCuotas").Value = mIdVentaEnCuotas
                  .Fields("IdDetalleVentaEnCuotas").Value = mIdDetalleVentaEnCuotas
                  .Fields("Ente recaudador").Value = mBanco
                  .Fields("Fecha cobranza").Value = mFechaCobranza
                  .Fields("Importe cobrado").Value = mImporteCobrado
                  .Fields("ImporteCobrado").Value = mImporteCobrado
                  .Fields("Codigo barra").Value = mId(Filas(i), 24, 50)
                  .Fields("IdCliente").Value = mIdCliente
                  .Fields("Cliente").Value = mCliente
                  .Fields("IdArticulo").Value = mIdArticulo
                  .Fields("Bien / Producto").Value = mArticulo
                  .Fields("Cuota").Value = mCuota
                  .Fields("Observaciones").Value = mError
                  .Fields("Vector_T").Value = mVector_T
                  .Fields("Vector_X").Value = mVector_X
                  .Update
               End With
            
            End If
         
         Next
         
         cmd(0).Enabled = False
         cmd(2).Enabled = True
         With dcfields(0)
            Set .RowSource = Aplicacion.Bancos.TraerFiltrado("_PorCuentasBancarias")
            .Enabled = True
         End With
         With dcfields(10)
            Set .RowSource = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(2, "X"))
            .Enabled = True
         End With
         
         If oRs.RecordCount > 0 Then oRs.MoveFirst
         Set Lista.DataSource = oRs
         
         Set oRs = Nothing
      
      Case 1
      
         Unload Me
   
      Case 2
      
         mProcesoOK = False
         GenerarCobranzaCuotas
         If mProcesoOK Then
            cmd(2).Enabled = False
            cmd(1).Caption = "Salir"
            MsgBox "Proceso concluido", vbInformation
         End If
   
   End Select
   
Salida:

   Set oRs = Nothing
   Set oRsAux = Nothing
   
   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case -2147217900
         mvarResp = MsgBox("No puede borrar este registro porque se esta" & vbCrLf & "utilizando en otros archivos. Desea ver detalles?", vbYesNo + vbCritical)
         If mvarResp = vbYes Then
            MsgBox "Detalle del error : " & vbCrLf & Err.Number & " -> " & Err.Description
         End If
      Case Else
         MsgBox "Se ha producido un error de procesamiento" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

   Resume Salida
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   mvarId = vnewvalue
   
End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub FileBrowser1_Change(Index As Integer)

   If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
      FileBrowser1(Index).InitDir = FileBrowser1(Index).Text
   End If
   
End Sub

Private Sub Form_Load()

   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   If Not IsNull(oRs.Fields("PathArchivoCobranzaCuotas").Value) Then
      FileBrowser1(0).Text = oRs.Fields("PathArchivoCobranzaCuotas").Value
   End If
   oRs.Close
   Set oRs = Nothing

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Sub GenerarCobranzaCuotas()

   If Not IsNumeric(dcfields(0).BoundText) Then
      MsgBox "Debe indicar la cuenta bancaria", vbExclamation
      Exit Sub
   End If
   
   If Not IsNumeric(dcfields(10).BoundText) Then
      MsgBox "Debe indicar el punto de cobranza", vbExclamation
      Exit Sub
   End If
   
   Dim oAp As ComPronto.Aplicacion
   Dim oVta As ComPronto.VentaEnCuotas
   Dim oRec As ComPronto.Recibo
   Dim oPto As ComPronto.PuntoVenta
   Dim oRs As ADOR.Recordset
   Dim oL As ListItem
   Dim i As Integer, mIdMonedaPesos As Integer, mIdMonedaDolar As Integer
   Dim mDecimales As Integer, mIdPuntoVenta As Integer, mPuntoVenta As Integer
   Dim mIdBanco As Integer
   Dim mIdVentaEnCuotas As Long, mIdDetalleVentaEnCuotas As Long, mIdCliente As Long
   Dim mNumeroRecibo As Long, mIdRecibo As Long, mIdNotaDebito As Long
   Dim mIdImputacion As Long, mIdCuentaBancaria As Long, mIdCuenta As Long
   Dim mImporteCobrado As Double, mCotizacionDolar As Double
   Dim mFechaCobranza As Date
   
   On Error GoTo Mal
   
   Me.MousePointer = vbHourglass
   DoEvents
   
   Set oAp = Aplicacion

   Set oRs = oAp.Parametros.Item(1).Registro
   mDecimales = oRs.Fields("Decimales").Value
   mIdMonedaPesos = oRs.Fields("IdMoneda").Value
   mIdMonedaDolar = oRs.Fields("IdMonedaDolar").Value
   oRs.Close
   
   mIdCuentaBancaria = dcfields(0).BoundText
   mIdPuntoVenta = dcfields(10).BoundText
   mPuntoVenta = CInt(dcfields(10).Text)
   
   Set oRs = oAp.CuentasBancarias.TraerFiltrado("_PorIdConCuenta", mIdCuentaBancaria)
   mIdBanco = 0
   mIdCuenta = 0
   If oRs.RecordCount > 0 Then
      mIdBanco = oRs.Fields("IdBanco").Value
      mIdCuenta = oRs.Fields("IdCuenta").Value
   End If
   oRs.Close
   
   For Each oL In Lista.ListItems
      
      If Len(oL.SubItems(14)) = 0 Then
      
         mIdVentaEnCuotas = oL.SubItems(2)
         mIdDetalleVentaEnCuotas = oL.SubItems(3)
         mIdCliente = oL.SubItems(9)
         mFechaCobranza = CDate(oL.SubItems(5))
         mImporteCobrado = CDbl(oL.SubItems(7))
         
         mCotizacionDolar = Cotizacion(mFechaCobranza, mIdMonedaDolar)
         If mCotizacionDolar = 0 Then
            MsgBox "No hay cotizacion dolar del dia " & mFechaCobranza & vbCrLf & _
                     "ingresela y reprocese el archivo de cobranzas."
            GoTo Salida
         End If
   
         Set oRs = oAp.VentasEnCuotas.TraerFiltrado("_DatosPorIdDetalleVentaEnCuotas", mIdDetalleVentaEnCuotas)
         IdNotaDebito = 0
         If oRs.RecordCount > 0 Then
            mIdNotaDebito = oRs.Fields("IdNotaDebito").Value
         End If
         oRs.Close
         
         mIdImputacion = 0
         Set oRs = oAp.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(mIdNotaDebito, 3))
         If oRs.RecordCount > 0 Then
            mIdImputacion = oRs.Fields(0).Value
         End If
         oRs.Close
         
         Set oRs = oAp.PuntosVenta.TraerFiltrado("_PorId", mIdPuntoVenta)
         If oRs.RecordCount > 0 Then
            mNumeroRecibo = IIf(IsNull(oRs.Fields("ProximoNumero").Value), 1, oRs.Fields("ProximoNumero").Value)
         End If
         oRs.Close
         
         Set oRec = oAp.Recibos.Item(-1)
         With oRec
            With .Registro
               .Fields("NumeroRecibo").Value = mNumeroRecibo
               .Fields("FechaRecibo").Value = mFechaCobranza
               .Fields("IdCliente").Value = mIdCliente
               .Fields("Valores").Value = mImporteCobrado
               .Fields("Efectivo").Value = 0
               .Fields("Documentos").Value = 0
               .Fields("Otros1").Value = 0
               .Fields("Otros2").Value = 0
               .Fields("Otros3").Value = 0
               .Fields("Otros4").Value = 0
               .Fields("Otros5").Value = 0
               .Fields("Deudores").Value = mImporteCobrado
               .Fields("RetencionIVA").Value = 0
               .Fields("RetencionGanancias").Value = 0
               .Fields("RetencionIBrutos").Value = 0
               .Fields("GastosGenerales").Value = 0
               .Fields("Cotizacion").Value = mCotizacionDolar
               .Fields("IdMoneda").Value = mIdMonedaPesos
               .Fields("Tipo").Value = "CC"
               .Fields("AsientoManual").Value = "NO"
               .Fields("CotizacionMoneda").Value = 1
               .Fields("PuntoVenta").Value = mPuntoVenta
               .Fields("IdPuntoVenta").Value = mIdPuntoVenta
               .Fields("Dolarizada").Value = "NO"
            End With
            With .DetRecibos.Item(-1)
               With .Registro
                  .Fields("IdImputacion").Value = mIdImputacion
                  .Fields("Importe").Value = mImporteCobrado
               End With
               .Modificado = True
            End With
            With .DetRecibosValores.Item(-1)
               With .Registro
                  .Fields("IdTipoValor").Value = 21
                  .Fields("Importe").Value = mImporteCobrado
                  .Fields("IdBancoTransferencia").Value = mIdBanco
                  .Fields("IdCuentaBancariaTransferencia").Value = mIdCuentaBancaria
                  .Fields("IdCuenta").Value = mIdCuenta
                  .Fields("NumeroTransferencia").Value = 0
               End With
               .Modificado = True
            End With
            .Guardar
            mIdRecibo = .Registro.Fields(0).Value
         End With
         Set oRec = Nothing
         
         Set oPto = oAp.PuntosVenta.Item(mIdPuntoVenta)
         With oPto
            With .Registro
               .Fields("ProximoNumero").Value = mNumeroRecibo + 1
            End With
            .Guardar
         End With
         Set oPto = Nothing
         
         Set oVta = oAp.VentasEnCuotas.Item(mIdVentaEnCuotas)
         With oVta
            With .DetVentasEnCuotas.Item(mIdDetalleVentaEnCuotas)
               With .Registro
                  .Fields("FechaCobranza").Value = mFechaCobranza
                  .Fields("ImporteCobrado").Value = mImporteCobrado
                  .Fields("IdRecibo").Value = mIdRecibo
               End With
               .Modificado = True
            End With
            .Guardar
         End With
         Set oVta = Nothing
      
      End If
      
   Next
   
   mProcesoOK = True

Salida:
   
   Set oL = Nothing
   Set oRs = Nothing
   Set oPto = Nothing
   Set oVta = Nothing
   Set oRec = Nothing
   Set oAp = Nothing
   
   Me.MousePointer = vbDefault
   
   Exit Sub
   
Mal:

   Dim mvarResp As Integer
   Select Case Err.Number
      Case -2147217900
         mvarResp = MsgBox("No puede borrar este registro porque se esta" & vbCrLf & "utilizando en otros archivos. Desea ver detalles?", vbYesNo + vbCritical)
         If mvarResp = vbYes Then
            MsgBox "Detalle del error : " & vbCrLf & Err.Number & " -> " & Err.Description
         End If
      Case Else
         MsgBox "Se ha producido un error de procesamiento" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

   Resume Salida

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub
