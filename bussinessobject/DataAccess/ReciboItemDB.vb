Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class reciboItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As reciboItem
            Dim myreciboItem As reciboItem = Nothing
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

        Public Shared Function GetList(ByVal SC As String, ByVal Idrecibo As Integer) As ReciboItemList
            Dim tempList As ReciboItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                'DetRecibos_TX_PorIdCabecera    trae los nombres como en la base
                'DetRecibos_TXDeb               formatea para la grilla, con las descripciones de los ids (pero sin algunos ids)

                Dim myCommand As SqlCommand = New SqlCommand("DetRecibos_TX_PorIdRecibo", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRecibo", Idrecibo)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    tempList = New ReciboItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myreciboItem As ReciboItem) As Integer
            Dim result As Integer = 0

            With myreciboItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand("DetRecibos_A", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleRecibo", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand("DetRecibos_M", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleRecibo", .Id)
                        End If



                

                        NETtoSQL(myCommand, "@IdRecibo", .IdRecibo)
                        NETtoSQL(myCommand, "@IdImputacion", .IdImputacion)
                        NETtoSQL(myCommand, "@Importe", .Importe)
                        NETtoSQL(myCommand, "@SaldoParteEnDolaresAnterior", .SaldoParteEnDolaresAnterior)
                        NETtoSQL(myCommand, "@PagadoParteEnDolares", .PagadoParteEnDolares)
                        NETtoSQL(myCommand, "@NuevoSaldoParteEnDolares", .NuevoSaldoParteEnDolares)
                        NETtoSQL(myCommand, "@SaldoParteEnPesosAnterior", .SaldoParteEnPesosAnterior)
                        NETtoSQL(myCommand, "@PagadoParteEnPesos", .PagadoParteEnPesos)
                        NETtoSQL(myCommand, "@NuevoSaldoParteEnPesos", .NuevoSaldoParteEnPesos)
                        NETtoSQL(myCommand, "@EnviarEmail", .EnviarEmail)
                        NETtoSQL(myCommand, "@IdOrigenTransmision", .IdOrigenTransmision)
                        NETtoSQL(myCommand, "@IdReciboOriginal", .IdReciboOriginal)
                        NETtoSQL(myCommand, "@IdDetalleReciboOriginal", .IdDetalleReciboOriginal)
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

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As ReciboItem
            Dim myreciboItem As ReciboItem = New ReciboItem
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



                SQLtoNET(.Id, "IdDetalleRecibo", myDataRecord)
                SQLtoNET(.IdRecibo, "IdRecibo", myDataRecord)
                SQLtoNET(.IdImputacion, "IdImputacion", myDataRecord)
                SQLtoNET(.Importe, "Importe", myDataRecord)
                SQLtoNET(.SaldoParteEnDolaresAnterior, "SaldoParteEnDolaresAnterior", myDataRecord)
                SQLtoNET(.PagadoParteEnDolares, "PagadoParteEnDolares", myDataRecord)
                SQLtoNET(.NuevoSaldoParteEnDolares, "NuevoSaldoParteEnDolares", myDataRecord)
                SQLtoNET(.SaldoParteEnPesosAnterior, "SaldoParteEnPesosAnterior", myDataRecord)
                SQLtoNET(.PagadoParteEnPesos, "PagadoParteEnPesos", myDataRecord)
                SQLtoNET(.NuevoSaldoParteEnPesos, "NuevoSaldoParteEnPesos", myDataRecord)
                SQLtoNET(.EnviarEmail, "EnviarEmail", myDataRecord)
                SQLtoNET(.IdOrigenTransmision, "IdOrigenTransmision", myDataRecord)
                SQLtoNET(.IdReciboOriginal, "IdReciboOriginal", myDataRecord)
                SQLtoNET(.IdDetalleReciboOriginal, "IdDetalleReciboOriginal", myDataRecord)
                SQLtoNET(.FechaImportacionTransmision, "FechaImportacionTransmision", myDataRecord)



                Return myreciboItem
            End With
        End Function

    End Class
End Namespace