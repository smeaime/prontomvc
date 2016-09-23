Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class ProveedorContactoDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As ProveedorContacto
            Dim myProveedorContacto As ProveedorContacto = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetProveedoresContactos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleProveedor", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myProveedorContacto = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myProveedorContacto
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdProveedor As Integer) As ProveedorContactoList
            Dim tempList As ProveedorContactoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetProveedoresContactos_TT", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdProveedor", IdProveedor)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New ProveedorContactoList
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

        Public Shared Function Save(ByVal SC As String, ByVal myProveedorContacto As ProveedorContacto) As Integer
            Dim result As Integer = 0
            If Not myProveedorContacto.Eliminado Then
                Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
                Try
                    Dim myCommand As SqlCommand = New SqlCommand("wDetProveedoresContactos_A", myConnection)
                    myCommand.CommandType = CommandType.StoredProcedure
                    If myProveedorContacto.Nuevo Then
                        myCommand.Parameters.AddWithValue("@IdDetalleProveedor", DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@IdDetalleProveedor", myProveedorContacto.Id)
                    End If
                    With myCommand.Parameters
                        .AddWithValue("@IdProveedor", myProveedorContacto.IdProveedor)
                        .AddWithValue("@Contacto", myProveedorContacto.Contacto)
                        .AddWithValue("@Puesto", myProveedorContacto.Puesto)
                        .AddWithValue("@Telefono", myProveedorContacto.Telefono)
                        .AddWithValue("@Email", myProveedorContacto.Email)
                    End With
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
                If Not myProveedorContacto.Nuevo Then Delete(SC, myProveedorContacto.Id)
            End If
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetProveedoresContactos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleProveedor", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As ProveedorContacto
            Dim myProveedorContacto As ProveedorContacto = New ProveedorContacto
            myProveedorContacto.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleProveedor"))
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Contacto")) Then
                myProveedorContacto.Contacto = myDataRecord.GetString(myDataRecord.GetOrdinal("Contacto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Puesto")) Then
                myProveedorContacto.Puesto = myDataRecord.GetString(myDataRecord.GetOrdinal("Puesto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Telefono")) Then
                myProveedorContacto.Telefono = myDataRecord.GetString(myDataRecord.GetOrdinal("Telefono"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Email")) Then
                myProveedorContacto.Email = myDataRecord.GetString(myDataRecord.GetOrdinal("Email"))
            End If
            Return myProveedorContacto
        End Function
    End Class
End Namespace