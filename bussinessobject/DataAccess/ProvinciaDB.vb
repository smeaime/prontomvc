Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO

Namespace Pronto.ERP.Dal

    Public Class ProvinciaDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Provincia
            Dim myProvincia As Provincia = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wProvincias_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdProvincia", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myProvincia = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myProvincia
        End Function

        Public Shared Function GetList(ByVal SC As String) As ProvinciaList
            Dim tempList As ProvinciaList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wProvincias_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New ProvinciaList
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
                Dim myCommand As SqlCommand = New SqlCommand("wProvincias_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdProvincia", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myProvincia As Provincia) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wProvincias_A", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                If myProvincia.Id = -1 Then
                    myCommand.Parameters.AddWithValue("@IdProvincia", DBNull.Value)
                Else
                    myCommand.Parameters.AddWithValue("@IdProvincia", myProvincia.Id)
                End If
                myCommand.Parameters.AddWithValue("@Nombre", myProvincia.Nombre)
                myCommand.Parameters.AddWithValue("@Codigo", myProvincia.Codigo)
                myCommand.Parameters.AddWithValue("@IdPais", myProvincia.IdPais)
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
                Dim myCommand As SqlCommand = New SqlCommand("Provincias_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdProvincia", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Provincia
            Dim myProvincia As Provincia = New Provincia
            myProvincia.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdProvincia"))
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Nombre")) Then
                myProvincia.Nombre = myDataRecord.GetString(myDataRecord.GetOrdinal("Nombre"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Codigo")) Then
                myProvincia.Codigo = myDataRecord.GetString(myDataRecord.GetOrdinal("Codigo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdPais")) Then
                myProvincia.IdPais = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdPais"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Pais")) Then
                myProvincia.Pais = myDataRecord.GetString(myDataRecord.GetOrdinal("Pais"))
            End If
            Return myProvincia
        End Function

    End Class

End Namespace