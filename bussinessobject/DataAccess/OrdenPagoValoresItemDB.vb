Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class OrdenPagoValoresItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As OrdenPagoValoresItem
            Dim myOrdenPagoItem As OrdenPagoValoresItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.DetOrdenesPago_T.ToString, myConnection)
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

        Public Shared Function GetList(ByVal SC As String, ByVal IdOrdenPago As Integer) As OrdenPagoValoresItemList
            Dim tempList As OrdenPagoValoresItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                'DetOrdenPagos_TX_PorIdCabecera    trae los nombres como en la base
                'DetOrdenPagos_TXDeb               formatea para la grilla, con las descripciones de los ids (pero sin algunos ids)

                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.DetOrdenesPagoValores_TX_PorIdCabecera.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdOrdenPago", IdOrdenPago)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    tempList = New OrdenPagoValoresItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myOrdenPagoItem As OrdenPagoValoresItem) As Integer
            Dim result As Integer = 0

            With myOrdenPagoItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand(enumSPs.DetOrdenesPagoValores_A.ToString, myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleOrdenPagoValores", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand(enumSPs.DetOrdenesPagoValores_M.ToString, myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleOrdenPagoValores", .Id)
                        End If


                        NETtoSQL(myCommand, "@IdOrdenPago", .IdOrdenPago)
                        NETtoSQL(myCommand, "@IdTipoValor", .IdTipoValor)
                        NETtoSQL(myCommand, "@NumeroValor", .NumeroValor)
                        NETtoSQL(myCommand, "@NumeroInterno", .NumeroInterno)
                        NETtoSQL(myCommand, "@FechaVencimiento", .FechaVencimiento)
                        NETtoSQL(myCommand, "@IdBanco", .IdBanco)
                        NETtoSQL(myCommand, "@Importe", .Importe)

                        NETtoSQL(myCommand, "@IdValor", .IdValor)
                        NETtoSQL(myCommand, "@IdCuentaBancaria", .IdCuentaBancaria)
                        NETtoSQL(myCommand, "@IdBancoChequera", .IdBancoChequera)
                        NETtoSQL(myCommand, "@IdCaja", .IdCaja)
                        NETtoSQL(myCommand, "@ChequesALaOrdenDe", .ChequesALaOrdenDe)
                        NETtoSQL(myCommand, "@NoALaOrden", .NoALaOrden)

                        NETtoSQL(myCommand, "@Anulado", .Anulado)
                        NETtoSQL(myCommand, "@IdUsuarioAnulo", .IdUsuarioAnulo)
                        NETtoSQL(myCommand, "@FechaAnulacion", .FechaAnulacion)
                        NETtoSQL(myCommand, "@MotivoAnulacion", .MotivoAnulacion)
                        NETtoSQL(myCommand, "@IdTarjetaCredito", .IdTarjetaCredito)







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
                    If Not myOrdenPagoItem.Nuevo Then Delete(SC, myOrdenPagoItem.Id)
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

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As OrdenPagoValoresItem
            Dim myOrdenPagoItem As OrdenPagoValoresItem = New OrdenPagoValoresItem
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




                SQLtoNET(.Id, "IdDetalleOrdenPagoValores", myDataRecord)
                SQLtoNET(.IdOrdenPago, "IdOrdenPago", myDataRecord)
                SQLtoNET(.IdTipoValor, "IdTipoValor", myDataRecord)
                SQLtoNET(.NumeroValor, "NumeroValor", myDataRecord)
                SQLtoNET(.NumeroInterno, "NumeroInterno", myDataRecord)
                SQLtoNET(.FechaVencimiento, "FechaVencimiento", myDataRecord)
                SQLtoNET(.IdBanco, "IdBanco", myDataRecord)
                SQLtoNET(.Importe, "Importe", myDataRecord)

                SQLtoNET(myDataRecord, "@IdValor", .IdValor)
                SQLtoNET(myDataRecord, "@IdCuentaBancaria", .IdCuentaBancaria)
                SQLtoNET(myDataRecord, "@IdBancoChequera", .IdBancoChequera)
                SQLtoNET(myDataRecord, "@IdCaja", .IdCaja)
                SQLtoNET(myDataRecord, "@ChequesALaOrdenDe", .ChequesALaOrdenDe)
                SQLtoNET(myDataRecord, "@NoALaOrden", .NoALaOrden)

                SQLtoNET(myDataRecord, "@Anulado", .Anulado)
                SQLtoNET(myDataRecord, "@IdUsuarioAnulo", .IdUsuarioAnulo)
                SQLtoNET(myDataRecord, "@FechaAnulacion", .FechaAnulacion)
                SQLtoNET(myDataRecord, "@MotivoAnulacion", .MotivoAnulacion)
                SQLtoNET(myDataRecord, "@IdTarjetaCredito", .IdTarjetaCredito)

                Return myOrdenPagoItem
            End With
        End Function

    End Class
End Namespace