Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO

Namespace Pronto.ERP.Dal

    Public Class GeneralDB


        Public Shared Function EjecutarSP(ByRef myConnection As SqlConnection, ByRef Transaccion As SqlTransaction, _
                                          ByVal Nombre As String, _
                                          ByVal ParamArray Parametros() As Object) As Integer


            Dim cant As Integer
            'Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                'Valido
                If Nombre.Length < 3 Then
                    Throw New ApplicationException("Nombre de SP invalido")
                End If

                'Creo el objeto comando
                Dim myCommand As SqlCommand = New SqlCommand(Nombre, myConnection)
                myCommand.Transaction = Transaccion
                myCommand.CommandType = CommandType.StoredProcedure


                'Traigo los parametros de la base
                'myConnection.Open()
                SqlCommandBuilder.DeriveParameters(myCommand)

                'Pasar los parametros al array
                If myCommand.Parameters.Count <> Parametros.Length + 1 Then
                    Throw New ApplicationException("Cantidad de parametros pasados invalidos.")
                End If

                Dim i As Integer
                For i = 0 To Parametros.Length - 1
                    myCommand.Parameters(i + 1).Value = Parametros(i)
                Next

                'Ejecucion
                cant = myCommand.ExecuteNonQuery()

                'Devuelvo los parametros
                For i = 0 To Parametros.Length - 1
                    Parametros(i) = myCommand.Parameters(i + 1).Value
                Next

            Catch ex As Exception
                'Throw ex
                'Debug.Print(ex.Message)
                ErrHandler.WriteError(ex)
                Throw New ApplicationException("Error en la ejecucion del SP: " + Nombre + " - " + ex.Message, ex)

            Finally
            End Try

            Return cant
        End Function


        Public Shared Function EjecutarSP(ByVal SC As String, ByVal Nombre As String, _
                    ByVal ParamArray Parametros() As Object) As Integer

            Dim cant As Integer
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                'Valido
                If Nombre.Length < 3 Then
                    Throw New ApplicationException("Nombre de SP invalido")
                End If

                'Creo el objeto comando
                Dim myCommand As SqlCommand = New SqlCommand(Nombre, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure


                'Traigo los parametros de la base
                myConnection.Open()
                SqlCommandBuilder.DeriveParameters(myCommand)

                'Pasar los parametros al array
                If myCommand.Parameters.Count <> Parametros.Length + 1 Then
                    Throw New ApplicationException("Cantidad de parametros pasados invalidos.")
                End If

                Dim i As Integer
                For i = 0 To Parametros.Length - 1
                    myCommand.Parameters(i + 1).Value = Parametros(i)
                Next

                'Ejecucion
                cant = myCommand.ExecuteNonQuery()

                'Devuelvo los parametros
                For i = 0 To Parametros.Length - 1
                    Parametros(i) = myCommand.Parameters(i + 1).Value
                Next

            Catch ex As Exception
                'Throw ex
                'Debug.Print(ex.Message)
                ErrHandler.WriteError(ex)
                Throw New ApplicationException("Error en la ejecucion del SP: " + Nombre + " - " + ex.Message, ex)

            Finally
                If myConnection.State = ConnectionState.Open Then
                    myConnection.Close()
                End If
            End Try

            Return cant

        End Function

        Public Shared Function TraerDatos(ByVal SC As String, ByVal Nombre As String, _
                    ByVal ParamArray ParametrosQueLeQuieroMandarAsql() As Object) As System.Data.DataSet

            Dim ds As New DataSet()
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))

            Try
                'Valido
                If Nombre.Length < 3 Then
                    Throw New ApplicationException("Nombre de SP invalido")
                End If

                'Creo el objeto comando
                Dim StoreProcedureDeLaBase As SqlCommand = New SqlCommand(Nombre, myConnection)
                StoreProcedureDeLaBase.CommandType = CommandType.StoredProcedure

                'Traigo los parametros de la base
                myConnection.Open()
                SqlCommandBuilder.DeriveParameters(StoreProcedureDeLaBase)



                '////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////
                ' Verifico parametros
                '////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////

                'Pasar los parametros al array   
                With StoreProcedureDeLaBase

                    If .Parameters.Count <> ParametrosQueLeQuieroMandarAsql.Length + 1 Then

                        'NO hay la misma cantidad de parametros
                        '-por qué el +1?
                        '-porque el primero es el @RETURNVALUE



                        If .Parameters.Count > ParametrosQueLeQuieroMandarAsql.Length + 1 Then
                            'ME FALTAN parametros para mandar


                            If .Parameters(ParametrosQueLeQuieroMandarAsql.Length + 1).IsNullable Then
                                'el sp tiene los parametros faltantes como opcionales
                                '-no está funcionando el IsNullable
                                'http://dev.mainsoft.com/Default.aspx?tabid=181 'cómo solucionar el asunto
                                'http://social.msdn.microsoft.com/Forums/en-SG/netfxbcl/thread/9e8b6101-50b4-47bc-84d8-ac5764bd0a5a
                                'http://social.msdn.microsoft.com/forums/en-US/transactsql/thread/900756fd-3980-48e3-ae59-a15d7fc15b4c/

                            Else
                                ErrHandler.WriteError("Me faltan parametros. " & Nombre & " esperaba " & .Parameters.Count - 1 & " y se le pasaron " & ParametrosQueLeQuieroMandarAsql.Length)
                                'y si me tiro el lance y llamo a los parametros faltantes con null?
                                'Throw New ApplicationException("Cantidad de parametros pasados invalidos. " & Nombre & " esperaba " & .Parameters.Count - 1 & " y se le pasaron " & Parametros.Length)
                            End If


                        Else
                            'ME SOBRAN parametros para mandar

                            'el sp tiene los parametros faltantes NO opcionales
                            ErrHandler.WriteError("Me sobran parametros. " & Nombre & " esperaba " & .Parameters.Count - 1 & " y se le pasaron " & ParametrosQueLeQuieroMandarAsql.Length)
                            Throw New ApplicationException("Cantidad de parametros pasados invalidos. " & Nombre & " esperaba " & .Parameters.Count - 1 & " y se le pasaron " & ParametrosQueLeQuieroMandarAsql.Length)
                        End If

                    Else


                    End If


                End With

                '////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////




                Dim i As Integer
                For i = 1 To StoreProcedureDeLaBase.Parameters.Count - 1 'ParametrosQueLeQuieroMandarAsql.Length - 1

                    If i - 1 < ParametrosQueLeQuieroMandarAsql.Length Then
                        StoreProcedureDeLaBase.Parameters(i).Value = ParametrosQueLeQuieroMandarAsql(i - 1)
                    Else
                        StoreProcedureDeLaBase.Parameters(i).Value = DBNull.Value
                    End If
                Next


                'Armo el DataAdapter
                StoreProcedureDeLaBase.CommandTimeout = 20
                Dim DA As New SqlDataAdapter(StoreProcedureDeLaBase)

                'Obtengo el DataSet
                DA.Fill(ds)

                'Devuelvo los parametros
                For i = 0 To ParametrosQueLeQuieroMandarAsql.Length - 1
                    ParametrosQueLeQuieroMandarAsql(i) = StoreProcedureDeLaBase.Parameters(i + 1).Value
                Next

            Catch ex As Exception
                'Throw ex
                'Debug.Print(ex.Message)
                ErrHandler.WriteError(ex)
                Throw New ApplicationException("Error en la ejecucion del SP: " + Nombre + " - " + ex.Message, ex)

            Finally
                If myConnection.State = ConnectionState.Open Then
                    myConnection.Close()
                End If
            End Try

            CorreccionNombresColumnaConPunto(ds)

            Return ds

        End Function


        Private Shared Sub CorreccionNombresColumnaConPunto(ByRef ds As DataSet)
            'reemplazo el dichoso punto usado en los nombres de columna (creo que siempre por motivos
            ' de presentacion)
            For Each c As DataColumn In ds.Tables(0).Columns
                c.ColumnName = Replace(c.ColumnName, ".", "_")
            Next
        End Sub



        Public Shared Function ExecDinamico(ByVal SC As String, ByVal comandoSQLdinamico As String) As DataTable


            Dim ds As New DataSet
            Dim myConnection = New SqlConnection(Encriptar(SC))

            Try
                Dim myCommand As SqlCommand
                myCommand = New SqlCommand(comandoSQLdinamico, myConnection)

                myCommand.CommandType = CommandType.Text
                myConnection.Open()
                Dim DA = New SqlDataAdapter(myCommand)
                DA.Fill(ds)


            Catch ex As Exception
                ErrHandler.WriteError(ex.Message)
                Throw New ApplicationException("Error en la ejecucion dinamica " + comandoSQLdinamico + " - " + ex.Message, ex)

                'Throw 'ex
                'Debug.Print(ex.Message)
                'Throw New ApplicationException("Error en la ejecucion", ex)

            Finally
                If myConnection.State = ConnectionState.Open Then
                    myConnection.Close()
                End If
            End Try

            If ds.Tables.Count <> 0 Then
                Return ds.Tables(0)
            Else
                Return Nothing
            End If

        End Function

    End Class

End Namespace
