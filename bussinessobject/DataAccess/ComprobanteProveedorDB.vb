Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Imports System.Diagnostics

Namespace Pronto.ERP.Dal

    Public Class ComprobanteProveedorDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As ComprobanteProveedor
            Dim myComprobanteProveedor As ComprobanteProveedor = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wComprobantesProveedores_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdComprobanteProveedor", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myComprobanteProveedor = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myComprobanteProveedor
        End Function


        Public Shared Function GetList(ByVal SC As String) As ComprobanteProveedorList
            Dim tempList As ComprobanteProveedorList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wComprobantesProveedores_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New ComprobanteProveedorList
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


        Public Shared Function GetList_FondosFijos(ByVal SC As String, ByVal IdObra As Integer) As ComprobanteProveedorList
            Dim tempList As ComprobanteProveedorList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wComprobantesProveedores_TX_FondosFijos", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdObra", IdObra)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New ComprobanteProveedorList
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


        Public Shared Function GetList_fm(ByVal SC As String) As DataSet
            Dim ds As New DataSet()
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wComprobantesProveedores_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdComprobanteProveedor", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myComprobanteProveedor As ComprobanteProveedor) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand
                With myComprobanteProveedor


                    If .Id = -1 Then

                        myCommand = New SqlCommand(enumSPs.ComprobantesProveedores_A.ToString, myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdComprobanteProveedor", -1)
                        param.Direction = ParameterDirection.Output

                    Else

                        myCommand = New SqlCommand(enumSPs.ComprobantesProveedores_M.ToString, myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        myCommand.Parameters.AddWithValue("@IdComprobanteProveedor", .Id)
                    End If



                    NETtoSQL(myCommand, "@IdProveedor", .IdProveedor)
                    NETtoSQL(myCommand, "@IdTipoComprobante", .IdTipoComprobante)
                    NETtoSQL(myCommand, "@FechaComprobante", .FechaComprobante)
                    NETtoSQL(myCommand, "@Letra", .Letra)
                    NETtoSQL(myCommand, "@NumeroComprobante1", .NumeroComprobante1)
                    NETtoSQL(myCommand, "@NumeroComprobante2", .NumeroComprobante2)
                    NETtoSQL(myCommand, "@NumeroReferencia", .NumeroReferencia)
                    NETtoSQL(myCommand, "@FechaRecepcion", .FechaRecepcion)
                    NETtoSQL(myCommand, "@FechaVencimiento", .FechaVencimiento)
                    NETtoSQL(myCommand, "@TotalBruto", .TotalBruto)
                    NETtoSQL(myCommand, "@TotalIva1", .TotalIva1)
                    NETtoSQL(myCommand, "@TotalIva2", .TotalIva2)
                    NETtoSQL(myCommand, "@TotalBonificacion", .TotalBonificacion)
                    NETtoSQL(myCommand, "@TotalComprobante", .TotalComprobante)
                    NETtoSQL(myCommand, "@PorcentajeBonificacion", .PorcentajeBonificacion)
                    NETtoSQL(myCommand, "@Observaciones", .Observaciones)
                    NETtoSQL(myCommand, "@DiasVencimiento", .DiasVencimiento)
                    NETtoSQL(myCommand, "@IdObra", .IdObra)
                    NETtoSQL(myCommand, "@IdProveedorEventual", .IdProveedorEventual)
                    NETtoSQL(myCommand, "@IdOrdenPago", .IdOrdenPago)
                    NETtoSQL(myCommand, "@IdCuenta", .IdCuenta)
                    NETtoSQL(myCommand, "@IdMoneda", .IdMoneda)
                    NETtoSQL(myCommand, "@CotizacionMoneda", .CotizacionMoneda)
                    NETtoSQL(myCommand, "@CotizacionDolar", .CotizacionDolar)
                    NETtoSQL(myCommand, "@TotalIVANoDiscriminado", .TotalIVANoDiscriminado)
                    NETtoSQL(myCommand, "@IdCuentaIvaCompras1", .IdCuentaIvaCompras1)
                    NETtoSQL(myCommand, "@IVAComprasPorcentaje1", .IVAComprasPorcentaje1)
                    NETtoSQL(myCommand, "@IVAComprasImporte1", .IVAComprasImporte1)
                    NETtoSQL(myCommand, "@IdCuentaIvaCompras2", .IdCuentaIvaCompras2)
                    NETtoSQL(myCommand, "@IVAComprasPorcentaje2", .IVAComprasPorcentaje2)
                    NETtoSQL(myCommand, "@IVAComprasImporte2", .IVAComprasImporte2)
                    NETtoSQL(myCommand, "@IdCuentaIvaCompras3", .IdCuentaIvaCompras3)
                    NETtoSQL(myCommand, "@IVAComprasPorcentaje3", .IVAComprasPorcentaje3)
                    NETtoSQL(myCommand, "@IVAComprasImporte3", .IVAComprasImporte3)
                    NETtoSQL(myCommand, "@IdCuentaIvaCompras4", .IdCuentaIvaCompras4)
                    NETtoSQL(myCommand, "@IVAComprasPorcentaje4", .IVAComprasPorcentaje4)
                    NETtoSQL(myCommand, "@IVAComprasImporte4", .IVAComprasImporte4)
                    NETtoSQL(myCommand, "@IdCuentaIvaCompras5", .IdCuentaIvaCompras5)
                    NETtoSQL(myCommand, "@IVAComprasPorcentaje5", .IVAComprasPorcentaje5)
                    NETtoSQL(myCommand, "@IVAComprasImporte5", .IVAComprasImporte5)
                    NETtoSQL(myCommand, "@IdCuentaIvaCompras6", .IdCuentaIvaCompras6)
                    NETtoSQL(myCommand, "@IVAComprasPorcentaje6", .IVAComprasPorcentaje6)
                    NETtoSQL(myCommand, "@IVAComprasImporte6", .IVAComprasImporte6)
                    NETtoSQL(myCommand, "@IdCuentaIvaCompras7", .IdCuentaIvaCompras7)
                    NETtoSQL(myCommand, "@IVAComprasPorcentaje7", .IVAComprasPorcentaje7)
                    NETtoSQL(myCommand, "@IVAComprasImporte7", .IVAComprasImporte7)
                    NETtoSQL(myCommand, "@IdCuentaIvaCompras8", .IdCuentaIvaCompras8)
                    NETtoSQL(myCommand, "@IVAComprasPorcentaje8", .IVAComprasPorcentaje8)
                    NETtoSQL(myCommand, "@IVAComprasImporte8", .IVAComprasImporte8)
                    NETtoSQL(myCommand, "@IdCuentaIvaCompras9", .IdCuentaIvaCompras9)
                    NETtoSQL(myCommand, "@IVAComprasPorcentaje9", .IVAComprasPorcentaje9)
                    NETtoSQL(myCommand, "@IVAComprasImporte9", .IVAComprasImporte9)
                    NETtoSQL(myCommand, "@IdCuentaIvaCompras10", .IdCuentaIvaCompras10)
                    NETtoSQL(myCommand, "@IVAComprasPorcentaje10", .IVAComprasPorcentaje10)
                    NETtoSQL(myCommand, "@IVAComprasImporte10", .IVAComprasImporte10)
                    NETtoSQL(myCommand, "@SubtotalGravado", .SubtotalGravado)
                    NETtoSQL(myCommand, "@SubtotalExento", .SubtotalExento)
                    NETtoSQL(myCommand, "@AjusteIVA", .AjusteIVA)
                    NETtoSQL(myCommand, "@PorcentajeIVAAplicacionAjuste", .PorcentajeIVAAplicacionAjuste)
                    NETtoSQL(myCommand, "@BienesOServicios", .BienesOServicios)
                    NETtoSQL(myCommand, "@IdDetalleOrdenPagoRetencionIVAAplicada", .IdDetalleOrdenPagoRetencionIVAAplicada)
                    NETtoSQL(myCommand, "@IdIBCondicion", .IdIBCondicion)
                    NETtoSQL(myCommand, "@PRESTOFactura", .PRESTOFactura)
                    NETtoSQL(myCommand, "@Confirmado", .Confirmado)
                    NETtoSQL(myCommand, "@IdProvinciaDestino", .IdProvinciaDestino)
                    NETtoSQL(myCommand, "@IdTipoRetencionGanancia", .IdTipoRetencionGanancia)
                    NETtoSQL(myCommand, "@NumeroCAI", .NumeroCAI)
                    NETtoSQL(myCommand, "@FechaVencimientoCAI", .FechaVencimientoCAI)
                    NETtoSQL(myCommand, "@IdCodigoAduana", .IdCodigoAduana)
                    NETtoSQL(myCommand, "@IdCodigoDestinacion", .IdCodigoDestinacion)
                    NETtoSQL(myCommand, "@NumeroDespacho", .NumeroDespacho)
                    NETtoSQL(myCommand, "@DigitoVerificadorNumeroDespacho", .DigitoVerificadorNumeroDespacho)
                    NETtoSQL(myCommand, "@FechaDespachoAPlaza", .FechaDespachoAPlaza)
                    NETtoSQL(myCommand, "@IdUsuarioIngreso", .IdUsuarioIngreso)
                    NETtoSQL(myCommand, "@FechaIngreso", .FechaIngreso)
                    NETtoSQL(myCommand, "@IdUsuarioModifico", .IdUsuarioModifico)
                    NETtoSQL(myCommand, "@FechaModifico", .FechaModifico)
                    NETtoSQL(myCommand, "@PRESTOProveedor", .PRESTOProveedor)
                    NETtoSQL(myCommand, "@IdCodigoIva", .IdCodigoIva)
                    NETtoSQL(myCommand, "@CotizacionEuro", .CotizacionEuro)
                    NETtoSQL(myCommand, "@IdCondicionCompra", .IdCondicionCompra)
                    NETtoSQL(myCommand, "@Importacion_FOB", .Importacion_FOB)
                    NETtoSQL(myCommand, "@Importacion_PosicionAduana", .Importacion_PosicionAduana)
                    NETtoSQL(myCommand, "@Importacion_Despacho", .Importacion_Despacho)
                    NETtoSQL(myCommand, "@Importacion_Guia", .Importacion_Guia)
                    NETtoSQL(myCommand, "@Importacion_IdPaisOrigen", .Importacion_IdPaisOrigen)
                    NETtoSQL(myCommand, "@Importacion_FechaEmbarque", .Importacion_FechaEmbarque)
                    NETtoSQL(myCommand, "@Importacion_FechaOficializacion", .Importacion_FechaOficializacion)
                    NETtoSQL(myCommand, "@REP_CTAPRO_INS", .REP_CTAPRO_INS)
                    NETtoSQL(myCommand, "@REP_CTAPRO_UPD", .REP_CTAPRO_UPD)
                    NETtoSQL(myCommand, "@InformacionAuxiliar", .InformacionAuxiliar)
                    NETtoSQL(myCommand, "@GravadoParaSUSS", .GravadoParaSUSS)
                    NETtoSQL(myCommand, "@PorcentajeParaSUSS", .PorcentajeParaSUSS)
                    NETtoSQL(myCommand, "@FondoReparo", .FondoReparo)
                    NETtoSQL(myCommand, "@AutoincrementarNumeroReferencia", .AutoincrementarNumeroReferencia)
                    NETtoSQL(myCommand, "@ReintegroImporte", .ReintegroImporte)
                    NETtoSQL(myCommand, "@ReintegroDespacho", .ReintegroDespacho)
                    NETtoSQL(myCommand, "@ReintegroIdMoneda", .ReintegroIdMoneda)
                    NETtoSQL(myCommand, "@ReintegroIdCuenta", .ReintegroIdCuenta)
                    NETtoSQL(myCommand, "@PrestoDestino", .PrestoDestino)
                    NETtoSQL(myCommand, "@IdFacturaVenta_RecuperoGastos", .IdFacturaVenta_RecuperoGastos)
                    NETtoSQL(myCommand, "@IdNotaCreditoVenta_RecuperoGastos", .IdNotaCreditoVenta_RecuperoGastos)
                    NETtoSQL(myCommand, "@IdComprobanteImputado", .IdComprobanteImputado)
                    NETtoSQL(myCommand, "@IdCuentaOtros", .IdCuentaOtros)
                    NETtoSQL(myCommand, "@PRESTOFechaProceso", .PRESTOFechaProceso)
                    NETtoSQL(myCommand, "@DestinoPago", .DestinoPago)
                    NETtoSQL(myCommand, "@NumeroRendicionFF", .NumeroRendicionFF)
                    NETtoSQL(myCommand, "@Cuit", .Cuit)
                    NETtoSQL(myCommand, "@FechaAsignacionPresupuesto", .FechaAsignacionPresupuesto)
                    NETtoSQL(myCommand, "@Dolarizada", .Dolarizada)
                    NETtoSQL(myCommand, "@NumeroOrdenPagoFondoReparo", .NumeroOrdenPagoFondoReparo)
                    NETtoSQL(myCommand, "@IdListaPrecios", .IdListaPrecios)
                    NETtoSQL(myCommand, "@IdComprobanteProveedorOriginal", .IdComprobanteProveedorOriginal)
                    NETtoSQL(myCommand, "@PorcentajeIVAParaMonotributistas", .PorcentajeIVAParaMonotributistas)
                    NETtoSQL(myCommand, "@IdDiferenciaCambio", .IdDiferenciaCambio)
                    NETtoSQL(myCommand, "@TomarEnCuboDeGastos", .TomarEnCuboDeGastos)
                    NETtoSQL(myCommand, "@ConfirmadoPorWeb", .ConfirmadoPorWeb)
                    NETtoSQL(myCommand, "@CircuitoFirmasCompleto", .CircuitoFirmasCompleto)
                    NETtoSQL(myCommand, "@IdLiquidacionFlete", .IdLiquidacionFlete)
                    NETtoSQL(myCommand, "@NumeroCAE", .NumeroCAE)



                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    For Each Item As ComprobanteProveedorItem In .Detalles
                        Item.IdComprobanteProveedor = result
                        ComprobanteProveedorItemDB.Save(SC, Item)
                    Next

                    If Not IsNothing(.DetallesProvincias) Then
                        For Each Item As ComprobanteProveedorProvinciasItem In .DetallesProvincias
                            Item.IdComprobanteProveedor = result
                            ComprobanteProveedorProvinciasItemDB.Save(SC, Item)
                        Next
                    End If

                    Transaccion.Commit()
                    myConnection.Close()
                End With


            Catch e As Exception
                Transaccion.Rollback()
                Debug.Print(e.Message)
                Throw New ApplicationException("Error en la grabacion " + e.Message, e)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wComprobantesProveedores_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdComprobanteProveedor", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As ComprobanteProveedor
            Dim myComprobanteProveedor As ComprobanteProveedor = New ComprobanteProveedor

            With myComprobanteProveedor
                SQLtoNET(myDataRecord, "@IdComprobanteProveedor", .Id)

                SQLtoNET(myDataRecord, "@IdProveedor", .IdProveedor)
                SQLtoNET(myDataRecord, "@IdTipoComprobante", .IdTipoComprobante)
                SQLtoNET(myDataRecord, "@FechaComprobante", .FechaComprobante)
                SQLtoNET(myDataRecord, "@Letra", .Letra)
                SQLtoNET(myDataRecord, "@NumeroComprobante1", .NumeroComprobante1)
                SQLtoNET(myDataRecord, "@NumeroComprobante2", .NumeroComprobante2)
                SQLtoNET(myDataRecord, "@NumeroReferencia", .NumeroReferencia)
                SQLtoNET(myDataRecord, "@FechaRecepcion", .FechaRecepcion)
                SQLtoNET(myDataRecord, "@FechaVencimiento", .FechaVencimiento)
                SQLtoNET(myDataRecord, "@TotalBruto", .TotalBruto)
                SQLtoNET(myDataRecord, "@TotalIva1", .TotalIva1)
                SQLtoNET(myDataRecord, "@TotalIva2", .TotalIva2)
                SQLtoNET(myDataRecord, "@TotalBonificacion", .TotalBonificacion)
                SQLtoNET(myDataRecord, "@TotalComprobante", .TotalComprobante)
                SQLtoNET(myDataRecord, "@PorcentajeBonificacion", .PorcentajeBonificacion)
                SQLtoNET(myDataRecord, "@Observaciones", .Observaciones)
                SQLtoNET(myDataRecord, "@DiasVencimiento", .DiasVencimiento)
                SQLtoNET(myDataRecord, "@IdObra", .IdObra)
                SQLtoNET(myDataRecord, "@IdProveedorEventual", .IdProveedorEventual)
                SQLtoNET(myDataRecord, "@IdOrdenPago", .IdOrdenPago)
                SQLtoNET(myDataRecord, "@IdCuenta", .IdCuenta)
                SQLtoNET(myDataRecord, "@IdMoneda", .IdMoneda)
                SQLtoNET(myDataRecord, "@CotizacionMoneda", .CotizacionMoneda)
                SQLtoNET(myDataRecord, "@CotizacionDolar", .CotizacionDolar)
                SQLtoNET(myDataRecord, "@TotalIVANoDiscriminado", .TotalIVANoDiscriminado)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras1", .IdCuentaIvaCompras1)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje1", .IVAComprasPorcentaje1)
                SQLtoNET(myDataRecord, "@IVAComprasImporte1", .IVAComprasImporte1)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras2", .IdCuentaIvaCompras2)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje2", .IVAComprasPorcentaje2)
                SQLtoNET(myDataRecord, "@IVAComprasImporte2", .IVAComprasImporte2)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras3", .IdCuentaIvaCompras3)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje3", .IVAComprasPorcentaje3)
                SQLtoNET(myDataRecord, "@IVAComprasImporte3", .IVAComprasImporte3)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras4", .IdCuentaIvaCompras4)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje4", .IVAComprasPorcentaje4)
                SQLtoNET(myDataRecord, "@IVAComprasImporte4", .IVAComprasImporte4)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras5", .IdCuentaIvaCompras5)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje5", .IVAComprasPorcentaje5)
                SQLtoNET(myDataRecord, "@IVAComprasImporte5", .IVAComprasImporte5)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras6", .IdCuentaIvaCompras6)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje6", .IVAComprasPorcentaje6)
                SQLtoNET(myDataRecord, "@IVAComprasImporte6", .IVAComprasImporte6)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras7", .IdCuentaIvaCompras7)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje7", .IVAComprasPorcentaje7)
                SQLtoNET(myDataRecord, "@IVAComprasImporte7", .IVAComprasImporte7)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras8", .IdCuentaIvaCompras8)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje8", .IVAComprasPorcentaje8)
                SQLtoNET(myDataRecord, "@IVAComprasImporte8", .IVAComprasImporte8)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras9", .IdCuentaIvaCompras9)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje9", .IVAComprasPorcentaje9)
                SQLtoNET(myDataRecord, "@IVAComprasImporte9", .IVAComprasImporte9)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras10", .IdCuentaIvaCompras10)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje10", .IVAComprasPorcentaje10)
                SQLtoNET(myDataRecord, "@IVAComprasImporte10", .IVAComprasImporte10)
                SQLtoNET(myDataRecord, "@SubtotalGravado", .SubtotalGravado)
                SQLtoNET(myDataRecord, "@SubtotalExento", .SubtotalExento)
                SQLtoNET(myDataRecord, "@AjusteIVA", .AjusteIVA)
                SQLtoNET(myDataRecord, "@PorcentajeIVAAplicacionAjuste", .PorcentajeIVAAplicacionAjuste)
                SQLtoNET(myDataRecord, "@BienesOServicios", .BienesOServicios)
                SQLtoNET(myDataRecord, "@IdDetalleOrdenPagoRetencionIVAAplicada", .IdDetalleOrdenPagoRetencionIVAAplicada)
                SQLtoNET(myDataRecord, "@IdIBCondicion", .IdIBCondicion)
                SQLtoNET(myDataRecord, "@PRESTOFactura", .PRESTOFactura)
                SQLtoNET(myDataRecord, "@Confirmado", .Confirmado)
                SQLtoNET(myDataRecord, "@IdProvinciaDestino", .IdProvinciaDestino)
                SQLtoNET(myDataRecord, "@IdTipoRetencionGanancia", .IdTipoRetencionGanancia)
                SQLtoNET(myDataRecord, "@NumeroCAI", .NumeroCAI)
                SQLtoNET(myDataRecord, "@FechaVencimientoCAI", .FechaVencimientoCAI)
                SQLtoNET(myDataRecord, "@IdCodigoAduana", .IdCodigoAduana)
                SQLtoNET(myDataRecord, "@IdCodigoDestinacion", .IdCodigoDestinacion)
                SQLtoNET(myDataRecord, "@NumeroDespacho", .NumeroDespacho)
                SQLtoNET(myDataRecord, "@DigitoVerificadorNumeroDespacho", .DigitoVerificadorNumeroDespacho)
                SQLtoNET(myDataRecord, "@FechaDespachoAPlaza", .FechaDespachoAPlaza)
                SQLtoNET(myDataRecord, "@IdUsuarioIngreso", .IdUsuarioIngreso)
                SQLtoNET(myDataRecord, "@FechaIngreso", .FechaIngreso)
                SQLtoNET(myDataRecord, "@IdUsuarioModifico", .IdUsuarioModifico)
                SQLtoNET(myDataRecord, "@FechaModifico", .FechaModifico)
                SQLtoNET(myDataRecord, "@PRESTOProveedor", .PRESTOProveedor)
                SQLtoNET(myDataRecord, "@IdCodigoIva", .IdCodigoIva)
                SQLtoNET(myDataRecord, "@CotizacionEuro", .CotizacionEuro)
                SQLtoNET(myDataRecord, "@IdCondicionCompra", .IdCondicionCompra)
                SQLtoNET(myDataRecord, "@Importacion_FOB", .Importacion_FOB)
                SQLtoNET(myDataRecord, "@Importacion_PosicionAduana", .Importacion_PosicionAduana)
                SQLtoNET(myDataRecord, "@Importacion_Despacho", .Importacion_Despacho)
                SQLtoNET(myDataRecord, "@Importacion_Guia", .Importacion_Guia)
                SQLtoNET(myDataRecord, "@Importacion_IdPaisOrigen", .Importacion_IdPaisOrigen)
                SQLtoNET(myDataRecord, "@Importacion_FechaEmbarque", .Importacion_FechaEmbarque)
                SQLtoNET(myDataRecord, "@Importacion_FechaOficializacion", .Importacion_FechaOficializacion)
                SQLtoNET(myDataRecord, "@REP_CTAPRO_INS", .REP_CTAPRO_INS)
                SQLtoNET(myDataRecord, "@REP_CTAPRO_UPD", .REP_CTAPRO_UPD)
                SQLtoNET(myDataRecord, "@InformacionAuxiliar", .InformacionAuxiliar)
                SQLtoNET(myDataRecord, "@GravadoParaSUSS", .GravadoParaSUSS)
                SQLtoNET(myDataRecord, "@PorcentajeParaSUSS", .PorcentajeParaSUSS)
                SQLtoNET(myDataRecord, "@FondoReparo", .FondoReparo)
                SQLtoNET(myDataRecord, "@AutoincrementarNumeroReferencia", .AutoincrementarNumeroReferencia)
                SQLtoNET(myDataRecord, "@ReintegroImporte", .ReintegroImporte)
                SQLtoNET(myDataRecord, "@ReintegroDespacho", .ReintegroDespacho)
                SQLtoNET(myDataRecord, "@ReintegroIdMoneda", .ReintegroIdMoneda)
                SQLtoNET(myDataRecord, "@ReintegroIdCuenta", .ReintegroIdCuenta)
                SQLtoNET(myDataRecord, "@PrestoDestino", .PrestoDestino)
                SQLtoNET(myDataRecord, "@IdFacturaVenta_RecuperoGastos", .IdFacturaVenta_RecuperoGastos)
                SQLtoNET(myDataRecord, "@IdNotaCreditoVenta_RecuperoGastos", .IdNotaCreditoVenta_RecuperoGastos)
                SQLtoNET(myDataRecord, "@IdComprobanteImputado", .IdComprobanteImputado)
                SQLtoNET(myDataRecord, "@IdCuentaOtros", .IdCuentaOtros)
                SQLtoNET(myDataRecord, "@PRESTOFechaProceso", .PRESTOFechaProceso)
                SQLtoNET(myDataRecord, "@DestinoPago", .DestinoPago)
                SQLtoNET(myDataRecord, "@NumeroRendicionFF", .NumeroRendicionFF)
                SQLtoNET(myDataRecord, "@Cuit", .Cuit)
                SQLtoNET(myDataRecord, "@FechaAsignacionPresupuesto", .FechaAsignacionPresupuesto)
                SQLtoNET(myDataRecord, "@Dolarizada", .Dolarizada)
                SQLtoNET(myDataRecord, "@NumeroOrdenPagoFondoReparo", .NumeroOrdenPagoFondoReparo)
                SQLtoNET(myDataRecord, "@IdListaPrecios", .IdListaPrecios)
                SQLtoNET(myDataRecord, "@IdComprobanteProveedorOriginal", .IdComprobanteProveedorOriginal)
                SQLtoNET(myDataRecord, "@PorcentajeIVAParaMonotributistas", .PorcentajeIVAParaMonotributistas)
                SQLtoNET(myDataRecord, "@IdDiferenciaCambio", .IdDiferenciaCambio)
                SQLtoNET(myDataRecord, "@TomarEnCuboDeGastos", .TomarEnCuboDeGastos)
                SQLtoNET(myDataRecord, "@ConfirmadoPorWeb", .ConfirmadoPorWeb)
                SQLtoNET(myDataRecord, "@CircuitoFirmasCompleto", .CircuitoFirmasCompleto)
                SQLtoNET(myDataRecord, "@IdLiquidacionFlete", .IdLiquidacionFlete)
                SQLtoNET(myDataRecord, "@NumeroCAE", .NumeroCAE)

            End With


            Return myComprobanteProveedor
        End Function
    End Class
End Namespace