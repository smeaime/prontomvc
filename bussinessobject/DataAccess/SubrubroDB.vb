Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO

Namespace Pronto.ERP.Dal

    Public Class SubrubroDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Subrubro
            Dim mySubrubro As Subrubro = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wSubrubros_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdSubrubro", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        mySubrubro = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return mySubrubro
        End Function

        Public Shared Function GetList(ByVal SC As String) As SubrubroList
            Dim tempList As SubrubroList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wSubrubros_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New SubrubroList
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

        Public Shared Function GetList_fm(ByVal SC As String) As DataSet
            Dim ds As New DataSet()
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wSubrubros_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdSubrubro", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal mySubrubro As Subrubro) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wSubrubros_A", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                If mySubrubro.Id = -1 Then
                    myCommand.Parameters.AddWithValue("@IdSubrubro", DBNull.Value)
                Else
                    myCommand.Parameters.AddWithValue("@IdSubrubro", mySubrubro.Id)
                End If
                myCommand.Parameters.AddWithValue("@Descripcion", mySubrubro.Descripcion)
                myCommand.Parameters.AddWithValue("@Abreviatura", mySubrubro.Abreviatura)
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
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("Subrubros_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdSubrubro", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Subrubro
            Dim mySubrubro As Subrubro = New Subrubro
            mySubrubro.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdSubrubro"))
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Descripcion")) Then
                mySubrubro.Descripcion = myDataRecord.GetString(myDataRecord.GetOrdinal("Descripcion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Abreviatura")) Then
                mySubrubro.Abreviatura = myDataRecord.GetString(myDataRecord.GetOrdinal("Abreviatura"))
            End If
            Return mySubrubro
        End Function

    End Class

End Namespace