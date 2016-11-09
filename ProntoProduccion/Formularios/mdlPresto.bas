Attribute VB_Name = "mdlPresto"
Private Declare Sub keybd_event Lib "User32" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As Long)
Const KEYEVENTF_KEYUP = &H2
Const VK_LWIN = &H5B

Public Function ImportarDatosDesdePresto() As ADOR.Recordset

   Dim oAp As ComPronto.Aplicacion
   Dim oPr As ComPronto.Proveedor
   Dim oCP As ComPronto.ComprobanteProveedor
   Dim oCl As ComPronto.Cliente
   Dim oRq As ComPronto.Requerimiento
   Dim oPar As ComPronto.Parametro
   Dim oPresto As PrestoApplication
   Dim mCodigoProveedor As String, mPathObra As String, mCuit As String
   Dim mConfirmado As String, mFactura As String, mObra As String
   Dim mContrato As String, mPedido As String, mConcepto As String
   Dim mCodigo As String, s As String, mProveedor As String
   Dim mOk As Boolean, mGrabar As Boolean, mExiste As Boolean
   Dim i As Integer, mIdMonedaPesos As Integer, mIdObra As Integer
   Dim mIdTipoComprobanteFacturaCompra As Integer, mItem As Integer
   Dim mContador As Integer, mProcesados As Integer, mDocumentos As Integer
   Dim mNoProcesadosConError As Integer, mNoProcesadosYaExistentes As Integer
   Dim mIdProveedor As Long, mIdCuentaGasto As Long, mIdCuenta As Long
   Dim mCodigoCuenta As Long, mCodigo2 As Long, mIdCuentaIvaCompras1 As Long
   Dim mIdArticulo As Long, mIdUnidadPorUnidad As Long, mIdArticuloVarios As Long
   Dim mNumeroRequerimiento As Long
   Dim mIdCuentaIvaCompras(10) As Long
   Dim mvarCotizacionDolar As Double, mImporte As Double, mBaseFactura As Double
   Dim mIVA As Double, mTotal As Double, mPrecio As Double, mCantidad As Double
   Dim mImportePedido As Double
   Dim mIVAComprasPorcentaje1 As Single, mPorcentajeIVA As Single
   Dim mIVAComprasPorcentaje(10) As Single
   Dim mFechaFactura As Date, mFechaContrato As Date, mFecha As Date
   Dim mFechaEntrega As Date
   Dim oRs As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim oRsErrores As ADOR.Recordset
   Dim oRsPrestoProv As ADOR.Recordset
   Dim oRsPrestoDoc As ADOR.Recordset
   Dim oRsPrestoSum As ADOR.Recordset
   Dim oRsPrestoConc As ADOR.Recordset
   Dim oF As Form

   On Error GoTo Mal

   Set oRsErrores = CreateObject("ADOR.Recordset")
   With oRsErrores
      .Fields.Append "Id", adInteger
      .Fields.Append "Detalle", adVarChar, 200
   End With
   oRsErrores.Open
   
   Set oF = New frmPathPresto
   With oF
      .Id = 1
      .Show vbModal
      mOk = .Ok
      mPathObra = .FileBrowser1(0).Text
   End With
   Unload oF
   Set oF = Nothing

   If Not mOk Then Exit Function

   Set oAp = Aplicacion

   Set oRs = oAp.Parametros.Item(1).Registro
   mIdMonedaPesos = oRs.Fields("IdMoneda").Value
   mIdTipoComprobanteFacturaCompra = oRs.Fields("IdTipoComprobanteFacturaCompra").Value
   mIdUnidadPorUnidad = oRs.Fields("IdUnidadPorUnidad").Value
   If IsNull(oRs.Fields("IdArticuloVariosParaPRESTO").Value) Then
      oRs.Close
      MsgBox "Debe definir en parametros el item material varios para PRESTO!", vbExclamation
      GoTo Salida
   End If
   mIdArticuloVarios = oRs.Fields("IdArticuloVariosParaPRESTO").Value
   For i = 1 To 10
      If Not IsNull(oRs.Fields("IdCuentaIvaCompras" & i).Value) Then
         mIdCuentaIvaCompras(i) = oRs.Fields("IdCuentaIvaCompras" & i).Value
         mIVAComprasPorcentaje(i) = oRs.Fields("IVAComprasPorcentaje" & i).Value
      Else
         mIdCuentaIvaCompras(i) = 0
         mIVAComprasPorcentaje(i) = 0
      End If
   Next
   oRs.Close
   
   Set oPresto = New PrestoApplication
   oPresto.Open (mPathObra)
   
   Set oF = New frmAviso
   With oF
      .Label1 = "Iniciando PRESTO ..."
      .Show
      .Refresh
      DoEvents
   End With

'   Call keybd_event(VK_LWIN, 0, 0, 0)
'   Call keybd_event(77, 0, 0, 0)
'   Call keybd_event(VK_LWIN, 0, KEYEVENTF_KEYUP, 0)
   
   Sleep 5000
   DoEvents

   'BAJAR PROVEEDORES DE PRESTO A PRONTO
   oF.Label1 = oF.Label1 & vbCrLf & "Cargando proveedores ... "
   DoEvents

   Set oRsPrestoProv = CargarTablaPresto("Proveedores", oPresto, oF)
   
   s = oF.Label1.Caption & vbCrLf
   oF.Label1 = oF.Label1 & vbCrLf & "Procesando proveedores ..."
   DoEvents
   
   mContador = 0
   With oRsPrestoProv
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If .Fields("sTipo").Value = 0 Then
               mContador = mContador + 1
               oF.Label1 = s & "Procesando proveedores ... " & mContador
               oF.Label2 = "Proveedor : " & mId(.Fields("sNombre").Value, 1, 50)
               oF.Label3 = "" & .AbsolutePosition & " / " & .RecordCount
               DoEvents
               mCuit = Trim(.Fields("sNIF").Value)
               If Len(mCuit) > 0 Then
                  Set oRs = oAp.Proveedores.TraerFiltrado("_PorCuitNoEventual", mCuit)
                  If oRs.RecordCount > 0 Then
                     Set oPr = oAp.Proveedores.Item(oRs.Fields(0).Value)
                     mConfirmado = IIf(IsNull(oRs.Fields("Confirmado").Value), "SI", oRs.Fields("Confirmado").Value)
                  Else
                     Set oPr = oAp.Proveedores.Item(-1)
                     mConfirmado = "NO"
                  End If
                  oRs.Close
                  With oPr.Registro
                     .Fields("Confirmado").Value = mConfirmado
                     .Fields("CodigoPresto").Value = oRsPrestoProv.Fields("sProveedor").Value
                     .Fields("RazonSocial").Value = mId(oRsPrestoProv.Fields("sNombre").Value, 1, 50)
                     If Len(oRsPrestoProv.Fields("sDirección").Value) > 0 Then
                        .Fields("Direccion").Value = mId(Trim(oRsPrestoProv.Fields("sDirección").Value) & " " & Trim(oRsPrestoProv.Fields("sCiudad").Value) & " " & Trim(oRsPrestoProv.Fields("sProvincia").Value), 1, 50)
                     End If
                     If Len(oRsPrestoProv.Fields("sCPostal").Value) > 0 Then
                        .Fields("CodigoPostal").Value = oRsPrestoProv.Fields("sCPostal").Value
                     End If
                     .Fields("CUIT").Value = oRsPrestoProv.Fields("sNIF").Value
                     If Len(oRsPrestoProv.Fields("sTeléfono").Value) > 0 Then
                        .Fields("Telefono1").Value = oRsPrestoProv.Fields("sTeléfono").Value
                     End If
                     If Len(oRsPrestoProv.Fields("sCorreo").Value) > 0 Then
                        .Fields("Email").Value = mId(oRsPrestoProv.Fields("sCorreo").Value, 1, 50)
                     End If
                     .Fields("EnviarEmail").Value = 1
                  End With
                  oPr.Guardar
                  Set oPr = Nothing
               End If
            End If
            .MoveNext
         Loop
      End If
   End With
   
   
   'BAJAR CLIENTES DE PRESTO A PRONTO
   s = oF.Label1.Caption & vbCrLf
   oF.Label1 = oF.Label1 & vbCrLf & "Procesando clientes ..."
   oF.Label2 = ""
   oF.Label3 = ""
   DoEvents

   mContador = 0
   With oRsPrestoProv
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If .Fields("sTipo").Value = 1 Then
               mContador = mContador + 1
               oF.Label1 = s & "Procesando clientes ... " & mContador
               oF.Label2 = "Cliente : " & mId(.Fields("sNombre").Value, 1, 50)
               oF.Label3 = "" & .AbsolutePosition & " / " & .RecordCount
               DoEvents
               mCuit = Trim(.Fields("sNIF").Value)
               If Len(mCuit) > 0 Then
                  Set oRs = oAp.Clientes.TraerFiltrado("_PorCuit", mCuit)
                  If oRs.RecordCount > 0 Then
                     Set oCl = oAp.Clientes.Item(oRs.Fields(0).Value)
                     mConfirmado = IIf(IsNull(oRs.Fields("Confirmado").Value), "SI", oRs.Fields("Confirmado").Value)
                  Else
                     Set oCl = oAp.Clientes.Item(-1)
                     mConfirmado = "NO"
                  End If
                  oRs.Close
                  With oCl.Registro
                     .Fields("Confirmado").Value = mConfirmado
                     .Fields("CodigoPresto").Value = oRsPrestoProv.Fields("sProveedor").Value
                     .Fields("RazonSocial").Value = mId(oRsPrestoProv.Fields("sNombre").Value, 1, 50)
                     If Len(oRsPrestoProv.Fields("sDirección").Value) > 0 Then
                        .Fields("Direccion").Value = mId(Trim(oRsPrestoProv.Fields("sDirección").Value) & " " & Trim(oRsPrestoProv.Fields("sCiudad").Value) & " " & Trim(oRsPrestoProv.Fields("sProvincia").Value), 1, 50)
                     End If
                     If Len(oRsPrestoProv.Fields("sCPostal").Value) > 0 Then
                        .Fields("CodigoPostal").Value = oRsPrestoProv.Fields("sCPostal").Value
                     End If
                     .Fields("CUIT").Value = oRsPrestoProv.Fields("sNIF").Value
                     If Len(oRsPrestoProv.Fields("sTeléfono").Value) > 0 Then
                        .Fields("Telefono").Value = oRsPrestoProv.Fields("sTeléfono").Value
                     End If
                     If Len(oRsPrestoProv.Fields("sCorreo").Value) > 0 Then
                        .Fields("Email").Value = mId(oRsPrestoProv.Fields("sCorreo").Value, 1, 30)
                     End If
                  End With
                  oCl.Guardar
                  Set oCl = Nothing
               End If
            End If
            .MoveNext
         Loop
      End If
   End With
   
   
   'Lectura de documentos, detalles y conceptos
   oF.Label1 = oF.Label1 & vbCrLf & "Cargando Documentos ..."
   oF.Label2 = ""
   oF.Label3 = ""
   DoEvents
   Set oRsPrestoDoc = CargarTablaPresto("Documentos", oPresto, oF)
   
   oF.Label1 = oF.Label1 & vbCrLf & "Cargando Suministros ..."
   oF.Label2 = ""
   oF.Label3 = ""
   DoEvents
   Set oRsPrestoSum = CargarTablaPresto("Suministros", oPresto, oF)
   
   oF.Label1 = oF.Label1 & vbCrLf & "Cargando Conceptos ..."
   oF.Label2 = ""
   oF.Label3 = ""
   DoEvents
   Set oRsPrestoConc = CargarTablaPresto("Conceptos", oPresto, oF)
   
   'BAJAR CONTRATOS DE PRESTO COMO REQUERIMIENTOS DE PRONTO
   oF.Label1 = oF.Label1 & vbCrLf & "Procesando contratos ..."
   oF.Label2 = ""
   oF.Label3 = ""
   DoEvents

   With oRsPrestoDoc
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If .Fields("gTipo").Value = 1 And _
                  Len(Trim(.Fields("gProveedor").Value)) = 0 Then
               mGrabar = True
               mContrato = .Fields("gDocumento").Value
               oF.Label2 = "Contrato : " & mContrato
               oF.Label3 = "" & .AbsolutePosition & " / " & .RecordCount
               DoEvents
               Set oRs = oAp.Requerimientos.TraerFiltrado("_PorPRESTOContrato", mContrato)
               If oRs.RecordCount = 0 Then
                  mFechaContrato = DateAdd("yyyy", 80, CDate(.Fields("gFecha").Value))
                  Set oRq = oAp.Requerimientos.Item(-1)
                  With oRq
                     With .Registro
                        .Fields("PRESTOContrato").Value = mContrato
                        .Fields("Confirmado").Value = "NO"
                        .Fields("FechaRequerimiento").Value = Date
                        .Fields("IdObra").Value = 0
                        .Fields("IdMoneda").Value = mIdMonedaPesos
                        .Fields("Observaciones").Value = "Contrato PRESTO : " & _
                                 RTrim(mContrato) & " del " & mFechaContrato & vbCrLf
                     End With
                  End With
                  mItem = 0
                  mIdObra = 0
                  With oRsPrestoSum
                     If .RecordCount > 0 Then
                        .MoveFirst
                        Do While Not .EOF
                           If .Fields("jPedido").Value = mContrato And _
                                 Len(Trim(.Fields("jProveedor").Value)) = 0 Then
                              mIdArticulo = 0
                              Set oRsAux = oAp.Articulos.TraerFiltrado("_PorCodigo", .Fields("jCódigo").Value)
                              If oRsAux.RecordCount > 0 Then
                                 mIdArticulo = oRsAux.Fields(0).Value
                              End If
                              oRsAux.Close
                              If mIdObra = 0 Then
                                 mObra = Trim(.Fields("jObra").Value)
                                 Set oRsAux = oAp.Obras.TraerFiltrado("_PorNumero", mObra)
                                 If oRsAux.RecordCount > 0 Then
                                    mIdObra = oRsAux.Fields(0).Value
                                 End If
                                 oRsAux.Close
                                 If mIdObra = 0 Then
                                    AgregarMensajeProcesoPresto oRsErrores, "El contrato Presto " & mContrato & _
                                          " tiene el item con codigo sin obra o con una obra invalida, toda la RM fue rechazada."
                                    mGrabar = False
                                    Exit Do
                                 End If
                              End If
                              If mIdArticulo = 0 Then
                                 mIdArticulo = mIdArticuloVarios
'                                 oRsErrores.AddNew
'                                 oRsErrores.Fields(0).Value = 0
'                                 oRsErrores.Fields(1).Value = "El contrato Presto " & mContrato & " tiene el item con codigo " & _
'                                    .Fields("jCódigo").Value & " inexistente en PRONTO, toda la RM fue rechazada."
'                                 oRsErrores.Update
'                                 mGrabar = False
'                                 Exit Do
                              End If
                              mCodigo = .Fields("jCódigo").Value
                              mConcepto = "Concepto : " & .Fields("jCódigo").Value & vbCrLf
                              If oRsPrestoConc.RecordCount > 0 Then
                                 oRsPrestoConc.MoveFirst
                                 Do While Not oRsPrestoConc.EOF
                                    If oRsPrestoConc.Fields("cCódigo").Value = .Fields("jCódigo").Value Then
                                       mConcepto = mConcepto & oRsPrestoConc.Fields("cResumen").Value
                                       Exit Do
                                    End If
                                    oRsPrestoConc.MoveNext
                                 Loop
                              End If
                              If Len(.Fields("jNota").Value) > 0 Then
                                 mConcepto = mConcepto & vbCrLf & .Fields("jNota").Value
                              End If
                              mCantidad = .Fields("jCantidad").Value
                              If .Fields("jFecPrev").Value > 0 Then
                                 mFecha = DateAdd("yyyy", 80, CDate(.Fields("jFecPrev").Value))
                              Else
                                 mFecha = mFechaContrato
                              End If
                              With oRq.DetRequerimientos.Item(-1)
                                 mItem = mItem + 1
                                 With .Registro
                                    .Fields("IdArticulo").Value = mIdArticulo
                                    .Fields("Cantidad").Value = mCantidad
                                    .Fields("IdUnidad").Value = mIdUnidadPorUnidad
                                    .Fields("NumeroItem").Value = mItem
                                    .Fields("FechaEntrega").Value = mFecha
                                    .Fields("Adjunto").Value = "NO"
                                    .Fields("EsBienDeUso").Value = "NO"
                                    .Fields("Observaciones").Value = mConcepto
                                    .Fields("PRESTOConcepto").Value = mCodigo
                                 End With
                                 .Modificado = True
                              End With
                           End If
                           .MoveNext
                        Loop
                     End If
                  End With
                  If mGrabar Then
                     Set oPar = Aplicacion.Parametros.Item(1)
                     mNumeroRequerimiento = oPar.Registro.Fields("ProximoNumeroRequerimiento").Value
