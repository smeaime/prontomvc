Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class ComparativaItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As ComparativaItem
            Dim myComparativaItem As ComparativaItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetComparativas_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleComparativa", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myComparativaItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try

            Return myComparativaItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdComparativa As Integer) As ComparativaItemList
            Dim tempList As ComparativaItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetComparativas_TT", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdComparativa", IdComparativa)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New ComparativaItemList
                        While myReader.Read
                            tempList.Add(FillDataRecord(myReader))

                            '///////////////////////////////////////////////////////////////////////
                            '///////////////////////////////////////////////////////////////////////
                            'traigo de contrabando el nombre del articulo. TO DO. 
                            'Lo saco, obviamente, por problema de performance
                            Try
                                'tempList.Item(tempList.Count - 1).Articulo = ArticuloDB.GetItem(SC, tempList.Item(tempList.Count - 1).IdArticulo).Descripcion
                            Catch x As Exception
                            End Try
                            '///////////////////////////////////////////////////////////////////////
                            '///////////////////////////////////////////////////////////////////////

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

        Public Shared Function Save(ByVal SC As String, ByVal myComparativaItem As ComparativaItem) As Integer
            Dim result As Integer = 0
            If Not myComparativaItem.Eliminado Then
                Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
                Try
                    Dim myCommand As SqlCommand = New SqlCommand("wDetComparativas_A", myConnection)
                    myCommand.CommandType = CommandType.StoredProcedure

                    '///////////////////////////////////////////////////////////////////////
                    'A partir de acá pegás el codigo generado
                    '///////////////////////////////////////////////////////////////////////



                    myCommand.Parameters.AddWithValue("@IdDetalleComparativa", IIf(myComparativaItem.Nuevo, System.DBNull.Value, myComparativaItem.Id))


                    myCommand.Parameters.AddWithValue("@IdComparativa", IIf(myComparativaItem.IdComparativa = 0, System.DBNull.Value, myComparativaItem.IdComparativa))
                    myCommand.Parameters.AddWithValue("@IdPresupuesto", IIf(myComparativaItem.IdPresupuesto = 0, System.DBNull.Value, myComparativaItem.IdPresupuesto))
                    myCommand.Parameters.AddWithValue("@NumeroPresupuesto", myComparativaItem.NumeroPresupuesto)
                    If myComparativaItem.FechaPresupuesto = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaPresupuesto", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaPresupuesto", myComparativaItem.FechaPresupuesto)
                    End If

                    myCommand.Parameters.AddWithValue("@IdArticulo", IIf(myComparativaItem.IdArticulo = 0, System.DBNull.Value, myComparativaItem.IdArticulo))
                    myCommand.Parameters.AddWithValue("@Cantidad", myComparativaItem.Cantidad)
                    myCommand.Parameters.AddWithValue("@Precio", myComparativaItem.Precio)
                    myCommand.Parameters.AddWithValue("@Estado", myComparativaItem.Estado)
                    myCommand.Parameters.AddWithValue("@SubNumero", myComparativaItem.SubNumero)
                    myCommand.Parameters.AddWithValue("@Observaciones", IIf(myComparativaItem.Observaciones Is Nothing, System.DBNull.Value, myComparativaItem.Observaciones))
                    myCommand.Parameters.AddWithValue("@IdUnidad", IIf(myComparativaItem.IdUnidad = 0, System.DBNull.Value, myComparativaItem.IdUnidad))
                    myCommand.Parameters.AddWithValue("@IdMoneda", IIf(myComparativaItem.IdMoneda = 0, System.DBNull.Value, myComparativaItem.IdMoneda))
                    myCommand.Parameters.AddWithValue("@OrigenDescripcion", myComparativaItem.OrigenDescripcion)
                    myCommand.Parameters.AddWithValue("@PorcentajeBonificacion", myComparativaItem.PorcentajeBonificacion)
                    myCommand.Parameters.AddWithValue("@CotizacionMoneda", myComparativaItem.CotizacionMoneda)
                    myCommand.Parameters.AddWithValue("@IdDetallePresupuesto", IIf(myComparativaItem.IdDetallePresupuesto = 0, System.DBNull.Value, myComparativaItem.IdDetallePresupuesto))









                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)
                    myConnection.Close()
                Catch e As Exception
                    Throw New ApplicationException("Error en la grabacion " + e.Message, e)
                Finally
                    CType(myConnection, IDisposable).Dispose()
                End Try
            Else
                If Not myComparativaItem.Nuevo Then Delete(SC, myComparativaItem.Id)
            End If
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetComparativas_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleComparativa", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As ComparativaItem
            Dim myComparativaItem As ComparativaItem = New ComparativaItem
            myComparativaItem.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleComparativa"))

            Try
                '///////////////////////////////////////////////////////////////////////
                'Desnormalizados
                '///////////////////////////////////////////////////////////////////////
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Articulo")) Then
                    myComparativaItem.Articulo = myDataRecord.GetString(myDataRecord.GetOrdinal("Articulo"))
                End If

                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Unidad")) Then
                    myComparativaItem.Unidad = myDataRecord.GetString(myDataRecord.GetOrdinal("Unidad"))
                End If

                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ProveedorDelPresupuesto")) Then
                    myComparativaItem.ProveedorDelPresupuesto = myDataRecord.GetString(myDataRecord.GetOrdinal("ProveedorDelPresupuesto"))
                End If
                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////



                '///////////////////////////////////////////////////////////////////////
                'A partir de acá pegás el codigo generado (si la plantilla generó un campo que solo dice "Id", borralo
                '///////////////////////////////////////////////////////////////////////


                'Fijate que no estoy trayendo el id del padre. Esto es deliberado? Es conveniente?

                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdComparativa")) Then
                    myComparativaItem.IdComparativa = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdComparativa"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdPresupuesto")) Then
                    myComparativaItem.IdPresupuesto = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdPresupuesto"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NumeroPresupuesto")) Then
                    myComparativaItem.NumeroPresupuesto = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroPresupuesto"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaPresupuesto")) Then
                    myComparativaItem.FechaPresupuesto = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaPresupuesto"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdArticulo")) Then
                    myComparativaItem.IdArticulo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdArticulo"))
                End If




                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cantidad")) Then
                    myComparativaItem.Cantidad = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Cantidad"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Precio")) Then
                    myComparativaItem.Precio = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Precio"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Estado")) Then
                    myComparativaItem.Estado = myDataRecord.GetString(myDataRecord.GetOrdinal("Estado"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SubNumero")) Then
                    myComparativaItem.SubNumero = myDataRecord.GetInt32(myDataRecord.GetOrdinal("SubNumero"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Observaciones")) Then
                    myComparativaItem.Observaciones = myDataRecord.GetString(myDataRecord.GetOrdinal("Observaciones"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdUnidad")) Then
                    myComparativaItem.IdUnidad = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdUnidad"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdMoneda")) Then
                    myComparativaItem.IdMoneda = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdMoneda"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("OrigenDescripcion")) Then
                    myComparativaItem.OrigenDescripcion = myDataRecord.GetInt32(myDataRecord.GetOrdinal("OrigenDescripcion"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PorcentajeBonificacion")) Then
                    myComparativaItem.PorcentajeBonificacion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("PorcentajeBonificacion"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CotizacionMoneda")) Then
                    myComparativaItem.CotizacionMoneda = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("CotizacionMoneda"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetallePresupuesto")) Then
                    myComparativaItem.IdDetallePresupuesto = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetallePresupuesto"))
                End If


            Catch e As Exception
                Debug.Print(e.Message)
                Throw New ApplicationException("Error en la carga " + e.Message, e)
            Finally
            End Try


            Return myComparativaItem
        End Function
    End Class
End Namespace