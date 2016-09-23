Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO

Namespace Pronto.ERP.Dal

    Public Class PaisDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Pais
            Dim myPais As Pais = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wPaises_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdPais", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myPais = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myPais
        End Function

        Public Shared Function GetList(ByVal SC As String) As PaisList
            Dim tempList As PaisList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wPaises_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New PaisList
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
                Dim myCommand As SqlCommand = New SqlCommand("wPaises_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdPais", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myPais As Pais) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wPaises_A", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                If myPais.Id = -1 Then
                    myCommand.Parameters.AddWithValue("@IdPais", DBNull.Value)
                Else
                    myCommand.Parameters.AddWithValue("@IdPais", myPais.Id)
                End If
                myCommand.Parameters.AddWithValue("@Descripcion", myPais.Descripcion)
                myCommand.Parameters.AddWithValue("@Codigo", myPais.Codigo)
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
            ' Using
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("Paises_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdPais", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Pais
            Dim myPais As Pais = New Pais
            myPais.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdPais"))
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Descripcion")) Then
                myPais.Descripcion = myDataRecord.GetString(myDataRecord.GetOrdinal("Descripcion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Codigo")) Then
                myPais.Codigo = myDataRecord.GetString(myDataRecord.GetOrdinal("Codigo"))
            End If
            Return myPais
        End Function

    End Class

End Namespace