'                     With oPar
'                        .Registro.Fields("ProximoNumeroRequerimiento").Value = mNumeroRequerimiento + 1
'                        .Guardar
'                     End With
                     Set oPar = Nothing
                     oRq.Registro.Fields("NumeroRequerimiento").Value = mNumeroRequerimiento
                     oRq.Registro.Fields("IdObra").Value = mIdObra
                     oRq.Guardar
                  End If
                  Set oRq = Nothing
               End If
               oRs.Close
            End If
            .MoveNext
         Loop
      End If
   End With
   
   
   'BAJAR FACTURAS DE PRESTO A PRONTO
   s = oF.Label1.Caption & vbCrLf
   oF.Label1 = oF.Label1 & vbCrLf & "Procesando facturas ..."
   oF.Label2 = ""
   oF.Label3 = ""
   DoEvents

   AgregarMensajeProcesoPresto oRsErrores, "IMPORTACION DE FACTURAS DE COMPRA " & _
      "DESDE PRESTO HACIA PRONTO"
   
   mContador = 0
   mDocumentos = 0
   mProcesados = 0
   mNoProcesadosConError = 0
   mNoProcesadosYaExistentes = 0
   
   With oRsPrestoDoc
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If .Fields("gTipo").Value = 3 Then
               mGrabar = True
               mFactura = .Fields("gDocumento").Value
               mCodigoProveedor = .Fields("gProveedor").Value
               mContador = mContador + 1
               mDocumentos = mDocumentos + 1
               oF.Label1 = s & "Procesando facturas ... " & mContador
               oF.Label2 = "Factura : " & mFactura
               oF.Label3 = "" & .AbsolutePosition & " / " & .RecordCount
               DoEvents
               Set oRs = oAp.ComprobantesProveedores.TraerFiltrado("_PorPRESTOFactura", Array(mFactura, mCodigoProveedor))
               If oRs.RecordCount > 0 Then
                  mNoProcesadosYaExistentes = mNoProcesadosYaExistentes + 1
               Else
                  mIdProveedor = 0
                  mProveedor = ""
                  Set oRsAux = oAp.Proveedores.TraerFiltrado("_PorCodigoPresto", mCodigoProveedor)
                  If oRsAux.RecordCount > 0 Then
                     mIdProveedor = oRsAux.Fields(0).Value
                     mProveedor = oRsAux.Fields("RazonSocial").Value
                  End If
                  oRsAux.Close
                  If Len(Trim(mFactura)) = 0 Or _
                        ((mId(mFactura, 1, 1) <> "A" And mId(mFactura, 1, 1) <> "B" And _
                          mId(mFactura, 1, 1) <> "C" And mId(mFactura, 1, 1) <> "E") And _
                        Not IsNumeric(mId(mFactura, 2, 4)) And Not IsNumeric(mId(mFactura, 6, 8))) Then
                     AgregarMensajeProcesoPresto oRsErrores, "Hay una factura del proveedor " & _
                        mProveedor & " " & vbCrLf & "numero " & mFactura & " no tiene un formato valido, " & _
                        "toda la factura fue rechazada."
                     mGrabar = False
                  End If
                  If mIdProveedor = 0 Then
                     AgregarMensajeProcesoPresto oRsErrores, "La factura Presto " & mFactura & " es de un proveedor inexistente " & _
                        "en PRONTO, el codigo de PRESTO es " & mCodigoProveedor & ", toda la factura fue rechazada."
                     mGrabar = False
                  Else
                     mFechaFactura = DateAdd("yyyy", 80, CDate(.Fields("gFecha").Value))
                     mvarCotizacionDolar = Cotizacion(mFechaFactura, glbIdMonedaDolar)
                     mBaseFactura = .Fields("gBaseFac").Value
                     mPorcentajeIVA = .Fields("gIVA").Value
                     mIVA = Round(mBaseFactura * mPorcentajeIVA / 100, 4)
                     mTotal = mBaseFactura + mIVA
                     mIdCuentaIvaCompras1 = 0
                     mIVAComprasPorcentaje1 = 0
                     If mPorcentajeIVA <> 0 Then
                        For i = 1 To 10
                           If mIVAComprasPorcentaje(i) = mPorcentajeIVA Then
                              mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(i)
                              mIVAComprasPorcentaje1 = mIVAComprasPorcentaje(i)
                              Exit For
                           End If
                        Next
                     End If
                     If mIVA <> 0 And mIdCuentaIvaCompras1 = 0 Then
                        AgregarMensajeProcesoPresto oRsErrores, "La factura Presto " & mFactura & _
                           ", tiene un porcentaje de iva igual a " & mPorcentajeIVA & " que no " & _
                           "tiene en los parametros de Pronto una cuenta contable asignada, " & _
                           "toda la factura fue rechazada."
                        mGrabar = False
                     End If
                     Set oCP = oAp.ComprobantesProveedores.Item(-1)
                     With oCP
                        With .Registro
                           .Fields("Confirmado").Value = "NO"
                           .Fields("PRESTOFactura").Value = mFactura
                           .Fields("PRESTOProveedor").Value = mCodigoProveedor
                           .Fields("IdTipoComprobante").Value = mIdTipoComprobanteFacturaCompra
                           .Fields("FechaComprobante").Value = mFechaFactura
                           .Fields("FechaRecepcion").Value = Date
                           .Fields("FechaVencimiento").Value = mFechaFactura
                           .Fields("TotalBruto").Value = mBaseFactura
                           .Fields("TotalIva1").Value = mIVA
                           .Fields("TotalIva2").Value = 0
                           .Fields("TotalBonificacion").Value = 0
                           .Fields("TotalComprobante").Value = mTotal
                           .Fields("PorcentajeBonificacion").Value = 0
                           .Fields("TotalIVANoDiscriminado").Value = 0
                           .Fields("AjusteIVA").Value = 0
                           .Fields("IdMoneda").Value = mIdMonedaPesos
                           .Fields("CotizacionMoneda").Value = 1
                           .Fields("CotizacionDolar").Value = mvarCotizacionDolar
                           .Fields("IdProveedor").Value = mIdProveedor
                           If mId(mFactura, 1, 1) = "A" Or mId(mFactura, 1, 1) = "B" Or _
                              mId(mFactura, 1, 1) = "C" Or mId(mFactura, 1, 1) = "E" Then
                              .Fields("Letra").Value = mId(mFactura, 1, 1)
                           End If
                           If IsNumeric(mId(mFactura, 2, 4)) Then
                              .Fields("NumeroComprobante1").Value = Val(mId(mFactura, 2, 4))
                           End If
                           If IsNumeric(mId(mFactura, 6, 8)) Then
                              .Fields("NumeroComprobante2").Value = Val(mId(mFactura, 6, 8))
                           End If
                        End With
                     End With
                     With oRsPrestoSum
                        If .RecordCount > 0 Then
                           .MoveFirst
                           Do While Not .EOF
                              If .Fields("jFactura").Value = mFactura And _
                                    .Fields("jProveedor").Value = mCodigoProveedor Then
                                 mIdCuenta = 0
                                 mCodigoCuenta = 0
                                 mIdCuentaGasto = 0
                                 If oRsPrestoConc.RecordCount > 0 Then
                                    oRsPrestoConc.MoveFirst
                                    Do While Not oRsPrestoConc.EOF
                                       If oRsPrestoConc.Fields("cCódigo").Value = .Fields("jCódigo").Value Then
                                          If Len(Trim(oRsPrestoConc.Fields("cCódigo2").Value)) > 0 And _
                                                IsNumeric(Trim(oRsPrestoConc.Fields("cCódigo2").Value)) Then
                                             mCodigo2 = Val(Trim(oRsPrestoConc.Fields("cCódigo2").Value))
                                             If mCodigo2 > 1000 Then
                                                Set oRsAux = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigo2)
                                                If oRsAux.RecordCount > 0 Then
                                                   mIdCuenta = oRsAux.Fields(0).Value
                                                   mCodigoCuenta = mCodigo2
                                                End If
                                             Else
                                                Set oRsAux = oAp.CuentasGastos.TraerFiltrado("_PorId", mCodigo2)
                                                If oRsAux.RecordCount > 0 Then
                                                   mIdCuentaGasto = oRsAux.Fields(0).Value
                                                End If
                                             End If
                                             oRsAux.Close
                                          End If
                                          Exit Do
                                       End If
                                       oRsPrestoConc.MoveNext
                                    Loop
                                 End If
                                 If mIdCuentaGasto = 0 And mIdCuenta = 0 Then
                                    AgregarMensajeProcesoPresto oRsErrores, "La factura Presto " & mFactura & " tiene el item con codigo " & _
                                       .Fields("jCódigo").Value & " sin la cuenta de gasto en codigo2 o una cuenta invalida, " & _
                                       "toda la factura fue rechazada."
                                    mGrabar = False
                                    Exit Do
                                 End If
                                 
                                 mObra = Trim(.Fields("jObra").Value)
                                 mIdObra = 0
                                 Set oRsAux = oAp.Obras.TraerFiltrado("_PorNumero", mObra)
                                 If oRsAux.RecordCount > 0 Then
                                    mIdObra = oRsAux.Fields(0).Value
                                 End If
                                 oRsAux.Close
                                 If mIdObra = 0 And mIdCuenta = 0 Then
                                    AgregarMensajeProcesoPresto oRsErrores, "La factura Presto " & mFactura & " tiene el item con codigo " & _
                                       .Fields("jCódigo").Value & " sin obra o con una obra invalida, toda la factura fue rechazada."
                                    mGrabar = False
                                    Exit Do
                                 End If
                                 
                                 If mIdCuenta = 0 Then
                                    Set oRsAux = oAp.Cuentas.TraerFiltrado("_PorObraCuentaGasto", Array(mIdObra, mIdCuentaGasto))
                                    If oRsAux.RecordCount > 0 Then
                                       mIdCuenta = oRsAux.Fields(0).Value
                                       mCodigoCuenta = oRsAux.Fields("Codigo").Value
                                    End If
                                    oRsAux.Close
                                    If mIdCuentaGasto = 0 Then
                                       AgregarMensajeProcesoPresto oRsErrores, "La factura Presto " & mFactura & " tiene el item con codigo " & _
                                          .Fields("jCódigo").Value & " para el que no se encontro la cuenta contable, " & _
                                          "IdObra " & mIdObra & ", IdCuentaGasto " & mIdCuentaGasto & ", toda la factura fue rechazada."
                                       mGrabar = False
                                       Exit Do
                                    End If
                                 End If
                                 
                                 mImporte = oRsPrestoSum.Fields("jCantidad").Value * oRsPrestoSum.Fields("jPrecio").Value
                                 If Not IsNull(oRsPrestoSum.Fields("jDto").Value) Then
                                    mImporte = mImporte - (mImporte * oRsPrestoSum.Fields("jDto").Value / 100)
                                 End If
                                 
                                 With oCP.DetComprobantesProveedores.Item(-1)
                                    With .Registro
                                       .Fields("PRESTOConcepto").Value = oRsPrestoSum.Fields("jCódigo").Value
                                       .Fields("PRESTOObra").Value = mObra
                                       .Fields("IdObra").Value = mIdObra
                                       .Fields("IdCuentaGasto").Value = mIdCuentaGasto
                                       .Fields("IdCuenta").Value = mIdCuenta
                                       .Fields("CodigoCuenta").Value = mCodigoCuenta
                                       .Fields("Importe").Value = mImporte
                                       If mIdCuentaIvaCompras1 <> 0 Then
                                          .Fields("IdCuentaIvaCompras1").Value = mIdCuentaIvaCompras1
                                          .Fields("IVAComprasPorcentaje1").Value = mIVAComprasPorcentaje1
                                          .Fields("ImporteIVA1").Value = Round(mImporte * mIVAComprasPorcentaje1 / 100, 2)
                                          .Fields("AplicarIVA1").Value = "SI"
                                       Else
                                          .Fields("IdCuentaIvaCompras1").Value = Null
                                          .Fields("IVAComprasPorcentaje1").Value = 0
                                          .Fields("ImporteIVA1").Value = 0
                                          .Fields("AplicarIVA1").Value = "NO"
                                       End If
                                       .Fields("IdCuentaIvaCompras2").Value = Null
                                       .Fields("IVAComprasPorcentaje2").Value = 0
                                       .Fields("ImporteIVA2").Value = 0
                                       .Fields("AplicarIVA2").Value = "NO"
                                       .Fields("IdCuentaIvaCompras3").Value = Null
                                       .Fields("IVAComprasPorcentaje3").Value = 0
                                       .Fields("ImporteIVA3").Value = 0
                                       .Fields("AplicarIVA3").Value = "NO"
                                       .Fields("IdCuentaIvaCompras4").Value = Null
                                       .Fields("IVAComprasPorcentaje4").Value = 0
                                       .Fields("ImporteIVA4").Value = 0
                                       .Fields("AplicarIVA4").Value = "NO"
                                       .Fields("IdCuentaIvaCompras5").Value = Null
                                       .Fields("IVAComprasPorcentaje5").Value = 0
                                       .Fields("ImporteIVA5").Value = 0
                                       .Fields("AplicarIVA5").Value = "NO"
                                       .Fields("IdCuentaIvaCompras6").Value = Null
                                       .Fields("IVAComprasPorcentaje6").Value = 0
                                       .Fields("ImporteIVA6").Value = 0
                                       .Fields("AplicarIVA6").Value = "NO"
                                       .Fields("IdCuentaIvaCompras7").Value = Null
                                       .Fields("IVAComprasPorcentaje7").Value = 0
                                       .Fields("ImporteIVA7").Value = 0
                                       .Fields("AplicarIVA7").Value = "NO"
                                       .Fields("IdCuentaIvaCompras8").Value = Null
                                       .Fields("IVAComprasPorcentaje8").Value = 0
                                       .Fields("ImporteIVA8").Value = 0
                                       .Fields("AplicarIVA8").Value = "NO"
                                       .Fields("IdCuentaIvaCompras9").Value = Null
                                       .Fields("IVAComprasPorcentaje9").Value = 0
                                       .Fields("ImporteIVA9").Value = 0
                                       .Fields("AplicarIVA9").Value = "NO"
                                       .Fields("IdCuentaIvaCompras10").Value = Null
                                       .Fields("IVAComprasPorcentaje10").Value = 0
                                       .Fields("ImporteIVA10").Value = 0
                                       .Fields("AplicarIVA10").Value = "NO"
                                    End With
                                    .Modificado = True
                                 End With
                              End If
                              .MoveNext
                           Loop
                        End If
                     End With
                  End If
                  If mGrabar Then
                     oCP.Guardar
                     mProcesados = mProcesados + 1
                  Else
                     mNoProcesadosConError = mNoProcesadosConError + 1
                  End If
                  Set oCP = Nothing
                  'Marcar facturas en presto
                  If oPresto.StepFirst("Documentos") = 0 Then
                     Do While oPresto.FindEqual("Documentos", "gDocumento", mFactura) = 0
                        If oPresto.GetStr("gTipo") = 3 Then
                           If mGrabar Then
                              oPresto.SetNum ("gExp"), 49
                           Else
                              oPresto.SetNum ("gExp"), 0
                           End If
                           oPresto.UpdateRecord ("Documentos")
                           Exit Do
                        Else
                           If oPresto.StepFirst("Documentos") = 0 Then
                              Do
                                 If oPresto.GetStr("gDocumento") = mFactura And _
                                       oPresto.GetStr("gTipo") = 3 Then
                                    If mGrabar Then
                                       oPresto.SetNum ("gExp"), 49
                                    Else
                                       oPresto.SetNum ("gExp"), 0
                                    End If
                                    oPresto.UpdateRecord ("Documentos")
                                    Exit Do
                                 End If
                              Loop While oPresto.StepNext("Documentos") = 0
                           End If
                        End If
                     Loop
                  End If
               End If
               oRs.Close
            End If
            .MoveNext
         Loop
      End If
   End With
   
   AgregarMensajeProcesoPresto oRsErrores, "Informe proceso importacion de facturas de compra desde Presto hacia Pronto : "
   AgregarMensajeProcesoPresto oRsErrores, "Documentos importados : " & mProcesados
   AgregarMensajeProcesoPresto oRsErrores, "Documentos no importados (con error) : " & mNoProcesadosConError
   AgregarMensajeProcesoPresto oRsErrores, "Documentos no importados (ya existentes) : " & mNoProcesadosYaExistentes
   AgregarMensajeProcesoPresto oRsErrores, ""
   
   'SUBIR PEDIDOS DE PRONTO A PRESTO
   oF.Label1 = oF.Label1 & vbCrLf & "Procesando pedidos a PRESTO ..."
   oF.Label2 = ""
   oF.Label3 = ""
   DoEvents

   Set oRs = oAp.Pedidos.TraerFiltrado("_ParaPasarAPrestoCabeceras")
   If oRs.RecordCount > 0 Then
      oRs.MoveFirst
      Do While Not oRs.EOF
         mGrabar = True
         mContrato = oRs.Fields("PRESTOContrato").Value
         mPedido = oRs.Fields("Pedido").Value
         mFecha = oRs.Fields("Fecha").Value
         mCodigoProveedor = IIf(IsNull(oRs.Fields("ProveedorPresto").Value), "", oRs.Fields("ProveedorPresto").Value)
         mImportePedido = IIf(IsNull(oRs.Fields("ImportePedido").Value), 0, oRs.Fields("ImportePedido").Value)
         If mCodigoProveedor = "" Then
            AgregarMensajeProcesoPresto oRsErrores, "El pedido de PRONTO numero " & mPedido & _
               " del " & mFecha & ", tiene un proveedor inexistente en PRESTO."
            oRsErrores.Update
            mGrabar = False
         End If
         If mGrabar Then
            mExiste = False
            If oPresto.StepFirst("Documentos") = 0 Then
               Do
                  If oPresto.GetStr("gDocumento") = mContrato And _
                        Trim(oPresto.GetStr("gProveedor")) = "" And _
                        oPresto.GetStr("gTipo") = 1 And _
                        oPresto.GetStr("gPrevisional") = 1 Then
                     oPresto.SetStr ("gConProveedor"), mCodigoProveedor
                     oPresto.UpdateRecord ("Documentos")
                     mExiste = True
                     Exit Do
                  End If
               Loop While oPresto.StepNext("Documentos") = 0
            End If
            If Not mExiste Then
               AgregarMensajeProcesoPresto oRsErrores, "El contrato Presto " & mContrato & _
                  " no fue encontrado y hay una referencia a el en el " & _
                  "pedido de PRONTO numero " & mPedido & " del " & mFecha & "."
               oRsErrores.Update
               mGrabar = False
            End If
            mExiste = False
            With oRsPrestoDoc
               If .RecordCount > 0 Then
                  .MoveFirst
                  Do While Not .EOF
                     If .Fields("gDocumento").Value = mPedido And _
                           .Fields("gProveedor").Value = mCodigoProveedor And _
                           .Fields("gTipo").Value = 1 And _
                           .Fields("gPrevisional").Value = 0 Then
                        mExiste = True
                        Exit Do
                     End If
                     .MoveNext
                  Loop
               End If
            End With
            If Not mExiste Then
               oPresto.InitRecord "Documentos"
               oPresto.SetStr "gDocumento", mPedido
               oPresto.SetStr "gProveedor", mCodigoProveedor
               oPresto.SetNum "gTipo", 1
               oPresto.SetNum "gPrevisional", 0
               oPresto.SetNum "gFecha", DateAdd("yyyy", -80, mFecha)
               oPresto.SetStr "gOrgContrato", mContrato
               oPresto.SetNum "gBasePed", mImportePedido
               oPresto.InsertRecord "Documentos"
            End If
         End If
         oAp.Tarea "Pedidos_SetearPedidoPresto", Array(oRs.Fields(0).Value, mPedido)
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   Set oRs = oAp.Pedidos.TraerFiltrado("_ParaPasarAPrestoDetalles")
   If oRs.RecordCount > 0 Then
      oRs.MoveFirst
      Do While Not oRs.EOF
         mGrabar = True
         mContrato = oRs.Fields("PRESTOContrato").Value
         mPedido = oRs.Fields("Pedido").Value
         mFecha = oRs.Fields("Fecha").Value
         mCodigoProveedor = IIf(IsNull(oRs.Fields("ProveedorPresto").Value), "", oRs.Fields("ProveedorPresto").Value)
         mConcepto = IIf(IsNull(oRs.Fields("PRESTOConcepto").Value), "", oRs.Fields("PRESTOConcepto").Value)
         mPrecio = oRs.Fields("Precio").Value
         mCantidad = oRs.Fields("Cantidad").Value
         mFechaEntrega = oRs.Fields("FechaEntrega").Value
         mObra = oRs.Fields("NumeroObra").Value
         mExiste = False
         With oRsPrestoSum
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  If .Fields("jPedido").Value = mPedido And _
                        .Fields("jProveedor").Value = mCodigoProveedor And _
                        .Fields("jCódigo").Value = mConcepto Then
                     mExiste = True
                     Exit Do
                  End If
                  .MoveNext
               Loop
            End If
         End With
         If Not mExiste Then
            oPresto.InitRecord "Suministros"
            oPresto.SetStr "jPedido", mPedido
            oPresto.SetStr "jProveedor", mCodigoProveedor
            oPresto.SetStr "jCódigo", mConcepto
            oPresto.SetNum "jCantidad", mCantidad
            oPresto.SetNum "jPrecio", mPrecio
            oPresto.SetNum "jFecPrev", DateAdd("yyyy", -80, mFechaEntrega)
            oPresto.SetStr "jObra", mObra
            oPresto.InsertRecord "Suministros"
         End If
         oAp.Tarea "DetPedidos_SetearPedidoPresto", Array(oRs.Fields(0).Value, mPedido)
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   oPresto.Command ("Archivo|Guardar")
   
Salida:

   On Error Resume Next
   
   oRsPrestoProv.Close
   oRsPrestoDoc.Close
   oRsPrestoSum.Close
   oRsPrestoConc.Close
   
   oPresto.Close
   oPresto.Quit

   Set ImportarDatosDesdePresto = oRsErrores
   
   Unload oF
   Set oF = Nothing

   Set oRs = Nothing
   Set oRsErrores = Nothing
   Set oRsPrestoProv = Nothing
   Set oRsPrestoDoc = Nothing
   Set oRsPrestoSum = Nothing
   Set oRsPrestoConc = Nothing
   Set oRsAux = Nothing
   Set oPr = Nothing
   Set oCl = Nothing
   Set oRq = Nothing
   Set oAp = Nothing
   Set oPresto = Nothing

   Exit Function

Mal:

   MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   Resume Salida
   
End Function

