Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class NotaDeCreditoProvinciasItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As NotaDeCreditoItem
            Dim myNotaDeCreditoItem As NotaDeCreditoItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetNotaDeCreditos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleNotaDeCredito", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myNotaDeCreditoItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myNotaDeCreditoItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdNotaDeCredito As Integer) As NotaDeCreditoItemList
            Dim tempList As NotaDeCreditoItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("DetNotasDebito_TX_PorIdCabecera", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdNotaDeCredito", IdNotaDeCredito)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New NotaDeCreditoItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myNotaDeCreditoItem As NotaDeCreditoProvinciasItem) As Integer
            Dim result As Integer = 0
            With myNotaDeCreditoItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand("DetNotasCredito_A", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdNotaCredito", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand("DetNotasCredito_M", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdNotaCredito", .Id)
                        End If



                        NETtoSQL(myCommand, "@IdNotaCredito", .IdNotaCredito)
                        NETtoSQL(myCommand, "@IdConcepto", .IdConcepto)
                        NETtoSQL(myCommand, "@Importe", .Importe)
                        NETtoSQL(myCommand, "@Gravado", .Gravado)
                        NETtoSQL(myCommand, "@IdDiferenciaCambio", .IdDiferenciaCambio)
                        NETtoSQL(myCommand, "@IvaNoDiscriminado", .IvaNoDiscriminado)
                        NETtoSQL(myCommand, "@IdCuentaBancaria", .IdCuentaBancaria)
                        NETtoSQL(myCommand, "@IdCaja", .IdCaja)





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
                    If Not myNotaDeCreditoItem.Nuevo Then Delete(SC, myNotaDeCreditoItem.Id)
                End If
                Return result
            End With
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetNotaDeCreditos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleNotaDeCredito", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As NotaDeCreditoItem
            Dim myNotaDeCreditoItem As NotaDeCreditoItem = New NotaDeCreditoItem
            With myNotaDeCreditoItem
                SQLtoNET(.Id, "IdDetalleNotaCredito", myDataRecord)
                SQLtoNET(.IdNotaCredito, "IdNotaCredito", myDataRecord)
                SQLtoNET(.IdConcepto, "IdConcepto", myDataRecord)
                SQLtoNET(.ImporteTotalItem, "Importe", myDataRecord)
                SQLtoNET(.Gravado, "Gravado", myDataRecord)
                SQLtoNET(.IdDiferenciaCambio, "IdDiferenciaCambio", myDataRecord)
                SQLtoNET(.IvaNoDiscriminado, "IvaNoDiscriminado", myDataRecord)
                SQLtoNET(.IdCuentaBancaria, "IdCuentaBancaria", myDataRecord)
                SQLtoNET(.IdCaja, "IdCaja", myDataRecord)

                Return myNotaDeCreditoItem
            End With
        End Function
    End Class
End Namespace