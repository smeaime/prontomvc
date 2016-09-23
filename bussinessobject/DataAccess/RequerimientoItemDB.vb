Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class RequerimientoItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As RequerimientoItem
            Dim myRequerimientoItem As RequerimientoItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetRequerimientos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleRequerimiento", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myRequerimientoItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myRequerimientoItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdRequerimiento As Integer) As RequerimientoItemList
            Dim tempList As RequerimientoItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetRequerimientos_TT", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRequerimiento", IdRequerimiento)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New RequerimientoItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myRequerimientoItem As RequerimientoItem) As Integer
            Dim result As Integer = 0
            If Not myRequerimientoItem.Eliminado Then
                Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
                Try
                    Dim myCommand As SqlCommand = New SqlCommand("wDetRequerimientos_A", myConnection)
                    myCommand.CommandType = CommandType.StoredProcedure
                    If myRequerimientoItem.Nuevo Then
                        myCommand.Parameters.AddWithValue("@IdDetalleRequerimiento", DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@IdDetalleRequerimiento", myRequerimientoItem.Id)
                    End If
                    myCommand.Parameters.AddWithValue("@IdRequerimiento", myRequerimientoItem.IdRequerimiento)
                    myCommand.Parameters.AddWithValue("@NumeroItem", myRequerimientoItem.NumeroItem)
                    myCommand.Parameters.AddWithValue("@Cantidad", myRequerimientoItem.Cantidad)
                    myCommand.Parameters.AddWithValue("@IdUnidad", myRequerimientoItem.IdUnidad)
                    myCommand.Parameters.AddWithValue("@IdArticulo", myRequerimientoItem.IdArticulo)
                    If myRequerimientoItem.FechaEntrega = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaEntrega", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaEntrega", myRequerimientoItem.FechaEntrega)
                    End If
                    myCommand.Parameters.AddWithValue("@Observaciones", myRequerimientoItem.Observaciones)
                    myCommand.Parameters.AddWithValue("@Cantidad1", myRequerimientoItem.Cantidad1)
                    myCommand.Parameters.AddWithValue("@Cantidad2", myRequerimientoItem.Cantidad2)
                    myCommand.Parameters.AddWithValue("@IdDetalleLMateriales", myRequerimientoItem.IdDetalleLMateriales)
                    myCommand.Parameters.AddWithValue("@IdComprador", myRequerimientoItem.IdComprador)
                    myCommand.Parameters.AddWithValue("@NumeroFacturaCompra1", myRequerimientoItem.NumeroFacturaCompra1)
                    If myRequerimientoItem.FechaFacturaCompra = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaFacturaCompra", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaFacturaCompra", myRequerimientoItem.FechaFacturaCompra)
                    End If
                    myCommand.Parameters.AddWithValue("@ImporteFacturaCompra", myRequerimientoItem.ImporteFacturaCompra)
                    myCommand.Parameters.AddWithValue("@IdProveedor", myRequerimientoItem.IdProveedor)
                    myCommand.Parameters.AddWithValue("@NumeroFacturaCompra2", myRequerimientoItem.NumeroFacturaCompra2)
                    myCommand.Parameters.AddWithValue("@Cumplido", myRequerimientoItem.Cumplido)
                    myCommand.Parameters.AddWithValue("@DescripcionManual", myRequerimientoItem.DescripcionManual)
                    myCommand.Parameters.AddWithValue("@IdRequerimientoOriginal", myRequerimientoItem.IdRequerimientoOriginal)
                    myCommand.Parameters.AddWithValue("@IdDetalleRequerimientoOriginal", myRequerimientoItem.IdDetalleRequerimientoOriginal)
                    myCommand.Parameters.AddWithValue("@IdOrigenTransmision", myRequerimientoItem.IdOrigenTransmision)
                    myCommand.Parameters.AddWithValue("@IdAutorizoCumplido", myRequerimientoItem.IdAutorizoCumplido)
                    myCommand.Parameters.AddWithValue("@IdDioPorCumplido", myRequerimientoItem.IdDioPorCumplido)
                    If myRequerimientoItem.FechaDadoPorCumplido = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaDadoPorCumplido", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaDadoPorCumplido", myRequerimientoItem.FechaDadoPorCumplido)
                    End If
                    myCommand.Parameters.AddWithValue("@ObservacionesCumplido", myRequerimientoItem.ObservacionesCumplido)
                    myCommand.Parameters.AddWithValue("@Costo", myRequerimientoItem.Costo)
                    myCommand.Parameters.AddWithValue("@OrigenDescripcion", myRequerimientoItem.OrigenDescripcion)
                    myCommand.Parameters.AddWithValue("@TipoDesignacion", myRequerimientoItem.TipoDesignacion)
                    myCommand.Parameters.AddWithValue("@IdLiberoParaCompras", myRequerimientoItem.IdLiberoParaCompras)
                    If myRequerimientoItem.FechaLiberacionParaCompras = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaLiberacionParaCompras", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaLiberacionParaCompras", myRequerimientoItem.FechaLiberacionParaCompras)
                    End If
                    myCommand.Parameters.AddWithValue("@Recepcionado", myRequerimientoItem.Recepcionado)
                    myCommand.Parameters.AddWithValue("@Pagina", myRequerimientoItem.Pagina)
                    myCommand.Parameters.AddWithValue("@Item", myRequerimientoItem.Item)
                    myCommand.Parameters.AddWithValue("@Figura", myRequerimientoItem.Figura)
                    myCommand.Parameters.AddWithValue("@CodigoDistribucion", myRequerimientoItem.CodigoDistribucion)
                    myCommand.Parameters.AddWithValue("@IdEquipoDestino", myRequerimientoItem.IdEquipoDestino)
                    myCommand.Parameters.AddWithValue("@Entregado", myRequerimientoItem.Entregado)
                    If myRequerimientoItem.FechaAsignacionComprador = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaAsignacionComprador", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaAsignacionComprador", myRequerimientoItem.FechaAsignacionComprador)
                    End If
                    myCommand.Parameters.AddWithValue("@MoP", myRequerimientoItem.MoP)
                    myCommand.Parameters.AddWithValue("@IdDetalleObraDestino", myRequerimientoItem.IdDetalleObraDestino)
                    myCommand.Parameters.AddWithValue("@Adjunto", myRequerimientoItem.Adjunto)
                    myCommand.Parameters.AddWithValue("@ArchivoAdjunto1", myRequerimientoItem.ArchivoAdjunto1)

                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)
                    myConnection.Close()
                Finally
                    CType(myConnection, IDisposable).Dispose()
                End Try
            Else
                If Not myRequerimientoItem.Nuevo Then Delete(SC, myRequerimientoItem.Id)
            End If
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetRequerimientos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleRequerimiento", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As RequerimientoItem
            Dim myRequerimientoItem As RequerimientoItem = New RequerimientoItem
            myRequerimientoItem.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleRequerimiento"))

            'Fijate que no estoy trayendo el id del padre. Esto es deliberado? Es conveniente?

            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdArticulo")) Then
                myRequerimientoItem.IdArticulo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdArticulo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Codigo")) Then
                myRequerimientoItem.Codigo = myDataRecord.GetString(myDataRecord.GetOrdinal("Codigo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Articulo")) Then
                myRequerimientoItem.Articulo = myDataRecord.GetString(myDataRecord.GetOrdinal("Articulo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cantidad")) Then
                myRequerimientoItem.Cantidad = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Cantidad"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdUnidad")) Then
                myRequerimientoItem.IdUnidad = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdUnidad"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Unidad")) Then
                myRequerimientoItem.Unidad = myDataRecord.GetString(myDataRecord.GetOrdinal("Unidad"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaEntrega")) Then
                myRequerimientoItem.FechaEntrega = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaEntrega"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NumeroItem")) Then
                myRequerimientoItem.NumeroItem = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroItem"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Observaciones")) Then
                myRequerimientoItem.Observaciones = myDataRecord.GetString(myDataRecord.GetOrdinal("Observaciones"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cantidad1")) Then
                myRequerimientoItem.Cantidad1 = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Cantidad1"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cantidad2")) Then
                myRequerimientoItem.Cantidad2 = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Cantidad2"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleLMateriales")) Then
                myRequerimientoItem.IdDetalleLMateriales = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleLMateriales"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdComprador")) Then
                myRequerimientoItem.IdComprador = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdComprador"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Comprador")) Then
                myRequerimientoItem.Comprador = myDataRecord.GetString(myDataRecord.GetOrdinal("Comprador"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NumeroFacturaCompra1")) Then
                myRequerimientoItem.NumeroFacturaCompra1 = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroFacturaCompra1"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NumeroFacturaCompra2")) Then
                myRequerimientoItem.NumeroFacturaCompra2 = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroFacturaCompra2"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaFacturaCompra")) Then
                myRequerimientoItem.FechaFacturaCompra = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaFacturaCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImporteFacturaCompra")) Then
                myRequerimientoItem.ImporteFacturaCompra = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("ImporteFacturaCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdProveedor")) Then
                myRequerimientoItem.IdProveedor = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdProveedor"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ProveedorCompra")) Then
                myRequerimientoItem.ProveedorCompra = myDataRecord.GetString(myDataRecord.GetOrdinal("ProveedorCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cumplido")) Then
                myRequerimientoItem.Cumplido = myDataRecord.GetString(myDataRecord.GetOrdinal("Cumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("DescripcionManual")) Then
                myRequerimientoItem.DescripcionManual = myDataRecord.GetString(myDataRecord.GetOrdinal("DescripcionManual"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdRequerimientoOriginal")) Then
                myRequerimientoItem.IdRequerimientoOriginal = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdRequerimientoOriginal"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleRequerimientoOriginal")) Then
                myRequerimientoItem.IdDetalleRequerimientoOriginal = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleRequerimientoOriginal"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdOrigenTransmision")) Then
                myRequerimientoItem.IdOrigenTransmision = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdOrigenTransmision"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdAutorizoCumplido")) Then
                myRequerimientoItem.IdAutorizoCumplido = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdAutorizoCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDioPorCumplido")) Then
                myRequerimientoItem.IdDioPorCumplido = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDioPorCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaDadoPorCumplido")) Then
                myRequerimientoItem.FechaDadoPorCumplido = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaDadoPorCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ObservacionesCumplido")) Then
                myRequerimientoItem.ObservacionesCumplido = myDataRecord.GetString(myDataRecord.GetOrdinal("ObservacionesCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Costo")) Then
                myRequerimientoItem.Costo = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Costo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("OrigenDescripcion")) Then
                myRequerimientoItem.OrigenDescripcion = myDataRecord.GetInt32(myDataRecord.GetOrdinal("OrigenDescripcion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("TipoDesignacion")) Then
                myRequerimientoItem.TipoDesignacion = myDataRecord.GetString(myDataRecord.GetOrdinal("TipoDesignacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdLiberoParaCompras")) Then
                myRequerimientoItem.IdLiberoParaCompras = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdLiberoParaCompras"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaLiberacionParaCompras")) Then
                myRequerimientoItem.FechaLiberacionParaCompras = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaLiberacionParaCompras"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Recepcionado")) Then
                myRequerimientoItem.Recepcionado = myDataRecord.GetString(myDataRecord.GetOrdinal("Recepcionado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Pagina")) Then
                myRequerimientoItem.Pagina = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Pagina"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Item")) Then
                myRequerimientoItem.Item = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Item"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Figura")) Then
                myRequerimientoItem.Figura = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Figura"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CodigoDistribucion")) Then
                myRequerimientoItem.CodigoDistribucion = myDataRecord.GetString(myDataRecord.GetOrdinal("CodigoDistribucion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdEquipoDestino")) Then
                myRequerimientoItem.IdEquipoDestino = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdEquipoDestino"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Entregado")) Then
                myRequerimientoItem.Entregado = myDataRecord.GetString(myDataRecord.GetOrdinal("Entregado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAsignacionComprador")) Then
                myRequerimientoItem.FechaAsignacionComprador = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAsignacionComprador"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("MoP")) Then
                myRequerimientoItem.MoP = myDataRecord.GetString(myDataRecord.GetOrdinal("MoP"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleObraDestino")) Then
                myRequerimientoItem.IdDetalleObraDestino = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleObraDestino"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Adjunto")) Then
                myRequerimientoItem.Adjunto = myDataRecord.GetString(myDataRecord.GetOrdinal("Adjunto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto1")) Then
                myRequerimientoItem.ArchivoAdjunto1 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto1"))
            End If
            Return myRequerimientoItem
        End Function
    End Class
End Namespace