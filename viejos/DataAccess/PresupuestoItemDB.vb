Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class PresupuestoItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As PresupuestoItem
            Dim myPresupuestoItem As PresupuestoItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetPresupuestos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetallePresupuesto", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myPresupuestoItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myPresupuestoItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdPresupuesto As Integer) As PresupuestoItemList
            Dim tempList As PresupuestoItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetPresupuestos_TT", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdPresupuesto", IdPresupuesto)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New PresupuestoItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myPresupuestoItem As PresupuestoItem) As Integer
            Dim result As Integer = 0
            If Not myPresupuestoItem.Eliminado Then
                Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
                Try
                    Dim myCommand As SqlCommand = New SqlCommand("wDetPresupuestos_A", myConnection)
                    myCommand.CommandType = CommandType.StoredProcedure

                    '///////////////////////////////////////////////////////////////////////
                    'A partir de acá pegás el codigo generado
                    '///////////////////////////////////////////////////////////////////////


                    If myPresupuestoItem.Nuevo Then
                        myCommand.Parameters.AddWithValue("@IdDetallePresupuesto", DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@IdDetallePresupuesto", myPresupuestoItem.Id)
                    End If
                    myCommand.Parameters.AddWithValue("@IdPresupuesto", myPresupuestoItem.IdPresupuesto)

                    If myPresupuestoItem.IdArticulo = 0 Then
                        myCommand.Parameters.AddWithValue("@IdArticulo", DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@IdArticulo", myPresupuestoItem.IdArticulo)
                    End If



                    With myPresupuestoItem
                        myCommand.Parameters.AddWithValue("@NumeroItem", myPresupuestoItem.NumeroItem)
                        myCommand.Parameters.AddWithValue("@Cantidad", myPresupuestoItem.Cantidad)
                        myCommand.Parameters.AddWithValue("@IdUnidad", myPresupuestoItem.IdUnidad)
                        myCommand.Parameters.AddWithValue("@Precio", myPresupuestoItem.Precio)
                        myCommand.Parameters.AddWithValue("@Adjunto", myPresupuestoItem.Adjunto)
                        myCommand.Parameters.AddWithValue("@ArchivoAdjunto", myPresupuestoItem.ArchivoAdjunto)
                        myCommand.Parameters.AddWithValue("@Cantidad1", myPresupuestoItem.Cantidad1)
                        myCommand.Parameters.AddWithValue("@Cantidad2", myPresupuestoItem.Cantidad2)
                        myCommand.Parameters.AddWithValue("@Observaciones", myPresupuestoItem.Observaciones)
                        myCommand.Parameters.AddWithValue("@IdDetalleAcopios", IdNull(.IdDetalleAcopios))
                        myCommand.Parameters.AddWithValue("@IdDetalleRequerimiento", IdNull(.IdDetalleRequerimiento))
                        myCommand.Parameters.AddWithValue("@OrigenDescripcion", IdNull(.OrigenDescripcion))
                        myCommand.Parameters.AddWithValue("@IdDetalleLMateriales", myPresupuestoItem.IdDetalleLMateriales)
                        myCommand.Parameters.AddWithValue("@IdCuenta", myPresupuestoItem.IdCuenta)
                        myCommand.Parameters.AddWithValue("@ArchivoAdjunto1", myPresupuestoItem.ArchivoAdjunto1)
                        myCommand.Parameters.AddWithValue("@ArchivoAdjunto2", myPresupuestoItem.ArchivoAdjunto2)
                        myCommand.Parameters.AddWithValue("@ArchivoAdjunto3", myPresupuestoItem.ArchivoAdjunto3)
                        myCommand.Parameters.AddWithValue("@ArchivoAdjunto4", myPresupuestoItem.ArchivoAdjunto4)
                        myCommand.Parameters.AddWithValue("@ArchivoAdjunto5", myPresupuestoItem.ArchivoAdjunto5)
                        myCommand.Parameters.AddWithValue("@ArchivoAdjunto6", myPresupuestoItem.ArchivoAdjunto6)
                        myCommand.Parameters.AddWithValue("@ArchivoAdjunto7", myPresupuestoItem.ArchivoAdjunto7)
                        myCommand.Parameters.AddWithValue("@ArchivoAdjunto8", myPresupuestoItem.ArchivoAdjunto8)
                        myCommand.Parameters.AddWithValue("@ArchivoAdjunto9", myPresupuestoItem.ArchivoAdjunto9)
                        myCommand.Parameters.AddWithValue("@ArchivoAdjunto10", myPresupuestoItem.ArchivoAdjunto10)
                        If myPresupuestoItem.FechaEntrega = DateTime.MinValue Then
                            myCommand.Parameters.AddWithValue("@FechaEntrega", System.DBNull.Value)
                        Else
                            myCommand.Parameters.AddWithValue("@FechaEntrega", myPresupuestoItem.FechaEntrega)
                        End If
                        myCommand.Parameters.AddWithValue("@IdCentroCosto", myPresupuestoItem.IdCentroCosto)
                        myCommand.Parameters.AddWithValue("@PorcentajeBonificacion", myPresupuestoItem.PorcentajeBonificacion)
                        myCommand.Parameters.AddWithValue("@ImporteBonificacion", myPresupuestoItem.ImporteBonificacion)
                        myCommand.Parameters.AddWithValue("@PorcentajeIVA", myPresupuestoItem.PorcentajeIVA)
                        myCommand.Parameters.AddWithValue("@ImporteIVA", myPresupuestoItem.ImporteIVA)
                        myCommand.Parameters.AddWithValue("@ImporteTotalItem", myPresupuestoItem.ImporteTotalItem)


                    End With



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
                If Not myPresupuestoItem.Nuevo Then Delete(SC, myPresupuestoItem.Id)
            End If
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetPresupuestos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetallePresupuesto", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As PresupuestoItem
            Dim myPresupuestoItem As PresupuestoItem = New PresupuestoItem
            myPresupuestoItem.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetallePresupuesto"))

            '///////////////////////////////////////////////////////////////////////
            'A partir de acá pegás el codigo generado
            '///////////////////////////////////////////////////////////////////////


            'Fijate que no estoy trayendo el id del padre. Esto es deliberado? Es conveniente?

            Try
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NumeroItem")) Then
                    myPresupuestoItem.NumeroItem = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroItem"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdArticulo")) Then
                    myPresupuestoItem.IdArticulo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdArticulo"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Articulo")) Then
                    myPresupuestoItem.Articulo = myDataRecord.GetString(myDataRecord.GetOrdinal("Articulo"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cantidad")) Then
                    myPresupuestoItem.Cantidad = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Cantidad"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdUnidad")) Then
                    myPresupuestoItem.IdUnidad = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdUnidad"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Precio")) Then
                    myPresupuestoItem.Precio = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Precio"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Adjunto")) Then
                    myPresupuestoItem.Adjunto = myDataRecord.GetString(myDataRecord.GetOrdinal("Adjunto"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto")) Then
                    myPresupuestoItem.ArchivoAdjunto = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cantidad1")) Then
                    myPresupuestoItem.Cantidad1 = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Cantidad1"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cantidad2")) Then
                    myPresupuestoItem.Cantidad2 = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Cantidad2"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Observaciones")) Then
                    myPresupuestoItem.Observaciones = myDataRecord.GetString(myDataRecord.GetOrdinal("Observaciones"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleAcopios")) Then
                    myPresupuestoItem.IdDetalleAcopios = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleAcopios"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleRequerimiento")) Then
                    myPresupuestoItem.IdDetalleRequerimiento = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleRequerimiento"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("OrigenDescripcion")) Then
                    myPresupuestoItem.OrigenDescripcion = myDataRecord.GetInt32(myDataRecord.GetOrdinal("OrigenDescripcion"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleLMateriales")) Then
                    myPresupuestoItem.IdDetalleLMateriales = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleLMateriales"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdCuenta")) Then
                    myPresupuestoItem.IdCuenta = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdCuenta"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto1")) Then
                    myPresupuestoItem.ArchivoAdjunto1 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto1"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto2")) Then
                    myPresupuestoItem.ArchivoAdjunto2 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto2"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto3")) Then
                    myPresupuestoItem.ArchivoAdjunto3 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto3"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto4")) Then
                    myPresupuestoItem.ArchivoAdjunto4 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto4"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto5")) Then
                    myPresupuestoItem.ArchivoAdjunto5 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto5"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto6")) Then
                    myPresupuestoItem.ArchivoAdjunto6 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto6"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto7")) Then
                    myPresupuestoItem.ArchivoAdjunto7 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto7"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto8")) Then
                    myPresupuestoItem.ArchivoAdjunto8 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto8"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto9")) Then
                    myPresupuestoItem.ArchivoAdjunto9 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto9"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto10")) Then
                    myPresupuestoItem.ArchivoAdjunto10 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto10"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaEntrega")) Then
                    myPresupuestoItem.FechaEntrega = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaEntrega"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdCentroCosto")) Then
                    myPresupuestoItem.IdCentroCosto = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdCentroCosto"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PorcentajeBonificacion")) Then
                    myPresupuestoItem.PorcentajeBonificacion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("PorcentajeBonificacion"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImporteBonificacion")) Then
                    myPresupuestoItem.ImporteBonificacion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("ImporteBonificacion"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PorcentajeIVA")) Then
                    myPresupuestoItem.PorcentajeIVA = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("PorcentajeIVA"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImporteIVA")) Then
                    myPresupuestoItem.ImporteIVA = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("ImporteIVA"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImporteTotalItem")) Then
                    myPresupuestoItem.ImporteTotalItem = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("ImporteTotalItem"))
                End If


            Catch e As Exception
                Debug.Print(e.Message)
                Throw New ApplicationException("Error en la carga " + e.Message, e)
            Finally
            End Try


            Return myPresupuestoItem
        End Function
    End Class
End Namespace