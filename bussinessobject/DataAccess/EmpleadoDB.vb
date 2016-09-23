Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO

Namespace Pronto.ERP.Dal

    Public Class EmpleadoDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Empleado
            Dim myEmpleado As Empleado = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wEmpleados_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdEmpleado", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myEmpleado = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////
                Try
                    'como estoy metiendo campos por afuera de los sp en el Save(), tengo que traerlos acá de la misma manera
                    Dim dt As DataTable = GeneralDB.ExecDinamico(SC, "select * from Empleados WHERE IdEmpleado=" & id)
                    With myEmpleado
                        myEmpleado.PuntoVentaAsociado = iisNull(dt.Rows(0).Item("PuntoVentaAsociado"), 0)
                    End With
                Catch ex As Exception

                End Try

                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////            
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myEmpleado
        End Function

        Public Shared Function GetList(ByVal SC As String) As EmpleadoList
            Dim tempList As EmpleadoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wEmpleados_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New EmpleadoList
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
                Dim myCommand As SqlCommand = New SqlCommand("wEmpleados_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdEmpleado", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myEmpleado As Empleado) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wEmpleados_A", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                If myEmpleado.Id = -1 Then
                    myCommand.Parameters.AddWithValue("@IdEmpleado", DBNull.Value)
                Else
                    myCommand.Parameters.AddWithValue("@IdEmpleado", myEmpleado.Id)
                End If
                myCommand.Parameters.AddWithValue("@Legajo", myEmpleado.Legajo)
                myCommand.Parameters.AddWithValue("@Nombre", myEmpleado.Nombre)
                'myCommand.Parameters.AddWithValue("@Email", myEmpleado.Email)

                Dim returnValue As DbParameter
                returnValue = myCommand.CreateParameter
                returnValue.Direction = ParameterDirection.ReturnValue
                myCommand.Parameters.Add(returnValue)
                myConnection.Open()
                myCommand.ExecuteNonQuery()
                result = Convert.ToInt32(returnValue.Value)
                myConnection.Close()


                '///////////////////////////////////////////////////
                '///////////////////////////////////////////////////
                'hasta que no se definan los campos adicionales, los agrego por acá

                Dim comandoSQLdinamico As String = String.Format("UPDATE Empleados SET " & _
                                    "PuntoVentaAsociado={1}, " & _
                                    "Email='{2}' " & _
                                        "WHERE IdEmpleado={0} ", result, DecimalToString(myEmpleado.PuntoVentaAsociado), myEmpleado.Email)


                ''myCommand = New SqlCommand(comandoSQLdinamico, myConnection)
                ''myCommand.Transaction = Transaccion
                ''myCommand.CommandType = CommandType.Text
                ''myCommand.ExecuteNonQuery()

                GeneralDB.ExecDinamico(SC, comandoSQLdinamico)

                '///////////////////////////////////////////////////
                '///////////////////////////////////////////////////
                '///////////////////////////////////////////////////



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
                Dim myCommand As SqlCommand = New SqlCommand("Empleados_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdEmpleado", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Empleado
            Dim myEmpleado As Empleado = New Empleado
            myEmpleado.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdEmpleado"))
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Legajo")) Then
                myEmpleado.Legajo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Legajo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Nombre")) Then
                myEmpleado.Nombre = myDataRecord.GetString(myDataRecord.GetOrdinal("Nombre"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Email")) Then
                myEmpleado.Email = myDataRecord.GetString(myDataRecord.GetOrdinal("Email"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdSector")) Then
                myEmpleado.IdSector = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdSector"))
            End If

            Return myEmpleado
        End Function

        Public Shared Function HaveAccess(ByVal SC As String, ByVal UserName As String, ByVal Nodo As String) As Boolean
            Dim result As Boolean = False
            Dim myEmpleado As Empleado = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("HaveEmployeeAccess", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@UserName", UserName)
                myCommand.Parameters.AddWithValue("@Nodo", Nodo)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                If myReader.HasRows Then
                    result = True
                End If
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result
        End Function

        Public Shared Function GetEmployeeByName(ByVal SC As String, ByVal UserName As String) As Empleado
            Dim myEmpleado As Empleado = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("GetEmployeeByName", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@UserName", UserName)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myEmpleado = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myEmpleado
        End Function
    End Class

End Namespace