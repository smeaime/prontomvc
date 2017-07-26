Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class PresupuestoDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Presupuesto
            Dim myPresupuesto As Presupuesto = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wPresupuestos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdPresupuesto", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myPresupuesto = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myPresupuesto
        End Function


        Public Shared Function GetList(ByVal SC As String) As PresupuestoList
            Dim tempList As PresupuestoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wPresupuestos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New PresupuestoList
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
        Public Shared Function GetList_FondosFijos(ByVal SC As String, ByVal IdObra As Integer) As PresupuestoList
            Dim tempList As PresupuestoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wPresupuestos_TX_FondosFijos", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdObra", IdObra)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New PresupuestoList
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
                Dim myCommand As SqlCommand = New SqlCommand("wPresupuestos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdPresupuesto", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myPresupuesto As Presupuesto) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            With myPresupuesto
                Try
                    Dim myCommand As SqlCommand = New SqlCommand("wPresupuestos_A", myConnection)
                    myCommand.Transaction = Transaccion
                    myCommand.CommandType = CommandType.StoredProcedure

                    '///////////////////////////////////////////////////////////////////////
                    'A partir de acá pegás el codigo generado
                    '///////////////////////////////////////////////////////////////////////

                    myCommand.Parameters.AddWithValue("@IdPresupuesto", myPresupuesto.Id)
                    myCommand.Parameters.AddWithValue("@Numero", myPresupuesto.Numero)
                    myCommand.Parameters.AddWithValue("@IdProveedor", myPresupuesto.IdProveedor)
                    If myPresupuesto.FechaIngreso = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaIngreso", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaIngreso", myPresupuesto.FechaIngreso)
                    End If
                    myCommand.Parameters.AddWithValue("@Observaciones", myPresupuesto.Observaciones)
                    myCommand.Parameters.AddWithValue("@Bonificacion", myPresupuesto.Bonificacion)
                    myCommand.Parameters.AddWithValue("@Plazo", myPresupuesto.Plazo)
                    myCommand.Parameters.AddWithValue("@validez", myPresupuesto.Validez)
                    myCommand.Parameters.AddWithValue("@IdCondicionCompra", myPresupuesto.IdCondicionCompra)
                    myCommand.Parameters.AddWithValue("@Garantia", myPresupuesto.Garantia)
                    myCommand.Parameters.AddWithValue("@LugarEntrega", myPresupuesto.LugarEntrega)
                    myCommand.Parameters.AddWithValue("@IdComprador", myPresupuesto.IdComprador)
                    myCommand.Parameters.AddWithValue("@Referencia", myPresupuesto.Referencia)
                    myCommand.Parameters.AddWithValue("@PorcentajeIva1", myPresupuesto.PorcentajeIva1)
                    myCommand.Parameters.AddWithValue("@PorcentajeIva2", myPresupuesto.PorcentajeIva2)
                    myCommand.Parameters.AddWithValue("@Detalle", myPresupuesto.Detalle)
                    myCommand.Parameters.AddWithValue("@Contacto", myPresupuesto.Contacto)
                    myCommand.Parameters.AddWithValue("@ImporteBonificacion", myPresupuesto.ImporteBonificacion)
                    myCommand.Parameters.AddWithValue("@ImporteIva1", myPresupuesto.ImporteIva1)
                    myCommand.Parameters.AddWithValue("@ImporteTotal", myPresupuesto.ImporteTotal)
                    myCommand.Parameters.AddWithValue("@SubNumero", myPresupuesto.SubNumero)
                    myCommand.Parameters.AddWithValue("@Aprobo", myPresupuesto.Aprobo)
                    myCommand.Parameters.AddWithValue("@IdMoneda", myPresupuesto.IdMoneda)
                    If myPresupuesto.FechaAprobacion = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaAprobacion", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaAprobacion", myPresupuesto.FechaAprobacion)
                    End If
                    myCommand.Parameters.AddWithValue("@DetalleCondicionCompra", myPresupuesto.DetalleCondicionCompra)
                    myCommand.Parameters.AddWithValue("@ArchivoAdjunto1", myPresupuesto.ArchivoAdjunto1)
                    myCommand.Parameters.AddWithValue("@ArchivoAdjunto2", myPresupuesto.ArchivoAdjunto2)
                    myCommand.Parameters.AddWithValue("@ArchivoAdjunto3", myPresupuesto.ArchivoAdjunto3)
                    myCommand.Parameters.AddWithValue("@ArchivoAdjunto4", myPresupuesto.ArchivoAdjunto4)
                    myCommand.Parameters.AddWithValue("@ArchivoAdjunto5", myPresupuesto.ArchivoAdjunto5)
                    myCommand.Parameters.AddWithValue("@ArchivoAdjunto6", myPresupuesto.ArchivoAdjunto6)
                    myCommand.Parameters.AddWithValue("@ArchivoAdjunto7", myPresupuesto.ArchivoAdjunto7)
                    myCommand.Parameters.AddWithValue("@ArchivoAdjunto8", myPresupuesto.ArchivoAdjunto8)
                    myCommand.Parameters.AddWithValue("@ArchivoAdjunto9", myPresupuesto.ArchivoAdjunto9)
                    myCommand.Parameters.AddWithValue("@ArchivoAdjunto10", myPresupuesto.ArchivoAdjunto10)
                    myCommand.Parameters.AddWithValue("@IdPlazoEntrega", myPresupuesto.IdPlazoEntrega)
                    myCommand.Parameters.AddWithValue("@CotizacionMoneda", myPresupuesto.CotizacionMoneda)
                    myCommand.Parameters.AddWithValue("@CircuitoFirmasCompleto", myPresupuesto.CircuitoFirmasCompleto)

                    myCommand.Parameters.AddWithValue("@ConfirmadoPorWeb", myPresupuesto.ConfirmadoPorWeb)
                    myCommand.Parameters.AddWithValue("@FechaCierreCompulsa", myPresupuesto.FechaCierreCompulsa)

                    myCommand.Parameters.AddWithValue("@NombreUsuarioWeb", "")
                    myCommand.Parameters.AddWithValue("@FechaRespuestaweb", Now)


                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    For Each Item As PresupuestoItem In .Detalles
                        Item.IdPresupuesto = result
                        PresupuestoItemDB.Save(SC, Item)
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
                Dim myCommand As SqlCommand = New SqlCommand("wPresupuestos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdPresupuesto", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Presupuesto
            Dim myPresupuesto As Presupuesto = New Presupuesto

            Try
                myPresupuesto.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdPresupuesto"))

                '///////////////////////////////////////////////////////////////////////
                'A partir de acá pegás el codigo generado
                '///////////////////////////////////////////////////////////////////////
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Numero")) Then
                    myPresupuesto.Numero = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Numero"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdProveedor")) Then
                    myPresupuesto.IdProveedor = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdProveedor"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaIngreso")) Then
                    myPresupuesto.FechaIngreso = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaIngreso"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Observaciones")) Then
                    myPresupuesto.Observaciones = myDataRecord.GetString(myDataRecord.GetOrdinal("Observaciones"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Bonificacion")) Then
                    myPresupuesto.Bonificacion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Bonificacion"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Plazo")) Then
                    myPresupuesto.Plazo = myDataRecord.GetString(myDataRecord.GetOrdinal("Plazo"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("validez")) Then
                    myPresupuesto.Validez = myDataRecord.GetString(myDataRecord.GetOrdinal("validez"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdCondicionCompra")) Then
                    myPresupuesto.IdCondicionCompra = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdCondicionCompra"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Garantia")) Then
                    myPresupuesto.Garantia = myDataRecord.GetString(myDataRecord.GetOrdinal("Garantia"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("LugarEntrega")) Then
                    myPresupuesto.LugarEntrega = myDataRecord.GetString(myDataRecord.GetOrdinal("LugarEntrega"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdComprador")) Then
                    myPresupuesto.IdComprador = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdComprador"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Referencia")) Then
                    myPresupuesto.Referencia = myDataRecord.GetString(myDataRecord.GetOrdinal("Referencia"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PorcentajeIva1")) Then
                    myPresupuesto.PorcentajeIva1 = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("PorcentajeIva1"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PorcentajeIva2")) Then
                    myPresupuesto.PorcentajeIva2 = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("PorcentajeIva2"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Detalle")) Then
                    myPresupuesto.Detalle = myDataRecord.GetString(myDataRecord.GetOrdinal("Detalle"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Contacto")) Then
                    myPresupuesto.Contacto = myDataRecord.GetString(myDataRecord.GetOrdinal("Contacto"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImporteBonificacion")) Then
                    myPresupuesto.ImporteBonificacion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("ImporteBonificacion"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImporteIva1")) Then
                    myPresupuesto.ImporteIva1 = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("ImporteIva1"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImporteTotal")) Then
                    myPresupuesto.ImporteTotal = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("ImporteTotal"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SubNumero")) Then
                    myPresupuesto.SubNumero = myDataRecord.GetInt32(myDataRecord.GetOrdinal("SubNumero"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Aprobo")) Then
                    myPresupuesto.Aprobo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Aprobo"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdMoneda")) Then
                    myPresupuesto.IdMoneda = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdMoneda"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAprobacion")) Then
                    myPresupuesto.FechaAprobacion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAprobacion"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("DetalleCondicionCompra")) Then
                    myPresupuesto.DetalleCondicionCompra = myDataRecord.GetString(myDataRecord.GetOrdinal("DetalleCondicionCompra"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto1")) Then
                    myPresupuesto.ArchivoAdjunto1 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto1"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto2")) Then
                    myPresupuesto.ArchivoAdjunto2 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto2"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto3")) Then
                    myPresupuesto.ArchivoAdjunto3 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto3"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto4")) Then
                    myPresupuesto.ArchivoAdjunto4 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto4"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto5")) Then
                    myPresupuesto.ArchivoAdjunto5 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto5"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto6")) Then
                    myPresupuesto.ArchivoAdjunto6 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto6"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto7")) Then
                    myPresupuesto.ArchivoAdjunto7 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto7"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto8")) Then
                    myPresupuesto.ArchivoAdjunto8 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto8"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto9")) Then
                    myPresupuesto.ArchivoAdjunto9 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto9"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto10")) Then
                    myPresupuesto.ArchivoAdjunto10 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto10"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdPlazoEntrega")) Then
                    myPresupuesto.IdPlazoEntrega = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdPlazoEntrega"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CotizacionMoneda")) Then
                    myPresupuesto.CotizacionMoneda = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("CotizacionMoneda"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CircuitoFirmasCompleto")) Then
                    myPresupuesto.CircuitoFirmasCompleto = myDataRecord.GetString(myDataRecord.GetOrdinal("CircuitoFirmasCompleto"))
                End If

                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ConfirmadoPorWeb")) Then
                    myPresupuesto.ConfirmadoPorWeb = myDataRecord.GetString(myDataRecord.GetOrdinal("ConfirmadoPorWeb"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaCierreCompulsa")) Then
                    myPresupuesto.FechaCierreCompulsa = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaCierreCompulsa"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NombreUsuarioWeb")) Then
                    myPresupuesto.NombreUsuarioWeb = myDataRecord.GetString(myDataRecord.GetOrdinal("NombreUsuarioWeb"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaRespuestaweb")) Then
                    myPresupuesto.FechaRespuestaweb = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaRespuestaweb"))
                End If

                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Proveedor")) Then
                    myPresupuesto.Proveedor = myDataRecord.GetString(myDataRecord.GetOrdinal("Proveedor"))
                End If

            Catch e As Exception
                Debug.Print(e.Message)
                Throw New ApplicationException("Error en la carga " + e.Message, e)
            Finally
            End Try


            Return myPresupuesto
        End Function
    End Class
End Namespace