Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class ReciboValoresItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As ReciboValoresItem
            Dim myreciboItem As ReciboValoresItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("DetRecibos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleRecibo", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myreciboItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myreciboItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal Idrecibo As Integer) As ReciboValoresItemList
            Dim tempList As ReciboValoresItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                'DetRecibos_TX_PorIdCabecera    trae los nombres como en la base
                'DetRecibos_TXDeb               formatea para la grilla, con las descripciones de los ids (pero sin algunos ids)

                Dim myCommand As SqlCommand = New SqlCommand("DetRecibosValores_TX_PorIdCabecera", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRecibo", Idrecibo)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    tempList = New ReciboValoresItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myreciboItem As ReciboValoresItem) As Integer
            Dim result As Integer = 0

            With myreciboItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand("DetRecibosValores_A", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleReciboValores", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand("DetRecibosValores_M", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleReciboValores", .Id)
                        End If


                        NETtoSQL(myCommand, "@IdRecibo", .IdRecibo)
                        NETtoSQL(myCommand, "@IdTipoValor", .IdTipoValor)
                        NETtoSQL(myCommand, "@NumeroValor", .NumeroValor)
                        NETtoSQL(myCommand, "@NumeroInterno", .NumeroInterno)
                        NETtoSQL(myCommand, "@FechaVencimiento", .FechaVencimiento)
                        NETtoSQL(myCommand, "@IdBanco", .IdBanco)
                        NETtoSQL(myCommand, "@Importe", .Importe)
                        NETtoSQL(myCommand, "@IdCuentaBancariaTransferencia", .IdCuentaBancariaTransferencia)
                        NETtoSQL(myCommand, "@IdBancoTransferencia", .IdBancoTransferencia)
                        NETtoSQL(myCommand, "@NumeroTransferencia", .NumeroTransferencia)
                        NETtoSQL(myCommand, "@IdTipoCuentaGrupo", .IdTipoCuentaGrupo)
                        NETtoSQL(myCommand, "@IdCuenta", .IdCuenta)
                        NETtoSQL(myCommand, "@IdCaja", .IdCaja)
                        NETtoSQL(myCommand, "@CuitLibrador", .CuitLibrador)
                        NETtoSQL(myCommand, "@IdTarjetaCredito", .IdTarjetaCredito)
                        NETtoSQL(myCommand, "@NumeroTarjetaCredito", .NumeroTarjetaCredito)
                        NETtoSQL(myCommand, "@NumeroAutorizacionTarjetaCredito", .NumeroAutorizacionTarjetaCredito)
                        NETtoSQL(myCommand, "@CantidadCuotas", .CantidadCuotas)
                        NETtoSQL(myCommand, "@EnviarEmail", .EnviarEmail)
                        NETtoSQL(myCommand, "@IdOrigenTransmision", .IdOrigenTransmision)
                        NETtoSQL(myCommand, "@IdReciboOriginal", .IdReciboOriginal)
                        NETtoSQL(myCommand, "@IdDetalleReciboValoresOriginal", .IdDetalleReciboValoresOriginal)
                        NETtoSQL(myCommand, "@FechaImportacionTransmision", .FechaImportacionTransmision)



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
                    If Not myreciboItem.Nuevo Then Delete(SC, myreciboItem.Id)
                End If
                Return result
            End With
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetrecibos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetallerecibo", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As ReciboValoresItem
            Dim myreciboItem As ReciboValoresItem = New ReciboValoresItem
            With myreciboItem
                'SQLtoNET(.Id, "IdDetalleRecibo", myDataRecord)
                'SQLtoNET(.IdRecibo, "IdRecibo", myDataRecord)
                'SQLtoNET(.IdConcepto, "IdConcepto", myDataRecord)
                'SQLtoNET(.ImporteTotalItem, "Importe", myDataRecord)
                'SQLtoNET(.Gravado, "Gravado", myDataRecord)
                'SQLtoNET(.IdDiferenciaCambio, "IdDiferenciaCambio", myDataRecord)
                'SQLtoNET(.IvaNoDiscriminado, "IvaNoDiscriminado", myDataRecord)
                'SQLtoNET(.IdCuentaBancaria, "IdCuentaBancaria", myDataRecord)
                'SQLtoNET(.IdCaja, "IdCaja", myDataRecord)




                SQLtoNET(.Id, "IdDetalleReciboValores", myDataRecord)
                SQLtoNET(.IdRecibo, "IdRecibo", myDataRecord)
                SQLtoNET(.IdTipoValor, "IdTipoValor", myDataRecord)
                SQLtoNET(.NumeroValor, "NumeroValor", myDataRecord)
                SQLtoNET(.NumeroInterno, "NumeroInterno", myDataRecord)
                SQLtoNET(.FechaVencimiento, "FechaVencimiento", myDataRecord)
                SQLtoNET(.IdBanco, "IdBanco", myDataRecord)
                SQLtoNET(.Importe, "Importe", myDataRecord)
                SQLtoNET(.IdCuentaBancariaTransferencia, "IdCuentaBancariaTransferencia", myDataRecord)
                SQLtoNET(.IdBancoTransferencia, "IdBancoTransferencia", myDataRecord)
                SQLtoNET(.NumeroTransferencia, "NumeroTransferencia", myDataRecord)
                SQLtoNET(.IdTipoCuentaGrupo, "IdTipoCuentaGrupo", myDataRecord)
                SQLtoNET(.IdCuenta, "IdCuenta", myDataRecord)
                SQLtoNET(.IdCaja, "IdCaja", myDataRecord)
                SQLtoNET(.CuitLibrador, "CuitLibrador", myDataRecord)
                SQLtoNET(.IdTarjetaCredito, "IdTarjetaCredito", myDataRecord)
                SQLtoNET(.NumeroTarjetaCredito, "NumeroTarjetaCredito", myDataRecord)
                SQLtoNET(.NumeroAutorizacionTarjetaCredito, "NumeroAutorizacionTarjetaCredito", myDataRecord)
                SQLtoNET(.CantidadCuotas, "CantidadCuotas", myDataRecord)
                SQLtoNET(.EnviarEmail, "EnviarEmail", myDataRecord)
                SQLtoNET(.IdOrigenTransmision, "IdOrigenTransmision", myDataRecord)
                SQLtoNET(.IdReciboOriginal, "IdReciboOriginal", myDataRecord)
                SQLtoNET(.IdDetalleReciboValoresOriginal, "IdDetalleReciboValoresOriginal", myDataRecord)
                SQLtoNET(.FechaImportacionTransmision, "FechaImportacionTransmision", myDataRecord)

                Return myreciboItem
            End With
        End Function

    End Class
End Namespace