Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class ComprobanteProveedorItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As ComprobanteProveedorItem
            Dim myComprobanteProveedorItem As ComprobanteProveedorItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetComprobantesProveedores_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleComprobanteProveedor", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myComprobanteProveedorItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myComprobanteProveedorItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdComprobanteProveedor As Integer) As ComprobanteProveedorItemList
            Dim tempList As ComprobanteProveedorItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetComprobantesProveedores_TT", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdComprobanteProveedor", IdComprobanteProveedor)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New ComprobanteProveedorItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myComprobanteProveedorItem As ComprobanteProveedorItem) As Integer
            Dim result As Integer = 0

            With myComprobanteProveedorItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand(enumSPs.DetComprobantesProveedores_A.ToString, myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleComprobanteProveedor", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand(enumSPs.DetComprobantesProveedores_M.ToString, myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleComprobanteProveedor", .Id)
                        End If



                        NETtoSQL(myCommand, "@IdComprobanteProveedor", .IdComprobanteProveedor)
                        NETtoSQL(myCommand, "@IdArticulo", .IdArticulo)
                        NETtoSQL(myCommand, "@CodigoArticulo", .CodigoArticulo)
                        NETtoSQL(myCommand, "@IdCuenta", .IdCuenta)
                        NETtoSQL(myCommand, "@CodigoCuenta", .CodigoCuenta)
                        NETtoSQL(myCommand, "@PorcentajeIvaAplicado", .PorcentajeIvaAplicado)
                        NETtoSQL(myCommand, "@Importe", .Importe)
                        NETtoSQL(myCommand, "@IdCuentaGasto", .IdCuentaGasto)
                        NETtoSQL(myCommand, "@IdCuentaIvaCompras1", .IdCuentaIvaCompras1)
                        NETtoSQL(myCommand, "@IVAComprasPorcentaje1", .IVAComprasPorcentaje1)
                        NETtoSQL(myCommand, "@ImporteIVA1", .ImporteIVA1)
                        NETtoSQL(myCommand, "@AplicarIVA1", .AplicarIVA1)
                        NETtoSQL(myCommand, "@IdCuentaIvaCompras2", .IdCuentaIvaCompras2)
                        NETtoSQL(myCommand, "@IVAComprasPorcentaje2", .IVAComprasPorcentaje2)
                        NETtoSQL(myCommand, "@ImporteIVA2", .ImporteIVA2)
                        NETtoSQL(myCommand, "@AplicarIVA2", .AplicarIVA2)
                        NETtoSQL(myCommand, "@IdCuentaIvaCompras3", .IdCuentaIvaCompras3)
                        NETtoSQL(myCommand, "@IVAComprasPorcentaje3", .IVAComprasPorcentaje3)
                        NETtoSQL(myCommand, "@ImporteIVA3", .ImporteIVA3)
                        NETtoSQL(myCommand, "@AplicarIVA3", .AplicarIVA3)
                        NETtoSQL(myCommand, "@IdCuentaIvaCompras4", .IdCuentaIvaCompras4)
                        NETtoSQL(myCommand, "@IVAComprasPorcentaje4", .IVAComprasPorcentaje4)
                        NETtoSQL(myCommand, "@ImporteIVA4", .ImporteIVA4)
                        NETtoSQL(myCommand, "@AplicarIVA4", .AplicarIVA4)
                        NETtoSQL(myCommand, "@IdCuentaIvaCompras5", .IdCuentaIvaCompras5)
                        NETtoSQL(myCommand, "@IVAComprasPorcentaje5", .IVAComprasPorcentaje5)
                        NETtoSQL(myCommand, "@ImporteIVA5", .ImporteIVA5)
                        NETtoSQL(myCommand, "@AplicarIVA5", .AplicarIVA5)
                        NETtoSQL(myCommand, "@IdObra", .IdObra)
                        NETtoSQL(myCommand, "@Item", .Item)
                        NETtoSQL(myCommand, "@IdCuentaIvaCompras6", .IdCuentaIvaCompras6)
                        NETtoSQL(myCommand, "@IVAComprasPorcentaje6", .IVAComprasPorcentaje6)
                        NETtoSQL(myCommand, "@ImporteIVA6", .ImporteIVA6)
                        NETtoSQL(myCommand, "@AplicarIVA6", .AplicarIVA6)
                        NETtoSQL(myCommand, "@IdCuentaIvaCompras7", .IdCuentaIvaCompras7)
                        NETtoSQL(myCommand, "@IVAComprasPorcentaje7", .IVAComprasPorcentaje7)
                        NETtoSQL(myCommand, "@ImporteIVA7", .ImporteIVA7)
                        NETtoSQL(myCommand, "@AplicarIVA7", .AplicarIVA7)
                        NETtoSQL(myCommand, "@IdCuentaIvaCompras8", .IdCuentaIvaCompras8)
                        NETtoSQL(myCommand, "@IVAComprasPorcentaje8", .IVAComprasPorcentaje8)
                        NETtoSQL(myCommand, "@ImporteIVA8", .ImporteIVA8)
                        NETtoSQL(myCommand, "@AplicarIVA8", .AplicarIVA8)
                        NETtoSQL(myCommand, "@IdCuentaIvaCompras9", .IdCuentaIvaCompras9)
                        NETtoSQL(myCommand, "@IVAComprasPorcentaje9", .IVAComprasPorcentaje9)
                        NETtoSQL(myCommand, "@ImporteIVA9", .ImporteIVA9)
                        NETtoSQL(myCommand, "@AplicarIVA9", .AplicarIVA9)
                        NETtoSQL(myCommand, "@IdCuentaIvaCompras10", .IdCuentaIvaCompras10)
                        NETtoSQL(myCommand, "@IVAComprasPorcentaje10", .IVAComprasPorcentaje10)
                        NETtoSQL(myCommand, "@ImporteIVA10", .ImporteIVA10)
                        NETtoSQL(myCommand, "@AplicarIVA10", .AplicarIVA10)
                        NETtoSQL(myCommand, "@IVAComprasPorcentajeDirecto", .IVAComprasPorcentajeDirecto)
                        NETtoSQL(myCommand, "@IdCuentaBancaria", .IdCuentaBancaria)
                        NETtoSQL(myCommand, "@PRESTOConcepto", .PRESTOConcepto)
                        NETtoSQL(myCommand, "@PRESTOObra", .PRESTOObra)
                        NETtoSQL(myCommand, "@IdDetalleRecepcion", .IdDetalleRecepcion)
                        NETtoSQL(myCommand, "@TomarEnCalculoDeImpuestos", .TomarEnCalculoDeImpuestos)
                        NETtoSQL(myCommand, "@IdRubroContable", .IdRubroContable)
                        NETtoSQL(myCommand, "@IdPedido", .IdPedido)
                        NETtoSQL(myCommand, "@IdDetallePedido", .IdDetallePedido)
                        NETtoSQL(myCommand, "@Importacion_FOB", .Importacion_FOB)
                        NETtoSQL(myCommand, "@Importacion_PosicionAduana", .Importacion_PosicionAduana)
                        NETtoSQL(myCommand, "@Importacion_Despacho", .Importacion_Despacho)
                        NETtoSQL(myCommand, "@Importacion_Guia", .Importacion_Guia)
                        NETtoSQL(myCommand, "@Importacion_IdPaisOrigen", .Importacion_IdPaisOrigen)
                        NETtoSQL(myCommand, "@Importacion_FechaEmbarque", .Importacion_FechaEmbarque)
                        NETtoSQL(myCommand, "@Importacion_FechaOficializacion", .Importacion_FechaOficializacion)
                        NETtoSQL(myCommand, "@IdProvinciaDestino1", .IdProvinciaDestino1)
                        NETtoSQL(myCommand, "@PorcentajeProvinciaDestino1", .PorcentajeProvinciaDestino1)
                        NETtoSQL(myCommand, "@IdProvinciaDestino2", .IdProvinciaDestino2)
                        NETtoSQL(myCommand, "@PorcentajeProvinciaDestino2", .PorcentajeProvinciaDestino2)
                        NETtoSQL(myCommand, "@IdDistribucionObra", .IdDistribucionObra)
                        NETtoSQL(myCommand, "@Cantidad", .Cantidad)
                        NETtoSQL(myCommand, "@IdDetalleObraDestino", .IdDetalleObraDestino)
                        NETtoSQL(myCommand, "@IdPresupuestoObraRubro", .IdPresupuestoObraRubro)
                        NETtoSQL(myCommand, "@IdPedidoAnticipo", .IdPedidoAnticipo)
                        NETtoSQL(myCommand, "@PorcentajeAnticipo", .PorcentajeAnticipo)
                        NETtoSQL(myCommand, "@PorcentajeCertificacion", .PorcentajeCertificacion)
                        NETtoSQL(myCommand, "@IdPresupuestoObrasNodo", .IdPresupuestoObrasNodo)
                        NETtoSQL(myCommand, "@IdDetalleComprobanteProveedorOriginal", .IdDetalleComprobanteProveedorOriginal)
                        NETtoSQL(myCommand, "@NumeroSubcontrato", .NumeroSubcontrato)
                        NETtoSQL(myCommand, "@IdSubcontrato", .IdSubcontrato)
                        NETtoSQL(myCommand, "@AmpliacionSubcontrato", .AmpliacionSubcontrato)
                        NETtoSQL(myCommand, "@IdDetalleSubcontratoDatos", .IdDetalleSubcontratoDatos)
                        NETtoSQL(myCommand, "@IdEquipoDestino", .IdEquipoDestino)



                        Dim returnValue As DbParameter
                        returnValue = myCommand.CreateParameter
                        returnValue.Direction = ParameterDirection.ReturnValue
                        myCommand.Parameters.Add(returnValue)
                        myConnection.Open()
                        myCommand.ExecuteNonQuery()
                        result = Convert.ToInt32(returnValue.Value)
                        myConnection.Close()
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    Finally
                        CType(myConnection, IDisposable).Dispose()
                    End Try
                Else
                    If Not myComprobanteProveedorItem.Nuevo Then Delete(SC, myComprobanteProveedorItem.Id)
                End If
                Return result
            End With


        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetComprobantesProveedores_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleComprobanteProveedor", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As ComprobanteProveedorItem
            Dim myComprobanteProveedorItem As ComprobanteProveedorItem = New ComprobanteProveedorItem

            With myComprobanteProveedorItem
                SQLtoNET(myDataRecord, "@IdDetalleComprobanteProveedor", .Id)

                SQLtoNET(myDataRecord, "@IdComprobanteProveedor", .IdComprobanteProveedor)
                SQLtoNET(myDataRecord, "@IdArticulo", .IdArticulo)
                SQLtoNET(myDataRecord, "@CodigoArticulo", .CodigoArticulo)
                SQLtoNET(myDataRecord, "@IdCuenta", .IdCuenta)
                SQLtoNET(myDataRecord, "@CodigoCuenta", .CodigoCuenta)
                SQLtoNET(myDataRecord, "@PorcentajeIvaAplicado", .PorcentajeIvaAplicado)
                SQLtoNET(myDataRecord, "@Importe", .Importe)
                SQLtoNET(myDataRecord, "@IdCuentaGasto", .IdCuentaGasto)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras1", .IdCuentaIvaCompras1)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje1", .IVAComprasPorcentaje1)
                SQLtoNET(myDataRecord, "@ImporteIVA1", .ImporteIVA1)
                SQLtoNET(myDataRecord, "@AplicarIVA1", .AplicarIVA1)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras2", .IdCuentaIvaCompras2)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje2", .IVAComprasPorcentaje2)
                SQLtoNET(myDataRecord, "@ImporteIVA2", .ImporteIVA2)
                SQLtoNET(myDataRecord, "@AplicarIVA2", .AplicarIVA2)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras3", .IdCuentaIvaCompras3)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje3", .IVAComprasPorcentaje3)
                SQLtoNET(myDataRecord, "@ImporteIVA3", .ImporteIVA3)
                SQLtoNET(myDataRecord, "@AplicarIVA3", .AplicarIVA3)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras4", .IdCuentaIvaCompras4)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje4", .IVAComprasPorcentaje4)
                SQLtoNET(myDataRecord, "@ImporteIVA4", .ImporteIVA4)
                SQLtoNET(myDataRecord, "@AplicarIVA4", .AplicarIVA4)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras5", .IdCuentaIvaCompras5)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje5", .IVAComprasPorcentaje5)
                SQLtoNET(myDataRecord, "@ImporteIVA5", .ImporteIVA5)
                SQLtoNET(myDataRecord, "@AplicarIVA5", .AplicarIVA5)
                SQLtoNET(myDataRecord, "@IdObra", .IdObra)
                SQLtoNET(myDataRecord, "@Item", .Item)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras6", .IdCuentaIvaCompras6)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje6", .IVAComprasPorcentaje6)
                SQLtoNET(myDataRecord, "@ImporteIVA6", .ImporteIVA6)
                SQLtoNET(myDataRecord, "@AplicarIVA6", .AplicarIVA6)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras7", .IdCuentaIvaCompras7)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje7", .IVAComprasPorcentaje7)
                SQLtoNET(myDataRecord, "@ImporteIVA7", .ImporteIVA7)
                SQLtoNET(myDataRecord, "@AplicarIVA7", .AplicarIVA7)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras8", .IdCuentaIvaCompras8)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje8", .IVAComprasPorcentaje8)
                SQLtoNET(myDataRecord, "@ImporteIVA8", .ImporteIVA8)
                SQLtoNET(myDataRecord, "@AplicarIVA8", .AplicarIVA8)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras9", .IdCuentaIvaCompras9)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje9", .IVAComprasPorcentaje9)
                SQLtoNET(myDataRecord, "@ImporteIVA9", .ImporteIVA9)
                SQLtoNET(myDataRecord, "@AplicarIVA9", .AplicarIVA9)
                SQLtoNET(myDataRecord, "@IdCuentaIvaCompras10", .IdCuentaIvaCompras10)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentaje10", .IVAComprasPorcentaje10)
                SQLtoNET(myDataRecord, "@ImporteIVA10", .ImporteIVA10)
                SQLtoNET(myDataRecord, "@AplicarIVA10", .AplicarIVA10)
                SQLtoNET(myDataRecord, "@IVAComprasPorcentajeDirecto", .IVAComprasPorcentajeDirecto)
                SQLtoNET(myDataRecord, "@IdCuentaBancaria", .IdCuentaBancaria)
                SQLtoNET(myDataRecord, "@PRESTOConcepto", .PRESTOConcepto)
                SQLtoNET(myDataRecord, "@PRESTOObra", .PRESTOObra)
                SQLtoNET(myDataRecord, "@IdDetalleRecepcion", .IdDetalleRecepcion)
                SQLtoNET(myDataRecord, "@TomarEnCalculoDeImpuestos", .TomarEnCalculoDeImpuestos)
                SQLtoNET(myDataRecord, "@IdRubroContable", .IdRubroContable)
                SQLtoNET(myDataRecord, "@IdPedido", .IdPedido)
                SQLtoNET(myDataRecord, "@IdDetallePedido", .IdDetallePedido)
                SQLtoNET(myDataRecord, "@Importacion_FOB", .Importacion_FOB)
                SQLtoNET(myDataRecord, "@Importacion_PosicionAduana", .Importacion_PosicionAduana)
                SQLtoNET(myDataRecord, "@Importacion_Despacho", .Importacion_Despacho)
                SQLtoNET(myDataRecord, "@Importacion_Guia", .Importacion_Guia)
                SQLtoNET(myDataRecord, "@Importacion_IdPaisOrigen", .Importacion_IdPaisOrigen)
                SQLtoNET(myDataRecord, "@Importacion_FechaEmbarque", .Importacion_FechaEmbarque)
                SQLtoNET(myDataRecord, "@Importacion_FechaOficializacion", .Importacion_FechaOficializacion)
                SQLtoNET(myDataRecord, "@IdProvinciaDestino1", .IdProvinciaDestino1)
                SQLtoNET(myDataRecord, "@PorcentajeProvinciaDestino1", .PorcentajeProvinciaDestino1)
                SQLtoNET(myDataRecord, "@IdProvinciaDestino2", .IdProvinciaDestino2)
                SQLtoNET(myDataRecord, "@PorcentajeProvinciaDestino2", .PorcentajeProvinciaDestino2)
                SQLtoNET(myDataRecord, "@IdDistribucionObra", .IdDistribucionObra)
                SQLtoNET(myDataRecord, "@Cantidad", .Cantidad)
                SQLtoNET(myDataRecord, "@IdDetalleObraDestino", .IdDetalleObraDestino)
                SQLtoNET(myDataRecord, "@IdPresupuestoObraRubro", .IdPresupuestoObraRubro)
                SQLtoNET(myDataRecord, "@IdPedidoAnticipo", .IdPedidoAnticipo)
                SQLtoNET(myDataRecord, "@PorcentajeAnticipo", .PorcentajeAnticipo)
                SQLtoNET(myDataRecord, "@PorcentajeCertificacion", .PorcentajeCertificacion)
                SQLtoNET(myDataRecord, "@IdPresupuestoObrasNodo", .IdPresupuestoObrasNodo)
                SQLtoNET(myDataRecord, "@IdDetalleComprobanteProveedorOriginal", .IdDetalleComprobanteProveedorOriginal)
                SQLtoNET(myDataRecord, "@NumeroSubcontrato", .NumeroSubcontrato)
                SQLtoNET(myDataRecord, "@IdSubcontrato", .IdSubcontrato)
                SQLtoNET(myDataRecord, "@AmpliacionSubcontrato", .AmpliacionSubcontrato)
                SQLtoNET(myDataRecord, "@IdDetalleSubcontratoDatos", .IdDetalleSubcontratoDatos)
                SQLtoNET(myDataRecord, "@IdEquipoDestino", .IdEquipoDestino)
            End With



            Return myComprobanteProveedorItem
        End Function
    End Class
End Namespace