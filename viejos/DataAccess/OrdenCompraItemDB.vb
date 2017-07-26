Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class OrdenCompraItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As OrdenCompraItem
            Dim myOrdenCompraItem As OrdenCompraItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetFacturas_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleFactura", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myOrdenCompraItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myOrdenCompraItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdOrdenCompra As Integer) As OrdenCompraItemList
            Dim tempList As OrdenCompraItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetOrdenesCompra_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdOrdenCompra", IdOrdenCompra)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New OrdenCompraItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myOrdenCompraItem As OrdenCompraItem) As Integer
            Dim result As Integer = 0
            If Not myOrdenCompraItem.Eliminado Then
                Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
                Try
                    Dim myCommand As SqlCommand = New SqlCommand("wDetFacturas_A", myConnection)
                    myCommand.CommandType = CommandType.StoredProcedure
                    If myOrdenCompraItem.Nuevo Then
                        myCommand.Parameters.AddWithValue("@IdDetalleFactura", DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@IdDetalleFactura", myOrdenCompraItem.Id)
                    End If
                    myCommand.Parameters.AddWithValue("@IdFactura", myOrdenCompraItem.Id)
                    myCommand.Parameters.AddWithValue("@NumeroItem", myOrdenCompraItem.NumeroItem)
                    myCommand.Parameters.AddWithValue("@Cantidad", myOrdenCompraItem.Cantidad)
                    myCommand.Parameters.AddWithValue("@IdUnidad", myOrdenCompraItem.IdUnidad)
                    myCommand.Parameters.AddWithValue("@IdArticulo", myOrdenCompraItem.IdArticulo)
                    If myOrdenCompraItem.FechaEntrega = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaEntrega", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaEntrega", myOrdenCompraItem.FechaEntrega)
                    End If
                    myCommand.Parameters.AddWithValue("@Observaciones", myOrdenCompraItem.Observaciones)
                    myCommand.Parameters.AddWithValue("@Cantidad1", myOrdenCompraItem.Cantidad1)
                    myCommand.Parameters.AddWithValue("@Cantidad2", myOrdenCompraItem.Cantidad2)
                    myCommand.Parameters.AddWithValue("@IdDetalleLMateriales", myOrdenCompraItem.IdDetalleLMateriales)
                    myCommand.Parameters.AddWithValue("@IdComprador", myOrdenCompraItem.IdComprador)
                    myCommand.Parameters.AddWithValue("@NumeroFacturaCompra1", myOrdenCompraItem.NumeroFacturaCompra1)
                    If myOrdenCompraItem.FechaFacturaCompra = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaFacturaCompra", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaFacturaCompra", myOrdenCompraItem.FechaFacturaCompra)
                    End If
                    myCommand.Parameters.AddWithValue("@ImporteFacturaCompra", myOrdenCompraItem.ImporteFacturaCompra)
                    myCommand.Parameters.AddWithValue("@IdProveedor", myOrdenCompraItem.IdProveedor)
                    myCommand.Parameters.AddWithValue("@NumeroFacturaCompra2", myOrdenCompraItem.NumeroFacturaCompra2)
                    myCommand.Parameters.AddWithValue("@Cumplido", myOrdenCompraItem.Cumplido)
                    myCommand.Parameters.AddWithValue("@DescripcionManual", myOrdenCompraItem.DescripcionManual)
                    'myCommand.Parameters.AddWithValue("@IdFacturaOriginal", myOrdenCompraItem.IdFacturaOriginal)
                    'myCommand.Parameters.AddWithValue("@IdDetalleFacturaOriginal", myOrdenCompraItem.IdDetalleFacturaOriginal)
                    myCommand.Parameters.AddWithValue("@IdOrigenTransmision", myOrdenCompraItem.IdOrigenTransmision)
                    myCommand.Parameters.AddWithValue("@IdAutorizoCumplido", myOrdenCompraItem.IdAutorizoCumplido)
                    myCommand.Parameters.AddWithValue("@IdDioPorCumplido", myOrdenCompraItem.IdDioPorCumplido)
                    If myOrdenCompraItem.FechaDadoPorCumplido = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaDadoPorCumplido", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaDadoPorCumplido", myOrdenCompraItem.FechaDadoPorCumplido)
                    End If
                    myCommand.Parameters.AddWithValue("@ObservacionesCumplido", myOrdenCompraItem.ObservacionesCumplido)
                    myCommand.Parameters.AddWithValue("@Costo", myOrdenCompraItem.Costo)
                    myCommand.Parameters.AddWithValue("@OrigenDescripcion", myOrdenCompraItem.OrigenDescripcion)
                    myCommand.Parameters.AddWithValue("@TipoDesignacion", myOrdenCompraItem.TipoDesignacion)
                    myCommand.Parameters.AddWithValue("@IdLiberoParaCompras", myOrdenCompraItem.IdLiberoParaCompras)
                    If myOrdenCompraItem.FechaLiberacionParaCompras = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaLiberacionParaCompras", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaLiberacionParaCompras", myOrdenCompraItem.FechaLiberacionParaCompras)
                    End If
                    myCommand.Parameters.AddWithValue("@Recepcionado", myOrdenCompraItem.Recepcionado)
                    myCommand.Parameters.AddWithValue("@Pagina", myOrdenCompraItem.Pagina)
                    myCommand.Parameters.AddWithValue("@Item", myOrdenCompraItem.Item)
                    myCommand.Parameters.AddWithValue("@Figura", myOrdenCompraItem.Figura)
                    myCommand.Parameters.AddWithValue("@CodigoDistribucion", myOrdenCompraItem.CodigoDistribucion)
                    myCommand.Parameters.AddWithValue("@IdEquipoDestino", myOrdenCompraItem.IdEquipoDestino)
                    myCommand.Parameters.AddWithValue("@Entregado", myOrdenCompraItem.Entregado)
                    If myOrdenCompraItem.FechaAsignacionComprador = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaAsignacionComprador", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaAsignacionComprador", myOrdenCompraItem.FechaAsignacionComprador)
                    End If
                    myCommand.Parameters.AddWithValue("@MoP", myOrdenCompraItem.MoP)
                    myCommand.Parameters.AddWithValue("@IdDetalleObraDestino", myOrdenCompraItem.IdDetalleObraDestino)
                    myCommand.Parameters.AddWithValue("@Adjunto", myOrdenCompraItem.Adjunto)
                    myCommand.Parameters.AddWithValue("@ArchivoAdjunto1", myOrdenCompraItem.ArchivoAdjunto1)

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
                If Not myOrdenCompraItem.Nuevo Then Delete(SC, myOrdenCompraItem.Id)
            End If
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
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

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As OrdenCompraItem
            Dim myOrdenCompraItem As OrdenCompraItem = New OrdenCompraItem
            'Fijate que no estoy trayendo el id del padre. Esto es deliberado? Es conveniente?

            With myOrdenCompraItem
                SQLtoNET(.Id, "IdDetalleOrdenCompra", myDataRecord)

                SQLtoNET(.TipoCancelacion, "TipoCancelacion", myDataRecord)
                SQLtoNET(.FacturacionAutomatica, "FacturacionAutomatica", myDataRecord)
                SQLtoNET(.Item, "Item", myDataRecord)
                SQLtoNET(.Codigo, "Codigo", myDataRecord)

                SQLtoNET(.IdArticulo, "idarticulo", myDataRecord)
                SQLtoNET(.Articulo, "Articulo", myDataRecord)
                'SQLtoNET(., " [Color]", myDataRecord)
                SQLtoNET(.Cantidad, "Cant.", myDataRecord)
                SQLtoNET(.Unidad, "Un.", myDataRecord)
                SQLtoNET(.OrigenDescripcion, "OrigenDescripcion", myDataRecord)
                SQLtoNET(.PorcentajeBonificacion, "Bonificacion", myDataRecord)
                SQLtoNET(.ImporteTotalItem, "Importe", myDataRecord)
                'SQLtoNET(.stock, "[Stock]", myDataRecord)
                SQLtoNET(.FechaNecesidad, "Fecha nec.", myDataRecord)
                SQLtoNET(.FechaEntrega, "Fecha ent.", myDataRecord)
                SQLtoNET(.Observaciones, "Observaciones", myDataRecord)
                SQLtoNET(.Cumplido, "Cum", myDataRecord)
            End With



            Return myOrdenCompraItem
        End Function
    End Class
End Namespace