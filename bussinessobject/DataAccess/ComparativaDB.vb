Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class ComparativaDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Comparativa
            Dim myComparativa As Comparativa = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wComparativas_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdComparativa", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myComparativa = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myComparativa
        End Function


        Public Shared Function GetList(ByVal SC As String) As ComparativaList
            Dim tempList As ComparativaList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wComparativas_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New ComparativaList
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

        'GetList filtrado
        Public Shared Function GetList_FondosFijos(ByVal SC As String, ByVal IdObra As Integer) As ComparativaList
            Dim tempList As ComparativaList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wComparativas_TX_FondosFijos", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdObra", IdObra)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New ComparativaList
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
                Dim myCommand As SqlCommand = New SqlCommand("wComparativas_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdComparativa", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myComparativa As Comparativa) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            With myComparativa
                Try
                    Dim myCommand As SqlCommand = New SqlCommand("wComparativas_A", myConnection)
                    myCommand.Transaction = Transaccion
                    myCommand.CommandType = CommandType.StoredProcedure

                    'myCommand.Parameters.AddWithValue("@ConfirmadoPorWeb", myComparativa.ConfirmadoPorWeb)
                    'myCommand.Parameters.AddWithValue("@NombreUsuarioWeb", "")
                    'myCommand.Parameters.AddWithValue("@FechaRespuestaweb", Now)
                    '///////////////////////////////////////////////////////////////////////
                    'A partir de acá pegás el codigo generado
                    '///////////////////////////////////////////////////////////////////////

                    myCommand.Parameters.AddWithValue("@IdComparativa", myComparativa.Id)
                    myCommand.Parameters.AddWithValue("@Numero", myComparativa.Numero)
                    If myComparativa.Fecha = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@Fecha", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@Fecha", myComparativa.Fecha)
                    End If
                    myCommand.Parameters.AddWithValue("@Observaciones", myComparativa.Observaciones)
                    myCommand.Parameters.AddWithValue("@IdConfecciono", IIf(myComparativa.IdConfecciono = 0, System.DBNull.Value, myComparativa.IdConfecciono))
                    myCommand.Parameters.AddWithValue("@IdAprobo", IIf(myComparativa.IdAprobo = 0, System.DBNull.Value, myComparativa.IdAprobo))
                    myCommand.Parameters.AddWithValue("@PresupuestoSeleccionado", IIf(myComparativa.PresupuestoSeleccionado = 0, System.DBNull.Value, myComparativa.PresupuestoSeleccionado))
                    myCommand.Parameters.AddWithValue("@SubNumeroSeleccionado", IIf(myComparativa.SubNumeroSeleccionado = 0, System.DBNull.Value, myComparativa.SubNumeroSeleccionado))
                    myCommand.Parameters.AddWithValue("@MontoPrevisto", myComparativa.MontoPrevisto)
                    myCommand.Parameters.AddWithValue("@MontoParaCompra", myComparativa.MontoParaCompra)
                    myCommand.Parameters.AddWithValue("@NumeroRequerimiento", myComparativa.NumeroRequerimiento)
                    If myComparativa.FechaAprobacion = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaAprobacion", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaAprobacion", myComparativa.FechaAprobacion)
                    End If
                    myCommand.Parameters.AddWithValue("@Obras", myComparativa.Obras)
                    myCommand.Parameters.AddWithValue("@CircuitoFirmasCompleto", myComparativa.CircuitoFirmasCompleto)






                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    For Each Item As ComparativaItem In .Detalles
                        Item.IdComparativa = result
                        ComparativaItemDB.Save(SC, Item)
                    Next

                    Transaccion.Commit()
                    myConnection.Close()
                Catch e As Exception
                    Transaccion.Rollback()
                    ErrHandler.WriteAndRaiseError(e)
                    'Return -1 'qué conviene usar? disparar errores o devolver -1?
                Finally
                    CType(myConnection, IDisposable).Dispose()
                End Try
            End With
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wComparativas_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdComparativa", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Comparativa
            Dim myComparativa As Comparativa = New Comparativa

            Try
                myComparativa.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdComparativa"))

                'If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ConfirmadoPorWeb")) Then
                '    myComparativa.ConfirmadoPorWeb = myDataRecord.GetString(myDataRecord.GetOrdinal("ConfirmadoPorWeb"))
                'End If
                'If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NombreUsuarioWeb")) Then
                '    myComparativa.NombreUsuarioWeb = myDataRecord.GetString(myDataRecord.GetOrdinal("NombreUsuarioWeb"))
                'End If
                'If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaRespuestaweb")) Then
                '    myComparativa.FechaRespuestaWeb = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaRespuestaweb"))
                'End If

                '///////////////////////////////////////////////////////////////////////
                'A partir de acá pegás el codigo generado
                '///////////////////////////////////////////////////////////////////////
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Numero")) Then
                    myComparativa.Numero = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Numero"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Fecha")) Then
                    myComparativa.Fecha = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("Fecha"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Observaciones")) Then
                    myComparativa.Observaciones = myDataRecord.GetString(myDataRecord.GetOrdinal("Observaciones"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdConfecciono")) Then
                    myComparativa.IdConfecciono = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdConfecciono"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdAprobo")) Then
                    myComparativa.IdAprobo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdAprobo"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PresupuestoSeleccionado")) Then
                    myComparativa.PresupuestoSeleccionado = myDataRecord.GetInt32(myDataRecord.GetOrdinal("PresupuestoSeleccionado"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SubNumeroSeleccionado")) Then
                    myComparativa.SubNumeroSeleccionado = myDataRecord.GetInt32(myDataRecord.GetOrdinal("SubNumeroSeleccionado"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("MontoPrevisto")) Then
                    myComparativa.MontoPrevisto = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("MontoPrevisto"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("MontoParaCompra")) Then
                    myComparativa.MontoParaCompra = myDataRecord.GetString(myDataRecord.GetOrdinal("MontoParaCompra"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NumeroRequerimiento")) Then
                    myComparativa.NumeroRequerimiento = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroRequerimiento"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAprobacion")) Then
                    myComparativa.FechaAprobacion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAprobacion"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Obras")) Then
                    myComparativa.Obras = myDataRecord.GetString(myDataRecord.GetOrdinal("Obras"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CircuitoFirmasCompleto")) Then
                    myComparativa.CircuitoFirmasCompleto = myDataRecord.GetString(myDataRecord.GetOrdinal("CircuitoFirmasCompleto"))
                End If







                
            Catch e As Exception
                Debug.Print(e.Message)
                Throw New ApplicationException("Error en la carga " + e.Message, e)
            Finally
            End Try


            Return myComparativa
        End Function
    End Class
End Namespace