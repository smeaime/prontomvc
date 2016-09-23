Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO

Namespace Pronto.ERP.Dal

    Public Class PedidoItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As PedidoItem
            Dim myPedidoItem As PedidoItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetPedidos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetallePedido", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myPedidoItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myPedidoItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdPedido As Integer) As PedidoItemList
            Dim tempList As PedidoItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetPedidos_TT", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdPedido", IdPedido)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New PedidoItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myPedidoItem As PedidoItem) As Integer
            Dim result As Integer = 0
            Dim myCommand As SqlCommand

            With myPedidoItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try


                        If .Nuevo Then

                            myCommand = New SqlCommand("DetPedidos_A", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetallePedido", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand("DetPedidos_M", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetallePedido", .Id)
                        End If





                        NETtoSQL(myCommand, "@IdPedido", .IdPedido)
                        NETtoSQL(myCommand, "@NumeroItem", .NumeroItem)


                        myCommand.Parameters.AddWithValue("@Cantidad", .Cantidad)
                        myCommand.Parameters.AddWithValue("@IdUnidad", .IdUnidad)
                        myCommand.Parameters.AddWithValue("@IdArticulo", .IdArticulo)
                        myCommand.Parameters.AddWithValue("@FechaEntrega", fechaNETtoSQL(.FechaEntrega))
                        myCommand.Parameters.AddWithValue("@Precio", .Precio)
                        myCommand.Parameters.AddWithValue("@Observaciones", iisNull(.Observaciones, DBNull.Value))
                        myCommand.Parameters.AddWithValue("@IdDetalleAcopios", myPedidoItem.IdDetalleAcopios)
                        myCommand.Parameters.AddWithValue("@IdDetalleRequerimiento", .IdDetalleRequerimiento)
                        myCommand.Parameters.AddWithValue("@Cumplido", .Cumplido)
                        myCommand.Parameters.AddWithValue("@FechaNecesidad", fechaNETtoSQL(.FechaNecesidad))
                        myCommand.Parameters.AddWithValue("@IdDetalleLMateriales", .IdDetalleLMateriales)
                        myCommand.Parameters.AddWithValue("@IdCuenta", .IdCuenta)
                        myCommand.Parameters.AddWithValue("@OrigenDescripcion", .OrigenDescripcion)
                        myCommand.Parameters.AddWithValue("@IdAutorizoCumplido", .IdAutorizoCumplido)
                        myCommand.Parameters.AddWithValue("@IdDioPorCumplido", .IdDioPorCumplido)
                        myCommand.Parameters.AddWithValue("@FechaDadoPorCumplido", fechaNETtoSQL(.FechaDadoPorCumplido))
                        myCommand.Parameters.AddWithValue("@ObservacionesCumplido", .ObservacionesCumplido)
                        myCommand.Parameters.AddWithValue("@PorcentajeBonificacion", .PorcentajeBonificacion)
                        myCommand.Parameters.AddWithValue("@ImporteBonificacion", .ImporteBonificacion)
                        myCommand.Parameters.AddWithValue("@PorcentajeIVA", .PorcentajeIVA)
                        myCommand.Parameters.AddWithValue("@ImporteIVA", .ImporteIVA)
                        myCommand.Parameters.AddWithValue("@ImporteTotalItem", .ImporteTotalItem)
                        myCommand.Parameters.AddWithValue("@Costo", .Costo)
                        myCommand.Parameters.AddWithValue("@IdAsignacionCosto", .IdAsignacionCosto)
                        myCommand.Parameters.AddWithValue("@CostoAsignado", .CostoAsignado)
                        myCommand.Parameters.AddWithValue("@IdUsuarioAsignoCosto", myPedidoItem.IdUsuarioAsignoCosto)
                        myCommand.Parameters.AddWithValue("@FechaAsignacionCosto", fechaNETtoSQL(myPedidoItem.FechaAsignacionCosto))
                        myCommand.Parameters.AddWithValue("@IdDetallePedidoOriginal", myPedidoItem.IdDetallePedidoOriginal)
                        myCommand.Parameters.AddWithValue("@IdPedidoOriginal", myPedidoItem.IdPedidoOriginal)
                        myCommand.Parameters.AddWithValue("@IdOrigenTransmision", myPedidoItem.IdOrigenTransmision)
                        myCommand.Parameters.AddWithValue("@PlazoEntrega", myPedidoItem.PlazoEntrega)
                        myCommand.Parameters.AddWithValue("@CostoAsignadoDolar", myPedidoItem.CostoAsignadoDolar)
                        myCommand.Parameters.AddWithValue("@IdDetalleComparativa", myPedidoItem.IdDetalleComparativa)
                        myCommand.Parameters.AddWithValue("@IdDetalleRequerimientoOriginal", myPedidoItem.IdDetalleRequerimientoOriginal)




                        NETtoSQL(myCommand, "@IdControlCalidad")
                        NETtoSQL(myCommand, "@Cantidad1")
                        NETtoSQL(myCommand, "@Cantidad2")
                        NETtoSQL(myCommand, "@CantidadAdicional")
                        NETtoSQL(myCommand, "@CantidadRecibida")
                        NETtoSQL(myCommand, "@CantidadAdicionalRecibida")
                        NETtoSQL(myCommand, "@Adjunto")
                        NETtoSQL(myCommand, "@ArchivoAdjunto")
                        NETtoSQL(myCommand, "@ArchivoAdjunto1")
                        NETtoSQL(myCommand, "@ArchivoAdjunto2")
                        NETtoSQL(myCommand, "@ArchivoAdjunto3")
                        NETtoSQL(myCommand, "@ArchivoAdjunto4")
                        NETtoSQL(myCommand, "@ArchivoAdjunto5")
                        NETtoSQL(myCommand, "@ArchivoAdjunto6") 
                        NETtoSQL(myCommand, "@ArchivoAdjunto7")
                        NETtoSQL(myCommand, "@ArchivoAdjunto8")
                        NETtoSQL(myCommand, "@ArchivoAdjunto9")
                        NETtoSQL(myCommand, "@ArchivoAdjunto10")
                        NETtoSQL(myCommand, "@IdCentroCosto")
                        NETtoSQL(myCommand, "@PRESTOPedido")
                        NETtoSQL(myCommand, "@PRESTOFechaProceso")
                        NETtoSQL(myCommand, "@EnviarEmail")
                        NETtoSQL(myCommand, "@ImpuestosInternos")

                        NETtoSQL(myCommand, "@CostoOriginal")

                        NETtoSQL(myCommand, "@IdUsuarioModificoCosto")
                        NETtoSQL(myCommand, "@FechaModificacionCosto")
                        NETtoSQL(myCommand, "@ObservacionModificacionCosto")


                        Dim returnValue As DbParameter
                        returnValue = myCommand.CreateParameter
                        returnValue.Direction = ParameterDirection.ReturnValue
                        myCommand.Parameters.Add(returnValue)
                        myConnection.Open()
                        myCommand.ExecuteNonQuery()
                        result = Convert.ToInt32(returnValue.Value)
                        myConnection.Close()
                    Catch ex As Exception
                        DebugGetStoreProcedureParameters(myCommand)
                        Throw
                    Finally
                        CType(myConnection, IDisposable).Dispose()
                    End Try
                Else
                    If Not myPedidoItem.Nuevo Then Delete(SC, myPedidoItem.Id)
                End If
                Return result
            End With

        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetPedidos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetallePedido", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As PedidoItem
            Dim myPedidoItem As PedidoItem = New PedidoItem

            With myPedidoItem

                SQLtoNET(.Id, "IdDetallePedido", myDataRecord)
                SQLtoNET(.NumeroItem, "NumeroItem", myDataRecord)

              
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdArticulo")) Then
                    myPedidoItem.IdArticulo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdArticulo"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Codigo")) Then
                    myPedidoItem.Codigo = myDataRecord.GetString(myDataRecord.GetOrdinal("Codigo"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Articulo")) Then
                    myPedidoItem.Articulo = myDataRecord.GetString(myDataRecord.GetOrdinal("Articulo"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cantidad")) Then
                    myPedidoItem.Cantidad = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Cantidad"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdUnidad")) Then
                    myPedidoItem.IdUnidad = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdUnidad"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Unidad")) Then
                    myPedidoItem.Unidad = myDataRecord.GetString(myDataRecord.GetOrdinal("Unidad"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaEntrega")) Then
                    myPedidoItem.FechaEntrega = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaEntrega"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaNecesidad")) Then
                    myPedidoItem.FechaNecesidad = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaNecesidad"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Precio")) Then
                    myPedidoItem.Precio = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Precio"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Observaciones")) Then
                    myPedidoItem.Observaciones = myDataRecord.GetString(myDataRecord.GetOrdinal("Observaciones"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleAcopios")) Then
                    myPedidoItem.IdDetalleAcopios = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleAcopios"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleRequerimiento")) Then
                    myPedidoItem.IdDetalleRequerimiento = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleRequerimiento"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleLMateriales")) Then
                    myPedidoItem.IdDetalleLMateriales = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleLMateriales"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cumplido")) Then
                    myPedidoItem.Cumplido = myDataRecord.GetString(myDataRecord.GetOrdinal("Cumplido"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdCuenta")) Then
                    myPedidoItem.IdCuenta = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdCuenta"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("OrigenDescripcion")) Then
                    myPedidoItem.OrigenDescripcion = myDataRecord.GetInt32(myDataRecord.GetOrdinal("OrigenDescripcion"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdAutorizoCumplido")) Then
                    myPedidoItem.IdAutorizoCumplido = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdAutorizoCumplido"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDioPorCumplido")) Then
                    myPedidoItem.IdDioPorCumplido = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDioPorCumplido"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaDadoPorCumplido")) Then
                    myPedidoItem.FechaDadoPorCumplido = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaDadoPorCumplido"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ObservacionesCumplido")) Then
                    myPedidoItem.ObservacionesCumplido = myDataRecord.GetString(myDataRecord.GetOrdinal("ObservacionesCumplido"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PorcentajeBonificacion")) Then
                    myPedidoItem.PorcentajeBonificacion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("PorcentajeBonificacion"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImporteBonificacion")) Then
                    myPedidoItem.ImporteBonificacion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("ImporteBonificacion"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PorcentajeIVA")) Then
                    myPedidoItem.PorcentajeIVA = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("PorcentajeIVA"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImporteIVA")) Then
                    myPedidoItem.ImporteIVA = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("ImporteIVA"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImporteTotalItem")) Then
                    myPedidoItem.ImporteTotalItem = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("ImporteTotalItem"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Costo")) Then
                    myPedidoItem.Costo = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Costo"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdAsignacionCosto")) Then
                    myPedidoItem.IdAsignacionCosto = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdAsignacionCosto"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CostoAsignado")) Then
                    myPedidoItem.CostoAsignado = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("CostoAsignado"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdUsuarioAsignoCosto")) Then
                    myPedidoItem.IdUsuarioAsignoCosto = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdUsuarioAsignoCosto"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAsignacionCosto")) Then
                    myPedidoItem.FechaAsignacionCosto = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAsignacionCosto"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetallePedidoOriginal")) Then
                    myPedidoItem.IdDetallePedidoOriginal = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetallePedidoOriginal"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdPedidoOriginal")) Then
                    myPedidoItem.IdPedidoOriginal = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdPedidoOriginal"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdOrigenTransmision")) Then
                    myPedidoItem.IdOrigenTransmision = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdOrigenTransmision"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PlazoEntrega")) Then
                    myPedidoItem.PlazoEntrega = myDataRecord.GetString(myDataRecord.GetOrdinal("PlazoEntrega"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CostoAsignadoDolar")) Then
                    myPedidoItem.CostoAsignadoDolar = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("CostoAsignadoDolar"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleComparativa")) Then
                    myPedidoItem.IdDetalleComparativa = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleComparativa"))
                End If
                If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDetalleRequerimientoOriginal")) Then
                    myPedidoItem.IdDetalleRequerimientoOriginal = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleRequerimientoOriginal"))
                End If


                Return myPedidoItem
            End With
        End Function




    End Class
End Namespace