Public Function CargarTablaPresto(ByVal Tabla As String, _
                                 ByRef oPresto As PrestoApplication, _
                                 Optional ByVal oF As Form) As ADOR.Recordset

   Dim Aprocesar(4, 5) As String
   Dim Tablas(4, 100, 1) As String
   
   'Definicion de tablas para intercambiar
   'Posicion 0 : Nombre de la tabla
   'Posicion 1 : Cantidad de campos habilitados
   'Posicion 2 : Control de duplicados
   'Posicion 3 : T=Tabla, C=Cabeza, D=Detalle
   'Posicion 4 : Nombre de campo clave Cabeza-Detalle + tipo de dato del campo
   '             (obligatorio si la posicion 2 = SI)
   'Posicion 5 : SI=Procesar, NO=No procesar
   
   Aprocesar(0, 0) = "Conceptos"
   Aprocesar(0, 1) = "13"
   Aprocesar(0, 2) = "NO"
   Aprocesar(0, 3) = "T"
   Aprocesar(0, 4) = ""
   Aprocesar(0, 5) = "SI"
   
   Aprocesar(1, 0) = "Proveedores"
   Aprocesar(1, 1) = "28"
   Aprocesar(1, 2) = "NO"
   Aprocesar(1, 3) = "T"
   Aprocesar(1, 4) = ""
   Aprocesar(1, 5) = "SI"
   
   Aprocesar(2, 0) = "Relaciones"
   Aprocesar(2, 1) = "35"
   Aprocesar(2, 2) = "NO"
   Aprocesar(2, 3) = "T"
   Aprocesar(2, 4) = ""
   Aprocesar(2, 5) = "SI"
   
   Aprocesar(3, 0) = "Documentos"
   Aprocesar(3, 1) = "25"
   Aprocesar(3, 2) = "SI"
   Aprocesar(3, 3) = "C"
   Aprocesar(3, 4) = "gDocumento|gProveedor"
   Aprocesar(3, 5) = "SI"
   
   Aprocesar(4, 0) = "Suministros"
   Aprocesar(4, 1) = "15"
   Aprocesar(4, 2) = "NO"
   Aprocesar(4, 3) = "D"
   Aprocesar(4, 4) = "jDocumento|jProveedor"
   Aprocesar(4, 5) = "NO"
   
   'CONCEPTOS
   Tablas(0, 0, 0) = "cCódigo"
   Tablas(0, 1, 0) = "cInfo"
   Tablas(0, 2, 0) = "cNat"
   Tablas(0, 3, 0) = "cCódigo2"
   Tablas(0, 4, 0) = "cOrigen"
   Tablas(0, 5, 0) = "cUd"
   Tablas(0, 6, 0) = "cResumen"
   Tablas(0, 7, 0) = "cDivisa"
   Tablas(0, 8, 0) = "cFecha"
   Tablas(0, 9, 0) = "cPrPres"
   Tablas(0, 10, 0) = "cPrReal"
   Tablas(0, 11, 0) = "cPrCert"
   Tablas(0, 12, 0) = "cPrObj"
   Tablas(0, 13, 0) = "cPrPlan"
   Tablas(0, 14, 0) = "cTipoPres"
   Tablas(0, 15, 0) = "cTipoCert"
   Tablas(0, 16, 0) = "cTipoReal"
   Tablas(0, 17, 0) = "cTipoObj"
   Tablas(0, 18, 0) = "cTipoPlan"
   Tablas(0, 19, 0) = "cNuloPres"
   Tablas(0, 20, 0) = "cNuloCert"
   Tablas(0, 21, 0) = "cNuloReal"
   Tablas(0, 22, 0) = "cNuloObj"
   Tablas(0, 23, 0) = "cNuloPlan"
   Tablas(0, 24, 0) = "cCompras"
   Tablas(0, 25, 0) = "cFacRend"
   Tablas(0, 26, 0) = "cDurUnit"
   Tablas(0, 27, 0) = "cTipoDurUnit"
   Tablas(0, 28, 0) = "cMdoPres"
   Tablas(0, 29, 0) = "cMdoCert"
   Tablas(0, 30, 0) = "cMdoReal"
   Tablas(0, 31, 0) = "cMdoObj"
   Tablas(0, 32, 0) = "cMdoPlan"
   Tablas(0, 33, 0) = "cMatPres"
   Tablas(0, 34, 0) = "cMatCert"
   Tablas(0, 35, 0) = "cMatReal"
   Tablas(0, 36, 0) = "cMatObj"
   Tablas(0, 37, 0) = "cMatPlan"
   Tablas(0, 38, 0) = "cMaqPres"
   Tablas(0, 39, 0) = "cMaqCert"
   Tablas(0, 40, 0) = "cMaqReal"
   Tablas(0, 41, 0) = "cMaqObj"
   Tablas(0, 42, 0) = "cMaqPlan"
   Tablas(0, 43, 0) = "cOtrPres"
   Tablas(0, 44, 0) = "cOtrCert"
   Tablas(0, 45, 0) = "cOtrReal"
   Tablas(0, 46, 0) = "cOtrObj"
   Tablas(0, 47, 0) = "cOtrPlan"
   Tablas(0, 48, 0) = "cExistencias"
   Tablas(0, 49, 0) = "cConsAuto"
   Tablas(0, 50, 0) = "cCabComentario"
   Tablas(0, 51, 0) = "cFórmula"
   Tablas(0, 52, 0) = "cRedParc"
   Tablas(0, 53, 0) = "cCabAUni"
   Tablas(0, 54, 0) = "cCabBLon"
   Tablas(0, 55, 0) = "cCabCLat"
   Tablas(0, 56, 0) = "cCabDAlt"
   Tablas(0, 57, 0) = "cConsumo"
   Tablas(0, 58, 0) = "cEstado"
   Tablas(0, 59, 0) = "cCanTotTeor"
   Tablas(0, 60, 0) = "cContrato"
   Tablas(0, 61, 0) = "cSubMdoPres"
   Tablas(0, 62, 0) = "cSubMdoCert"
   Tablas(0, 63, 0) = "cSubMdoReal"
   Tablas(0, 64, 0) = "cSubMdoObj"
   Tablas(0, 65, 0) = "cSubMdoPlan"
   Tablas(0, 66, 0) = "cSubMatPres"
   Tablas(0, 67, 0) = "cSubMatCert"
   Tablas(0, 68, 0) = "cSubMatReal"
   Tablas(0, 69, 0) = "cSubMatObj"
   Tablas(0, 70, 0) = "cSubMatPlan"
   Tablas(0, 71, 0) = "cSubMaqPres"
   Tablas(0, 72, 0) = "cSubMaqCert"
   Tablas(0, 73, 0) = "cSubMaqReal"
   Tablas(0, 74, 0) = "cSubMaqObj"
   Tablas(0, 75, 0) = "cSubMaqPlan"
   Tablas(0, 76, 0) = "cSubOtrPres"
   Tablas(0, 77, 0) = "cSubOtrCert"
   Tablas(0, 78, 0) = "cSubOtrReal"
   Tablas(0, 79, 0) = "cSubOtrObj"
   Tablas(0, 80, 0) = "cSubOtrPlan"
   Tablas(0, 81, 0) = "cPrProyTot"
'   Tablas(0,82, 0) = "cTexto1"
'   Tablas(0,83, 0) = "cTipoTexto1"
'   Tablas(0,84, 0) = "cTexto2"
'   Tablas(0,85, 0) = "cTipoTexto2"
'   Tablas(0,86, 0) = "cImagen"
'   Tablas(0,87, 0) = "cTipo"
'   Tablas(0,88, 0) = "cDibujo"
'   Tablas(0,89, 0) = "cTipoDibujo"
   
   Tablas(0, 0, 1) = "S|13||"
   Tablas(0, 1, 1) = "N|INT|0|0"
   Tablas(0, 2, 1) = "N|INT|0|0"
   Tablas(0, 3, 1) = "S|13||"
   Tablas(0, 4, 1) = "S|13||"
   Tablas(0, 5, 1) = "S|4||"
   Tablas(0, 6, 1) = "S|64||"
   Tablas(0, 7, 1) = "S|3||"
   Tablas(0, 8, 1) = "S|10||"
   Tablas(0, 9, 1) = "N|NUM|18|2"
   Tablas(0, 10, 1) = "N|NUM|18|2"
   Tablas(0, 11, 1) = "N|NUM|18|2"
   Tablas(0, 12, 1) = "N|NUM|18|2"
   Tablas(0, 13, 1) = "N|NUM|18|2"
   Tablas(0, 14, 1) = "N|INT|0|0"
   Tablas(0, 15, 1) = "N|INT|0|0"
   Tablas(0, 16, 1) = "N|INT|0|0"
   Tablas(0, 17, 1) = "N|INT|0|0"
   Tablas(0, 18, 1) = "N|INT|0|0"
   Tablas(0, 19, 1) = "N|INT|0|0"
   Tablas(0, 20, 1) = "N|INT|0|0"
   Tablas(0, 21, 1) = "N|INT|0|0"
   Tablas(0, 22, 1) = "N|INT|0|0"
   Tablas(0, 23, 1) = "N|INT|0|0"
   Tablas(0, 24, 1) = "N|NUM|18|2"
   Tablas(0, 25, 1) = "N|NUM|18|2"
   Tablas(0, 26, 1) = "N|NUM|18|2"
   Tablas(0, 27, 1) = "N|INT|0|0"
   Tablas(0, 28, 1) = "N|NUM|18|2"
   Tablas(0, 29, 1) = "N|NUM|18|2"
   Tablas(0, 30, 1) = "N|NUM|18|2"
   Tablas(0, 31, 1) = "N|NUM|18|2"
   Tablas(0, 32, 1) = "N|NUM|18|2"
   Tablas(0, 33, 1) = "N|NUM|18|2"
   Tablas(0, 34, 1) = "N|NUM|18|2"
   Tablas(0, 35, 1) = "N|NUM|18|2"
   Tablas(0, 36, 1) = "N|NUM|18|2"
   Tablas(0, 37, 1) = "N|NUM|18|2"
   Tablas(0, 38, 1) = "N|NUM|18|2"
   Tablas(0, 39, 1) = "N|NUM|18|2"
   Tablas(0, 40, 1) = "N|NUM|18|2"
   Tablas(0, 41, 1) = "N|NUM|18|2"
   Tablas(0, 42, 1) = "N|NUM|18|2"
   Tablas(0, 43, 1) = "N|NUM|18|2"
   Tablas(0, 44, 1) = "N|NUM|18|2"
   Tablas(0, 45, 1) = "N|NUM|18|2"
   Tablas(0, 46, 1) = "N|NUM|18|2"
   Tablas(0, 47, 1) = "N|NUM|18|2"
   Tablas(0, 48, 1) = "N|NUM|18|2"
   Tablas(0, 49, 1) = "N|INT|0|0"
   Tablas(0, 50, 1) = "S|32||"
   Tablas(0, 51, 1) = "S|64||"
   Tablas(0, 52, 1) = "N|INT|0|0"
   Tablas(0, 53, 1) = "S|8||"
   Tablas(0, 54, 1) = "S|8||"
   Tablas(0, 55, 1) = "S|8||"
   Tablas(0, 56, 1) = "S|8||"
   Tablas(0, 57, 1) = "N|NUM|18|2"
   Tablas(0, 58, 1) = "N|INT|0|0"
   Tablas(0, 59, 1) = "N|NUM|18|2"
   Tablas(0, 60, 1) = "S|13||"
   Tablas(0, 61, 1) = "N|NUM|18|2"
   Tablas(0, 62, 1) = "N|NUM|18|2"
   Tablas(0, 63, 1) = "N|NUM|18|2"
   Tablas(0, 64, 1) = "N|NUM|18|2"
   Tablas(0, 65, 1) = "N|NUM|18|2"
   Tablas(0, 66, 1) = "N|NUM|18|2"
   Tablas(0, 67, 1) = "N|NUM|18|2"
   Tablas(0, 68, 1) = "N|NUM|18|2"
   Tablas(0, 69, 1) = "N|NUM|18|2"
   Tablas(0, 70, 1) = "N|NUM|18|2"
   Tablas(0, 71, 1) = "N|NUM|18|2"
   Tablas(0, 72, 1) = "N|NUM|18|2"
   Tablas(0, 73, 1) = "N|NUM|18|2"
   Tablas(0, 74, 1) = "N|NUM|18|2"
   Tablas(0, 75, 1) = "N|NUM|18|2"
   Tablas(0, 76, 1) = "N|NUM|18|2"
   Tablas(0, 77, 1) = "N|NUM|18|2"
   Tablas(0, 78, 1) = "N|NUM|18|2"
   Tablas(0, 79, 1) = "N|NUM|18|2"
   Tablas(0, 80, 1) = "N|NUM|18|2"
   Tablas(0, 81, 1) = "N|NUM|18|2"
