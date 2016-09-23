Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class NotaDeDebitoProvinciasItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As NotaDeDebitoItem
            Dim myNotaDeDebitoItem As NotaDeDebitoItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("DetNotasDebito_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleNotaDebito", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myNotaDeDebitoItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myNotaDeDebitoItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdNotaDeDebito As Integer) As NotaDeDebitoItemList
            Dim tempList As NotaDeDebitoItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                'DetNotasDebito_TX_PorIdCabecera    trae los nombres como en la base
                'DetNotasDebito_TXDeb               formatea para la grilla, con las descripciones de los ids (pero sin algunos ids)

                Dim myCommand As SqlCommand = New SqlCommand("DetNotasDebito_TX_PorIdCabecera", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdNotaDebito", IdNotaDeDebito)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New NotaDeDebitoItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myNotaDeDebitoItem As NotaDeDebitoProvinciasItem) As Integer
            Dim result As Integer = 0

            With myNotaDeDebitoItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand("DetNotasDebito_A", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleNotaDebito", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand("DetNotasDebito_M", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleNotaDebito", .Id)
                        End If



                        NETtoSQL(myCommand, "@IdNotaDebito", .IdNotaDebito)
                        NETtoSQL(myCommand, "@IdConcepto", .IdConcepto)
                        NETtoSQL(myCommand, "@Importe", .ImporteTotalItem)
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
                    If Not myNotaDeDebitoItem.Nuevo Then Delete(SC, myNotaDeDebitoItem.Id)
                End If
                Return result
            End With
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetNotaDeDebitos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleNotaDeDebito", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As NotaDeDebitoItem
            Dim myNotaDeDebitoItem As NotaDeDebitoItem = New NotaDeDebitoItem
            With myNotaDeDebitoItem
                SQLtoNET(.Id, "IdDetalleNotaDebito", myDataRecord)
                SQLtoNET(.IdNotaDebito, "IdNotaDebito", myDataRecord)
                SQLtoNET(.IdConcepto, "IdConcepto", myDataRecord)
                SQLtoNET(.ImporteTotalItem, "Importe", myDataRecord)
                SQLtoNET(.Gravado, "Gravado", myDataRecord)
                SQLtoNET(.IdDiferenciaCambio, "IdDiferenciaCambio", myDataRecord)
                SQLtoNET(.IvaNoDiscriminado, "IvaNoDiscriminado", myDataRecord)
                SQLtoNET(.IdCuentaBancaria, "IdCuentaBancaria", myDataRecord)
                SQLtoNET(.IdCaja, "IdCaja", myDataRecord)

                Return myNotaDeDebitoItem
            End With
        End Function

    End Class
End Namespace