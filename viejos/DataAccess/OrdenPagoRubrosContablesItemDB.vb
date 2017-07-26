Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class OrdenPagoRubrosContablesItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As OrdenPagoRubrosContablesItem
            Dim myOrdenPagoItem As OrdenPagoRubrosContablesItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.DetOrdenesPagoRubrosContables_T.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleOrdenPagoRubrosContables", id)
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

        Public Shared Function GetList(ByVal SC As String, ByVal IdOrdenPago As Integer) As OrdenPagoRubrosContablesItemList
            Dim tempList As OrdenPagoRubrosContablesItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                'DetOrdenPagos_TX_PorIdCabecera    trae los nombres como en la base
                'DetOrdenPagos_TXDeb               formatea para la grilla, con las descripciones de los ids (pero sin algunos ids)

                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.DetOrdenesPagoRubrosContables_TX_PorIdOrdenPago.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdOrdenPago", IdOrdenPago)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    tempList = New OrdenPagoRubrosContablesItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myOrdenPagoItem As OrdenPagoRubrosContablesItem) As Integer
            Dim result As Integer = 0

            With myOrdenPagoItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand(enumSPs.DetOrdenesPagoRubrosContables_A.ToString, myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleOrdenPagoRubrosContables", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand(enumSPs.DetOrdenesPagoRubrosContables_M.ToString, myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleOrdenPagoRubrosContables", .Id)
                        End If



                        NETtoSQL(myCommand, "@IdOrdenPago", .IdOrdenPago)
                        NETtoSQL(myCommand, "@IdRubroContable", .IdRubroContable)
                        NETtoSQL(myCommand, "@Importe", .Importe)
                        'NETtoSQL(myCommand, "@EnviarEmail", .EnviarEmail)
                        'NETtoSQL(myCommand, "@IdOrigenTransmision", .IdOrigenTransmision)
                        'NETtoSQL(myCommand, "@IdOrdenPagoOriginal", .IdOrdenPagoOriginal)
                        'NETtoSQL(myCommand, "@IdDetalleOrdenPagoRubrosContablesOriginal", .IdDetalleOrdenPagoRubrosContablesOriginal)
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
                    If Not myOrdenPagoItem.Nuevo Then Delete(SC, myOrdenPagoItem.Id)
                End If
                Return result
            End With
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetOrdenPagosRubrosContables_E", myConnection)
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

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As OrdenPagoRubrosContablesItem
            Dim myOrdenPagoItem As OrdenPagoRubrosContablesItem = New OrdenPagoRubrosContablesItem
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



                SQLtoNET(.Id, "IdDetalleOrdenPagoRubrosContables", myDataRecord)
                SQLtoNET(.IdOrdenPago, "IdOrdenPago", myDataRecord)
                SQLtoNET(.IdRubroContable, "IdRubroContable", myDataRecord)
                SQLtoNET(.Importe, "Importe", myDataRecord)
                'SQLtoNET(.EnviarEmail, "EnviarEmail", myDataRecord)
                'SQLtoNET(.IdOrigenTransmision, "IdOrigenTransmision", myDataRecord)
                'SQLtoNET(.IdOrdenPagoOriginal, "IdOrdenPagoOriginal", myDataRecord)
                'SQLtoNET(.IdDetalleOrdenPagoRubrosContablesOriginal, "IdDetalleOrdenPagoRubrosContablesOriginal", myDataRecord)
                'SQLtoNET(.FechaImportacionTransmision, "FechaImportacionTransmision", myDataRecord)


                Return myOrdenPagoItem
            End With
        End Function

    End Class
End Namespace