Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Imports System.Diagnostics
Imports System.Collections.Generic

Namespace Pronto.ERP.Dal

    Public Class PedidoDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Pedido
            Dim myPedido As Pedido = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wPedidos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdPedido", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myPedido = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myPedido
        End Function

        Public Shared Function GetList(ByVal SC As String) As PedidoList
            Dim tempList As PedidoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wPedidos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New PedidoList
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
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wPedidos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdPedido", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function





        Public Shared Function Save(ByVal SC As String, ByVal myPedido As Pedido) As Integer

            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Dim myCommand As SqlCommand

            Try
                With myPedido


                    If .Id = -1 Then

                        myCommand = New SqlCommand("Pedidos_A", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdPedido", -1)
                        param.Direction = ParameterDirection.Output

                    Else

                        myCommand = New SqlCommand("Pedidos_M", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        myCommand.Parameters.AddWithValue("@IdPedido", .Id)
                    End If



                    NETtoSQL(myCommand, "@NumeroPedido", .Numero)
                    NETtoSQL(myCommand, "@IdProveedor", .IdProveedor)


                    myCommand.Parameters.AddWithValue("@FechaPedido", iisValidSqlDate(myPedido.Fecha))
                    myCommand.Parameters.AddWithValue("@LugarEntrega", myPedido.LugarEntrega)
                    myCommand.Parameters.AddWithValue("@FormaPago", myPedido.FormaPago)
                    myCommand.Parameters.AddWithValue("@Observaciones", myPedido.Observaciones)
                    myCommand.Parameters.AddWithValue("@Bonificacion", myPedido.Bonificacion)
                    myCommand.Parameters.AddWithValue("@TotalIva1", myPedido.TotalIva1)
                    myCommand.Parameters.AddWithValue("@TotalPedido", myPedido.TotalPedido)
                    myCommand.Parameters.AddWithValue("@PorcentajeIva1", myPedido.PorcentajeIva1)
                    myCommand.Parameters.AddWithValue("@IdComprador", myPedido.IdComprador)
                    myCommand.Parameters.AddWithValue("@PorcentajeBonificacion", myPedido.PorcentajeBonificacion)
                    myCommand.Parameters.AddWithValue("@NumeroComparativa", myPedido.NumeroComparativa)
                    myCommand.Parameters.AddWithValue("@Contacto", myPedido.Contacto)
                    myCommand.Parameters.AddWithValue("@PlazoEntrega", myPedido.PlazoEntrega)
                    myCommand.Parameters.AddWithValue("@Garantia", myPedido.Garantia)
                    myCommand.Parameters.AddWithValue("@Documentacion", myPedido.Documentacion)
                    myCommand.Parameters.AddWithValue("@Aprobo", myPedido.IdAprobo)
                    myCommand.Parameters.AddWithValue("@IdMoneda", myPedido.IdMoneda)
                    myCommand.Parameters.AddWithValue("@FechaAprobacion", iisValidSqlDate(myPedido.FechaAprobacion, DBNull.Value))
                    myCommand.Parameters.AddWithValue("@Importante", myPedido.Importante)
                    myCommand.Parameters.AddWithValue("@TipoCompra", myPedido.TipoCompra)
                    myCommand.Parameters.AddWithValue("@Cumplido", myPedido.Cumplido)
                    myCommand.Parameters.AddWithValue("@DetalleCondicionCompra", myPedido.DetalleCondicionCompra)
                    myCommand.Parameters.AddWithValue("@IdAutorizoCumplido", myPedido.IdAutorizoCumplido)
                    myCommand.Parameters.AddWithValue("@IdDioPorCumplido", myPedido.IdDioPorCumplido)
                    myCommand.Parameters.AddWithValue("@FechaDadoPorCumplido", iisValidSqlDate(myPedido.FechaDadoPorCumplido, DBNull.Value))
                    myCommand.Parameters.AddWithValue("@ObservacionesCumplido", myPedido.ObservacionesCumplido)
                    myCommand.Parameters.AddWithValue("@SubNumero", myPedido.SubNumero)
                    myCommand.Parameters.AddWithValue("@UsuarioAnulacion", myPedido.UsuarioAnulacion)
                    myCommand.Parameters.AddWithValue("@FechaAnulacion", iisValidSqlDate(myPedido.FechaAnulacion, DBNull.Value))
                    myCommand.Parameters.AddWithValue("@MotivoAnulacion", myPedido.MotivoAnulacion)
                    myCommand.Parameters.AddWithValue("@ImprimeImportante", myPedido.ImprimeImportante)
                    myCommand.Parameters.AddWithValue("@ImprimePlazoEntrega", myPedido.ImprimePlazoEntrega)
                    myCommand.Parameters.AddWithValue("@ImprimeLugarEntrega", myPedido.ImprimeLugarEntrega)
                    myCommand.Parameters.AddWithValue("@ImprimeFormaPago", myPedido.ImprimeFormaPago)
                    myCommand.Parameters.AddWithValue("@ImprimeImputaciones", myPedido.ImprimeImputaciones)
                    myCommand.Parameters.AddWithValue("@ImprimeInspecciones", myPedido.ImprimeInspecciones)
                    myCommand.Parameters.AddWithValue("@ImprimeGarantia", myPedido.ImprimeGarantia)
                    myCommand.Parameters.AddWithValue("@ImprimeDocumentacion", myPedido.ImprimeDocumentacion)
                    myCommand.Parameters.AddWithValue("@CotizacionDolar", myPedido.CotizacionDolar)
                    myCommand.Parameters.AddWithValue("@CotizacionMoneda", myPedido.CotizacionMoneda)
                    myCommand.Parameters.AddWithValue("@PedidoExterior", myPedido.PedidoExterior)
                    myCommand.Parameters.AddWithValue("@IdCondicionCompra", myPedido.IdCondicionCompra)
                    myCommand.Parameters.AddWithValue("@IdPedidoOriginal", myPedido.IdPedidoOriginal)
                    myCommand.Parameters.AddWithValue("@IdOrigenTransmision", myPedido.IdOrigenTransmision)
                    myCommand.Parameters.AddWithValue("@FechaImportacionTransmision", iisValidSqlDate(myPedido.FechaImportacionTransmision, DBNull.Value))
                    myCommand.Parameters.AddWithValue("@Subcontrato", myPedido.Subcontrato)
                    myCommand.Parameters.AddWithValue("@IdPedidoAbierto", myPedido.IdPedidoAbierto)
                    myCommand.Parameters.AddWithValue("@NumeroLicitacion", myPedido.NumeroLicitacion)
                    myCommand.Parameters.AddWithValue("@Transmitir_a_SAT", myPedido.Transmitir_a_SAT)
                    myCommand.Parameters.AddWithValue("@NumeracionAutomatica", myPedido.NumeracionAutomatica)
                    myCommand.Parameters.AddWithValue("@Impresa", myPedido.Impresa)
                    myCommand.Parameters.AddWithValue("@EmbarcadoA", myPedido.EmbarcadoA)
                    myCommand.Parameters.AddWithValue("@FacturarA", myPedido.FacturarA)
                    myCommand.Parameters.AddWithValue("@ProveedorExt", myPedido.ProveedorExt)
                    myCommand.Parameters.AddWithValue("@ImpuestosInternos", myPedido.ImpuestosInternos)
                    myCommand.Parameters.AddWithValue("@FechaSalida", iisValidSqlDate(myPedido.FechaSalida, DBNull.Value))
                    myCommand.Parameters.AddWithValue("@CodigoControl", myPedido.CodigoControl)
                    myCommand.Parameters.AddWithValue("@CircuitoFirmasCompleto", myPedido.CircuitoFirmasCompleto)

                    NETtoSQL(myCommand, "@TotalIva2")
                    NETtoSQL(myCommand, "@PorcentajeIva2")
                    NETtoSQL(myCommand, "@Consorcial")

                    NETtoSQL(myCommand, "@OtrosConceptos1")
                    NETtoSQL(myCommand, "@OtrosConceptos2")
                    NETtoSQL(myCommand, "@OtrosConceptos3")
                    NETtoSQL(myCommand, "@OtrosConceptos4")
                    NETtoSQL(myCommand, "@OtrosConceptos5")
                    NETtoSQL(myCommand, "@IdClausula")
                    NETtoSQL(myCommand, "@IncluirObservacionesRM")
                    NETtoSQL(myCommand, "@NumeroSubcontrato")
                    NETtoSQL(myCommand, "@IdPuntoVenta")
                    NETtoSQL(myCommand, "@PuntoVenta")

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


                    NETtoSQL(myCommand, "@PRESTOPedido")
                    NETtoSQL(myCommand, "@PRESTOFechaProceso")
                    NETtoSQL(myCommand, "@EnviarEmail")

                    NETtoSQL(myCommand, "@IdMonedaOriginal")


                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    For Each myPedidoItem As PedidoItem In myPedido.Detalles
                        myPedidoItem.IdPedido = result
                        PedidoItemDB.Save(SC, myPedidoItem)
                    Next

                End With

                GeneralDB.EjecutarSP(myConnection, Transaccion, "Pedidos_ActualizarEstadoPorIdPedido", result)



                Transaccion.Commit()
                myConnection.Close()
            Catch e As Exception
                DebugGetStoreProcedureParameters(myCommand)

                Transaccion.Rollback()
                ErrHandler.WriteAndRaiseError(e)
                'Return -1 'qu� conviene usar? disparar errores o devolver -1?
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result
        End Function





  





        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wPedidos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdPedido", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Pedido
            Dim myPedido As Pedido = New Pedido
            myPedido.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdPedido"))
            myPedido.Numero = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroPedido"))
            myPedido.Fecha = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaPedido"))
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdProveedor")) Then
                myPedido.IdProveedor = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdProveedor"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Proveedor")) Then
                myPedido.Proveedor = myDataRecord.GetString(myDataRecord.GetOrdinal("Proveedor"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("LugarEntrega")) Then
                myPedido.LugarEntrega = myDataRecord.GetString(myDataRecord.GetOrdinal("LugarEntrega"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FormaPago")) Then
                myPedido.FormaPago = myDataRecord.GetString(myDataRecord.GetOrdinal("FormaPago"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Observaciones")) Then
                myPedido.Observaciones = myDataRecord.GetString(myDataRecord.GetOrdinal("Observaciones"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Bonificacion")) Then
                myPedido.Bonificacion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Bonificacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("TotalIva1")) Then
                myPedido.TotalIva1 = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("TotalIva1"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("TotalPedido")) Then
                myPedido.TotalPedido = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("TotalPedido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PorcentajeIva1")) Then
                myPedido.PorcentajeIva1 = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("PorcentajeIva1"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdComprador")) Then
                myPedido.IdComprador = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdComprador"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Comprador")) Then
                myPedido.Comprador = myDataRecord.GetString(myDataRecord.GetOrdinal("Comprador"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PorcentajeBonificacion")) Then
                myPedido.PorcentajeBonificacion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("PorcentajeBonificacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NumeroComparativa")) Then
                myPedido.NumeroComparativa = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NumeroComparativa"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Contacto")) Then
                myPedido.Contacto = myDataRecord.GetString(myDataRecord.GetOrdinal("Contacto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PlazoEntrega")) Then
                myPedido.PlazoEntrega = myDataRecord.GetString(myDataRecord.GetOrdinal("PlazoEntrega"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Garantia")) Then
                myPedido.Garantia = myDataRecord.GetString(myDataRecord.GetOrdinal("Garantia"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Documentacion")) Then
                myPedido.Documentacion = myDataRecord.GetString(myDataRecord.GetOrdinal("Documentacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Aprobo")) Then
                myPedido.IdAprobo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Aprobo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Libero")) Then
                myPedido.Aprobo = myDataRecord.GetString(myDataRecord.GetOrdinal("Libero"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdMoneda")) Then
                myPedido.IdMoneda = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdMoneda"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Moneda")) Then
                myPedido.Moneda = myDataRecord.GetString(myDataRecord.GetOrdinal("Moneda"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAprobacion")) Then
                myPedido.FechaAprobacion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAprobacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Importante")) Then
                myPedido.Importante = myDataRecord.GetString(myDataRecord.GetOrdinal("Importante"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("TipoCompra")) Then
                myPedido.TipoCompra = myDataRecord.GetInt32(myDataRecord.GetOrdinal("TipoCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cumplido")) Then
                myPedido.Cumplido = myDataRecord.GetString(myDataRecord.GetOrdinal("Cumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("DetalleCondicionCompra")) Then
                myPedido.DetalleCondicionCompra = myDataRecord.GetString(myDataRecord.GetOrdinal("DetalleCondicionCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdAutorizoCumplido")) Then
                myPedido.IdAutorizoCumplido = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdAutorizoCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdDioPorCumplido")) Then
                myPedido.IdDioPorCumplido = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDioPorCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaDadoPorCumplido")) Then
                myPedido.FechaDadoPorCumplido = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaDadoPorCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ObservacionesCumplido")) Then
                myPedido.ObservacionesCumplido = myDataRecord.GetString(myDataRecord.GetOrdinal("ObservacionesCumplido"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SubNumero")) Then
                myPedido.SubNumero = myDataRecord.GetInt32(myDataRecord.GetOrdinal("SubNumero"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("UsuarioAnulacion")) Then
                myPedido.UsuarioAnulacion = myDataRecord.GetString(myDataRecord.GetOrdinal("UsuarioAnulacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAnulacion")) Then
                myPedido.FechaAnulacion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAnulacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("MotivoAnulacion")) Then
                myPedido.MotivoAnulacion = myDataRecord.GetString(myDataRecord.GetOrdinal("MotivoAnulacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImprimeImportante")) Then
                myPedido.ImprimeImportante = myDataRecord.GetString(myDataRecord.GetOrdinal("ImprimeImportante"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImprimePlazoEntrega")) Then
                myPedido.ImprimePlazoEntrega = myDataRecord.GetString(myDataRecord.GetOrdinal("ImprimePlazoEntrega"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImprimeLugarEntrega")) Then
                myPedido.ImprimeLugarEntrega = myDataRecord.GetString(myDataRecord.GetOrdinal("ImprimeLugarEntrega"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImprimeFormaPago")) Then
                myPedido.ImprimeFormaPago = myDataRecord.GetString(myDataRecord.GetOrdinal("ImprimeFormaPago"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImprimeImputaciones")) Then
                myPedido.ImprimeImputaciones = myDataRecord.GetString(myDataRecord.GetOrdinal("ImprimeImputaciones"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImprimeInspecciones")) Then
                myPedido.ImprimeInspecciones = myDataRecord.GetString(myDataRecord.GetOrdinal("ImprimeInspecciones"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImprimeGarantia")) Then
                myPedido.ImprimeGarantia = myDataRecord.GetString(myDataRecord.GetOrdinal("ImprimeGarantia"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImprimeDocumentacion")) Then
                myPedido.ImprimeDocumentacion = myDataRecord.GetString(myDataRecord.GetOrdinal("ImprimeDocumentacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CotizacionDolar")) Then
                myPedido.CotizacionDolar = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("CotizacionDolar"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CotizacionMoneda")) Then
                myPedido.CotizacionMoneda = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("CotizacionMoneda"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PedidoExterior")) Then
                myPedido.PedidoExterior = myDataRecord.GetString(myDataRecord.GetOrdinal("PedidoExterior"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdCondicionCompra")) Then
                myPedido.IdCondicionCompra = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdCondicionCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CondicionCompra")) Then
                myPedido.CondicionCompra = myDataRecord.GetString(myDataRecord.GetOrdinal("CondicionCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdPedidoOriginal")) Then
                myPedido.IdPedidoOriginal = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdPedidoOriginal"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdOrigenTransmision")) Then
                myPedido.IdOrigenTransmision = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdOrigenTransmision"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaImportacionTransmision")) Then
                myPedido.FechaImportacionTransmision = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaImportacionTransmision"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Subcontrato")) Then
                myPedido.Subcontrato = myDataRecord.GetString(myDataRecord.GetOrdinal("Subcontrato"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdPedidoAbierto")) Then
                myPedido.IdPedidoAbierto = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdPedidoAbierto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NumeroLicitacion")) Then
                myPedido.NumeroLicitacion = myDataRecord.GetString(myDataRecord.GetOrdinal("NumeroLicitacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Transmitir_a_SAT")) Then
                myPedido.Transmitir_a_SAT = myDataRecord.GetString(myDataRecord.GetOrdinal("Transmitir_a_SAT"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NumeracionAutomatica")) Then
                myPedido.NumeracionAutomatica = myDataRecord.GetString(myDataRecord.GetOrdinal("NumeracionAutomatica"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Impresa")) Then
                myPedido.Impresa = myDataRecord.GetString(myDataRecord.GetOrdinal("Impresa"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("EmbarcadoA")) Then
                myPedido.EmbarcadoA = myDataRecord.GetString(myDataRecord.GetOrdinal("EmbarcadoA"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FacturarA")) Then
                myPedido.FacturarA = myDataRecord.GetString(myDataRecord.GetOrdinal("FacturarA"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ProveedorExt")) Then
                myPedido.ProveedorExt = myDataRecord.GetString(myDataRecord.GetOrdinal("ProveedorExt"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImpuestosInternos")) Then
                myPedido.ImpuestosInternos = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("ImpuestosInternos"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaSalida")) Then
                myPedido.FechaSalida = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaSalida"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CodigoControl")) Then
                myPedido.CodigoControl = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("CodigoControl"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CircuitoFirmasCompleto")) Then
                myPedido.CircuitoFirmasCompleto = myDataRecord.GetString(myDataRecord.GetOrdinal("CircuitoFirmasCompleto"))
            End If

            'Nuevos
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("RMs")) Then
                myPedido.RMs = myDataRecord.GetString(myDataRecord.GetOrdinal("RMs"))
            End If
            'If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Presupuestos")) Then
            '	myPedido.Presupuestos = myDataRecord.GetString(myDataRecord.GetOrdinal("Presupuestos"))
            'End If
            'If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Comparativa")) Then
            '	myPedido.Comparativa = myDataRecord.GetString(myDataRecord.GetOrdinal("Comparativa"))
            'End If
            Return myPedido
        End Function
    End Class
End Namespace