'   Tablas(0,82, 1) = "M|||"
'   Tablas(0,83, 1) = "N|INT|0|0"
'   Tablas(0,84, 1) = "M|||"
'   Tablas(0,85, 1) = "N|INT|0|0"
'   Tablas(0,86, 1) = "O|||"
'   Tablas(0,87, 1) = "N|INT|0|0"
'   Tablas(0,88, 1) = "O|||"
'   Tablas(0,89, 1) = "N|INT|0|0"

   
   'PROVEEDORES
   Tablas(1, 0, 0) = "sProveedor"
   Tablas(1, 1, 0) = "sInfo"
   Tablas(1, 2, 0) = "sTipo"
   Tablas(1, 3, 0) = "sNombre"
   Tablas(1, 4, 0) = "sContacto"
   Tablas(1, 5, 0) = "sDirección"
   Tablas(1, 6, 0) = "sCiudad"
   Tablas(1, 7, 0) = "sCPostal"
   Tablas(1, 8, 0) = "sProvincia"
   Tablas(1, 9, 0) = "sTeléfono"
   Tablas(1, 10, 0) = "sTeléfono2"
   Tablas(1, 11, 0) = "sFax"
   Tablas(1, 12, 0) = "sCorreo"
   Tablas(1, 13, 0) = "sNIF"
   Tablas(1, 14, 0) = "sNota"
   Tablas(1, 15, 0) = "sPagado"
   Tablas(1, 16, 0) = "sPagoPrev"
   Tablas(1, 17, 0) = "sPagoPte"
   Tablas(1, 18, 0) = "sPedido"
   Tablas(1, 19, 0) = "sContrato"
   Tablas(1, 20, 0) = "sEntregas"
   Tablas(1, 21, 0) = "sEntPrev"
   Tablas(1, 22, 0) = "sFacturado"
   Tablas(1, 23, 0) = "sFacPrev"
   Tablas(1, 24, 0) = "sRetGar"
   Tablas(1, 25, 0) = "sRetFis"
   Tablas(1, 26, 0) = "sIVA"
   Tablas(1, 27, 0) = "sSupTotal"
   Tablas(1, 28, 0) = "sFacClientes"

   Tablas(1, 0, 1) = "S|13||"
   Tablas(1, 1, 1) = "N|INT|0|0"
   Tablas(1, 2, 1) = "N|INT|0|0"
   Tablas(1, 3, 1) = "S|255||"
   Tablas(1, 4, 1) = "S|32||"
   Tablas(1, 5, 1) = "S|64||"
   Tablas(1, 6, 1) = "S|32||"
   Tablas(1, 7, 1) = "S|7||"
   Tablas(1, 8, 1) = "S|16||"
   Tablas(1, 9, 1) = "S|13||"
   Tablas(1, 10, 1) = "S|13||"
   Tablas(1, 11, 1) = "S|13||"
   Tablas(1, 12, 1) = "S|64||"
   Tablas(1, 13, 1) = "S|13||"
   Tablas(1, 14, 1) = "S|64||"
   Tablas(1, 15, 1) = "N|NUM|18|2"
   Tablas(1, 16, 1) = "N|NUM|18|2"
   Tablas(1, 17, 1) = "N|NUM|18|2"
   Tablas(1, 18, 1) = "N|NUM|18|2"
   Tablas(1, 19, 1) = "N|NUM|18|2"
   Tablas(1, 20, 1) = "N|NUM|18|2"
   Tablas(1, 21, 1) = "N|NUM|18|2"
   Tablas(1, 22, 1) = "N|NUM|18|2"
   Tablas(1, 23, 1) = "N|NUM|18|2"
   Tablas(1, 24, 1) = "N|NUM|18|2"
   Tablas(1, 25, 1) = "N|NUM|18|2"
   Tablas(1, 26, 1) = "N|NUM|18|2"
   Tablas(1, 27, 1) = "N|NUM|18|2"
   Tablas(1, 28, 1) = "N|NUM|18|2"
   
   
   'RELACIONES
   Tablas(2, 0, 0) = "rCodSup"
   Tablas(2, 1, 0) = "rCodInf"
   Tablas(2, 2, 0) = "rSección"
   Tablas(2, 3, 0) = "rInfo"
   Tablas(2, 4, 0) = "rFecIPlan"
   Tablas(2, 5, 0) = "rFecFPlan"
   Tablas(2, 6, 0) = "rFecIReal"
   Tablas(2, 7, 0) = "rFecFReal"
   Tablas(2, 8, 0) = "rTipoFecIPlan"
   Tablas(2, 9, 0) = "rTipoFecFPlan"
   Tablas(2, 10, 0) = "rRefPres"
   Tablas(2, 11, 0) = "rRefCert"
   Tablas(2, 12, 0) = "rRefReal"
   Tablas(2, 13, 0) = "rRefObj"
   Tablas(2, 14, 0) = "rRefPlan"
   Tablas(2, 15, 0) = "rFactor"
   Tablas(2, 16, 0) = "rCanPres"
   Tablas(2, 17, 0) = "rCanCert"
   Tablas(2, 18, 0) = "rCanReal"
   Tablas(2, 19, 0) = "rCanObj"
   Tablas(2, 20, 0) = "rCanPlan"
   Tablas(2, 21, 0) = "rTipoCanPres"
   Tablas(2, 22, 0) = "rTipoCanCert"
   Tablas(2, 23, 0) = "rTipoCanReal"
   Tablas(2, 24, 0) = "rTipoCanObj"
   Tablas(2, 25, 0) = "rTipoCanPlan"
   Tablas(2, 26, 0) = "rNuloCanPres"
   Tablas(2, 27, 0) = "rNuloCanCert"
   Tablas(2, 28, 0) = "rNuloCanReal"
   Tablas(2, 29, 0) = "rNuloCanObj"
   Tablas(2, 30, 0) = "rNuloCanPlan"
   Tablas(2, 31, 0) = "rDurTot"
   Tablas(2, 32, 0) = "rTipoDurTot"
   Tablas(2, 33, 0) = "rNota"
   Tablas(2, 34, 0) = "rEquipos"
   Tablas(2, 35, 0) = "rCalidad"
   
   Tablas(2, 0, 1) = "S|13||"
   Tablas(2, 1, 1) = "S|13||"
   Tablas(2, 2, 1) = "S|2||"
   Tablas(2, 3, 1) = "N|INT|0|0"
   Tablas(2, 4, 1) = "N|INT|0|0"
   Tablas(2, 5, 1) = "N|INT|0|0"
   Tablas(2, 6, 1) = "N|INT|0|0"
   Tablas(2, 7, 1) = "N|INT|0|0"
   Tablas(2, 8, 1) = "N|INT|0|0"
   Tablas(2, 9, 1) = "N|INT|0|0"
   Tablas(2, 10, 1) = "N|INT|0|0"
   Tablas(2, 11, 1) = "N|INT|0|0"
   Tablas(2, 12, 1) = "N|INT|0|0"
   Tablas(2, 13, 1) = "N|INT|0|0"
   Tablas(2, 14, 1) = "N|INT|0|0"
   Tablas(2, 15, 1) = "N|NUM|18|2"
   Tablas(2, 16, 1) = "N|NUM|18|2"
   Tablas(2, 17, 1) = "N|NUM|18|2"
   Tablas(2, 18, 1) = "N|NUM|18|2"
   Tablas(2, 19, 1) = "N|NUM|18|2"
   Tablas(2, 20, 1) = "N|NUM|18|2"
   Tablas(2, 21, 1) = "N|INT|0|0"
   Tablas(2, 22, 1) = "N|INT|0|0"
   Tablas(2, 23, 1) = "N|INT|0|0"
   Tablas(2, 24, 1) = "N|INT|0|0"
   Tablas(2, 25, 1) = "N|INT|0|0"
   Tablas(2, 26, 1) = "N|INT|0|0"
   Tablas(2, 27, 1) = "N|INT|0|0"
   Tablas(2, 28, 1) = "N|INT|0|0"
   Tablas(2, 29, 1) = "N|INT|0|0"
   Tablas(2, 30, 1) = "N|INT|0|0"
   Tablas(2, 31, 1) = "N|INT|0|0"
   Tablas(2, 32, 1) = "N|INT|0|0"
   Tablas(2, 33, 1) = "S|64||"
   Tablas(2, 34, 1) = "N|INT|0|0"
   Tablas(2, 35, 1) = "N|INT|0|0"
   
   
   'DOCUMENTOS
   Tablas(3, 0, 0) = "gFecha"
   Tablas(3, 1, 0) = "gDocumento"
   Tablas(3, 2, 0) = "gProveedor"
   Tablas(3, 3, 0) = "gInfo"
   Tablas(3, 4, 0) = "gTipo"
   Tablas(3, 5, 0) = "gDestinoDef"
   Tablas(3, 6, 0) = "gEmitido"
   Tablas(3, 7, 0) = "gPrevisional"
   Tablas(3, 8, 0) = "gExp"
   Tablas(3, 9, 0) = "gVencPag"
   Tablas(3, 10, 0) = "gBasePed"
   Tablas(3, 11, 0) = "gBaseEnt"
   Tablas(3, 12, 0) = "gBaseFac"
   Tablas(3, 13, 0) = "gBaseParte"
   Tablas(3, 14, 0) = "gCanProd"
   Tablas(3, 15, 0) = "gIVA"
   Tablas(3, 16, 0) = "gRetGar"
   Tablas(3, 17, 0) = "gRetFis"
   Tablas(3, 18, 0) = "gVencPte"
   Tablas(3, 19, 0) = "gNota"
   Tablas(3, 20, 0) = "gConProveedor"
   Tablas(3, 21, 0) = "gOrgContrato"
   Tablas(3, 22, 0) = "gBaseCon"
   Tablas(3, 23, 0) = "gBaseMed"
   Tablas(3, 24, 0) = "gBaseMin"
   Tablas(3, 25, 0) = "gBaseFacOrg"

   Tablas(3, 0, 1) = "N|INT|0|0"
   Tablas(3, 1, 1) = "S|13||"
   Tablas(3, 2, 1) = "S|13||"
   Tablas(3, 3, 1) = "N|INT|0|0"
   Tablas(3, 4, 1) = "N|INT|0|0"
   Tablas(3, 5, 1) = "S|13||"
   Tablas(3, 6, 1) = "N|INT|0|0"
   Tablas(3, 7, 1) = "N|INT|0|0"
   Tablas(3, 8, 1) = "N|INT|0|0"
   Tablas(3, 9, 1) = "N|NUM|18|2"
   Tablas(3, 10, 1) = "N|NUM|18|2"
   Tablas(3, 11, 1) = "N|NUM|18|2"
   Tablas(3, 12, 1) = "N|NUM|18|2"
   Tablas(3, 13, 1) = "N|NUM|18|2"
   Tablas(3, 14, 1) = "N|NUM|18|2"
   Tablas(3, 15, 1) = "N|NUM|18|2"
   Tablas(3, 16, 1) = "N|NUM|18|2"
   Tablas(3, 17, 1) = "N|NUM|18|2"
   Tablas(3, 18, 1) = "N|NUM|18|2"
   Tablas(3, 19, 1) = "S|300||"
   Tablas(3, 20, 1) = "S|13||"
   Tablas(3, 21, 1) = "S|13||"
   Tablas(3, 22, 1) = "N|NUM|18|2"
   Tablas(3, 23, 1) = "N|NUM|18|2"
   Tablas(3, 24, 1) = "N|NUM|18|2"
   Tablas(3, 25, 1) = "N|NUM|18|2"


   'SUMINISTROS
   Tablas(4, 0, 0) = "jFactura"
   Tablas(4, 1, 0) = "jProveedor"
   Tablas(4, 2, 0) = "jCódigo"
   Tablas(4, 3, 0) = "jPedido"
   Tablas(4, 4, 0) = "jEntrega"
   Tablas(4, 5, 0) = "jDestino"
   Tablas(4, 6, 0) = "jParte"
   Tablas(4, 7, 0) = "jObra"
   Tablas(4, 8, 0) = "jTrans"
   Tablas(4, 9, 0) = "jFecPrev"
   Tablas(4, 10, 0) = "jCantidad"
   Tablas(4, 11, 0) = "jRend"
   Tablas(4, 12, 0) = "jDto"
   Tablas(4, 13, 0) = "jPrecio"
   Tablas(4, 14, 0) = "jFecFinal"
   Tablas(4, 15, 0) = "jNota"

   Tablas(4, 0, 1) = "S|13||"
   Tablas(4, 1, 1) = "S|13||"
   Tablas(4, 2, 1) = "S|13||"
   Tablas(4, 3, 1) = "S|13||"
   Tablas(4, 4, 1) = "S|13||"
   Tablas(4, 5, 1) = "S|13||"
   Tablas(4, 6, 1) = "S|13||"
   Tablas(4, 7, 1) = "S|13||"
   Tablas(4, 8, 1) = "N|INT|0|0"
   Tablas(4, 9, 1) = "N|INT|0|0"
   Tablas(4, 10, 1) = "N|NUM|18|7"
   Tablas(4, 11, 1) = "N|NUM|18|2"
   Tablas(4, 12, 1) = "N|NUM|18|2"
   Tablas(4, 13, 1) = "N|NUM|18|2"
   Tablas(4, 14, 1) = "N|INT|0|0"
   Tablas(4, 15, 1) = "S|64||"

   If Not oF Is Nothing Then
      oF.Label1 = oF.Label1 & Tabla & " "
      DoEvents
   End If
   
   Dim oRsDat As ADOR.Recordset
   Dim i As Integer, j As Integer, k As Integer, X As Integer
   Dim mCampos
                           
   For j = 0 To UBound(Aprocesar, 1)
      
      If Tabla = Aprocesar(j, 0) Then
         
         mCampos = Val(Aprocesar(j, 1))
         
         Set oRsDat = CreateObject("ADOR.Recordset")
         With oRsDat
            For i = 0 To mCampos
               mVector = VBA.Split(Tablas(j, i, 1), "|")
               Select Case mVector(0)
                  Case "S"
                     .Fields.Append Tablas(j, i, 0), adVarChar, mVector(1)
                  Case "N"
                     If mVector(1) = "INT" Then
                        .Fields.Append Tablas(j, i, 0), adInteger
                     Else
                        .Fields.Append Tablas(j, i, 0), adNumeric
                        .Fields.Item(Tablas(j, i, 0)).Precision = mVector(2)
                        .Fields.Item(Tablas(j, i, 0)).NumericScale = mVector(3)
                     End If
                  Case "M"
                     .Fields.Append Tablas(j, i, 0), adVarChar, 1
                  Case "O"
                     .Fields.Append Tablas(j, i, 0), adVarChar, 1
               End Select
            Next
            .Open
         End With
      
         If oPresto.StepFirst(Tabla) = 0 Then
            i = 0
            Do
               i = i + 1
               If Not oF Is Nothing Then
                  oF.Label3 = "" & i
                  DoEvents
               End If
            Loop While oPresto.StepNext(Tabla) = 0
         End If
         
         If oPresto.StepFirst(Tabla) = 0 Then
            For X = 1 To i
               oRsDat.AddNew
               For k = 0 To mCampos
                  If oRsDat.Fields(k).Type = adInteger Or oRsDat.Fields(k).Type = adNumeric Then
                     oRsDat.Fields(k).Value = oPresto.GetNum(oRsDat.Fields(k).Name)
                  Else
                     oRsDat.Fields(k).Value = oPresto.GetStr(oRsDat.Fields(k).Name)
                  End If
               Next
               oRsDat.Update
               If Not oF Is Nothing Then
                  oF.Label3 = "" & X & " / " & i
                  DoEvents
               End If
               oPresto.StepNext (Tabla)
            Next
         End If
      
         If oRsDat.RecordCount > 0 Then oRsDat.MoveFirst
         
         Exit For
         
      End If
      
   Next

   Set CargarTablaPresto = oRsDat
   Set oRsDat = Nothing
   
End Function

Public Sub ProcesarDocumentos(ByVal oRsDoc As ADOR.Recordset, ByVal oRsSum As ADOR.Recordset, ByRef oPresto As PrestoApplication)

   Dim oRsPrestoDoc As ADOR.Recordset
   Dim oRsPrestoSum As ADOR.Recordset
   Dim Datos As ADOR.Recordset
   Dim mTipoDocumento As String
   Dim mExisteDocumento As Boolean
   
   With oRsDoc
      
      If .RecordCount > 0 Then
         .MoveFirst
         
         Set oRsPrestoDoc = CargarTablaPresto("Documentos", oPresto)
         Set oRsPrestoSum = CargarTablaPresto("Suministros", oPresto)
         
         Do While Not .EOF
         
            mTipoDocumento = TipoDocumento(.Fields("gTipo").Value, .Fields("gProveedor").Value, .Fields("gPrevisional").Value)
            If Len(mTipoDocumento) > 0 Then
            
               mExisteDocumento = ExisteDocumento(oRsPrestoDoc, mTipoDocumento, .Fields("gDocumento").Value, .Fields("gProveedor").Value)
               If Not mExisteDocumento Then
                  Select Case mTipoDocumento
                     Case "Contrato", "Asignacion", "Pedido"
                        AgregarSuministros oRsSum, mTipoDocumento, .Fields("gDocumento").Value, .Fields("gProveedor").Value, oPresto
                     Case "Entrega"
                        AgregarSuministros oRsSum, mTipoDocumento, .Fields("gDocumento").Value, .Fields("gProveedor").Value, oPresto
                     Case "Factura"
                        AgregarSuministros oRsSum, mTipoDocumento, .Fields("gDocumento").Value, .Fields("gProveedor").Value, oPresto
                  End Select
                  
                  Set Datos = CreateObject("ADOR.Recordset")
                  For i = 0 To .Fields.Count - 1
                     With .Fields(i)
                        Datos.Fields.Append .Name, .Type, .DefinedSize, .Attributes
                        Datos.Fields(.Name).Precision = .Precision
                        Datos.Fields(.Name).NumericScale = .NumericScale
                     End With
                  Next
                  Datos.Open
                  Datos.AddNew
                  For i = 0 To .Fields.Count - 1
                     With .Fields(i)
                        Datos.Fields(i).Value = .Value
                     End With
                  Next
                  Datos.Update
                  AgregarDocumento Datos, oPresto
                  Datos.Close
                  Set Datos = Nothing
               Else

                  Select Case mTipoDocumento
                     Case "Pedido"
                        ActualizarSuministrosPedidos oRsSum, oRsPrestoSum, .Fields("gDocumento").Value, .Fields("gProveedor").Value, oPresto
                     Case "Entrega"
                  
                     Case "Factura"
                  
                  End Select



               End If
               
            End If

            .MoveNext
         Loop
      
      End If
   
   End With

   Set oRsDoc = Nothing
   Set oRsSum = Nothing
   Set oRsPrestoDoc = Nothing
   Set oRsPrestoSum = Nothing
   
End Sub

Public Function TipoDocumento(ByVal Tipo As Integer, ByVal Proveedor As String, ByVal Previsional As Integer) As String
   
   Dim mDocumento As String
            
   mDocumento = ""
   If Tipo = 1 Then
      If Len(Trim(Proveedor)) = 0 Then
         mDocumento = "Contrato"
      ElseIf Previsional = 0 Then
         mDocumento = "Pedido"
      Else
         mDocumento = "Asignacion"
      End If
   ElseIf Tipo = 2 Then
      mDocumento = "Entrega"
   ElseIf Tipo = 3 Then
      mDocumento = "Factura"
   End If
   
   TipoDocumento = mDocumento

End Function

Public Function ExisteDocumento(ByVal oRsDoc As ADOR.Recordset, TipoDocumentoOrigen As String, NumeroDocumento As String, ByVal Proveedor As String) As Boolean

   Dim mExiste As Boolean
   
   mExiste = False
   
   With oRsDoc
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If TipoDocumento(.Fields("gTipo").Value, .Fields("gProveedor").Value, .Fields("gPrevisional").Value) = TipoDocumentoOrigen And _
               .Fields("gDocumento").Value = NumeroDocumento And _
               .Fields("gProveedor").Value = Proveedor Then
               mExiste = True
               Exit Do
            End If
            .MoveNext
         Loop
      End If
   End With
   
   Set oRsDoc = Nothing
   
   ExisteDocumento = mExiste

End Function

Public Sub AgregarDocumento(ByVal oRsDoc As ADOR.Recordset, ByRef oPresto As PrestoApplication)

   With oRsDoc
      oPresto.InitRecord "Documentos"
      For i = 0 To .Fields.Count - 1
         If .Fields(i).Type = adInteger Or .Fields(i).Type = adNumeric Then
            oPresto.SetNum .Fields(i).Name, .Fields(i).Value
         Else
            oPresto.SetStr .Fields(i).Name, .Fields(i).Value
         End If
      Next
      oPresto.InsertRecord "Documentos"
   End With
   
   Set oRsDoc = Nothing

End Sub

Public Sub AgregarSuministros(ByVal oRsSum As ADOR.Recordset, TipoDocumento As String, NumeroDocumento As String, Proveedor As String, ByRef oPresto As PrestoApplication)

   Dim i As Integer
   Dim mAgregar As Boolean
   
   With oRsSum
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            mAgregar = False
            Select Case TipoDocumento
               Case "Contrato", "Asignacion", "Pedido"
                  If .Fields("jPedido").Value = NumeroDocumento And _
                     .Fields("jProveedor").Value = Proveedor Then
                     mAgregar = True
                  End If
               Case "Entrega"
                  If .Fields("jEntrega").Value = NumeroDocumento And _
                     .Fields("jProveedor").Value = Proveedor And _
                     Len(Trim(.Fields("jPedido").Value)) = 0 Then
                     mAgregar = True
                  End If
               Case "Factura"
                  If .Fields("jFactura").Value = NumeroDocumento And _
                     .Fields("jProveedor").Value = Proveedor And _
                     Len(Trim(.Fields("jPedido").Value)) = 0 And _
                     Len(Trim(.Fields("jEntrega").Value)) = 0 Then
                     mAgregar = True
                  End If
            End Select
            If mAgregar Then
               oPresto.InitRecord "Suministros"
               For i = 0 To .Fields.Count - 1
                  If .Fields(i).Type = adInteger Or .Fields(i).Type = adNumeric Then
                     oPresto.SetNum .Fields(i).Name, .Fields(i).Value
                  Else
                     oPresto.SetStr .Fields(i).Name, .Fields(i).Value
                  End If
               Next
               oPresto.InsertRecord "Suministros"
            End If
            .MoveNext
         Loop
      End If
   End With

   Set oRsSum = Nothing

End Sub

