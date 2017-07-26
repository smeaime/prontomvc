Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO

Namespace Pronto.ERP.Dal

    Public Class LocalidadDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Localidad
            Dim myLocalidad As Localidad = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wLocalidades_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdLocalidad", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myLocalidad = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myLocalidad
        End Function

        Public Shared Function GetList(ByVal SC As String) As LocalidadList
            Dim tempList As LocalidadList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wLocalidades_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New LocalidadList
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
                Dim myCommand As SqlCommand = New SqlCommand("wLocalidades_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdLocalidad", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myLocalidad As Localidad) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wLocalidades_A", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                If myLocalidad.Id = -1 Then
                    myCommand.Parameters.AddWithValue("@IdLocalidad", DBNull.Value)
                Else
                    myCommand.Parameters.AddWithValue("@IdLocalidad", myLocalidad.Id)
                End If
                myCommand.Parameters.AddWithValue("@Nombre", myLocalidad.Nombre)
                myCommand.Parameters.AddWithValue("@CodigoPostal", myLocalidad.CodigoPostal)
                myCommand.Parameters.AddWithValue("@IdProvincia", myLocalidad.IdProvincia)
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
                Dim myCommand As SqlCommand = New SqlCommand("Localidades_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdLocalidad", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Localidad
            Dim myLocalidad As Localidad = New Localidad
            myLocalidad.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdLocalidad"))
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Nombre")) Then
                myLocalidad.Nombre = myDataRecord.GetString(myDataRecord.GetOrdinal("Nombre"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CodigoPostal")) Then
                myLocalidad.CodigoPostal = myDataRecord.GetString(myDataRecord.GetOrdinal("CodigoPostal"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdProvincia")) Then
                myLocalidad.IdProvincia = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdProvincia"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Provincia")) Then
                myLocalidad.Provincia = myDataRecord.GetString(myDataRecord.GetOrdinal("Provincia"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdPais")) Then
                myLocalidad.IdPais = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdPais"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Pais")) Then
                myLocalidad.Pais = myDataRecord.GetString(myDataRecord.GetOrdinal("Pais"))
            End If
            Return myLocalidad
        End Function

    End Class

End Namespace