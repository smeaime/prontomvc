Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO

Namespace Pronto.ERP.Dal

    Public Class RemitoDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Remito
            Dim myRemito As Remito = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wRemitos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRemito", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myRemito = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myRemito
        End Function

        Public Shared Function GetList(ByVal SC As String) As RemitoList
            Dim tempList As RemitoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wRemitos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New RemitoList
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

        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String) As RemitoList

            Dim tempList As RemitoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wRemitos_T_ByEmployee", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdSolicito", IdSolicito)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New RemitoList
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
            Dim tempList As RemitoList = Nothing
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
                Dim myCommand As SqlCommand = New SqlCommand("wRemitos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRemito", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myRemito As Remito) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand





                With myRemito

                    If .Id = -1 Then

                        myCommand = New SqlCommand("wRemitos_A", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdRemito", -1)
                        param.Direction = ParameterDirection.Output

                    Else

                        myCommand = New SqlCommand("wRemitos_M", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        myCommand.Parameters.AddWithValue("@IdRemito", .Id)
                    End If



                    NETtoSQL(myCommand, "@NumeroRemito", .Numero)
                    NETtoSQL(myCommand, "@IdCliente", .IdCliente)
                    NETtoSQL(myCommand, "@FechaRemito", .Fecha)
                    NETtoSQL(myCommand, "@IdCondicionVenta", .IdCondicionVenta)
                    NETtoSQL(myCommand, "@Anulado", .Anulado)
                    NETtoSQL(myCommand, "@FechaAnulacion", .FechaAnulacion)
                    NETtoSQL(myCommand, "@Observaciones", .Observaciones)
                    NETtoSQL(myCommand, "@ArchivoAdjunto1", .ArchivoAdjunto1)
                    NETtoSQL(myCommand, "@ArchivoAdjunto2", .ArchivoAdjunto2)
                    NETtoSQL(myCommand, "@ArchivoAdjunto3", .ArchivoAdjunto3)
                    NETtoSQL(myCommand, "@ArchivoAdjunto4", .ArchivoAdjunto4)
                    NETtoSQL(myCommand, "@ArchivoAdjunto5", .ArchivoAdjunto5)
                    NETtoSQL(myCommand, "@ArchivoAdjunto6", .ArchivoAdjunto6)
                    NETtoSQL(myCommand, "@ArchivoAdjunto7", .ArchivoAdjunto7)
                    NETtoSQL(myCommand, "@ArchivoAdjunto8", .ArchivoAdjunto8)
                    NETtoSQL(myCommand, "@ArchivoAdjunto9", .ArchivoAdjunto9)
                    NETtoSQL(myCommand, "@ArchivoAdjunto10", .ArchivoAdjunto10)
                    NETtoSQL(myCommand, "@Destino", .Destino)
                    NETtoSQL(myCommand, "@IdProveedor", .IdProveedor)
                    NETtoSQL(myCommand, "@IdTransportista", .IdTransportista)
                    NETtoSQL(myCommand, "@TotalBultos", .TotalBultos)
                    NETtoSQL(myCommand, "@ValorDeclarado", .ValorDeclarado)
                    NETtoSQL(myCommand, "@FechaRegistracion", .FechaRegistracion)
                    NETtoSQL(myCommand, "@IdAutorizaAnulacion", .IdAutorizaAnulacion)
                    NETtoSQL(myCommand, "@IdPuntoVenta", .IdPuntoVenta)
                    NETtoSQL(myCommand, "@PuntoVenta", .PuntoVenta)
                    NETtoSQL(myCommand, "@Patente", .Patente)
                    NETtoSQL(myCommand, "@Chofer", .Chofer)
                    NETtoSQL(myCommand, "@NumeroDocumento", .NumeroDocumento)
                    NETtoSQL(myCommand, "@OrdenCarga", .OrdenCarga)
                    NETtoSQL(myCommand, "@OrdenCompra", .OrdenCompra)
                    NETtoSQL(myCommand, "@COT", .COT)
                    NETtoSQL(myCommand, "@IdEquipo", .IdEquipo)
                    NETtoSQL(myCommand, "@IdObra", .IdObra)
                    NETtoSQL(myCommand, "@IdListaPrecios", .IdListaPrecios)
                    NETtoSQL(myCommand, "@IdDetalleClienteLugarEntrega", .IdDetalleClienteLugarEntrega)


                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    For Each myRemitoItem As RemitoItem In myRemito.Detalles
                        myRemitoItem.IdRemito = result
                        RemitoItemDB.Save(SC, myRemitoItem)
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
                Dim myCommand As SqlCommand = New SqlCommand("wRemitos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRemito", id)
                myConnection.Open()

                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Public Shared Function Anular(ByVal SC As String, ByVal IdRemito As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wRemitos_N", myConnection)
                myCommand.Transaction = Transaccion
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRemito", IdRemito)
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

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Remito
            Dim myRemito As Remito = New Remito
            myRemito.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdRemito"))
            myRemito.Numero = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroRemito"))
            myRemito.Fecha = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaRemito"))


            'SQLtoNET(.IdCliente, "IdCliente", myDataRecord)
            'SQLtoNET(.IdCliente, "IdCliente", myDataRecord)
            'SQLtoNET(.IdCliente, "IdCliente", myDataRecord)
            'SQLtoNET(.IdCliente, "IdCliente", myDataRecord)
            'SQLtoNET(.IdCliente, "IdCliente", myDataRecord)
            'SQLtoNET(.IdCliente, "IdCliente", myDataRecord)
            'SQLtoNET(.IdCliente, "IdCliente", myDataRecord)

            'SQLtoNET(myDataRecord, "@IdRecibo", .Id)
            'SQLtoNET(myDataRecord, "@NumeroRecibo", .NumeroRecibo)

            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdObra")) Then
                myRemito.IdObra = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdObra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Obra")) Then
                myRemito.Obra = myDataRecord.GetString(myDataRecord.GetOrdinal("Obra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdSolicito")) Then
                myRemito.IdSolicito = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdSolicito"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Solicito")) Then
                myRemito.Solicito = myDataRecord.GetString(myDataRecord.GetOrdinal("Solicito"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("LugarEntrega")) Then
                myRemito.LugarEntrega = myDataRecord.GetString(myDataRecord.GetOrdinal("LugarEntrega"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Observaciones")) Then
                myRemito.Observaciones = myDataRecord.GetString(myDataRecord.GetOrdinal("Observaciones"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdSector")) Then
                myRemito.IdSector = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdSector"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Sector")) Then
                myRemito.Sector = myDataRecord.GetString(myDataRecord.GetOrdinal("Sector"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdComprador")) Then
                myRemito.IdComprador = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdComprador"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Comprador")) Then
                myRemito.Comprador = myDataRecord.GetString(myDataRecord.GetOrdinal("Comprador"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Aprobo")) Then
                myRemito.IdAprobo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Aprobo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Libero")) Then
                myRemito.Aprobo = myDataRecord.GetString(myDataRecord.GetOrdinal("Libero"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAprobacion")) Then
                myRemito.FechaAprobacion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAprobacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("MontoPrevisto")) Then
                myRemito.MontoPrevisto = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("MontoPrevisto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("MontoParaCompra")) Then
                myRemito.MontoParaCompra = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("MontoParaCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cumplido")) Then
                myRemito.Cumplido = myDataRecord.GetString(myDataRecord.GetOrdinal("Cumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("UsuarioAnulacion")) Then
                myRemito.UsuarioAnulacion = myDataRecord.GetString(myDataRecord.GetOrdinal("UsuarioAnulacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAnulacion")) Then
                myRemito.FechaAnulacion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAnulacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("MotivoAnulacion")) Then
                myRemito.MotivoAnulacion = myDataRecord.GetString(myDataRecord.GetOrdinal("MotivoAnulacion"))
            End If
            'If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdRemitoOriginal")) Then
            '    myRemito.IdRemitoOriginal = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdRemitoOriginal"))
            'End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdOrigenTransmision")) Then
                myRemito.IdOrigenTransmision = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdOrigenTransmision"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaImportacionTransmision")) Then
                myRemito.FechaImportacionTransmision = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaImportacionTransmision"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdImporto")) Then
                myRemito.IdImporto = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdImporto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaLlegadaImportacion")) Then
                myRemito.FechaLlegadaImportacion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaLlegadaImportacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdAutorizoCumplido")) Then
                myRemito.IdAutorizoCumplido = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdAutorizoCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDioPorCumplido")) Then
                myRemito.IdDioPorCumplido = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDioPorCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaDadoPorCumplido")) Then
                myRemito.FechaDadoPorCumplido = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaDadoPorCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ObservacionesCumplido")) Then
                myRemito.ObservacionesCumplido = myDataRecord.GetString(myDataRecord.GetOrdinal("ObservacionesCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdMoneda")) Then
                myRemito.IdMoneda = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdMoneda"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Detalle")) Then
                myRemito.Detalle = myDataRecord.GetString(myDataRecord.GetOrdinal("Detalle"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Confirmado")) Then
                myRemito.Confirmado = myDataRecord.GetString(myDataRecord.GetOrdinal("Confirmado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdEquipoDestino")) Then
                myRemito.IdEquipoDestino = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdEquipoDestino"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Impresa")) Then
                myRemito.Impresa = myDataRecord.GetString(myDataRecord.GetOrdinal("Impresa"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Recepcionado")) Then
                myRemito.Recepcionado = myDataRecord.GetString(myDataRecord.GetOrdinal("Recepcionado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Entregado")) Then
                myRemito.Entregado = myDataRecord.GetString(myDataRecord.GetOrdinal("Entregado"))
            End If
            'If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("TipoRemito")) Then
            '    myRemito.TipoRemito = myDataRecord.GetString(myDataRecord.GetOrdinal("TipoRemito"))
            'End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdOrdenTrabajo")) Then
                myRemito.IdOrdenTrabajo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdOrdenTrabajo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdTipoCompra")) Then
                myRemito.IdTipoCompra = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdTipoCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CircuitoFirmasCompleto")) Then
                myRemito.CircuitoFirmasCompleto = myDataRecord.GetString(myDataRecord.GetOrdinal("CircuitoFirmasCompleto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ConfirmadoPorWeb")) Then
                myRemito.ConfirmadoPorWeb = myDataRecord.GetString(myDataRecord.GetOrdinal("ConfirmadoPorWeb"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("DirectoACompras")) Then
                myRemito.DirectoACompras = myDataRecord.GetString(myDataRecord.GetOrdinal("DirectoACompras"))
            End If


            Return myRemito
        End Function
    End Class
End Namespace