Public Sub ActualizarSuministrosPedidos(ByVal oRsSum As ADOR.Recordset, ByVal oRsSumPresto As ADOR.Recordset, NumeroDocumento As String, Proveedor As String, ByRef oPresto As PrestoApplication)

   Dim i As Integer
   Dim DatosEnviados As ADOR.Recordset
   Dim DatosEnviadosOri As ADOR.Recordset
   Dim DatosPresto As ADOR.Recordset
   Dim DatosPrestoOri As ADOR.Recordset
   Dim RegistrosParaAgregar As ADOR.Recordset
   Dim mExiste As Boolean, mExiste1 As Boolean
   Dim mCantidadEnviada As Double, mCantidadPresto As Double
   Dim mCantidadEntregadaEnviada As Double, mCantidadEntregadaPresto As Double
   Dim mCantidadFacturadaEnviada As Double, mCantidadFacturadaPresto As Double
   Dim mRegistro As Integer, mRegistrosEnviados As Integer, mRegistrosPresto As Integer
   Dim mCodigo As String
   
   Set DatosEnviados = CreateObject("ADOR.Recordset")
   With oRsSum
      If .RecordCount > 0 Then
         .MoveFirst
         For i = 0 To .Fields.Count - 1
            With .Fields(i)
               DatosEnviados.Fields.Append .Name, .Type, .DefinedSize, .Attributes
               DatosEnviados.Fields(.Name).Precision = .Precision
               DatosEnviados.Fields(.Name).NumericScale = .NumericScale
            End With
         Next
         DatosEnviados.Open
         Do While Not .EOF
            If .Fields("jPedido").Value = NumeroDocumento And _
               .Fields("jProveedor").Value = Proveedor Then
               DatosEnviados.AddNew
               For i = 0 To .Fields.Count - 1
                  With .Fields(i)
                     DatosEnviados.Fields(i).Value = .Value
                  End With
               Next
               DatosEnviados.Update
            End If
            .MoveNext
         Loop
         If DatosEnviados.RecordCount > 0 Then
            DatosEnviados.Sort = "jCódigo"
            DatosEnviados.MoveFirst
         End If
      End If
   End With
   Set DatosEnviadosOri = DatosEnviados.Clone
   
   Set DatosPresto = CreateObject("ADOR.Recordset")
   With oRsSumPresto
      If .RecordCount > 0 Then
         .MoveFirst
         For i = 0 To .Fields.Count - 1
            With .Fields(i)
               DatosPresto.Fields.Append .Name, .Type, .DefinedSize, .Attributes
               DatosPresto.Fields(.Name).Precision = .Precision
               DatosPresto.Fields(.Name).NumericScale = .NumericScale
            End With
         Next
         DatosPresto.Fields.Append "Procesado", adVarChar, 1
         DatosPresto.Open
         Do While Not .EOF
            If .Fields("jPedido").Value = NumeroDocumento And _
               .Fields("jProveedor").Value = Proveedor Then
               DatosPresto.AddNew
               For i = 0 To .Fields.Count - 1
                  With .Fields(i)
                     DatosPresto.Fields(i).Value = .Value
                  End With
               Next
               DatosPresto.Fields("Procesado").Value = " "
               DatosPresto.Update
            End If
            .MoveNext
         Loop
         If DatosPresto.RecordCount > 0 Then
            DatosPresto.Sort = "jCódigo"
            DatosPresto.MoveFirst
         End If
      End If
   End With
   Set DatosPrestoOri = DatosPresto.Clone
   
   Set RegistrosParaAgregar = CreateObject("ADOR.Recordset")
   With oRsSumPresto
      For i = 0 To .Fields.Count - 1
         With .Fields(i)
            RegistrosParaAgregar.Fields.Append .Name, .Type, .DefinedSize, .Attributes
            RegistrosParaAgregar.Fields(.Name).Precision = .Precision
            RegistrosParaAgregar.Fields(.Name).NumericScale = .NumericScale
         End With
      Next
      RegistrosParaAgregar.Open
   End With
   
   With DatosEnviados
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               
               mCodigo = .Fields("jCódigo").Value
               
               mRegistrosEnviados = 0
               mCantidadEnviada = 0
               mCantidadEntregadaEnviada = 0
               mCantidadFacturadaEnviada = 0
               If DatosEnviadosOri.RecordCount > 0 Then
                  DatosEnviadosOri.MoveFirst
                  Do While Not DatosEnviadosOri.EOF
                     If mCodigo = DatosEnviadosOri.Fields("jCódigo").Value Then
                        mRegistrosEnviados = mRegistrosEnviados + 1
                        mCantidadEnviada = mCantidadEnviada + DatosEnviadosOri.Fields("jCantidad").Value
                        If Len(Trim(DatosEnviadosOri.Fields("jEntrega").Value)) > 0 Then
                           mCantidadEntregadaEnviada = mCantidadEntregadaEnviada + DatosEnviadosOri.Fields("jCantidad").Value
                        End If
                        If Len(Trim(DatosEnviadosOri.Fields("jFactura").Value)) > 0 Then
                           mCantidadFacturadaEnviada = mCantidadFacturadaEnviada + DatosEnviadosOri.Fields("jCantidad").Value
                        End If
                     End If
                     DatosEnviadosOri.MoveNext
                  Loop
               End If
               
               mRegistrosEnviados = 0
               mCantidadPresto = 0
               mCantidadEntregadaPresto = 0
               mCantidadFacturadaPresto = 0
               If DatosPrestoOri.RecordCount > 0 Then
                  DatosPrestoOri.MoveFirst
                  Do While Not DatosPrestoOri.EOF
                     If mCodigo = DatosPrestoOri.Fields("jCódigo").Value Then
                        mRegistrosPresto = mRegistrosPresto + 1
                        mCantidadPresto = mCantidadPresto + DatosPrestoOri.Fields("jCantidad").Value
                        If Len(Trim(DatosPrestoOri.Fields("jEntrega").Value)) > 0 Then
                           mCantidadEntregadaPresto = mCantidadEntregadaPresto + DatosPrestoOri.Fields("jCantidad").Value
                        End If
                        If Len(Trim(DatosPrestoOri.Fields("jFactura").Value)) > 0 Then
                           mCantidadFacturadaPresto = mCantidadFacturadaPresto + DatosPrestoOri.Fields("jCantidad").Value
                        End If
                     End If
                     DatosPrestoOri.MoveNext
                  Loop
               End If
               
               'Si los datos enviados traen nueva informacion se procesan
               If mCantidadEntregadaEnviada > mCantidadEntregadaPresto Or _
                  mCantidadFacturadaEnviada > mCantidadFacturadaPresto Then
               
                  mExiste = False
                  If DatosPresto.RecordCount > 0 Then
                     DatosPresto.MoveFirst
                     Do While Not DatosPresto.EOF
                        If .Fields("jCódigo").Value = DatosPresto.Fields("jCódigo").Value And _
                           .Fields("jEntrega").Value = DatosPresto.Fields("jEntrega").Value And _
                           .Fields("jFactura").Value = DatosPresto.Fields("jFactura").Value And _
                           .Fields("jCantidad").Value = DatosPresto.Fields("jCantidad").Value And _
                           DatosPresto.Fields("Procesado").Value = " " Then
                           DatosPresto.Fields("Procesado").Value = "P"
                           DatosPresto.Update
                           mExiste = True
                           Exit Do
                        End If
                        DatosPresto.MoveNext
                     Loop
                  End If
                  
                  If Not mExiste Then
                     
                     'Si es un item de pedido sin entregas ni facturas
                     If Len(Trim(.Fields("jEntrega").Value)) = 0 And _
                        Len(Trim(.Fields("jFactura").Value)) = 0 Then
                        mExiste1 = False
                        If DatosPresto.RecordCount > 0 Then
                           DatosPresto.MoveFirst
                           Do While Not DatosPresto.EOF
                              If .Fields("jCódigo").Value = DatosPresto.Fields("jCódigo").Value And _
                                 Len(Trim(DatosPresto.Fields("jEntrega").Value)) = 0 And _
                                 Len(Trim(DatosPresto.Fields("jFactura").Value)) = 0 And _
                                 DatosPresto.Fields("Procesado").Value = " " Then
                                 DatosPresto.Fields("Procesado").Value = "M"
                                 DatosPresto.Update
                                 
                                 RegistrosParaAgregar.AddNew
                                 For i = 0 To DatosPresto.Fields.Count - 2
                                    RegistrosParaAgregar.Fields(i).Value = DatosPresto.Fields(i).Value
                                 Next
                                 RegistrosParaAgregar.Fields("jCantidad").Value = .Fields("jCantidad").Value
                                 RegistrosParaAgregar.Update
                                 
                                 mExiste1 = True
                                 Exit Do
                              End If
                              DatosPresto.MoveNext
                           Loop
                        End If
                        If Not mExiste1 Then
                           RegistrosParaAgregar.AddNew
                           For i = 0 To .Fields.Count - 1
                              With .Fields(i)
                                 RegistrosParaAgregar.Fields(i).Value = .Value
                              End With
                           Next
                           RegistrosParaAgregar.Update
                        End If
                     
                     'Si es un item de pedido CON entregas y SIN facturas
                     ElseIf Len(Trim(.Fields("jEntrega").Value)) <> 0 And _
                        Len(Trim(.Fields("jFactura").Value)) = 0 Then
                        mExiste1 = False
                        If DatosPresto.RecordCount > 0 Then
                           DatosPresto.MoveFirst
                           Do While Not DatosPresto.EOF
                              If .Fields("jCódigo").Value = DatosPresto.Fields("jCódigo").Value And _
                                 .Fields("jEntrega").Value = DatosPresto.Fields("jEntrega").Value And _
                                 Len(Trim(DatosPresto.Fields("jFactura").Value)) = 0 And _
                                 DatosPresto.Fields("Procesado").Value = " " Then
                                 DatosPresto.Fields("Procesado").Value = "M"
                                 DatosPresto.Update
                                 
                                 RegistrosParaAgregar.AddNew
                                 For i = 0 To DatosPresto.Fields.Count - 2
                                    RegistrosParaAgregar.Fields(i).Value = DatosPresto.Fields(i).Value
                                 Next
                                 RegistrosParaAgregar.Fields("jCantidad").Value = .Fields("jCantidad").Value
                                 RegistrosParaAgregar.Update
                                 
                                 mExiste1 = True
                                 Exit Do
                              End If
                              DatosPresto.MoveNext
                           Loop
                        End If
                        If Not mExiste1 Then
                           mExiste1 = False
                           If DatosPresto.RecordCount > 0 Then
                              DatosPresto.MoveFirst
                              Do While Not DatosPresto.EOF
                                 If .Fields("jCódigo").Value = DatosPresto.Fields("jCódigo").Value And _
                                    Len(Trim(DatosPresto.Fields("jEntrega").Value)) = 0 And _
                                    .Fields("jFactura").Value = DatosPresto.Fields("jFactura").Value And _
                                    DatosPresto.Fields("Procesado").Value = " " Then
                                    DatosPresto.Fields("Procesado").Value = "M"
                                    DatosPresto.Update
                                 
                                    RegistrosParaAgregar.AddNew
                                    For i = 0 To DatosPresto.Fields.Count - 2
                                       RegistrosParaAgregar.Fields(i).Value = DatosPresto.Fields(i).Value
                                    Next
                                    RegistrosParaAgregar.Fields("jEntrega").Value = .Fields("jEntrega").Value
                                    RegistrosParaAgregar.Fields("jCantidad").Value = .Fields("jCantidad").Value
                                    RegistrosParaAgregar.Update
                                 
                                    mExiste1 = True
                                    Exit Do
                                 End If
                                 DatosPresto.MoveNext
                              Loop
                           End If
                           If Not mExiste1 Then
                              RegistrosParaAgregar.AddNew
                              For i = 0 To .Fields.Count - 1
                                 With .Fields(i)
                                    RegistrosParaAgregar.Fields(i).Value = .Value
                                 End With
                              Next
                              RegistrosParaAgregar.Update
                           End If
                        End If
                     
                     'Si es un item de pedido CON entregas y CON facturas
                     ElseIf Len(Trim(.Fields("jEntrega").Value)) <> 0 And _
                            Len(Trim(.Fields("jFactura").Value)) <> 0 Then
                        mExiste1 = False
                        If DatosPresto.RecordCount > 0 Then
                           DatosPresto.MoveFirst
                           Do While Not DatosPresto.EOF
                              If .Fields("jCódigo").Value = DatosPresto.Fields("jCódigo").Value And _
                                 .Fields("jEntrega").Value = DatosPresto.Fields("jEntrega").Value And _
                                 .Fields("jFactura").Value = DatosPresto.Fields("jFactura").Value And _
                                 DatosPresto.Fields("Procesado").Value = " " Then
                                 DatosPresto.Fields("Procesado").Value = "M"
                                 DatosPresto.Update
                                 
                                 RegistrosParaAgregar.AddNew
                                 For i = 0 To DatosPresto.Fields.Count - 2
                                    RegistrosParaAgregar.Fields(i).Value = DatosPresto.Fields(i).Value
                                 Next
                                 RegistrosParaAgregar.Fields("jCantidad").Value = .Fields("jCantidad").Value
                                 RegistrosParaAgregar.Update
                                 
                                 mExiste1 = True
                                 Exit Do
                              End If
                              DatosPresto.MoveNext
                           Loop
                        End If
                        If Not mExiste1 Then
                           mExiste1 = False
                           If DatosPresto.RecordCount > 0 Then
                              DatosPresto.MoveFirst
                              Do While Not DatosPresto.EOF
                                 If .Fields("jCódigo").Value = DatosPresto.Fields("jCódigo").Value And _
                                    .Fields("jEntrega").Value = DatosPresto.Fields("jEntrega").Value And _
                                    Len(Trim(DatosPresto.Fields("jFactura").Value)) = 0 And _
                                    DatosPresto.Fields("Procesado").Value = " " Then
                                    DatosPresto.Fields("Procesado").Value = "M"
                                    DatosPresto.Update
                                 
                                    RegistrosParaAgregar.AddNew
                                    For i = 0 To DatosPresto.Fields.Count - 2
                                       RegistrosParaAgregar.Fields(i).Value = DatosPresto.Fields(i).Value
                                    Next
                                    RegistrosParaAgregar.Fields("jFactura").Value = .Fields("jFactura").Value
                                    RegistrosParaAgregar.Fields("jCantidad").Value = .Fields("jCantidad").Value
                                    RegistrosParaAgregar.Update
                                 
                                    mExiste1 = True
                                    Exit Do
                                 End If
                                 DatosPresto.MoveNext
                              Loop
                           End If
                           If Not mExiste1 Then
                              RegistrosParaAgregar.AddNew
                              For i = 0 To .Fields.Count - 1
                                 With .Fields(i)
                                    RegistrosParaAgregar.Fields(i).Value = .Value
                                 End With
                              Next
                              RegistrosParaAgregar.Update
                           End If
                        End If
                     
                     End If
                        
                  End If
               
               Else
               
                  'Si no hay informacion nueva para el concepto, marco todos como
                  'procesados para que no se modifiquen.
                  If DatosPresto.RecordCount > 0 Then
                     DatosPresto.MoveFirst
                     Do While Not DatosPresto.EOF
                        If .Fields("jCódigo").Value = DatosPresto.Fields("jCódigo").Value And _
                           DatosPresto.Fields("Procesado").Value = " " Then
                           DatosPresto.Fields("Procesado").Value = "P"
                           DatosPresto.Update
                           Exit Do
                        End If
                        DatosPresto.MoveNext
                     Loop
                  End If
               
               End If
               
               .MoveNext
            Loop
         End If
      End If
   End With

   If DatosPresto.RecordCount > 0 Then
      DatosPresto.MoveFirst
      Do While Not DatosPresto.EOF
         If DatosPresto.Fields("Procesado").Value = "M" Then
            If oPresto.StepFirst("Suministros") = 0 Then
               Do
                  If oPresto.GetStr("jPedido") = NumeroDocumento And _
                     oPresto.GetStr("jProveedor") = Proveedor And _
                     oPresto.GetStr("jCódigo") = DatosPresto.Fields("jCódigo").Value And _
                     oPresto.GetStr("jEntrega") = DatosPresto.Fields("jEntrega").Value And _
                     oPresto.GetStr("jFactura") = DatosPresto.Fields("jFactura").Value Then
                     oPresto.DeleteRecord ("Suministros")
                  End If
               Loop While oPresto.StepNext("Suministros") = 0
            End If
         End If
         DatosPresto.MoveNext
      Loop
   End If
   
   If RegistrosParaAgregar.RecordCount > 0 Then
      RegistrosParaAgregar.MoveFirst
      Do While Not RegistrosParaAgregar.EOF
         oPresto.InitRecord "Suministros"
         For i = 0 To RegistrosParaAgregar.Fields.Count - 1
            If RegistrosParaAgregar.Fields(i).Type = adInteger Or RegistrosParaAgregar.Fields(i).Type = adNumeric Then
               oPresto.SetNum RegistrosParaAgregar.Fields(i).Name, RegistrosParaAgregar.Fields(i).Value
            Else
               oPresto.SetStr RegistrosParaAgregar.Fields(i).Name, RegistrosParaAgregar.Fields(i).Value
            End If
         Next
         oPresto.InsertRecord "Suministros"
         RegistrosParaAgregar.MoveNext
      Loop
   End If
         
   DatosEnviados.Close
   DatosEnviadosOri.Close
   DatosPresto.Close
   DatosPrestoOri.Close
   RegistrosParaAgregar.Close
   
   Set DatosEnviados = Nothing
   Set DatosPresto = Nothing
   Set DatosEnviadosOri = Nothing
   Set DatosPrestoOri = Nothing
   Set RegistrosParaAgregar = Nothing
   Set oRsSum = Nothing
   Set oRsSumPresto = Nothing

End Sub

Public Sub AgregarMensajeProcesoPresto(ByRef oRsErrores As ADOR.Recordset, ByVal Mensaje As String)

   oRsErrores.AddNew
   oRsErrores.Fields(0).Value = 0
   oRsErrores.Fields(1).Value = Mensaje
   oRsErrores.Update

End Sub

Public Function LeerPresto() As ADOR.Recordset

   Dim oAp As ComPronto.Aplicacion
   Dim oPr As ComPronto.Proveedor
   Dim oCP As ComPronto.ComprobanteProveedor
   Dim oCl As ComPronto.Cliente
   Dim oRq As ComPronto.Requerimiento
   Dim oPar As ComPronto.Parametro
   Dim oPresto As PrestoApplication
   Dim mCodigoProveedor As String, mPathObra As String, mCuit As String
   Dim mConfirmado As String, mFactura As String, mObra As String, mMensaje As String
   Dim mContrato As String, mPedido As String, mConcepto As String
   Dim mCodigo As String, s As String, mProveedor As String
   Dim mOk As Boolean, mGrabar As Boolean, mExiste As Boolean
   Dim i As Integer, mIdMonedaPesos As Integer, mIdObra As Integer
   Dim mIdTipoComprobanteFacturaCompra As Integer, mItem As Integer
   Dim mContador As Integer, mProcesados As Integer, mDocumentos As Integer
   Dim mNoProcesadosConError As Integer, mNoProcesadosYaExistentes As Integer
   Dim mIdProveedor As Long, mIdCuentaGasto As Long, mIdCuenta As Long
   Dim mCodigoCuenta As Long, mCodigo2 As Long, mIdCuentaIvaCompras1 As Long
   Dim mIdArticulo As Long, mIdUnidadPorUnidad As Long, mIdArticuloVarios As Long
   Dim mNumeroRequerimiento As Long
   Dim mIdCuentaIvaCompras(10) As Long
   Dim mvarCotizacionDolar As Double, mImporte As Double, mBaseFactura As Double
   Dim mIVA As Double, mTotal As Double, mPrecio As Double, mCantidad As Double
   Dim mImportePedido As Double, mvarCotizacionEuro As Double
   Dim mIVAComprasPorcentaje1 As Single, mPorcentajeIVA As Single
   Dim mIVAComprasPorcentaje(10) As Single
   Dim mFechaFactura As Date, mFechaContrato As Date, mFecha As Date
   Dim mFechaEntrega As Date
   Dim oRs As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim oRsErrores As ADOR.Recordset
   Dim oF As Form

'   On Error GoTo Mal

   Set oRsErrores = CreateObject("ADOR.Recordset")
   With oRsErrores
      .Fields.Append "Id", adInteger
      .Fields.Append "Detalle", adVarChar, 200
   End With
   oRsErrores.Open
   
   Set oF = New frmPathPresto
   With oF
      .Id = 1
      .Show vbModal
      mOk = .Ok
      mPathObra = .FileBrowser1(0).Text
   End With
   Unload oF
   Set oF = Nothing

   If Not mOk Then Exit Function

   Set oAp = Aplicacion

   Set oRs = oAp.Parametros.Item(1).Registro
   mIdMonedaPesos = oRs.Fields("IdMoneda").Value
   mIdTipoComprobanteFacturaCompra = oRs.Fields("IdTipoComprobanteFacturaCompra").Value
   mIdUnidadPorUnidad = oRs.Fields("IdUnidadPorUnidad").Value
   If IsNull(oRs.Fields("IdArticuloVariosParaPRESTO").Value) Then
      oRs.Close
      MsgBox "Debe definir en parametros el item material varios para PRESTO!", vbExclamation
      GoTo Salida
   End If
   mIdArticuloVarios = oRs.Fields("IdArticuloVariosParaPRESTO").Value
   For i = 1 To 10
      If Not IsNull(oRs.Fields("IdCuentaIvaCompras" & i).Value) Then
         mIdCuentaIvaCompras(i) = oRs.Fields("IdCuentaIvaCompras" & i).Value
         mIVAComprasPorcentaje(i) = oRs.Fields("IVAComprasPorcentaje" & i).Value
      Else
         mIdCuentaIvaCompras(i) = 0
         mIVAComprasPorcentaje(i) = 0
      End If
   Next
   oRs.Close
   
   Set oPresto = CreateObject("Presto.Application")
   oPresto.Open (mPathObra)
   
   Set oF = New frmAviso
   With oF
      .Label1 = "Iniciando PRESTO ..."
