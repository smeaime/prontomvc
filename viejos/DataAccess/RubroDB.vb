Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO

Namespace Pronto.ERP.Dal

    Public Class RubroDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Rubro
            Dim myRubro As Rubro = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wRubros_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRubro", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myRubro = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myRubro
        End Function

        Public Shared Function GetList(ByVal SC As String) As RubroList
            Dim tempList As RubroList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wRubros_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New RubroList
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
                Dim myCommand As SqlCommand = New SqlCommand("wRubros_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRubro", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myRubro As Rubro) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wRubros_A", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                If myRubro.Id = -1 Then
                    myCommand.Parameters.AddWithValue("@IdRubro", DBNull.Value)
                Else
                    myCommand.Parameters.AddWithValue("@IdRubro", myRubro.Id)
                End If
                myCommand.Parameters.AddWithValue("@Descripcion", myRubro.Descripcion)
                myCommand.Parameters.AddWithValue("@Abreviatura", myRubro.Abreviatura)
                myCommand.Parameters.AddWithValue("@IdCuenta", myRubro.IdCuentaVentas)
                myCommand.Parameters.AddWithValue("@IdCuentaCompras", myRubro.IdCuentaCompras)
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
                Dim myCommand As SqlCommand = New SqlCommand("Rubros_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRubro", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Rubro
            Dim myRubro As Rubro = New Rubro
            myRubro.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdRubro"))
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Descripcion")) Then
                myRubro.Descripcion = myDataRecord.GetString(myDataRecord.GetOrdinal("Descripcion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Abreviatura")) Then
                myRubro.Abreviatura = myDataRecord.GetString(myDataRecord.GetOrdinal("Abreviatura"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdCuenta")) Then
                myRubro.IdCuentaVentas = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdCuenta"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CuentaVentas")) Then
                myRubro.CuentaVentas = myDataRecord.GetString(myDataRecord.GetOrdinal("CuentaVentas"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdCuentaCompras")) Then
                myRubro.IdCuentaCompras = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdCuentaCompras"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CuentaCompras")) Then
                myRubro.CuentaCompras = myDataRecord.GetString(myDataRecord.GetOrdinal("CuentaCompras"))
            End If
            Return myRubro
        End Function

    End Class

End Namespace