Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class ParametroDB

        'Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Parametro
        '    Dim myParametro As Parametro = Nothing
        '    Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
        '    Try
        '        Dim myCommand As SqlCommand = New SqlCommand("wParametroes_T", myConnection)
        '        myCommand.CommandType = CommandType.StoredProcedure
        '        myCommand.Parameters.AddWithValue("@IdParametro", id)
        '        myConnection.Open()
        '        Dim myReader As SqlDataReader = myCommand.ExecuteReader
        '        Try
        '            If myReader.Read Then
        '                myParametro = FillDataRecord(myReader)
        '            End If
        '            myReader.Close()
        '        Finally
        '            CType(myReader, IDisposable).Dispose()
        '        End Try
        '        myConnection.Close()
        '    Finally
        '        CType(myConnection, IDisposable).Dispose()
        '    End Try
        '    Return myParametro
        'End Function

        'Public Shared Function GetList(ByVal SC As String) As ParametroList
        '    Dim tempList As ParametroList = Nothing
        '    Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
        '    Try
        '        Dim myCommand As SqlCommand = New SqlCommand("wParametroes_T", myConnection)
        '        myCommand.CommandType = CommandType.StoredProcedure
        '        myConnection.Open()
        '        Dim myReader As SqlDataReader = myCommand.ExecuteReader
        '        Try
        '            If myReader.HasRows Then
        '                tempList = New ParametroList
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

        'Public Shared Function GetListParaWebService(ByVal SC As String, ByVal Busqueda As String) As ParametroList
        '    Dim tempList As ParametroList = Nothing
        '    Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
        '    Try
        '        Dim myCommand As SqlCommand = New SqlCommand("[wParametroes_TX_Busqueda]", myConnection)
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
        '                tempList = New ParametroList
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


        Public Shared Function GrabaRenglonDirecto(ByVal SC As String, ByVal ds As System.Data.DataSet) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand = New SqlCommand("Parametros_M", myConnection)
                myCommand.Transaction = Transaccion
                myCommand.CommandType = CommandType.StoredProcedure



                'tengo que pasearme por todos los parametros del ds.....


                For i As Integer = 0 To ds.Tables(0).Columns.Count - 1
                    With myCommand.Parameters
                        .AddWithValue("@" & ds.Tables(0).Columns(i).ColumnName, ds.Tables(0).Rows(0).Item(i))
                    End With
                Next




                Dim returnValue As DbParameter
                returnValue = myCommand.CreateParameter
                returnValue.Direction = ParameterDirection.ReturnValue
                myCommand.Parameters.Add(returnValue)
                myCommand.ExecuteNonQuery()
                result = Convert.ToInt32(returnValue.Value)

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



        'Public Shared Function GetList_fm(ByVal SC As String) As DataSet
        '    Dim ds As New DataSet()
        '    Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
        '    Try
        '        Dim myCommand As SqlCommand = New SqlCommand("wParametroes_T", myConnection)
        '        myCommand.CommandType = CommandType.StoredProcedure
        '        myCommand.Parameters.AddWithValue("@IdParametro", -2)
        '        myConnection.Open()
        '        Dim DA As New SqlDataAdapter(myCommand)
        '        DA.Fill(ds)
        '    Finally
        '        CType(myConnection, IDisposable).Dispose()
        '    End Try
        '    Return ds
        'End Function

        'Public Shared Function Save(ByVal SC As String, ByVal myParametro As Parametro) As Integer
        '    Dim result As Integer = 0
        '    Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
        '    Dim Transaccion As SqlTransaction
        '    myConnection.Open()
        '    Transaccion = myConnection.BeginTransaction()
        '    Try
        '        Dim myCommand As SqlCommand = New SqlCommand("wParametroes_A", myConnection)
        '        myCommand.Transaction = Transaccion
        '        myCommand.CommandType = CommandType.StoredProcedure
        '        If myParametro.Id = -1 Then
        '            myCommand.Parameters.AddWithValue("@IdParametro", DBNull.Value)
        '        Else
        '            myCommand.Parameters.AddWithValue("@IdParametro", myParametro.Id)
        '        End If
        '        With myCommand.Parameters
        '            .AddWithValue("@RazonSocial", myParametro.RazonSocial)
        '            .AddWithValue("@Direccion", myParametro.Direccion)
        '            .AddWithValue("@IdLocalidad", myParametro.IdLocalidad)
        '            .AddWithValue("@CodigoPostal", myParametro.CodigoPostal)
        '            .AddWithValue("@IdProvincia", myParametro.IdProvincia)
        '            .AddWithValue("@IdPais", myParametro.IdPais)
        '            .AddWithValue("@Telefono1", myParametro.Telefono1)
        '            .AddWithValue("@Telefono2", myParametro.Telefono2)
        '            .AddWithValue("@Fax", myParametro.Fax)
        '            .AddWithValue("@Email", myParametro.Email)
        '            .AddWithValue("@Cuit", myParametro.Cuit)
        '            .AddWithValue("@IdCodigoIva", myParametro.IdCodigoIva)
        '            If myParametro.FechaAlta = DateTime.MinValue Then
        '                .AddWithValue("@FechaAlta", DBNull.Value)
        '            Else
        '                .AddWithValue("@FechaAlta", myParametro.FechaAlta)
        '            End If
        '            If myParametro.FechaUltimaCompra = DateTime.MinValue Then
        '                .AddWithValue("@FechaUltimaCompra", DBNull.Value)
        '            Else
        '                .AddWithValue("@FechaUltimaCompra", myParametro.FechaUltimaCompra)
        '            End If
        '            .AddWithValue("@Excencion", myParametro.Excencion)
        '            .AddWithValue("@IdCondicionCompra", myParametro.IdCondicionCompra)
        '            .AddWithValue("@Contacto", myParametro.Contacto)
        '            .AddWithValue("@IdActividad", myParametro.IdActividad)
        '            .AddWithValue("@Nif", myParametro.Nif)
        '            .AddWithValue("@IdEstado", myParametro.IdEstado)
        '            If myParametro.EstadoFecha = DateTime.MinValue Then
        '                .AddWithValue("@EstadoFecha", DBNull.Value)
        '            Else
        '                .AddWithValue("@EstadoFecha", myParametro.EstadoFecha)
        '            End If
        '            .AddWithValue("@EstadoUsuario", myParametro.EstadoUsuario)
        '            .AddWithValue("@AltaUsuario", myParametro.AltaUsuario)
        '            .AddWithValue("@CodigoEmpresa", myParametro.CodigoEmpresa)
        '            .AddWithValue("@Nombre1", myParametro.Nombre1)
        '            .AddWithValue("@Nombre2", myParametro.Nombre2)
        '            .AddWithValue("@NombreFantasia", myParametro.NombreFantasia)
        '            .AddWithValue("@IdTipoRetencionGanancia", myParametro.IdTipoRetencionGanancia)
        '            .AddWithValue("@IGCondicion", myParametro.IGCondicion)
        '            .AddWithValue("@IGCertificadoAutoretencion", myParametro.IGCertificadoAutoretencion)
        '            .AddWithValue("@IGCertificadoNORetencion", myParametro.IGCertificadoNORetencion)
        '            If myParametro.IGFechaCaducidadExencion = DateTime.MinValue Then
        '                .AddWithValue("@IGFechaCaducidadExencion", DBNull.Value)
        '            Else
        '                .AddWithValue("@IGFechaCaducidadExencion", myParametro.IGFechaCaducidadExencion)
        '            End If
        '            If myParametro.FechaLimiteExentoGanancias = DateTime.MinValue Then
        '                .AddWithValue("@FechaLimiteExentoGanancias", DBNull.Value)
        '            Else
        '                .AddWithValue("@FechaLimiteExentoGanancias", myParametro.FechaLimiteExentoGanancias)
        '            End If
        '            .AddWithValue("@IGPorcentajeNORetencion", myParametro.IGPorcentajeNORetencion)
        '            .AddWithValue("@IvaAgenteRetencion", myParametro.IvaAgenteRetencion)
        '            .AddWithValue("@IvaExencionRetencion", myParametro.IvaExencionRetencion)
        '            If myParametro.IvaFechaCaducidadExencion = DateTime.MinValue Then
        '                .AddWithValue("@IvaFechaCaducidadExencion", DBNull.Value)
        '            Else
        '                .AddWithValue("@IvaFechaCaducidadExencion", myParametro.IvaFechaCaducidadExencion)
        '            End If
        '            .AddWithValue("@IvaPorcentajeExencion", myParametro.IvaPorcentajeExencion)
        '            .AddWithValue("@CodigoSituacionRetencionIVA", myParametro.CodigoSituacionRetencionIVA)
        '            .AddWithValue("@IBNumeroInscripcion ", myParametro.IBNumeroInscripcion)
        '            .AddWithValue("@IdIBCondicionPorDefecto", myParametro.IdIBCondicionPorDefecto)
        '            .AddWithValue("@IBCondicion", myParametro.IBCondicion)
        '            If myParametro.IBFechaCaducidadExencion = DateTime.MinValue Then
        '                .AddWithValue("@IBFechaCaducidadExencion", DBNull.Value)
        '            Else
        '                .AddWithValue("@IBFechaCaducidadExencion", myParametro.IBFechaCaducidadExencion)
        '            End If
        '            If myParametro.FechaLimiteExentoIIBB = DateTime.MinValue Then
        '                .AddWithValue("@FechaLimiteExentoIIBB", DBNull.Value)
        '            Else
        '                .AddWithValue("@FechaLimiteExentoIIBB", myParametro.FechaLimiteExentoIIBB)
        '            End If
        '            .AddWithValue("@IBPorcentajeExencion", myParametro.IBPorcentajeExencion)
        '            .AddWithValue("@CoeficienteIIBBUnificado", myParametro.CoeficienteIIBBUnificado)
        '            .AddWithValue("@SujetoEmbargado", myParametro.SujetoEmbargado)
        '            .AddWithValue("@SaldoEmbargo", myParametro.SaldoEmbargo)
        '            .AddWithValue("@DetalleEmbargo", myParametro.DetalleEmbargo)
        '            .AddWithValue("@PorcentajeIBDirecto", myParametro.PorcentajeIBDirecto)
        '            If myParametro.FechaInicioVigenciaIBDirecto = DateTime.MinValue Then
        '                .AddWithValue("@FechaInicioVigenciaIBDirecto", DBNull.Value)
        '            Else
        '                .AddWithValue("@FechaInicioVigenciaIBDirecto", myParametro.FechaInicioVigenciaIBDirecto)
        '            End If
        '            If myParametro.FechaFinVigenciaIBDirecto = DateTime.MinValue Then
        '                .AddWithValue("@FechaFinVigenciaIBDirecto", DBNull.Value)
        '            Else
        '                .AddWithValue("@FechaFinVigenciaIBDirecto", myParametro.FechaFinVigenciaIBDirecto)
        '            End If
        '            .AddWithValue("@GrupoIIBB", myParametro.GrupoIIBB)
        '            If myParametro.SSFechaCaducidadExencion = DateTime.MinValue Then
        '                .AddWithValue("@SSFechaCaducidadExencion", DBNull.Value)
        '            Else
        '                .AddWithValue("@SSFechaCaducidadExencion", myParametro.SSFechaCaducidadExencion)
        '            End If
        '            .AddWithValue("@SSPorcentajeExcencion", myParametro.SSPorcentajeExcencion)
        '            .AddWithValue("@PaginaWeb", myParametro.PaginaWeb)
        '            .AddWithValue("@Habitual", myParametro.Habitual)
        '            .AddWithValue("@Observaciones", myParametro.Observaciones)
        '            .AddWithValue("@Saldo", myParametro.Saldo)
        '            .AddWithValue("@CodigoParametro", myParametro.CodigoParametro)
        '            .AddWithValue("@IdCuenta", myParametro.IdCuenta)
        '            .AddWithValue("@IdMoneda", myParametro.IdMoneda)
        '            .AddWithValue("@LimiteCredito", myParametro.LimiteCredito)
        '            .AddWithValue("@TipoParametro", myParametro.TipoParametro)
        '            .AddWithValue("@Eventual", myParametro.Eventual)
        '            .AddWithValue("@Confirmado", myParametro.Confirmado)
        '            .AddWithValue("@CodigoPresto", myParametro.CodigoPresto)
        '            .AddWithValue("@BienesOServicios", myParametro.BienesOServicios)
        '            .AddWithValue("@RetenerSUSS", myParametro.RetenerSUSS)
        '            If myParametro.SUSSFechaCaducidadExencion = DateTime.MinValue Then
        '                .AddWithValue("@SUSSFechaCaducidadExencion", DBNull.Value)
        '            Else
        '                .AddWithValue("@SUSSFechaCaducidadExencion", myParametro.SUSSFechaCaducidadExencion)
        '            End If
        '            .AddWithValue("@ChequesALaOrdenDe", myParametro.ChequesALaOrdenDe)
        '            .AddWithValue("@IdImpuestoDirectoSUSS", myParametro.IdImpuestoDirectoSUSS)
        '            .AddWithValue("@Importaciones_NumeroInscripcion", myParametro.Importaciones_NumeroInscripcion)
        '            .AddWithValue("@Importaciones_DenominacionInscripcion", myParametro.Importaciones_DenominacionInscripcion)
        '            .AddWithValue("@EnviarEmail", myParametro.EnviarEmail)
        '            .AddWithValue("@InformacionAuxiliar", myParametro.InformacionAuxiliar)
        '            If myParametro.FechaUltimaPresentacionDocumentacion = DateTime.MinValue Then
        '                .AddWithValue("@FechaUltimaPresentacionDocumentacion", DBNull.Value)
        '            Else
        '                .AddWithValue("@FechaUltimaPresentacionDocumentacion", myParametro.FechaUltimaPresentacionDocumentacion)
        '            End If
        '            .AddWithValue("@ObservacionesPresentacionDocumentacion", myParametro.ObservacionesPresentacionDocumentacion)
        '            If myParametro.FechaLimiteCondicionIVA = DateTime.MinValue Then
        '                .AddWithValue("@FechaLimiteCondicionIVA", DBNull.Value)
        '            Else
        '                .AddWithValue("@FechaLimiteCondicionIVA", myParametro.FechaLimiteCondicionIVA)
        '            End If
        '            .AddWithValue("@Calificacion", myParametro.Calificacion)
        '            .AddWithValue("@IdUsuarioIngreso", myParametro.IdUsuarioIngreso)
        '            If myParametro.FechaIngreso = DateTime.MinValue Then
        '                .AddWithValue("@FechaIngreso", DBNull.Value)
        '            Else
        '                .AddWithValue("@FechaIngreso", myParametro.FechaIngreso)
        '            End If
        '            .AddWithValue("@IdUsuarioModifico", myParametro.IdUsuarioModifico)
        '            If myParametro.FechaModifico = DateTime.MinValue Then
        '                .AddWithValue("@FechaModifico", DBNull.Value)
        '            Else
        '                .AddWithValue("@FechaModifico", myParametro.FechaModifico)
        '            End If
        '            .AddWithValue("@Exterior", myParametro.Exterior)
        '        End With
        '        Dim returnValue As DbParameter
        '        returnValue = myCommand.CreateParameter
        '        returnValue.Direction = ParameterDirection.ReturnValue
        '        myCommand.Parameters.Add(returnValue)
        '        myCommand.ExecuteNonQuery()
        '        result = Convert.ToInt32(returnValue.Value)

        '        For Each myParametroContacto As ParametroContacto In myParametro.DetallesContactos
        '            myParametroContacto.IdParametro = result
        '            ParametroContactoDB.Save(SC, myParametroContacto)
        '        Next

        '        Transaccion.Commit()
        '        myConnection.Close()
        '    Catch e As Exception
        '       Transaccion.Rollback()
        '       ErrHandler.WriteAndRaiseError(e)
        'Return -1 'qué conviene usar? disparar errores o devolver -1?
        '    Finally
        '        CType(myConnection, IDisposable).Dispose()
        '    End Try
        '    Return result
        'End Function

        'Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
        '    Dim result As Integer = 0
        '    ' Using
        '    Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
        '    Try
        '        Dim myCommand As SqlCommand = New SqlCommand("Parametroes_E", myConnection)
        '        myCommand.CommandType = CommandType.StoredProcedure
        '        myCommand.Parameters.AddWithValue("@IdParametro", id)
        '        myConnection.Open()
        '        result = myCommand.ExecuteNonQuery
        '        myConnection.Close()
        '    Finally
        '        CType(myConnection, IDisposable).Dispose()
        '    End Try
        '    Return result > 0
        'End Function

        'Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Parametro
        '    Dim myParametro As Parametro = New Parametro
        '    myParametro.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdParametro"))
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("RazonSocial")) Then
        '        myParametro.RazonSocial = myDataRecord.GetString(myDataRecord.GetOrdinal("RazonSocial"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Direccion")) Then
        '        myParametro.Direccion = myDataRecord.GetString(myDataRecord.GetOrdinal("Direccion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdLocalidad")) Then
        '        myParametro.IdLocalidad = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdLocalidad"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Localidad")) Then
        '        myParametro.Localidad = myDataRecord.GetString(myDataRecord.GetOrdinal("Localidad"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CodigoPostal")) Then
        '        myParametro.CodigoPostal = myDataRecord.GetString(myDataRecord.GetOrdinal("CodigoPostal"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdProvincia")) Then
        '        myParametro.IdProvincia = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdProvincia"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Provincia")) Then
        '        myParametro.Provincia = myDataRecord.GetString(myDataRecord.GetOrdinal("Provincia"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdPais")) Then
        '        myParametro.IdPais = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdPais"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Pais")) Then
        '        myParametro.Pais = myDataRecord.GetString(myDataRecord.GetOrdinal("Pais"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Telefono1")) Then
        '        myParametro.Telefono1 = myDataRecord.GetString(myDataRecord.GetOrdinal("Telefono1"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Telefono2")) Then
        '        myParametro.Telefono2 = myDataRecord.GetString(myDataRecord.GetOrdinal("Telefono2"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Fax")) Then
        '        myParametro.Fax = myDataRecord.GetString(myDataRecord.GetOrdinal("Fax"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Email")) Then
        '        myParametro.Email = myDataRecord.GetString(myDataRecord.GetOrdinal("Email"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cuit")) Then
        '        myParametro.Cuit = myDataRecord.GetString(myDataRecord.GetOrdinal("Cuit"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdCodigoIva")) Then
        '        myParametro.IdCodigoIva = myDataRecord.GetByte(myDataRecord.GetOrdinal("IdCodigoIva"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CondicionIVA")) Then
        '        myParametro.CodigoIva = myDataRecord.GetString(myDataRecord.GetOrdinal("CondicionIVA"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAlta")) Then
        '        myParametro.FechaAlta = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAlta"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaUltimaCompra")) Then
        '        myParametro.FechaUltimaCompra = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaUltimaCompra"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Excencion")) Then
        '        myParametro.Excencion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Excencion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdCondicionCompra")) Then
        '        myParametro.IdCondicionCompra = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdCondicionCompra"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CondicionCompra")) Then
        '        myParametro.CondicionCompra = myDataRecord.GetString(myDataRecord.GetOrdinal("CondicionCompra"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Contacto")) Then
        '        myParametro.Contacto = myDataRecord.GetString(myDataRecord.GetOrdinal("Contacto"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdActividad")) Then
        '        myParametro.IdActividad = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdActividad"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Actividad")) Then
        '        myParametro.Actividad = myDataRecord.GetString(myDataRecord.GetOrdinal("Actividad"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Nif")) Then
        '        myParametro.Nif = myDataRecord.GetString(myDataRecord.GetOrdinal("Nif"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdEstado")) Then
        '        myParametro.IdEstado = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdEstado"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Estado")) Then
        '        myParametro.Estado = myDataRecord.GetString(myDataRecord.GetOrdinal("Estado"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("EstadoFecha")) Then
        '        myParametro.EstadoFecha = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("EstadoFecha"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("EstadoUsuario")) Then
        '        myParametro.EstadoUsuario = myDataRecord.GetString(myDataRecord.GetOrdinal("EstadoUsuario"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("AltaUsuario")) Then
        '        myParametro.AltaUsuario = myDataRecord.GetString(myDataRecord.GetOrdinal("AltaUsuario"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CodigoEmpresa")) Then
        '        myParametro.CodigoEmpresa = myDataRecord.GetString(myDataRecord.GetOrdinal("CodigoEmpresa"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Nombre1")) Then
        '        myParametro.Nombre1 = myDataRecord.GetString(myDataRecord.GetOrdinal("Nombre1"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Nombre2")) Then
        '        myParametro.Nombre2 = myDataRecord.GetString(myDataRecord.GetOrdinal("Nombre2"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NombreFantasia")) Then
        '        myParametro.NombreFantasia = myDataRecord.GetString(myDataRecord.GetOrdinal("NombreFantasia"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdTipoRetencionGanancia")) Then
        '        myParametro.IdTipoRetencionGanancia = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdTipoRetencionGanancia"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CategoriaGanancias")) Then
        '        myParametro.CategoriaGanancias = myDataRecord.GetString(myDataRecord.GetOrdinal("CategoriaGanancias"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IGCondicion")) Then
        '        myParametro.IGCondicion = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IGCondicion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IGCertificadoAutoretencion")) Then
        '        myParametro.IGCertificadoAutoretencion = myDataRecord.GetString(myDataRecord.GetOrdinal("IGCertificadoAutoretencion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IGCertificadoNORetencion")) Then
        '        myParametro.IGCertificadoNORetencion = myDataRecord.GetString(myDataRecord.GetOrdinal("IGCertificadoNORetencion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IGFechaCaducidadExencion")) Then
        '        myParametro.IGFechaCaducidadExencion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("IGFechaCaducidadExencion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaLimiteExentoGanancias")) Then
        '        myParametro.FechaLimiteExentoGanancias = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaLimiteExentoGanancias"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IGPorcentajeNORetencion")) Then
        '        myParametro.IGPorcentajeNORetencion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("IGPorcentajeNORetencion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IvaAgenteRetencion")) Then
        '        myParametro.IvaAgenteRetencion = myDataRecord.GetString(myDataRecord.GetOrdinal("IvaAgenteRetencion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IvaExencionRetencion")) Then
        '        myParametro.IvaExencionRetencion = myDataRecord.GetString(myDataRecord.GetOrdinal("IvaExencionRetencion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IvaFechaCaducidadExencion")) Then
        '        myParametro.IvaFechaCaducidadExencion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("IvaFechaCaducidadExencion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IvaPorcentajeExencion")) Then
        '        myParametro.IvaPorcentajeExencion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("IvaPorcentajeExencion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CodigoSituacionRetencionIVA")) Then
        '        myParametro.CodigoSituacionRetencionIVA = myDataRecord.GetString(myDataRecord.GetOrdinal("CodigoSituacionRetencionIVA"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SituacionIIBB")) Then
        '        myParametro.SituacionIIBB = myDataRecord.GetString(myDataRecord.GetOrdinal("SituacionIIBB"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IBNumeroInscripcion")) Then
        '        myParametro.IBNumeroInscripcion = myDataRecord.GetString(myDataRecord.GetOrdinal("IBNumeroInscripcion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdIBCondicionPorDefecto")) Then
        '        myParametro.IdIBCondicionPorDefecto = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdIBCondicionPorDefecto"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CategoriaIIBB")) Then
        '        myParametro.CategoriaIIBB = myDataRecord.GetString(myDataRecord.GetOrdinal("CategoriaIIBB"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IBCondicion")) Then
        '        myParametro.IBCondicion = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IBCondicion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IBFechaCaducidadExencion")) Then
        '        myParametro.IBFechaCaducidadExencion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("IBFechaCaducidadExencion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaLimiteExentoIIBB")) Then
        '        myParametro.FechaLimiteExentoIIBB = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaLimiteExentoIIBB"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IBPorcentajeExencion")) Then
        '        myParametro.IBPorcentajeExencion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("IBPorcentajeExencion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CoeficienteIIBBUnificado")) Then
        '        myParametro.CoeficienteIIBBUnificado = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("CoeficienteIIBBUnificado"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SujetoEmbargado")) Then
        '        myParametro.SujetoEmbargado = myDataRecord.GetString(myDataRecord.GetOrdinal("SujetoEmbargado"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SaldoEmbargo")) Then
        '        myParametro.SaldoEmbargo = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("SaldoEmbargo"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("DetalleEmbargo")) Then
        '        myParametro.DetalleEmbargo = myDataRecord.GetString(myDataRecord.GetOrdinal("DetalleEmbargo"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PorcentajeIBDirecto")) Then
        '        myParametro.PorcentajeIBDirecto = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("PorcentajeIBDirecto"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaInicioVigenciaIBDirecto")) Then
        '        myParametro.FechaInicioVigenciaIBDirecto = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaInicioVigenciaIBDirecto"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaFinVigenciaIBDirecto")) Then
        '        myParametro.FechaFinVigenciaIBDirecto = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaFinVigenciaIBDirecto"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("GrupoIIBB")) Then
        '        myParametro.GrupoIIBB = myDataRecord.GetInt32(myDataRecord.GetOrdinal("GrupoIIBB"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SSFechaCaducidadExencion")) Then
        '        myParametro.SSFechaCaducidadExencion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("SSFechaCaducidadExencion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SSPorcentajeExcencion")) Then
        '        myParametro.SSPorcentajeExcencion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("SSPorcentajeExcencion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PaginaWeb")) Then
        '        myParametro.PaginaWeb = myDataRecord.GetString(myDataRecord.GetOrdinal("PaginaWeb"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Habitual")) Then
        '        myParametro.Habitual = myDataRecord.GetString(myDataRecord.GetOrdinal("Habitual"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Observaciones")) Then
        '        myParametro.Observaciones = myDataRecord.GetString(myDataRecord.GetOrdinal("Observaciones"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CodigoParametro")) Then
        '        myParametro.CodigoParametro = myDataRecord.GetInt32(myDataRecord.GetOrdinal("CodigoParametro"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdCuenta")) Then
        '        myParametro.IdCuenta = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdCuenta"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CuentaContable")) Then
        '        myParametro.CuentaContable = myDataRecord.GetString(myDataRecord.GetOrdinal("CuentaContable"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdMoneda")) Then
        '        myParametro.IdMoneda = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdMoneda"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("MonedaHabitual")) Then
        '        myParametro.MonedaHabitual = myDataRecord.GetString(myDataRecord.GetOrdinal("MonedaHabitual"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("LimiteCredito")) Then
        '        myParametro.LimiteCredito = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("LimiteCredito"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("TipoParametro")) Then
        '        myParametro.TipoParametro = myDataRecord.GetInt32(myDataRecord.GetOrdinal("TipoParametro"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Eventual")) Then
        '        myParametro.Eventual = myDataRecord.GetString(myDataRecord.GetOrdinal("Eventual"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Confirmado")) Then
        '        myParametro.Confirmado = myDataRecord.GetString(myDataRecord.GetOrdinal("Confirmado"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CodigoPresto")) Then
        '        myParametro.CodigoPresto = myDataRecord.GetString(myDataRecord.GetOrdinal("CodigoPresto"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("BienesOServicios")) Then
        '        myParametro.BienesOServicios = myDataRecord.GetString(myDataRecord.GetOrdinal("BienesOServicios"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("RetenerSUSS")) Then
        '        myParametro.RetenerSUSS = myDataRecord.GetString(myDataRecord.GetOrdinal("RetenerSUSS"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SUSSFechaCaducidadExencion")) Then
        '        myParametro.SUSSFechaCaducidadExencion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("SUSSFechaCaducidadExencion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ChequesALaOrdenDe")) Then
        '        myParametro.ChequesALaOrdenDe = myDataRecord.GetString(myDataRecord.GetOrdinal("ChequesALaOrdenDe"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdImpuestoDirectoSUSS")) Then
        '        myParametro.IdImpuestoDirectoSUSS = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdImpuestoDirectoSUSS"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImpuestoDirectoSUSS")) Then
        '        myParametro.ImpuestoDirectoSUSS = myDataRecord.GetString(myDataRecord.GetOrdinal("ImpuestoDirectoSUSS"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Importaciones_NumeroInscripcion")) Then
        '        myParametro.Importaciones_NumeroInscripcion = myDataRecord.GetString(myDataRecord.GetOrdinal("Importaciones_NumeroInscripcion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Importaciones_DenominacionInscripcion")) Then
        '        myParametro.Importaciones_DenominacionInscripcion = myDataRecord.GetString(myDataRecord.GetOrdinal("Importaciones_DenominacionInscripcion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("InformacionAuxiliar")) Then
        '        myParametro.InformacionAuxiliar = myDataRecord.GetString(myDataRecord.GetOrdinal("InformacionAuxiliar"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaUltimaPresentacionDocumentacion")) Then
        '        myParametro.FechaUltimaPresentacionDocumentacion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaUltimaPresentacionDocumentacion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ObservacionesPresentacionDocumentacion")) Then
        '        myParametro.ObservacionesPresentacionDocumentacion = myDataRecord.GetString(myDataRecord.GetOrdinal("ObservacionesPresentacionDocumentacion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaLimiteCondicionIVA")) Then
        '        myParametro.FechaLimiteCondicionIVA = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaLimiteCondicionIVA"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Calificacion")) Then
        '        myParametro.Calificacion = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Calificacion"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdUsuarioIngreso")) Then
        '        myParametro.IdUsuarioIngreso = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdUsuarioIngreso"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("UsuarioIngreso")) Then
        '        myParametro.UsuarioIngreso = myDataRecord.GetString(myDataRecord.GetOrdinal("UsuarioIngreso"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaIngreso")) Then
        '        myParametro.FechaIngreso = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaIngreso"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdUsuarioModifico")) Then
        '        myParametro.IdUsuarioModifico = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdUsuarioModifico"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("UsuarioModifico")) Then
        '        myParametro.UsuarioModifico = myDataRecord.GetString(myDataRecord.GetOrdinal("UsuarioModifico"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaModifico")) Then
        '        myParametro.FechaModifico = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaModifico"))
        '    End If
        '    If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Exterior")) Then
        '        myParametro.Exterior = myDataRecord.GetString(myDataRecord.GetOrdinal("Exterior"))
        '    End If

        '    Return myParametro
        'End Function

    End Class

End Namespace