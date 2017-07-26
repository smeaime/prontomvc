Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class AsientoDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Asiento
            Dim myAsiento As Asiento = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try


                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.Asientos_T.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdAsiento", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myAsiento = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myAsiento
        End Function

        Public Shared Function GetList(ByVal SC As String) As AsientoList
            Dim tempList As AsientoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.Asientos_T.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New AsientoList
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

        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String) As AsientoList

            Dim tempList As AsientoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wAsientos_T_ByEmployee", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdSolicito", IdSolicito)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New AsientoList
                        While myReader.Read
                            'tempList.Add(FillDataRecord(myReader))
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

        Public Shared Function GetCountRequemientoForEmployee(ByVal SC As String, ByVal IdEmpleado As Integer) As Integer
            Dim result As Integer = 0
            Dim tempList As AsientoList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("GetCountRequemientoForEmployee", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdSolicito", IdEmpleado)

                Dim returnValue As DbParameter
                returnValue = myCommand.CreateParameter
                returnValue.Direction = ParameterDirection.ReturnValue
                myCommand.Parameters.Add(returnValue)
                myConnection.Open()
                myCommand.ExecuteNonQuery()
                result = Convert.ToInt32(returnValue.Value)
                myConnection.Close()
            Catch ex As Exception
                Throw New System.Exception(SC)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result
        End Function

        Public Shared Function GetList_fm(ByVal SC As String) As DataSet 'supongo que con esta, Edu solo quería traerse la metadata, el recordset vacío.
            Dim ds As New DataSet()
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wAsientos_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdAsiento", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myAsiento As Asiento) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand
                With myAsiento


                    If .Id = -1 Then

                        myCommand = New SqlCommand(enumSPs.Asientos_A.ToString, myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdAsiento", -1)
                        param.Direction = ParameterDirection.Output

                    Else

                        myCommand = New SqlCommand(enumSPs.Asientos_M.ToString, myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        myCommand.Parameters.AddWithValue("@IdAsiento", .Id)
                    End If


                    'NETtoSQL(myCommand, "@IdCliente", .IdCliente)






                    NETtoSQL(myCommand, "@NumeroAsiento", .NumeroAsiento)
                    NETtoSQL(myCommand, "@FechaAsiento", .FechaAsiento)
                    NETtoSQL(myCommand, "@Ejercicio", .Ejercicio)
                    NETtoSQL(myCommand, "@IdCuentaSubdiario", .IdCuentaSubdiario)
                    NETtoSQL(myCommand, "@Concepto", .Concepto)
                    NETtoSQL(myCommand, "@Tipo", .Tipo)
                    NETtoSQL(myCommand, "@IdIngreso", .IdIngreso)
                    NETtoSQL(myCommand, "@FechaIngreso", .FechaIngreso)
                    NETtoSQL(myCommand, "@IdModifico", .IdModifico)
                    NETtoSQL(myCommand, "@FechaUltimaModificacion", .FechaUltimaModificacion)
                    NETtoSQL(myCommand, "@AsientoApertura", .AsientoApertura)
                    NETtoSQL(myCommand, "@BaseConsolidadaHija", .BaseConsolidadaHija)
                    NETtoSQL(myCommand, "@FechaGeneracionConsolidado", .FechaGeneracionConsolidado)
                    NETtoSQL(myCommand, "@ArchivoImportacion", .ArchivoImportacion)
                    NETtoSQL(myCommand, "@AsignarAPresupuestoObra", .AsignarAPresupuestoObra)





                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    For Each myAsientoItem As AsientoItem In myAsiento.Detalles
                        myAsientoItem.IdAsiento = result




                        If myAsientoItem.Eliminado Then
                            'EntidadManager.GetStoreProcedure(SC, "DetAsientos_E", .Id)
                        Else
                            Dim IdAntesDeGrabar = myAsientoItem.Id
                            myAsientoItem.Id = AsientoItemDB.Save(SC, myAsientoItem)


                            'Como un item nuevo consiguió un nuevo id al grabarse, 
                            'lo tengo que refrescar en el resto de las colecciones
                            'de imputacion (en el prontovb6, se usaba -100,-101,etc)
                            '-OK, eso si los items del resto de las colecciones (Valores,Cuentas)
                            'estuviesen imputadas contra la de Imputaciones. Pero, de donde demonios saqué
                            'que esto es así?

                            'For Each o As AsientoAnticiposAlPersonalItem In .DetallesAnticiposAlPersonal
                            '    If o. = IdAntesDeGrabar Then
                            '        o. = myAsientoItem.Id
                            '    End If
                            'Next

                            'For Each o As AsientoCuentasItem In .DetallesCuentas
                            '    If o. = IdAntesDeGrabar Then
                            '        o. = myAsientoItem.Id
                            '    End If
                            'Next
                        End If
                    Next


                    ''//////////////////////////////////////////////////////////////////////////////////////
                    'Colecciones adicionales
                    ''//////////////////////////////////////////////////////////////////////////////////////

                    For Each myAsientoAnticiposAlPersonalItem As AsientoAnticiposItem In myAsiento.DetallesAnticipos
                        myAsientoAnticiposAlPersonalItem.IdAsiento = result
                        AsientoAnticipoItemDB.Save(SC, myAsientoAnticiposAlPersonalItem)
                    Next

                    'For Each myAsientoCuentasItem As AsientoCuentasItem In myAsiento.DetallesCuentas
                    '    myAsientoCuentasItem.IdAsiento = result
                    '    AsientoCuentasItemDB.Save(SC, myAsientoCuentasItem)
                    'Next
                    'For Each myAsientoValoresItem As AsientoValoresItem In myAsiento.DetallesValores
                    '    myAsientoValoresItem.IdAsiento = result
                    '    AsientoValoresItemDB.Save(SC, myAsientoValoresItem)
                    'Next

                    'For Each myAsientoRubrosContablesItem As AsientoRubrosContablesItem In myAsiento.DetallesRubrosContables
                    '    myAsientoRubrosContablesItem.IdAsiento = result
                    '    AsientoRubrosContablesItemDB.Save(SC, myAsientoRubrosContablesItem)
                    'Next

                    'For Each myAsientoImpuestosItem As AsientoImpuestosItem In myAsiento.DetallesImpuestos
                    '    myAsientoImpuestosItem.IdAsiento = result
                    '    AsientoImpuestosItemDB.Save(SC, myAsientoImpuestosItem)
                    'Next



                End With
                Transaccion.Commit()
                myConnection.Close()
            Catch e As Exception
                Transaccion.Rollback()
                ErrHandler.WriteAndRaiseError(e)
                'Return -1 'qué conviene usar? disparar errores o devolver -1?
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wAsientos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdAsiento", id)
                myConnection.Open()

                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Public Shared Function Anular(ByVal SC As String, ByVal IdAsiento As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wAsientos_N", myConnection)
                myCommand.Transaction = Transaccion
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdAsiento", IdAsiento)
                result = myCommand.ExecuteNonQuery
                Transaccion.Commit()
                myConnection.Close()
            Catch e As Exception
                Transaccion.Rollback()
                ErrHandler.WriteAndRaiseError(e)
                'Return -1 'qué conviene usar? disparar errores o devolver -1?
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Asiento
            Dim myAsiento As Asiento = New Asiento
            With myAsiento


                SQLtoNET(myDataRecord, "@IdAsiento", .Id)

                SQLtoNET(myDataRecord, "@NumeroAsiento", .NumeroAsiento)
                SQLtoNET(myDataRecord, "@FechaAsiento", .FechaAsiento)
                SQLtoNET(myDataRecord, "@Ejercicio", .Ejercicio)
                SQLtoNET(myDataRecord, "@IdCuentaSubdiario", .IdCuentaSubdiario)
                SQLtoNET(myDataRecord, "@Concepto", .Concepto)
                SQLtoNET(myDataRecord, "@Tipo", .Tipo)
                SQLtoNET(myDataRecord, "@IdIngreso", .IdIngreso)
                SQLtoNET(myDataRecord, "@FechaIngreso", .FechaIngreso)
                SQLtoNET(myDataRecord, "@IdModifico", .IdModifico)
                SQLtoNET(myDataRecord, "@FechaUltimaModificacion", .FechaUltimaModificacion)
                SQLtoNET(myDataRecord, "@AsientoApertura", .AsientoApertura)
                SQLtoNET(myDataRecord, "@BaseConsolidadaHija", .BaseConsolidadaHija)
                SQLtoNET(myDataRecord, "@FechaGeneracionConsolidado", .FechaGeneracionConsolidado)
                SQLtoNET(myDataRecord, "@ArchivoImportacion", .ArchivoImportacion)
                SQLtoNET(myDataRecord, "@AsignarAPresupuestoObra", .AsignarAPresupuestoObra)




                Return myAsiento
            End With
        End Function
    End Class
End Namespace