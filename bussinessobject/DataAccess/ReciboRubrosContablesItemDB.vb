Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class ReciboRubrosContablesItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As ReciboRubrosContablesItem
            Dim myreciboItem As ReciboRubrosContablesItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("DetRecibosRubrosContables_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleReciboRubrosContables", id)
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

        Public Shared Function GetList(ByVal SC As String, ByVal Idrecibo As Integer) As ReciboRubrosContablesItemList
            Dim tempList As ReciboRubrosContablesItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                'DetRecibos_TX_PorIdCabecera    trae los nombres como en la base
                'DetRecibos_TXDeb               formatea para la grilla, con las descripciones de los ids (pero sin algunos ids)

                Dim myCommand As SqlCommand = New SqlCommand("DetRecibosRubrosContables_TX_PorIdRecibo", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRecibo", Idrecibo)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    tempList = New ReciboRubrosContablesItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myreciboItem As ReciboRubrosContablesItem) As Integer
            Dim result As Integer = 0

            With myreciboItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand("DetRecibosRubrosContables_A", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleReciboRubrosContables", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand("DetRecibosRubrosContables_M", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleReciboRubrosContables", .Id)
                        End If



                        NETtoSQL(myCommand, "@IdRecibo", .IdRecibo)
                        NETtoSQL(myCommand, "@IdRubroContable", .IdRubroContable)
                        NETtoSQL(myCommand, "@Importe", .Importe)
                        NETtoSQL(myCommand, "@EnviarEmail", .EnviarEmail)
                        NETtoSQL(myCommand, "@IdOrigenTransmision", .IdOrigenTransmision)
                        NETtoSQL(myCommand, "@IdReciboOriginal", .IdReciboOriginal)
                        NETtoSQL(myCommand, "@IdDetalleReciboRubrosContablesOriginal", .IdDetalleReciboRubrosContablesOriginal)
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
                Dim myCommand As SqlCommand = New SqlCommand("wDetrecibosRubrosContables_E", myConnection)
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

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As ReciboRubrosContablesItem
            Dim myreciboItem As ReciboRubrosContablesItem = New ReciboRubrosContablesItem
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



                SQLtoNET(.Id, "IdDetalleReciboRubrosContables", myDataRecord)
                SQLtoNET(.IdRecibo, "IdRecibo", myDataRecord)
                SQLtoNET(.IdRubroContable, "IdRubroContable", myDataRecord)
                SQLtoNET(.Importe, "Importe", myDataRecord)
                SQLtoNET(.EnviarEmail, "EnviarEmail", myDataRecord)
                SQLtoNET(.IdOrigenTransmision, "IdOrigenTransmision", myDataRecord)
                SQLtoNET(.IdReciboOriginal, "IdReciboOriginal", myDataRecord)
                SQLtoNET(.IdDetalleReciboRubrosContablesOriginal, "IdDetalleReciboRubrosContablesOriginal", myDataRecord)
                SQLtoNET(.FechaImportacionTransmision, "FechaImportacionTransmision", myDataRecord)


                Return myreciboItem
            End With
        End Function

    End Class
End Namespace