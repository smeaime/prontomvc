Imports System.Diagnostics.Debug
Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class CartaDePorteDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As CartaDePorte
            Dim myCartaDePorte As CartaDePorte = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wCartasDePorte_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdCartaDePorte", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myCartaDePorte = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try



                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////
                ''como estoy metiendo campos por afuera de los sp en el Save(), tengo que traerlos acá de la misma manera
                'Dim dt As DataTable = GeneralDB.ExecDinamico(SC, "select * from CartasDePorte WHERE idCartaDePorte=" & id)
                'With myCartaDePorte
                '    .HumedadDesnormalizada = iisNull(dt.Rows(0).Item("HumedadDesnormalizada"), 0)
                '    .Factor = iisNull(dt.Rows(0).Item("Factor"), 0)
                '    .PuntoVenta = iisNull(dt.Rows(0).Item("PuntoVenta"), 0)
                '    .SubnumeroVagon = iisNull(dt.Rows(0).Item("SubnumeroVagon"), 0)

                '    .SubnumeroVagon = iisNull(dt.Rows(0).Item("SubnumeroVagon"), 0)

                '    .TarifaCobradaAlCliente = iisNull(dt.Rows(0).Item("TarifaFacturada"), 0)
                '    .TarifaSubcontratista1 = iisNull(dt.Rows(0).Item("TarifaSubcontratista1"), 0)
                '    .TarifaSubcontratista2 = iisNull(dt.Rows(0).Item("TarifaSubcontratista2"), 0)

                '    .FechaArribo = iisValidSqlDate(dt.Rows(0).Item("FechaArribo"))
                '    .motivoanulacion = iisNull(dt.Rows(0).Item("MotivoAnulacion"), 0)
                'End With

                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////




                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myCartaDePorte
        End Function


        Public Shared Function GetList(ByVal SC As String) As CartaDePorteList
            Dim tempList As CartaDePorteList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wCartasDePorte_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New CartaDePorteList
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

        'GetList filtrado
        Public Shared Function GetList_FondosFijos(ByVal SC As String, ByVal IdObra As Integer) As CartaDePorteList
            Dim tempList As CartaDePorteList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wCartasDePorte_TX_FondosFijos", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdObra", IdObra)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New CartaDePorteList
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
                Dim myCommand As SqlCommand = New SqlCommand("wCartasDePorte_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdCartaDePorte", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myCartaDePorte As CartaDePorte) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            With myCartaDePorte
                Try
                    Dim myCommand As SqlCommand = New SqlCommand("wCartasDePorte_A", myConnection)
                    myCommand.Transaction = Transaccion
                    myCommand.CommandType = CommandType.StoredProcedure

                    '///////////////////////////////////////////////////////////////////////
                    'A partir de acá pegás el codigo generado
                    '///////////////////////////////////////////////////////////////////////



                    myCommand.Parameters.AddWithValue("@IdCartaDePorte", IIf(myCartaDePorte.Id = 0, System.DBNull.Value, myCartaDePorte.Id))
                    myCommand.Parameters.AddWithValue("@NumeroCartaDePorte", myCartaDePorte.NumeroCartaDePorte)
                    myCommand.Parameters.AddWithValue("@SubnumeroVagon", myCartaDePorte.SubnumeroVagon)
                    myCommand.Parameters.AddWithValue("@IdUsuarioIngreso", myCartaDePorte.IdUsuarioIngreso)
                    If myCartaDePorte.FechaIngreso = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaIngreso", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaIngreso", myCartaDePorte.FechaIngreso)
                    End If
                    myCommand.Parameters.AddWithValue("@Anulada", myCartaDePorte.Anulada)
                    myCommand.Parameters.AddWithValue("@IdUsuarioAnulo", IdNull(myCartaDePorte.IdUsuarioAnulo))
                    If myCartaDePorte.FechaAnulacion = DateTime.MinValue Then
                        myCommand.Parameters.AddWithValue("@FechaAnulacion", System.DBNull.Value)
                    Else
                        myCommand.Parameters.AddWithValue("@FechaAnulacion", myCartaDePorte.FechaAnulacion)
                    End If

                    myCommand.Parameters.AddWithValue("@Observaciones", myCartaDePorte.Observaciones)
                    myCommand.Parameters.AddWithValue("@FechaTimeStamp", .FechaTimeStamp)
                    myCommand.Parameters.AddWithValue("@Vendedor", IdNull(myCartaDePorte.Titular))
                    myCommand.Parameters.AddWithValue("@CuentaOrden1", IdNull(myCartaDePorte.CuentaOrden1))
                    myCommand.Parameters.AddWithValue("@CuentaOrden2", IdNull(myCartaDePorte.CuentaOrden2))
                    myCommand.Parameters.AddWithValue("@Corredor", IdNull(myCartaDePorte.Corredor))
                    myCommand.Parameters.AddWithValue("@Entregador", IdNull(myCartaDePorte.Entregador))
                    myCommand.Parameters.AddWithValue("@Procedencia", myCartaDePorte.Procedencia)
                    myCommand.Parameters.AddWithValue("@Patente", myCartaDePorte.Patente)
                    myCommand.Parameters.AddWithValue("@IdArticulo", IdNull(myCartaDePorte.IdArticulo))
                    myCommand.Parameters.AddWithValue("@IdStock", IdNull(myCartaDePorte.IdStock))
                    myCommand.Parameters.AddWithValue("@Partida", myCartaDePorte.Partida)
                    myCommand.Parameters.AddWithValue("@IdUnidad", IdNull(myCartaDePorte.IdUnidad))
                    myCommand.Parameters.AddWithValue("@IdUbicacion", IdNull(myCartaDePorte.IdUbicacion))
                    myCommand.Parameters.AddWithValue("@Cantidad", myCartaDePorte.Cantidad)
                    myCommand.Parameters.AddWithValue("@Cupo", myCartaDePorte.Cupo)
                    myCommand.Parameters.AddWithValue("@NetoProc", myCartaDePorte.NetoFinalSinMermas)
                    myCommand.Parameters.AddWithValue("@Calidad", "") 'OBSOLETO myCartaDePorte.Calidad)
                    myCommand.Parameters.AddWithValue("@BrutoPto", myCartaDePorte.BrutoPto)
                    myCommand.Parameters.AddWithValue("@TaraPto", myCartaDePorte.TaraPto)
                    myCommand.Parameters.AddWithValue("@NetoPto", myCartaDePorte.NetoPto)
                    myCommand.Parameters.AddWithValue("@Acoplado", myCartaDePorte.Acoplado)
                    myCommand.Parameters.AddWithValue("@Humedad", myCartaDePorte.Humedad)
                    myCommand.Parameters.AddWithValue("@Merma", myCartaDePorte.Merma)
                    myCommand.Parameters.AddWithValue("@NetoFinal", myCartaDePorte.NetoFinalIncluyendoMermas)
                    myCommand.Parameters.AddWithValue("@FechaDeCarga", fechaNETtoSQL(myCartaDePorte.FechaDeCarga, System.DBNull.Value))
                    myCommand.Parameters.AddWithValue("@FechaVencimiento", fechaNETtoSQL(myCartaDePorte.FechaVencimiento, System.DBNull.Value))
                    myCommand.Parameters.AddWithValue("@CEE", myCartaDePorte.CEE)
                    myCommand.Parameters.AddWithValue("@IdTransportista", IdNull(myCartaDePorte.IdTransportista))
                    myCommand.Parameters.AddWithValue("@TransportistaCUIT", myCartaDePorte.TransportistaCUIT)
                    myCommand.Parameters.AddWithValue("@IdChofer", IdNull(myCartaDePorte.IdChofer))
                    myCommand.Parameters.AddWithValue("@ChoferCUIT", myCartaDePorte.ChoferCUIT)


                    myCommand.Parameters.AddWithValue("@CTG", myCartaDePorte.CTG)
                    myCommand.Parameters.AddWithValue("@Contrato", iisNull(myCartaDePorte.Contrato))
                    myCommand.Parameters.AddWithValue("@Destino", IdNull(myCartaDePorte.Destino))
                    myCommand.Parameters.AddWithValue("@Subcontr1", IdNull(myCartaDePorte.Subcontr1))
                    myCommand.Parameters.AddWithValue("@Subcontr2", IdNull(myCartaDePorte.Subcontr2))
                    myCommand.Parameters.AddWithValue("@Contrato1", myCartaDePorte.Contrato1)
                    myCommand.Parameters.AddWithValue("@contrato2", myCartaDePorte.contrato2)

                    myCommand.Parameters.AddWithValue("@Cosecha", iisNull(myCartaDePorte.Cosecha))


                    myCommand.Parameters.AddWithValue("@KmARecorrer", myCartaDePorte.KmARecorrer)
                    myCommand.Parameters.AddWithValue("@Tarifa", myCartaDePorte.TarifaTransportista)
                    myCommand.Parameters.AddWithValue("@FechaDescarga", fechaNETtoSQL(myCartaDePorte.FechaDescarga, System.DBNull.Value))
                    myCommand.Parameters.AddWithValue("@Hora", iisValidSqlDate(myCartaDePorte.Hora, System.DBNull.Value))
                    myCommand.Parameters.AddWithValue("@NRecibo", myCartaDePorte.NRecibo)
                    myCommand.Parameters.AddWithValue("@CalidadDe", IdNull(myCartaDePorte.CalidadDe))
                    myCommand.Parameters.AddWithValue("@TaraFinal", myCartaDePorte.TaraFinal)
                    myCommand.Parameters.AddWithValue("@BrutoFinal", myCartaDePorte.BrutoFinal)
                    myCommand.Parameters.AddWithValue("@Fumigada", myCartaDePorte.Fumigada)

                    myCommand.Parameters.AddWithValue("@Secada", myCartaDePorte.Secada)
                    myCommand.Parameters.AddWithValue("@Exporta", IIf(myCartaDePorte.Exporta, "SI", "NO"))

                    myCommand.Parameters.AddWithValue("@NobleExtranos", myCartaDePorte.NobleExtranos)
                    myCommand.Parameters.AddWithValue("@NobleNegros", myCartaDePorte.NobleNegros)
                    myCommand.Parameters.AddWithValue("@NobleQuebrados", myCartaDePorte.NobleQuebrados)
                    myCommand.Parameters.AddWithValue("@NobleDaniados", myCartaDePorte.NobleDaniados)
                    myCommand.Parameters.AddWithValue("@NobleChamico", myCartaDePorte.NobleChamico)
                    myCommand.Parameters.AddWithValue("@NobleChamico2", myCartaDePorte.NobleChamico2)
                    myCommand.Parameters.AddWithValue("@NobleRevolcado", myCartaDePorte.NobleRevolcado)
                    myCommand.Parameters.AddWithValue("@NobleObjetables", myCartaDePorte.NobleObjetables)
                    myCommand.Parameters.AddWithValue("@NobleAmohosados", myCartaDePorte.NobleAmohosados)
                    myCommand.Parameters.AddWithValue("@NobleHectolitrico", myCartaDePorte.NobleHectolitrico)
                    myCommand.Parameters.AddWithValue("@NobleCarbon", myCartaDePorte.NobleCarbon)
                    myCommand.Parameters.AddWithValue("@NoblePanzaBlanca", myCartaDePorte.NoblePanzaBlanca)
                    myCommand.Parameters.AddWithValue("@NoblePicados", myCartaDePorte.NoblePicados)
                    myCommand.Parameters.AddWithValue("@NobleMGrasa", myCartaDePorte.NobleMGrasa)
                    myCommand.Parameters.AddWithValue("@NobleAcidezGrasa", myCartaDePorte.NobleAcidezGrasa)
                    myCommand.Parameters.AddWithValue("@NobleVerdes", myCartaDePorte.NobleVerdes)
                    myCommand.Parameters.AddWithValue("@NobleGrado", myCartaDePorte.NobleGrado)
                    myCommand.Parameters.AddWithValue("@NobleConforme", myCartaDePorte.NobleConforme)
                    myCommand.Parameters.AddWithValue("@NobleACamara", myCartaDePorte.NobleACamara)


                    myCommand.Parameters.AddWithValue("@IdFacturaImputada", myCartaDePorte.IdFacturaImputada)





                    NETtoSQL(myCommand, "@HumedadDesnormalizada", .HumedadDesnormalizada)
                    NETtoSQL(myCommand, "@Factor", .Factor)
                    NETtoSQL(myCommand, "@PuntoVenta", .PuntoVenta)
                    NETtoSQL(myCommand, "@TarifaFacturada", .TarifaCobradaAlCliente)
                    NETtoSQL(myCommand, "@TarifaSubcontratista1", .TarifaSubcontratista1)
                    NETtoSQL(myCommand, "@TarifaSubcontratista2", .TarifaSubcontratista2)
                    NETtoSQL(myCommand, "@FechaArribo", .FechaArribo)
                    NETtoSQL(myCommand, "@MotivoAnulacion", .MotivoAnulacion)

                    NETtoSQL(myCommand, "@Corredor2", .Corredor2)



                    NETtoSQL(myCommand, "@NumeroSubfijo", .NumeroSubfijo)
                    NETtoSQL(myCommand, "@IdEstablecimiento", .IdEstablecimiento)
                    NETtoSQL(myCommand, "@EnumSyngentaDivision", .EnumSyngentaDivision)

                    NETtoSQL(myCommand, "@IdUsuarioModifico", .IdUsuarioModifico)
                    NETtoSQL(myCommand, "@FechaModificacion", .FechaModificacion)
                    NETtoSQL(myCommand, "@FechaEmision", .FechaEmision)

                    NETtoSQL(myCommand, "@ExcluirDeSubcontratistas", IIf(.ExcluirDeSubcontratistas, "SI", "NO"))
                    NETtoSQL(myCommand, "@IdTipoMovimiento", .IdTipoMovimiento)

                    NETtoSQL(myCommand, "@AgregaItemDeGastosAdministrativos", IIf(.AgregaItemDeGastosAdministrativos, "SI", "NO"))


                    NETtoSQL(myCommand, "@IdClienteAFacturarle", .IdClienteAFacturarle)
                    NETtoSQL(myCommand, "@SubnumeroDeFacturacion", .SubnumeroDeFacturacion)




                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    'For Each Item As CartaDePorteItem In .Detalles
                    '    Item.IdCartaDePorte = result
                    '    CartaDePorteItemDB.Save(SC, Item)
                    'Next



                    Transaccion.Commit()
                    myConnection.Close()




                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////
                    'hasta que no se definan los campos adicionales, los agrego por acá

                    'Dim comandoSQLdinamico As String = String.Format("UPDATE CartasDePorte SET " & _
                    '                    "HumedadDesnormalizada={1}, " & _
                    '                    "Factor={2},  " & _
                    '                    "PuntoVenta={3}, " & _
                    '                    "SubnumeroVagon={4}, " & _
                    '                    "TarifaFacturada={5}, " & _
                    '                    "TarifaSubcontratista1={6}, " & _
                    '                    "TarifaSubcontratista2={7}, " & _
                    '                    "FechaArribo='{8}', " & _
                    '                    "MotivoAnulacion='{9}' " & _
                    '                        "WHERE IdCartaDePorte={0} ", result, DecimalToString(myCartaDePorte.HumedadDesnormalizada), DecimalToString(myCartaDePorte.Factor), myCartaDePorte.PuntoVenta, myCartaDePorte.SubnumeroVagon, DecimalToString(.TarifaCobradaAlCliente), DecimalToString(.TarifaSubcontratista1), DecimalToString(.TarifaSubcontratista2), FechaANSI(iisValidSqlDate(.FechaArribo, Today)), .MotivoAnulacion)


                    ''myCommand = New SqlCommand(comandoSQLdinamico, myConnection)
                    ''myCommand.Transaction = Transaccion
                    ''myCommand.CommandType = CommandType.Text
                    ''myCommand.ExecuteNonQuery()

                    'GeneralDB.ExecDinamico(SC, comandoSQLdinamico)

                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////



                Catch e As Exception
                    Transaccion.Rollback()
                    'Debug.Print(e.Message)
                    Pronto.ERP.Bll.ErrHandler2.WriteError(e)
                    Throw New ApplicationException("Error en la grabacion " + e.Message, e)
                Finally
                    CType(myConnection, IDisposable).Dispose()
                End Try
            End With
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wCartasDePorte_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdCartaDePorte", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As CartaDePorte
            Dim myCartaDePorte As CartaDePorte = New CartaDePorte

            Try
                With myCartaDePorte

                    myCartaDePorte.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdCartaDePorte"))

                    '///////////////////////////////////////////////////////////////////////
                    'A partir de acá pegás el codigo generado
                    '///////////////////////////////////////////////////////////////////////

                    myCartaDePorte.NumeroCartaDePorte = myDataRecord.GetInt64(myDataRecord.GetOrdinal("NumeroCartaDePorte"))

                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdUsuarioIngreso")) Then
                        myCartaDePorte.IdUsuarioIngreso = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdUsuarioIngreso"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaIngreso")) Then
                        myCartaDePorte.FechaIngreso = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaIngreso"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Anulada")) Then
                        myCartaDePorte.Anulada = myDataRecord.GetString(myDataRecord.GetOrdinal("Anulada"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdUsuarioAnulo")) Then
                        myCartaDePorte.IdUsuarioAnulo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdUsuarioAnulo"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAnulacion")) Then
                        myCartaDePorte.FechaAnulacion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAnulacion"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Observaciones")) Then
                        myCartaDePorte.Observaciones = myDataRecord.GetString(myDataRecord.GetOrdinal("Observaciones"))
                    End If

                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaTimeStamp")) Then
                        myCartaDePorte.FechaTimeStamp = BitConverter.ToInt64(myDataRecord.GetValue(myDataRecord.GetOrdinal("FechaTimeStamp")), 0)
                    End If

                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Vendedor")) Then
                        myCartaDePorte.Titular = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Vendedor"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CuentaOrden1")) Then
                        myCartaDePorte.CuentaOrden1 = myDataRecord.GetInt32(myDataRecord.GetOrdinal("CuentaOrden1"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CuentaOrden2")) Then
                        myCartaDePorte.CuentaOrden2 = myDataRecord.GetInt32(myDataRecord.GetOrdinal("CuentaOrden2"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Corredor")) Then
                        myCartaDePorte.Corredor = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Corredor"))
                    End If

                    Try
                        If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Procedencia")) Then
                            myCartaDePorte.Procedencia = Val(myDataRecord.GetString(myDataRecord.GetOrdinal("Procedencia")))
                        End If
                    Catch ex As Exception
                        myCartaDePorte.Procedencia = 0
                    End Try


                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Patente")) Then
                        myCartaDePorte.Patente = myDataRecord.GetString(myDataRecord.GetOrdinal("Patente"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdArticulo")) Then
                        myCartaDePorte.IdArticulo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdArticulo"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdStock")) Then
                        myCartaDePorte.IdStock = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdStock"))
                    End If

                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Partida")) Then
                        myCartaDePorte.Partida = myDataRecord.GetString(myDataRecord.GetOrdinal("Partida"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdUnidad")) Then
                        myCartaDePorte.IdUnidad = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdUnidad"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdUbicacion")) Then
                        myCartaDePorte.IdUbicacion = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdUbicacion"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cantidad")) Then
                        myCartaDePorte.Cantidad = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Cantidad"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cupo")) Then
                        myCartaDePorte.Cupo = myDataRecord.GetString(myDataRecord.GetOrdinal("Cupo"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NetoProc")) Then
                        myCartaDePorte.NetoFinalSinMermas = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NetoProc"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Calidad")) Then
                        'myCartaDePorte.Calidad = "" 'OBSOLETO myDataRecord.GetString(myDataRecord.GetOrdinal("Calidad"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("BrutoPto")) Then
                        myCartaDePorte.BrutoPto = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("BrutoPto"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("TaraPto")) Then
                        myCartaDePorte.TaraPto = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("TaraPto"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NetoPto")) Then
                        myCartaDePorte.NetoPto = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NetoPto"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Acoplado")) Then
                        myCartaDePorte.Acoplado = myDataRecord.GetString(myDataRecord.GetOrdinal("Acoplado"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Humedad")) Then
                        myCartaDePorte.Humedad = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Humedad"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Merma")) Then
                        myCartaDePorte.Merma = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Merma"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NetoFinal")) Then
                        myCartaDePorte.NetoFinalIncluyendoMermas = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NetoFinal"))
                    End If

                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaDeCarga")) Then
                        myCartaDePorte.FechaDeCarga = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaDeCarga"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaVencimiento")) Then
                        myCartaDePorte.FechaVencimiento = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaVencimiento"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CEE")) Then
                        myCartaDePorte.CEE = myDataRecord.GetString(myDataRecord.GetOrdinal("CEE"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CTG")) Then
                        myCartaDePorte.CTG = myDataRecord.GetInt32(myDataRecord.GetOrdinal("CTG"))
                    End If

                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdTransportista")) Then
                        myCartaDePorte.IdTransportista = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdTransportista"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdChofer")) Then
                        myCartaDePorte.IdChofer = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdChofer"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("TransportistaCUITdesnormalizado")) Then
                        myCartaDePorte.TransportistaCUIT = myDataRecord.GetString(myDataRecord.GetOrdinal("TransportistaCUITdesnormalizado"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ChoferCUITdesnormalizado")) Then
                        myCartaDePorte.ChoferCUIT = myDataRecord.GetString(myDataRecord.GetOrdinal("ChoferCUITdesnormalizado"))
                    End If




                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Entregador")) Then
                        myCartaDePorte.Entregador = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Entregador"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Contrato")) Then
                        myCartaDePorte.Contrato = myDataRecord.GetString(myDataRecord.GetOrdinal("Contrato"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Destino")) Then
                        myCartaDePorte.Destino = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Destino"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Subcontr1")) Then
                        myCartaDePorte.Subcontr1 = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Subcontr1"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Subcontr2")) Then
                        myCartaDePorte.Subcontr2 = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Subcontr2"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Contrato1")) Then
                        myCartaDePorte.Contrato1 = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Contrato1"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Contrato2")) Then
                        myCartaDePorte.Contrato2 = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Contrato2"))
                    End If

                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cosecha")) Then
                        myCartaDePorte.Cosecha = myDataRecord.GetString(myDataRecord.GetOrdinal("Cosecha"))
                    End If



                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("KmARecorrer")) Then
                        myCartaDePorte.KmARecorrer = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("KmARecorrer"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Tarifa")) Then
                        myCartaDePorte.TarifaTransportista = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Tarifa"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaDescarga")) Then
                        myCartaDePorte.FechaDescarga = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaDescarga"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Hora")) Then
                        myCartaDePorte.Hora = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("Hora"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NRecibo")) Then
                        myCartaDePorte.NRecibo = myDataRecord.GetString(myDataRecord.GetOrdinal("NRecibo"))
                        'myCartaDePorte.NRecibo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NRecibo"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CalidadDe")) Then
                        myCartaDePorte.CalidadDe = myDataRecord.GetInt32(myDataRecord.GetOrdinal("CalidadDe"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("TaraFinal")) Then
                        myCartaDePorte.TaraFinal = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("TaraFinal"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("BrutoFinal")) Then
                        myCartaDePorte.BrutoFinal = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("BrutoFinal"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Fumigada")) Then
                        myCartaDePorte.Fumigada = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Fumigada"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Secada")) Then
                        myCartaDePorte.Secada = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Secada"))
                    End If

                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Exporta")) Then
                        myCartaDePorte.Exporta = (myDataRecord.GetString(myDataRecord.GetOrdinal("Exporta")) = "SI")
                    End If

                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleExtranos")) Then
                        myCartaDePorte.NobleExtranos = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NobleExtranos"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleNegros")) Then
                        myCartaDePorte.NobleNegros = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NobleNegros"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleQuebrados")) Then
                        myCartaDePorte.NobleQuebrados = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NobleQuebrados"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleDaniados")) Then
                        myCartaDePorte.NobleDaniados = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NobleDaniados"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleChamico")) Then
                        myCartaDePorte.NobleChamico = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NobleChamico"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleChamico2")) Then
                        myCartaDePorte.NobleChamico2 = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NobleChamico2"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleRevolcado")) Then
                        myCartaDePorte.NobleRevolcado = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NobleRevolcado"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleObjetables")) Then
                        myCartaDePorte.NobleObjetables = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NobleObjetables"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleAmohosados")) Then
                        myCartaDePorte.NobleAmohosados = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NobleAmohosados"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleHectolitrico")) Then
                        myCartaDePorte.NobleHectolitrico = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NobleHectolitrico"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NoblePanzaBlanca")) Then
                        myCartaDePorte.NoblePanzaBlanca = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NoblePanzaBlanca"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NoblePicados")) Then
                        myCartaDePorte.NoblePicados = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NoblePicados"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleMGrasa")) Then
                        myCartaDePorte.NobleMGrasa = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NobleMGrasa"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleCarbon")) Then
                        myCartaDePorte.NobleCarbon = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NobleCarbon"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleAcidezGrasa")) Then
                        myCartaDePorte.NobleAcidezGrasa = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NobleAcidezGrasa"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleVerdes")) Then
                        myCartaDePorte.NobleVerdes = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("NobleVerdes"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleGrado")) Then
                        myCartaDePorte.NobleGrado = myDataRecord.GetInt32(myDataRecord.GetOrdinal("NobleGrado"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleConforme")) Then
                        myCartaDePorte.NobleConforme = myDataRecord.GetString(myDataRecord.GetOrdinal("NobleConforme"))
                    End If
                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NobleACamara")) Then
                        myCartaDePorte.NobleACamara = myDataRecord.GetString(myDataRecord.GetOrdinal("NobleACamara"))
                    End If

                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdFacturaImputada")) Then
                        myCartaDePorte.IdFacturaImputada = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdFacturaImputada"))
                    End If

                    
                    SQLtoNET(myDataRecord, "@HumedadDesnormalizada", .HumedadDesnormalizada)
                    SQLtoNET(myDataRecord, "@Factor", .Factor)
                    SQLtoNET(myDataRecord, "@PuntoVenta", .PuntoVenta)
                    SQLtoNET(myDataRecord, "@SubnumeroVagon", .SubnumeroVagon)
                    SQLtoNET(myDataRecord, "@TarifaFacturada", .TarifaCobradaAlCliente)
                    SQLtoNET(myDataRecord, "@TarifaSubcontratista1", .TarifaSubcontratista1)
                    SQLtoNET(myDataRecord, "@TarifaSubcontratista2", .TarifaSubcontratista2)
                    SQLtoNET(myDataRecord, "@FechaArribo", .FechaArribo)
                    SQLtoNET(myDataRecord, "@MotivoAnulacion", .MotivoAnulacion)

                    SQLtoNET(myDataRecord, "@Corredor2", .Corredor2)

                    SQLtoNET(myDataRecord, "@NumeroSubfijo", .NumeroSubfijo)
                    SQLtoNET(myDataRecord, "@IdEstablecimiento", .IdEstablecimiento)
                    SQLtoNET(myDataRecord, "@EnumSyngentaDivision", .EnumSyngentaDivision)


                    SQLtoNET(myDataRecord, "@IdUsuarioModifico", .IdUsuarioModifico)
                    SQLtoNET(myDataRecord, "@FechaModificacion", .FechaModificacion)
                    SQLtoNET(myDataRecord, "@FechaEmision", .FechaEmision)

                    SQLtoNET(myDataRecord, "@IdTipoMovimiento", .IdTipoMovimiento)


                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ExcluirDeSubcontratistas")) Then
                        .ExcluirDeSubcontratistas = (myDataRecord.GetString(myDataRecord.GetOrdinal("ExcluirDeSubcontratistas")) = "SI")
                    End If


                    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("AgregaItemDeGastosAdministrativos")) Then
                        .AgregaItemDeGastosAdministrativos = (myDataRecord.GetString(myDataRecord.GetOrdinal("AgregaItemDeGastosAdministrativos")) = "SI")
                    End If


                    SQLtoNET(myDataRecord, "@IdClienteAFacturarle", .IdClienteAFacturarle)
                    SQLtoNET(myDataRecord, "@SubnumeroDeFacturacion", .SubnumeroDeFacturacion)

             

                End With


            Catch e As Exception
                'Debug.Print(e.Message)
                Pronto.ERP.Bll.ErrHandler2.WriteError("Error en la carga " & e.ToString)
                Throw
                'Throw New ApplicationException("Error en la carga " + e.Message, e)
            Finally
            End Try


            Return myCartaDePorte
        End Function
    End Class
End Namespace