'      .Height = .Height * 2
      .Show
      .Refresh
      DoEvents
   End With

   Sleep 5000
   DoEvents

   
   'BAJAR PROVEEDORES DE PRESTO A PRONTO
   s = oF.Label1.Caption & vbCrLf
   oF.Label1 = oF.Label1 & vbCrLf & "Procesando proveedores ..."
   DoEvents
   
   mContador = 0
   If oPresto.StepFirst("Proveedores") = 0 Then
      Do
         If oPresto.GetNum("sTipo") = 0 Then
            mContador = mContador + 1
            oF.Label1 = s & "Procesando proveedores ... " & mContador
            oF.Label2 = "Proveedor : " & mId(oPresto.GetStr("sNombre"), 1, 50)
            oF.Label3 = "" & mContador
            DoEvents
            mCuit = Trim(oPresto.GetStr("sNIF"))
            If Len(mCuit) > 0 Then
               Set oRs = oAp.Proveedores.TraerFiltrado("_PorCuitNoEventual", mCuit)
               If oRs.RecordCount > 0 Then
                  Set oPr = oAp.Proveedores.Item(oRs.Fields(0).Value)
                  mConfirmado = IIf(IsNull(oRs.Fields("Confirmado").Value), "SI", oRs.Fields("Confirmado").Value)
                  With oPr.Registro
                     .Fields("Confirmado").Value = mConfirmado
                  End With
               Else
                  Set oPr = oAp.Proveedores.Item(-1)
                  mConfirmado = "NO"
                  With oPr.Registro
                     .Fields("Confirmado").Value = mConfirmado
                     .Fields("CodigoPresto").Value = oPresto.GetStr("sProveedor")
                     .Fields("RazonSocial").Value = mId(oPresto.GetStr("sNombre"), 1, 50)
                     If Len(oPresto.GetStr("sDirección")) > 0 Then
                        .Fields("Direccion").Value = mId(Trim(oPresto.GetStr("sDirección")) & " " & Trim(oPresto.GetStr("sCiudad")) & " " & Trim(oPresto.GetStr("sProvincia")), 1, 50)
                     End If
                     If Len(oPresto.GetStr("sCPostal")) > 0 Then
                        .Fields("CodigoPostal").Value = oPresto.GetStr("sCPostal")
                     End If
                     .Fields("CUIT").Value = mCuit
                     If Len(oPresto.GetStr("sTeléfono")) > 0 Then
                        .Fields("Telefono1").Value = oPresto.GetStr("sTeléfono")
                     End If
                     If Len(oPresto.GetStr("sCorreo")) > 0 Then
                        .Fields("Email").Value = mId(oPresto.GetStr("sCorreo"), 1, 50)
                     End If
                     .Fields("EnviarEmail").Value = 1
                  End With
               End If
               oRs.Close
               oPr.Guardar
               Set oPr = Nothing
            End If
         End If
      Loop While oPresto.StepNext("Proveedores") = 0
   End If
      
   
   'BAJAR CLIENTES DE PRESTO A PRONTO
   s = oF.Label1.Caption & vbCrLf
   oF.Label1 = oF.Label1 & vbCrLf & "Procesando clientes ..."
   oF.Label2 = ""
   oF.Label3 = ""
   DoEvents

   mContador = 0
   If oPresto.StepFirst("Proveedores") = 0 Then
      Do
         If oPresto.GetNum("sTipo") = 1 Then
            mContador = mContador + 1
            oF.Label1 = s & "Procesando clientes ... " & mContador
            oF.Label2 = "Cliente : " & mId(oPresto.GetStr("sNombre"), 1, 50)
            oF.Label3 = "" & mContador
            DoEvents
            mCuit = Trim(oPresto.GetStr("sNIF"))
            If Len(mCuit) > 0 Then
               Set oRs = oAp.Clientes.TraerFiltrado("_PorCuit", mCuit)
               If oRs.RecordCount > 0 Then
                  Set oCl = oAp.Clientes.Item(oRs.Fields(0).Value)
                  mConfirmado = IIf(IsNull(oRs.Fields("Confirmado").Value), "SI", oRs.Fields("Confirmado").Value)
                  With oCl.Registro
                     .Fields("Confirmado").Value = mConfirmado
                  End With
               Else
                  Set oCl = oAp.Clientes.Item(-1)
                  mConfirmado = "NO"
                  With oCl.Registro
                     .Fields("Confirmado").Value = mConfirmado
                     .Fields("CodigoPresto").Value = oPresto.GetStr("sProveedor")
                     .Fields("RazonSocial").Value = mId(oPresto.GetStr("sNombre"), 1, 50)
                     If Len(oPresto.GetStr("sDirección")) > 0 Then
                        .Fields("Direccion").Value = mId(Trim(oPresto.GetStr("sDirección")) & " " & Trim(oPresto.GetStr("sCiudad")) & " " & Trim(oPresto.GetStr("sProvincia")), 1, 50)
                     End If
                     If Len(oPresto.GetStr("sCPostal")) > 0 Then
                        .Fields("CodigoPostal").Value = oPresto.GetStr("sCPostal")
                     End If
                     .Fields("CUIT").Value = mCuit
                     If Len(oPresto.GetStr("sTeléfono")) > 0 Then
                        .Fields("Telefono").Value = oPresto.GetStr("sTeléfono")
                     End If
                     If Len(oPresto.GetStr("sCorreo")) > 0 Then
                        .Fields("Email").Value = mId(oPresto.GetStr("sCorreo"), 1, 30)
                     End If
                  End With
               End If
               oRs.Close
               oCl.Guardar
               Set oCl = Nothing
            End If
         End If
      Loop While oPresto.StepNext("Proveedores") = 0
   End If
   
   
   'BAJAR FACTURAS DE PRESTO A PRONTO
   s = oF.Label1.Caption & vbCrLf
   oF.Label1 = oF.Label1 & vbCrLf & "Procesando facturas ..."
   oF.Label2 = ""
   oF.Label3 = ""
   DoEvents

   AgregarMensajeProcesoPresto oRsErrores, "IMPORTACION DE FACTURAS DE COMPRA " & _
                                             "DESDE PRESTO HACIA PRONTO [" & Now & "]"
   
   mContador = 0
   mDocumentos = 0
   mProcesados = 0
   mNoProcesadosConError = 0
   mNoProcesadosYaExistentes = 0

   oPresto.SetElement 1, "Documentos", , , "gExp==0 && gTipo==3"
   While (oPresto.GetElement(1) = 0)
      
      mGrabar = True
      mFactura = oPresto.GetStr("gDocumento")
      mCodigoProveedor = oPresto.GetStr("gProveedor")
      mContador = mContador + 1
      mDocumentos = mDocumentos + 1
      oF.Label1 = s & "Procesando facturas ... " & mContador
      oF.Label2 = "Factura : " & mFactura
      oF.Label3 = "" & mContador
      DoEvents
      
      Set oRs = oAp.ComprobantesProveedores.TraerFiltrado("_PorPRESTOFactura", Array(mFactura, mCodigoProveedor))
      If oRs.RecordCount > 0 Then
         mNoProcesadosYaExistentes = mNoProcesadosYaExistentes + 1
         oPresto.SetNum ("gExp"), 49
         oPresto.UpdateRecord ("Documentos")
      Else
         mIdProveedor = 0
         mProveedor = ""
         Set oRsAux = oAp.Proveedores.TraerFiltrado("_PorCodigoPresto", mCodigoProveedor)
         If oRsAux.RecordCount > 0 Then
            mIdProveedor = oRsAux.Fields(0).Value
            mProveedor = oRsAux.Fields("RazonSocial").Value
         End If
         oRsAux.Close
         If Len(Trim(mFactura)) = 0 Or _
               ((mId(mFactura, 1, 1) <> "A" And mId(mFactura, 1, 1) <> "B" And _
                 mId(mFactura, 1, 1) <> "C" And mId(mFactura, 1, 1) <> "E") And _
               Not IsNumeric(mId(mFactura, 2, 4)) And Not IsNumeric(mId(mFactura, 6, 8))) Then
            AgregarMensajeProcesoPresto oRsErrores, "Hay una factura del proveedor " & _
               mProveedor & " " & vbCrLf & "numero " & mFactura & " no tiene un formato valido, " & _
               "toda la factura fue rechazada."
            mGrabar = False
         End If
         If mIdProveedor = 0 Then
            AgregarMensajeProcesoPresto oRsErrores, "La factura Presto " & mFactura & " es de un proveedor inexistente " & _
               "en PRONTO, el codigo de PRESTO es " & mCodigoProveedor & ", toda la factura fue rechazada."
            mGrabar = False
         Else
            mFechaFactura = DateAdd("yyyy", 80, CDate(oPresto.GetNum("gFecha")))
            mvarCotizacionDolar = Cotizacion(mFechaFactura, glbIdMonedaDolar)
            mvarCotizacionEuro = Cotizacion(mFechaFactura, glbIdMonedaEuro)
            mBaseFactura = oPresto.GetNum("gBaseFac")
            mPorcentajeIVA = oPresto.GetNum("gIVA")
            mIVA = Round(mBaseFactura * mPorcentajeIVA / 100, 4)
            mTotal = mBaseFactura + mIVA
            mIdCuentaIvaCompras1 = 0
            mIVAComprasPorcentaje1 = 0
            If mPorcentajeIVA <> 0 Then
               For i = 1 To 10
                  If mIVAComprasPorcentaje(i) = mPorcentajeIVA Then
                     mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(i)
                     mIVAComprasPorcentaje1 = mIVAComprasPorcentaje(i)
                     Exit For
                  End If
               Next
            End If
            If mIVA <> 0 And mIdCuentaIvaCompras1 = 0 Then
               AgregarMensajeProcesoPresto oRsErrores, "La factura Presto " & mFactura & _
                  ", tiene un porcentaje de iva igual a " & mPorcentajeIVA & " que no " & _
                  "tiene en los parametros de Pronto una cuenta contable asignada, " & _
                  "toda la factura fue rechazada."
               mGrabar = False
            End If
            Set oCP = oAp.ComprobantesProveedores.Item(-1)
            With oCP
               With .Registro
                  .Fields("Confirmado").Value = "NO"
                  .Fields("PRESTOFactura").Value = mFactura
                  .Fields("PRESTOProveedor").Value = mCodigoProveedor
                  .Fields("IdTipoComprobante").Value = mIdTipoComprobanteFacturaCompra
                  .Fields("FechaComprobante").Value = mFechaFactura
                  .Fields("FechaRecepcion").Value = Date
                  .Fields("FechaVencimiento").Value = mFechaFactura
                  .Fields("TotalBruto").Value = mBaseFactura
                  .Fields("TotalIva1").Value = mIVA
                  .Fields("TotalIva2").Value = 0
                  .Fields("TotalBonificacion").Value = 0
                  .Fields("TotalComprobante").Value = mTotal
                  .Fields("PorcentajeBonificacion").Value = 0
                  .Fields("TotalIVANoDiscriminado").Value = 0
                  .Fields("AjusteIVA").Value = 0
                  .Fields("IdMoneda").Value = mIdMonedaPesos
                  .Fields("CotizacionMoneda").Value = 1
                  .Fields("CotizacionDolar").Value = mvarCotizacionDolar
                  .Fields("CotizacionEuro").Value = mvarCotizacionEuro
                  .Fields("IdProveedor").Value = mIdProveedor
                  If mId(mFactura, 1, 1) = "A" Or mId(mFactura, 1, 1) = "B" Or _
                     mId(mFactura, 1, 1) = "C" Or mId(mFactura, 1, 1) = "E" Then
                     .Fields("Letra").Value = mId(mFactura, 1, 1)
                  End If
                  If IsNumeric(mId(mFactura, 2, 4)) Then
                     .Fields("NumeroComprobante1").Value = Val(mId(mFactura, 2, 4))
                  End If
                  If IsNumeric(mId(mFactura, 6, 8)) Then
                     .Fields("NumeroComprobante2").Value = Val(mId(mFactura, 6, 8))
                  End If
               End With
            End With
      
            oPresto.SetElement 2, "Suministros", , , "jFactura==" & Chr(34) & mFactura & Chr(34) & _
                                                      " && jProveedor==" & Chr(34) & mCodigoProveedor & Chr(34)
            While (oPresto.GetElement(2) = 0)
         
               mIdCuenta = 0
               mCodigoCuenta = 0
               mIdCuentaGasto = 0
               
               oPresto.SetElement 3, "Conceptos", , , "cCódigo==" & Chr(34) & oPresto.GetStr("jCódigo") & Chr(34)
               If oPresto.GetElement(3) = 0 Then
                  If Len(Trim(oPresto.GetStr("cCódigo2"))) > 0 And _
                        IsNumeric(Trim(oPresto.GetStr("cCódigo2"))) Then
                     mCodigo2 = Val(Trim(oPresto.GetStr("cCódigo2")))
                     If mCodigo2 > 1000 Then
                        Set oRsAux = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigo2)
                        If oRsAux.RecordCount > 0 Then
                           mIdCuenta = oRsAux.Fields(0).Value
                           mCodigoCuenta = mCodigo2
                        End If
                     Else
                        Set oRsAux = oAp.CuentasGastos.TraerFiltrado("_PorId", mCodigo2)
                        If oRsAux.RecordCount > 0 Then
                           mIdCuentaGasto = oRsAux.Fields(0).Value
                        End If
                     End If
                     oRsAux.Close
                  End If
               End If
               If mIdCuentaGasto = 0 And mIdCuenta = 0 Then
                  AgregarMensajeProcesoPresto oRsErrores, "La factura Presto " & mFactura & " tiene el item con codigo " & _
                     oPresto.GetStr("jCódigo") & " sin la cuenta de gasto en codigo2 o una cuenta invalida, " & _
                     "toda la factura fue rechazada."
                  mGrabar = False
                  GoTo SalidaComprobante
               End If
               
               mObra = Trim(oPresto.GetStr("jObra"))
               mIdObra = 0
               Set oRsAux = oAp.Obras.TraerFiltrado("_PorNumero", mObra)
               If oRsAux.RecordCount > 0 Then
                  mIdObra = oRsAux.Fields(0).Value
               End If
               oRsAux.Close
               If mIdObra = 0 And mIdCuenta = 0 Then
                  AgregarMensajeProcesoPresto oRsErrores, "La factura Presto " & mFactura & " tiene el item con codigo " & _
                     oPresto.GetStr("jCódigo") & " sin obra o con una obra invalida, toda la factura fue rechazada."
                  mGrabar = False
                  GoTo SalidaComprobante
               End If
                                 
               If mIdCuenta = 0 Then
                  Set oRsAux = oAp.Cuentas.TraerFiltrado("_PorObraCuentaGasto", Array(mIdObra, mIdCuentaGasto))
                  If oRsAux.RecordCount > 0 Then
                     mIdCuenta = oRsAux.Fields(0).Value
                     mCodigoCuenta = oRsAux.Fields("Codigo").Value
                  End If
                  oRsAux.Close
                  If mIdCuentaGasto = 0 Then
                     AgregarMensajeProcesoPresto oRsErrores, "La factura Presto " & mFactura & " tiene el item con codigo " & _
                        oPresto.GetStr("jCódigo") & " para el que no se encontro la cuenta contable, " & _
                        "IdObra " & mIdObra & ", IdCuentaGasto " & mIdCuentaGasto & ", toda la factura fue rechazada."
                     mGrabar = False
                     GoTo SalidaComprobante
                  End If
               End If
               
               mImporte = oPresto.GetNum("jCantidad") * oPresto.GetNum("jPrecio")
               If oPresto.GetNum("jDto") <> 0 Then
                  mImporte = mImporte - (mImporte * oPresto.GetNum("jDto") / 100)
               End If
                                 
               With oCP.DetComprobantesProveedores.Item(-1)
                  With .Registro
                     .Fields("PRESTOConcepto").Value = oPresto.GetStr("jCódigo")
                     .Fields("PRESTOObra").Value = mObra
                     .Fields("IdObra").Value = mIdObra
                     .Fields("IdCuentaGasto").Value = mIdCuentaGasto
                     .Fields("IdCuenta").Value = mIdCuenta
                     .Fields("CodigoCuenta").Value = mCodigoCuenta
                     .Fields("Importe").Value = mImporte
                     If mIdCuentaIvaCompras1 <> 0 Then
                        .Fields("IdCuentaIvaCompras1").Value = mIdCuentaIvaCompras1
                        .Fields("IVAComprasPorcentaje1").Value = mIVAComprasPorcentaje1
                        .Fields("ImporteIVA1").Value = Round(mImporte * mIVAComprasPorcentaje1 / 100, 2)
                        .Fields("AplicarIVA1").Value = "SI"
                     Else
                        .Fields("IdCuentaIvaCompras1").Value = Null
                        .Fields("IVAComprasPorcentaje1").Value = 0
                        .Fields("ImporteIVA1").Value = 0
                        .Fields("AplicarIVA1").Value = "NO"
                     End If
                     .Fields("IdCuentaIvaCompras2").Value = Null
                     .Fields("IVAComprasPorcentaje2").Value = 0
                     .Fields("ImporteIVA2").Value = 0
                     .Fields("AplicarIVA2").Value = "NO"
                     .Fields("IdCuentaIvaCompras3").Value = Null
                     .Fields("IVAComprasPorcentaje3").Value = 0
                     .Fields("ImporteIVA3").Value = 0
                     .Fields("AplicarIVA3").Value = "NO"
                     .Fields("IdCuentaIvaCompras4").Value = Null
                     .Fields("IVAComprasPorcentaje4").Value = 0
                     .Fields("ImporteIVA4").Value = 0
                     .Fields("AplicarIVA4").Value = "NO"
                     .Fields("IdCuentaIvaCompras5").Value = Null
                     .Fields("IVAComprasPorcentaje5").Value = 0
                     .Fields("ImporteIVA5").Value = 0
                     .Fields("AplicarIVA5").Value = "NO"
                     .Fields("IdCuentaIvaCompras6").Value = Null
                     .Fields("IVAComprasPorcentaje6").Value = 0
                     .Fields("ImporteIVA6").Value = 0
                     .Fields("AplicarIVA6").Value = "NO"
                     .Fields("IdCuentaIvaCompras7").Value = Null
                     .Fields("IVAComprasPorcentaje7").Value = 0
                     .Fields("ImporteIVA7").Value = 0
                     .Fields("AplicarIVA7").Value = "NO"
                     .Fields("IdCuentaIvaCompras8").Value = Null
                     .Fields("IVAComprasPorcentaje8").Value = 0
                     .Fields("ImporteIVA8").Value = 0
                     .Fields("AplicarIVA8").Value = "NO"
                     .Fields("IdCuentaIvaCompras9").Value = Null
                     .Fields("IVAComprasPorcentaje9").Value = 0
                     .Fields("ImporteIVA9").Value = 0
                     .Fields("AplicarIVA9").Value = "NO"
                     .Fields("IdCuentaIvaCompras10").Value = Null
                     .Fields("IVAComprasPorcentaje10").Value = 0
                     .Fields("ImporteIVA10").Value = 0
                     .Fields("AplicarIVA10").Value = "NO"
                  End With
                  .Modificado = True
               End With
            
            Wend
            
         End If
         
SalidaComprobante:
         If mGrabar Then
            oCP.Guardar
            mProcesados = mProcesados + 1
            oPresto.SetNum ("gExp"), 49
         Else
            oPresto.SetNum ("gExp"), 0
            mNoProcesadosConError = mNoProcesadosConError + 1
         End If
         oPresto.UpdateRecord ("Documentos")
         Set oCP = Nothing
         
      End If
      oRs.Close
         
   Wend
   
   AgregarMensajeProcesoPresto oRsErrores, "Informe proceso importacion de facturas de compra desde Presto hacia Pronto : "
   AgregarMensajeProcesoPresto oRsErrores, "Documentos importados : " & mProcesados
   AgregarMensajeProcesoPresto oRsErrores, "Documentos no importados (con error) : " & mNoProcesadosConError
   AgregarMensajeProcesoPresto oRsErrores, "Documentos no importados (ya existentes) : " & mNoProcesadosYaExistentes
   AgregarMensajeProcesoPresto oRsErrores, "[Finalizacion : " & Now & "]"
   
   
   oPresto.Command ("Archivo|Guardar")
   
Salida:

   On Error Resume Next
   
   oPresto.Close
   oPresto.Quit

   Set LeerPresto = oRsErrores
   
   Unload oF
   Set oF = Nothing

   Set oRs = Nothing
   Set oRsErrores = Nothing
   Set oRsAux = Nothing
   Set oPr = Nothing
   Set oCl = Nothing
   Set oRq = Nothing
   Set oAp = Nothing
   Set oPresto = Nothing

   Exit Function

Mal:

   MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   Resume Salida

End Function

