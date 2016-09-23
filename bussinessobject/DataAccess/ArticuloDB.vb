Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO

Namespace Pronto.ERP.Dal

    Public Class ArticuloDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Articulo
            Dim myArticulo As Articulo = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wArticulos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdArticulo", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myArticulo = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myArticulo
        End Function

        Public Shared Function GetList(ByVal SC As String) As ArticuloList
            Dim tempList As ArticuloList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wArticulos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New ArticuloList
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
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wArticulos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdArticulo", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function GetArticulos(ByVal SC As String, ByVal codigo As String, ByVal description As String, ByVal idRubro As Integer) As ArticuloList
            Dim tempList As ArticuloList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("Articulos_C", myConnection) 'esta incluye los Inactivos
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@codigo", codigo)
                myCommand.Parameters.AddWithValue("@idRubro", idRubro)

                If description Is Nothing Then
                    myCommand.Parameters.AddWithValue("@Descripcion", "")
                Else
                    myCommand.Parameters.AddWithValue("@Descripcion", description)
                End If


                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New ArticuloList
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

        'Public Shared Function GetListParaWebService(ByVal SC As String, ByVal Busqueda As String) As ArticuloList
        '    Dim tempList As ArticuloList = Nothing
        '    Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
        '    Try
        '        Dim myCommand As SqlCommand = New SqlCommand("[wArticulos_TX_Busqueda]", myConnection)
        '        myCommand.CommandType = CommandType.StoredProcedure
        '        myCommand.Parameters.AddWithValue("@Busqueda", Busqueda)

        '        'myCommand.Parameters.AddWithValue("@idRubro", idRubro)
        '        'If description Is Nothing Then
        '        '    myCommand.Parameters.AddWithValue("@Descripcion", "")
        '        'Else
        '        '    myCommand.Parameters.AddWithValue("@Descripcion", description)
        '        'End If


        '        myConnection.Open()
        '        Dim myReader As SqlDataReader = myCommand.ExecuteReader
        '        Try
        '            If myReader.HasRows Then
        '                tempList = New ArticuloList
        '                While myReader.Read
        '                    tempList.Add(FillDataRecord(myReader))
        '                End While
        '            End If
        '            myReader.Close()
        '        Finally
        '            CType(myReader, IDisposable).Dispose()
        '        End Try
        '    Finally
        '        CType(myConnection, IDisposable).Dispose()
        '    End Try
        '    Return tempList
        'End Function

        Public Shared Function Save(ByVal SC As String, ByVal myArticulo As Articulo) As Integer




            'este cambia muy seguido como para usar el store de pronto......
            'este cambia muy seguido como para usar el store de pronto......
            'este cambia muy seguido como para usar el store de pronto......
            'este cambia muy seguido como para usar el store de pronto......
            'este cambia muy seguido como para usar el store de pronto......
            'este cambia muy seguido como para usar el store de pronto......


            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wArticulos_A", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                If myArticulo.Id = -1 Then
                    myCommand.Parameters.AddWithValue("@IdArticulo", DBNull.Value)
                Else
                    myCommand.Parameters.AddWithValue("@IdArticulo", myArticulo.Id)
                End If

                With myArticulo


                    NETtoSQL(myCommand, "@Codigo", .Codigo)
                    NETtoSQL(myCommand, "@NumeroInventario", .NumeroInventario)
                    NETtoSQL(myCommand, "@Descripcion", .Descripcion)
                    NETtoSQL(myCommand, "@IdRubro", .IdRubro)
                    NETtoSQL(myCommand, "@IdSubrubro", .IdSubrubro)
                    NETtoSQL(myCommand, "@IdUnidad", .IdUnidad)
                    NETtoSQL(myCommand, "@AlicuotaIVA", .AlicuotaIVA)
                    NETtoSQL(myCommand, "@CostoPPP", .CostoPPP)
                    NETtoSQL(myCommand, "@CostoPPPDolar", .CostoPPPDolar)


                    NETtoSQL(myCommand, "@CostoReposicion", .CostoReposicion)
                    NETtoSQL(myCommand, "@CostoReposicionDolar", .CostoReposicionDolar)
                    NETtoSQL(myCommand, "@Observaciones", .Observaciones)
                    NETtoSQL(myCommand, "@CostoPPPDolar", .CostoPPPDolar)
                    NETtoSQL(myCommand, "@AuxiliarString5", .AuxiliarString5)
                    NETtoSQL(myCommand, "@AuxiliarString6", .AuxiliarString6)
                    NETtoSQL(myCommand, "@AuxiliarString7", .AuxiliarString7)

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
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            ' Using
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("Articulos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdArticulo", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Catch e As Exception
                Return False
                'Delete = False
                'Throw
                'Finally
                '    Try
                '        'CType(myConnection, IDisposable).Dispose()
                '    Catch ex As Exception

                '    End Try
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Articulo
            Dim myArticulo As Articulo = New Articulo

            With myArticulo

                SQLtoNET(myDataRecord, "@IdArticulo", .Id)

                

                SQLtoNET(myDataRecord, "@Codigo", .Codigo)
                SQLtoNET(myDataRecord, "@NumeroInventario", .NumeroInventario)
                SQLtoNET(myDataRecord, "@Descripcion", .Descripcion)
                SQLtoNET(myDataRecord, "@IdRubro", .IdRubro)
                SQLtoNET(myDataRecord, "@IdSubrubro", .IdSubrubro)
                SQLtoNET(myDataRecord, "@IdUnidad", .IdUnidad)
                SQLtoNET(myDataRecord, "@AlicuotaIVA", .AlicuotaIVA)
                SQLtoNET(myDataRecord, "@CostoPPP", .CostoPPP)
                SQLtoNET(myDataRecord, "@CostoPPPDolar", .CostoPPPDolar)


                SQLtoNET(myDataRecord, "@CostoReposicion", .CostoReposicion)
                SQLtoNET(myDataRecord, "@CostoReposicionDolar", .CostoReposicionDolar)
                SQLtoNET(myDataRecord, "@Observaciones", .Observaciones)
                SQLtoNET(myDataRecord, "@CostoPPPDolar", .CostoPPPDolar)
                SQLtoNET(myDataRecord, "@AuxiliarString5", .AuxiliarString5)
                SQLtoNET(myDataRecord, "@AuxiliarString6", .AuxiliarString6)
                SQLtoNET(myDataRecord, "@AuxiliarString7", .AuxiliarString7)

            End With

            Return myArticulo
        End Function



    End Class

End Namespace