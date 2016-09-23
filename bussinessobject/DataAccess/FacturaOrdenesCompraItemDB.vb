Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class FacturaOrdenesCompraItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As FacturaItem
            Dim myFacturaItem As FacturaItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetFacturas_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleFactura", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myFacturaItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myFacturaItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdFactura As Integer) As FacturaItemList
            Dim tempList As FacturaItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("DetFacturaOrdenCompra_TX_PorIdCabecera", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdFactura", IdFactura)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New FacturaItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myFacturaItem As FacturaOrdenesCompraItem) As Integer
            Dim result As Integer = 0
            With myFacturaItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand("DetFacturasOrdenesCompra_A", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleFacturaOrdenesCompra", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand("DetFacturasOrdenesCompra_M", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleFacturaOrdenesCompra", .Id)
                        End If


                        NETtoSQL(myCommand, "@IdDetalleFactura", .IdDetalleFactura)
                        NETtoSQL(myCommand, "@IdFactura", .IdFactura)
                        NETtoSQL(myCommand, "@IdDetalleOrdenCompra", .IdDetalleOrdenCompra)
                        NETtoSQL(myCommand, "@EnviarEmail", .EnviarEmail)


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
                    If Not myFacturaItem.Nuevo Then Delete(SC, myFacturaItem.Id)
                End If
            End With
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetFacturas_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleFactura", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As FacturaItem
            Dim myFacturaItem As FacturaItem = New FacturaItem
            myFacturaItem.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleFactura"))

            'Fijate que no estoy trayendo el id del padre. Esto es deliberado? Es conveniente?

            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdArticulo")) Then
                myFacturaItem.IdArticulo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdArticulo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Codigo")) Then
                myFacturaItem.Codigo = myDataRecord.GetString(myDataRecord.GetOrdinal("Codigo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Articulo")) Then
                myFacturaItem.Articulo = myDataRecord.GetString(myDataRecord.GetOrdinal("Articulo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cantidad")) Then
                myFacturaItem.Cantidad = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Cantidad"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdUnidad")) Then
                myFacturaItem.IdUnidad = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdUnidad"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Unidad")) Then
                myFacturaItem.Unidad = myDataRecord.GetString(myDataRecord.GetOrdinal("Unidad"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaEntrega")) Then
                myFacturaItem.FechaEntrega = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaEntrega"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NumeroItem")) Then
                myFacturaItem.NumeroItem = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroItem"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Observaciones")) Then
                myFacturaItem.Observaciones = myDataRecord.GetString(myDataRecord.GetOrdinal("Observaciones"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cantidad1")) Then
                myFacturaItem.Cantidad1 = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Cantidad1"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cantidad2")) Then
                myFacturaItem.Cantidad2 = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Cantidad2"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleLMateriales")) Then
                myFacturaItem.IdDetalleLMateriales = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleLMateriales"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdComprador")) Then
                myFacturaItem.IdComprador = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdComprador"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Comprador")) Then
                myFacturaItem.Comprador = myDataRecord.GetString(myDataRecord.GetOrdinal("Comprador"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NumeroFacturaCompra1")) Then
                myFacturaItem.NumeroFacturaCompra1 = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroFacturaCompra1"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NumeroFacturaCompra2")) Then
                myFacturaItem.NumeroFacturaCompra2 = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroFacturaCompra2"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaFacturaCompra")) Then
                myFacturaItem.FechaFacturaCompra = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaFacturaCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImporteFacturaCompra")) Then
                myFacturaItem.ImporteFacturaCompra = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("ImporteFacturaCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdProveedor")) Then
                myFacturaItem.IdProveedor = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdProveedor"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ProveedorCompra")) Then
                myFacturaItem.ProveedorCompra = myDataRecord.GetString(myDataRecord.GetOrdinal("ProveedorCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cumplido")) Then
                myFacturaItem.Cumplido = myDataRecord.GetString(myDataRecord.GetOrdinal("Cumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("DescripcionManual")) Then
                myFacturaItem.DescripcionManual = myDataRecord.GetString(myDataRecord.GetOrdinal("DescripcionManual"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdFacturaOriginal")) Then
                'myFacturaItem.IdFacturaOriginal = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdFacturaOriginal"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleFacturaOriginal")) Then
                'myFacturaItem.IdDetalleFacturaOriginal = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleFacturaOriginal"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdOrigenTransmision")) Then
                myFacturaItem.IdOrigenTransmision = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdOrigenTransmision"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdAutorizoCumplido")) Then
                myFacturaItem.IdAutorizoCumplido = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdAutorizoCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDioPorCumplido")) Then
                myFacturaItem.IdDioPorCumplido = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDioPorCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaDadoPorCumplido")) Then
                myFacturaItem.FechaDadoPorCumplido = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaDadoPorCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ObservacionesCumplido")) Then
                myFacturaItem.ObservacionesCumplido = myDataRecord.GetString(myDataRecord.GetOrdinal("ObservacionesCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Costo")) Then
                myFacturaItem.Costo = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Costo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("OrigenDescripcion")) Then
                myFacturaItem.OrigenDescripcion = myDataRecord.GetInt32(myDataRecord.GetOrdinal("OrigenDescripcion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("TipoDesignacion")) Then
                myFacturaItem.TipoDesignacion = myDataRecord.GetString(myDataRecord.GetOrdinal("TipoDesignacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdLiberoParaCompras")) Then
                myFacturaItem.IdLiberoParaCompras = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdLiberoParaCompras"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaLiberacionParaCompras")) Then
                myFacturaItem.FechaLiberacionParaCompras = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaLiberacionParaCompras"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Recepcionado")) Then
                myFacturaItem.Recepcionado = myDataRecord.GetString(myDataRecord.GetOrdinal("Recepcionado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Pagina")) Then
                myFacturaItem.Pagina = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Pagina"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Item")) Then
                myFacturaItem.Item = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Item"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Figura")) Then
                myFacturaItem.Figura = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Figura"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CodigoDistribucion")) Then
                myFacturaItem.CodigoDistribucion = myDataRecord.GetString(myDataRecord.GetOrdinal("CodigoDistribucion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdEquipoDestino")) Then
                myFacturaItem.IdEquipoDestino = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdEquipoDestino"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Entregado")) Then
                myFacturaItem.Entregado = myDataRecord.GetString(myDataRecord.GetOrdinal("Entregado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAsignacionComprador")) Then
                myFacturaItem.FechaAsignacionComprador = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAsignacionComprador"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("MoP")) Then
                myFacturaItem.MoP = myDataRecord.GetString(myDataRecord.GetOrdinal("MoP"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleObraDestino")) Then
                myFacturaItem.IdDetalleObraDestino = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleObraDestino"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Adjunto")) Then
                myFacturaItem.Adjunto = myDataRecord.GetString(myDataRecord.GetOrdinal("Adjunto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ArchivoAdjunto1")) Then
                myFacturaItem.ArchivoAdjunto1 = myDataRecord.GetString(myDataRecord.GetOrdinal("ArchivoAdjunto1"))
            End If
            Return myFacturaItem
        End Function
    End Class
End Namespace