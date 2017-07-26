Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class NotaDeCreditoDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As NotaDeCredito
            Dim myNotaDeCredito As NotaDeCredito = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("NotasCredito_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdNotaCredito", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myNotaDeCredito = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myNotaDeCredito
        End Function

        Public Shared Function GetList(ByVal SC As String) As NotaDeCreditoList
            Dim tempList As NotaDeCreditoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wNotaDeCreditos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New NotaDeCreditoList
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

        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String) As NotaDeCreditoList

            Dim tempList As NotaDeCreditoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wNotaDeCreditos_T_ByEmployee", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdSolicito", IdSolicito)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New NotaDeCreditoList
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
            Dim tempList As NotaDeCreditoList = Nothing
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
                Dim myCommand As SqlCommand = New SqlCommand("wNotaDeCreditos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdNotaDeCredito", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myNotaDeCredito As NotaDeCredito) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand
                With myNotaDeCredito

                    If .Id = -1 Then

                        myCommand = New SqlCommand("NotasCredito_A", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdNotaCredito", -1)
                        param.Direction = ParameterDirection.Output

                    Else

                        myCommand = New SqlCommand("NotasCredito_M", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        myCommand.Parameters.AddWithValue("@IdNotaCredito", .Id)
                    End If





                    NETtoSQL(myCommand, "@NumeroNotaCredito", .Numero)
                    NETtoSQL(myCommand, "@TipoABC", .TipoABC)
                    NETtoSQL(myCommand, "@PuntoVenta", .PuntoVenta)
                    NETtoSQL(myCommand, "@IdCliente", .IdCliente)
                    NETtoSQL(myCommand, "@FechaNotaCredito", .Fecha)
                    NETtoSQL(myCommand, "@IdVendedor", .IdVendedor)
                    NETtoSQL(myCommand, "@ImporteTotal", .ImporteTotal)
                    NETtoSQL(myCommand, "@ImporteIva1", .ImporteIva1)
                    NETtoSQL(myCommand, "@ImporteIva2", .ImporteIva2)


                    NETtoSQL(myCommand, "@RetencionIBrutos1", .RetencionIBrutos1)
                    NETtoSQL(myCommand, "@PorcentajeIBrutos1", .PorcentajeIBrutos1)
                    NETtoSQL(myCommand, "@RetencionIBrutos2", .RetencionIBrutos2)
                    NETtoSQL(myCommand, "@PorcentajeIBrutos2", .PorcentajeIBrutos2)
                    NETtoSQL(myCommand, "@IdCodigoIva", .IdCodigoIva)
                    NETtoSQL(myCommand, "@PorcentajeIva1", .PorcentajeIva1)
                    NETtoSQL(myCommand, "@PorcentajeIva2", .PorcentajeIva2)
                    NETtoSQL(myCommand, "@Observaciones", .Observaciones)
                    NETtoSQL(myCommand, "@ImporteIvaIncluido", .ImporteIvaIncluido)
                    NETtoSQL(myCommand, "@CotizacionDolar", .CotizacionDolar)





                    NETtoSQL(myCommand, "@CtaCte", .CtaCte)
                    NETtoSQL(myCommand, "@IdMoneda", .IdMoneda)
                    NETtoSQL(myCommand, "@CotizacionMoneda", .CotizacionMoneda)
                    NETtoSQL(myCommand, "@IVANoDiscriminado", .IVANoDiscriminado)
                    NETtoSQL(myCommand, "@ConvenioMultilateral", .ConvenioMultilateral)
                    NETtoSQL(myCommand, "@OtrasPercepciones1", .OtrasPercepciones1)
                    NETtoSQL(myCommand, "@OtrasPercepciones1Desc", .OtrasPercepciones1Desc)
                    NETtoSQL(myCommand, "@OtrasPercepciones2", .OtrasPercepciones2)
                    NETtoSQL(myCommand, "@OtrasPercepciones2Desc", .OtrasPercepciones2Desc)
                    NETtoSQL(myCommand, "@IdProvinciaDestino", .IdProvinciaDestino)


                    NETtoSQL(myCommand, "@IdIBCondicion", .IdIBCondicion)


                    NETtoSQL(myCommand, "@IdPuntoVenta", .IdPuntoVenta)
                    NETtoSQL(myCommand, "@Anulada", .anulada)
                    NETtoSQL(myCommand, "@IdUsuarioAnulacion", .IdUsuarioAnulacion)
                    NETtoSQL(myCommand, "@FechaAnulacion", .FechaAnulacion)





                    NETtoSQL(myCommand, "@NumeroCAI", .NumeroCAI)
                    NETtoSQL(myCommand, "@FechaVencimientoCAI", .FechaVencimientoCAI)
                    NETtoSQL(myCommand, "@IdObra", .IdObra)

                    NETtoSQL(myCommand, "@IdUsuarioIngreso", .IdUsuarioIngreso)
                    NETtoSQL(myCommand, "@FechaIngreso", .FechaIngreso)

                    NETtoSQL(myCommand, "@AplicarEnCtaCte", .AplicarEnCtaCte)
                    NETtoSQL(myCommand, "@IdIBCondicion2", .IdIBCondicion2)
                    NETtoSQL(myCommand, "@OtrasPercepciones3", .OtrasPercepciones3)
                    NETtoSQL(myCommand, "@OtrasPercepciones3Desc", .OtrasPercepciones3Desc)
                    NETtoSQL(myCommand, "@NoIncluirEnCubos", .NoIncluirEnCubos)
                    NETtoSQL(myCommand, "@PercepcionIVA", .PercepcionIVA)
                    NETtoSQL(myCommand, "@PorcentajePercepcionIVA", .PorcentajePercepcionIVA)
                    NETtoSQL(myCommand, "@ActivarRecuperoGastos", .ActivarRecuperoGastos)





                    NETtoSQL(myCommand, "@IdAutorizoRecuperoGastos", .IdAutorizoRecuperoGastos)
                    NETtoSQL(myCommand, "@IdFacturaVenta_RecuperoGastos", .IdFacturaVenta_RecuperoGastos)
                    NETtoSQL(myCommand, "@IdListaPrecios", .IdListaPrecios)
                    NETtoSQL(myCommand, "@IdIBCondicion3", .IdIBCondicion3)
                    NETtoSQL(myCommand, "@RetencionIBrutos3", .RetencionIBrutos3)
                    NETtoSQL(myCommand, "@PorcentajeIBrutos3", .PorcentajeIBrutos3)

                    NETtoSQL(myCommand, "@CAE", .CAE)
                    NETtoSQL(myCommand, "@RechazoCAE", .RechazoCAE)
                    NETtoSQL(myCommand, "@FechaVencimientoORechazoCAE", .FechaVencimientoORechazoCAE)
                    NETtoSQL(myCommand, "@IdIdentificacionCAE", .IdIdentificacionCAE)

                    NETtoSQL(myCommand, "@CodigoIdAuxiliar", .CodigoIdAuxiliar)
                    NETtoSQL(myCommand, "@NumeroFacturaOriginal", .NumeroFacturaOriginal)



                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    For Each myNotaDeCreditoItem As NotaDeCreditoItem In myNotaDeCredito.Detalles


                        myNotaDeCreditoItem.IdNotaCredito = result

                        If myNotaDeCreditoItem.Eliminado Then
                        Else
                            NotaDeCreditoItemDB.Save(SC, myNotaDeCreditoItem)
                        End If
                    Next

                    For Each myNotaDeCreditoImputacionItem As NotaDeCreditoImpItem In myNotaDeCredito.DetallesImp
                        myNotaDeCreditoImputacionItem.IdNotaCredito = result
                        If myNotaDeCreditoImputacionItem.Eliminado Then
                        Else
                            NotaDeCreditoImpItemDB.Save(SC, myNotaDeCreditoImputacionItem)
                        End If
                    Next

                    If Not IsNothing(myNotaDeCredito.DetallesOC) Then
                        For Each myNotaDeCreditoOCItem As NotaDeCreditoOCItem In myNotaDeCredito.DetallesOC
                            myNotaDeCreditoOCItem.IdNotaCredito = result
                            If myNotaDeCreditoOCItem.Eliminado Then
                            Else
                                NotaDeCreditoOCItemDB.Save(SC, myNotaDeCreditoOCItem)
                            End If
                        Next
                    End If

                    If Not IsNothing(myNotaDeCredito.DetallesProvincias) Then
                        For Each myNotaDeCreditoProvinciasItem As NotaDeCreditoProvinciasItem In myNotaDeCredito.DetallesProvincias
                            myNotaDeCreditoProvinciasItem.IdNotaCredito = result
                            If myNotaDeCreditoProvinciasItem.Eliminado Then
                            Else
                                NotaDeCreditoProvinciasItemDB.Save(SC, myNotaDeCreditoProvinciasItem)
                            End If
                        Next
                    End If
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
                Dim myCommand As SqlCommand = New SqlCommand("wNotaDeCreditos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdNotaDeCredito", id)
                myConnection.Open()

                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Public Shared Function Anular(ByVal SC As String, ByVal IdNotaDeCredito As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wNotaDeCreditos_N", myConnection)
                myCommand.Transaction = Transaccion
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdNotaDeCredito", IdNotaDeCredito)
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

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As NotaDeCredito
            Dim myNotaDeCredito As NotaDeCredito = New NotaDeCredito

            With myNotaDeCredito
                SQLtoNET(myDataRecord, "@IdNotaCredito", .Id)

                SQLtoNET(myDataRecord, "@NumeroNotaCredito", .Numero)
                SQLtoNET(myDataRecord, "@TipoABC", .TipoABC)
                SQLtoNET(myDataRecord, "@PuntoVenta", .PuntoVenta)
                SQLtoNET(myDataRecord, "@IdCliente", .IdCliente)
                SQLtoNET(myDataRecord, "@FechaNotaCredito", .Fecha)
                SQLtoNET(myDataRecord, "@IdVendedor", .IdVendedor)
                SQLtoNET(myDataRecord, "@ImporteTotal", .ImporteTotal)
                SQLtoNET(myDataRecord, "@ImporteIva1", .ImporteIva1)
                SQLtoNET(myDataRecord, "@ImporteIva2", .ImporteIva2)


                SQLtoNET(myDataRecord, "@RetencionIBrutos1", .RetencionIBrutos1)
                SQLtoNET(myDataRecord, "@PorcentajeIBrutos1", .PorcentajeIBrutos1)
                SQLtoNET(myDataRecord, "@RetencionIBrutos2", .RetencionIBrutos2)
                SQLtoNET(myDataRecord, "@PorcentajeIBrutos2", .PorcentajeIBrutos2)
                SQLtoNET(myDataRecord, "@IdCodigoIva", .IdCodigoIva)
                SQLtoNET(myDataRecord, "@PorcentajeIva1", .PorcentajeIva1)
                SQLtoNET(myDataRecord, "@PorcentajeIva2", .PorcentajeIva2)
                SQLtoNET(myDataRecord, "@Observaciones", .Observaciones)
                SQLtoNET(myDataRecord, "@ImporteIvaIncluido", .ImporteIvaIncluido)
                SQLtoNET(myDataRecord, "@CotizacionDolar", .CotizacionDolar)





                SQLtoNET(myDataRecord, "@CtaCte", .CtaCte)
                SQLtoNET(myDataRecord, "@IdMoneda", .IdMoneda)
                SQLtoNET(myDataRecord, "@CotizacionMoneda", .CotizacionMoneda)
                SQLtoNET(myDataRecord, "@IVANoDiscriminado", .IVANoDiscriminado)
                SQLtoNET(myDataRecord, "@ConvenioMultilateral", .ConvenioMultilateral)
                SQLtoNET(myDataRecord, "@OtrasPercepciones1", .OtrasPercepciones1)
                SQLtoNET(myDataRecord, "@OtrasPercepciones1Desc", .OtrasPercepciones1Desc)
                SQLtoNET(myDataRecord, "@OtrasPercepciones2", .OtrasPercepciones2)
                SQLtoNET(myDataRecord, "@OtrasPercepciones2Desc", .OtrasPercepciones2Desc)
                SQLtoNET(myDataRecord, "@IdProvinciaDestino", .IdProvinciaDestino)
                SQLtoNET(myDataRecord, "@IdIBCondicion", .IdIBCondicion)

                SQLtoNET(myDataRecord, "@IdPuntoVenta", .IdPuntoVenta)

                SQLtoNET(myDataRecord, "@Anulada", .anulada)
                SQLtoNET(myDataRecord, "@IdUsuarioAnulacion", .IdUsuarioAnulacion)
                SQLtoNET(myDataRecord, "@FechaAnulacion", .FechaAnulacion)





                SQLtoNET(myDataRecord, "@NumeroCAI", .NumeroCAI)
                SQLtoNET(myDataRecord, "@FechaVencimientoCAI", .FechaVencimientoCAI)
                SQLtoNET(myDataRecord, "@IdObra", .IdObra)
                SQLtoNET(myDataRecord, "@IdUsuarioIngreso", .IdUsuarioIngreso)
                SQLtoNET(myDataRecord, "@FechaIngreso", .FechaIngreso)

                SQLtoNET(myDataRecord, "@AplicarEnCtaCte", .AplicarEnCtaCte)
                SQLtoNET(myDataRecord, "@IdIBCondicion2", .IdIBCondicion2)
                SQLtoNET(myDataRecord, "@OtrasPercepciones3", .OtrasPercepciones3)
                SQLtoNET(myDataRecord, "@OtrasPercepciones3Desc", .OtrasPercepciones3Desc)
                SQLtoNET(myDataRecord, "@NoIncluirEnCubos", .NoIncluirEnCubos)
                SQLtoNET(myDataRecord, "@PercepcionIVA", .PercepcionIVA)
                SQLtoNET(myDataRecord, "@PorcentajePercepcionIVA", .PorcentajePercepcionIVA)
                SQLtoNET(myDataRecord, "@ActivarRecuperoGastos", .ActivarRecuperoGastos)





                SQLtoNET(myDataRecord, "@IdAutorizoRecuperoGastos", .IdAutorizoRecuperoGastos)
                SQLtoNET(myDataRecord, "@IdFacturaVenta_RecuperoGastos", .IdFacturaVenta_RecuperoGastos)
                SQLtoNET(myDataRecord, "@IdListaPrecios", .IdListaPrecios)
                SQLtoNET(myDataRecord, "@IdIBCondicion3", .IdIBCondicion3)
                SQLtoNET(myDataRecord, "@RetencionIBrutos3", .RetencionIBrutos3)
                SQLtoNET(myDataRecord, "@PorcentajeIBrutos3", .PorcentajeIBrutos3)

                SQLtoNET(myDataRecord, "@CAE", .CAE)
                SQLtoNET(myDataRecord, "@RechazoCAE", .RechazoCAE)
                SQLtoNET(myDataRecord, "@FechaVencimientoORechazoCAE", .FechaVencimientoORechazoCAE)
                SQLtoNET(myDataRecord, "@IdIdentificacionCAE", .IdIdentificacionCAE)

                Try
                    SQLtoNET(myDataRecord, "@CodigoIdAuxiliar", .CodigoIdAuxiliar)
                    SQLtoNET(myDataRecord, "@NumeroFacturaOriginal", .NumeroFacturaOriginal)
                Catch ex As Exception

                End Try

            End With
            Return myNotaDeCredito

        End Function
    End Class
End Namespace