Public Function ImportarDatosDesdePrestoAccess() As ADOR.Recordset

   Dim oSrv As iSrvDatos
   Dim oAp As ComPronto.Aplicacion
   Dim oPr As ComPronto.Proveedor
   Dim oCP As ComPronto.ComprobanteProveedor
   Dim oCl As ComPronto.Cliente
   Dim oRq As ComPronto.Requerimiento
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim oRsErrores As ADOR.Recordset
   Dim oRsPrestoProv As ADOR.Recordset
   Dim oF As Form
   
   Dim mCodigoProveedor As String, mPathObra As String, mCuit As String
   Dim mConfirmado As String, mFactura As String, mObra As String, mCodigo As String
   Dim mContrato As String, mPedido As String, mConcepto As String, mProveedor As String
   Dim s As String
   Dim mOk As Boolean, mGrabar As Boolean, mExiste As Boolean
   Dim i As Integer, mIdMonedaPesos As Integer, mIdObra As Integer, mItem As Integer
   Dim mIdTipoComprobanteFacturaCompra As Integer, mDocumentos As Integer
   Dim mContador As Integer, mProcesados As Integer, mNoProcesadosConError As Integer
   Dim mNoProcesadosYaExistentes As Integer
   Dim mIdProveedor As Long, mIdCuentaGasto As Long, mIdCuenta As Long
   Dim mCodigoCuenta As Long, mCodigo2 As Long, mIdCuentaIvaCompras1 As Long
   Dim mIdArticulo As Long, mIdUnidadPorUnidad As Long, mIdArticuloVarios As Long
   Dim mNumeroRequerimiento As Long, mNumeroReferencia As Long
   Dim mIdCuentaIvaCompras(10) As Long
   Dim mvarCotizacionDolar As Double, mImporte As Double, mBaseFactura As Double
   Dim mIVA As Double, mTotal As Double, mPrecio As Double, mCantidad As Double
   Dim mImportePedido As Double
   Dim mIVAComprasPorcentaje1 As Single, mPorcentajeIVA As Single
   Dim mIVAComprasPorcentaje(10) As Single
   Dim mFechaFactura As Date, mFechaContrato As Date, mFecha As Date, mFechaEntrega As Date

   On Error GoTo Mal
   
   Set oF = New frmPathPresto
   With oF
      .Id = 1
      .Show vbModal
      mOk = .Ok
      If mOk Then
         mArchivo = .FileBrowser1(0).Text
      End If
   End With
   Unload oF
   Set oF = Nothing

   If Not mOk Then Exit Function

   Set oSrv = CreateObject("SrvDatosDAO.SrvDatos")
   oSrv.Connect mArchivo
   
   Set oAp = Aplicacion

   Set oRsErrores = CreateObject("ADOR.Recordset")
   With oRsErrores
      .Fields.Append "Id", adInteger
      .Fields.Append "Detalle", adVarChar, 200
   End With
   oRsErrores.Open
   
   Set oRs = oAp.Parametros.Item(1).Registro
   mIdMonedaPesos = oRs.Fields("IdMoneda").Value
   mIdTipoComprobanteFacturaCompra = oRs.Fields("IdTipoComprobanteFacturaCompra").Value
   mIdUnidadPorUnidad = oRs.Fields("IdUnidadPorUnidad").Value
   If IsNull(oRs.Fields("IdArticuloVariosParaPRESTO").Value) Then
      oRs.Close
      MsgBox "Debe definir en parametros el item material varios para PRESTO!", vbExclamation
      GoTo Salida
   End If
   mIdArticuloVarios = oRs.Fields("IdArticuloVariosParaPRESTO").Value
   For i = 1 To 10
      If Not IsNull(oRs.Fields("IdCuentaIvaCompras" & i).Value) Then
         mIdCuentaIvaCompras(i) = oRs.Fields("IdCuentaIvaCompras" & i).Value
         mIVAComprasPorcentaje(i) = oRs.Fields("IVAComprasPorcentaje" & i).Value
      Else
         mIdCuentaIvaCompras(i) = 0
         mIVAComprasPorcentaje(i) = 0
      End If
   Next
   oRs.Close
   
   Set oF = New frmAviso
   With oF
      .Label1 = "Iniciando PRESTO (ACCESS) ..."
      .Show
      .Refresh
      DoEvents
   End With

   'BAJAR PROVEEDORES DE PRESTO A PRONTO
   oF.Label1 = oF.Label1 & vbCrLf & "Cargando proveedores ... "
   DoEvents

   Set oRsPrestoProv = oSrv.GetRecordset("Entidades", , Srv_cmdTable)
   
   s = oF.Label1.Caption & vbCrLf
   oF.Label1 = oF.Label1 & vbCrLf & "Procesando proveedores ..."
   DoEvents
   
   mContador = 0
   With oRsPrestoProv
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If CInt(.Fields("Tipo").Value) = 0 Then
               mContador = mContador + 1
               oF.Label1 = s & "Procesando proveedores ... " & mContador
               oF.Label2 = "Proveedor : " & mId(.Fields("Nombre").Value, 1, 50)
               oF.Label3 = "" & .AbsolutePosition & " / " & .RecordCount
               DoEvents
               mCuit = Trim(.Fields("NIF").Value)
               If Len(mCuit) > 0 Then
                  Set oRs = oAp.Proveedores.TraerFiltrado("_PorCuitNoEventual", mCuit)
                  If oRs.RecordCount > 0 Then
                     Set oPr = oAp.Proveedores.Item(oRs.Fields(0).Value)
                     mConfirmado = IIf(IsNull(oRs.Fields("Confirmado").Value), "SI", oRs.Fields("Confirmado").Value)
                  Else
                     Set oPr = oAp.Proveedores.Item(-1)
                     mConfirmado = "NO"
                  End If
                  oRs.Close
                  With oPr.Registro
                     .Fields("Confirmado").Value = mConfirmado
                     .Fields("CodigoPresto").Value = oRsPrestoProv.Fields("Entidad").Value
                     .Fields("RazonSocial").Value = mId(oRsPrestoProv.Fields("Nombre").Value, 1, 50)
                     If Len(oRsPrestoProv.Fields("Dirección").Value) > 0 Then
                        .Fields("Direccion").Value = mId(Trim(oRsPrestoProv.Fields("Dirección").Value) & " " & _
                                          Trim(oRsPrestoProv.Fields("Ciudad").Value) & " " & _
                                          Trim(oRsPrestoProv.Fields("Provincia").Value), 1, 50)
                     End If
                     If Len(oRsPrestoProv.Fields("CPostal").Value) > 0 Then
                        .Fields("CodigoPostal").Value = oRsPrestoProv.Fields("CPostal").Value
                     End If
                     .Fields("CUIT").Value = oRsPrestoProv.Fields("NIF").Value
                     If Len(oRsPrestoProv.Fields("Teléfono").Value) > 0 Then
                        .Fields("Telefono1").Value = oRsPrestoProv.Fields("Teléfono").Value
                     End If
                     If Len(oRsPrestoProv.Fields("Correo").Value) > 0 Then
                        .Fields("Email").Value = mId(oRsPrestoProv.Fields("Correo").Value, 1, 50)
                     End If
                  End With
                  oPr.Guardar
                  Set oPr = Nothing
               End If
            End If
            .MoveNext
         Loop
      End If
   End With
   
   
   'BAJAR CLIENTES DE PRESTO A PRONTO
   s = oF.Label1.Caption & vbCrLf
   oF.Label1 = oF.Label1 & vbCrLf & "Procesando clientes ..."
   oF.Label2 = ""
   oF.Label3 = ""
   DoEvents

   mContador = 0
   With oRsPrestoProv
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If CInt(.Fields("Tipo").Value) = 1 Then
               mContador = mContador + 1
               oF.Label1 = s & "Procesando clientes ... " & mContador
               oF.Label2 = "Cliente : " & mId(.Fields("Nombre").Value, 1, 50)
               oF.Label3 = "" & .AbsolutePosition & " / " & .RecordCount
               DoEvents
               mCuit = Trim(.Fields("NIF").Value)
               If Len(mCuit) > 0 Then
                  Set oRs = oAp.Clientes.TraerFiltrado("_PorCuit", mCuit)
                  If oRs.RecordCount > 0 Then
                     Set oCl = oAp.Clientes.Item(oRs.Fields(0).Value)
                     mConfirmado = IIf(IsNull(oRs.Fields("Confirmado").Value), "SI", oRs.Fields("Confirmado").Value)
                  Else
                     Set oCl = oAp.Clientes.Item(-1)
                     mConfirmado = "NO"
                  End If
                  oRs.Close
                  With oCl.Registro
                     .Fields("Confirmado").Value = mConfirmado
                     .Fields("CodigoPresto").Value = oRsPrestoProv.Fields("Proveedor").Value
                     .Fields("RazonSocial").Value = mId(oRsPrestoProv.Fields("Nombre").Value, 1, 50)
                     If Len(oRsPrestoProv.Fields("Dirección").Value) > 0 Then
                        .Fields("Direccion").Value = mId(Trim(oRsPrestoProv.Fields("Dirección").Value) & " " & _
                                          Trim(oRsPrestoProv.Fields("Ciudad").Value) & " " & _
                                          Trim(oRsPrestoProv.Fields("Provincia").Value), 1, 50)
                     End If
                     If Len(oRsPrestoProv.Fields("CPostal").Value) > 0 Then
                        .Fields("CodigoPostal").Value = oRsPrestoProv.Fields("CPostal").Value
                     End If
                     .Fields("CUIT").Value = oRsPrestoProv.Fields("NIF").Value
                     If Len(oRsPrestoProv.Fields("Teléfono").Value) > 0 Then
                        .Fields("Telefono").Value = oRsPrestoProv.Fields("Teléfono").Value
                     End If
                     If Len(oRsPrestoProv.Fields("Correo").Value) > 0 Then
                        .Fields("Email").Value = mId(oRsPrestoProv.Fields("Correo").Value, 1, 30)
                     End If
                  End With
                  oCl.Guardar
                  Set oCl = Nothing
               End If
            End If
            .MoveNext
         Loop
      End If
   End With


