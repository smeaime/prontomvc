Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class ReciboDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Recibo
            Dim myRecibo As Recibo = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("Recibos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRecibo", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myRecibo = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myRecibo
        End Function

        Public Shared Function GetList(ByVal SC As String) As ReciboList
            Dim tempList As ReciboList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("Recibos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New ReciboList
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

        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String) As ReciboList

            Dim tempList As ReciboList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wRecibos_T_ByEmployee", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdSolicito", IdSolicito)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New ReciboList
                        While myReader.Read
                            'tempList.Add(FillDataRecord(myReader))
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
            Dim tempList As ReciboList = Nothing
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
                Dim myCommand As SqlCommand = New SqlCommand("wRecibos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRecibo", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myRecibo As Recibo) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand
                With myrecibo


                    If .Id = -1 Then

                        myCommand = New SqlCommand("Recibos_A", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdRecibo", -1)
                        param.Direction = ParameterDirection.Output

                    Else

                        myCommand = New SqlCommand("Recibos_M", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        myCommand.Parameters.AddWithValue("@IdRecibo", .Id)
                    End If


                    'NETtoSQL(myCommand, "@IdCliente", .IdCliente)


                    NETtoSQL(myCommand, "@NumeroRecibo", .NumeroRecibo)
                    NETtoSQL(myCommand, "@FechaRecibo", .FechaRecibo)
                    NETtoSQL(myCommand, "@IdCliente", .IdCliente)
                    NETtoSQL(myCommand, "@Efectivo", .Efectivo)
                    NETtoSQL(myCommand, "@Descuentos", .Descuentos)
                    NETtoSQL(myCommand, "@Valores", .Valores)
                    NETtoSQL(myCommand, "@Documentos", .Documentos)
                    NETtoSQL(myCommand, "@Otros1", .Otros1)
                    NETtoSQL(myCommand, "@IdCuenta1", .IdCuenta1)
                    NETtoSQL(myCommand, "@Otros2", .Otros2)
                    NETtoSQL(myCommand, "@IdCuenta2", .IdCuenta2)
                    NETtoSQL(myCommand, "@Otros3", .Otros3)
                    NETtoSQL(myCommand, "@IdCuenta3", .IdCuenta3)
                    NETtoSQL(myCommand, "@Deudores", .Deudores)
                    NETtoSQL(myCommand, "@RetencionIVA", .RetencionIVA)
                    NETtoSQL(myCommand, "@RetencionGanancias", .RetencionGanancias)
                    NETtoSQL(myCommand, "@RetencionIBrutos", .RetencionIBrutos)
                    NETtoSQL(myCommand, "@GastosGenerales", .GastosGenerales)
                    NETtoSQL(myCommand, "@Cotizacion", .Cotizacion)
                    NETtoSQL(myCommand, "@Observaciones", .Observaciones)
                    NETtoSQL(myCommand, "@IdMoneda", .IdMoneda)
                    NETtoSQL(myCommand, "@Dolarizada", .Dolarizada)
                    NETtoSQL(myCommand, "@IdObra1", .IdObra1)
                    NETtoSQL(myCommand, "@IdCuentaGasto1", .IdCuentaGasto1)
                    NETtoSQL(myCommand, "@IdObra2", .IdObra2)
                    NETtoSQL(myCommand, "@IdCuentaGasto2", .IdCuentaGasto2)
                    NETtoSQL(myCommand, "@IdObra3", .IdObra3)
                    NETtoSQL(myCommand, "@IdCuentaGasto3", .IdCuentaGasto3)
                    NETtoSQL(myCommand, "@IdObra4", .IdObra4)
                    NETtoSQL(myCommand, "@IdCuentaGasto4", .IdCuentaGasto4)
                    NETtoSQL(myCommand, "@IdCuenta4", .IdCuenta4)
                    NETtoSQL(myCommand, "@Otros4", .Otros4)
                    NETtoSQL(myCommand, "@IdObra5", .IdObra5)
                    NETtoSQL(myCommand, "@IdCuentaGasto5", .IdCuentaGasto5)
                    NETtoSQL(myCommand, "@IdCuenta5", .IdCuenta5)
                    NETtoSQL(myCommand, "@Otros5", .Otros5)
                    NETtoSQL(myCommand, "@Tipo", .Tipo)
                    NETtoSQL(myCommand, "@IdCuenta", .IdCuenta)
                    NETtoSQL(myCommand, "@AsientoManual", .AsientoManual)
                    NETtoSQL(myCommand, "@IdObra", .IdObra)
                    NETtoSQL(myCommand, "@IdCuentaGasto", .IdCuentaGasto)
                    NETtoSQL(myCommand, "@NumeroCertificadoRetencionGanancias", .NumeroCertificadoRetencionGanancias)
                    NETtoSQL(myCommand, "@NumeroCertificadoRetencionIVA", .NumeroCertificadoRetencionIVA)
                    NETtoSQL(myCommand, "@NumeroCertificadoSUSS", .NumeroCertificadoSUSS)
                    NETtoSQL(myCommand, "@IdTipoRetencionGanancia", .IdTipoRetencionGanancia)
                    NETtoSQL(myCommand, "@CotizacionMoneda", .CotizacionMoneda)
                    NETtoSQL(myCommand, "@NumeroCertificadoRetencionIngresosBrutos", .NumeroCertificadoRetencionIngresosBrutos)
                    NETtoSQL(myCommand, "@Anulado", .Anulado)
                    NETtoSQL(myCommand, "@PuntoVenta", .PuntoVenta)
                    NETtoSQL(myCommand, "@IdPuntoVenta", .IdPuntoVenta)
                    NETtoSQL(myCommand, "@IdUsuarioIngreso", .IdUsuarioIngreso)
                    NETtoSQL(myCommand, "@FechaIngreso", .FechaIngreso)
                    NETtoSQL(myCommand, "@IdUsuarioModifico", .IdUsuarioModifico)
                    NETtoSQL(myCommand, "@FechaModifico", .FechaModifico)
                    NETtoSQL(myCommand, "@IdCobrador", .IdCobrador)
                    NETtoSQL(myCommand, "@IdVendedor", .IdVendedor)
                    NETtoSQL(myCommand, "@Lote", .Lote)
                    NETtoSQL(myCommand, "@Sublote", .Sublote)
                    NETtoSQL(myCommand, "@IdCodigoIvaOpcional", .IdCodigoIvaOpcional)
                    NETtoSQL(myCommand, "@TipoOperacionOtros", .TipoOperacionOtros)
                    NETtoSQL(myCommand, "@FechaLote", .FechaLote)
                    NETtoSQL(myCommand, "@CuitOpcional", .CuitOpcional)
                    NETtoSQL(myCommand, "@IdComprobanteProveedorReintegro", .IdComprobanteProveedorReintegro)
                    NETtoSQL(myCommand, "@IdObra6", .IdObra6)
                    NETtoSQL(myCommand, "@IdCuentaGasto6", .IdCuentaGasto6)
                    NETtoSQL(myCommand, "@IdCuenta6", .IdCuenta6)
                    NETtoSQL(myCommand, "@Otros6", .Otros6)
                    NETtoSQL(myCommand, "@IdObra7", .IdObra7)
                    NETtoSQL(myCommand, "@IdCuentaGasto7", .IdCuentaGasto7)
                    NETtoSQL(myCommand, "@IdCuenta7", .IdCuenta7)
                    NETtoSQL(myCommand, "@Otros7", .Otros7)
                    NETtoSQL(myCommand, "@IdObra8", .IdObra8)
                    NETtoSQL(myCommand, "@IdCuentaGasto8", .IdCuentaGasto8)
                    NETtoSQL(myCommand, "@IdCuenta8", .IdCuenta8)
                    NETtoSQL(myCommand, "@Otros8", .Otros8)
                    NETtoSQL(myCommand, "@IdObra9", .IdObra9)
                    NETtoSQL(myCommand, "@IdCuentaGasto9", .IdCuentaGasto9)
                    NETtoSQL(myCommand, "@IdCuenta9", .IdCuenta9)
                    NETtoSQL(myCommand, "@Otros9", .Otros9)
                    NETtoSQL(myCommand, "@IdObra10", .IdObra10)
                    NETtoSQL(myCommand, "@IdCuentaGasto10", .IdCuentaGasto10)
                    NETtoSQL(myCommand, "@IdCuenta10", .IdCuenta10)
                    NETtoSQL(myCommand, "@Otros10", .Otros10)
                    NETtoSQL(myCommand, "@NumeroComprobante1", .NumeroComprobante1)
                    NETtoSQL(myCommand, "@NumeroComprobante2", .NumeroComprobante2)
                    NETtoSQL(myCommand, "@NumeroComprobante3", .NumeroComprobante3)
                    NETtoSQL(myCommand, "@NumeroComprobante4", .NumeroComprobante4)
                    NETtoSQL(myCommand, "@NumeroComprobante5", .NumeroComprobante5)
                    NETtoSQL(myCommand, "@NumeroComprobante6", .NumeroComprobante6)
                    NETtoSQL(myCommand, "@NumeroComprobante7", .NumeroComprobante7)
                    NETtoSQL(myCommand, "@NumeroComprobante8", .NumeroComprobante8)
                    NETtoSQL(myCommand, "@NumeroComprobante9", .NumeroComprobante9)
                    NETtoSQL(myCommand, "@NumeroComprobante10", .NumeroComprobante10)
                    NETtoSQL(myCommand, "@EnviarEmail", .EnviarEmail)
                    NETtoSQL(myCommand, "@IdOrigenTransmision", .IdOrigenTransmision)
                    NETtoSQL(myCommand, "@IdReciboOriginal", .IdReciboOriginal)
                    NETtoSQL(myCommand, "@FechaImportacionTransmision", .FechaImportacionTransmision)
                    NETtoSQL(myCommand, "@CuitClienteTransmision", .CuitClienteTransmision)
                    NETtoSQL(myCommand, "@IdProvinciaDestino", .IdProvinciaDestino)
                    NETtoSQL(myCommand, "@ServicioCobro", .ServicioCobro)
                    NETtoSQL(myCommand, "@LoteServicioCobro", .LoteServicioCobro)





                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    For Each myReciboItem As ReciboItem In myRecibo.DetallesImputaciones
                        myReciboItem.IdRecibo = result




                        If myReciboItem.Eliminado Then
                            'EntidadManager.GetStoreProcedure(SC, "DetRecibos_E", .Id)
                        Else
                            Dim IdAntesDeGrabar = myReciboItem.Id
                            myReciboItem.Id = reciboItemDB.Save(SC, myReciboItem)


                            'Como un item nuevo consiguió un nuevo id al grabarse, 
                            'lo tengo que refrescar en el resto de las colecciones
                            'de imputacion (en el prontovb6, se usaba -100,-101,etc)
                            '-OK, eso si los items del resto de las colecciones (Valores,Cuentas)
                            'estuviesen imputadas contra la de Imputaciones. Pero, de donde demonios saqué
                            'que esto es así?

                            'For Each o As ReciboAnticiposAlPersonalItem In .DetallesAnticiposAlPersonal
                            '    If o. = IdAntesDeGrabar Then
                            '        o. = myReciboItem.Id
                            '    End If
                            'Next

                            'For Each o As ReciboCuentasItem In .DetallesCuentas
                            '    If o. = IdAntesDeGrabar Then
                            '        o. = myReciboItem.Id
                            '    End If
                            'Next
                        End If
                    Next


                    ''//////////////////////////////////////////////////////////////////////////////////////
                    'Colecciones adicionales
                    ''//////////////////////////////////////////////////////////////////////////////////////

                    For Each myReciboAnticiposAlPersonalItem As ReciboAnticiposAlPersonalItem In myrecibo.DetallesAnticiposAlPersonal
                        myReciboAnticiposAlPersonalItem.IdRecibo = result
                        ReciboAnticiposAlPersonalItemDB.Save(SC, myReciboAnticiposAlPersonalItem)
                    Next
                    For Each myReciboCuentasItem As ReciboCuentasItem In myrecibo.DetallesCuentas
                        myReciboCuentasItem.IdRecibo = result
                        ReciboCuentasItemDB.Save(SC, myReciboCuentasItem)
                    Next
                    For Each myReciboValoresItem As ReciboValoresItem In myrecibo.DetallesValores
                        myReciboValoresItem.IdRecibo = result
                        ReciboValoresItemDB.Save(SC, myReciboValoresItem)
                    Next

                    For Each myReciboRubrosContablesItem As ReciboRubrosContablesItem In myrecibo.DetallesRubrosContables
                        myReciboRubrosContablesItem.IdRecibo = result
                        reciborubroscontablesItemDB.Save(SC, myReciboRubrosContablesItem)
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
                Dim myCommand As SqlCommand = New SqlCommand("wRecibos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRecibo", id)
                myConnection.Open()

                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Public Shared Function Anular(ByVal SC As String, ByVal IdRecibo As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wRecibos_N", myConnection)
                myCommand.Transaction = Transaccion
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRecibo", Idrecibo)
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

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Recibo
            Dim myRecibo As Recibo = New Recibo
            With myRecibo

                SQLtoNET(myDataRecord, "@IdRecibo", .Id)
                SQLtoNET(myDataRecord, "@NumeroRecibo", .NumeroRecibo)
                SQLtoNET(myDataRecord, "@FechaRecibo", .FechaRecibo)
                SQLtoNET(myDataRecord, "@IdCliente", .IdCliente)
                SQLtoNET(myDataRecord, "@Efectivo", .Efectivo)
                SQLtoNET(myDataRecord, "@Descuentos", .Descuentos)
                SQLtoNET(myDataRecord, "@Valores", .Valores)
                SQLtoNET(myDataRecord, "@Documentos", .Documentos)
                SQLtoNET(myDataRecord, "@Otros1", .Otros1)
                SQLtoNET(myDataRecord, "@IdCuenta1", .IdCuenta1)
                SQLtoNET(myDataRecord, "@Otros2", .Otros2)
                SQLtoNET(myDataRecord, "@IdCuenta2", .IdCuenta2)
                SQLtoNET(myDataRecord, "@Otros3", .Otros3)
                SQLtoNET(myDataRecord, "@IdCuenta3", .IdCuenta3)
                SQLtoNET(myDataRecord, "@Deudores", .Deudores)
                SQLtoNET(myDataRecord, "@RetencionIVA", .RetencionIVA)
                SQLtoNET(myDataRecord, "@RetencionGanancias", .RetencionGanancias)
                SQLtoNET(myDataRecord, "@RetencionIBrutos", .RetencionIBrutos)
                SQLtoNET(myDataRecord, "@GastosGenerales", .GastosGenerales)
                SQLtoNET(myDataRecord, "@Cotizacion", .Cotizacion)
                SQLtoNET(myDataRecord, "@Observaciones", .Observaciones)
                SQLtoNET(myDataRecord, "@IdMoneda", .IdMoneda)
                SQLtoNET(myDataRecord, "@Dolarizada", .Dolarizada)
                SQLtoNET(myDataRecord, "@IdObra1", .IdObra1)
                SQLtoNET(myDataRecord, "@IdCuentaGasto1", .IdCuentaGasto1)
                SQLtoNET(myDataRecord, "@IdObra2", .IdObra2)
                SQLtoNET(myDataRecord, "@IdCuentaGasto2", .IdCuentaGasto2)
                SQLtoNET(myDataRecord, "@IdObra3", .IdObra3)
                SQLtoNET(myDataRecord, "@IdCuentaGasto3", .IdCuentaGasto3)
                SQLtoNET(myDataRecord, "@IdObra4", .IdObra4)
                SQLtoNET(myDataRecord, "@IdCuentaGasto4", .IdCuentaGasto4)
                SQLtoNET(myDataRecord, "@IdCuenta4", .IdCuenta4)
                SQLtoNET(myDataRecord, "@Otros4", .Otros4)
                SQLtoNET(myDataRecord, "@IdObra5", .IdObra5)
                SQLtoNET(myDataRecord, "@IdCuentaGasto5", .IdCuentaGasto5)
                SQLtoNET(myDataRecord, "@IdCuenta5", .IdCuenta5)
                SQLtoNET(myDataRecord, "@Otros5", .Otros5)
                SQLtoNET(myDataRecord, "@Tipo", .Tipo)
                SQLtoNET(myDataRecord, "@IdCuenta", .IdCuenta)
                SQLtoNET(myDataRecord, "@AsientoManual", .AsientoManual)
                SQLtoNET(myDataRecord, "@IdObra", .IdObra)
                SQLtoNET(myDataRecord, "@IdCuentaGasto", .IdCuentaGasto)
                SQLtoNET(myDataRecord, "@NumeroCertificadoRetencionGanancias", .NumeroCertificadoRetencionGanancias)
                SQLtoNET(myDataRecord, "@NumeroCertificadoRetencionIVA", .NumeroCertificadoRetencionIVA)
                SQLtoNET(myDataRecord, "@NumeroCertificadoSUSS", .NumeroCertificadoSUSS)
                SQLtoNET(myDataRecord, "@IdTipoRetencionGanancia", .IdTipoRetencionGanancia)
                SQLtoNET(myDataRecord, "@CotizacionMoneda", .CotizacionMoneda)
                SQLtoNET(myDataRecord, "@NumeroCertificadoRetencionIngresosBrutos", .NumeroCertificadoRetencionIngresosBrutos)
                SQLtoNET(myDataRecord, "@Anulado", .Anulado)
                SQLtoNET(myDataRecord, "@PuntoVenta", .PuntoVenta)
                SQLtoNET(myDataRecord, "@IdPuntoVenta", .IdPuntoVenta)
                SQLtoNET(myDataRecord, "@IdUsuarioIngreso", .IdUsuarioIngreso)
                SQLtoNET(myDataRecord, "@FechaIngreso", .FechaIngreso)
                SQLtoNET(myDataRecord, "@IdUsuarioModifico", .IdUsuarioModifico)
                SQLtoNET(myDataRecord, "@FechaModifico", .FechaModifico)
                SQLtoNET(myDataRecord, "@IdCobrador", .IdCobrador)
                SQLtoNET(myDataRecord, "@IdVendedor", .IdVendedor)
                SQLtoNET(myDataRecord, "@Lote", .Lote)
                SQLtoNET(myDataRecord, "@Sublote", .Sublote)
                SQLtoNET(myDataRecord, "@IdCodigoIvaOpcional", .IdCodigoIvaOpcional)
                SQLtoNET(myDataRecord, "@TipoOperacionOtros", .TipoOperacionOtros)
                SQLtoNET(myDataRecord, "@FechaLote", .FechaLote)
                SQLtoNET(myDataRecord, "@CuitOpcional", .CuitOpcional)
                SQLtoNET(myDataRecord, "@IdComprobanteProveedorReintegro", .IdComprobanteProveedorReintegro)
                SQLtoNET(myDataRecord, "@IdObra6", .IdObra6)
                SQLtoNET(myDataRecord, "@IdCuentaGasto6", .IdCuentaGasto6)
                SQLtoNET(myDataRecord, "@IdCuenta6", .IdCuenta6)
                SQLtoNET(myDataRecord, "@Otros6", .Otros6)
                SQLtoNET(myDataRecord, "@IdObra7", .IdObra7)
                SQLtoNET(myDataRecord, "@IdCuentaGasto7", .IdCuentaGasto7)
                SQLtoNET(myDataRecord, "@IdCuenta7", .IdCuenta7)
                SQLtoNET(myDataRecord, "@Otros7", .Otros7)
                SQLtoNET(myDataRecord, "@IdObra8", .IdObra8)
                SQLtoNET(myDataRecord, "@IdCuentaGasto8", .IdCuentaGasto8)
                SQLtoNET(myDataRecord, "@IdCuenta8", .IdCuenta8)
                SQLtoNET(myDataRecord, "@Otros8", .Otros8)
                SQLtoNET(myDataRecord, "@IdObra9", .IdObra9)
                SQLtoNET(myDataRecord, "@IdCuentaGasto9", .IdCuentaGasto9)
                SQLtoNET(myDataRecord, "@IdCuenta9", .IdCuenta9)
                SQLtoNET(myDataRecord, "@Otros9", .Otros9)
                SQLtoNET(myDataRecord, "@IdObra10", .IdObra10)
                SQLtoNET(myDataRecord, "@IdCuentaGasto10", .IdCuentaGasto10)
                SQLtoNET(myDataRecord, "@IdCuenta10", .IdCuenta10)
                SQLtoNET(myDataRecord, "@Otros10", .Otros10)
                SQLtoNET(myDataRecord, "@NumeroComprobante1", .NumeroComprobante1)
                SQLtoNET(myDataRecord, "@NumeroComprobante2", .NumeroComprobante2)
                SQLtoNET(myDataRecord, "@NumeroComprobante3", .NumeroComprobante3)
                SQLtoNET(myDataRecord, "@NumeroComprobante4", .NumeroComprobante4)
                SQLtoNET(myDataRecord, "@NumeroComprobante5", .NumeroComprobante5)
                SQLtoNET(myDataRecord, "@NumeroComprobante6", .NumeroComprobante6)
                SQLtoNET(myDataRecord, "@NumeroComprobante7", .NumeroComprobante7)
                SQLtoNET(myDataRecord, "@NumeroComprobante8", .NumeroComprobante8)
                SQLtoNET(myDataRecord, "@NumeroComprobante9", .NumeroComprobante9)
                SQLtoNET(myDataRecord, "@NumeroComprobante10", .NumeroComprobante10)
                SQLtoNET(myDataRecord, "@EnviarEmail", .EnviarEmail)
                SQLtoNET(myDataRecord, "@IdOrigenTransmision", .IdOrigenTransmision)
                SQLtoNET(myDataRecord, "@IdReciboOriginal", .IdReciboOriginal)
                SQLtoNET(myDataRecord, "@FechaImportacionTransmision", .FechaImportacionTransmision)
                SQLtoNET(myDataRecord, "@CuitClienteTransmision", .CuitClienteTransmision)
                SQLtoNET(myDataRecord, "@IdProvinciaDestino", .IdProvinciaDestino)
                SQLtoNET(myDataRecord, "@ServicioCobro", .ServicioCobro)
                SQLtoNET(myDataRecord, "@LoteServicioCobro", .LoteServicioCobro)



                Return myRecibo
            End With
        End Function
    End Class
End Namespace