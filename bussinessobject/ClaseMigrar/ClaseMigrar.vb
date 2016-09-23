Imports Pronto.ERP.BO
Imports Excel = Microsoft.Office.Interop.Excel
Imports Microsoft.Office.Interop.Excel

'////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////
'    MOLESTOS de los que hay que independizarse!
'   1: COMpronto !!!!
'   2: Excel Interop !!!!!
'////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////

Public Module ProntoFuncionesGeneralesCOMPRONTO

    Public Const wrdFormatDocument As Object = 0 '(save word .DOC in default format)




    'Debería ser private.......... Qué hago usando ComPronto?!?!?!?! No debería....
    Public Function CrearAppCompronto(ByVal SC As String) As Object ' ComPronto.Aplicacion


        'ya no hace falta encriptarla, porque viene encriptada. pero ahora hay que desencriptarla para 
        'para agregarle el prefijo


        CrearAppCompronto = CreateObject("ComPronto.Aplicacion")


        'En el web.config figura el provider para NET.  
        ' Al COMpronto se lo tengo que poner explicito en la cadena de conexion.

        Dim sConex As String

        sConex = ReEncriptaParaPronto(SC) 'desencripta

        Debug.Print(sConex)



        CrearAppCompronto.StringConexion = sConex

    End Function


    Function ReEncriptaParaPronto(ByVal SC As String) As String
        'En el web.config figura el provider para NET.  
        ' Al COMpronto se lo tengo que poner explicito en la cadena de conexion.
        Return Encriptar("Provider=SQLOLEDB.1;Persist Security Info=False;" + Encriptar(SC)) 'desencripta
    End Function


    Function Encriptar(ByVal SC As String) As String
        Dim x As New dsEncrypt
        x.KeyString = ("EDS")
        'Encriptar = x.Encrypt("Provider=SQLOLEDB.1;Persist Security Info=False;" + SC) 'esto era para el caso especial de compronto. pero no lo uses mas, porque sino estropeas las encriptaciones que no son de ese caso!
        Encriptar = x.Encrypt(SC)
    End Function

    
    Public Sub AsignarNumeroATalonario(ByVal SC As String, ByVal IdPuntoVenta As Integer, ByVal numero As Long)

        Dim Aplicacion = CrearAppCompronto(SC)
        Try
            Dim oPto
            oPto = Aplicacion.PuntosVenta.Item(IdPuntoVenta)
            With oPto.Registro
                .Fields("ProximoNumero").Value = numero
            End With
            oPto.Guardar()
            oPto = Nothing
        Catch ex As Exception
            ErrHandler.WriteAndRaiseError(ex)
            'por qué puede ser que puntosVenta_M no esté?
        End Try
    End Sub

    Public Function GetItemComProntoRemito(ByVal SC As String, ByVal id As Integer, ByVal getRemitoDetalles As Boolean) As Remito
        Dim myRemito As Remito
        'myRemito = RemitoDB.GetItem(SC, id)
        myRemito = New Remito

        Dim Aplicacion = CrearAppCompronto(SC)
        myRemito.__COMPRONTO_Remito = Aplicacion.Remitos.Item(id)

        myRemito = ConvertirComProntoRemitoAPuntoNET(Aplicacion.Remitos.Item(id))
        Return myRemito
    End Function

    Public Function ConvertirComProntoRemitoAPuntoNET(ByVal oRemito) As Pronto.ERP.BO.Remito
        Dim oDest As New Pronto.ERP.BO.Remito

        '///////////////////////////
        '///////////////////////////
        'ENCABEZADO
        With oRemito.Registro
            Debug.Print(DebugGetDataTableColumnNamesRS(oRemito.Registro))

            oDest.Id = oRemito.Id




            'oDest.TipoRemito = .Fields("TipoABC").Value
            oDest.Numero = SQLtoNET(.Fields("NumeroRemito"))
            oDest.Fecha = SQLtoNET(.Fields("FechaRemito"))
            oDest.IdCliente = SQLtoNET(.Fields("IdCliente"))
            oDest.IdPuntoVenta = SQLtoNET(.Fields("IdPuntoVenta"))

            oDest.Observaciones = iisNull(SQLtoNET(.Fields("Observaciones")))




            oDest.IdCondicionVenta = SQLtoNET(.Fields("IdCondicionVenta"))
            oDest.Anulado = SQLtoNET(.Fields("Anulado"))
            oDest.FechaAnulacion = SQLtoNET(.Fields("FechaAnulacion"))
            oDest.ArchivoAdjunto1 = SQLtoNET(.Fields("ArchivoAdjunto1"))
            oDest.ArchivoAdjunto2 = SQLtoNET(.Fields("ArchivoAdjunto2"))
            oDest.Destino = SQLtoNET(.Fields("Destino"))
            oDest.IdProveedor = SQLtoNET(.Fields("IdProveedor"))
            oDest.IdTransportista = SQLtoNET(.Fields("IdTransportista"))
            oDest.TotalBultos = SQLtoNET(.Fields("TotalBultos"))
            oDest.ValorDeclarado = SQLtoNET(.Fields("ValorDeclarado"))
            oDest.FechaRegistracion = SQLtoNET(.Fields("FechaRegistracion"))
            oDest.IdAutorizaAnulacion = SQLtoNET(.Fields("IdAutorizaAnulacion"))
            oDest.PuntoVenta = SQLtoNET(.Fields("PuntoVenta"))
            oDest.Patente = SQLtoNET(.Fields("Patente"))
            oDest.Chofer = SQLtoNET(.Fields("Chofer"))
            oDest.NumeroDocumento = SQLtoNET(.Fields("NumeroDocumento"))
            oDest.OrdenCarga = SQLtoNET(.Fields("OrdenCarga"))
            oDest.OrdenCompra = SQLtoNET(.Fields("OrdenCompra"))
            oDest.COT = SQLtoNET(.Fields("COT"))
            oDest.IdEquipo = SQLtoNET(.Fields("IdEquipo"))
            oDest.IdObra = SQLtoNET(.Fields("IdObra"))
            oDest.IdListaPrecios = SQLtoNET(.Fields("IdListaPrecios"))
            oDest.IdDetalleClienteLugarEntrega = SQLtoNET(.Fields("IdDetalleClienteLugarEntrega"))
        End With


        '///////////////////////////
        '///////////////////////////
        'DETALLE




        Dim rsDet As ADODB.Recordset = oRemito.DetRemitos.TraerTodos

        With rsDet
            If Not .EOF Then .MoveFirst()

            Do While Not .EOF

                Dim item As New RemitoItem
                item.Id = rsDet.Fields("IdDetalleRemito").Value

                Dim oDetRemito = oRemito.DetRemitos.Item(item.Id)

                Debug.Print(DebugGetDataTableColumnNamesRS(oDetRemito.Registro))


                With oDetRemito.Registro

                    item.IdRemito = SQLtoNET(.Fields("IdRemito"))

                    item.IdArticulo = SQLtoNET(.Fields("IdArticulo"))
                    item.Cantidad = SQLtoNET(.Fields("Cantidad"))
                    item.Precio = SQLtoNET(.Fields("Precio"))
                    item.NumeroItem = SQLtoNET(.Fields("NumeroItem"))
                    item.IdUnidad = SQLtoNET(.Fields("IdUnidad"))
                    item.Observaciones = SQLtoNET(.Fields("Observaciones"))
                    item.PorcentajeCertificacion = SQLtoNET(.Fields("PorcentajeCertificacion"))
                    item.OrigenDescripcion = SQLtoNET(.Fields("OrigenDescripcion"))
                    item.IdDetalleOrdenCompra = SQLtoNET(.Fields("IdDetalleOrdenCompra"))
                    item.TipoCancelacion = SQLtoNET(.Fields("TipoCancelacion"))
                    item.IdUbicacion = SQLtoNET(.Fields("IdUbicacion"))
                    item.IdObra = SQLtoNET(.Fields("IdObra"))
                    item.Partida = SQLtoNET(.Fields("Partida"))
                    item.DescargaPorKit = SQLtoNET(.Fields("DescargaPorKit"))
                    item.NumeroCaja = SQLtoNET(.Fields("NumeroCaja"))



                    '///////////////////////////////////////////////////////
                    'DESNORMALIZADOS
                    item.Articulo = rsDet.Fields(4).Value
                    item.ImporteTotalItem = item.Precio * item.Cantidad
                End With

                oDest.Detalles.Add(item)
                .MoveNext()
            Loop

        End With


        Return oDest
    End Function
    Public Function GetItemComProntoFactura(ByVal SC As String, ByVal id As Integer, ByVal getFacturaDetalles As Boolean) As Factura
        Dim myFactura As Factura
        'myFactura = FacturaDB.GetItem(SC, id)
        myFactura = New Factura

        Dim Aplicacion = CrearAppCompronto(SC)
        myFactura.__COMPRONTO_Factura = Aplicacion.Facturas.Item(id)

        myFactura = ConvertirComProntoFacturaAPuntoNET(Aplicacion.Facturas.Item(id))
        Return myFactura
    End Function

    Public Function ConvertirComProntoFacturaAPuntoNET(ByVal oFactura) As Pronto.ERP.BO.Factura
        Dim oDest As New Pronto.ERP.BO.Factura

        '///////////////////////////
        '///////////////////////////
        'ENCABEZADO
        With oFactura.Registro


            oDest.Id = oFactura.Id

            oDest.TipoFactura = SQLtoNET(.Fields("TipoABC"))
            oDest.Numero = SQLtoNET(.Fields("NumeroFactura"))
            oDest.Fecha = SQLtoNET(.Fields("FechaFactura"))
            oDest.IdCliente = SQLtoNET(.Fields("IdCliente"))
            oDest.IdPuntoVenta = SQLtoNET(.Fields("IdPuntoVenta"))

            oDest.Observaciones = iisNull(.Fields("Observaciones"))
            oDest.IdMoneda = SQLtoNET(.Fields("IdMoneda"))
            oDest.IdCondicionVenta = SQLtoNET(.Fields("IdCondicionVenta"))

            oDest.Bonificacion = SQLtoNET(.Fields("PorcentajeBonificacion"))
            oDest.ImporteIva1 = SQLtoNET(.Fields("ImporteIVA1"))
            oDest.Total = SQLtoNET(.Fields("ImporteTotal"))

            oDest.Anulada = SQLtoNET(.Fields("Anulada"))
            oDest.FechaAnulacion = SQLtoNET(.Fields("FechaAnulacion"))
            oDest.IdAutorizaAnulacion = SQLtoNET(.Fields("IdAutorizaAnulacion"))

            oDest.NumeroCertificadoPercepcionIIBB = SQLtoNET(.Fields("NumeroCertificadoPercepcionIIBB"))
            'oDest.bonificacion = .Fields("IdPuntoVenta").Value
            'oDest.total = .Fields("IdPuntoVenta").Value


        End With


        '///////////////////////////
        '///////////////////////////
        'DETALLE
        Dim rsDet As ADODB.Recordset = oFactura.DetFacturas.TraerTodos

        With rsDet
            If Not .EOF Then .MoveFirst()

            Do While Not .EOF


                Dim item As New FacturaItem
                item.Id = rsDet.Fields("IdDetalleFactura").Value
                Dim oDetFactura = oFactura.DetFacturas.Item(item.Id)


                With oDetFactura.Registro

                    item.IdArticulo = .Fields("IdArticulo").Value
                    item.Articulo = rsDet.Fields(6).Value 'el nombre
                    item.Cantidad = .Fields("Cantidad").Value
                    item.Precio = SQLtoNET(.Fields("PrecioUnitario"))
                    item.PrecioUnitarioTotal = SQLtoNET(.Fields("PrecioUnitarioTotal"))
                    item.ImporteTotalItem = item.PrecioUnitarioTotal * item.Cantidad


                    'item.Precio = .Fields("PrecioUnitarioTotal").Value
                    '///////////////////////////////////////////////////////
                    'DESNORMALIZADOS
                    item.Articulo = rsDet.Fields(6).Value 'el nombre que saco del recordset
                    item.ImporteTotalItem = item.Precio * item.Cantidad
                End With

                oDest.Detalles.Add(item)
                .MoveNext()
            Loop

        End With


        Return oDest
    End Function
    Public Function GetItemComProntoRecibo(ByVal SC As String, ByVal id As Integer, ByVal getReciboDetalles As Boolean) As Recibo
        Dim myRecibo As Recibo
        'myRecibo = ReciboDB.GetItem(SC, id)
        myRecibo = New Recibo

        Dim Aplicacion = CrearAppCompronto(SC)
        'myRecibo.__COMPRONTO_Recibo = Aplicacion.Recibos.Item(id)

        myRecibo = ConvertirComProntoReciboAPuntoNET(Aplicacion.Recibos.Item(id))
        Return myRecibo
    End Function
    Public Function ConvertirComProntoReciboAPuntoNET(ByVal oRecibo) As Pronto.ERP.BO.Recibo
        Dim oDest As New Pronto.ERP.BO.Recibo

        '///////////////////////////
        '///////////////////////////
        'ENCABEZADO
        With oRecibo.Registro

            oDest.Id = oRecibo.Id

            'oDest.Fecha = .Fields("FechaRecibo").Value
            oDest.IdCliente = .Fields("IdCliente").Value

            'oDest.TipoFactura = .Fields("TipoABC").Value

            oDest.IdPuntoVenta = .Fields("IdPuntoVenta").Value
            'oDest.Numero = .Fields("NumeroRecibo").Value


            'oDest.IdVendedor = iisNull(.Fields("IdVendedor").Value, 0)
            'oDest.Total = .Fields("ImporteTotal").Value
            oDest.IdMoneda = iisNull(.Fields("IdMoneda").Value, 0)
            'oDest.IdCodigoIVA = iisNull(.Fields("Idcodigoiva").Value, 0)

            oDest.Observaciones = iisNull(.Fields("observaciones").Value, 0)

            'oDest.Bonificacion = .Fields("PorcentajeBonificacion").Value
            'oDest.ImporteIva1 = .Fields("ImporteIVA1").Value
            'oDest.ImporteTotal = .Fields("ImporteTotal").Value
        End With



        '///////////////////////////
        '///////////////////////////
        'DETALLE
        Dim rsDet As ADODB.Recordset = oRecibo.DetRecibos.TraerTodos

        With rsDet
            If Not .EOF Then .MoveFirst()

            Do While Not .EOF

                Dim oDetRecibo = oRecibo.DetRecibos.Item(rsDet.Fields("IdDetalleRecibo"))

                Dim item As New ReciboItem


                With oDetRecibo.Registro

                    'item.IdConcepto = .Fields("IdConcepto").Value
                    'item.Concepto = rsDet.Fields(3).Value
                    item.ImporteTotalItem = .Fields("Importe").Value
                    'item.gravado = .Fields("Gravado").Value
                    'item.Precio = .Fields("IvaNoDiscriminado").Value
                    'item.Precio = .Fields("PrecioUnitarioTotal").Value

                End With

                oDest.DetallesImputaciones.Add(item)
                .MoveNext()
            Loop

        End With


        Return oDest
    End Function
    Public Function GetItemComProntoNotaCredito(ByVal SC As String, ByVal id As Integer, ByVal getNotaDeCreditoDetalles As Boolean) As NotaDeCredito
        Dim myNotaDeCredito As NotaDeCredito
        'myNotaDeCredito = NotaDeCreditoDB.GetItem(SC, id)
        myNotaDeCredito = New NotaDeCredito

        Dim Aplicacion = CrearAppCompronto(SC)
        'myNotaDeCredito.__COMPRONTO_NotaDeCredito = Aplicacion.NotasCredito.Item(id)

        myNotaDeCredito = ConvertirComProntoNotaDeCreditoAPuntoNET(Aplicacion.NotasCredito.Item(id))
        Return myNotaDeCredito
    End Function
    Public Function ConvertirComProntoNotaDeCreditoAPuntoNET(ByVal oNotaDeCredito) As Pronto.ERP.BO.NotaDeCredito
        Dim oDest As New Pronto.ERP.BO.NotaDeCredito

        '///////////////////////////
        '///////////////////////////
        'ENCABEZADO
        With oNotaDeCredito.Registro

            oDest.Id = oNotaDeCredito.Id

            oDest.Fecha = .Fields("FechaNotaCredito").Value
            oDest.IdCliente = .Fields("IdCliente").Value

            oDest.TipoFactura = .Fields("TipoABC").Value

            oDest.IdPuntoVenta = .Fields("IdPuntoVenta").Value
            oDest.Numero = .Fields("NumeroNotaCredito").Value


            oDest.IdVendedor = iisNull(.Fields("IdVendedor").Value, 0)
            oDest.ImporteTotal = .Fields("ImporteTotal").Value
            oDest.IdMoneda = iisNull(.Fields("IdMoneda").Value, 0)
            oDest.IdCodigoIva = iisNull(.Fields("Idcodigoiva").Value, 0)

            oDest.Observaciones = iisNull(.Fields("observaciones").Value, 0)

            'oDest.Bonificacion = .Fields("PorcentajeBonificacion").Value
            oDest.ImporteIva1 = .Fields("ImporteIVA1").Value
            oDest.ImporteTotal = .Fields("ImporteTotal").Value
        End With


        '///////////////////////////
        '///////////////////////////
        'DETALLE
        Dim rsDet As ADODB.Recordset = oNotaDeCredito.DetNotasCredito.TraerTodos

        With rsDet
            If Not .EOF Then .MoveFirst()

            Do While Not .EOF

                Dim oDetNotaDeCredito = oNotaDeCredito.DetNotasCredito.Item(rsDet.Fields("IdDetalleNotaCredito"))

                Dim item As New NotaDeCreditoItem


                With oDetNotaDeCredito.Registro

                    item.IdConcepto = .Fields("IdConcepto").Value
                    item.Concepto = rsDet.Fields(3).Value
                    item.ImporteTotalItem = .Fields("Importe").Value
                    item.Gravado = .Fields("Gravado").Value
                    item.ImporteTotalItem = .Fields("IvaNoDiscriminado").Value
                    'item.Precio = .Fields("PrecioUnitarioTotal").Value

                End With

                oDest.Detalles.Add(item)
                .MoveNext()
            Loop

        End With


        Return oDest
    End Function

    Public Function BuscaIdCliente(ByVal descripcion As String, ByVal SC As String) As Long
        Dim rs As ADODB.Recordset
        Dim Aplicacion
        Aplicacion = CrearAppCompronto(SC)

        rs = Aplicacion.Clientes.TraerTodos
        rs.Filter = "[Razon Social]='" & descripcion & "'"

        If rs.RecordCount = 0 Then
            'Stop
            BuscaIdCliente = -1
        Else
            BuscaIdCliente = rs.Fields("IdCliente").Value
        End If

        rs = Nothing
    End Function

    Public Function BuscaIdLocalidad(ByVal descripcion As String, ByVal SC As String) As Long
        Dim rs As ADODB.Recordset
        Dim Aplicacion
        Aplicacion = CrearAppCompronto(SC)

        rs = Aplicacion.Localidades.TraerTodos
        rs.Filter = "[Localidad]='" & descripcion & "'"

        If rs.RecordCount = 0 Then
            'Stop
            BuscaIdLocalidad = -1
        Else
            BuscaIdLocalidad = rs.Fields("IdLocalidad").Value
        End If

        rs = Nothing
    End Function

    Public Function BuscaIdColor(ByVal descripcion As String) As Long
        Dim rs As ADODB.Recordset
        Dim Aplicacion '
        Aplicacion = CreateObject("ComPronto.Aplicacion")
        rs = Aplicacion.Colores.TraerTodos
        rs.Filter = "COLOR='" & descripcion & "'"

        If rs.RecordCount = 0 Then
            Stop
            BuscaIdColor = -1
        Else
            BuscaIdColor = rs.Fields("IdColor").Value
        End If
        rs = Nothing
    End Function


    Public Function BuscaIdUnidad(ByVal descripcion As String) As Long
        Dim rs As ADODB.Recordset
        Dim Aplicacion
        Aplicacion = CreateObject("ComPronto.Aplicacion")
        rs = Aplicacion.Unidades.TraerTodos
        rs.Filter = "DESCRIPCION='" & descripcion & "'"

        If rs.RecordCount = 0 Then
            Stop
            BuscaIdUnidad = -1
        Else
            BuscaIdUnidad = rs.Fields("IdUnidad").Value
        End If
        rs = Nothing
    End Function

    Public Function BuscaIdMaquina(ByVal descripcion As String) As Long
        Dim rs As ADODB.Recordset
        Dim Aplicacion
        Aplicacion = CreateObject("ComPronto.Aplicacion")
        rs = Aplicacion.Maquinas.TraerTodos
        rs.Filter = "DESCRIPCION='" & descripcion & "'"

        Dim art 'As ComPronto.Articulo 
        'set art=aplicacion.Articulos.Item(rs.Fields("idarticulo


        'If rs.RecordCount = 0 Then Stop

        BuscaIdMaquina = BuscaIdArticulo(descripcion)  'rs.Fields("IdMaquina
        rs = Nothing
    End Function

    Public Function BuscaIdProceso(ByVal descripcion As String) As Long
        Dim rs As ADODB.Recordset
        Dim Aplicacion
        Aplicacion = CreateObject("ComPronto.Aplicacion")
        rs = Aplicacion.Procesos.TraerTodos
        rs.Filter = "DESCRIPCION='" & descripcion & "'"

        If rs.RecordCount = 0 Then Stop
        BuscaIdProceso = rs.Fields("IdProduccionProceso").Value
        rs = Nothing
    End Function

    Public Function BuscaIdUbicacion(ByVal descripcion As String) As Long
        Dim rs As ADODB.Recordset
        Dim Aplicacion
        Aplicacion = CreateObject("ComPronto.Aplicacion")
        rs = Aplicacion.Ubicaciones.TraerTodos
        rs.Filter = "Ubicacion='" & descripcion & "'"

        If rs.RecordCount = 0 Then
            Stop
            BuscaIdUbicacion = -1
        Else
            BuscaIdUbicacion = rs.Fields("IdUbicacion").Value
        End If

        rs = Nothing
    End Function

    Public Function BuscaIdDeposito(ByVal descripcion As String) As Long
        Dim rs As ADODB.Recordset
        Dim Aplicacion
        Aplicacion = CreateObject("ComPronto.Aplicacion")
        rs = Aplicacion.Depositos.TraerTodos
        rs.Filter = "Descripcion='" & descripcion & "'"

        If rs.RecordCount = 0 Then
            Stop
            BuscaIdDeposito = -1
        Else
            BuscaIdDeposito = rs.Fields("IdDeposito").Value
        End If

        rs = Nothing
    End Function



    Public Function BuscaIdArticulo(ByVal descripcion As String, Optional ByVal repeticion As Long = 0) As Long
        Dim rs As ADODB.Recordset
        Dim Aplicacion '
        Aplicacion = CreateObject("ComPronto.Aplicacion")
        rs = Aplicacion.Articulos.TraerFiltrado("_Busca", Left(descripcion, 50))

        If rs.RecordCount = 0 Then
            'MsgBox ("No se encuentra el artículo")
            BuscaIdArticulo = -1
            'Stop
        ElseIf rs.RecordCount > 1 Then
            BuscaIdArticulo = rs.Fields("IdArticulo").Value
            'Debug.Print rs.Fields("IdArticulo, rs.Fields(1)
            'Stop
        Else
            'Do While repeticion > 0
            '    rs.MoveNext
            '    repeticion = repeticion - 1
            'Wend
            BuscaIdArticulo = rs.Fields("IdArticulo").Value
        End If

        rs = Nothing
    End Function

    Private Function BuscaIdStock(ByVal descripcion As String, Optional ByVal Ubicacion As String = "", Optional ByVal Partida As String = "") As Long
        Dim rs As ADODB.Recordset
        Dim Aplicacion
        Aplicacion = CreateObject("ComPronto.Aplicacion")
        rs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_CompletoPorArticulo", New Object() {BuscaIdArticulo(descripcion), 0, 0, 0, 0, 0})

        'rs.Filter = "Partida=Partida"
        If Partida <> "" Then rs.Filter = "Partida='" & Partida & "'"
        If Ubicacion <> "" Then rs.Filter = rs.Filter & "and IdUbicacion=" & BuscaIdUbicacion(Ubicacion)

        If rs.RecordCount > 1 Then Stop 'Encuentra más de uno
        If rs.RecordCount < 1 Then Stop 'No encuentra ninguno.Fields("


        BuscaIdStock = rs.Fields("IdStock").Value
        rs = Nothing
    End Function






    Public Function BuscaIdProveedor(ByVal descripcion As String, ByVal SC As String) As Long
        Dim rs As ADODB.Recordset
        Dim Aplicacion
        Aplicacion = CrearAppCompronto(SC)

        rs = Aplicacion.Proveedores.TraerTodos
        rs.Filter = "[Razon Social]='" & descripcion & "'"

        If rs.RecordCount = 0 Then
            Stop
            BuscaIdProveedor = -1
        Else
            BuscaIdProveedor = rs.Fields("IdProveedor").Value
        End If

        rs = Nothing
    End Function


    Public Function ConvertirPuntoNETFacturaAComPronto(ByVal SC As String, ByVal oFacturaNET As Pronto.ERP.BO.Factura)

        Dim Aplicacion = CrearAppCompronto(SC)
        Dim oFacturaCOMPRONTO = Aplicacion.Facturas.Item(oFacturaNET.Id)

        '///////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////
        'ERRORES EN LA GRABACION (en especial al hacer el alta)
        '///////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////
        'Prob-utiliza un valor de tipo no valido para la operacion actual (Application Uses a Value of the Wrong Type)
        'R-Le puse valores a todos los campos y dejó de pasar. Probablemente las fechas?

        'Prob-La opreacion en varios pasos generó errores (Multiple-step operation generated errors. )
        '-Creo que en los dos casos, SON LAS FECHAS!!! Verificar tambien que no estes agregando renglones eliminados
        '///////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////


        With oFacturaCOMPRONTO.Registro
            Debug.Print(DebugGetDataTableColumnNamesRS(oFacturaCOMPRONTO.Registro))

            ', NumeroFactura
            ', TipoABC
            ', PuntoVenta
            ', IdCliente
            ', FechaFactura
            ', IdCondicionVenta
            ', IdVendedor
            ', IdTransportista1
            ', IdTransportista2
            ', ItemDireccion
            ', OrdenCompra
            ', TipoPedidoConsignacion
            ', Anulada
            ', FechaAnulacion
            ', Observaciones
            ', IdRemito
            ', NumeroRemito
            ', IdPedido
            ', NumeroPedido
            ', ImporteTotal
            ', ImporteIva1
            ', ImporteIva2
            ', ImporteBonificacion
            ', RetencionIBrutos1
            ', PorcentajeIBrutos1
            ', RetencionIBrutos2
            ', PorcentajeIBrutos2
            ', ConvenioMultilateral
            ', RetencionIBrutos3
            ', PorcentajeIBrutos3
            ', IdTipoVentaC
            ', ImporteIvaIncluido
            ', CotizacionDolar
            ', EsMuestra
            ', CotizacionADolarFijo
            ', ImporteParteEnDolares
            ', ImporteParteEnPesos
            ', PorcentajeIva1
            ', PorcentajeIva2
            ', FechaVencimiento
            ', IVANoDiscriminado
            ', IdMoneda
            ', CotizacionMoneda
            ', PorcentajeBonificacion
            ', OtrasPercepciones1
            ', OtrasPercepciones1Desc
            ', OtrasPercepciones2
            ', OtrasPercepciones2Desc
            ', IdProvinciaDestino
            ', IdIBCondicion
            ', IdAutorizaAnulacion
            ', IdPuntoVenta
            ', NumeroCAI
            ', FechaVencimientoCAI
            ', NumeroCertificadoPercepcionIIBB
            ', NumeroTicketInicial
            ', NumeroTicketFinal
            ', IdUsuarioIngreso
            ', FechaIngreso
            ', IdObra
            ', IdIBCondicion2
            ', IdIBCondicion3
            ', IdCodigoIva
            ', Exportacion_FOB
            ', Exportacion_PosicionAduana
            ', Exportacion_Despacho
            ', Exportacion_Guia
            ', Exportacion_IdPaisDestino
            ', Exportacion_FechaEmbarque
            ', Exportacion_FechaOficializacion
            ', OtrasPercepciones3
            ', OtrasPercepciones3Desc
            ', NoIncluirEnCubos
            ', PercepcionIVA
            ', PorcentajePercepcionIVA
            ', ActivarRecuperoGastos
            ', IdAutorizoRecuperoGastos
            ',ContabilizarAFechaVencimiento
            ',FacturaContado
            ', IdReciboContado
            ', EnviarEmail
            ', IdOrigenTransmision
            ', IdFacturaOriginal
            ', FechaImportacionTransmision
            ', CuitClienteTransmision
            ', IdReciboContadoOriginal
            ', DevolucionAnticipo
            ', PorcentajeDevolucionAnticipo
            ', CAE
            ', RechazoCAE
            ', FechaVencimientoORechazoCAE
            ', IdListaPrecios, 

            .Fields("NumeroFactura").Value = oFacturaNET.Numero
            .Fields("IdCliente").Value = oFacturaNET.IdCliente
            '.Fields("FechaFactura").Value = fechaNETtoSQL(oFacturaNET.FechaFactura)
            .Fields("IdCondicionVenta").Value = oFacturaNET.IdCondicionVenta
            .Fields("Anulada").Value = oFacturaNET.Anulada
            .Fields("FechaAnulacion").Value = fechaNETtoSQL(oFacturaNET.FechaAnulacion)
            .Fields("Observaciones").Value = oFacturaNET.Observaciones
            .Fields("ImporteTotal").Value = oFacturaNET.Total



        End With


        For Each i As Pronto.ERP.BO.FacturaItem In oFacturaNET.Detalles
            If i.Eliminado Then Continue For

            Dim DetOC

            If i.Id > 0 And Not i.Nuevo Then
                DetOC = oFacturaCOMPRONTO.DetFacturas.Item(i.Id)
            Else
                DetOC = oFacturaCOMPRONTO.DetFacturas.Item(-1)
            End If

            Debug.Print(DebugGetDataTableColumnNamesRS(DetOC.Registro))
            With DetOC.Registro

                If oFacturaCOMPRONTO.Id > 0 Then .Fields("IdFactura").Value = oFacturaCOMPRONTO.Id


                .Fields("Cantidad").Value = i.Cantidad
                .Fields("IdUnidad").Value = i.IdUnidad
                .Fields("IdArticulo").Value = i.IdArticulo
                .Fields("PrecioUnitario").Value = i.Precio
                .Fields("PrecioUnitarioTotal").Value = i.PrecioUnitarioTotal

                .Fields("Observaciones").Value = i.Observaciones
                '.Fields("NumeroFactura").Value = i.
                '.Fields("TipoABC").Value = i.Cantidad
                '.Fields("PuntoVenta").Value = i.Cantidad
                '.Fields("CodigoArticulo").Value = i.Cantidad
                '.Fields("Costo").Value = i.Cantidad
                '.Fields("Bonificacion").Value = i.Cantidad
                '.Fields("IdDetalleRemito").Value = i.Cantidad
                '.Fields("ParteDolar").Value = i.Cantidad
                '.Fields("PartePesos").Value = i.Cantidad
                '.Fields("PorcentajeCertificacion").Value = i.Cantidad
                '.Fields("OrigenDescripcion").Value = i.Cantidad
                '.Fields("TipoCancelacion").Value = i.Cantidad
                '.Fields("Observaciones").Value = i.Cantidad
                '.Fields("NotaAclaracion").Value = i.Cantidad
                '.Fields("EnviarEmail").Value = i.Cantidad
                '.Fields("IdOrigenTransmision").Value = i.Cantidad
                '.Fields("IdFacturaOriginal").Value = i.Cantidad
                '.Fields("IdDetalleFacturaOriginal").Value = i.Cantidad
                '.Fields("FechaImportacionTransmision").Value = fechaNETtoSQL(i.Cantidad)


            End With
            DetOC.Modificado = True

        Next


        Return oFacturaCOMPRONTO
    End Function

    Public Sub AnularFacturaComPronto(ByVal SC As String, ByVal myFactura As Pronto.ERP.BO.Factura, ByVal IdAutorizaAnulacion As Long)



        Dim myFacturaPronto
        Dim Aplicacion = CrearAppCompronto(SC)
        myFacturaPronto = Aplicacion.Facturas.Item(myFactura.Id)

        With myFacturaPronto

            .Registro.Fields("Anulada").Value = "SI"
            .Registro.Fields("FechaAnulacion").Value = Now
            .Registro.Fields("IdAutorizaAnulacion").Value = IdAutorizaAnulacion

       

            .Guardar()



        End With

    End Sub

    Public Function ConvertirPuntoNETOrdenCompraAComPronto(ByVal SC As String, ByVal oOrdenCompraNET As Pronto.ERP.BO.OrdenCompra)

        Dim Aplicacion = CrearAppCompronto(SC)
        Dim oOrdenCompraCOMPRONTO = Aplicacion.OrdenesCompra.Item(oOrdenCompraNET.Id)

        '///////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////
        'ERRORES EN LA GRABACION (en especial al hacer el alta)
        '///////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////
        'Prob-utiliza un valor de tipo no valido para la operacion actual (Application Uses a Value of the Wrong Type)
        'R-Le puse valores a todos los campos y dejó de pasar. Probablemente las fechas?

        'Prob-La opreacion en varios pasos generó errores (Multiple-step operation generated errors. )
        '-Creo que en los dos casos, SON LAS FECHAS!!! Verificar tambien que no estes agregando renglones eliminados
        '///////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////


        With oOrdenCompraCOMPRONTO.Registro
            Debug.Print(DebugGetDataTableColumnNamesRS(oOrdenCompraCOMPRONTO.Registro))


            .Fields("NumeroOrdenCompra").Value = oOrdenCompraNET.Numero
            .Fields("IdCliente").Value = oOrdenCompraNET.IdCliente
            .Fields("FechaOrdenCompra").Value = fechaNETtoSQL(oOrdenCompraNET.FechaOrdenCompra)
            .Fields("IdCondicionVenta").Value = oOrdenCompraNET.IdCondicionVenta
            .Fields("Anulada").Value = oOrdenCompraNET.Anulada
            .Fields("FechaAnulacion").Value = fechaNETtoSQL(oOrdenCompraNET.FechaAnulacion)
            .Fields("Observaciones").Value = oOrdenCompraNET.Observaciones
            .Fields("ImporteTotal").Value = oOrdenCompraNET.ImporteTotal
            .Fields("ArchivoAdjunto1").Value = oOrdenCompraNET.ArchivoAdjunto1
            .Fields("ArchivoAdjunto2").Value = oOrdenCompraNET.ArchivoAdjunto2
            .Fields("ArchivoAdjunto3").Value = oOrdenCompraNET.ArchivoAdjunto3
            .Fields("ArchivoAdjunto4").Value = oOrdenCompraNET.ArchivoAdjunto4
            .Fields("ArchivoAdjunto5").Value = oOrdenCompraNET.ArchivoAdjunto5
            .Fields("ArchivoAdjunto6").Value = oOrdenCompraNET.ArchivoAdjunto6
            .Fields("ArchivoAdjunto7").Value = oOrdenCompraNET.ArchivoAdjunto7
            .Fields("ArchivoAdjunto8").Value = oOrdenCompraNET.ArchivoAdjunto8
            .Fields("ArchivoAdjunto9").Value = oOrdenCompraNET.ArchivoAdjunto9
            .Fields("ArchivoAdjunto10").Value = oOrdenCompraNET.ArchivoAdjunto10
            .Fields("NumeroOrdenCompraCliente").Value = oOrdenCompraNET.NumeroOrdenCompraCliente
            .Fields("IdObra").Value = oOrdenCompraNET.IdObra
            .Fields("IdMoneda").Value = oOrdenCompraNET.IdMoneda
            .Fields("IdUsuarioAnulacion").Value = oOrdenCompraNET.IdUsuarioAnulacion
            '.Fields("AgrupacionFacturacion").Value = oOrdenCompraNET.AgrupacionFacturacion
            '.Fields("Agrupacion2Facturacion").Value = oOrdenCompraNET.Agrupacion2Facturacion
            .Fields("SeleccionadaParaFacturacion").Value = oOrdenCompraNET.SeleccionadaParaFacturacion
            .Fields("PorcentajeBonificacion").Value = oOrdenCompraNET.PorcentajeBonificacion
            .Fields("IdListaPrecios").Value = oOrdenCompraNET.IdListaPrecios
            .Fields("IdUsuarioIngreso").Value = oOrdenCompraNET.IdUsuarioIngreso
            .Fields("IdListaPrecios").Value = oOrdenCompraNET.IdListaPrecios
            .Fields("FechaIngreso").Value = fechaNETtoSQL(oOrdenCompraNET.FechaIngreso)
            .Fields("IdUsuarioModifico").Value = oOrdenCompraNET.IdUsuarioModifico
            .Fields("FechaModifico").Value = fechaNETtoSQL(oOrdenCompraNET.FechaModifico)
            .Fields("Aprobo").Value = oOrdenCompraNET.IdAprobo
            .Fields("FechaAprobacion").Value = fechaNETtoSQL(oOrdenCompraNET.FechaAprobacion)
            .Fields("CircuitoFirmasCompleto").Value = oOrdenCompraNET.CircuitoFirmasCompleto
            .Fields("IdDetalleClienteLugarEntrega").Value = oOrdenCompraNET.IdDetalleClienteLugarEntrega


            '.Fields("FechaOrdenCompra").Value = "10/10/2010"
            '.Fields("FechaAnulacion").Value = "10/10/2010"
            '.Fields("FechaIngreso").Value = "10/10/2010"
            '.Fields("FechaModifico").Value = "10/10/2010"
            '.Fields("FechaAprobacion").Value = "10/10/2010"


        End With


        For Each i As OrdenCompraItem In oOrdenCompraNET.Detalles
            If i.Eliminado Then Continue For

            Dim DetOC

            If i.Id > 0 And Not i.Nuevo Then
                DetOC = oOrdenCompraCOMPRONTO.DetOrdenesCompra.Item(i.Id)
            Else
                DetOC = oOrdenCompraCOMPRONTO.DetOrdenesCompra.Item(-1)
            End If

            Debug.Print(DebugGetDataTableColumnNamesRS(DetOC.Registro))
            With DetOC.Registro

                If oOrdenCompraCOMPRONTO.Id > 0 Then .Fields("IdOrdenCompra").Value = oOrdenCompraCOMPRONTO.Id

                .Fields("NumeroItem").Value = i.NumeroItem
                .Fields("Cantidad").Value = i.Cantidad
                .Fields("IdUnidad").Value = i.IdUnidad
                .Fields("IdArticulo").Value = i.IdArticulo
                .Fields("Precio").Value = i.Precio
                .Fields("Observaciones").Value = i.Observaciones
                .Fields("OrigenDescripcion").Value = i.OrigenDescripcion
                .Fields("TipoCancelacion").Value = i.TipoCancelacion
                .Fields("Cumplido").Value = i.Cumplido
                .Fields("FacturacionAutomatica").Value = i.FacturacionAutomatica
                .Fields("FechaComienzoFacturacion").Value = fechaNETtoSQL(i.FechaComienzoFacturacion)
                .Fields("CantidadMesesAFacturar").Value = i.CantidadMesesAFacturar
                .Fields("FacturacionCompletaMensual").Value = i.FacturacionCompletaMensual
                .Fields("PorcentajeBonificacion").Value = i.PorcentajeBonificacion
                .Fields("IdDetalleObraDestino").Value = i.IdDetalleObraDestino
                .Fields("FechaNecesidad").Value = fechaNETtoSQL(i.FechaNecesidad)
                .Fields("FechaEntrega").Value = fechaNETtoSQL(i.FechaEntrega)
                .Fields("IdColor").Value = i.IdColor
                .Fields("IdDioPorCumplido").Value = i.IdDioPorCumplido
                .Fields("FechaDadoPorCumplido").Value = fechaNETtoSQL(i.FechaDadoPorCumplido)
                .Fields("ObservacionesCumplido").Value = i.ObservacionesCumplido


                '.Fields("FechaComienzoFacturacion").Value = "10/10/2010"
                '.Fields("FechaComienzoFacturacion").Value = "10/10/2010"
                '.Fields("FechaNecesidad").Value = "10/10/2010"
                '.Fields("FechaEntrega").Value = "10/10/2010"
                '.Fields("FechaDadoPorCumplido").Value = "10/10/2010"


            End With
            DetOC.Modificado = True

        Next


        Return oOrdenCompraCOMPRONTO
    End Function

    Public Function GrabarAjusteStockConCompronto(ByVal SC As String, ByVal mIdAjusteStock As Integer, ByVal IdArticulo As Integer, ByVal Cantidad As Double) As Integer ' ComPronto.AjustesStock

        Dim Aplicacion 'As ComPronto.Aplicacion
        Aplicacion = CrearAppCompronto(SC)

        Dim oAju 'As ComPronto.AjusteStock
        Dim mIdDetalleAjusteStock As Integer = -1
        Dim mNumeroAjusteStock As Long

        '????
        Dim mIdObraDefault = 1
        Dim glbIdUsuario = 1
        Dim mNumeroCaja1 = 1



        If mIdAjusteStock = -1 Then
            Dim oPar = Aplicacion.Parametros.Item(1)
            With oPar.Registro
                mNumeroAjusteStock = .Fields("ProximoNumeroAjusteStock").Value
                .Fields("ProximoNumeroAjusteStock").Value = mNumeroAjusteStock + 1
            End With
            oPar.Guardar()
            oPar = Nothing
        Else
            Dim oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetAjustesStock", "AjStk", mIdAjusteStock)
            If oRs.RecordCount > 0 Then
                mIdDetalleAjusteStock = oRs.Fields(0).Value
            End If
            oRs.Close()
        End If

        oAju = Aplicacion.AjustesStock.Item(mIdAjusteStock)
        With oAju
            With .Registro
                .Fields("NumeroAjusteStock").Value = mNumeroAjusteStock
                .Fields("FechaAjuste").Value = Now
                '.Fields("Observaciones").Value = "Ingreso por etiquetado."
                .Fields("IdRealizo").Value = glbIdUsuario
                .Fields("FechaRegistro").Value = Now
                .Fields("NumeroMarbete").Value = mNumeroCaja1
                .Fields("TipoAjuste").Value = ""
                .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                .Fields("FechaIngreso").Value = Now
            End With
            With .DetAjustesStock.Item(mIdDetalleAjusteStock)
                With .Registro
                    .Fields("IdArticulo").Value = IdArticulo
                    .Fields("CantidadUnidades").Value = Cantidad

                    .Fields("Partida").Value = ""
                    .Fields("IdUnidad").Value = Nothing
                    '.Fields("Observaciones").Value = "Movimiento"
                    .Fields("IdUbicacion").Value = Nothing
                    .Fields("IdObra").Value = mIdObraDefault
                    .Fields("NumeroCaja").Value = mNumeroCaja1
                End With
                .Modificado = True
            End With
            .Guardar()
        End With

        GrabarAjusteStockConCompronto = oAju.registro.fields("IdAjusteStock").value
        oAju = Nothing

        Aplicacion = Nothing

    End Function

    Public Function GetItemComProntoOrdenCompra(ByVal SC As String, ByVal id As Integer, ByVal getOrdenCompraDetalles As Boolean) As Pronto.ERP.BO.OrdenCompra
        Dim myOrdenCompra As Pronto.ERP.BO.OrdenCompra
        'myOrdenCompra = OrdenCompraDB.GetItem(SC, id)
        myOrdenCompra = New Pronto.ERP.BO.OrdenCompra

        Dim Aplicacion = CrearAppCompronto(SC)
        myOrdenCompra.__COMPRONTO_OrdenCompra = Aplicacion.OrdenesCompra.Item(id)

        myOrdenCompra = ClaseMigrar.ConvertirComProntoOrdenCompraAPuntoNET(Aplicacion.OrdenesCompra.Item(id))
        Return myOrdenCompra
    End Function

    Public Function EstadoEntidad(ByVal SC As String, ByVal Entidad As String, ByVal IdEntidad As Long) As String


        Dim Aplicacion = CrearAppCompronto(SC) ' as ComPronto.Aplicacion = CrearAppCompronto(SC)

        EstadoEntidad = "ACTIVO"

        Dim oRs As adodb.Recordset
        Dim mIdEstado As Long

        mIdEstado = 0

        oRs = Aplicacion.TablasGenerales.TraerUno(Entidad, IdEntidad)
        If oRs.RecordCount > 0 Then
            mIdEstado = IIf(IsNull(oRs.Fields("IdEstado").Value), 0, oRs.Fields("IdEstado").Value)
        End If
        oRs.Close()

        If mIdEstado > 0 Then
            oRs = Aplicacion.TablasGenerales.TraerUno("EstadosProveedores", mIdEstado)
            If oRs.RecordCount > 0 Then
                If IIf(IsNull(oRs.Fields("Activo").Value), "SI", oRs.Fields("Activo").Value) = "NO" Then
                    EstadoEntidad = "INACTIVO"
                End If
            End If
            oRs.Close()
        End If

        oRs = Nothing

    End Function



    Public Function ConvertirComProntoOrdenCompraAPuntoNET(ByVal oOrdenCompra) As Pronto.ERP.BO.OrdenCompra
        Dim oDest As New Pronto.ERP.BO.OrdenCompra

        '///////////////////////////
        '///////////////////////////
        'ENCABEZADO
        With oOrdenCompra.Registro


            oDest.Id = oOrdenCompra.Id

            ''oDest.TipoOrdenCompra = .Fields("TipoABC").Value
            'oDest.Numero = .Fields("NumeroOrdenCompra").Value
            'oDest.Fecha = .Fields("FechaOrdenCompra").Value
            'oDest.IdCliente = .Fields("IdCliente").Value
            ''oDest.IdPuntoVenta = .Fields("IdPuntoVenta").Value

            'oDest.Observaciones = iisNull(.Fields("Observaciones").Value)
            'oDest.IdMoneda = .Fields("IdMoneda").Value
            'oDest.IdCondicionVenta = iisNull(.Fields("IdCondicionVenta").Value, 0)

            'oDest.Bonificacion = SQLtoNET(.Fields("PorcentajeBonificacion"))
            ''oDest.ImporteIva1 = SQLtoNET(.Fields("ImporteIVA1"))
            'oDest.ImporteTotal = SQLtoNET(.Fields("ImporteTotal"))

            'oDest.Anulada = SQLtoNET(.Fields("Anulada"))
            'oDest.FechaAnulacion = SQLtoNET(.Fields("FechaAnulacion"))
            ''oDest.IdAutorizaAnulacion = SQLtoNET(.Fields("IdAutorizaAnulacion"))

            ''oDest.bonificacion = .Fields("IdPuntoVenta").Value
            ''oDest.total = .Fields("IdPuntoVenta").Value



            oDest.Numero = SQLtoNET(.Fields("NumeroOrdenCompra"))
            oDest.IdCliente = SQLtoNET(.Fields("IdCliente"))
            oDest.FechaOrdenCompra = SQLtoNET(.Fields("FechaOrdenCompra"))
            oDest.IdCondicionVenta = SQLtoNET(.Fields("IdCondicionVenta"))
            oDest.Anulada = SQLtoNET(.Fields("Anulada"))
            oDest.FechaAnulacion = SQLtoNET(.Fields("FechaAnulacion"))
            oDest.Observaciones = SQLtoNET(.Fields("Observaciones"))
            oDest.ImporteTotal = SQLtoNET(.Fields("ImporteTotal"))
            oDest.ArchivoAdjunto1 = SQLtoNET(.Fields("ArchivoAdjunto1"))
            oDest.ArchivoAdjunto2 = SQLtoNET(.Fields("ArchivoAdjunto2"))
            oDest.ArchivoAdjunto3 = SQLtoNET(.Fields("ArchivoAdjunto3"))
            oDest.ArchivoAdjunto4 = SQLtoNET(.Fields("ArchivoAdjunto4"))
            oDest.ArchivoAdjunto5 = SQLtoNET(.Fields("ArchivoAdjunto5"))
            oDest.ArchivoAdjunto6 = SQLtoNET(.Fields("ArchivoAdjunto6"))
            oDest.ArchivoAdjunto7 = SQLtoNET(.Fields("ArchivoAdjunto7"))
            oDest.ArchivoAdjunto8 = SQLtoNET(.Fields("ArchivoAdjunto8"))
            oDest.ArchivoAdjunto9 = SQLtoNET(.Fields("ArchivoAdjunto9"))
            oDest.ArchivoAdjunto10 = SQLtoNET(.Fields("ArchivoAdjunto10"))
            oDest.NumeroOrdenCompraCliente = SQLtoNET(.Fields("NumeroOrdenCompraCliente"))
            oDest.IdObra = SQLtoNET(.Fields("IdObra"))
            oDest.IdMoneda = SQLtoNET(.Fields("IdMoneda"))
            oDest.IdUsuarioAnulacion = SQLtoNET(.Fields("IdUsuarioAnulacion"))
            oDest.AgrupacionFacturacion = SQLtoNET(.Fields("AgrupacionFacturacion"))
            oDest.Agrupacion2Facturacion = SQLtoNET(.Fields("Agrupacion2Facturacion"))
            oDest.SeleccionadaParaFacturacion = SQLtoNET(.Fields("SeleccionadaParaFacturacion"))
            oDest.PorcentajeBonificacion = SQLtoNET(.Fields("PorcentajeBonificacion"))
            oDest.IdListaPrecios = SQLtoNET(.Fields("IdListaPrecios"))
            oDest.IdUsuarioIngreso = SQLtoNET(.Fields("IdUsuarioIngreso"))
            oDest.IdListaPrecios = SQLtoNET(.Fields("IdListaPrecios"))
            oDest.FechaIngreso = SQLtoNET(.Fields("FechaIngreso"))
            oDest.IdUsuarioModifico = SQLtoNET(.Fields("IdUsuarioModifico"))
            oDest.FechaModifico = SQLtoNET(.Fields("FechaModifico"))
            oDest.IdAprobo = SQLtoNET(.Fields("Aprobo"))
            oDest.FechaAprobacion = SQLtoNET(.Fields("FechaAprobacion"))
            oDest.FechaModifico = SQLtoNET(.Fields("FechaModifico"))
            oDest.CircuitoFirmasCompleto = SQLtoNET(.Fields("CircuitoFirmasCompleto"))
            oDest.IdDetalleClienteLugarEntrega = SQLtoNET(.Fields("IdDetalleClienteLugarEntrega"))


        End With


        '///////////////////////////
        '///////////////////////////
        'DETALLE
        Dim rsDet As ADODB.Recordset = oOrdenCompra.DetOrdenesCompra.TraerTodos

        With rsDet
            If Not .EOF Then .MoveFirst()

            Do While Not .EOF


                Dim item As New Pronto.ERP.BO.OrdenCompraItem
                item.Id = rsDet.Fields("IdDetalleOrdenCompra").Value

                Dim oDetOrdenCompra = oOrdenCompra.DetOrdenesCompra.Item(item.Id)


                With oDetOrdenCompra.Registro

                    item.IdOrdenCompra = SQLtoNET(.Fields("IdOrdenCompra"))

                    item.NumeroItem = SQLtoNET(.Fields("NumeroItem"))
                    item.Cantidad = SQLtoNET(.Fields("Cantidad"))
                    item.IdUnidad = SQLtoNET(.Fields("IdUnidad"))
                    item.IdArticulo = SQLtoNET(.Fields("IdArticulo"))
                    item.Precio = SQLtoNET(.Fields("Precio"))
                    item.Observaciones = SQLtoNET(.Fields("Observaciones"))
                    item.OrigenDescripcion = SQLtoNET(.Fields("OrigenDescripcion"))
                    item.TipoCancelacion = SQLtoNET(.Fields("TipoCancelacion"))
                    item.Cumplido = SQLtoNET(.Fields("Cumplido"))
                    item.FacturacionAutomatica = SQLtoNET(.Fields("FacturacionAutomatica"))
                    item.FechaComienzoFacturacion = SQLtoNET(.Fields("FechaComienzoFacturacion"))
                    item.CantidadMesesAFacturar = SQLtoNET(.Fields("CantidadMesesAFacturar"))
                    item.FacturacionCompletaMensual = SQLtoNET(.Fields("FacturacionCompletaMensual"))
                    item.PorcentajeBonificacion = SQLtoNET(.Fields("PorcentajeBonificacion"))
                    item.IdDetalleObraDestino = SQLtoNET(.Fields("IdDetalleObraDestino"))
                    item.FechaNecesidad = SQLtoNET(.Fields("FechaNecesidad"))
                    item.FechaEntrega = SQLtoNET(.Fields("FechaEntrega"))
                    item.IdColor = SQLtoNET(.Fields("IdColor"))
                    item.IdDioPorCumplido = SQLtoNET(.Fields("IdDioPorCumplido"))
                    item.FechaDadoPorCumplido = SQLtoNET(.Fields("FechaDadoPorCumplido"))
                    item.ObservacionesCumplido = SQLtoNET(.Fields("ObservacionesCumplido"))


                    'item.IdArticulo = .Fields("IdArticulo").Value
                    'item.Cantidad = .Fields("Cantidad").Value
                    'item.Precio = SQLtoNET(.Fields("Precio"))
                    ''item.PrecioUnitarioTotal = SQLtoNET(.Fields("PrecioUnitarioTotal"))


                    '///////////////////////////////////////////////////////
                    'DESNORMALIZADOS
                    item.Articulo = rsDet.Fields(6).Value 'el nombre que saco del recordset
                    item.ImporteTotalItem = item.Precio * item.Cantidad


                    'item.Precio = .Fields("PrecioUnitarioTotal").Value
                End With

                oDest.Detalles.Add(item)
                .MoveNext()
            Loop

        End With


        Return oDest
    End Function

    

    Public Function ImportacionInformacionImpositiva(ByVal mArchivo As String, ByVal SC As String, ByVal CUIT As String) As String

        Dim oAp
        Dim oProv 'As ComPronto.Proveedor 
        Dim oCli 'As ComPronto.Cliente 
        Dim oRs As ADODB.Recordset
        Dim oRsAux1 As ADODB.Recordset
        Dim oRsAux2 As ADODB.Recordset
        'Dim oF As frm_Aux
        '     Dim of1 As frmAviso
        Dim s As String, mCuit As String, mArchivoSalida As String
        Dim mvarPathArchivosExportados As String, mAux1 As String, mAuxS1 As String, mAuxS2 As String
        Dim mAuxS3 As String, mAuxS4 As String
        Dim mCodigo As Integer, mvarSeguro As Integer
        Dim i As Long, j As Long, X As Long, mAuxL1 As Long, mAuxL2 As Long, mAuxL3 As Long
        Dim mFechaLog As Date, mAuxD1 As Date
        Dim mOk As Boolean, mConProblemas As Boolean, mPrimero As Boolean
        Dim mAux2 As Double
        Dim Filas, Columnas

        '   On Error GoTo Mal



        mPrimero = True



        mCodigo = 8

        mOk = True
        '     End With
        'Unload oF
        'Set oF = Nothing

        If Not mOk Or Len(mArchivo) = 0 And mCodigo <> 3 Then Exit Function


        oAp = CrearAppCompronto(sc)




        If mCodigo = 3 Then
            oRs = oAp.Parametros.TraerTodos
            mvarPathArchivosExportados = IIf(IsNull(oRs.Fields("PathArchivosExportados").Value), "C:\", oRs.Fields("PathArchivosExportados").Value)
            oRs.Close()
            oRs = oAp.Proveedores.TraerFiltrado("_ParaTransmitir_Todos")
            If oRs.RecordCount > 0 Then
                s = "" & Mid(CUIT, 1, 2) & Mid(CUIT, 4, 8) & Mid(CUIT, 13, 1) & vbCrLf
                oRs.MoveFirst()
                Do While Not oRs.EOF
                    If Not IsNull(oRs.Fields("IdCodigoIva").Value) And _
                          oRs.Fields("IdCodigoIva").Value = 1 And _
                          Len(oRs.Fields("Cuit").Value) > 0 Then
                        s = s & "" & Mid(oRs.Fields("Cuit").Value, 1, 2) & _
                           Mid(oRs.Fields("Cuit").Value, 4, 8) & Mid(oRs.Fields("Cuit").Value, 13, 1) & _
                           " " & Mid(CStr(Today), 4, 7) & vbCrLf
                    End If
                    oRs.MoveNext()
                Loop
            End If
            oRs.Close()
            If Len(s) > 0 Then
                s = Mid(s, 1, Len(s) - 2)
                mArchivoSalida = mvarPathArchivosExportados & "ReproWeb.txt"
                GuardarArchivoSecuencial(mArchivoSalida, s)
            End If
            MsgBox("Se ha generado el archivo : " & mArchivoSalida)
            GoTo Salida
        End If

        If mCodigo = 6 Then
            oAp.Tarea("Proveedores_BorrarEmbargos")
        End If

        If mCodigo = 7 Then
            oRsAux1 = oAp.Proveedores.TraerFiltrado("_SoloCuit")
            oRsAux2 = oAp.Clientes.TraerFiltrado("_SoloCuit")
        End If



        s = LeerArchivoSecuencial1(mArchivo)
        If Len(s) = 0 Then GoTo Salida
        'of1.Label1 = ""

        Filas = Split(s, Chr(10))
        For i = 0 To UBound(Filas) - 1
            'of1.Label1 = vbCrLf & vbCrLf & vbCrLf & vbCrLf & "Procesando registros ..."
            'of1.Label2 = "Registro : " & i & " de " & UBound(Filas)
            'DoEvents()



            If mCodigo = 1 Then
                Columnas = Split(Filas(i), vbTab)
                If UBound(Columnas) < 9 Then
                    If mPrimero Then
                        MsgBox("Archivo invalido", vbExclamation)
                        GoTo Salida
                    End If
                End If
                If mPrimero Then
                    mPrimero = False
                    mFechaLog = Now
                    oAp.Tarea("Proveedores_EstadoInicialImpositivo", New Object() {mFechaLog, "RG830"})
                End If
                If i >= 1 And UBound(Columnas) >= 9 Then
                    mCuit = Mid(Columnas(1), 1, 2) & "-" & Mid(Columnas(1), 3, 8) & "-" & Mid(Columnas(1), 11, 1)
                    oRs = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)
                    If oRs.RecordCount > 0 Then
                        If IsNull(oRs.Fields("Eventual").Value) Or oRs.Fields("Eventual").Value <> "SI" Then
                            oProv = oAp.Proveedores.Item(oRs.Fields(0).Value)
                            If CInt(Columnas(3)) = 100 Then
                                oProv.Registro.Fields("IGCondicion").Value = 1
                                oProv.Registro.Fields("FechaLimiteExentoGanancias").Value = CDate(Columnas(9))
                            Else
                                oProv.Registro.Fields("IGCondicion").Value = 2
                                oProv.Registro.Fields("FechaLimiteExentoGanancias").Value = Nothing
                            End If
                            oAp.Tarea("LogImpuestos_A", New Object() {mFechaLog, "RG830", oRs.Fields(0).Value, _
                                                             oProv.Registro.Fields("IGCondicion").Value, _
                                                             oProv.Registro.Fields("FechaLimiteExentoGanancias").Value})
                            oProv.Guardar()
                        End If
                    End If
                    oRs.Close()
                End If

            ElseIf mCodigo = 2 Then
                If Len(Filas(i)) >= 130 Then
                    If Mid(Filas(i), 110, 4) = "RG17" Or Mid(Filas(i), 110, 6) = "RG2226" Then
                        If mPrimero Then
                            mPrimero = False
                            mFechaLog = Now
                            oAp.Tarea("Proveedores_EstadoInicialImpositivo", New Object() {mFechaLog, Mid(Filas(i), 112, 6)})
                        End If
                        Columnas = Split(Filas(i), vbTab)
                        mCuit = Mid(Filas(i), 2, 2) & "-" & Mid(Filas(i), 4, 8) & "-" & Mid(Filas(i), 12, 1)
                        oRs = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)
                        If oRs.RecordCount > 0 Then
                            If IsNull(oRs.Fields("Eventual").Value) Or oRs.Fields("Eventual").Value <> "SI" Then
                                oProv = oAp.Proveedores.Item(oRs.Fields(0).Value)
                                '                     If CSng(mId(Filas(i), 104, 5)) = 100 Then
                                '                        oProv.Registro.Fields("IvaExencionRetencion").Value = "SI"
                                '                        oProv.Registro.Fields("IvaPorcentajeExencion").Value =Nothing
                                '                        oProv.Registro.Fields("IvaFechaCaducidadExencion").Value = CDate(mId(Filas(i), 86, 10))
                                '                     Else
                                oProv.Registro.Fields("IvaExencionRetencion").Value = "NO"
                                oProv.Registro.Fields("IvaPorcentajeExencion").Value = CSng(Mid(Filas(i), 104, 5))
                                oProv.Registro.Fields("IvaFechaInicioExencion").Value = CDate(Mid(Filas(i), 75, 10))
                                oProv.Registro.Fields("IvaFechaCaducidadExencion").Value = CDate(Mid(Filas(i), 86, 10))
                                '                     End If
                                oAp.Tarea("LogImpuestos_A", New Object() {mFechaLog, Mid(Filas(i), 112, 6), oRs.Fields(0).Value, _
                                                                 -1, Nothing, _
                                                                 oProv.Registro.Fields("IvaExencionRetencion").Value, _
                                                                 oProv.Registro.Fields("IvaPorcentajeExencion").Value, _
                                                                 oProv.Registro.Fields("IvaFechaCaducidadExencion").Value})
                                oProv.Guardar()
                            End If
                        End If
                        oRs.Close()
                    End If
                End If

            ElseIf mCodigo = 4 Then
                Columnas = Split(Filas(i), ",")
                If UBound(Columnas) < 6 Then
                    MsgBox("Archivo invalido", vbExclamation)
                    GoTo Salida
                End If
                'If IsNumeric(mId(Filas(i), 95, 1)) Then
                If IsNumeric(Columnas(4)) Then
                    If mPrimero Then
                        mPrimero = False
                        mFechaLog = Now
                        oAp.Tarea("Proveedores_EstadoInicialImpositivo", New Object() {mFechaLog, "ReproWeb"})
                    End If
                    mCuit = Mid(Trim(Columnas(1)), 1, 2) & "-" & Mid(Trim(Columnas(1)), 3, 8) & "-" & Mid(Trim(Columnas(1)), 11, 1)
                    oRs = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)
                    If oRs.RecordCount > 0 Then
                        oProv = oAp.Proveedores.Item(oRs.Fields(0).Value)
                        'oProv.Registro.Fields("CodigoSituacionRetencionIVA").Value = CLng(mId(Filas(i), 95, 1))
                        oProv.Registro.Fields("CodigoSituacionRetencionIVA").Value = CLng(Columnas(4))
                        oAp.Tarea("LogImpuestos_A", New Object() {mFechaLog, "ReproWeb", oRs.Fields(0).Value, _
                                                         -1, Nothing, Nothing, -1, Nothing, _
                                                         oProv.Registro.Fields("CodigoSituacionRetencionIVA").Value})
                        oProv.Guardar()
                    End If
                    oRs.Close()
                End If

            ElseIf mCodigo = 5 Then
                '         Columnas = VBA.Split(Filas(i), vbTab)
                ''         If UBound(Columnas) < 7 Then
                ''            MsgBox "Archivo invalido", vbExclamation
                ''            GoTo Salida
                ''         End If
                '         If i >= 1 And Len(Columnas(0)) >= 11 Then
                '            mCuit = mId(Columnas(0), 1, 2) & "-" & mId(Columnas(0), 3, 8) & "-" & mId(Columnas(0), 11, 1)
                '            Set oRs = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)
                '            If oRs.RecordCount > 0 Then
                '               Set oProv = oAp.Proveedores.Item(oRs.Fields(0).Value)
                '               Columnas = VBA.Split(Filas(i + 2), vbTab)
                '               If Len(Columnas(0)) > 50 Then
                '                  If CInt(mId(Columnas(0), 31, 4)) = 100 And IsDate(mId(Columnas(0), 63, 9)) Then
                '                     With oProv.Registro
                '                        .Fields("RetenerSUSS").Value = "EX"
                '                        .Fields("SUSSFechaCaducidadExencion").Value = CDate(mId(Columnas(0), 63, 9))
                '                        .Fields("IdImpuestoDirectoSUSS").Value =Nothing
                '                     End With
                '                  End If
                '                  oProv.Guardar
                '               End If
                '               i = i + 3
                '            End If
                '            oRs.Close
                If IsNumeric(Mid(Filas(i), 1, 11)) Then
                    mCuit = Mid(Filas(i), 1, 2) & "-" & Mid(Filas(i), 3, 8) & "-" & Mid(Filas(i), 11, 1)
                    oRs = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)
                    If oRs.RecordCount > 0 Then
                        '               mOk = False
                        '               For j = i To i + 10
                        '                  If IsDate(mId(Filas(j), 63, 9)) Then
                        '                     mOk = True
                        '                     i = j
                        '                     Exit For
                        '                  End If
                        '               Next
                        '               If mOk Then
                        oProv = oAp.Proveedores.Item(oRs.Fields(0).Value)
                        Columnas = Split(Filas(i), ";")
                        If UBound(Columnas) <> 7 Then
                            If mPrimero Then
                                MsgBox("Archivo invalido", vbExclamation)
                                GoTo Salida
                            End If
                        End If
                        If mPrimero Then
                            mPrimero = False
                            mFechaLog = Now
                            oAp.Tarea("Proveedores_EstadoInicialImpositivo", New Object() {mFechaLog, "SUSS"})
                        End If
                        mAuxS1 = Columnas(7)
                        mAuxS1 = Replace(mAuxS1, "JAN", "01")
                        mAuxS1 = Replace(mAuxS1, "FEB", "02")
                        mAuxS1 = Replace(mAuxS1, "MAR", "03")
                        mAuxS1 = Replace(mAuxS1, "APR", "04")
                        mAuxS1 = Replace(mAuxS1, "MAY", "05")
                        mAuxS1 = Replace(mAuxS1, "JUN", "06")
                        mAuxS1 = Replace(mAuxS1, "JUL", "07")
                        mAuxS1 = Replace(mAuxS1, "AUG", "08")
                        mAuxS1 = Replace(mAuxS1, "SEP", "09")
                        mAuxS1 = Replace(mAuxS1, "OCT", "10")
                        mAuxS1 = Replace(mAuxS1, "NOV", "11")
                        mAuxS1 = Replace(mAuxS1, "DEC", "12")
                        If Val(Columnas(3)) = 100 And IsDate(mAuxS1) Then
                            With oProv.Registro
                                .Fields("RetenerSUSS").Value = "EX"
                                .Fields("SUSSFechaCaducidadExencion").Value = CDate(mAuxS1)
                                .Fields("IdImpuestoDirectoSUSS").Value = Nothing
                            End With
                            oAp.Tarea("LogImpuestos_A", New Object() {mFechaLog, "SUSS", oRs.Fields(0).Value, _
                                                             -1, Nothing, Nothing, -1, Nothing, -1, _
                                                             oProv.Registro.Fields("SUSSFechaCaducidadExencion").Value})
                            oProv.Guardar()
                        End If
                        '               End If
                    End If
                    oRs.Close()
                End If

            ElseIf mCodigo = 6 Then
                If Len(Filas(i)) < 30 Then
                    MsgBox("Archivo invalido", vbExclamation)
                    GoTo Salida
                End If
                mAux1 = Mid(Trim(Filas(i)), 7, 2) & "/" & Mid(Trim(Filas(i)), 5, 2) & "/" & Mid(Trim(Filas(i)), 1, 4) & _
                         " Rentas Bs.As."
                mAux2 = Val(Mid(Trim(Filas(i)), 20, 13)) / 100
                mCuit = Mid(Trim(Filas(i)), 9, 2) & "-" & Mid(Trim(Filas(i)), 11, 8) & "-" & Mid(Trim(Filas(i)), 19, 1)
                oRs = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)
                If oRs.RecordCount > 0 Then
                    oProv = oAp.Proveedores.Item(oRs.Fields(0).Value)
                    With oProv.Registro
                        .Fields("SujetoEmbargado").Value = "SI"
                        .Fields("SaldoEmbargo").Value = mAux2
                        .Fields("DetalleEmbargo").Value = mAux1
                    End With
                    oProv.Guardar()
                End If
                oRs.Close()

            ElseIf mCodigo = 7 Then
                Columnas = Split(Filas(i), ";")
                If UBound(Columnas) < 6 Then
                    MsgBox("Archivo invalido", vbExclamation)
                    GoTo Salida
                End If

                mAuxS1 = Mid(Trim(Columnas(1)), 1, 2) & "/" & Mid(Trim(Columnas(1)), 3, 2) & "/" & Mid(Trim(Columnas(1)), 5, 4)
                mAuxS2 = Mid(Trim(Columnas(2)), 1, 2) & "/" & Mid(Trim(Columnas(2)), 3, 2) & "/" & Mid(Trim(Columnas(2)), 5, 4)
                mAuxS3 = Replace(Columnas(8), ",", ".")
                mAuxS4 = Replace(Columnas(7), ",", ".")

                If IsDate(mAuxS1) And IsDate(mAuxS2) And IsNumeric(mAuxS3) Then
                    If mPrimero Then
                        mPrimero = False
                        mFechaLog = Now
                        oAp.Tarea("Proveedores_EstadoInicialImpositivo", New Object() {mFechaLog, "IIBB"})
                    End If
                    mCuit = Mid(Trim(Columnas(3)), 1, 2) & "-" & Mid(Trim(Columnas(3)), 3, 8) & "-" & Mid(Trim(Columnas(3)), 11, 1)
                    If oRsAux1.RecordCount > 0 Then
                        oRsAux1.MoveFirst()
                        oRsAux1.Find("Cuit = " & mCuit)
                        If Not oRsAux1.EOF Then
                            oAp.Tarea("Proveedores_ActualizarDatosIIBB", _
                                  New Object() {oRsAux1.Fields(0).Value, Val(mAuxS3), CDate(mAuxS1), CDate(mAuxS2), CInt(Columnas(10))})
                            oAp.Tarea("LogImpuestos_A", New Object() {mFechaLog, "IIBB", oRsAux1.Fields(0).Value, _
                                                             -1, Nothing, Nothing, -1, Nothing, -1, Nothing, _
                                                             Val(mAuxS3), CDate(mAuxS1), CDate(mAuxS2), CInt(Columnas(10))})

                        End If
                    End If

                    If oRsAux2.RecordCount > 0 Then
                        oRsAux2.MoveFirst()
                        oRsAux2.Find("Cuit = " & mCuit)
                        If Not oRsAux2.EOF Then
                            oAp.Tarea("Clientes_ActualizarDatosIIBB", _
                                  New Object() {oRsAux2.Fields(0).Value, Val(mAuxS4), CDate(mAuxS1), CDate(mAuxS2), CInt(Columnas(9))})
                            oAp.Tarea("LogImpuestos_A", New Object() {mFechaLog, "IIBB", -1, _
                                                             -1, Nothing, Nothing, -1, Nothing, -1, Nothing, _
                                                             Val(mAuxS4), CDate(mAuxS1), CDate(mAuxS2), CInt(Columnas(9)), _
                                                             oRsAux2.Fields(0).Value})

                        End If
                    End If
                End If

            ElseIf mCodigo = 8 Then
                '//////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////
                ' CAE   'http://robirosa.wikispaces.com/Factura+Electronica+RECE
                '//////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////

                If Len(Filas(i)) < 30 Then
                    MsgBox("Archivo invalido", vbExclamation)
                    GoTo Salida
                End If
                If Mid(Trim(Filas(i)), 1, 1) = "2" Then
                    mAuxS1 = Mid(Trim(Filas(i)), 10, 2)
                    Select Case mAuxS1
                        Case "01"
                            mAuxS2 = "A"
                        Case "06"
                            mAuxS2 = "B"
                        Case "11"
                            mAuxS2 = "C"
                        Case "19"
                            mAuxS2 = "E"
                        Case Else
                            mAuxS2 = "A"
                    End Select
                    mAuxL1 = CLng(Mid(Trim(Filas(i)), 12, 4))
                    mAuxL2 = CLng(Mid(Trim(Filas(i)), 16, 8))
                    mAuxL3 = CLng(Mid(Trim(Filas(i)), 24, 8))
                    For X = mAuxL2 To mAuxL3
                        oRs = oAp.Facturas.TraerFiltrado("_PorNumeroComprobante", New Object() {mAuxS2.ToString, mAuxL1.ToString, X.ToString})
                        If oRs.RecordCount > 0 Then
                            If Mid(Trim(Filas(i)), 1, 1) = "2" Then
                                mAuxS3 = Mid(Trim(Filas(i)), 136, 14)
                                mAuxD1 = CDate(Mid(Trim(Filas(i)), 156, 2) & "/" & Mid(Trim(Filas(i)), 154, 2) & "/" & Mid(Trim(Filas(i)), 150, 4))
                                oAp.Tarea("Facturas_ActualizarDatosCAE", New Object() {oRs.Fields(0).Value, mAuxS3, Nothing, mAuxD1})
                            ElseIf Mid(Trim(Filas(i)), 1, 1) = "4" Then
                                mAuxS3 = Mid(Trim(Filas(i)), 144, 11)
                                mAuxD1 = CDate(Mid(Trim(Filas(i)), 142, 2) & "/" & Mid(Trim(Filas(i)), 140, 2) & "/" & Mid(Trim(Filas(i)), 136, 4))
                                oAp.Tarea("Facturas_ActualizarDatosCAE", New Object() {oRs.Fields(0).Value, Nothing, mAuxS3, mAuxD1})
                            End If
                        End If
                        oRs.Close()
                    Next
                End If

            End If
        Next

