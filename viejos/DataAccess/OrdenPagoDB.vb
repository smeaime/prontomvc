Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class OrdenPagoDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As OrdenPago
            Dim myOrdenPago As OrdenPago = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try


                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.OrdenesPago_T.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdOrdenPago", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myOrdenPago = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myOrdenPago
        End Function

        Public Shared Function GetList(ByVal SC As String) As OrdenPagoList
            Dim tempList As OrdenPagoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.OrdenesPago_T.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New OrdenPagoList
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

        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String) As OrdenPagoList

            Dim tempList As OrdenPagoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wOrdenPagos_T_ByEmployee", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdSolicito", IdSolicito)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New OrdenPagoList
                        While myReader.Read
                            'tempList.Add(FillDataRecord(myReader))
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
            Dim tempList As OrdenPagoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
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
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wOrdenPagos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdOrdenPago", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myOrdenPago As OrdenPago) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand
                With myOrdenPago


                    If .Id = -1 Then

                        myCommand = New SqlCommand(enumSPs.OrdenesPago_A.ToString, myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdOrdenPago", -1)
                        param.Direction = ParameterDirection.Output

                    Else

                        myCommand = New SqlCommand(enumSPs.OrdenesPago_M.ToString, myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        myCommand.Parameters.AddWithValue("@IdOrdenPago", .Id)
                    End If


                    'NETtoSQL(myCommand, "@IdCliente", .IdCliente)


                    NETtoSQL(myCommand, "@NumeroOrdenPago", .NumeroOrdenPago)
                    NETtoSQL(myCommand, "@FechaOrdenPago", .FechaOrdenPago)
                    NETtoSQL(myCommand, "@IdProveedor", .IdProveedor)
                    NETtoSQL(myCommand, "@Efectivo", .Efectivo)

                    NETtoSQL(myCommand, "@Descuentos", .Descuentos)
                    NETtoSQL(myCommand, "@Valores", .Valores)
                    NETtoSQL(myCommand, "@Documentos", .Documentos)
                    NETtoSQL(myCommand, "@Otros1", .Otros1)
                    NETtoSQL(myCommand, "@IdCuenta1", .IdCuenta1)
                    NETtoSQL(myCommand, "@Otros2", .Otros2)
                    NETtoSQL(myCommand, "@IdCuenta2", .IdCuenta2)
                    NETtoSQL(myCommand, "@Otros3", .Otros3)
                    NETtoSQL(myCommand, "@IdCuenta3", .IdCuenta3)
                    NETtoSQL(myCommand, "@Acreedores", .Acreedores)
                    NETtoSQL(myCommand, "@RetencionIVA", .RetencionIVA)
                    NETtoSQL(myCommand, "@RetencionGanancias", .RetencionGanancias)
                    NETtoSQL(myCommand, "@RetencionIBrutos", .RetencionIBrutos)
                    NETtoSQL(myCommand, "@GastosGenerales", .GastosGenerales)
                    NETtoSQL(myCommand, "@Estado", .Estado)
                    NETtoSQL(myCommand, "@IdCuenta", .IdCuenta)
                    NETtoSQL(myCommand, "@Tipo", .Tipo)



                    NETtoSQL(myCommand, "@Anulada", .Anulada)


                    NETtoSQL(myCommand, "@CotizacionDolar", .CotizacionDolar)
                    NETtoSQL(myCommand, "@Dolarizada", .Dolarizada)
                    NETtoSQL(myCommand, "@Exterior", .Exterior)
                    NETtoSQL(myCommand, "@NumeroCertificadoRetencionGanancias", .NumeroCertificadoRetencionGanancias)
                    NETtoSQL(myCommand, "@BaseGanancias", .BaseGanancias)
                    NETtoSQL(myCommand, "@IdMoneda", .IdMoneda)
                    NETtoSQL(myCommand, "@CotizacionMoneda", .CotizacionMoneda)
                    NETtoSQL(myCommand, "@AsientoManual", .AsientoManual)
                    NETtoSQL(myCommand, "@Observaciones", .Observaciones)
                    NETtoSQL(myCommand, "@IdObra", .IdObra)
                    NETtoSQL(myCommand, "@IdCuentaGasto", .IdCuentaGasto)
                    NETtoSQL(myCommand, "@DiferenciaBalanceo", .DiferenciaBalanceo)
                    NETtoSQL(myCommand, "@IdOPComplementariaFF", .IdOPComplementariaFF)
                    NETtoSQL(myCommand, "@IdEmpleadoFF", .IdEmpleadoFF)
                    NETtoSQL(myCommand, "@NumeroCertificadoRetencionIVA", .NumeroCertificadoRetencionIVA)
                    NETtoSQL(myCommand, "@NumeroCertificadoRetencionIIBB", .NumeroCertificadoRetencionIIBB)

                    NETtoSQL(myCommand, "@RetencionSUSS", .RetencionSUSS)
                    NETtoSQL(myCommand, "@NumeroCertificadoRetencionSUSS", .NumeroCertificadoRetencionSUSS)
                    NETtoSQL(myCommand, "@TipoOperacionOtros", .TipoOperacionOtros)
                    NETtoSQL(myCommand, "@IdUsuarioIngreso", .IdUsuarioIngreso)
                    NETtoSQL(myCommand, "@FechaIngreso", .FechaIngreso)
                    NETtoSQL(myCommand, "@IdUsuarioModifico", .IdUsuarioModifico)
                    NETtoSQL(myCommand, "@FechaModifico", .FechaModifico)
                    NETtoSQL(myCommand, "@Confirmado", .Confirmado)
                    NETtoSQL(myCommand, "@IdObraOrigen", .IdObraOrigen)
                    NETtoSQL(myCommand, "@CotizacionEuro", .CotizacionEuro)
                    NETtoSQL(myCommand, "@TipoGrabacion", .TipoGrabacion)
                    NETtoSQL(myCommand, "@IdProvinciaDestino", .IdProvinciaDestino)
                    NETtoSQL(myCommand, "@CalculaSUSS", .CalculaSUSS)
                    NETtoSQL(myCommand, "@RetencionIVAComprobantesM", .RetencionIVAComprobantesM)
                    NETtoSQL(myCommand, "@IdUsuarioAnulo", .IdUsuarioAnulo)
                    NETtoSQL(myCommand, "@FechaAnulacion", .FechaAnulacion)
                    NETtoSQL(myCommand, "@MotivoAnulacion", .MotivoAnulacion)
                    NETtoSQL(myCommand, "@NumeroRendicionFF", .NumeroRendicionFF)
                    NETtoSQL(myCommand, "@ConfirmacionAcreditacionFF", .ConfirmacionAcreditacionFF)
                    NETtoSQL(myCommand, "@OPInicialFF", .OPInicialFF)
                    NETtoSQL(myCommand, "@IdConcepto", .IdConcepto)
                    NETtoSQL(myCommand, "@IdConcepto2", .IdConcepto2)
                    NETtoSQL(myCommand, "@FormaAnulacionCheques", .FormaAnulacionCheques)
                    NETtoSQL(myCommand, "@Detalle", .Detalle)
                    NETtoSQL(myCommand, "@RecalculoRetencionesUltimaModificacion", .RecalculoRetencionesUltimaModificacion)
                    NETtoSQL(myCommand, "@IdImpuestoDirecto", .IdImpuestoDirecto)
                    NETtoSQL(myCommand, "@NumeroReciboProveedor", .NumeroReciboProveedor)
                    NETtoSQL(myCommand, "@FechaReciboProveedor", .FechaReciboProveedor)




                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    For Each myOrdenPagoItem As OrdenPagoItem In myOrdenPago.DetallesImputaciones
                        myOrdenPagoItem.IdOrdenPago = result




                        If myOrdenPagoItem.Eliminado Then
                            'EntidadManager.GetStoreProcedure(SC, "DetOrdenPagos_E", .Id)
                        Else
                            Dim IdAntesDeGrabar = myOrdenPagoItem.Id
                            myOrdenPagoItem.Id = OrdenPagoItemDB.Save(SC, myOrdenPagoItem)


                            'Como un item nuevo consiguió un nuevo id al grabarse, 
                            'lo tengo que refrescar en el resto de las colecciones
                            'de imputacion (en el prontovb6, se usaba -100,-101,etc)
                            '-OK, eso si los items del resto de las colecciones (Valores,Cuentas)
                            'estuviesen imputadas contra la de Imputaciones. Pero, de donde demonios saqué
                            'que esto es así?

                            'For Each o As OrdenPagoAnticiposAlPersonalItem In .DetallesAnticiposAlPersonal
                            '    If o. = IdAntesDeGrabar Then
                            '        o. = myOrdenPagoItem.Id
                            '    End If
                            'Next

                            'For Each o As OrdenPagoCuentasItem In .DetallesCuentas
                            '    If o. = IdAntesDeGrabar Then
                            '        o. = myOrdenPagoItem.Id
                            '    End If
                            'Next
                        End If
                    Next


                    ''//////////////////////////////////////////////////////////////////////////////////////
                    'Colecciones adicionales
                    ''//////////////////////////////////////////////////////////////////////////////////////

                    For Each myOrdenPagoAnticiposAlPersonalItem As OrdenPagoAnticiposAlPersonalItem In myOrdenPago.DetallesAnticiposAlPersonal
                        myOrdenPagoAnticiposAlPersonalItem.IdOrdenPago = result
                        OrdenPagoAnticiposAlPersonalItemDB.Save(SC, myOrdenPagoAnticiposAlPersonalItem)
                    Next
                    For Each myOrdenPagoCuentasItem As OrdenPagoCuentasItem In myOrdenPago.DetallesCuentas
                        myOrdenPagoCuentasItem.IdOrdenPago = result
                        OrdenPagoCuentasItemDB.Save(SC, myOrdenPagoCuentasItem)
                    Next
                    For Each myOrdenPagoValoresItem As OrdenPagoValoresItem In myOrdenPago.DetallesValores
                        myOrdenPagoValoresItem.IdOrdenPago = result
                        OrdenPagoValoresItemDB.Save(SC, myOrdenPagoValoresItem)
                    Next

                    For Each myOrdenPagoRubrosContablesItem As OrdenPagoRubrosContablesItem In myOrdenPago.DetallesRubrosContables
                        myOrdenPagoRubrosContablesItem.IdOrdenPago = result
                        OrdenPagoRubrosContablesItemDB.Save(SC, myOrdenPagoRubrosContablesItem)
                    Next

                    For Each myOrdenPagoImpuestosItem As OrdenPagoImpuestosItem In myOrdenPago.DetallesImpuestos
                        myOrdenPagoImpuestosItem.IdOrdenPago = result
                        OrdenPagoImpuestosItemDB.Save(SC, myOrdenPagoImpuestosItem)
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
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wOrdenPagos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdOrdenPago", id)
                myConnection.Open()

                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Public Shared Function Anular(ByVal SC As String, ByVal IdOrdenPago As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wOrdenPagos_N", myConnection)
                myCommand.Transaction = Transaccion
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdOrdenPago", IdOrdenPago)
                result = myCommand.ExecuteNonQuery
                Transaccion.Commit()
                myConnection.Close()
            Catch e As Exception
                Transaccion.Rollback()
                ErrHandler.WriteAndRaiseError(e)
                'Return -1 'qué conviene usar? disparar errores o devolver -1?
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As OrdenPago
            Dim myOrdenPago As OrdenPago = New OrdenPago
            With myOrdenPago

                'SQLtoNET(.Id, "IdOrdenPago", myDataRecord)
                'SQLtoNET(.NumeroOrdenPago, "NumeroOrdenPago", myDataRecord)
                'SQLtoNET(.TipoABC, "TipoABC", myDataRecord)
                'SQLtoNET(.PuntoVenta, "PuntoVenta", myDataRecord)
                'SQLtoNET(.IdCliente, "IdCliente", myDataRecord)
                'SQLtoNET(.FechaOrdenPago, "FechaOrdenPago", myDataRecord)
                'SQLtoNET(.IdVendedor, "IdVendedor", myDataRecord)
                'SQLtoNET(.ImporteTotal, "ImporteTotal", myDataRecord)
                'SQLtoNET(.ImporteIva1, "ImporteIva1", myDataRecord)
                'SQLtoNET(.ImporteIva2, "ImporteIva2", myDataRecord)
                'SQLtoNET(.RetencionIBrutos1, "RetencionIBrutos1", myDataRecord)
                'SQLtoNET(.PorcentajeIBrutos1, "PorcentajeIBrutos1", myDataRecord)
                'SQLtoNET(.RetencionIBrutos2, "RetencionIBrutos2", myDataRecord)
                'SQLtoNET(.PorcentajeIBrutos2, "PorcentajeIBrutos2", myDataRecord)
                'SQLtoNET(.IdCodigoIva, "IdCodigoIva", myDataRecord)
                'SQLtoNET(.PorcentajeIva1, "PorcentajeIva1", myDataRecord)
                'SQLtoNET(.PorcentajeIva2, "PorcentajeIva2", myDataRecord)
                'SQLtoNET(.Observaciones, "Observaciones", myDataRecord)
                'SQLtoNET(.ImporteIvaIncluido, "ImporteIvaIncluido", myDataRecord)
                'SQLtoNET(.CotizacionDolar, "CotizacionDolar", myDataRecord)
                'SQLtoNET(.CtaCte, "CtaCte", myDataRecord)
                'SQLtoNET(.IdMoneda, "IdMoneda", myDataRecord)
                'SQLtoNET(.CotizacionMoneda, "CotizacionMoneda", myDataRecord)
                'SQLtoNET(.IVANoDiscriminado, "IVANoDiscriminado", myDataRecord)
                'SQLtoNET(.ConvenioMultilateral, "ConvenioMultilateral", myDataRecord)
                'SQLtoNET(.OtrasPercepciones1, "OtrasPercepciones1", myDataRecord)
                'SQLtoNET(.OtrasPercepciones1Desc, "OtrasPercepciones1Desc", myDataRecord)
                'SQLtoNET(.OtrasPercepciones2, "OtrasPercepciones2", myDataRecord)
                'SQLtoNET(.OtrasPercepciones2Desc, "OtrasPercepciones2Desc", myDataRecord)
                'SQLtoNET(.IdProvinciaDestino, "IdProvinciaDestino", myDataRecord)
                'SQLtoNET(.IdIBCondicion, "IdIBCondicion", myDataRecord)
                'SQLtoNET(.IdPuntoVenta, "IdPuntoVenta", myDataRecord)
                'SQLtoNET(.Anulada, "Anulada", myDataRecord)
                'SQLtoNET(.IdUsuarioAnulacion, "IdUsuarioAnulacion", myDataRecord)
                'SQLtoNET(.FechaAnulacion, "FechaAnulacion", myDataRecord)
                'SQLtoNET(.NumeroCAI, "NumeroCAI", myDataRecord)
                'SQLtoNET(.FechaVencimientoCAI, "FechaVencimientoCAI", myDataRecord)
                'SQLtoNET(.IdObra, "IdObra", myDataRecord)
                'SQLtoNET(.NumeroCertificadoPercepcionIIBB, "NumeroCertificadoPercepcionIIBB", myDataRecord)
                'SQLtoNET(.IdVentaEnCuotas, "IdVentaEnCuotas", myDataRecord)
                'SQLtoNET(.NumeroCuota, "NumeroCuota", myDataRecord)
                'SQLtoNET(.IdUsuarioIngreso, "IdUsuarioIngreso", myDataRecord)
                'SQLtoNET(.FechaIngreso, "FechaIngreso", myDataRecord)
                'SQLtoNET(.AplicarEnCtaCte, "AplicarEnCtaCte", myDataRecord)
                'SQLtoNET(.IdIBCondicion2, "IdIBCondicion2", myDataRecord)
                'SQLtoNET(.OtrasPercepciones3, "OtrasPercepciones3", myDataRecord)
                'SQLtoNET(.OtrasPercepciones3Desc, "OtrasPercepciones3Desc", myDataRecord)
                'SQLtoNET(.NoIncluirEnCubos, "NoIncluirEnCubos", myDataRecord)
                'SQLtoNET(.PercepcionIVA, "PercepcionIVA", myDataRecord)
                'SQLtoNET(.PorcentajePercepcionIVA, "PorcentajePercepcionIVA", myDataRecord)
                'SQLtoNET(.IdNotaCreditoVenta_RecuperoGastos, "IdNotaCreditoVenta_RecuperoGastos", myDataRecord)
                'SQLtoNET(.IdListaPrecios, "IdListaPrecios", myDataRecord)
                'SQLtoNET(.IdIBCondicion3, "IdIBCondicion3", myDataRecord)
                'SQLtoNET(.RetencionIBrutos3, "RetencionIBrutos3", myDataRecord)
                'SQLtoNET(.PorcentajeIBrutos3, "PorcentajeIBrutos3", myDataRecord)
                'SQLtoNET(.CAE, "CAE", myDataRecord)
                'SQLtoNET(.RechazoCAE, "RechazoCAE", myDataRecord)
                'SQLtoNET(.FechaVencimientoORechazoCAE, "FechaVencimientoORechazoCAE", myDataRecord)
                'SQLtoNET(.IdIdentificacionCAE, "IdIdentificacionCAE", myDataRecord)

                SQLtoNET(myDataRecord, "@IdOrdenPago", .Id)

                SQLtoNET(myDataRecord, "@NumeroOrdenPago", .NumeroOrdenPago)
                SQLtoNET(myDataRecord, "@FechaOrdenPago", .FechaOrdenPago)
                SQLtoNET(myDataRecord, "@IdProveedor", .IdProveedor)
                SQLtoNET(myDataRecord, "@Efectivo", .Efectivo)

                SQLtoNET(myDataRecord, "@Descuentos", .Descuentos)
                SQLtoNET(myDataRecord, "@Valores", .Valores)
                SQLtoNET(myDataRecord, "@Documentos", .Documentos)
                SQLtoNET(myDataRecord, "@Otros1", .Otros1)
                SQLtoNET(myDataRecord, "@IdCuenta1", .IdCuenta1)
                SQLtoNET(myDataRecord, "@Otros2", .Otros2)
                SQLtoNET(myDataRecord, "@IdCuenta2", .IdCuenta2)
                SQLtoNET(myDataRecord, "@Otros3", .Otros3)
                SQLtoNET(myDataRecord, "@IdCuenta3", .IdCuenta3)
                SQLtoNET(myDataRecord, "@Acreedores", .Acreedores)
                SQLtoNET(myDataRecord, "@RetencionIVA", .RetencionIVA)
                SQLtoNET(myDataRecord, "@RetencionGanancias", .RetencionGanancias)
                SQLtoNET(myDataRecord, "@RetencionIBrutos", .RetencionIBrutos)
                SQLtoNET(myDataRecord, "@GastosGenerales", .GastosGenerales)
                SQLtoNET(myDataRecord, "@Estado", .Estado)
                SQLtoNET(myDataRecord, "@IdCuenta", .IdCuenta)
                SQLtoNET(myDataRecord, "@Tipo", .Tipo)



                SQLtoNET(myDataRecord, "@Anulada", .Anulada)


                SQLtoNET(myDataRecord, "@CotizacionDolar", .CotizacionDolar)
                SQLtoNET(myDataRecord, "@Dolarizada", .Dolarizada)
                SQLtoNET(myDataRecord, "@Exterior", .Exterior)
                SQLtoNET(myDataRecord, "@NumeroCertificadoRetencionGanancias", .NumeroCertificadoRetencionGanancias)
                SQLtoNET(myDataRecord, "@BaseGanancias", .BaseGanancias)
                SQLtoNET(myDataRecord, "@IdMoneda", .IdMoneda)
                SQLtoNET(myDataRecord, "@CotizacionMoneda", .CotizacionMoneda)
                SQLtoNET(myDataRecord, "@AsientoManual", .AsientoManual)
                SQLtoNET(myDataRecord, "@Observaciones", .Observaciones)
                SQLtoNET(myDataRecord, "@IdObra", .IdObra)
                SQLtoNET(myDataRecord, "@IdCuentaGasto", .IdCuentaGasto)
                SQLtoNET(myDataRecord, "@DiferenciaBalanceo", .DiferenciaBalanceo)
                SQLtoNET(myDataRecord, "@IdOPComplementariaFF", .IdOPComplementariaFF)
                SQLtoNET(myDataRecord, "@IdEmpleadoFF", .IdEmpleadoFF)
                SQLtoNET(myDataRecord, "@NumeroCertificadoRetencionIVA", .NumeroCertificadoRetencionIVA)
                SQLtoNET(myDataRecord, "@NumeroCertificadoRetencionIIBB", .NumeroCertificadoRetencionIIBB)

                SQLtoNET(myDataRecord, "@RetencionSUSS", .RetencionSUSS)
                SQLtoNET(myDataRecord, "@NumeroCertificadoRetencionSUSS", .NumeroCertificadoRetencionSUSS)
                SQLtoNET(myDataRecord, "@TipoOperacionOtros", .TipoOperacionOtros)
                SQLtoNET(myDataRecord, "@IdUsuarioIngreso", .IdUsuarioIngreso)
                SQLtoNET(myDataRecord, "@FechaIngreso", .FechaIngreso)
                SQLtoNET(myDataRecord, "@IdUsuarioModifico", .IdUsuarioModifico)
                SQLtoNET(myDataRecord, "@FechaModifico", .FechaModifico)
                SQLtoNET(myDataRecord, "@Confirmado", .Confirmado)
                SQLtoNET(myDataRecord, "@IdObraOrigen", .IdObraOrigen)
                SQLtoNET(myDataRecord, "@CotizacionEuro", .CotizacionEuro)
                SQLtoNET(myDataRecord, "@TipoGrabacion", .TipoGrabacion)
                SQLtoNET(myDataRecord, "@IdProvinciaDestino", .IdProvinciaDestino)
                SQLtoNET(myDataRecord, "@CalculaSUSS", .CalculaSUSS)
                SQLtoNET(myDataRecord, "@RetencionIVAComprobantesM", .RetencionIVAComprobantesM)
                SQLtoNET(myDataRecord, "@IdUsuarioAnulo", .IdUsuarioAnulo)
                SQLtoNET(myDataRecord, "@FechaAnulacion", .FechaAnulacion)
                SQLtoNET(myDataRecord, "@MotivoAnulacion", .MotivoAnulacion)
                SQLtoNET(myDataRecord, "@NumeroRendicionFF", .NumeroRendicionFF)
                SQLtoNET(myDataRecord, "@ConfirmacionAcreditacionFF", .ConfirmacionAcreditacionFF)
                SQLtoNET(myDataRecord, "@OPInicialFF", .OPInicialFF)
                SQLtoNET(myDataRecord, "@IdConcepto", .IdConcepto)
                SQLtoNET(myDataRecord, "@IdConcepto2", .IdConcepto2)
                SQLtoNET(myDataRecord, "@FormaAnulacionCheques", .FormaAnulacionCheques)
                SQLtoNET(myDataRecord, "@Detalle", .Detalle)
                SQLtoNET(myDataRecord, "@RecalculoRetencionesUltimaModificacion", .RecalculoRetencionesUltimaModificacion)
                SQLtoNET(myDataRecord, "@IdImpuestoDirecto", .IdImpuestoDirecto)
                SQLtoNET(myDataRecord, "@NumeroReciboProveedor", .NumeroReciboProveedor)
                SQLtoNET(myDataRecord, "@FechaReciboProveedor", .FechaReciboProveedor)


                Return myOrdenPago
            End With
        End Function
    End Class
End Namespace