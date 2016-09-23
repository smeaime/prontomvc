Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class AsientoItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As AsientoItem
            Dim myAsientoItem As AsientoItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.DetAsientos_T, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleAsiento", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myAsientoItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myAsientoItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdAsiento As Integer) As AsientoItemList
            Dim tempList As AsientoItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                'DetAsientos_TX_PorIdCabecera    trae los nombres como en la base (como el sp usado en GetItem. GetList usa el mismo FillDataRecord, así que tendrían que tener las mismas columnas....)
                'DetAsientos_TXDeb               formatea para la grilla, con las descripciones de los ids (pero sin algunos ids)

                Dim myCommand As SqlCommand = New SqlCommand("DetAsientos_TX_PorIdAsiento", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdAsiento", IdAsiento)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    tempList = New AsientoItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myAsientoItem As AsientoItem) As Integer
            Dim result As Integer = 0

            With myAsientoItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand(enumSPs.DetAsientos_A.ToString, myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleAsiento", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand(enumSPs.DetAsientos_M.ToString, myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleAsiento", .Id)
                        End If





                        NETtoSQL(.IdAsiento, "IdAsiento", myCommand)
                        NETtoSQL(.IdCuenta, "IdCuenta", myCommand)
                        NETtoSQL(.IdTipoComprobante, "IdTipoComprobante", myCommand)
                        NETtoSQL(.NumeroComprobante, "NumeroComprobante", myCommand)
                        NETtoSQL(.FechaComprobante, "FechaComprobante", myCommand)
                        NETtoSQL(.Libro, "Libro", myCommand)
                        NETtoSQL(.Signo, "Signo", myCommand)
                        NETtoSQL(.TipoImporte, "TipoImporte", myCommand)
                        NETtoSQL(.Cuit, "Cuit", myCommand)
                        NETtoSQL(.Detalle, "Detalle", myCommand)
                        NETtoSQL(.Debe, "Debe", myCommand)
                        NETtoSQL(.Haber, "Haber", myCommand)
                        NETtoSQL(.IdObra, "IdObra", myCommand)
                        NETtoSQL(.IdCuentaGasto, "IdCuentaGasto", myCommand)
                        NETtoSQL(.IdMoneda, "IdMoneda", myCommand)
                        NETtoSQL(.CotizacionMoneda, "CotizacionMoneda", myCommand)
                        NETtoSQL(.IdCuentaBancaria, "IdCuentaBancaria", myCommand)
                        NETtoSQL(.IdCaja, "IdCaja", myCommand)
                        NETtoSQL(.IdMonedaDestino, "IdMonedaDestino", myCommand)
                        NETtoSQL(.CotizacionMonedaDestino, "CotizacionMonedaDestino", myCommand)
                        NETtoSQL(.ImporteEnMonedaDestino, "ImporteEnMonedaDestino", myCommand)
                        NETtoSQL(.PorcentajeIVA, "PorcentajeIVA", myCommand)
                        NETtoSQL(.RegistrarEnAnalitico, "RegistrarEnAnalitico", myCommand)
                        NETtoSQL(.Item, "Item", myCommand)
                        NETtoSQL(.IdValor, "IdValor", myCommand)
                        NETtoSQL(.IdProvinciaDestino, "IdProvinciaDestino", myCommand)


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
                    If Not myAsientoItem.Nuevo Then Delete(SC, myAsientoItem.Id)
                End If
                Return result
            End With
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.DetAsientos_E.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleAsiento", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As AsientoItem
            Dim myAsientoItem As AsientoItem = New AsientoItem
            With myAsientoItem

                SQLtoNET(.Id, "IdDetalleAsiento", myDataRecord)
                SQLtoNET(.IdAsiento, "IdAsiento", myDataRecord)
                SQLtoNET(.IdCuenta, "IdCuenta", myDataRecord)
                SQLtoNET(.IdTipoComprobante, "IdTipoComprobante", myDataRecord)
                SQLtoNET(.NumeroComprobante, "NumeroComprobante", myDataRecord)
                SQLtoNET(.FechaComprobante, "FechaComprobante", myDataRecord)
                SQLtoNET(.Libro, "Libro", myDataRecord)
                SQLtoNET(.Signo, "Signo", myDataRecord)
                SQLtoNET(.TipoImporte, "TipoImporte", myDataRecord)
                SQLtoNET(.Cuit, "Cuit", myDataRecord)
                SQLtoNET(.Detalle, "Detalle", myDataRecord)
                SQLtoNET(.Debe, "Debe", myDataRecord)
                SQLtoNET(.Haber, "Haber", myDataRecord)
                SQLtoNET(.IdObra, "IdObra", myDataRecord)
                SQLtoNET(.IdCuentaGasto, "IdCuentaGasto", myDataRecord)
                SQLtoNET(.IdMoneda, "IdMoneda", myDataRecord)
                SQLtoNET(.CotizacionMoneda, "CotizacionMoneda", myDataRecord)
                SQLtoNET(.IdCuentaBancaria, "IdCuentaBancaria", myDataRecord)
                SQLtoNET(.IdCaja, "IdCaja", myDataRecord)
                SQLtoNET(.IdMonedaDestino, "IdMonedaDestino", myDataRecord)
                SQLtoNET(.CotizacionMonedaDestino, "CotizacionMonedaDestino", myDataRecord)
                SQLtoNET(.ImporteEnMonedaDestino, "ImporteEnMonedaDestino", myDataRecord)
                SQLtoNET(.PorcentajeIVA, "PorcentajeIVA", myDataRecord)
                SQLtoNET(.RegistrarEnAnalitico, "RegistrarEnAnalitico", myDataRecord)
                SQLtoNET(.Item, "Item", myDataRecord)
                SQLtoNET(.IdValor, "IdValor", myDataRecord)
                SQLtoNET(.IdProvinciaDestino, "IdProvinciaDestino", myDataRecord)




                Return myAsientoItem
            End With
        End Function

    End Class
End Namespace