Salida:

        On Error Resume Next

        'Unload oF
        'Set oF = Nothing
        'Unload(of1)
        'of1 = Nothing

        If mCodigo = 7 Then
            oRsAux1.Close()
            oRsAux2.Close()
        End If

        oRs = Nothing
        oRsAux1 = Nothing
        oRsAux2 = Nothing
        oProv = Nothing
        oCli = Nothing
        oAp = Nothing

        If mPrimero Then
            Return "Se ha completado el proceso sin ningun registro procesado."
        Else
            Return "Se ha completado el proceso de importación."
        End If


        Exit Function

Mal:

        Return "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description
        Resume Salida

    End Function


    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////TEST          /////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    '    Sub ImportarHumedadesWilliams(ByVal SC As String)
    '        Dim DOCPATH As String
    '        Dim INIRENGLON As Long
    '        Dim FINRENGLON As Long
    '        Dim CurrentRow As Long

    '        Dim oArt 'As ComPronto.Articulo 
    '        Dim Aplicacion = CrearAppCompronto(SC)

    '        DOCPATH = "c:\prontoweb\doc\williams\tablas\humedad rejunte.xls"
    '        INIRENGLON = 4
    '        FINRENGLON = 301

    '        'K_UN1 = BuscaIdUnidad("Unidad")

    '        'Hacer funcion que descule cual es el campo que tira errores



    '        Dim oXL As Application
    '        Dim oWB As Workbook
    '        Dim wh As Worksheet
    '        Dim oRng As Range
    '        Dim oWBs As Workbooks

    '        '  creat a Application object
    '        oXL = New ApplicationClass()
    '        '   get   WorkBook  object
    '        oWBs = oXL.Workbooks
    '        oWB = oWBs.Open(DOCPATH, Missing.Value, Missing.Value, _
    'Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    'Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    'Missing.Value, Missing.Value)

    '        '   get   WorkSheet object
    '        wh = CType(oWB.Sheets(1),  _
    '        Microsoft.Office.Interop.Excel.Worksheet)
    '        Dim dt As New System.Data.DataTable("dtExcel")




    '        CurrentRow = INIRENGLON
    '        'While wh.Cells(CurrentRow, 1) <> "FIN"
    '        While CurrentRow < FINRENGLON

    '            Debug.Print(CurrentRow, f(wh.Cells(CurrentRow, "F")))
    '            If f(wh.Cells(CurrentRow, "B")) <> "" Then


    '                '///////////////////////////////////////////////////////////////

    '                EntidadManager.ExecDinamico(SC, String.Format("INSERT INTO CDPHumedades (IdArticulo,Humedad,Merma) VALUES ('{0}','{1}','{2}')", _
    '                                                            f(wh.Cells(CurrentRow, "B")), _
    '                                                            f(wh.Cells(CurrentRow, "C")), _
    '                                                            f(wh.Cells(CurrentRow, "D")) _
    '                                                            ))


    '            End If


    '            CurrentRow = CurrentRow + 1
    '            'txtROW = CurrentRow
    '            'If CurrentRow Mod 1000 = 0 Then DoEvents()
    '        End While

    '    End Sub


    '    Sub ImportarChoferesWilliams(ByVal SC As String)
    '        Dim DOCPATH As String
    '        Dim INIRENGLON As Long
    '        Dim FINRENGLON As Long
    '        Dim CurrentRow As Long

    '        Dim oArt 'As ComPronto.Articulo 
    '        Dim Aplicacion = CrearAppCompronto(SC)

    '        DOCPATH = "c:\prontoweb\doc\williams\tablas\choferes.xls"
    '        INIRENGLON = 4
    '        FINRENGLON = 4521

    '        'K_UN1 = BuscaIdUnidad("Unidad")

    '        'Hacer funcion que descule cual es el campo que tira errores



    '        Dim oXL As Application
    '        Dim oWB As Workbook
    '        Dim wh As Worksheet
    '        Dim oRng As Range
    '        Dim oWBs As Workbooks

    '        '  creat a Application object
    '        oXL = New ApplicationClass()
    '        '   get   WorkBook  object
    '        oWBs = oXL.Workbooks
    '        oWB = oWBs.Open(DOCPATH, Missing.Value, Missing.Value, _
    'Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    'Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    'Missing.Value, Missing.Value)

    '        '   get   WorkSheet object
    '        wh = CType(oWB.Sheets(1),  _
    '        Microsoft.Office.Interop.Excel.Worksheet)
    '        Dim dt As New System.Data.DataTable("dtExcel")




    '        CurrentRow = INIRENGLON
    '        'While wh.Cells(CurrentRow, 1) <> "FIN"
    '        While CurrentRow < FINRENGLON

    '            Debug.Print(CurrentRow, f(wh.Cells(CurrentRow, "F")))
    '            If f(wh.Cells(CurrentRow, "B")) <> "" Then


    '                '///////////////////////////////////////////////////////////////

    '                EntidadManager.ExecDinamico(SC, String.Format("INSERT INTO Choferes (Nombre,CUIL) VALUES ('{0}','{1}')", _
    '                                                            f(wh.Cells(CurrentRow, "C")), _
    '                                                            f(wh.Cells(CurrentRow, "A")) & "-" & f(wh.Cells(CurrentRow, "B")).ToString.PadLeft(9, "0") _
    '                                                            ))




    '                '///////////////////////////////////////////////////////////////////
    '                '///////////////////////////////////////////////////////////////////
    '                'Creacion de Articulo
    '                '///////////////////////////////////////////////////////////////////
    '                '///////////////////////////////////////////////////////////////////
    '                'If BuscaIdArticuloNET(f(wh.Cells(CurrentRow, "B")), sc) = -1 Then
    '                '    oArt = Aplicacion.Articulos.Item(-1)
    '                '    With oArt
    '                '        With .Registro
    '                '            .Fields("Codigo").Value = f(wh.Cells(CurrentRow, "A"))
    '                '            '.Fields("Idtipo").Value = 13
    '                '            .Fields("Descripcion").Value = f(wh.Cells(CurrentRow, "B"))
    '                '            .Fields("AuxiliarString1").Value = f(wh.Cells(CurrentRow, "C"))
    '                '            .Fields("AuxiliarString2").Value = f(wh.Cells(CurrentRow, "D"))
    '                '            .Fields("IdRubro").Value = 2
    '                '            .Fields("IdSubRubro").Value = 1
    '                '        End With
    '                '        .Guardar()
    '                '    End With
    '                '    oArt = Nothing
    '                'Else
    '                '    'Stop
    '                'End If
    '                '///////////////////////////////////////////////////////////////////
    '                '///////////////////////////////////////////////////////////////////
    '            Else
    '                'Stop
    '            End If



    '            CurrentRow = CurrentRow + 1
    '            'txtROW = CurrentRow
    '            'If CurrentRow Mod 1000 = 0 Then DoEvents()
    '        End While

    '    End Sub


    'Sub TestSolicitudes(ByVal SC As String, ByRef Session As Object)

    '    Dim Aplicacion = CrearAppCompronto(SC)
    '    Dim oArt 'As ComPronto.Articulo 

    '    Dim myProveedor As New Pronto.ERP.BO.Proveedor
    '    Dim myPresupuesto As New Pronto.ERP.BO.Presupuesto
    '    Dim myDetPR As New Pronto.ERP.BO.PresupuestoItem
    '    Dim drParam As System.Data.DataRow

    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'creo un proveedor
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////

    '    If BuscaIdProveedorNET(P1, SC) = -1 Then
    '        myProveedor = New Pronto.ERP.BO.Proveedor
    '    Else
    '        myProveedor = ProveedorManager.GetItem(SC, BuscaIdProveedorNET(P1, SC))
    '    End If

    '    With myProveedor
    '        .Confirmado = "SI"
    '        .RazonSocial = P1
    '        .Cuit = P1CUIT
    '        .EnviarEmail = 1

    '        'If mLetra = ""B"" Or mLetra = ""C"" Then
    '        .IdCodigoIva = 0
    '        'mIdCodigoIva = 0
    '        'Else
    '        'mIdCodigoIva = 1
    '        'End If
    '        .Eventual = "NO"

    '        .IdCondicionCompra = 1
    '        .Eventual = "NO"

    '        Dim myContacto As New Pronto.ERP.BO.ProveedorContacto
    '        With myContacto
    '            .Contacto = "xx"
    '            .Email = "mscalella911@gmail.com"
    '        End With
    '        myProveedor.DetallesContactos.Add(myContacto)



    '    End With
    '    ProveedorManager.Save(SC, myProveedor)
    '    myProveedor = Nothing

    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'creo un proveedor
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////

    '    If BuscaIdProveedorNET(P2, SC) = -1 Then
    '        myProveedor = New Pronto.ERP.BO.Proveedor
    '    Else
    '        myProveedor = ProveedorManager.GetItem(SC, BuscaIdProveedorNET(P2, SC))
    '    End If

    '    If BuscaIdProveedorNET(P2, SC) = -1 Then
    '        With myProveedor
    '            .Confirmado = "SI"
    '            .RazonSocial = P2
    '            .Cuit = P2CUIT
    '            .EnviarEmail = 1
    '            'If mLetra = ""B"" Or mLetra = ""C"" Then
    '            .IdCodigoIva = 0
    '            'mIdCodigoIva = 0
    '            'Else
    '            'mIdCodigoIva = 1
    '            'End If
    '            .Eventual = "NO"

    '            .IdCondicionCompra = 1


    '            Dim myContacto As New Pronto.ERP.BO.ProveedorContacto
    '            With myContacto
    '                .Contacto = "xx"
    '                .Email = "mscalella911@gmail.com"
    '            End With
    '            myProveedor.DetallesContactos.Add(myContacto)



    '        End With
    '        ProveedorManager.Save(SC, myProveedor)
    '    End If
    '    myProveedor = Nothing
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'creo un proveedor
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////


    '    If BuscaIdProveedorNET(P3, SC) = -1 Then
    '        myProveedor = New Pronto.ERP.BO.Proveedor
    '    Else
    '        myProveedor = ProveedorManager.GetItem(SC, BuscaIdProveedorNET(P3, SC))
    '    End If

    '    With myProveedor
    '        .Confirmado = "SI"
    '        .RazonSocial = P3
    '        .Cuit = P3CUIT
    '        .EnviarEmail = 1
    '        'If mLetra = ""B"" Or mLetra = ""C"" Then
    '        .IdCodigoIva = 0
    '        'mIdCodigoIva = 0
    '        'Else
    '        'mIdCodigoIva = 1
    '        'End If
    '        .Eventual = "NO"

    '        .IdCondicionCompra = 1


    '        Dim myContacto As New Pronto.ERP.BO.ProveedorContacto
    '        With myContacto
    '            .Contacto = "xx"
    '            .Email = "mscalella911@gmail.com"
    '        End With
    '        myProveedor.DetallesContactos.Add(myContacto)



    '    End With
    '    ProveedorManager.Save(SC, myProveedor)
    '    myProveedor = Nothing

    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'ARTICULOS
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'Agrego el artículo que necesito para el script

    '    If BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado") = -1 Then
    '        oArt = Aplicacion.Articulos.Item(-1)
    '        With oArt
    '            With .Registro
    '                .Fields("descripcion").Value = "Light 1/15 A002 Crudo B Vaporizado"
    '                .Fields("Codigo").Value = "LA0021/15"
    '                .Fields("IdRubro").Value = 1
    '                .Fields("IdSubRubro").Value = 1
    '            End With
    '            .Guardar()
    '        End With
    '        oArt = Nothing
    '    End If

    '    '//////////////////////////////////////////////////////////////////

    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'ARTICULOS
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'Agrego el artículo que necesito para el script

    '    If BuscaIdArticulo("Cashmere X4") = -1 Then
    '        oArt = Aplicacion.Articulos.Item(-1)
    '        With oArt
    '            With .Registro
    '                .Fields("descripcion").Value = "Cashmere X4"
    '                .Fields("Codigo").Value = "CX4"
    '                .Fields("IdRubro").Value = 1
    '                .Fields("IdSubRubro").Value = 1
    '            End With
    '            .Guardar()
    '        End With
    '        oArt = Nothing
    '    End If

    '    '//////////////////////////////////////////////////////////////////





    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'crear tres usuarios para esos proveedores
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////


    '    'DDLUser.Items.Clear()
    '    'Dim membershipUserCollection As MembershipUserCollection
    '    'membershipUserCollection = Membership.GetAllUsers()
    '    'Dim li As ListItem
    '    'For Each user As MembershipUser In membershipUserCollection
    '    '    li = New ListItem
    '    '    li.Text = user.UserName
    '    '    li.Value = user.ProviderUserKey.ToString
    '    '    If Not Page.PreviousPage Is Nothing Then
    '    '        If Not (PreviousPage.UserName Is Nothing) Then
    '    '            If (li.Text = PreviousPage.UserName) Then
    '    '                li.Selected = True
    '    '            End If
    '    '        End If
    '    '    End If
    '    '    DDLUser.Items.Add(li)
    '    'Next

    '    'membershipUserCollection.Add(
    '    'membershipUserCollection


    '    'EmpresaManager.AddUserInCompanies(SC, DDLUser.SelectedValue, DDLEmpresas.SelectedItem.Value)

    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////









    '    '//////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////
    '    'Configuro los mails de los proveedores y del comprador
    '    '//////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////





    '    '//////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////
    '    'Creo 3 Solicitudes (los mails los mando manualmente desde pronto)
    '    '//////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////


    '    '//////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////
    '    myPresupuesto = New Pronto.ERP.BO.Presupuesto
    '    With myPresupuesto

    '        'traigo parámetros generales
    '        drParam = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
    '        '.IdMoneda = drParam.Item("ProximoPresupuestoReferencia").ToString 'mIdMonedaPesos

    '        .Numero = drParam.Item("ProximoPresupuesto").ToString
    '        .SubNumero = 1

    '        .IdMoneda = 1

    '        .CotizacionMoneda = 1
    '        .FechaIngreso = Now
    '        .FechaAprobacion = Now
    '        .FechaCierreCompulsa = DateAdd(DateInterval.Weekday, 1, Now)
    '        .IdCondicionCompra = 1

    '        .Detalle = "Esta solicitud fue creada para Demo de Web"
    '        .DetalleCondicionCompra = "Máximo 10 días"


    '        .Observaciones = "Solicitud para Demo de Web"

    '        .ArchivoAdjunto1 = "Adjunto.rar"

    '        .IdProveedor = BuscaIdProveedorNET(P1, SC)

    '        .ConfirmadoPorWeb = "NO"
    '        .IdComprador = 3 'IdUsuarioEnProntoVB6()



    '        myDetPR = New Pronto.ERP.BO.PresupuestoItem
    '        With myDetPR
    '            .IdArticulo = BuscaIdArticuloNET("Light 1/15 A002 Crudo B Vaporizado", SC)

    '            .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)

    '            .Cantidad = 30
    '            '.Precio = 1.41
    '            '.PorcentajeBonificacion = 0
    '            '.PorcentajeIVA = 21
    '        End With
    '        .Detalles.Add(myDetPR)

    '        myDetPR = New Pronto.ERP.BO.PresupuestoItem
    '        With myDetPR
    '            .IdArticulo = BuscaIdArticuloNET("Cashmere X4", SC)

    '            .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)

    '            .Cantidad = 65
    '            '.Precio = 3.48 'no tengo que poner el precio!
    '            '.PorcentajeBonificacion = 0
    '            '.PorcentajeIVA = 21
    '        End With
    '        .Detalles.Add(myDetPR)
    '        myDetPR = Nothing


    '    End With

    '    PresupuestoManager.Save(SC, myPresupuesto)
    '    myPresupuesto = Nothing

    '    '//////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////
    '    myPresupuesto = New Pronto.ERP.BO.Presupuesto
    '    With myPresupuesto

    '        'traigo parámetros generales
    '        drParam = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
    '        '.IdMoneda = drParam.Item("ProximoPresupuestoReferencia").ToString 'mIdMonedaPesos

    '        .Numero = drParam.Item("ProximoPresupuesto").ToString
    '        .SubNumero = 2

    '        .IdMoneda = 1

    '        .CotizacionMoneda = 1
    '        .FechaIngreso = Now
    '        .FechaAprobacion = Now
    '        .FechaCierreCompulsa = DateAdd(DateInterval.Weekday, 1, Now)
    '        .IdCondicionCompra = 1

    '        .Detalle = "Esta solicitud fue creada para Demo de Web"
    '        .DetalleCondicionCompra = "Máximo 10 días"


    '        .Observaciones = "Solicitud para Demo de Web"

    '        .ArchivoAdjunto1 = "Adjunto.rar"

    '        .IdProveedor = BuscaIdProveedorNET(P2, SC)
    '        .IdComprador = 3
    '        .ConfirmadoPorWeb = "NO"


    '        myDetPR = New Pronto.ERP.BO.PresupuestoItem
    '        With myDetPR
    '            .IdArticulo = BuscaIdArticuloNET("Light 1/15 A002 Crudo B Vaporizado", SC)

    '            .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)

    '            .Cantidad = 30
    '            '.Precio = 1.41
    '            .PorcentajeBonificacion = 0
    '            .PorcentajeIVA = 21
    '        End With
    '        .Detalles.Add(myDetPR)

    '        myDetPR = New Pronto.ERP.BO.PresupuestoItem
    '        With myDetPR
    '            .IdArticulo = BuscaIdArticuloNET("Cashmere X4", SC)

    '            .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)

    '            .Cantidad = 65
    '            '.Precio = 3.48
    '            .PorcentajeBonificacion = 0
    '            .PorcentajeIVA = 21
    '        End With
    '        .Detalles.Add(myDetPR)
    '        myDetPR = Nothing


    '    End With

    '    PresupuestoManager.Save(SC, myPresupuesto)
    '    myPresupuesto = Nothing


    '    '//////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////
    '    myPresupuesto = New Pronto.ERP.BO.Presupuesto
    '    With myPresupuesto

    '        'traigo parámetros generales
    '        drParam = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
    '        '.IdMoneda = drParam.Item("ProximoPresupuestoReferencia").ToString 'mIdMonedaPesos

    '        .Numero = drParam.Item("ProximoPresupuesto").ToString
    '        .SubNumero = 3

    '        .IdMoneda = 1

    '        .CotizacionMoneda = 1
    '        .FechaIngreso = Now
    '        .FechaAprobacion = Now
    '        .FechaCierreCompulsa = DateAdd(DateInterval.Weekday, 1, Now)
    '        .IdCondicionCompra = 1

    '        .Detalle = "Esta solicitud fue creada para Demo de Web"
    '        .DetalleCondicionCompra = "Máximo 10 días"

    '        .IdComprador = 3
    '        .Observaciones = "Solicitud para Demo de Web"

    '        .ArchivoAdjunto1 = "Adjunto.rar"

    '        .IdProveedor = BuscaIdProveedorNET(P3, SC)

    '        .ConfirmadoPorWeb = "NO"


    '        myDetPR = New Pronto.ERP.BO.PresupuestoItem
    '        With myDetPR
    '            .IdArticulo = BuscaIdArticuloNET("Light 1/15 A002 Crudo B Vaporizado", SC)

    '            .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)

    '            .Cantidad = 30
    '            '.Precio = 1.41
    '            .PorcentajeBonificacion = 0
    '            .PorcentajeIVA = 21
    '        End With
    '        .Detalles.Add(myDetPR)
    '        myDetPR = Nothing

    '        myDetPR = New Pronto.ERP.BO.PresupuestoItem
    '        With myDetPR
    '            .IdArticulo = BuscaIdArticuloNET("Cashmere X4", SC)

    '            .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)

    '            .Cantidad = 65
    '            '.Precio = 3.48
    '            .PorcentajeBonificacion = 0
    '            .PorcentajeIVA = 21
    '        End With
    '        .Detalles.Add(myDetPR)
    '        myDetPR = Nothing


    '    End With

    '    PresupuestoManager.Save(SC, myPresupuesto)
    '    myPresupuesto = Nothing




    '    ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, "ProximoPresupuesto", drParam.Item("ProximoPresupuesto") + 1)


    'End Sub


    '    Sub ImportarTransportistasWilliams(ByVal SC As String)

    '        Dim DOCPATH As String
    '        Dim INIRENGLON As Long
    '        Dim FINRENGLON As Long
    '        Dim CurrentRow As Long

    '        Dim oArt 'As ComPronto.Articulo 
    '        Dim Aplicacion = CrearAppCompronto(SC)

    '        DOCPATH = "c:\prontoweb\doc\williams\tablas\transportistas.xls"
    '        INIRENGLON = 4
    '        FINRENGLON = 2064

    '        'K_UN1 = BuscaIdUnidad("Unidad")

    '        'Hacer funcion que descule cual es el campo que tira errores



    '        Dim oXL As Application
    '        Dim oWB As Workbook
    '        Dim wh As Worksheet
    '        Dim oRng As Range
    '        Dim oWBs As Workbooks

    '        '  creat a Application object
    '        oXL = New ApplicationClass()
    '        '   get   WorkBook  object
    '        oWBs = oXL.Workbooks
    '        oWB = oWBs.Open(DOCPATH, Missing.Value, Missing.Value, _
    'Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    'Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    'Missing.Value, Missing.Value)

    '        '   get   WorkSheet object
    '        wh = CType(oWB.Sheets(1),  _
    '        Microsoft.Office.Interop.Excel.Worksheet)
    '        Dim dt As New System.Data.DataTable("dtExcel")




    '        CurrentRow = INIRENGLON
    '        'While wh.Cells(CurrentRow, 1) <> "FIN"
    '        While CurrentRow < FINRENGLON

    '            Debug.Print(CurrentRow, f(wh.Cells(CurrentRow, "F")))
    '            If f(wh.Cells(CurrentRow, "B")) <> "" Then


    '                '///////////////////////////////////////////////////////////////

    '                EntidadManager.ExecDinamico(SC, String.Format("INSERT INTO Transportistas (RazonSocial,CUIT,Direccion,CodigoPostal,Fax) VALUES ('{0}','{1}','{2}','{3}','{4}')", _
    '                                                            f(wh.Cells(CurrentRow, "C")), _
    '                                                            f(wh.Cells(CurrentRow, "A")) & "-" & f(wh.Cells(CurrentRow, "B")).ToString.PadLeft(9, "0"), _
    '                                                            f(wh.Cells(CurrentRow, "D")), _
    '                                                            f(wh.Cells(CurrentRow, "E")), _
    '                                                            f(wh.Cells(CurrentRow, "F")) _
    '                                                            ))


    '            End If


    '            CurrentRow = CurrentRow + 1
    '            'txtROW = CurrentRow
    '            'If CurrentRow Mod 1000 = 0 Then DoEvents()
    '        End While

    '    End Sub

    '    Sub ImportarCalidadesWilliams(ByVal SC As String)
    '        Dim DOCPATH As String
    '        Dim INIRENGLON As Long
    '        Dim FINRENGLON As Long
    '        Dim CurrentRow As Long

    '        Dim oArt 'As ComPronto.Articulo 
    '        Dim Aplicacion = CrearAppCompronto(SC)

    '        DOCPATH = "c:\prontoweb\doc\williams\tablas\calidad.xls"
    '        INIRENGLON = 5
    '        FINRENGLON = 103

    '        'K_UN1 = BuscaIdUnidad("Unidad")

    '        'Hacer funcion que descule cual es el campo que tira errores



    '        Dim oXL As Application
    '        Dim oWB As Workbook
    '        Dim wh As Worksheet
    '        Dim oRng As Range
    '        Dim oWBs As Workbooks

    '        '  creat a Application object
    '        oXL = New ApplicationClass()
    '        '   get   WorkBook  object
    '        oWBs = oXL.Workbooks
    '        oWB = oWBs.Open(DOCPATH, Missing.Value, Missing.Value, _
    'Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    'Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    'Missing.Value, Missing.Value)

    '        '   get   WorkSheet object
    '        wh = CType(oWB.Sheets(1),  _
    '        Microsoft.Office.Interop.Excel.Worksheet)
    '        Dim dt As New System.Data.DataTable("dtExcel")




    '        CurrentRow = INIRENGLON
    '        'While wh.Cells(CurrentRow, 1) <> "FIN"
    '        While CurrentRow < FINRENGLON

    '            Debug.Print(CurrentRow, f(wh.Cells(CurrentRow, "F")))
    '            If f(wh.Cells(CurrentRow, "B")) <> "" Then


    '                '///////////////////////////////////////////////////////////////

    '                EntidadManager.ExecDinamico(SC, String.Format("INSERT INTO Calidades (Descripcion) VALUES ('{0}')", _
    '                                                            f(wh.Cells(CurrentRow, "C")) _
    '                                                            ))


    '            End If


    '            CurrentRow = CurrentRow + 1
    '            'txtROW = CurrentRow
    '            'If CurrentRow Mod 1000 = 0 Then DoEvents()
    '        End While
    '    End Sub




    'Public Sub Firmas(ByVal SC As String, ByRef Session As Object)
    '    'a traves del bus creo una solicitud
    '    Dim myPedido As New Pronto.ERP.BO.Pedido
    '    Dim myRM As New Pronto.ERP.BO.Requerimiento

    '    Dim Aplicacion = CrearAppCompronto(SC)
    '    Dim oAut ''As ComPronto.Autorizacion  
    '    Dim DetAut ''As ComPronto.DetAutorizacion  

    '    Dim oOP ''As ComPronto.OrdenPago  
    '    Dim DetOP ''As ComPronto.DetOrdenPago  


    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'creo un proveedor
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////

    '    Dim myProveedor As Pronto.ERP.BO.Proveedor
    '    If BuscaIdProveedorNET(P1, SC) = -1 Then
    '        myProveedor = New Pronto.ERP.BO.Proveedor
    '    Else
    '        myProveedor = ProveedorManager.GetItem(SC, BuscaIdProveedorNET(P1, SC))
    '    End If

    '    With myProveedor
    '        .Confirmado = "SI"
    '        .RazonSocial = P1
    '        .Cuit = P1CUIT
    '        .EnviarEmail = 1
    '        'If mLetra = ""B"" Or mLetra = ""C"" Then
    '        .IdCodigoIva = 0
    '        'mIdCodigoIva = 0
    '        'Else
    '        'mIdCodigoIva = 1
    '        'End If

    '        .IdCondicionCompra = 1


    '        Dim myContacto As New Pronto.ERP.BO.ProveedorContacto
    '        With myContacto
    '            .Contacto = "xx"
    '            .Email = "mscalella911@gmail.com"
    '        End With
    '        myProveedor.DetallesContactos.Add(myContacto)



    '    End With
    '    ProveedorManager.Save(SC, myProveedor)



    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'dar de alta cotizacion en dolar y en euros
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////

    '    Dim oCot ''As ComPronto.Cotizacion  

    '    oCot = Aplicacion.Cotizaciones.Item(-1)
    '    With oCot
    '        With .Registro
    '            .Fields("Moneda").Value = 2 'dolar
    '            .Fields("Cotizacion").Value = 3
    '        End With
    '        .Guardar()
    '    End With
    '    oCot = Nothing

    '    oCot = Aplicacion.Cotizaciones.Item(-1)
    '    With oCot
    '        With .Registro
    '            .Fields("Moneda").Value = 3 'euro
    '            .Fields("Cotizacion").Value = 4
    '        End With
    '        .Guardar()
    '    End With
    '    oCot = Nothing


    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'ARTICULOS
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'Agrego el artículo que necesito para el script

    '    Dim oArt ''As ComPronto.Articulo  
    '    oArt = Aplicacion.Articulos.Item(BuscaIdArticulo(A1)) 'si es -1, lo da de alta :)
    '    With oArt
    '        With .Registro
    '            .Fields("descripcion").Value = A1
    '            .Fields("Codigo").Value = "LA0021/15"
    '            .Fields("IdRubro").Value = 1
    '            .Fields("IdSubRubro").Value = 1
    '        End With
    '        .Guardar()
    '    End With
    '    oArt = Nothing



    '    '///////////////////////////////////////////////
    '    '///////////////////////////////////////////////
    '    'Autorizacion - Alta (por COMPronto)
    '    'doy de alta una autorizacion para RM
    '    '///////////////////////////////////////////////
    '    '///////////////////////////////////////////////



    '    'pero tenés que verificar que el usuario que te interesa quede primero para firmar, y 
    '    'generalmente ya hay otros en el sector.


    '    oAut = Aplicacion.Autorizaciones.Item(-1)

    '    With oAut.Registro
    '        .Fields("IdFormulario").Value = 3 '3 es el de RMs
    '    End With

    '    DetAut = oAut.DetAutorizaciones.Item(-1)
    '    With DetAut.Registro
    '        .Fields("OrdenAutorizacion").Value = 1
    '        .Fields("SectorEmisor1").Value = "S"
    '        .Fields("IdCargoAutoriza1").Value = 5 'Jefe (depende de la base)
    '        .Fields("SectorEmisor2").Value = "V"
    '        .Fields("SectorEmisor3").Value = "V"
    '        .Fields("SectorEmisor4").Value = "V"
    '        .Fields("SectorEmisor5").Value = "V"
    '        .Fields("SectorEmisor6").Value = "V"
    '        .Fields("ImporteDesde1").Value = 0
    '        .Fields("ImporteHasta1").Value = 9999999
    '    End With
    '    DetAut.Modificado = True

    '    oAut.Guardar()
    '    oAut = Nothing

    '    '///////////////////////////////////////////////
    '    '///////////////////////////////////////////////
    '    'Autorizacion - Alta (por COMPronto)
    '    'doy de alta una autorizacion para pedidos
    '    '///////////////////////////////////////////////
    '    '///////////////////////////////////////////////


    '    oAut = Aplicacion.Autorizaciones.Item(-1)

    '    With oAut.Registro
    '        .Fields("IdFormulario").Value = 4 '4 es el de Nota de Pedido
    '    End With

    '    DetAut = oAut.DetAutorizaciones.Item(-1)
    '    With DetAut.Registro
    '        .Fields("IdFirmante1").Value = Session("glbIdUsuario")

    '        .Fields("OrdenAutorizacion").Value = 1
    '        .Fields("SectorEmisor1").Value = "S"
    '        .Fields("SectorEmisor2").Value = "V"
    '        .Fields("SectorEmisor3").Value = "V"
    '        .Fields("SectorEmisor4").Value = "V"
    '        .Fields("SectorEmisor5").Value = "V"
    '        .Fields("SectorEmisor6").Value = "V"
    '        .Fields("ImporteDesde1").Value = 0
    '        .Fields("ImporteHasta1").Value = 9999999
    '    End With
    '    DetAut.Modificado = True

    '    oAut.Guardar()
    '    oAut = Nothing



    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'Creacion de Pedido
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    Dim mN As Long
    '    mN = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximoNumeroPedido").ToString
    '    ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, "ProximoNumeroPedido", (mN + 1).ToString)


    '    With myPedido
    '        .CircuitoFirmasCompleto = "NO"
    '        .IdProveedor = BuscaIdProveedorNET(P1, SC)
    '        '.Cuit = txtCUIT.Text
    '        '.EnviarEmail = 1
    '        '        If mLetra = ""B"" Or mLetra = ""C"" Then
    '        '    mIdCodigoIva = 0
    '        'Else
    '        '    mIdCodigoIva = 1
    '        'End If

    '        '.IdCodigoIva = mIdCodigoIva
    '        '.IdCondicionCompra = cmbCondicionIVA.SelectedValue

    '        .Fecha = Now
    '        .Observaciones = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
    '        .Numero = mN
    '        '!IdCliente = 22

    '        .IdComprador = Session("glbIdUsuario")
    '        .IdMoneda = 1

    '        Dim myDetPD As New Pronto.ERP.BO.PedidoItem
    '        With myDetPD
    '            .IdArticulo = BuscaIdArticuloNET("Protector para cubierta 1000", SC)
    '            .Cantidad = 250
    '            .IdUnidad = BuscaIdUnidadNET("Kilos", SC)
    '            If .IdUnidad = -1 Then .IdUnidad = 1
    '            '!IdColor = 33
    '        End With
    '        .Detalles.Add(myDetPD)



    '    End With
    '    PedidoManager.Save(SC, myPedido)
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////

    '    'nota de pedido por comprontovb6
    '    oOP = Aplicacion.OrdenesPago.Item(-1)

    '    With oOP.Registro
    '        .Fields("IdFormulario").Value = 4 '4 es el de Nota de Pedido
    '    End With

    '    DetOP = oOP.DetOrdenesPago.Item(-1)
    '    With DetOP.Registro
    '        .Fields("IdFirmante1").Value = Session("glbIdUsuario")

    '    End With
    '    DetOP.Modificado = True

    '    oOP.Guardar()
    '    oOP = Nothing

    '    'orden de pago

    '    oOP = Aplicacion.OrdenesPago.Item(-1)

    '    With oOP.Registro
    '        .Fields("IdFormulario").Value = 4 '4 es el de Nota de Pedido
    '    End With

    '    DetOP = oOP.DetOrdenesPago.Item(-1)
    '    With DetOP.Registro
    '        .Fields("IdFirmante1").Value = Session("glbIdUsuario")

    '    End With
    '    DetOP.Modificado = True

    '    oOP.Guardar()
    '    oOP = Nothing



    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'Creacion de RM
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////


    '    mN = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximoNumeroRequerimiento").ToString
    '    'ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, "ProximoNumeroRequerimiento", mN + 1) 'la rm avanza automatica


    '    With myRM
    '        .CircuitoFirmasCompleto = "NO"
    '        '.IdProveedor = BuscaIdProveedor("ACRON SRL")
    '        .Numero = mN
    '        .Fecha = Now
    '        '.IdObra = Null '1 'glbIdObraAsignadaUsuario
    '        '!IdColor =

    '        'En las RMs que se generan, agregar el usuario que libera el comprobante
    '        .Aprobo = Session("glbIdUsuario")
    '        .IdSolicito = Session("glbIdUsuario") ' UsuarioSistema

    '        'que se configure la obra que se pone en las RMs generadas
    '        Try
    '            .IdObra = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("IdObraDefault").ToString
    '        Catch ex As Exception
    '            .IdObra = ObraManager.GetList(SC).Item(1).Id 'agarro la primera que encuentre
    '        End Try


    '        .IdSector = iisNull(Session("glbIdSector"), 0)
    '        .Observaciones = "Generado por ProntowEB"
    '        .IdOrdenTrabajo = Nothing
    '        '.Cuit = txtCUIT.Text
    '        '.EnviarEmail = 1
    '        '        If mLetra = ""B"" Or mLetra = ""C"" Then
    '        '    mIdCodigoIva = 0
    '        'Else
    '        '    mIdCodigoIva = 1
    '        'End If

    '        '.IdCodigoIva = mIdCodigoIva
    '        '.IdCondicionCompra = cmbCondicionIVA.SelectedValue


    '        Dim myDetRM As New Pronto.ERP.BO.RequerimientoItem
    '        With myDetRM
    '            .IdArticulo = BuscaIdArticuloNET("Protector para cubierta 1000", SC)
    '            .Cantidad = 54
    '            .FechaEntrega = Now

    '            'Dim art 'As ComPronto.Articulo 
    '            'art = Aplicacion.Articulos.Item(dc0boundtext) 'dcfields(0).BoundText)
    '            'If IsNull(art.Registro!IdUnidad) Then MsgBox("No está indicado en el maestro de artículos la unidad de " & art.Registro!descripcion)
    '            .IdUnidad = BuscaIdUnidadNET("Kilos", SC)



    '            '.Adjunto = "NO"
    '            .MoP = "M"
    '            .Cantidad1 = 1
    '            .Cantidad2 = 1

    '        End With
    '        .Detalles.Add(myDetRM)


    '    End With
    '    RequerimientoManager.Save(SC, myRM)
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////


    'End Sub


    'Sub TestFondoFijo(ByVal SC As String, ByRef Session As Object)

    '    Dim Aplicacion = CrearAppCompronto(SC)

    '    Dim oOP 'As ComPronto.OrdenPago 
    '    Dim DetOP 'As ComPronto.DetOrdenPago 

    '    Dim myProveedor As Pronto.ERP.BO.Proveedor

    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'creo un proveedor
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////


    '    'que el mail del comprador sea mi msn, así veo cómo me van llegando los emails
    '    'doy de alta un usario para ese comprador?



    '    If BuscaIdProveedorNET(P1, SC) = -1 Then
    '        myProveedor = New Pronto.ERP.BO.Proveedor
    '    Else
    '        myProveedor = ProveedorManager.GetItem(SC, BuscaIdProveedorNET(P1, SC))
    '    End If

    '    With myProveedor
    '        .Confirmado = "SI"
    '        .RazonSocial = P1
    '        .Cuit = P1CUIT
    '        .EnviarEmail = 1
    '        'If mLetra = ""B"" Or mLetra = ""C"" Then
    '        .IdCodigoIva = 0
    '        'mIdCodigoIva = 0
    '        'Else
    '        'mIdCodigoIva = 1
    '        'End If

    '        .IdCondicionCompra = 1


    '        Dim myContacto As New Pronto.ERP.BO.ProveedorContacto
    '        With myContacto
    '            .Contacto = "xx"
    '            .Email = "mscalella911@gmail.com"
    '        End With
    '        myProveedor.DetallesContactos.Add(myContacto)



    '    End With
    '    ProveedorManager.Save(SC, myProveedor)
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////




    '    '//////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////
    '    'Verificar que hay una rendición en curso
    '    '//////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////



    '    '//////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////
    '    'Alta de Orden de Pago para asignar un monto tope a la cuenta de fondo fijo (ver manual)
    '    '//////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////


    '    oOP = Aplicacion.OrdenesPago.Item(-1)

    '    With oOP.Registro
    '        .Fields("opcion fondo fijo").Value = "SI"
    '        .Fields("inic?").Value = "SI"

    '        .Fields("Observaciones").Value = "La op de FF necesita una observacion"


    '    End With


    '    Dim DetOPV 'As ComPronto.DetOrdenPagoValores 
    '    DetOPV = oOP.DetOrdenesPagoValores.Item(-1)
    '    With DetOPV.Registro
    '        .Fields("Cuenta").Value = 1 'buscar("Caja")
    '        .Fields("Monto").Value = 10000

    '    End With
    '    DetOPV.Modificado = True


    '    Dim DetOPrc 'As ComPronto.DetOrdenPagoRubrosContables 
    '    DetOPrc = oOP.DetOrdenesPagoRubrosContables.Item(-1)
    '    With DetOPrc.Registro
    '        .Fields("Cuenta").Value = 1 'buscar("Caja")
    '        .Fields("Monto").Value = 10000 'el mismo monto que puse en valores

    '    End With
    '    DetOPrc.Modificado = True


    '    'esto (el asiento) lo genera automaticamente el form. Lo hace el objeto? Si no, lo tengo que hacer a mano 
    '    Dim DetOPcu 'As ComPronto.DetOrdenPagoCuentas 
    '    DetOPcu = oOP.DetOrdenesPagoCuentas.Item(-1)
    '    With DetOPcu.Registro
    '        .Fields("Cuenta").Value = 1 'buscar("Caja")
    '        .Fields("Monto").Value = 10000 'el mismo monto que puse en valores
    '    End With
    '    DetOPcu.Modificado = True
    '    DetOPcu = oOP.DetOrdenesPagoCuentas.Item(-1)
    '    With DetOPcu.Registro
    '        .Fields("Cuenta").Value = 1 'buscar("cuenta de fondo fijo")
    '        .Fields("Monto").Value = 10000 'el mismo monto que puse en valores
    '    End With
    '    DetOPcu.Modificado = True



    '    oOP.Guardar()
    '    oOP = Nothing



    '    '//////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////
    '    'Alta de Fondo Fijo
    '    '//////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////

    '    Dim myComprobanteProveedor As New Pronto.ERP.BO.ComprobanteProveedor

    '    With myComprobanteProveedor

    '        Dim drParam As System.Data.DataRow = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
    '        .IdMoneda = drParam.Item("ProximoComprobanteProveedorReferencia").ToString 'mIdMonedaPesos
    '        .CotizacionMoneda = 1
    '        .CotizacionDolar = Cotizacion(SC, Now, drParam.Item("IdMonedaDolar")) 'mvarCotizacionDolar
    '        .IdOrdenPago = Nothing
    '        .IdUsuarioIngreso = Session("glbIdUsuario")
    '        .FechaIngreso = Now
    '        .NumeroRendicionFF = 12

    '        .NumeroReferencia = 64
    '        .Letra = "A"
    '        .NumeroComprobante1 = 34
    '        .NumeroComprobante2 = 1
    '        .FechaComprobante = Now
    '        .FechaRecepcion = Now
    '        .FechaVencimiento = Now
    '        .IdTipoComprobante = 1
    '        .IdProveedorEventual = 10


    '        .ConfirmadoPorWeb = "NO"
    '        .IdProveedor = Nothing
    '        .IdCuentaOtros = Nothing

    '        .IdCuenta = 10
    '        .IdObra = 1
    '        .Observaciones = "Creado para Demo Web"
    '        .NumeroCAI = 64679998788

    '        .FechaVencimientoCAI = Nothing

    '        .IdComprobanteImputado = Nothing


    '        .Confirmado = "NO"
    '        '.TotalBruto = 
    '        '.TotalIva1 = 
    '        '.TotalIva2 = 0
    '        '.TotalBonificacion = 0
    '        '.TotalComprobante = 
    '        '.PorcentajeBonificacion = 0
    '        '.TotalIVANoDiscriminado = 0
    '        '.AjusteIVA = 
    '        'If mIncrementarReferencia <> "SI" Then .AutoincrementarNumeroReferencia = "NO"
    '        .AutoincrementarNumeroReferencia = "SI"

    '        .BienesOServicios = "B"
    '        .IdIBCondicion = 1


    '        .IdTipoRetencionGanancia = 1

    '        .IdProvinciaDestino = 1

    '        .DestinoPago = "O"
    '        .InformacionAuxiliar = ""



    '        Dim myDetFF As New Pronto.ERP.BO.ComprobanteProveedorItem
    '        With myDetFF
    '            .Importe = 64.1
    '            .IdObra = 1
    '            .IdCuentaGasto = 12
    '            .CuentaGastoDescripcion = "Cuenta Sarasa"
    '            .IdDetalleObraDestino = Nothing



    '            Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorObraCuentaGasto", .IdObra, .IdCuentaGasto, DBNull.Value)
    '            If ds.Tables(0).Rows.Count > 0 Then
    '                .IdCuenta = ds.Tables(0).Rows(0).Item("IdCuenta").ToString
    '                .CodigoCuenta = ds.Tables(0).Rows(0).Item("Codigo").ToString
    '            Else

    '                ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorCodigo", Mid(.IdCuentaGasto, InStrRev(.IdCuentaGasto, " ") + 1), DBNull.Value)
    '                If ds.Tables(0).Rows.Count > 0 Then
    '                    .IdCuenta = ds.Tables(0).Rows(0).Item("IdCuenta").ToString
    '                    .CodigoCuenta = ds.Tables(0).Rows(0).Item("Codigo").ToString
    '                Else
    '                    Exit Sub
    '                End If
    '            End If




    '            Dim mIdCuentaIvaCompras1 As Long
    '            'Dim drparam As Data.DataRow = Pronto.ERP.Bll.ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
    '            'With drparam
    '            ' mIdCuentaIvaCompras1 = .Item("IdCuentaIvaCompras1")
    '            'End With

    '            .IdCuentaIvaCompras1 = mIdCuentaIvaCompras1
    '            .IVAComprasPorcentaje1 = 21
    '            .ImporteIVA1 = Math.Round(21 / 100 * .Importe, 2)
    '            .AplicarIVA1 = "SI"
    '            .IdCuentaIvaCompras2 = Nothing
    '            .IVAComprasPorcentaje2 = 0
    '            .ImporteIVA2 = 0
    '            .AplicarIVA2 = "NO"
    '            .IdCuentaIvaCompras3 = Nothing
    '            .IVAComprasPorcentaje3 = 0
    '            .ImporteIVA3 = 0
    '            .AplicarIVA3 = "NO"
    '            .IdCuentaIvaCompras4 = Nothing
    '            .IVAComprasPorcentaje4 = 0
    '            .ImporteIVA4 = 0
    '            .AplicarIVA4 = "NO"
    '            .IdCuentaIvaCompras5 = Nothing
    '            .IVAComprasPorcentaje5 = 0
    '            .ImporteIVA5 = 0
    '            .AplicarIVA5 = "NO"
    '            .IdCuentaIvaCompras6 = Nothing
    '            .IVAComprasPorcentaje6 = 0
    '            .ImporteIVA6 = 0
    '            .AplicarIVA6 = "NO"
    '            .IdCuentaIvaCompras7 = Nothing
    '            .IVAComprasPorcentaje7 = 0
    '            .ImporteIVA7 = 0
    '            .AplicarIVA7 = "NO"
    '            .IdCuentaIvaCompras8 = Nothing
    '            .IVAComprasPorcentaje8 = 0
    '            .ImporteIVA8 = 0
    '            .AplicarIVA8 = "NO"
    '            .IdCuentaIvaCompras9 = Nothing
    '            .IVAComprasPorcentaje9 = 0
    '            .ImporteIVA9 = 0
    '            .AplicarIVA9 = "NO"
    '            .IdCuentaIvaCompras10 = Nothing
    '            .IVAComprasPorcentaje10 = 0
    '            .ImporteIVA10 = 0
    '            .AplicarIVA10 = "NO"

    '        End With

    '        .Detalles.Add(myDetFF)


    '        '////////////////////////////////////////////////////
    '        '////////////////////////////////////////////////////
    '        '////////////////////////////////////////////////////

    '    End With


    '    ComprobanteProveedorManager.Save(SC, myComprobanteProveedor)

    'End Sub

    'Sub ImportarLocalidadesWilliams(ByVal SC As String)


    '    Dim DOCPATH As String
    '    Dim INIRENGLON As Long
    '    Dim FINRENGLON As Long
    '    Dim CurrentRow As Long

    '    Dim oArt 'As ComPronto.Articulo 
    '    Dim Aplicacion = CrearAppCompronto(SC)

    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    DOCPATH = "E:\Backup\BDL\ProntoWeb\doc\williams\importacion\loc nueva\Tabla de Localidades NUEVA.xls"
    '    INIRENGLON = 2
    '    FINRENGLON = 52
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////



    '    'K_UN1 = BuscaIdUnidad("Unidad")

    '    'Hacer funcion que descule cual es el campo que tira errores


    '    'Dim vFileName As String = Path.GetTempPath & "SincroDR " & Now.ToString("ddMMMyyyy_HHmmss") & ".csv" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
    '    Dim vFileName As String = "c:\archivo.txt"
    '    FileOpen(1, vFileName, OpenMode.Output)
    '    Dim sb As String = ""
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////

    '    Dim oXL As Application
    '    Dim oWB As Workbook
    '    Dim wh As Worksheet
    '    Dim oRng As Range
    '    Dim oWBs As Workbooks

    '    '  creat a Application object
    '    oXL = New ApplicationClass()
    '    '   get   WorkBook  object
    '    oWBs = oXL.Workbooks
    '    oWB = oWBs.Open(DOCPATH, Missing.Value, Missing.Value, _
    '        Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    '        Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    '        Missing.Value, Missing.Value)

    '    '   get   WorkSheet object
    '    wh = CType(oWB.Sheets(1),  _
    '    Microsoft.Office.Interop.Excel.Worksheet)
    '    Dim dt As New System.Data.DataTable("dtExcel")
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////////////////////

    '    CurrentRow = INIRENGLON
    '    'While wh.Cells(CurrentRow, 1) <> "FIN"
    '    While CurrentRow < FINRENGLON

    '        Dim Nombre = f(wh.Cells(CurrentRow, "B"))
    '        Dim IdLocalidad = BuscaIdLocalidadNET(Nombre, SC)
    '        Dim IdProvincia = BuscaIdProvinciaNET(f(wh.Cells(CurrentRow, "F")), SC)
    '        Dim CP = f(wh.Cells(CurrentRow, "G"))
    '        Debug.Print(CurrentRow, f(wh.Cells(CurrentRow, "F")))


    '        If nombre <> "" Then 'me fijo si la celda no está vacía

    '            'hay datos para en el renglon



    '            If IdLocalidad = -1 Then
    '                '///////////////////////////////////////////////////////////////////
    '                '///////////////////////////////////////////////////////////////////
    '                'Creacion de Articulo
    '                'el nombre del articulo es NUEVO
    '                '///////////////////////////////////////////////////////////////////
    '                '///////////////////////////////////////////////////////////////////

    '                sb = String.Format("INSERT INTO Localidades " & _
    '                                  "(Nombre,CodigoPostal) " & _
    '                                  "VALUES ('{0}','{1}')", _
    '                                    Nombre, _
    '                                    CP _
    '                                    )

    '                'oArt = Aplicacion.Articulos.Item(-1)
    '                'With oArt
    '                '    With .Registro
    '                '        .Fields("Codigo").Value = f(wh.Cells(CurrentRow, "A"))
    '                '        '.Fields("Idtipo").Value = 13
    '                '        .Fields("Descripcion").Value = f(wh.Cells(CurrentRow, "B"))
    '                '        .Fields("AuxiliarString1").Value = f(wh.Cells(CurrentRow, "C"))
    '                '        .Fields("AuxiliarString2").Value = f(wh.Cells(CurrentRow, "D"))
    '                '        .Fields("IdRubro").Value = 2
    '                '        .Fields("IdSubRubro").Value = 1
    '                '    End With
    '                '    .Guardar()
    '                'End With
    '                'oArt = Nothing
    '            Else
    '                '///////////////////////////////////////////////////////////////////
    '                '///////////////////////////////////////////////////////////////////
    '                'YA EXISTE un articulo con este nombre
    '                '///////////////////////////////////////////////////////////////////
    '                '///////////////////////////////////////////////////////////////////
    '                sb = String.Format("UPDATE  Localidades " & _
    '                             "SET (Nombre='{0}',CodigoPostal='{1}' " & _
    '                             "WHERE IdLocalidad={2}", _
    '                               Nombre, _
    '                               CP, _
    '                               IdLocalidad _
    '                               )
    '            End If


    '            '///////////////////////////////////////////////////////////////////
    '        Else
    '            'no llegué al final del excel pero encontré un renglon con el campo vacío
    '            'Stop
    '        End If

    '        ExecDinamico(SC, sb)
    '        PrintLine(1, sb)

    '        CurrentRow = CurrentRow + 1
    '        'txtROW = CurrentRow
    '        'If CurrentRow Mod 1000 = 0 Then DoEvents()
    '    End While




    '    FileClose(1)



    'End Sub


    '    Sub ImportarArticulosWilliams(ByVal SC As String)
    '        Dim DOCPATH As String
    '        Dim INIRENGLON As Long
    '        Dim FINRENGLON As Long
    '        Dim CurrentRow As Long

    '        Dim oArt 'As ComPronto.Articulo 
    '        Dim Aplicacion = CrearAppCompronto(SC)

    '        DOCPATH = "c:\prontoweb\doc\williams\tablas\productos.xls"
    '        INIRENGLON = 2
    '        FINRENGLON = 52

    '        'K_UN1 = BuscaIdUnidad("Unidad")

    '        'Hacer funcion que descule cual es el campo que tira errores



    '        Dim oXL As Application
    '        Dim oWB As Workbook
    '        Dim wh As Worksheet
    '        Dim oRng As Range
    '        Dim oWBs As Workbooks

    '        '  creat a Application object
    '        oXL = New ApplicationClass()
    '        '   get   WorkBook  object
    '        oWBs = oXL.Workbooks
    '        oWB = oWBs.Open(DOCPATH, Missing.Value, Missing.Value, _
    'Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    'Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    'Missing.Value, Missing.Value)

    '        '   get   WorkSheet object
    '        wh = CType(oWB.Sheets(1),  _
    '        Microsoft.Office.Interop.Excel.Worksheet)
    '        Dim dt As New System.Data.DataTable("dtExcel")




    '        CurrentRow = INIRENGLON
    '        'While wh.Cells(CurrentRow, 1) <> "FIN"
    '        While CurrentRow < FINRENGLON

    '            Debug.Print(CurrentRow, f(wh.Cells(CurrentRow, "F")))
    '            If f(wh.Cells(CurrentRow, "B")) <> "" Then


    '                '///////////////////////////////////////////////////////////////

    '                'EntidadManager.ExecDinamico("INSERT INTO Choferes SET Nombre,Cuit (1),{2}")




    '                '///////////////////////////////////////////////////////////////////
    '                '///////////////////////////////////////////////////////////////////
    '                'Creacion de Articulo
    '                '///////////////////////////////////////////////////////////////////
    '                '///////////////////////////////////////////////////////////////////
    '                If BuscaIdArticuloNET(f(wh.Cells(CurrentRow, "B")), SC) = -1 Then
    '                    oArt = Aplicacion.Articulos.Item(-1)
    '                    With oArt
    '                        With .Registro
    '                            .Fields("Codigo").Value = f(wh.Cells(CurrentRow, "A"))
    '                            '.Fields("Idtipo").Value = 13
    '                            .Fields("Descripcion").Value = f(wh.Cells(CurrentRow, "B"))
    '                            .Fields("AuxiliarString1").Value = f(wh.Cells(CurrentRow, "C"))
    '                            .Fields("AuxiliarString2").Value = f(wh.Cells(CurrentRow, "D"))
    '                            .Fields("IdRubro").Value = 2
    '                            .Fields("IdSubRubro").Value = 1
    '                        End With
    '                        .Guardar()
    '                    End With
    '                    oArt = Nothing
    '                Else
    '                    'Stop
    '                End If
    '                '///////////////////////////////////////////////////////////////////
    '                '///////////////////////////////////////////////////////////////////
    '            Else
    '                'Stop
    '            End If



    '            CurrentRow = CurrentRow + 1
    '            'txtROW = CurrentRow
    '            'If CurrentRow Mod 1000 = 0 Then DoEvents()
    '        End While

    '    End Sub



End Module
