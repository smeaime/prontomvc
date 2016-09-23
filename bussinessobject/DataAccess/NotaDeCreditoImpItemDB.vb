Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class NotaDeCreditoImpItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As NotaDeCreditoImpItem
            Dim myNotaDeCreditoItem As NotaDeCreditoImpItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("DetNotasCreditoImp_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleNotaCreditoImputaciones", id)
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

        Public Shared Function GetList(ByVal SC As String, ByVal IdNotaDeCredito As Integer) As NotaDeCreditoImpItemList
            Dim tempList As NotaDeCreditoImpItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("DetNotasCreditoImp_TX_PorIdCabecera", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdNotaCredito", IdNotaDeCredito)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New NotaDeCreditoImpItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myNotaDeCreditoItem As NotaDeCreditoImpItem) As Integer
            Dim result As Integer = 0
            With myNotaDeCreditoItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try
                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand("DetNotasCreditoImp_A", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleNotaCreditoImputaciones", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand("DetNotasCreditoImp_M", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleNotaCreditoImputaciones", .Id)
                        End If



                        NETtoSQL(myCommand, "@IdNotaCredito", .IdNotaCredito)
                        NETtoSQL(myCommand, "@IdImputacion", .IdImputacion)
                        NETtoSQL(myCommand, "@Importe", .Importe)




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
                myCommand.Parameters.AddWithValue("@IdDetalleNotaCreditoImputaciones", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As NotaDeCreditoImpItem
            Dim myNotaDeCreditoItem As NotaDeCreditoImpItem = New NotaDeCreditoImpItem
            With myNotaDeCreditoItem


                SQLtoNET(myDataRecord, "@IdDetalleNotaCreditoImputaciones", .Id)
                SQLtoNET(myDataRecord, "@IdNotaCredito", .IdNotaCredito)
                SQLtoNET(myDataRecord, "@IdImputacion", .IdImputacion)
                SQLtoNET(myDataRecord, "@Importe", .Importe)

                Return myNotaDeCreditoItem
            End With
        End Function
    End Class
End Namespace