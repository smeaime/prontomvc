Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class RemitoItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As RemitoItem
            Dim myRemitoItem As RemitoItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetRemitos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleRemito", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myRemitoItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myRemitoItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdRemito As Integer) As RemitoItemList
            Dim tempList As RemitoItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("DetRemito_TX_PorIdCabecera", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRemito", IdRemito)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New RemitoItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myRemitoItem As RemitoItem) As Integer
            Dim result As Integer = 0
            If Not myRemitoItem.Eliminado Then
                Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                Try
                    Dim myCommand As SqlCommand
                    With myRemitoItem

                        If myRemitoItem.Nuevo Then

                            myCommand = New SqlCommand("wDetRemitos_A", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleRemito", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand("wDetRemitos_M", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleRemito", myRemitoItem.Id)
                        End If



                        NETtoSQL(myCommand, "@IdRemito", .IdRemito)
                        NETtoSQL(myCommand, "@NumeroItem", .NumeroItem)
                        NETtoSQL(myCommand, "@Cantidad", .Cantidad)
                        NETtoSQL(myCommand, "@IdUnidad", .IdUnidad)
                        NETtoSQL(myCommand, "@IdArticulo", .IdArticulo)
                        NETtoSQL(myCommand, "@Precio", .IdArticulo)
                        NETtoSQL(myCommand, "@Observaciones", .Observaciones)
                        NETtoSQL(myCommand, "@PorcentajeCertificacion", .PorcentajeCertificacion)
                        NETtoSQL(myCommand, "@OrigenDescripcion", .OrigenDescripcion)
                        NETtoSQL(myCommand, "@IdDetalleOrdenCompra", .IdDetalleOrdenCompra)
                        NETtoSQL(myCommand, "@TipoCancelacion", .TipoCancelacion)
                        NETtoSQL(myCommand, "@IdUbicacion", .IdUbicacion)
                        NETtoSQL(myCommand, "@IdObra", .IdObra)
                        NETtoSQL(myCommand, "@Partida", .Partida)
                        NETtoSQL(myCommand, "@DescargaPorKit", .DescargaPorKit)
                        NETtoSQL(myCommand, "@NumeroCaja", .NumeroCaja)

                        'myCommand.Parameters.AddWithValue("@FechaRemito", fechaNETtoSQL(.FechaRemito, System.DBNull.Value))
                        
                        Dim returnValue As DbParameter
                        returnValue = myCommand.CreateParameter
                        returnValue.Direction = ParameterDirection.ReturnValue
                        myCommand.Parameters.Add(returnValue)
                        myConnection.Open()
                        myCommand.ExecuteNonQuery()
                        result = Convert.ToInt32(returnValue.Value)
                        myConnection.Close()
                    End With

                Finally
                    CType(myConnection, IDisposable).Dispose()
                End Try
            Else
                If Not myRemitoItem.Nuevo Then Delete(SC, myRemitoItem.Id)
            End If

            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetRemitos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleRemito", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As RemitoItem
            Dim myRemitoItem As RemitoItem = New RemitoItem
            myRemitoItem.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleRemito"))

            'Fijate que no estoy trayendo el id del padre. Esto es deliberado? Es conveniente?

            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdArticulo")) Then
                myRemitoItem.IdArticulo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdArticulo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Codigo")) Then
                myRemitoItem.Codigo = myDataRecord.GetString(myDataRecord.GetOrdinal("Codigo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Articulo")) Then
                myRemitoItem.Articulo = myDataRecord.GetString(myDataRecord.GetOrdinal("Articulo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cantidad")) Then
                myRemitoItem.Cantidad = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Cantidad"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdUnidad")) Then
                myRemitoItem.IdUnidad = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdUnidad"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Unidad")) Then
                myRemitoItem.Unidad = myDataRecord.GetString(myDataRecord.GetOrdinal("Unidad"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaEntrega")) Then
                myRemitoItem.FechaEntrega = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaEntrega"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NumeroItem")) Then
                myRemitoItem.NumeroItem = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroItem"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Observaciones")) Then
                myRemitoItem.Observaciones = myDataRecord.GetString(myDataRecord.GetOrdinal("Observaciones"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cantidad1")) Then
                myRemitoItem.Cantidad1 = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Cantidad1"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cantidad2")) Then
                myRemitoItem.Cantidad2 = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Cantidad2"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleLMateriales")) Then
                myRemitoItem.IdDetalleLMateriales = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleLMateriales"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdComprador")) Then
                myRemitoItem.IdComprador = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdComprador"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Comprador")) Then
                myRemitoItem.Comprador = myDataRecord.GetString(myDataRecord.GetOrdinal("Comprador"))
            End If
            'If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NumeroRemitoCompra1")) Then
            '    myRemitoItem.NumeroRemitoCompra1 = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroRemitoCompra1"))
            'End If
            'If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NumeroRemitoCompra2")) Then
            '    myRemitoItem.NumeroRemitoCompra2 = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroRemitoCompra2"))
            'End If
            'If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaRemitoCompra")) Then
            '    myRemitoItem.FechaRemitoCompra = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaRemitoCompra"))
            'End If
            'If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImporteRemitoCompra")) Then
            '    myRemitoItem.ImporteRemitoCompra = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("ImporteRemitoCompra"))
            'End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdProveedor")) Then
                myRemitoItem.IdProveedor = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdProveedor"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ProveedorCompra")) Then
                myRemitoItem.ProveedorCompra = myDataRecord.GetString(myDataRecord.GetOrdinal("ProveedorCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cumplido")) Then
                myRemitoItem.Cumplido = myDataRecord.GetString(myDataRecord.GetOrdinal("Cumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("DescripcionManual")) Then
                myRemitoItem.DescripcionManual = myDataRecord.GetString(myDataRecord.GetOrdinal("DescripcionManual"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdRemitoOriginal")) Then
                'myRemitoItem.IdRemitoOriginal = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdRemitoOriginal"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleRemitoOriginal")) Then
                'myRemitoItem.IdDetalleRemitoOriginal = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleRemitoOriginal"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdOrigenTransmision")) Then
                myRemitoItem.IdOrigenTransmision = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdOrigenTransmision"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdAutorizoCumplido")) Then
                myRemitoItem.IdAutorizoCumplido = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdAutorizoCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDioPorCumplido")) Then
                myRemitoItem.IdDioPorCumplido = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDioPorCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaDadoPorCumplido")) Then
                myRemitoItem.FechaDadoPorCumplido = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaDadoPorCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ObservacionesCumplido")) Then
                myRemitoItem.ObservacionesCumplido = myDataRecord.GetString(myDataRecord.GetOrdinal("ObservacionesCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Costo")) Then
                myRemitoItem.Costo = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Costo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("OrigenDescripcion")) Then
                myRemitoItem.OrigenDescripcion = myDataRecord.GetInt32(myDataRecord.GetOrdinal("OrigenDescripcion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("TipoDesignacion")) Then
                myRemitoItem.TipoDesignacion = myDataRecord.GetString(myDataRecord.GetOrdinal("TipoDesignacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdLiberoParaCompras")) Then
                myRemitoItem.IdLiberoParaCompras = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdLiberoParaCompras"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaLiberacionParaCompras")) Then
                myRemitoItem.FechaLiberacionParaCompras = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaLiberacionParaCompras"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Recepcionado")) Then
                myRemitoItem.Recepcionado = myDataRecord.GetString(myDataRecord.GetOrdinal("Recepcionado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Pagina")) Then
                myRemitoItem.Pagina = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Pagina"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Item")) Then
                myRemitoItem.Item = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Item"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Figura")) Then
                myRemitoItem.Figura = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Figura"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CodigoDistribucion")) Then
                myRemitoItem.CodigoDistribucion = myDataRecord.GetString(myDataRecord.GetOrdinal("CodigoDistribucion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdEquipoDestino")) Then
                myRemitoItem.IdEquipoDestino = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdEquipoDestino"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Entregado")) Then
                myRemitoItem.Entregado = myDataRecord.GetString(myDataRecord.GetOrdinal("Entregado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAsignacionComprador")) Then
                myRemitoItem.FechaAsignacionComprador = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAsignacionComprador"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("MoP")) Then
                myRemitoItem.MoP = myDataRecord.GetString(myDataRecord.GetOrdinal("MoP"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleObraDestino")) Then
                myRemitoItem.IdDetalleObraDestino = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleObraDestino"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Adjunto")) Then
                myRemitoItem.Adjunto = myDataRecord.GetString(myDataRecord.GetOrdinal("Adjunto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto1")) Then
                myRemitoItem.ArchivoAdjunto1 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto1"))
            End If
            Return myRemitoItem
        End Function
    End Class
End Namespace