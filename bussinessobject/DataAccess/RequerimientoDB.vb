Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class RequerimientoDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Requerimiento
            Dim myRequerimiento As Requerimiento = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wRequerimientos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRequerimiento", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myRequerimiento = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myRequerimiento
        End Function

        Public Shared Function GetList(ByVal SC As String) As RequerimientoList
            Dim tempList As RequerimientoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wRequerimientos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New RequerimientoList
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

        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String) As RequerimientoList

            Dim tempList As RequerimientoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wRequerimientos_T_ByEmployee", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdSolicito", IdSolicito)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New RequerimientoList
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
            Dim tempList As RequerimientoList = Nothing
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
                Dim myCommand As SqlCommand = New SqlCommand("wRequerimientos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRequerimiento", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myRequerimiento As Requerimiento) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wRequerimientos_A", myConnection)
                myCommand.Transaction = Transaccion
                myCommand.CommandType = CommandType.StoredProcedure
                With myRequerimiento


                    NETtoSQL(myCommand, "@IdRequerimiento", .Id)
                    NETtoSQL(myCommand, "@NumeroRequerimiento", .Numero)
                    NETtoSQL(myCommand, "@FechaRequerimiento", .Fecha)
                    NETtoSQL(myCommand, "@LugarEntrega", .LugarEntrega)
                    NETtoSQL(myCommand, "@Observaciones", .Observaciones)

                    NETtoSQL(myCommand, "@IdObra", .IdObra)
                    NETtoSQL(myCommand, "@IdSolicito", .IdSolicito)
                    NETtoSQL(myCommand, "@IdSector", .IdSector)
                    NETtoSQL(myCommand, "@MontoPrevisto", .MontoPrevisto)
                    NETtoSQL(myCommand, "@IdComprador", .IdComprador)

                    NETtoSQL(myCommand, "@Aprobo", .IdAprobo, True)
                    NETtoSQL(myCommand, "@FechaAprobacion", .FechaAprobacion)
                    NETtoSQL(myCommand, "@MontoParaCompra", .MontoParaCompra)
                    NETtoSQL(myCommand, "@Cumplido", .Cumplido)
                    NETtoSQL(myCommand, "@UsuarioAnulacion", .UsuarioAnulacion)

                    NETtoSQL(myCommand, "@FechaAnulacion", .FechaAnulacion)
                    NETtoSQL(myCommand, "@MotivoAnulacion", .MotivoAnulacion)
                    NETtoSQL(myCommand, "@IdRequerimientoOriginal", .IdRequerimientoOriginal)
                    NETtoSQL(myCommand, "@IdOrigenTransmision", .IdOrigenTransmision)
                    NETtoSQL(myCommand, "@IdAutorizoCumplido", .IdAutorizoCumplido)

                    NETtoSQL(myCommand, "@IdDioPorCumplido", .IdDioPorCumplido)
                    NETtoSQL(myCommand, "@FechaDadoPorCumplido", .FechaDadoPorCumplido)
                    NETtoSQL(myCommand, "@ObservacionesCumplido", .ObservacionesCumplido)
                    NETtoSQL(myCommand, "@IdMoneda", .IdMoneda)
                    NETtoSQL(myCommand, "@Detalle", .Detalle)

                    NETtoSQL(myCommand, "@Confirmado", .Confirmado)
                    NETtoSQL(myCommand, "@FechaImportacionTransmision", .FechaImportacionTransmision)
                    NETtoSQL(myCommand, "@IdEquipoDestino", .IdEquipoDestino)
                    NETtoSQL(myCommand, "@Impresa", .Impresa)
                    NETtoSQL(myCommand, "@Recepcionado", .Recepcionado)

                    NETtoSQL(myCommand, "@Entregado", .Entregado)
                    NETtoSQL(myCommand, "@TipoRequerimiento", .TipoRequerimiento)
                    NETtoSQL(myCommand, "@IdOrdenTrabajo", .IdOrdenTrabajo)
                    NETtoSQL(myCommand, "@IdTipoCompra", .IdTipoCompra)
                    NETtoSQL(myCommand, "@IdImporto", .IdImporto)

                    NETtoSQL(myCommand, "@FechaLlegadaImportacion", .FechaLlegadaImportacion)
                    NETtoSQL(myCommand, "@CircuitoFirmasCompleto", .CircuitoFirmasCompleto)
                    NETtoSQL(myCommand, "@ConfirmadoPorWeb", .ConfirmadoPorWeb)
                    NETtoSQL(myCommand, "@DirectoACompras", .DirectoACompras)


                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    For Each myRequerimientoItem As RequerimientoItem In myRequerimiento.Detalles
                        myRequerimientoItem.IdRequerimiento = result
                        RequerimientoItemDB.Save(SC, myRequerimientoItem)
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
                Dim myCommand As SqlCommand = New SqlCommand("wRequerimientos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRequerimiento", id)
                myConnection.Open()

                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Public Shared Function Anular(ByVal SC As String, ByVal IdRequerimiento As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wRequerimientos_N", myConnection)
                myCommand.Transaction = Transaccion
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRequerimiento", IdRequerimiento)
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

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Requerimiento
            Dim myRequerimiento As Requerimiento = New Requerimiento
			myRequerimiento.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdRequerimiento"))
            myRequerimiento.Numero = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroRequerimiento"))
            myRequerimiento.Fecha = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaRequerimiento"))
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdObra")) Then
                myRequerimiento.IdObra = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdObra"))
            End If
			If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Obra")) Then
				myRequerimiento.Obra = myDataRecord.GetString(myDataRecord.GetOrdinal("Obra"))
			End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdSolicito")) Then
                myRequerimiento.IdSolicito = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdSolicito"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Solicito")) Then
                myRequerimiento.Solicito = myDataRecord.GetString(myDataRecord.GetOrdinal("Solicito"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("LugarEntrega")) Then
                myRequerimiento.LugarEntrega = myDataRecord.GetString(myDataRecord.GetOrdinal("LugarEntrega"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Observaciones")) Then
                myRequerimiento.Observaciones = myDataRecord.GetString(myDataRecord.GetOrdinal("Observaciones"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdSector")) Then
                myRequerimiento.IdSector = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdSector"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Sector")) Then
                myRequerimiento.Sector = myDataRecord.GetString(myDataRecord.GetOrdinal("Sector"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdComprador")) Then
                myRequerimiento.IdComprador = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdComprador"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Comprador")) Then
                myRequerimiento.Comprador = myDataRecord.GetString(myDataRecord.GetOrdinal("Comprador"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Aprobo")) Then
                myRequerimiento.IdAprobo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Aprobo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Libero")) Then
                myRequerimiento.Aprobo = myDataRecord.GetString(myDataRecord.GetOrdinal("Libero"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAprobacion")) Then
                myRequerimiento.FechaAprobacion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAprobacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("MontoPrevisto")) Then
                myRequerimiento.MontoPrevisto = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("MontoPrevisto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("MontoParaCompra")) Then
                myRequerimiento.MontoParaCompra = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("MontoParaCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cumplido")) Then
                myRequerimiento.Cumplido = myDataRecord.GetString(myDataRecord.GetOrdinal("Cumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("UsuarioAnulacion")) Then
                myRequerimiento.UsuarioAnulacion = myDataRecord.GetString(myDataRecord.GetOrdinal("UsuarioAnulacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAnulacion")) Then
                myRequerimiento.FechaAnulacion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAnulacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("MotivoAnulacion")) Then
                myRequerimiento.MotivoAnulacion = myDataRecord.GetString(myDataRecord.GetOrdinal("MotivoAnulacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdRequerimientoOriginal")) Then
                myRequerimiento.IdRequerimientoOriginal = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdRequerimientoOriginal"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdOrigenTransmision")) Then
                myRequerimiento.IdOrigenTransmision = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdOrigenTransmision"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaImportacionTransmision")) Then
                myRequerimiento.FechaImportacionTransmision = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaImportacionTransmision"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdImporto")) Then
                myRequerimiento.IdImporto = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdImporto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaLlegadaImportacion")) Then
                myRequerimiento.FechaLlegadaImportacion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaLlegadaImportacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdAutorizoCumplido")) Then
                myRequerimiento.IdAutorizoCumplido = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdAutorizoCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDioPorCumplido")) Then
                myRequerimiento.IdDioPorCumplido = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDioPorCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaDadoPorCumplido")) Then
                myRequerimiento.FechaDadoPorCumplido = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaDadoPorCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ObservacionesCumplido")) Then
                myRequerimiento.ObservacionesCumplido = myDataRecord.GetString(myDataRecord.GetOrdinal("ObservacionesCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdMoneda")) Then
                myRequerimiento.IdMoneda = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdMoneda"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Detalle")) Then
                myRequerimiento.Detalle = myDataRecord.GetString(myDataRecord.GetOrdinal("Detalle"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Confirmado")) Then
                myRequerimiento.Confirmado = myDataRecord.GetString(myDataRecord.GetOrdinal("Confirmado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdEquipoDestino")) Then
                myRequerimiento.IdEquipoDestino = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdEquipoDestino"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Impresa")) Then
                myRequerimiento.Impresa = myDataRecord.GetString(myDataRecord.GetOrdinal("Impresa"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Recepcionado")) Then
                myRequerimiento.Recepcionado = myDataRecord.GetString(myDataRecord.GetOrdinal("Recepcionado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Entregado")) Then
                myRequerimiento.Entregado = myDataRecord.GetString(myDataRecord.GetOrdinal("Entregado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("TipoRequerimiento")) Then
                myRequerimiento.TipoRequerimiento = myDataRecord.GetString(myDataRecord.GetOrdinal("TipoRequerimiento"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdOrdenTrabajo")) Then
                myRequerimiento.IdOrdenTrabajo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdOrdenTrabajo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdTipoCompra")) Then
                myRequerimiento.IdTipoCompra = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdTipoCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CircuitoFirmasCompleto")) Then
                myRequerimiento.CircuitoFirmasCompleto = myDataRecord.GetString(myDataRecord.GetOrdinal("CircuitoFirmasCompleto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ConfirmadoPorWeb")) Then
                myRequerimiento.ConfirmadoPorWeb = myDataRecord.GetString(myDataRecord.GetOrdinal("ConfirmadoPorWeb"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("DirectoACompras")) Then
                myRequerimiento.DirectoACompras = myDataRecord.GetString(myDataRecord.GetOrdinal("DirectoACompras"))
            End If


            Return myRequerimiento
        End Function
    End Class
End Namespace