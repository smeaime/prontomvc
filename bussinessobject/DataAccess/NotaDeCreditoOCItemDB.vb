Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class NotaDeCreditoOCItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As NotaDeCreditoOCItem
            Dim myNotaDeCreditoItem As NotaDeCreditoOCItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("DetNotasCreditoOC_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleNotaCreditoOrdenesCompra", id)
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

        Public Shared Function GetList(ByVal SC As String, ByVal IdNotaDeCredito As Integer) As NotaDeCreditoOCItemList
            Dim tempList As NotaDeCreditoOCItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("DetNotasCreditoOC_TX_PorIdNotasCredito", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdNotaCredito", IdNotaDeCredito)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New NotaDeCreditoOCItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myNotaDeCreditoOCItem As NotaDeCreditoOCItem) As Integer
            Dim result As Integer = 0
            With myNotaDeCreditoOCItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand("DetNotasCreditoOC_A", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleNotaCreditoOrdenesCompra", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand("DetNotasCreditoOC_M", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleNotaCreditoOrdenesCompra", .Id)
                        End If



                        NETtoSQL(myCommand, "@IdNotaCredito", .IdNotaCredito)
                        NETtoSQL(myCommand, "@IdDetalleOrdenCompra", .IdDetalleOrdenCompra)
                        NETtoSQL(myCommand, "@Cantidad", .Cantidad)
                        NETtoSQL(myCommand, "@PorcentajeCertificacion", .PorcentajeCertificacion)





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
                    If Not myNotaDeCreditoOCItem.Nuevo Then Delete(SC, myNotaDeCreditoOCItem.Id)
                End If
                Return result
            End With
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
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

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As NotaDeCreditoOCItem
            Dim myNotaDeCreditoOCItem As NotaDeCreditoOCItem = New NotaDeCreditoOCItem
            With myNotaDeCreditoOCItem

                SQLtoNET(myDataRecord, "@IdDetalleNotaCreditoOrdenesCompra", .Id)
                SQLtoNET(myDataRecord, "@IdNotaCredito", .IdNotaCredito)
                SQLtoNET(myDataRecord, "@IdDetalleOrdenCompra", .IdDetalleOrdenCompra)
                SQLtoNET(myDataRecord, "@Cantidad", .Cantidad)
                SQLtoNET(myDataRecord, "@PorcentajeCertificacion", .PorcentajeCertificacion)




                Return myNotaDeCreditoOCItem
            End With
        End Function
    End Class
End Namespace