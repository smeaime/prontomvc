Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class OrdenCompraDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As OrdenCompra
            Dim myOrdenCompra As OrdenCompra = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("OrdenesCompra_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdOrdenCompra", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myOrdenCompra = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myOrdenCompra
        End Function

        Public Shared Function GetList(ByVal SC As String) As OrdenCompraList
            Dim tempList As OrdenCompraList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wOrdenCompras_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New OrdenCompraList
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

        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String) As OrdenCompraList

            Dim tempList As OrdenCompraList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wOrdenCompras_T_ByEmployee", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdSolicito", IdSolicito)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New OrdenCompraList
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
            Dim tempList As OrdenCompraList = Nothing
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
                Dim myCommand As SqlCommand = New SqlCommand("wOrdenCompras_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdOrdenCompra", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myOrdenCompra As OrdenCompra) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wOrdenCompras_A", myConnection)
                myCommand.Transaction = Transaccion
                myCommand.CommandType = CommandType.StoredProcedure
                With myOrdenCompra
                    myCommand.Parameters.AddWithValue("@IdOrdenCompra", myOrdenCompra.Id)
                    myCommand.Parameters.AddWithValue("@NumeroOrdenCompra", myOrdenCompra.Numero)
                    If myOrdenCompra.Fecha = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaOrdenCompra", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaOrdenCompra", myOrdenCompra.Fecha)
                    End If
                    myCommand.Parameters.AddWithValue("@LugarEntrega", myOrdenCompra.LugarEntrega)
                    myCommand.Parameters.AddWithValue("@Observaciones", myOrdenCompra.Observaciones)
                    myCommand.Parameters.AddWithValue("@IdObra", myOrdenCompra.IdObra)
                    myCommand.Parameters.AddWithValue("@IdSolicito", myOrdenCompra.IdSolicito)
                    myCommand.Parameters.AddWithValue("@IdSector", myOrdenCompra.IdSector)
                    myCommand.Parameters.AddWithValue("@MontoPrevisto", myOrdenCompra.MontoPrevisto)
                    myCommand.Parameters.AddWithValue("@IdComprador", myOrdenCompra.IdComprador)
                    myCommand.Parameters.AddWithValue("@Aprobo", myOrdenCompra.IdAprobo)
                    If myOrdenCompra.FechaAprobacion = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaAprobacion", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaAprobacion", myOrdenCompra.FechaAprobacion)
                    End If
                    myCommand.Parameters.AddWithValue("@MontoParaCompra", myOrdenCompra.MontoParaCompra)
                    myCommand.Parameters.AddWithValue("@Cumplido", myOrdenCompra.Cumplido)
                    myCommand.Parameters.AddWithValue("@UsuarioAnulacion", myOrdenCompra.UsuarioAnulacion)
                    If myOrdenCompra.FechaAnulacion = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaAnulacion", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaAnulacion", .FechaAnulacion)
                    End If
                    myCommand.Parameters.AddWithValue("@MotivoAnulacion", .MotivoAnulacion)
                    myCommand.Parameters.AddWithValue("@IdOrdenCompraOriginal", .IdOrdenCompraOriginal)
                    myCommand.Parameters.AddWithValue("@IdOrigenTransmision", .IdOrigenTransmision)
                    myCommand.Parameters.AddWithValue("@IdAutorizoCumplido", .IdAutorizoCumplido)
                    myCommand.Parameters.AddWithValue("@IdDioPorCumplido", .IdDioPorCumplido)
                    If myOrdenCompra.FechaDadoPorCumplido = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaDadoPorCumplido", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaDadoPorCumplido", myOrdenCompra.FechaDadoPorCumplido)
                    End If
                    myCommand.Parameters.AddWithValue("@ObservacionesCumplido", myOrdenCompra.ObservacionesCumplido)
                    myCommand.Parameters.AddWithValue("@IdMoneda", IdNull(.IdMoneda))

                    myCommand.Parameters.AddWithValue("@Detalle", .Detalle)
                    myCommand.Parameters.AddWithValue("@Confirmado", .Confirmado)
                    If myOrdenCompra.FechaImportacionTransmision = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaImportacionTransmision", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaImportacionTransmision", myOrdenCompra.FechaImportacionTransmision)
                    End If
                    myCommand.Parameters.AddWithValue("@IdEquipoDestino", myOrdenCompra.IdEquipoDestino)
                    myCommand.Parameters.AddWithValue("@Impresa", myOrdenCompra.Impresa)
                    myCommand.Parameters.AddWithValue("@Recepcionado", myOrdenCompra.Recepcionado)
                    myCommand.Parameters.AddWithValue("@Entregado", myOrdenCompra.Entregado)
                    myCommand.Parameters.AddWithValue("@TipoOrdenCompra", myOrdenCompra.TipoOrdenCompra)
                    myCommand.Parameters.AddWithValue("@IdOrdenTrabajo", IdNull(.IdOrdenTrabajo))
                    myCommand.Parameters.AddWithValue("@IdTipoCompra", myOrdenCompra.IdTipoCompra)
                    myCommand.Parameters.AddWithValue("@IdImporto", myOrdenCompra.IdImporto)
                    If myOrdenCompra.FechaLlegadaImportacion = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaLlegadaImportacion", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaLlegadaImportacion", myOrdenCompra.FechaLlegadaImportacion)
                    End If
                    myCommand.Parameters.AddWithValue("@CircuitoFirmasCompleto", myOrdenCompra.CircuitoFirmasCompleto)
                    myCommand.Parameters.AddWithValue("@ConfirmadoPorWeb", myOrdenCompra.ConfirmadoPorWeb)
                    myCommand.Parameters.AddWithValue("@DirectoACompras", myOrdenCompra.DirectoACompras)

                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    For Each myOrdenCompraItem As OrdenCompraItem In myOrdenCompra.Detalles
                        myOrdenCompraItem.IdOrdenCompra = result
                        OrdenCompraItemDB.Save(SC, myOrdenCompraItem)
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
                Dim myCommand As SqlCommand = New SqlCommand("wOrdenCompras_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdOrdenCompra", id)
                myConnection.Open()

                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Public Shared Function Anular(ByVal SC As String, ByVal IdOrdenCompra As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wOrdenCompras_N", myConnection)
                myCommand.Transaction = Transaccion
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdOrdenCompra", IdOrdenCompra)
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






        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As OrdenCompra
            Dim myOrdenCompra As OrdenCompra = New OrdenCompra

            With myOrdenCompra
                SQLtoNET(.Id, "IdOrdenCompra", myDataRecord)
                SQLtoNET(.Numero, "NumeroOrdenCompra", myDataRecord)
                SQLtoNET(.Fecha, "FechaOrdenCompra", myDataRecord)

                SQLtoNET(.IdCliente, "IdCliente", myDataRecord)
                SQLtoNET(.IdCondicionVenta, "IdCondicionVenta", myDataRecord)
                SQLtoNET(.Anulada, "Anulada", myDataRecord)
                SQLtoNET(.FechaAnulacion, "FechaAnulacion", myDataRecord)
                SQLtoNET(.Observaciones, "Observaciones", myDataRecord)
                SQLtoNET(.ImporteTotal, "ImporteTotal", myDataRecord)
                SQLtoNET(.NumeroOrdenCompraCliente, "NumeroOrdenCompraCliente", myDataRecord)
                SQLtoNET(.IdObra, "IdObra", myDataRecord)
                SQLtoNET(.IdMoneda, "IdMoneda", myDataRecord)
                SQLtoNET(.IdUsuarioAnulacion, "IdUsuarioAnulacion", myDataRecord)
                SQLtoNET(.AgrupacionFacturacion, "AgrupacionFacturacion", myDataRecord)
                SQLtoNET(.Agrupacion2Facturacion, "Agrupacion2Facturacion", myDataRecord)
                SQLtoNET(.SeleccionadaParaFacturacion, "SeleccionadaParaFacturacion", myDataRecord)
                SQLtoNET(.PorcentajeBonificacion, "PorcentajeBonificacion", myDataRecord)
                SQLtoNET(.IdUsuarioIngreso, "IdUsuarioIngreso", myDataRecord)
                SQLtoNET(.IdListaPrecios, "IdListaPrecios", myDataRecord)
                SQLtoNET(.FechaIngreso, "FechaIngreso", myDataRecord)
                SQLtoNET(.IdUsuarioModifico, "IdUsuarioModifico", myDataRecord)
                SQLtoNET(.FechaModifico, "FechaModifico", myDataRecord)
                SQLtoNET(.IdAprobo, "Aprobo", myDataRecord)
                SQLtoNET(.FechaAprobacion, "FechaAprobacion", myDataRecord)
                SQLtoNET(.CircuitoFirmasCompleto, "CircuitoFirmasCompleto", myDataRecord)
                SQLtoNET(.IdDetalleClienteLugarEntrega, "IdDetalleClienteLugarEntrega", myDataRecord)

            End With

            Return myOrdenCompra
        End Function
    End Class
End Namespace