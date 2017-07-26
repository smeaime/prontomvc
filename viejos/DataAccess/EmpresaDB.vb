Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO

Namespace Pronto.ERP.Dal
    Public Class EmpresaDB
		Public Shared Function GetList(ByVal SC As String) As EmpresaList
			Dim tempList As EmpresaList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("GetAllCompanies", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New EmpresaList
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

        Public Shared Function EmpresasPorUsuario(ByVal SC As String, ByVal UserId As String) As EmpresaList
            Dim tempList As EmpresaList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("GetCompaniesForUser", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@UserId", UserId)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New EmpresaList
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

        Public Shared Function EmpresasDesasociadasPorUsuario(ByVal SC As String, ByVal UserId As String) As EmpresaList
            Dim tempList As EmpresaList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("GetCompaniesUnAssociatedForUser", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@UserId", UserId)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New EmpresaList
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

        Public Shared Function AddUserInCompanies(ByVal SC As String, ByVal UserId As String, ByVal IdCompany As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("AddUserInCompanies", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdUser", UserId)
                myCommand.Parameters.AddWithValue("@IdCompany", IdCompany)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Public Shared Function DeleteUserInCompanies(ByVal SC As String, ByVal UserId As String, ByVal IdCompany As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("DeleteUserInCompanies", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdUser", UserId)
                myCommand.Parameters.AddWithValue("@IdCompany", IdCompany)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

		Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Empresa
			Dim myEmpresa As Empresa = New Empresa
			myEmpresa.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdBD"))
			If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Descripcion")) Then
				myEmpresa.Descripcion = myDataRecord.GetString(myDataRecord.GetOrdinal("Descripcion"))
			End If
			If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("StringConection")) Then
				myEmpresa.ConnectionString = myDataRecord.GetString(myDataRecord.GetOrdinal("StringConection"))
			End If
			Return myEmpresa
		End Function

	End Class
End Namespace
