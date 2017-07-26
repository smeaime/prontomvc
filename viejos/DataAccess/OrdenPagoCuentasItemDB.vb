Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class OrdenPagoCuentasItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As OrdenPagoCuentasItem
            Dim myOrdenPagoItem As OrdenPagoCuentasItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.DetOrdenesPagoCuentas_T.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleOrdenPago", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myOrdenPagoItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myOrdenPagoItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdOrdenPago As Integer) As OrdenPagoCuentasItemList
            Dim tempList As OrdenPagoCuentasItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                'DetNotasDebito_TX_PorIdCabecera    trae los nombres como en la base
                'DetNotasDebito_TXDeb               formatea para la grilla, con las descripciones de los ids (pero sin algunos ids)

                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.DetOrdenesPagoCuentas_TX_PorIdOrdenPago.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdOrdenPago", IdOrdenPago)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    tempList = New OrdenPagoCuentasItemList
                    If myReader.HasRows Then
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

        Public Shared Function Save(ByVal SC As String, ByVal myOrdenPagoItem As OrdenPagoCuentasItem) As Integer
            Dim result As Integer = 0

            With myOrdenPagoItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand(enumSPs.DetOrdenesPagoCuentas_A.ToString, myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleOrdenPagoCuentas", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand(enumSPs.DetOrdenesPagoCuentas_M.ToString, myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleOrdenPagoCuentas", .Id)
                        End If



                        NETtoSQL(myCommand, "@IdOrdenPago", .IdOrdenPago)
                        NETtoSQL(myCommand, "@IdCuenta", .IdCuenta)
                        NETtoSQL(myCommand, "@CodigoCuenta", .CodigoCuenta)
                        NETtoSQL(myCommand, "@Debe", .Debe)
                        NETtoSQL(myCommand, "@Haber", .Haber)
                        NETtoSQL(myCommand, "@IdObra", .IdObra)
                        NETtoSQL(myCommand, "@IdCuentaGasto", .IdCuentaGasto)
                        NETtoSQL(myCommand, "@IdCuentaBancaria", .IdCuentaBancaria)
                        NETtoSQL(myCommand, "@IdCaja", .IdCaja)
                        NETtoSQL(myCommand, "@IdMoneda", .IdMoneda)
                        NETtoSQL(myCommand, "@CotizacionMonedaDestino", .CotizacionMonedaDestino)
                        NETtoSQL(myCommand, "@IdTarjetaCredito", .IdTarjetaCredito)




                        'NETtoSQL(myCommand, "@EnviarEmail", .EnviarEmail)
                        'NETtoSQL(myCommand, "@IdOrigenTransmision", .IdOrigenTransmision)
                        'NETtoSQL(myCommand, "@IdOrdenPagoOriginal", .IdOrdenPagoOriginal)
                        'NETtoSQL(myCommand, "@IdDetalleOrdenPagoCuentasOriginal", .IdDetalleOrdenPagoCuentasOriginal)
                        'NETtoSQL(myCommand, "@FechaImportacionTransmision", .FechaImportacionTransmision)




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
                    'If Not myOrdenPagoItem.Nuevo Then Delete(SC, myOrdenPagoItem.Id)
                End If
                Return result
            End With
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetOrdenPagos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleOrdenPago", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As OrdenPagoCuentasItem
            Dim myOrdenPagoItem As OrdenPagoCuentasItem = New OrdenPagoCuentasItem
            With myOrdenPagoItem
                'SQLtoNET(.Id, "IdDetalleOrdenPago", myDataRecord)
                'SQLtoNET(.IdOrdenPago, "IdOrdenPago", myDataRecord)
                'SQLtoNET(.IdConcepto, "IdConcepto", myDataRecord)
                'SQLtoNET(.ImporteTotalItem, "Importe", myDataRecord)
                'SQLtoNET(.Gravado, "Gravado", myDataRecord)
                'SQLtoNET(.IdDiferenciaCambio, "IdDiferenciaCambio", myDataRecord)
                'SQLtoNET(.IvaNoDiscriminado, "IvaNoDiscriminado", myDataRecord)
                'SQLtoNET(.IdCuentaBancaria, "IdCuentaBancaria", myDataRecord)
                'SQLtoNET(.IdCaja, "IdCaja", myDataRecord)

                SQLtoNET(.Id, "IdDetalleOrdenPagoCuentas", myDataRecord)
                SQLtoNET(.IdOrdenPago, "IdOrdenPago", myDataRecord)
                SQLtoNET(.IdCuenta, "IdCuenta", myDataRecord)
                SQLtoNET(.CodigoCuenta, "CodigoCuenta", myDataRecord)
                SQLtoNET(.Debe, "Debe", myDataRecord)
                SQLtoNET(.Haber, "Haber", myDataRecord)
                SQLtoNET(.IdObra, "IdObra", myDataRecord)
                SQLtoNET(.IdCuentaGasto, "IdCuentaGasto", myDataRecord)
                SQLtoNET(.IdCuentaBancaria, "IdCuentaBancaria", myDataRecord)
                SQLtoNET(.IdCaja, "IdCaja", myDataRecord)
                SQLtoNET(.IdMoneda, "IdMoneda", myDataRecord)
                SQLtoNET(.CotizacionMonedaDestino, "CotizacionMonedaDestino", myDataRecord)
                SQLtoNET(myDataRecord, "@IdTarjetaCredito", .IdTarjetaCredito)

                'SQLtoNET(.EnviarEmail, "EnviarEmail", myDataRecord)
                'SQLtoNET(.IdOrigenTransmision, "IdOrigenTransmision", myDataRecord)
                'SQLtoNET(.IdOrdenPagoOriginal, "IdOrdenPagoOriginal", myDataRecord)
                'SQLtoNET(.IdDetalleOrdenPagoCuentasOriginal, "IdDetalleOrdenPagoCuentasOriginal", myDataRecord)
                'SQLtoNET(.FechaImportacionTransmision, "FechaImportacionTransmision", myDataRecord)


                Return myOrdenPagoItem
            End With
        End Function

    End Class
End Namespace