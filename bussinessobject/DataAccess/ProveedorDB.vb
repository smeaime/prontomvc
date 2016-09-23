Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class ProveedorDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Proveedor
            Dim myProveedor As Proveedor = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wProveedores_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdProveedor", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myProveedor = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myProveedor
        End Function

        Public Shared Function GetList(ByVal SC As String) As ProveedorList
            Dim tempList As ProveedorList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wProveedores_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New ProveedorList
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

        'Public Shared Function GetListParaWebService(ByVal SC As String, ByVal Busqueda As String) As ProveedorList
        '    Dim tempList As ProveedorList = Nothing
        '    Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
        '    Try
        '        Dim myCommand As SqlCommand = New SqlCommand("[wProveedores_TX_Busqueda]", myConnection)
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
        '                tempList = New ProveedorList
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


        Public Shared Function GetList_fm(ByVal SC As String) As DataSet
            Dim ds As New DataSet()
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wProveedores_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdProveedor", -2)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myProveedor As Proveedor) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wProveedores_A", myConnection)
                myCommand.Transaction = Transaccion
                myCommand.CommandType = CommandType.StoredProcedure
                If myProveedor.Id = -1 Then
                    myCommand.Parameters.AddWithValue("@IdProveedor", DBNull.Value)
                Else
                    myCommand.Parameters.AddWithValue("@IdProveedor", myProveedor.Id)
                End If
                With myCommand.Parameters
                    .AddWithValue("@RazonSocial", myProveedor.RazonSocial)
                    .AddWithValue("@Direccion", myProveedor.Direccion)
                    .AddWithValue("@IdLocalidad", myProveedor.IdLocalidad)
                    .AddWithValue("@CodigoPostal", myProveedor.CodigoPostal)
                    .AddWithValue("@IdProvincia", myProveedor.IdProvincia)
                    .AddWithValue("@IdPais", myProveedor.IdPais)
                    .AddWithValue("@Telefono1", myProveedor.Telefono1)
                    .AddWithValue("@Telefono2", myProveedor.Telefono2)
                    .AddWithValue("@Fax", myProveedor.Fax)
                    .AddWithValue("@Email", myProveedor.Email)
                    .AddWithValue("@Cuit", myProveedor.Cuit)
                    .AddWithValue("@IdCodigoIva", myProveedor.IdCodigoIva)
                    If myProveedor.FechaAlta = DateTime.MinValue Then
                        .AddWithValue("@FechaAlta", DBNull.Value)
                    Else
                        .AddWithValue("@FechaAlta", myProveedor.FechaAlta)
                    End If
                    If myProveedor.FechaUltimaCompra = DateTime.MinValue Then
                        .AddWithValue("@FechaUltimaCompra", DBNull.Value)
                    Else
                        .AddWithValue("@FechaUltimaCompra", myProveedor.FechaUltimaCompra)
                    End If
                    .AddWithValue("@Excencion", myProveedor.Excencion)
                    .AddWithValue("@IdCondicionCompra", myProveedor.IdCondicionCompra)
                    .AddWithValue("@Contacto", myProveedor.Contacto)
                    .AddWithValue("@IdActividad", myProveedor.IdActividad)
                    .AddWithValue("@Nif", myProveedor.Nif)
                    .AddWithValue("@IdEstado", myProveedor.IdEstado)
                    If myProveedor.EstadoFecha = DateTime.MinValue Then
                        .AddWithValue("@EstadoFecha", DBNull.Value)
                    Else
                        .AddWithValue("@EstadoFecha", myProveedor.EstadoFecha)
                    End If
                    .AddWithValue("@EstadoUsuario", myProveedor.EstadoUsuario)
                    .AddWithValue("@AltaUsuario", myProveedor.AltaUsuario)
                    .AddWithValue("@CodigoEmpresa", myProveedor.CodigoEmpresa)
                    .AddWithValue("@Nombre1", myProveedor.Nombre1)
                    .AddWithValue("@Nombre2", myProveedor.Nombre2)
                    .AddWithValue("@NombreFantasia", myProveedor.NombreFantasia)
                    .AddWithValue("@IdTipoRetencionGanancia", myProveedor.IdTipoRetencionGanancia)
                    .AddWithValue("@IGCondicion", myProveedor.IGCondicion)
                    .AddWithValue("@IGCertificadoAutoretencion", myProveedor.IGCertificadoAutoretencion)
                    .AddWithValue("@IGCertificadoNORetencion", myProveedor.IGCertificadoNORetencion)
                    If myProveedor.IGFechaCaducidadExencion = DateTime.MinValue Then
                        .AddWithValue("@IGFechaCaducidadExencion", DBNull.Value)
                    Else
                        .AddWithValue("@IGFechaCaducidadExencion", myProveedor.IGFechaCaducidadExencion)
                    End If
                    If myProveedor.FechaLimiteExentoGanancias = DateTime.MinValue Then
                        .AddWithValue("@FechaLimiteExentoGanancias", DBNull.Value)
                    Else
                        .AddWithValue("@FechaLimiteExentoGanancias", myProveedor.FechaLimiteExentoGanancias)
                    End If
                    .AddWithValue("@IGPorcentajeNORetencion", myProveedor.IGPorcentajeNORetencion)
                    .AddWithValue("@IvaAgenteRetencion", myProveedor.IvaAgenteRetencion)
                    .AddWithValue("@IvaExencionRetencion", myProveedor.IvaExencionRetencion)
                    If myProveedor.IvaFechaCaducidadExencion = DateTime.MinValue Then
                        .AddWithValue("@IvaFechaCaducidadExencion", DBNull.Value)
                    Else
                        .AddWithValue("@IvaFechaCaducidadExencion", myProveedor.IvaFechaCaducidadExencion)
                    End If
                    .AddWithValue("@IvaPorcentajeExencion", myProveedor.IvaPorcentajeExencion)
                    .AddWithValue("@CodigoSituacionRetencionIVA", myProveedor.CodigoSituacionRetencionIVA)
                    .AddWithValue("@IBNumeroInscripcion ", myProveedor.IBNumeroInscripcion)
                    .AddWithValue("@IdIBCondicionPorDefecto", myProveedor.IdIBCondicionPorDefecto)
                    .AddWithValue("@IBCondicion", myProveedor.IBCondicion)
                    If myProveedor.IBFechaCaducidadExencion = DateTime.MinValue Then
                        .AddWithValue("@IBFechaCaducidadExencion", DBNull.Value)
                    Else
                        .AddWithValue("@IBFechaCaducidadExencion", myProveedor.IBFechaCaducidadExencion)
                    End If
                    If myProveedor.FechaLimiteExentoIIBB = DateTime.MinValue Then
                        .AddWithValue("@FechaLimiteExentoIIBB", DBNull.Value)
                    Else
                        .AddWithValue("@FechaLimiteExentoIIBB", myProveedor.FechaLimiteExentoIIBB)
                    End If
                    .AddWithValue("@IBPorcentajeExencion", myProveedor.IBPorcentajeExencion)
                    .AddWithValue("@CoeficienteIIBBUnificado", myProveedor.CoeficienteIIBBUnificado)
                    .AddWithValue("@SujetoEmbargado", myProveedor.SujetoEmbargado)
                    .AddWithValue("@SaldoEmbargo", myProveedor.SaldoEmbargo)
                    .AddWithValue("@DetalleEmbargo", myProveedor.DetalleEmbargo)
                    .AddWithValue("@PorcentajeIBDirecto", myProveedor.PorcentajeIBDirecto)
                    If myProveedor.FechaInicioVigenciaIBDirecto = DateTime.MinValue Then
                        .AddWithValue("@FechaInicioVigenciaIBDirecto", DBNull.Value)
                    Else
                        .AddWithValue("@FechaInicioVigenciaIBDirecto", myProveedor.FechaInicioVigenciaIBDirecto)
                    End If
                    If myProveedor.FechaFinVigenciaIBDirecto = DateTime.MinValue Then
                        .AddWithValue("@FechaFinVigenciaIBDirecto", DBNull.Value)
                    Else
                        .AddWithValue("@FechaFinVigenciaIBDirecto", myProveedor.FechaFinVigenciaIBDirecto)
                    End If
                    .AddWithValue("@GrupoIIBB", myProveedor.GrupoIIBB)
                    If myProveedor.SSFechaCaducidadExencion = DateTime.MinValue Then
                        .AddWithValue("@SSFechaCaducidadExencion", DBNull.Value)
                    Else
                        .AddWithValue("@SSFechaCaducidadExencion", myProveedor.SSFechaCaducidadExencion)
                    End If
                    .AddWithValue("@SSPorcentajeExcencion", myProveedor.SSPorcentajeExcencion)
                    .AddWithValue("@PaginaWeb", myProveedor.PaginaWeb)
                    .AddWithValue("@Habitual", myProveedor.Habitual)
                    .AddWithValue("@Observaciones", myProveedor.Observaciones)
                    .AddWithValue("@Saldo", myProveedor.Saldo)
                    .AddWithValue("@CodigoProveedor", myProveedor.CodigoProveedor)
                    .AddWithValue("@IdCuenta", myProveedor.IdCuenta)
                    .AddWithValue("@IdMoneda", myProveedor.IdMoneda)
                    .AddWithValue("@LimiteCredito", myProveedor.LimiteCredito)
                    .AddWithValue("@TipoProveedor", myProveedor.TipoProveedor)
                    .AddWithValue("@Eventual", myProveedor.Eventual)
                    .AddWithValue("@Confirmado", myProveedor.Confirmado)
                    .AddWithValue("@CodigoPresto", myProveedor.CodigoPresto)
                    .AddWithValue("@BienesOServicios", myProveedor.BienesOServicios)
                    .AddWithValue("@RetenerSUSS", myProveedor.RetenerSUSS)
                    If myProveedor.SUSSFechaCaducidadExencion = DateTime.MinValue Then
                        .AddWithValue("@SUSSFechaCaducidadExencion", DBNull.Value)
                    Else
                        .AddWithValue("@SUSSFechaCaducidadExencion", myProveedor.SUSSFechaCaducidadExencion)
                    End If
                    .AddWithValue("@ChequesALaOrdenDe", myProveedor.ChequesALaOrdenDe)
                    .AddWithValue("@IdImpuestoDirectoSUSS", myProveedor.IdImpuestoDirectoSUSS)
                    .AddWithValue("@Importaciones_NumeroInscripcion", myProveedor.Importaciones_NumeroInscripcion)
                    .AddWithValue("@Importaciones_DenominacionInscripcion", myProveedor.Importaciones_DenominacionInscripcion)
                    .AddWithValue("@EnviarEmail", myProveedor.EnviarEmail)
                    .AddWithValue("@InformacionAuxiliar", myProveedor.InformacionAuxiliar)
                    If myProveedor.FechaUltimaPresentacionDocumentacion = DateTime.MinValue Then
                        .AddWithValue("@FechaUltimaPresentacionDocumentacion", DBNull.Value)
                    Else
                        .AddWithValue("@FechaUltimaPresentacionDocumentacion", myProveedor.FechaUltimaPresentacionDocumentacion)
                    End If
                    .AddWithValue("@ObservacionesPresentacionDocumentacion", myProveedor.ObservacionesPresentacionDocumentacion)
                    If myProveedor.FechaLimiteCondicionIVA = DateTime.MinValue Then
                        .AddWithValue("@FechaLimiteCondicionIVA", DBNull.Value)
                    Else
                        .AddWithValue("@FechaLimiteCondicionIVA", myProveedor.FechaLimiteCondicionIVA)
                    End If
                    .AddWithValue("@Calificacion", myProveedor.Calificacion)
                    .AddWithValue("@IdUsuarioIngreso", myProveedor.IdUsuarioIngreso)
                    If myProveedor.FechaIngreso = DateTime.MinValue Then
                        .AddWithValue("@FechaIngreso", DBNull.Value)
                    Else
                        .AddWithValue("@FechaIngreso", myProveedor.FechaIngreso)
                    End If
                    .AddWithValue("@IdUsuarioModifico", myProveedor.IdUsuarioModifico)
                    If myProveedor.FechaModifico = DateTime.MinValue Then
                        .AddWithValue("@FechaModifico", DBNull.Value)
                    Else
                        .AddWithValue("@FechaModifico", myProveedor.FechaModifico)
                    End If
                    .AddWithValue("@Exterior", myProveedor.Exterior)
                End With
                Dim returnValue As DbParameter
                returnValue = myCommand.CreateParameter
                returnValue.Direction = ParameterDirection.ReturnValue
                myCommand.Parameters.Add(returnValue)
                myCommand.ExecuteNonQuery()
                result = Convert.ToInt32(returnValue.Value)

                For Each myProveedorContacto As ProveedorContacto In myProveedor.DetallesContactos
                    myProveedorContacto.IdProveedor = result
                    ProveedorContactoDB.Save(SC, myProveedorContacto)
                Next

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
            ' Using
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("Proveedores_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdProveedor", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Proveedor
            Dim myProveedor As Proveedor = New Proveedor
            myProveedor.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdProveedor"))
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("RazonSocial")) Then
                myProveedor.RazonSocial = myDataRecord.GetString(myDataRecord.GetOrdinal("RazonSocial"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Direccion")) Then
                myProveedor.Direccion = myDataRecord.GetString(myDataRecord.GetOrdinal("Direccion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdLocalidad")) Then
                myProveedor.IdLocalidad = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdLocalidad"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Localidad")) Then
                myProveedor.Localidad = myDataRecord.GetString(myDataRecord.GetOrdinal("Localidad"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CodigoPostal")) Then
                myProveedor.CodigoPostal = myDataRecord.GetString(myDataRecord.GetOrdinal("CodigoPostal"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdProvincia")) Then
                myProveedor.IdProvincia = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdProvincia"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Provincia")) Then
                myProveedor.Provincia = myDataRecord.GetString(myDataRecord.GetOrdinal("Provincia"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdPais")) Then
                myProveedor.IdPais = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdPais"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Pais")) Then
                myProveedor.Pais = myDataRecord.GetString(myDataRecord.GetOrdinal("Pais"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Telefono1")) Then
                myProveedor.Telefono1 = myDataRecord.GetString(myDataRecord.GetOrdinal("Telefono1"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Telefono2")) Then
                myProveedor.Telefono2 = myDataRecord.GetString(myDataRecord.GetOrdinal("Telefono2"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Fax")) Then
                myProveedor.Fax = myDataRecord.GetString(myDataRecord.GetOrdinal("Fax"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Email")) Then
                myProveedor.Email = myDataRecord.GetString(myDataRecord.GetOrdinal("Email"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Cuit")) Then
                myProveedor.Cuit = myDataRecord.GetString(myDataRecord.GetOrdinal("Cuit"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdCodigoIva")) Then
                myProveedor.IdCodigoIva = myDataRecord.GetByte(myDataRecord.GetOrdinal("IdCodigoIva"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CondicionIVA")) Then
                myProveedor.CodigoIva = myDataRecord.GetString(myDataRecord.GetOrdinal("CondicionIVA"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAlta")) Then
                myProveedor.FechaAlta = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAlta"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaUltimaCompra")) Then
                myProveedor.FechaUltimaCompra = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaUltimaCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Excencion")) Then
                myProveedor.Excencion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("Excencion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdCondicionCompra")) Then
                myProveedor.IdCondicionCompra = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdCondicionCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CondicionCompra")) Then
                myProveedor.CondicionCompra = myDataRecord.GetString(myDataRecord.GetOrdinal("CondicionCompra"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Contacto")) Then
                myProveedor.Contacto = myDataRecord.GetString(myDataRecord.GetOrdinal("Contacto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdActividad")) Then
                myProveedor.IdActividad = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdActividad"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Actividad")) Then
                myProveedor.Actividad = myDataRecord.GetString(myDataRecord.GetOrdinal("Actividad"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Nif")) Then
                myProveedor.Nif = myDataRecord.GetString(myDataRecord.GetOrdinal("Nif"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdEstado")) Then
                myProveedor.IdEstado = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdEstado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Estado")) Then
                myProveedor.Estado = myDataRecord.GetString(myDataRecord.GetOrdinal("Estado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("EstadoFecha")) Then
                myProveedor.EstadoFecha = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("EstadoFecha"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("EstadoUsuario")) Then
                myProveedor.EstadoUsuario = myDataRecord.GetString(myDataRecord.GetOrdinal("EstadoUsuario"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("AltaUsuario")) Then
                myProveedor.AltaUsuario = myDataRecord.GetString(myDataRecord.GetOrdinal("AltaUsuario"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CodigoEmpresa")) Then
                myProveedor.CodigoEmpresa = myDataRecord.GetString(myDataRecord.GetOrdinal("CodigoEmpresa"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Nombre1")) Then
                myProveedor.Nombre1 = myDataRecord.GetString(myDataRecord.GetOrdinal("Nombre1"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Nombre2")) Then
                myProveedor.Nombre2 = myDataRecord.GetString(myDataRecord.GetOrdinal("Nombre2"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("NombreFantasia")) Then
                myProveedor.NombreFantasia = myDataRecord.GetString(myDataRecord.GetOrdinal("NombreFantasia"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdTipoRetencionGanancia")) Then
                myProveedor.IdTipoRetencionGanancia = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdTipoRetencionGanancia"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CategoriaGanancias")) Then
                myProveedor.CategoriaGanancias = myDataRecord.GetString(myDataRecord.GetOrdinal("CategoriaGanancias"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IGCondicion")) Then
                myProveedor.IGCondicion = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IGCondicion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IGCertificadoAutoretencion")) Then
                myProveedor.IGCertificadoAutoretencion = myDataRecord.GetString(myDataRecord.GetOrdinal("IGCertificadoAutoretencion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IGCertificadoNORetencion")) Then
                myProveedor.IGCertificadoNORetencion = myDataRecord.GetString(myDataRecord.GetOrdinal("IGCertificadoNORetencion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IGFechaCaducidadExencion")) Then
                myProveedor.IGFechaCaducidadExencion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("IGFechaCaducidadExencion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaLimiteExentoGanancias")) Then
                myProveedor.FechaLimiteExentoGanancias = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaLimiteExentoGanancias"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IGPorcentajeNORetencion")) Then
                myProveedor.IGPorcentajeNORetencion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("IGPorcentajeNORetencion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IvaAgenteRetencion")) Then
                myProveedor.IvaAgenteRetencion = myDataRecord.GetString(myDataRecord.GetOrdinal("IvaAgenteRetencion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IvaExencionRetencion")) Then
                myProveedor.IvaExencionRetencion = myDataRecord.GetString(myDataRecord.GetOrdinal("IvaExencionRetencion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IvaFechaCaducidadExencion")) Then
                myProveedor.IvaFechaCaducidadExencion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("IvaFechaCaducidadExencion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IvaPorcentajeExencion")) Then
                myProveedor.IvaPorcentajeExencion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("IvaPorcentajeExencion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CodigoSituacionRetencionIVA")) Then
                myProveedor.CodigoSituacionRetencionIVA = myDataRecord.GetString(myDataRecord.GetOrdinal("CodigoSituacionRetencionIVA"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SituacionIIBB")) Then
                myProveedor.SituacionIIBB = myDataRecord.GetString(myDataRecord.GetOrdinal("SituacionIIBB"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IBNumeroInscripcion")) Then
                myProveedor.IBNumeroInscripcion = myDataRecord.GetString(myDataRecord.GetOrdinal("IBNumeroInscripcion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdIBCondicionPorDefecto")) Then
                myProveedor.IdIBCondicionPorDefecto = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdIBCondicionPorDefecto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CategoriaIIBB")) Then
                myProveedor.CategoriaIIBB = myDataRecord.GetString(myDataRecord.GetOrdinal("CategoriaIIBB"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IBCondicion")) Then
                myProveedor.IBCondicion = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IBCondicion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IBFechaCaducidadExencion")) Then
                myProveedor.IBFechaCaducidadExencion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("IBFechaCaducidadExencion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaLimiteExentoIIBB")) Then
                myProveedor.FechaLimiteExentoIIBB = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaLimiteExentoIIBB"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IBPorcentajeExencion")) Then
                myProveedor.IBPorcentajeExencion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("IBPorcentajeExencion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CoeficienteIIBBUnificado")) Then
                myProveedor.CoeficienteIIBBUnificado = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("CoeficienteIIBBUnificado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SujetoEmbargado")) Then
                myProveedor.SujetoEmbargado = myDataRecord.GetString(myDataRecord.GetOrdinal("SujetoEmbargado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SaldoEmbargo")) Then
                myProveedor.SaldoEmbargo = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("SaldoEmbargo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("DetalleEmbargo")) Then
                myProveedor.DetalleEmbargo = myDataRecord.GetString(myDataRecord.GetOrdinal("DetalleEmbargo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PorcentajeIBDirecto")) Then
                myProveedor.PorcentajeIBDirecto = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("PorcentajeIBDirecto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaInicioVigenciaIBDirecto")) Then
                myProveedor.FechaInicioVigenciaIBDirecto = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaInicioVigenciaIBDirecto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaFinVigenciaIBDirecto")) Then
                myProveedor.FechaFinVigenciaIBDirecto = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaFinVigenciaIBDirecto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("GrupoIIBB")) Then
                myProveedor.GrupoIIBB = myDataRecord.GetInt32(myDataRecord.GetOrdinal("GrupoIIBB"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SSFechaCaducidadExencion")) Then
                myProveedor.SSFechaCaducidadExencion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("SSFechaCaducidadExencion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SSPorcentajeExcencion")) Then
                myProveedor.SSPorcentajeExcencion = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("SSPorcentajeExcencion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("PaginaWeb")) Then
                myProveedor.PaginaWeb = myDataRecord.GetString(myDataRecord.GetOrdinal("PaginaWeb"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Habitual")) Then
                myProveedor.Habitual = myDataRecord.GetString(myDataRecord.GetOrdinal("Habitual"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Observaciones")) Then
                myProveedor.Observaciones = myDataRecord.GetString(myDataRecord.GetOrdinal("Observaciones"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CodigoProveedor")) Then
                myProveedor.CodigoProveedor = myDataRecord.GetInt32(myDataRecord.GetOrdinal("CodigoProveedor"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdCuenta")) Then
                myProveedor.IdCuenta = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdCuenta"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CuentaContable")) Then
                myProveedor.CuentaContable = myDataRecord.GetString(myDataRecord.GetOrdinal("CuentaContable"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdMoneda")) Then
                myProveedor.IdMoneda = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdMoneda"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("MonedaHabitual")) Then
                myProveedor.MonedaHabitual = myDataRecord.GetString(myDataRecord.GetOrdinal("MonedaHabitual"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("LimiteCredito")) Then
                myProveedor.LimiteCredito = myDataRecord.GetDecimal(myDataRecord.GetOrdinal("LimiteCredito"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("TipoProveedor")) Then
                myProveedor.TipoProveedor = myDataRecord.GetInt32(myDataRecord.GetOrdinal("TipoProveedor"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Eventual")) Then
                myProveedor.Eventual = myDataRecord.GetString(myDataRecord.GetOrdinal("Eventual"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Confirmado")) Then
                myProveedor.Confirmado = myDataRecord.GetString(myDataRecord.GetOrdinal("Confirmado"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("CodigoPresto")) Then
                myProveedor.CodigoPresto = myDataRecord.GetString(myDataRecord.GetOrdinal("CodigoPresto"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("BienesOServicios")) Then
                myProveedor.BienesOServicios = myDataRecord.GetString(myDataRecord.GetOrdinal("BienesOServicios"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("RetenerSUSS")) Then
                myProveedor.RetenerSUSS = myDataRecord.GetString(myDataRecord.GetOrdinal("RetenerSUSS"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("SUSSFechaCaducidadExencion")) Then
                myProveedor.SUSSFechaCaducidadExencion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("SUSSFechaCaducidadExencion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ChequesALaOrdenDe")) Then
                myProveedor.ChequesALaOrdenDe = myDataRecord.GetString(myDataRecord.GetOrdinal("ChequesALaOrdenDe"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdImpuestoDirectoSUSS")) Then
                myProveedor.IdImpuestoDirectoSUSS = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdImpuestoDirectoSUSS"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ImpuestoDirectoSUSS")) Then
                myProveedor.ImpuestoDirectoSUSS = myDataRecord.GetString(myDataRecord.GetOrdinal("ImpuestoDirectoSUSS"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Importaciones_NumeroInscripcion")) Then
                myProveedor.Importaciones_NumeroInscripcion = myDataRecord.GetString(myDataRecord.GetOrdinal("Importaciones_NumeroInscripcion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Importaciones_DenominacionInscripcion")) Then
                myProveedor.Importaciones_DenominacionInscripcion = myDataRecord.GetString(myDataRecord.GetOrdinal("Importaciones_DenominacionInscripcion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("InformacionAuxiliar")) Then
                myProveedor.InformacionAuxiliar = myDataRecord.GetString(myDataRecord.GetOrdinal("InformacionAuxiliar"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaUltimaPresentacionDocumentacion")) Then
                myProveedor.FechaUltimaPresentacionDocumentacion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaUltimaPresentacionDocumentacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("ObservacionesPresentacionDocumentacion")) Then
                myProveedor.ObservacionesPresentacionDocumentacion = myDataRecord.GetString(myDataRecord.GetOrdinal("ObservacionesPresentacionDocumentacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaLimiteCondicionIVA")) Then
                myProveedor.FechaLimiteCondicionIVA = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaLimiteCondicionIVA"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Calificacion")) Then
                myProveedor.Calificacion = myDataRecord.GetInt32(myDataRecord.GetOrdinal("Calificacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdUsuarioIngreso")) Then
                myProveedor.IdUsuarioIngreso = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdUsuarioIngreso"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("UsuarioIngreso")) Then
                myProveedor.UsuarioIngreso = myDataRecord.GetString(myDataRecord.GetOrdinal("UsuarioIngreso"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaIngreso")) Then
                myProveedor.FechaIngreso = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaIngreso"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdUsuarioModifico")) Then
                myProveedor.IdUsuarioModifico = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdUsuarioModifico"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("UsuarioModifico")) Then
                myProveedor.UsuarioModifico = myDataRecord.GetString(myDataRecord.GetOrdinal("UsuarioModifico"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaModifico")) Then
                myProveedor.FechaModifico = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaModifico"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Exterior")) Then
                myProveedor.Exterior = myDataRecord.GetString(myDataRecord.GetOrdinal("Exterior"))
            End If

            Return myProveedor
        End Function

    End Class

End Namespace