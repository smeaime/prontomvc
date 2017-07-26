Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class FacturaDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Factura
            Dim myFactura As Factura = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("Facturas_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdFactura", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myFactura = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myFactura
        End Function

        Public Shared Function GetList(ByVal SC As String) As FacturaList
            Dim tempList As FacturaList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("Facturas_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New FacturaList
                        While myReader.Read
                            tempList.Add(FillDataRecord(myReader))
                        End While
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return tempList
        End Function

        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String) As FacturaList

            Dim tempList As FacturaList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wFacturas_T_ByEmployee", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdSolicito", IdSolicito)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New FacturaList
                        While myReader.Read
                            tempList.Add(FillDataRecord(myReader))
                        End While
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return tempList
        End Function

        Public Shared Function GetCountRequemientoForEmployee(ByVal SC As String, ByVal IdEmpleado As Integer) As Integer
            Dim result As Integer = 0
            Dim tempList As FacturaList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("GetCountRequemientoForEmployee", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdSolicito", IdEmpleado)

                Dim returnValue As DbParameter
                returnValue = myCommand.CreateParameter
                returnValue.Direction = ParameterDirection.ReturnValue
                myCommand.Parameters.Add(returnValue)
                myConnection.Open()
                myCommand.ExecuteNonQuery()
                result = Convert.ToInt32(returnValue.Value)
                myConnection.Close()
            Catch ex As Exception
                Throw New System.Exception(SC)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result
        End Function

        Public Shared Function GetList_fm(ByVal SC As String) As DataSet 'supongo que con esta, Edu solo quería traerse la metadata, el recordset vacío.
            Dim ds As New DataSet()
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wFacturas_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdFactura", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myFactura As Factura) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand
                With myFactura


                    If .Id = -1 Then

                        myCommand = New SqlCommand("wFacturas_A", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdFactura", -1)
                        param.Direction = ParameterDirection.Output

                    Else

                        myCommand = New SqlCommand("wFacturas_M", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        myCommand.Parameters.AddWithValue("@IdFactura", .Id)
                    End If


                    NETtoSQL(myCommand, "@NumeroFactura", .Numero)
                    NETtoSQL(myCommand, "@TipoABC", .TipoABC)
                    NETtoSQL(myCommand, "@PuntoVenta", .PuntoVenta)
                    NETtoSQL(myCommand, "@IdCliente", .IdCliente)
                    NETtoSQL(myCommand, "@FechaFactura", .Fecha)

                    NETtoSQL(myCommand, "@IdCondicionVenta", .IdCondicionVenta)
                    NETtoSQL(myCommand, "@IdVendedor", .IdVendedor)
                    NETtoSQL(myCommand, "@IdTransportista1", .IdTransportista1)
                    NETtoSQL(myCommand, "@IdTransportista2", .IdTransportista2)
                    NETtoSQL(myCommand, "@ItemDireccion", .ItemDireccion)
                    NETtoSQL(myCommand, "@OrdenCompra", .OrdenCompra)
                    NETtoSQL(myCommand, "@TipoPedidoConsignacion", .TipoPedidoConsignacion)
                    NETtoSQL(myCommand, "@Anulada", .Anulada)
                    NETtoSQL(myCommand, "@FechaAnulacion", .FechaAnulacion)
                    NETtoSQL(myCommand, "@Observaciones", .Observaciones)
                    NETtoSQL(myCommand, "@IdRemito", .IdRemito)
                    NETtoSQL(myCommand, "@NumeroRemito", .NumeroRemito)
                    NETtoSQL(myCommand, "@IdPedido", .IdPedido)
                    NETtoSQL(myCommand, "@NumeroPedido", .NumeroPedido)
                    NETtoSQL(myCommand, "@ImporteTotal", .Total)
                    NETtoSQL(myCommand, "@ImporteIva1", .ImporteIva1)
                    NETtoSQL(myCommand, "@ImporteIva2", .ImporteIva2)
                    NETtoSQL(myCommand, "@ImporteBonificacion", .ImporteBonificacion)
                    NETtoSQL(myCommand, "@RetencionIBrutos1", .RetencionIBrutos1)
                    NETtoSQL(myCommand, "@PorcentajeIBrutos1", .PorcentajeIBrutos1)
                    NETtoSQL(myCommand, "@RetencionIBrutos2", .RetencionIBrutos2)
                    NETtoSQL(myCommand, "@PorcentajeIBrutos2", .PorcentajeIBrutos2)
                    NETtoSQL(myCommand, "@ConvenioMultilateral", .ConvenioMultilateral)
                    NETtoSQL(myCommand, "@RetencionIBrutos3", .RetencionIBrutos3)
                    NETtoSQL(myCommand, "@PorcentajeIBrutos3", .PorcentajeIBrutos3)
                    NETtoSQL(myCommand, "@IdTipoVentaC", .IdTipoVentaC)
                    NETtoSQL(myCommand, "@ImporteIvaIncluido", .ImporteIvaIncluido)
                    NETtoSQL(myCommand, "@CotizacionDolar", .CotizacionDolar)
                    NETtoSQL(myCommand, "@EsMuestra", .EsMuestra)
                    NETtoSQL(myCommand, "@CotizacionADolarFijo", .CotizacionADolarFijo)
                    NETtoSQL(myCommand, "@ImporteParteEnDolares", .ImporteParteEnDolares)
                    NETtoSQL(myCommand, "@ImporteParteEnPesos", .ImporteParteEnPesos)
                    NETtoSQL(myCommand, "@PorcentajeIva1", .PorcentajeIva1)
                    NETtoSQL(myCommand, "@PorcentajeIva2", .PorcentajeIva2)
                    NETtoSQL(myCommand, "@FechaVencimiento", .FechaVencimiento)
                    NETtoSQL(myCommand, "@IVANoDiscriminado", .IVANoDiscriminado)
                    NETtoSQL(myCommand, "@IdMoneda", .IdMoneda)
                    NETtoSQL(myCommand, "@CotizacionMoneda", .CotizacionMoneda)
                    NETtoSQL(myCommand, "@PorcentajeBonificacion", .PorcentajeBonificacion)
                    NETtoSQL(myCommand, "@OtrasPercepciones1", .OtrasPercepciones1)
                    NETtoSQL(myCommand, "@OtrasPercepciones1Desc", .OtrasPercepciones1Desc)
                    NETtoSQL(myCommand, "@OtrasPercepciones2", .OtrasPercepciones2)
                    NETtoSQL(myCommand, "@OtrasPercepciones2Desc", .OtrasPercepciones2Desc)
                    NETtoSQL(myCommand, "@IdProvinciaDestino", .IdProvinciaDestino)
                    NETtoSQL(myCommand, "@IdIBCondicion", .IdIBCondicion)
                    NETtoSQL(myCommand, "@IdAutorizaAnulacion", .IdAutorizaAnulacion)
                    NETtoSQL(myCommand, "@IdPuntoVenta", .IdPuntoVenta)
                    NETtoSQL(myCommand, "@NumeroCAI", .NumeroCAI)
                    NETtoSQL(myCommand, "@FechaVencimientoCAI", .FechaVencimientoCAI)
                    NETtoSQL(myCommand, "@NumeroCertificadoPercepcionIIBB", .NumeroCertificadoPercepcionIIBB)
                    NETtoSQL(myCommand, "@NumeroTicketInicial", .NumeroTicketInicial)
                    NETtoSQL(myCommand, "@NumeroTicketFinal", .NumeroTicketFinal)
                    NETtoSQL(myCommand, "@IdUsuarioIngreso", .IdUsuarioIngreso)
                    NETtoSQL(myCommand, "@FechaIngreso", .FechaIngreso)
                    NETtoSQL(myCommand, "@IdObra", .IdObra)
                    NETtoSQL(myCommand, "@IdIBCondicion2", .IdIBCondicion2)
                    NETtoSQL(myCommand, "@IdIBCondicion3", .IdIBCondicion3)
                    NETtoSQL(myCommand, "@IdCodigoIva", .IdCodigoIva)
                    NETtoSQL(myCommand, "@Exportacion_FOB", .Exportacion_FOB)
                    NETtoSQL(myCommand, "@Exportacion_PosicionAduana", .Exportacion_PosicionAduana)
                    NETtoSQL(myCommand, "@Exportacion_Despacho", .Exportacion_Despacho)
                    NETtoSQL(myCommand, "@Exportacion_Guia", .Exportacion_Guia)
                    NETtoSQL(myCommand, "@Exportacion_IdPaisDestino", .Exportacion_IdPaisDestino)
                    NETtoSQL(myCommand, "@Exportacion_FechaEmbarque", .Exportacion_FechaEmbarque)
                    NETtoSQL(myCommand, "@Exportacion_FechaOficializacion", .Exportacion_FechaOficializacion)
                    NETtoSQL(myCommand, "@OtrasPercepciones3", .OtrasPercepciones3)
                    NETtoSQL(myCommand, "@OtrasPercepciones3Desc", .OtrasPercepciones3Desc)
                    NETtoSQL(myCommand, "@NoIncluirEnCubos", .NoIncluirEnCubos)
                    NETtoSQL(myCommand, "@PercepcionIVA", .PercepcionIVA)
                    NETtoSQL(myCommand, "@PorcentajePercepcionIVA", .PorcentajePercepcionIVA)
                    NETtoSQL(myCommand, "@ActivarRecuperoGastos", .ActivarRecuperoGastos)
                    NETtoSQL(myCommand, "@IdAutorizoRecuperoGastos", .IdAutorizoRecuperoGastos)
                    NETtoSQL(myCommand, "@ContabilizarAFechaVencimiento", .ContabilizarAFechaVencimiento)
                    NETtoSQL(myCommand, "@FacturaContado", .FacturaContado)
                    NETtoSQL(myCommand, "@IdReciboContado", .IdReciboContado)
                    NETtoSQL(myCommand, "@EnviarEmail", .EnviarEmail)
                    NETtoSQL(myCommand, "@IdOrigenTransmision", .IdOrigenTransmision)
                    NETtoSQL(myCommand, "@IdFacturaOriginal", .IdFacturaOriginal)
                    NETtoSQL(myCommand, "@FechaImportacionTransmision", .FechaImportacionTransmision)
                    NETtoSQL(myCommand, "@CuitClienteTransmision", .CuitClienteTransmision)
                    NETtoSQL(myCommand, "@IdReciboContadoOriginal", .IdReciboContadoOriginal)
                    NETtoSQL(myCommand, "@DevolucionAnticipo", .DevolucionAnticipo)
                    NETtoSQL(myCommand, "@PorcentajeDevolucionAnticipo", .PorcentajeDevolucionAnticipo)
                    NETtoSQL(myCommand, "@CAE", .CAE)
                    NETtoSQL(myCommand, "@RechazoCAE", .RechazoCAE)
                    NETtoSQL(myCommand, "@FechaVencimientoORechazoCAE", .FechaVencimientoORechazoCAE)
                    NETtoSQL(myCommand, "@IdListaPrecios", .IdListaPrecios)
                    NETtoSQL(myCommand, "@IdIdentificacionCAE", .IdIdentificacionCAE)

                    'Estos son parametros nuevos, que no estan en todas las bases... ver como se puede verificar que
                    'estan en el store procedure
                    'NETtoSQL(myCommand, "@AjusteIva", .AjusteIva)
                    'NETtoSQL(myCommand, "@TipoExportacion", .TipoExportacion)
                    'NETtoSQL(myCommand, "@PermisoEmbarque", .PermisoEmbarque)
                    'NETtoSQL(myCommand, "@NumeroFacturaInicial", .NumeroFacturaInicial)
                    'NETtoSQL(myCommand, "@NumeroFacturaFinal", .NumeroFacturaFinal)
                    'NETtoSQL(myCommand, "@CodigoIdAuxiliar", .CodigoIdAuxiliar)
                    'NETtoSQL(myCommand, "@NumeroCertificadoObra", .NumeroCertificadoObra)
                    'NETtoSQL(myCommand, "@ImporteCertificacionObra", .ImporteCertificacionObra)
                    'NETtoSQL(myCommand, "@FondoReparoCertificacionObra", .FondoReparoCertificacionObra)
                    'NETtoSQL(myCommand, "@PorcentajeRetencionesEstimadasCertificacionObra", .PorcentajeRetencionesEstimadasCertificacionObra)
                    'NETtoSQL(myCommand, "@NumeroExpedienteCertificacionObra", .NumeroExpedienteCertificacionObra)


                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    For Each myFacturaItem As FacturaItem In myFactura.Detalles
                        myFacturaItem.IdFactura = result




                        If myFacturaItem.Eliminado Then
                            'EntidadManager.GetStoreProcedure(SC, "DetFacturas_E", .Id)
                        Else
                            Dim IdAntesDeGrabar = myFacturaItem.Id
                            myFacturaItem.Id = FacturaItemDB.Save(SC, myFacturaItem)


                            'Como el item consiguió un nuevo id, lo tengo que refrescar en las colecciones
                            'de imputacion (en el prontovb6, se usaba -100,-101,etc)
                            For Each o As FacturaRemitosItem In .DetallesRemitos
                                If o.IdDetalleFactura = IdAntesDeGrabar Then
                                    o.IdDetalleFactura = myFacturaItem.Id
                                End If
                            Next

                            For Each o As FacturaOrdenesCompraItem In .DetallesOrdenesCompra
                                If o.IdDetalleFactura = IdAntesDeGrabar Then
                                    o.IdDetalleFactura = myFacturaItem.Id
                                End If
                            Next
                        End If
                    Next


                    ''//////////////////////////////////////////////////////////////////////////////////////
                    'Colecciones adicionales
                    ''//////////////////////////////////////////////////////////////////////////////////////

                    For Each myFacturaProvinciaItem As FacturaProvinciasItem In myFactura.DetallesProvincias
                        myFacturaProvinciaItem.IdFactura = result
                        FacturaProvinciasItemDB.Save(SC, myFacturaProvinciaItem)
                    Next
                    For Each myFacturaRemitosItem As FacturaRemitosItem In myFactura.DetallesRemitos
                        myFacturaRemitosItem.IdFactura = result
                        FacturaRemitosItemDB.Save(SC, myFacturaRemitosItem)
                    Next
                    For Each myFacturaOrdenesCompraItem As FacturaOrdenesCompraItem In myFactura.DetallesOrdenesCompra
                        myFacturaOrdenesCompraItem.IdFactura = result
                        FacturaOrdenesCompraItemDB.Save(SC, myFacturaOrdenesCompraItem)
                    Next






                End With
                Transaccion.Commit()
                myConnection.Close()
            Catch e As Exception
                Transaccion.Rollback()
                ErrHandler.WriteAndRaiseError(e)
                'Return -1 'qué conviene usar? disparar errores o devolver -1?
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wFacturas_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdFactura", id)
                myConnection.Open()

                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Public Shared Function Anular(ByVal SC As String, ByVal IdFactura As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wFacturas_N", myConnection)
                myCommand.Transaction = Transaccion
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdFactura", IdFactura)
                result = myCommand.ExecuteNonQuery
                Transaccion.Commit()
                myConnection.Close()
            Catch e As Exception
                Transaccion.Rollback()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Factura
            Dim myFactura As Factura = New Factura


            With myFactura
                SQLtoNET(myDataRecord, "@IdFactura", .Id)
                SQLtoNET(myDataRecord, "@NumeroFactura", .Numero)
                SQLtoNET(myDataRecord, "@TipoABC", .TipoABC)
                SQLtoNET(myDataRecord, "@PuntoVenta", .PuntoVenta)
                SQLtoNET(myDataRecord, "@IdCliente", .IdCliente)
                SQLtoNET(myDataRecord, "@FechaFactura", .Fecha)
                SQLtoNET(myDataRecord, "@IdCondicionVenta", .IdCondicionVenta)
                SQLtoNET(myDataRecord, "@IdVendedor", .IdVendedor)
                SQLtoNET(myDataRecord, "@IdTransportista1", .IdTransportista1)
                SQLtoNET(myDataRecord, "@IdTransportista2", .IdTransportista2)
                SQLtoNET(myDataRecord, "@ItemDireccion", .ItemDireccion)
                SQLtoNET(myDataRecord, "@OrdenCompra", .OrdenCompra)
                SQLtoNET(myDataRecord, "@TipoPedidoConsignacion", .TipoPedidoConsignacion)
                SQLtoNET(myDataRecord, "@Anulada", .Anulada)
                SQLtoNET(myDataRecord, "@FechaAnulacion", .FechaAnulacion)
                SQLtoNET(myDataRecord, "@Observaciones", .Observaciones)
                SQLtoNET(myDataRecord, "@IdRemito", .IdRemito)
                SQLtoNET(myDataRecord, "@NumeroRemito", .NumeroRemito)
                SQLtoNET(myDataRecord, "@IdPedido", .IdPedido)
                SQLtoNET(myDataRecord, "@NumeroPedido", .NumeroPedido)
                SQLtoNET(myDataRecord, "@ImporteTotal", .Total)
                SQLtoNET(myDataRecord, "@ImporteIva1", .ImporteIva1)
                SQLtoNET(myDataRecord, "@ImporteIva2", .ImporteIva2)
                SQLtoNET(myDataRecord, "@ImporteBonificacion", .ImporteBonificacion)
                SQLtoNET(myDataRecord, "@RetencionIBrutos1", .RetencionIBrutos1)
                SQLtoNET(myDataRecord, "@PorcentajeIBrutos1", .PorcentajeIBrutos1)
                SQLtoNET(myDataRecord, "@RetencionIBrutos2", .RetencionIBrutos2)
                SQLtoNET(myDataRecord, "@PorcentajeIBrutos2", .PorcentajeIBrutos2)
                SQLtoNET(myDataRecord, "@ConvenioMultilateral", .ConvenioMultilateral)
                SQLtoNET(myDataRecord, "@RetencionIBrutos3", .RetencionIBrutos3)
                SQLtoNET(myDataRecord, "@PorcentajeIBrutos3", .PorcentajeIBrutos3)
                SQLtoNET(myDataRecord, "@IdTipoVentaC", .IdTipoVentaC)
                SQLtoNET(myDataRecord, "@ImporteIvaIncluido", .ImporteIvaIncluido)
                SQLtoNET(myDataRecord, "@CotizacionDolar", .CotizacionDolar)
                SQLtoNET(myDataRecord, "@EsMuestra", .EsMuestra)
                SQLtoNET(myDataRecord, "@CotizacionADolarFijo", .CotizacionADolarFijo)
                SQLtoNET(myDataRecord, "@ImporteParteEnDolares", .ImporteParteEnDolares)
                SQLtoNET(myDataRecord, "@ImporteParteEnPesos", .ImporteParteEnPesos)
                SQLtoNET(myDataRecord, "@PorcentajeIva1", .PorcentajeIva1)
                SQLtoNET(myDataRecord, "@PorcentajeIva2", .PorcentajeIva2)
                SQLtoNET(myDataRecord, "@FechaVencimiento", .FechaVencimiento)
                SQLtoNET(myDataRecord, "@IVANoDiscriminado", .IVANoDiscriminado)
                SQLtoNET(myDataRecord, "@IdMoneda", .IdMoneda)
                SQLtoNET(myDataRecord, "@CotizacionMoneda", .CotizacionMoneda)
                SQLtoNET(myDataRecord, "@PorcentajeBonificacion", .PorcentajeBonificacion)
                SQLtoNET(myDataRecord, "@OtrasPercepciones1", .OtrasPercepciones1)
                SQLtoNET(myDataRecord, "@OtrasPercepciones1Desc", .OtrasPercepciones1Desc)
                SQLtoNET(myDataRecord, "@OtrasPercepciones2", .OtrasPercepciones2)
                SQLtoNET(myDataRecord, "@OtrasPercepciones2Desc", .OtrasPercepciones2Desc)
                SQLtoNET(myDataRecord, "@IdProvinciaDestino", .IdProvinciaDestino)
                SQLtoNET(myDataRecord, "@IdIBCondicion", .IdIBCondicion)
                SQLtoNET(myDataRecord, "@IdAutorizaAnulacion", .IdAutorizaAnulacion)
                SQLtoNET(myDataRecord, "@IdPuntoVenta", .IdPuntoVenta)
                SQLtoNET(myDataRecord, "@NumeroCAI", .NumeroCAI)
                SQLtoNET(myDataRecord, "@FechaVencimientoCAI", .FechaVencimientoCAI)
                SQLtoNET(myDataRecord, "@NumeroCertificadoPercepcionIIBB", .NumeroCertificadoPercepcionIIBB)
                SQLtoNET(myDataRecord, "@NumeroTicketInicial", .NumeroTicketInicial)
                SQLtoNET(myDataRecord, "@NumeroTicketFinal", .NumeroTicketFinal)
                SQLtoNET(myDataRecord, "@IdUsuarioIngreso", .IdUsuarioIngreso)
                SQLtoNET(myDataRecord, "@FechaIngreso", .FechaIngreso)
                SQLtoNET(myDataRecord, "@IdObra", .IdObra)
                SQLtoNET(myDataRecord, "@IdIBCondicion2", .IdIBCondicion2)
                SQLtoNET(myDataRecord, "@IdIBCondicion3", .IdIBCondicion3)
                SQLtoNET(myDataRecord, "@IdCodigoIva", .IdCodigoIva)
                SQLtoNET(myDataRecord, "@Exportacion_FOB", .Exportacion_FOB)
                SQLtoNET(myDataRecord, "@Exportacion_PosicionAduana", .Exportacion_PosicionAduana)
                SQLtoNET(myDataRecord, "@Exportacion_Despacho", .Exportacion_Despacho)
                SQLtoNET(myDataRecord, "@Exportacion_Guia", .Exportacion_Guia)
                SQLtoNET(myDataRecord, "@Exportacion_IdPaisDestino", .Exportacion_IdPaisDestino)
                SQLtoNET(myDataRecord, "@Exportacion_FechaEmbarque", .Exportacion_FechaEmbarque)
                SQLtoNET(myDataRecord, "@Exportacion_FechaOficializacion", .Exportacion_FechaOficializacion)
                SQLtoNET(myDataRecord, "@OtrasPercepciones3", .OtrasPercepciones3)
                SQLtoNET(myDataRecord, "@OtrasPercepciones3Desc", .OtrasPercepciones3Desc)
                SQLtoNET(myDataRecord, "@NoIncluirEnCubos", .NoIncluirEnCubos)
                SQLtoNET(myDataRecord, "@PercepcionIVA", .PercepcionIVA)
                SQLtoNET(myDataRecord, "@PorcentajePercepcionIVA", .PorcentajePercepcionIVA)
                SQLtoNET(myDataRecord, "@ActivarRecuperoGastos", .ActivarRecuperoGastos)
                SQLtoNET(myDataRecord, "@IdAutorizoRecuperoGastos", .IdAutorizoRecuperoGastos)
                SQLtoNET(myDataRecord, "@ContabilizarAFechaVencimiento", .ContabilizarAFechaVencimiento)
                SQLtoNET(myDataRecord, "@FacturaContado", .FacturaContado)
                SQLtoNET(myDataRecord, "@IdReciboContado", .IdReciboContado)
                SQLtoNET(myDataRecord, "@EnviarEmail", .EnviarEmail)
                SQLtoNET(myDataRecord, "@IdOrigenTransmision", .IdOrigenTransmision)
                SQLtoNET(myDataRecord, "@IdFacturaOriginal", .IdFacturaOriginal)
                SQLtoNET(myDataRecord, "@FechaImportacionTransmision", .FechaImportacionTransmision)
                SQLtoNET(myDataRecord, "@CuitClienteTransmision", .CuitClienteTransmision)
                SQLtoNET(myDataRecord, "@IdReciboContadoOriginal", .IdReciboContadoOriginal)
                SQLtoNET(myDataRecord, "@DevolucionAnticipo", .DevolucionAnticipo)
                SQLtoNET(myDataRecord, "@PorcentajeDevolucionAnticipo", .PorcentajeDevolucionAnticipo)
                SQLtoNET(myDataRecord, "@CAE", .CAE)
                SQLtoNET(myDataRecord, "@RechazoCAE", .RechazoCAE)
                SQLtoNET(myDataRecord, "@FechaVencimientoORechazoCAE", .FechaVencimientoORechazoCAE)
                SQLtoNET(myDataRecord, "@IdListaPrecios", .IdListaPrecios)
                SQLtoNET(myDataRecord, "@IdIdentificacionCAE", .IdIdentificacionCAE)



                end With

                Return myFactura
        End Function
    End Class
End Namespace