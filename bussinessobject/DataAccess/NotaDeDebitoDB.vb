Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class NotaDeDebitoDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As NotaDeDebito
            Dim myNotaDeDebito As NotaDeDebito = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("NotasDebito_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdNotaDebito", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myNotaDeDebito = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myNotaDeDebito
        End Function

        Public Shared Function GetList(ByVal SC As String) As NotaDeDebitoList
            Dim tempList As NotaDeDebitoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("NotasDebito_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New NotaDeDebitoList
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

        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String) As NotaDeDebitoList

            Dim tempList As NotaDeDebitoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wNotaDeDebitos_T_ByEmployee", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdSolicito", IdSolicito)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New NotaDeDebitoList
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
            Dim tempList As NotaDeDebitoList = Nothing
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
                Dim myCommand As SqlCommand = New SqlCommand("wNotaDeDebitos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdNotaDeDebito", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myNotaDeDebito As NotaDeDebito) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand
                With myNotaDeDebito


                    If .Id = -1 Then

                        myCommand = New SqlCommand("NotasDebito_A", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdNotaDebito", -1)
                        param.Direction = ParameterDirection.Output

                    Else

                        myCommand = New SqlCommand("NotasDebito_M", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        myCommand.Parameters.AddWithValue("@IdNotaDebito", .Id)
                    End If


                    NETtoSQL(myCommand, "@NumeroNotaDebito", .Numero)
                    NETtoSQL(myCommand, "@TipoABC", .TipoABC)
                    NETtoSQL(myCommand, "@PuntoVenta", .PuntoVenta)
                    NETtoSQL(myCommand, "@IdCliente", .IdCliente)
                    NETtoSQL(myCommand, "@FechaNotaDebito", .Fecha)
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
                    NETtoSQL(myCommand, "@Anulada", .Anulada)
                    NETtoSQL(myCommand, "@IdUsuarioAnulacion", .IdUsuarioAnulacion)
                    NETtoSQL(myCommand, "@FechaAnulacion", .FechaAnulacion)
                    NETtoSQL(myCommand, "@NumeroCAI", .NumeroCAI)
                    NETtoSQL(myCommand, "@FechaVencimientoCAI", .FechaVencimientoCAI)
                    NETtoSQL(myCommand, "@IdObra", .IdObra)
                    NETtoSQL(myCommand, "@NumeroCertificadoPercepcionIIBB", .NumeroCertificadoPercepcionIIBB)
                    NETtoSQL(myCommand, "@IdVentaEnCuotas", .IdVentaEnCuotas)
                    NETtoSQL(myCommand, "@NumeroCuota", .NumeroCuota)
                    NETtoSQL(myCommand, "@IdUsuarioIngreso", .IdUsuarioIngreso)
                    NETtoSQL(myCommand, "@FechaIngreso", .FechaIngreso)
                    NETtoSQL(myCommand, "@AplicarEnCtaCte", .AplicarEnCtaCte)
                    NETtoSQL(myCommand, "@IdIBCondicion2", .IdIBCondicion2)
                    NETtoSQL(myCommand, "@OtrasPercepciones3", .OtrasPercepciones3)
                    NETtoSQL(myCommand, "@OtrasPercepciones3Desc", .OtrasPercepciones3Desc)
                    NETtoSQL(myCommand, "@NoIncluirEnCubos", .NoIncluirEnCubos)
                    NETtoSQL(myCommand, "@PercepcionIVA", .PercepcionIVA)
                    NETtoSQL(myCommand, "@PorcentajePercepcionIVA", .PorcentajePercepcionIVA)
                    NETtoSQL(myCommand, "@IdNotaCreditoVenta_RecuperoGastos", .IdNotaCreditoVenta_RecuperoGastos)
                    NETtoSQL(myCommand, "@IdListaPrecios", .IdListaPrecios)
                    NETtoSQL(myCommand, "@IdIBCondicion3", .IdIBCondicion3)
                    NETtoSQL(myCommand, "@RetencionIBrutos3", .RetencionIBrutos3)
                    NETtoSQL(myCommand, "@PorcentajeIBrutos3", .PorcentajeIBrutos3)
                    NETtoSQL(myCommand, "@CAE", .CAE)
                    NETtoSQL(myCommand, "@RechazoCAE", .RechazoCAE)
                    NETtoSQL(myCommand, "@FechaVencimientoORechazoCAE", .FechaVencimientoORechazoCAE)
                    NETtoSQL(myCommand, "@IdIdentificacionCAE", .IdIdentificacionCAE)






                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    For Each myNotaDeDebitoItem As NotaDeDebitoItem In myNotaDeDebito.Detalles
                        myNotaDeDebitoItem.IdNotaDebito = result
                        NotaDeDebitoItemDB.Save(SC, myNotaDeDebitoItem)
                    Next

                    For Each myNotaDeDebitoProvinciasItem As NotaDeDebitoProvinciasItem In myNotaDeDebito.DetallesProvincias
                        myNotaDeDebitoProvinciasItem.IdNotaDebito = result
                        NotaDeDebitoProvinciasItemDB.Save(SC, myNotaDeDebitoProvinciasItem)
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
                Dim myCommand As SqlCommand = New SqlCommand("wNotaDeDebitos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdNotaDeDebito", id)
                myConnection.Open()

                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Public Shared Function Anular(ByVal SC As String, ByVal IdNotaDeDebito As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wNotaDeDebitos_N", myConnection)
                myCommand.Transaction = Transaccion
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdNotaDeDebito", IdNotaDeDebito)
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

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As NotaDeDebito
            Dim myNotaDeDebito As NotaDeDebito = New NotaDeDebito
            With myNotaDeDebito

                SQLtoNET(.Id, "IdNotaDebito", myDataRecord)
                SQLtoNET(.Numero, "NumeroNotaDebito", myDataRecord)
                SQLtoNET(.TipoABC, "TipoABC", myDataRecord)
                SQLtoNET(.PuntoVenta, "PuntoVenta", myDataRecord)
                SQLtoNET(.IdCliente, "IdCliente", myDataRecord)
                SQLtoNET(.Fecha, "FechaNotaDebito", myDataRecord)
                SQLtoNET(.IdVendedor, "IdVendedor", myDataRecord)
                SQLtoNET(.ImporteTotal, "ImporteTotal", myDataRecord)
                SQLtoNET(.ImporteIva1, "ImporteIva1", myDataRecord)
                SQLtoNET(.ImporteIva2, "ImporteIva2", myDataRecord)
                SQLtoNET(.RetencionIBrutos1, "RetencionIBrutos1", myDataRecord)
                SQLtoNET(.PorcentajeIBrutos1, "PorcentajeIBrutos1", myDataRecord)
                SQLtoNET(.RetencionIBrutos2, "RetencionIBrutos2", myDataRecord)
                SQLtoNET(.PorcentajeIBrutos2, "PorcentajeIBrutos2", myDataRecord)
                SQLtoNET(.IdCodigoIva, "IdCodigoIva", myDataRecord)
                SQLtoNET(.PorcentajeIva1, "PorcentajeIva1", myDataRecord)
                SQLtoNET(.PorcentajeIva2, "PorcentajeIva2", myDataRecord)
                SQLtoNET(.Observaciones, "Observaciones", myDataRecord)
                SQLtoNET(.ImporteIvaIncluido, "ImporteIvaIncluido", myDataRecord)
                SQLtoNET(.CotizacionDolar, "CotizacionDolar", myDataRecord)
                SQLtoNET(.CtaCte, "CtaCte", myDataRecord)
                SQLtoNET(.IdMoneda, "IdMoneda", myDataRecord)
                SQLtoNET(.CotizacionMoneda, "CotizacionMoneda", myDataRecord)
                SQLtoNET(.IVANoDiscriminado, "IVANoDiscriminado", myDataRecord)
                SQLtoNET(.ConvenioMultilateral, "ConvenioMultilateral", myDataRecord)
                SQLtoNET(.OtrasPercepciones1, "OtrasPercepciones1", myDataRecord)
                SQLtoNET(.OtrasPercepciones1Desc, "OtrasPercepciones1Desc", myDataRecord)
                SQLtoNET(.OtrasPercepciones2, "OtrasPercepciones2", myDataRecord)
                SQLtoNET(.OtrasPercepciones2Desc, "OtrasPercepciones2Desc", myDataRecord)
                SQLtoNET(.IdProvinciaDestino, "IdProvinciaDestino", myDataRecord)
                SQLtoNET(.IdIBCondicion, "IdIBCondicion", myDataRecord)
                SQLtoNET(.IdPuntoVenta, "IdPuntoVenta", myDataRecord)
                SQLtoNET(.Anulada, "Anulada", myDataRecord)
                SQLtoNET(.IdUsuarioAnulacion, "IdUsuarioAnulacion", myDataRecord)
                SQLtoNET(.FechaAnulacion, "FechaAnulacion", myDataRecord)
                SQLtoNET(.NumeroCAI, "NumeroCAI", myDataRecord)
                SQLtoNET(.FechaVencimientoCAI, "FechaVencimientoCAI", myDataRecord)
                SQLtoNET(.IdObra, "IdObra", myDataRecord)
                SQLtoNET(.NumeroCertificadoPercepcionIIBB, "NumeroCertificadoPercepcionIIBB", myDataRecord)
                SQLtoNET(.IdVentaEnCuotas, "IdVentaEnCuotas", myDataRecord)
                SQLtoNET(.NumeroCuota, "NumeroCuota", myDataRecord)
                SQLtoNET(.IdUsuarioIngreso, "IdUsuarioIngreso", myDataRecord)
                SQLtoNET(.FechaIngreso, "FechaIngreso", myDataRecord)
                SQLtoNET(.AplicarEnCtaCte, "AplicarEnCtaCte", myDataRecord)
                SQLtoNET(.IdIBCondicion2, "IdIBCondicion2", myDataRecord)
                SQLtoNET(.OtrasPercepciones3, "OtrasPercepciones3", myDataRecord)
                SQLtoNET(.OtrasPercepciones3Desc, "OtrasPercepciones3Desc", myDataRecord)
                SQLtoNET(.NoIncluirEnCubos, "NoIncluirEnCubos", myDataRecord)
                SQLtoNET(.PercepcionIVA, "PercepcionIVA", myDataRecord)
                SQLtoNET(.PorcentajePercepcionIVA, "PorcentajePercepcionIVA", myDataRecord)
                SQLtoNET(.IdNotaCreditoVenta_RecuperoGastos, "IdNotaCreditoVenta_RecuperoGastos", myDataRecord)
                SQLtoNET(.IdListaPrecios, "IdListaPrecios", myDataRecord)
                SQLtoNET(.IdIBCondicion3, "IdIBCondicion3", myDataRecord)
                SQLtoNET(.RetencionIBrutos3, "RetencionIBrutos3", myDataRecord)
                SQLtoNET(.PorcentajeIBrutos3, "PorcentajeIBrutos3", myDataRecord)
                SQLtoNET(.CAE, "CAE", myDataRecord)
                SQLtoNET(.RechazoCAE, "RechazoCAE", myDataRecord)
                SQLtoNET(.FechaVencimientoORechazoCAE, "FechaVencimientoORechazoCAE", myDataRecord)
                SQLtoNET(.IdIdentificacionCAE, "IdIdentificacionCAE", myDataRecord)




                Return myNotaDeDebito
            End With
        End Function
    End Class
End Namespace