'   'Lectura de documentos, detalles y conceptos
'   oF.Label1 = oF.Label1 & vbCrLf & "Cargando Documentos ..."
'   oF.Label2 = ""
'   oF.Label3 = ""
'   DoEvents
'   Set oRsPrestoDoc = CargarTablaPresto("Documentos", oPresto, oF)
'
'   oF.Label1 = oF.Label1 & vbCrLf & "Cargando Suministros ..."
'   oF.Label2 = ""
'   oF.Label3 = ""
'   DoEvents
'   Set oRsPrestoSum = CargarTablaPresto("Suministros", oPresto, oF)
'
'   oF.Label1 = oF.Label1 & vbCrLf & "Cargando Conceptos ..."
'   oF.Label2 = ""
'   oF.Label3 = ""
'   DoEvents
'   Set oRsPrestoConc = CargarTablaPresto("Conceptos", oPresto, oF)
'
'   'BAJAR CONTRATOS DE PRESTO COMO REQUERIMIENTOS DE PRONTO
'   oF.Label1 = oF.Label1 & vbCrLf & "Procesando contratos ..."
'   oF.Label2 = ""
'   oF.Label3 = ""
'   DoEvents
'
'   With oRsPrestoDoc
'      If .RecordCount > 0 Then
'         .MoveFirst
'         Do While Not .EOF
'            If .Fields("gTipo").Value = 1 And _
'                  Len(Trim(.Fields("gProveedor").Value)) = 0 Then
'               mGrabar = True
'               mContrato = .Fields("gDocumento").Value
'               oF.Label2 = "Contrato : " & mContrato
'               oF.Label3 = "" & .AbsolutePosition & " / " & .RecordCount
'               DoEvents
'               Set oRs = oAp.Requerimientos.TraerFiltrado("_PorPRESTOContrato", mContrato)
'               If oRs.RecordCount = 0 Then
'                  mFechaContrato = DateAdd("yyyy", 80, CDate(.Fields("gFecha").Value))
'                  Set oRq = oAp.Requerimientos.Item(-1)
'                  With oRq
'                     With .Registro
'                        .Fields("PRESTOContrato").Value = mContrato
'                        .Fields("Confirmado").Value = "NO"
'                        .Fields("FechaRequerimiento").Value = Date
'                        .Fields("IdObra").Value = 0
'                        .Fields("IdMoneda").Value = mIdMonedaPesos
'                        .Fields("Observaciones").Value = "Contrato PRESTO : " & _
'                                 RTrim(mContrato) & " del " & mFechaContrato & vbCrLf
'                     End With
'                  End With
'                  mItem = 0
'                  mIdObra = 0
'                  With oRsPrestoSum
'                     If .RecordCount > 0 Then
'                        .MoveFirst
'                        Do While Not .EOF
'                           If .Fields("jPedido").Value = mContrato And _
'                                 Len(Trim(.Fields("jProveedor").Value)) = 0 Then
'                              mIdArticulo = 0
'                              Set oRsAux = oAp.Articulos.TraerFiltrado("_PorCodigo", .Fields("jCódigo").Value)
'                              If oRsAux.RecordCount > 0 Then
'                                 mIdArticulo = oRsAux.Fields(0).Value
'                              End If
'                              oRsAux.Close
'                              If mIdObra = 0 Then
'                                 mObra = Trim(.Fields("jObra").Value)
'                                 Set oRsAux = oAp.Obras.TraerFiltrado("_PorNumero", mObra)
'                                 If oRsAux.RecordCount > 0 Then
'                                    mIdObra = oRsAux.Fields(0).Value
'                                 End If
'                                 oRsAux.Close
'                                 If mIdObra = 0 Then
'                                    AgregarMensajeProcesoPresto oRsErrores, "El contrato Presto " & mContrato & _
'                                          " tiene el item con codigo sin obra o con una obra invalida, toda la RM fue rechazada."
'                                    mGrabar = False
'                                    Exit Do
'                                 End If
'                              End If
'                              If mIdArticulo = 0 Then
'                                 mIdArticulo = mIdArticuloVarios
''                                 oRsErrores.AddNew
''                                 oRsErrores.Fields(0).Value = 0
''                                 oRsErrores.Fields(1).Value = "El contrato Presto " & mContrato & " tiene el item con codigo " & _
''                                    .Fields("jCódigo").Value & " inexistente en PRONTO, toda la RM fue rechazada."
''                                 oRsErrores.Update
''                                 mGrabar = False
''                                 Exit Do
'                              End If
'                              mCodigo = .Fields("jCódigo").Value
'                              mConcepto = "Concepto : " & .Fields("jCódigo").Value & vbCrLf
'                              If oRsPrestoConc.RecordCount > 0 Then
'                                 oRsPrestoConc.MoveFirst
'                                 Do While Not oRsPrestoConc.EOF
'                                    If oRsPrestoConc.Fields("cCódigo").Value = .Fields("jCódigo").Value Then
'                                       mConcepto = mConcepto & oRsPrestoConc.Fields("cResumen").Value
'                                       Exit Do
'                                    End If
'                                    oRsPrestoConc.MoveNext
'                                 Loop
'                              End If
'                              If Len(.Fields("jNota").Value) > 0 Then
'                                 mConcepto = mConcepto & vbCrLf & .Fields("jNota").Value
'                              End If
'                              mCantidad = .Fields("jCantidad").Value
'                              If .Fields("jFecPrev").Value > 0 Then
'                                 mFecha = DateAdd("yyyy", 80, CDate(.Fields("jFecPrev").Value))
'                              Else
'                                 mFecha = mFechaContrato
'                              End If
'                              With oRq.DetRequerimientos.Item(-1)
'                                 mItem = mItem + 1
'                                 With .Registro
'                                    .Fields("IdArticulo").Value = mIdArticulo
'                                    .Fields("Cantidad").Value = mCantidad
'                                    .Fields("IdUnidad").Value = mIdUnidadPorUnidad
'                                    .Fields("NumeroItem").Value = mItem
'                                    .Fields("FechaEntrega").Value = mFecha
'                                    .Fields("Adjunto").Value = "NO"
'                                    .Fields("EsBienDeUso").Value = "NO"
'                                    .Fields("Observaciones").Value = mConcepto
'                                    .Fields("PRESTOConcepto").Value = mCodigo
'                                 End With
'                                 .Modificado = True
'                              End With
'                           End If
'                           .MoveNext
'                        Loop
'                     End If
'                  End With
'                  If mGrabar Then
'                     Set oPar = Aplicacion.Parametros.Item(1)
'                     mNumeroRequerimiento = oPar.Registro.Fields("ProximoNumeroRequerimiento").Value
'                     With oPar
'                        .Registro.Fields("ProximoNumeroRequerimiento").Value = mNumeroRequerimiento + 1
'                        .Guardar
'                     End With
'                     Set oPar = Nothing
'                     oRq.Registro.Fields("NumeroRequerimiento").Value = mNumeroRequerimiento
'                     oRq.Registro.Fields("IdObra").Value = mIdObra
'                     oRq.Guardar
'                  End If
'                  Set oRq = Nothing
'               End If
'               oRs.Close
'            End If
'            .MoveNext
'         Loop
'      End If
'   End With
'
'
   'BAJAR FACTURAS DE PRESTO A PRONTO
   s = oF.Label1.Caption & vbCrLf
   oF.Label1 = oF.Label1 & vbCrLf & "Procesando facturas ..."
   oF.Label2 = ""
   oF.Label3 = ""
   DoEvents

   AgregarMensajeProcesoPresto oRsErrores, "IMPORTACION DE FACTURAS DE COMPRA " & _
      "DESDE PRESTO HACIA PRONTO"

   mContador = 0
   mDocumentos = 0
   mProcesados = 0
   mNoProcesadosConError = 0
   mNoProcesadosYaExistentes = 0

   Set oRsPrestoDoc = oSrv.GetRecordset("SELECT * FROM DOCUMENTOS WHERE Tipo=3", , Srv_cmdText)
   
   With oRsPrestoDoc
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If CInt(.Fields("Tipo").Value) = 3 Then
               mGrabar = True
               mFactura = .Fields("Documento").Value
               mCodigoProveedor = .Fields("Entidad").Value
               mContador = mContador + 1
               mDocumentos = mDocumentos + 1
               oF.Label1 = s & "Procesando facturas ... " & mContador
               oF.Label2 = "Factura : " & mFactura
               oF.Label3 = "" & .AbsolutePosition & " / " & .RecordCount
               DoEvents
               Set oRs = oAp.ComprobantesProveedores.TraerFiltrado("_PorPRESTOFactura", Array(mFactura, mCodigoProveedor))
               If oRs.RecordCount > 0 Then
                  mNoProcesadosYaExistentes = mNoProcesadosYaExistentes + 1
               Else
                  mIdProveedor = 0
                  mProveedor = ""
                  Set oRsAux = oAp.Proveedores.TraerFiltrado("_PorCodigoPresto", mCodigoProveedor)
                  If oRsAux.RecordCount > 0 Then
                     mIdProveedor = oRsAux.Fields(0).Value
                     mProveedor = oRsAux.Fields("RazonSocial").Value
                  End If
                  oRsAux.Close
                  If Len(Trim(mFactura)) = 0 Or _
                        ((mId(mFactura, 1, 1) <> "A" And mId(mFactura, 1, 1) <> "B" And _
                          mId(mFactura, 1, 1) <> "C" And mId(mFactura, 1, 1) <> "E") And _
                        Not IsNumeric(mId(mFactura, 2, 4)) And Not IsNumeric(mId(mFactura, 6, 8))) Then
                     AgregarMensajeProcesoPresto oRsErrores, "Hay una factura del proveedor " & _
                        mProveedor & " " & vbCrLf & "numero " & mFactura & " no tiene un formato valido, " & _
                        "toda la factura fue rechazada."
                     mGrabar = False
                  End If
                  If mIdProveedor = 0 Then
                     AgregarMensajeProcesoPresto oRsErrores, "La factura Presto " & mFactura & " es de un proveedor inexistente " & _
                        "en PRONTO, el codigo de PRESTO es " & mCodigoProveedor & ", toda la factura fue rechazada."
                     mGrabar = False
                  Else
                     mFechaFactura = DateAdd("yyyy", 80, CDate(.Fields("Fecha").Value))
                     mvarCotizacionDolar = Cotizacion(mFechaFactura, glbIdMonedaDolar)
                     mBaseFactura = .Fields("BaseFac").Value
                     mPorcentajeIVA = .Fields("IVA").Value
                     mIVA = Round(mBaseFactura * mPorcentajeIVA / 100, 4)
                     mTotal = mBaseFactura + mIVA
                     mIdCuentaIvaCompras1 = 0
                     mIVAComprasPorcentaje1 = 0
                     If mPorcentajeIVA <> 0 Then
                        For i = 1 To 10
                           If mIVAComprasPorcentaje(i) = mPorcentajeIVA Then
                              mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(i)
                              mIVAComprasPorcentaje1 = mIVAComprasPorcentaje(i)
                              Exit For
                           End If
                        Next
                     End If
                     If mIVA <> 0 And mIdCuentaIvaCompras1 = 0 Then
                        AgregarMensajeProcesoPresto oRsErrores, "La factura Presto " & mFactura & _
                           ", tiene un porcentaje de iva igual a " & mPorcentajeIVA & " que no " & _
                           "tiene en los parametros de Pronto una cuenta contable asignada, " & _
                           "toda la factura fue rechazada."
                        mGrabar = False
                     End If
                     Set oCP = oAp.ComprobantesProveedores.Item(-1)
                     With oCP
                        With .Registro
                           .Fields("Confirmado").Value = "NO"
                           .Fields("PRESTOFactura").Value = mFactura
                           .Fields("PRESTOProveedor").Value = mCodigoProveedor
                           .Fields("IdTipoComprobante").Value = mIdTipoComprobanteFacturaCompra
                           .Fields("FechaComprobante").Value = mFechaFactura
                           .Fields("FechaRecepcion").Value = Date
                           .Fields("FechaVencimiento").Value = mFechaFactura
                           .Fields("TotalBruto").Value = mBaseFactura
                           .Fields("TotalIva1").Value = mIVA
                           .Fields("TotalIva2").Value = 0
                           .Fields("TotalBonificacion").Value = 0
                           .Fields("TotalComprobante").Value = mTotal
                           .Fields("PorcentajeBonificacion").Value = 0
                           .Fields("TotalIVANoDiscriminado").Value = 0
                           .Fields("AjusteIVA").Value = 0
                           .Fields("IdMoneda").Value = mIdMonedaPesos
                           .Fields("CotizacionMoneda").Value = 1
                           .Fields("CotizacionDolar").Value = mvarCotizacionDolar
                           .Fields("IdProveedor").Value = mIdProveedor
                           If mId(mFactura, 1, 1) = "A" Or mId(mFactura, 1, 1) = "B" Or _
                              mId(mFactura, 1, 1) = "C" Or mId(mFactura, 1, 1) = "E" Then
                              .Fields("Letra").Value = mId(mFactura, 1, 1)
                           End If
                           If IsNumeric(mId(mFactura, 2, 4)) Then
                              .Fields("NumeroComprobante1").Value = Val(mId(mFactura, 2, 4))
                           End If
                           If IsNumeric(mId(mFactura, 6, 8)) Then
                              .Fields("NumeroComprobante2").Value = Val(mId(mFactura, 6, 8))
                           End If
                        End With
                     End With
                     
                     Set oRsPrestoSum = oSrv.GetRecordset("SELECT * " & _
                                    "FROM SUMINISTROS WHERE Factura=" & Chr(34) & mFactura & Chr(34) & " and " & _
                                    "Proveedor=" & Chr(34) & mCodigoProveedor & Chr(34), , Srv_cmdText)
                     With oRsPrestoSum
                        If .RecordCount > 0 Then
                           .MoveFirst
                           Do While Not .EOF
                              mIdCuenta = 0
                              mCodigoCuenta = 0
                              mIdCuentaGasto = 0
                              
                              Set oRsPrestoConc = oSrv.GetRecordset("SELECT * " & _
                                             "FROM CONCEPTOS WHERE Código=" & Chr(34) & .Fields("Código").Value & Chr(34), , Srv_cmdText)
                              If oRsPrestoConc.RecordCount > 0 Then
                                 oRsPrestoConc.MoveFirst
                                 If Len(Trim(oRsPrestoConc.Fields("Código2").Value)) > 0 And _
                                       IsNumeric(Trim(oRsPrestoConc.Fields("Código2").Value)) Then
                                    mCodigo2 = Val(Trim(oRsPrestoConc.Fields("Código2").Value))
                                    If mCodigo2 > 1000 Then
                                       Set oRsAux = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigo2)
                                       If oRsAux.RecordCount > 0 Then
                                          mIdCuenta = oRsAux.Fields(0).Value
                                          mCodigoCuenta = mCodigo2
                                       End If
                                    Else
                                       Set oRsAux = oAp.CuentasGastos.TraerFiltrado("_PorId", mCodigo2)
                                       If oRsAux.RecordCount > 0 Then
                                          mIdCuentaGasto = oRsAux.Fields(0).Value
                                       End If
                                    End If
                                    oRsAux.Close
                                 End If
                              End If
                              oRsPrestoConc.Close
                              
                              If mIdCuentaGasto = 0 And mIdCuenta = 0 Then
                                 AgregarMensajeProcesoPresto oRsErrores, "La factura Presto " & mFactura & " tiene el item con codigo " & _
                                    .Fields("Código").Value & " sin la cuenta de gasto en codigo2 o una cuenta invalida, " & _
                                    "toda la factura fue rechazada."
                                 mGrabar = False
                                 Exit Do
                              End If

                              mObra = Trim(.Fields("Obra").Value)
                              mIdObra = 0
                              Set oRsAux = oAp.Obras.TraerFiltrado("_PorNumero", mObra)
                              If oRsAux.RecordCount > 0 Then
                                 mIdObra = oRsAux.Fields(0).Value
                              End If
                              oRsAux.Close
                              If mIdObra = 0 And mIdCuenta = 0 Then
                                 AgregarMensajeProcesoPresto oRsErrores, "La factura Presto " & mFactura & " tiene el item con codigo " & _
                                    .Fields("Código").Value & " sin obra o con una obra invalida, toda la factura fue rechazada."
                                 mGrabar = False
                                 Exit Do
                              End If

                              If mIdCuenta = 0 Then
                                 Set oRsAux = oAp.Cuentas.TraerFiltrado("_PorObraCuentaGasto", Array(mIdObra, mIdCuentaGasto))
                                 If oRsAux.RecordCount > 0 Then
                                    mIdCuenta = oRsAux.Fields(0).Value
                                    mCodigoCuenta = oRsAux.Fields("Codigo").Value
                                 End If
                                 oRsAux.Close
                                 If mIdCuentaGasto = 0 Then
                                    AgregarMensajeProcesoPresto oRsErrores, "La factura Presto " & mFactura & " tiene el item con codigo " & _
                                       .Fields("Código").Value & " para el que no se encontro la cuenta contable, " & _
                                       "IdObra " & mIdObra & ", IdCuentaGasto " & mIdCuentaGasto & ", toda la factura fue rechazada."
                                    mGrabar = False
                                    Exit Do
                                 End If
                              End If

                              mImporte = oRsPrestoSum.Fields("Cantidad").Value * oRsPrestoSum.Fields("Precio").Value
                              If Not IsNull(oRsPrestoSum.Fields("Dto").Value) Then
                                 mImporte = mImporte - (mImporte * oRsPrestoSum.Fields("Dto").Value / 100)
                              End If

                              With oCP.DetComprobantesProveedores.Item(-1)
                                 With .Registro
                                    .Fields("PRESTOConcepto").Value = oRsPrestoSum.Fields("Código").Value
                                    .Fields("PRESTOObra").Value = mObra
                                    .Fields("IdObra").Value = mIdObra
                                    .Fields("IdCuentaGasto").Value = mIdCuentaGasto
                                    .Fields("IdCuenta").Value = mIdCuenta
                                    .Fields("CodigoCuenta").Value = mCodigoCuenta
                                    .Fields("Importe").Value = mImporte
                                    If mIdCuentaIvaCompras1 <> 0 Then
                                       .Fields("IdCuentaIvaCompras1").Value = mIdCuentaIvaCompras1
                                       .Fields("IVAComprasPorcentaje1").Value = mIVAComprasPorcentaje1
                                       .Fields("ImporteIVA1").Value = Round(mImporte * mIVAComprasPorcentaje1 / 100, 2)
                                       .Fields("AplicarIVA1").Value = "SI"
                                    Else
                                       .Fields("IdCuentaIvaCompras1").Value = Null
                                       .Fields("IVAComprasPorcentaje1").Value = 0
                                       .Fields("ImporteIVA1").Value = 0
                                       .Fields("AplicarIVA1").Value = "NO"
                                    End If
                                    .Fields("IdCuentaIvaCompras2").Value = Null
                                    .Fields("IVAComprasPorcentaje2").Value = 0
                                    .Fields("ImporteIVA2").Value = 0
                                    .Fields("AplicarIVA2").Value = "NO"
                                    .Fields("IdCuentaIvaCompras3").Value = Null
                                    .Fields("IVAComprasPorcentaje3").Value = 0
                                    .Fields("ImporteIVA3").Value = 0
                                    .Fields("AplicarIVA3").Value = "NO"
                                    .Fields("IdCuentaIvaCompras4").Value = Null
                                    .Fields("IVAComprasPorcentaje4").Value = 0
                                    .Fields("ImporteIVA4").Value = 0
                                    .Fields("AplicarIVA4").Value = "NO"
                                    .Fields("IdCuentaIvaCompras5").Value = Null
                                    .Fields("IVAComprasPorcentaje5").Value = 0
                                    .Fields("ImporteIVA5").Value = 0
                                    .Fields("AplicarIVA5").Value = "NO"
                                    .Fields("IdCuentaIvaCompras6").Value = Null
                                    .Fields("IVAComprasPorcentaje6").Value = 0
                                    .Fields("ImporteIVA6").Value = 0
                                    .Fields("AplicarIVA6").Value = "NO"
                                    .Fields("IdCuentaIvaCompras7").Value = Null
                                    .Fields("IVAComprasPorcentaje7").Value = 0
                                    .Fields("ImporteIVA7").Value = 0
                                    .Fields("AplicarIVA7").Value = "NO"
                                    .Fields("IdCuentaIvaCompras8").Value = Null
                                    .Fields("IVAComprasPorcentaje8").Value = 0
                                    .Fields("ImporteIVA8").Value = 0
                                    .Fields("AplicarIVA8").Value = "NO"
                                    .Fields("IdCuentaIvaCompras9").Value = Null
                                    .Fields("IVAComprasPorcentaje9").Value = 0
                                    .Fields("ImporteIVA9").Value = 0
                                    .Fields("AplicarIVA9").Value = "NO"
                                    .Fields("IdCuentaIvaCompras10").Value = Null
                                    .Fields("IVAComprasPorcentaje10").Value = 0
                                    .Fields("ImporteIVA10").Value = 0
                                    .Fields("AplicarIVA10").Value = "NO"
                                 End With
                                 .Modificado = True
                              End With
                              .MoveNext
                           Loop
                        End If
                        .Close
                     End With
                  End If
                  If mGrabar Then
                     oCP.Guardar
                     mProcesados = mProcesados + 1
                  Else
                     mNoProcesadosConError = mNoProcesadosConError + 1
                  End If
                  Set oCP = Nothing
                  'Marcar facturas en presto
'                  If oPresto.StepFirst("Documentos") = 0 Then
'                     Do While oPresto.FindEqual("Documentos", "gDocumento", mFactura) = 0
'                        If oPresto.GetStr("gTipo") = 3 Then
'                           If mGrabar Then
'                              oPresto.SetNum ("gExp"), 49
'                           Else
'                              oPresto.SetNum ("gExp"), 0
'                           End If
'                           oPresto.UpdateRecord ("Documentos")
'                           Exit Do
'                        Else
'                           If oPresto.StepFirst("Documentos") = 0 Then
'                              Do
'                                 If oPresto.GetStr("gDocumento") = mFactura And _
'                                       oPresto.GetStr("gTipo") = 3 Then
'                                    If mGrabar Then
'                                       oPresto.SetNum ("gExp"), 49
'                                    Else
'                                       oPresto.SetNum ("gExp"), 0
'                                    End If
'                                    oPresto.UpdateRecord ("Documentos")
'                                    Exit Do
'                                 End If
'                              Loop While oPresto.StepNext("Documentos") = 0
'                           End If
'                        End If
'                     Loop
'                  End If
               End If
               oRs.Close
            End If
            .MoveNext
         Loop
      End If
   End With

   AgregarMensajeProcesoPresto oRsErrores, "Informe proceso importacion de facturas de compra desde Presto hacia Pronto : "
   AgregarMensajeProcesoPresto oRsErrores, "Documentos importados : " & mProcesados
   AgregarMensajeProcesoPresto oRsErrores, "Documentos no importados (con error) : " & mNoProcesadosConError
   AgregarMensajeProcesoPresto oRsErrores, "Documentos no importados (ya existentes) : " & mNoProcesadosYaExistentes
   AgregarMensajeProcesoPresto oRsErrores, ""

'   'SUBIR PEDIDOS DE PRONTO A PRESTO
'   oF.Label1 = oF.Label1 & vbCrLf & "Procesando pedidos a PRESTO ..."
'   oF.Label2 = ""
'   oF.Label3 = ""
'   DoEvents
'
'   Set oRs = oAp.Pedidos.TraerFiltrado("_ParaPasarAPrestoCabeceras")
'   If oRs.RecordCount > 0 Then
'      oRs.MoveFirst
'      Do While Not oRs.EOF
'         mGrabar = True
'         mContrato = oRs.Fields("PRESTOContrato").Value
'         mPedido = oRs.Fields("Pedido").Value
'         mFecha = oRs.Fields("Fecha").Value
'         mCodigoProveedor = IIf(IsNull(oRs.Fields("ProveedorPresto").Value), "", oRs.Fields("ProveedorPresto").Value)
'         mImportePedido = IIf(IsNull(oRs.Fields("ImportePedido").Value), 0, oRs.Fields("ImportePedido").Value)
'         If mCodigoProveedor = "" Then
'            AgregarMensajeProcesoPresto oRsErrores, "El pedido de PRONTO numero " & mPedido & _
'               " del " & mFecha & ", tiene un proveedor inexistente en PRESTO."
'            oRsErrores.Update
'            mGrabar = False
'         End If
'         If mGrabar Then
'            mExiste = False
'            If oPresto.StepFirst("Documentos") = 0 Then
'               Do
'                  If oPresto.GetStr("gDocumento") = mContrato And _
'                        Trim(oPresto.GetStr("gProveedor")) = "" And _
'                        oPresto.GetStr("gTipo") = 1 And _
'                        oPresto.GetStr("gPrevisional") = 1 Then
'                     oPresto.SetStr ("gConProveedor"), mCodigoProveedor
'                     oPresto.UpdateRecord ("Documentos")
'                     mExiste = True
'                     Exit Do
'                  End If
'               Loop While oPresto.StepNext("Documentos") = 0
'            End If
'            If Not mExiste Then
'               AgregarMensajeProcesoPresto oRsErrores, "El contrato Presto " & mContrato & _
'                  " no fue encontrado y hay una referencia a el en el " & _
'                  "pedido de PRONTO numero " & mPedido & " del " & mFecha & "."
'               oRsErrores.Update
'               mGrabar = False
'            End If
'            mExiste = False
'            With oRsPrestoDoc
'               If .RecordCount > 0 Then
'                  .MoveFirst
'                  Do While Not .EOF
'                     If .Fields("gDocumento").Value = mPedido And _
'                           .Fields("gProveedor").Value = mCodigoProveedor And _
'                           .Fields("gTipo").Value = 1 And _
'                           .Fields("gPrevisional").Value = 0 Then
'                        mExiste = True
'                        Exit Do
'                     End If
'                     .MoveNext
'                  Loop
'               End If
'            End With
'            If Not mExiste Then
'               oPresto.InitRecord "Documentos"
'               oPresto.SetStr "gDocumento", mPedido
'               oPresto.SetStr "gProveedor", mCodigoProveedor
'               oPresto.SetNum "gTipo", 1
'               oPresto.SetNum "gPrevisional", 0
'               oPresto.SetNum "gFecha", DateAdd("yyyy", -80, mFecha)
'               oPresto.SetStr "gOrgContrato", mContrato
'               oPresto.SetNum "gBasePed", mImportePedido
'               oPresto.InsertRecord "Documentos"
'            End If
'         End If
'         oAp.Tarea "Pedidos_SetearPedidoPresto", Array(oRs.Fields(0).Value, mPedido)
'         oRs.MoveNext
'      Loop
'   End If
'   oRs.Close
'
'   Set oRs = oAp.Pedidos.TraerFiltrado("_ParaPasarAPrestoDetalles")
'   If oRs.RecordCount > 0 Then
'      oRs.MoveFirst
'      Do While Not oRs.EOF
'         mGrabar = True
'         mContrato = oRs.Fields("PRESTOContrato").Value
'         mPedido = oRs.Fields("Pedido").Value
'         mFecha = oRs.Fields("Fecha").Value
'         mCodigoProveedor = IIf(IsNull(oRs.Fields("ProveedorPresto").Value), "", oRs.Fields("ProveedorPresto").Value)
'         mConcepto = IIf(IsNull(oRs.Fields("PRESTOConcepto").Value), "", oRs.Fields("PRESTOConcepto").Value)
'         mPrecio = oRs.Fields("Precio").Value
'         mCantidad = oRs.Fields("Cantidad").Value
'         mFechaEntrega = oRs.Fields("FechaEntrega").Value
'         mObra = oRs.Fields("NumeroObra").Value
'         mExiste = False
'         With oRsPrestoSum
'            If .RecordCount > 0 Then
'               .MoveFirst
'               Do While Not .EOF
'                  If .Fields("jPedido").Value = mPedido And _
'                        .Fields("jProveedor").Value = mCodigoProveedor And _
'                        .Fields("jCódigo").Value = mConcepto Then
'                     mExiste = True
'                     Exit Do
'                  End If
'                  .MoveNext
'               Loop
'            End If
'         End With
'         If Not mExiste Then
'            oPresto.InitRecord "Suministros"
'            oPresto.SetStr "jPedido", mPedido
'            oPresto.SetStr "jProveedor", mCodigoProveedor
'            oPresto.SetStr "jCódigo", mConcepto
'            oPresto.SetNum "jCantidad", mCantidad
'            oPresto.SetNum "jPrecio", mPrecio
'            oPresto.SetNum "jFecPrev", DateAdd("yyyy", -80, mFechaEntrega)
'            oPresto.SetStr "jObra", mObra
'            oPresto.InsertRecord "Suministros"
'         End If
'         oAp.Tarea "DetPedidos_SetearPedidoPresto", Array(oRs.Fields(0).Value, mPedido)
'         oRs.MoveNext
'      Loop
'   End If
'   oRs.Close
'
'   oPresto.Command ("Archivo|Guardar")
'
'Salida:
'
'   On Error Resume Next
'
'   oRsPrestoProv.Close
'   oRsPrestoDoc.Close
'   oRsPrestoSum.Close
'   oRsPrestoConc.Close
'
'   oPresto.Close
'   oPresto.Quit
'
'   Set ImportarDatosDesdePresto = oRsErrores
   
   Unload oF

Salida:

   Set ImportarDatosDesdePrestoAccess = oRsErrores
   
   oSrv.Disconnect
   
   Set oF = Nothing
   Set oRs = Nothing
   Set oRsErrores = Nothing
   Set oRsPrestoProv = Nothing
   Set oRsPrestoDoc = Nothing
   Set oRsPrestoSum = Nothing
   Set oRsPrestoConc = Nothing
   Set oRsAux = Nothing
   Set oPr = Nothing
   Set oCl = Nothing
   Set oRq = Nothing
   Set oAp = Nothing
   Set oRs = Nothing
   Set oSrv = Nothing

   Exit Function

Mal:

   MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   Resume Salida

End Function

Public Sub GenerarNovedades_Presto()

End Sub

