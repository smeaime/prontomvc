Imports CodeEngine.Framework.QueryBuilder

Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager

Public Module SQLdinamico



    Function BuscaIdProvinciaNET(ByVal descripcion As String, ByVal SC As String) As Long
        If descripcion = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdProvincia FROM Proveedores WHERE Nombre='" & Replace(descripcion, "'", "''") & "'")

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdProvincia")
    End Function

    Function BuscaIdLocalidadNET(ByVal descripcion As String, ByVal SC As String) As Long

        If descripcion = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdLocalidad FROM Localidades WHERE Nombre='" & Replace(descripcion, "'", "''") & "'")

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdLocalidad")

    End Function


    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////







    Public Function BuscaIdProveedorPreciso(ByVal ProveedorRazonSocial As String, ByVal SC As String) As Integer

        If ProveedorRazonSocial = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdProveedor FROM Proveedores WHERE RazonSocial='" & Replace(ProveedorRazonSocial, "'", "''") & "'")

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdProveedor")
    End Function






    Public Function BuscaIdVendedorPreciso(ByVal Nombre As String, ByVal SC As String) As Integer
        If Nombre = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdVendedor FROM Vendedores WHERE Nombre='" & Replace(Nombre, "'", "''") & "'")

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdVendedor")
    End Function

    Public Function BuscaIdVendedorPrecisoConCUIT(ByVal Nombre As String, ByVal SC As String) As Integer
        If Nombre = "" Then Return -1


        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////

        'http://www.codeproject.com/KB/database/SelectQueryBuilder.aspx

        Dim query As New SelectQueryBuilder
        query.SelectFromTable("Vendedores")
        query.SelectAllColumns()
        query.TopRecords = 1
        query.AddWhere("Nombre", Enums.Comparison.Equals, Nombre, 1) 'el ultimo parametro es para el OR
        query.AddWhere("CUIT COLLATE SQL_Latin1_General_CP1_CI_AS + ' ' + Nombre  COLLATE SQL_Latin1_General_CP1_CI_AS", Enums.Comparison.Equals, Nombre, 2) 'el ultimo parametro es para el OR


        Dim statement = query.BuildQuery()

        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////

        Dim ds = ExecDinamico(SC, statement)


        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdVendedor")
    End Function

    Function BuscaIdTipoComprobantePreciso(ByVal Nombre As String, ByVal SC As String) As Integer
        If Nombre = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdTipoComprobante FROM TiposComprobante WHERE Descripcion='" & Replace(Nombre, "'", "''") & "'")

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdTipoComprobante")
    End Function


    Function BuscaIdConceptoPreciso(ByVal Nombre As String, ByVal SC As String) As Integer
        If Nombre = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdConcepto FROM Conceptos WHERE Descripcion='" & Replace(Nombre, "'", "''") & "'")

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdConcepto")
    End Function

    Function BuscaIdCajaPreciso(ByVal Nombre As String, ByVal SC As String) As Integer
        If Nombre = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdCaja FROM Cajas WHERE Descripcion='" & Replace(Nombre, "'", "''") & "'")

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdCaja")
    End Function

    Function BuscaIdEmpleadoPreciso(ByVal Nombre As String, ByVal SC As String) As Integer
        If Nombre = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdEmpleado FROM Empleados WHERE Nombre='" & Replace(Nombre, "'", "''") & "'")

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdEmpleado")
    End Function


    Function BuscaIdClienteAproximado(ByVal ClienteRazonSocial As String, ByVal SC As String, ByVal distancia As Integer) As Integer

        If ClienteRazonSocial = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdCliente FROM Clientes WHERE ltrim(razonsocial)<>'' AND dbo.Levenshtein2(RazonSocial,'" & Replace(ClienteRazonSocial, "'", "''") & "'," & distancia & ") < " & distancia)

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdCliente")
    End Function



    Function BuscaIdLocalidadAproximado(ByVal ClienteRazonSocial As String, ByVal SC As String, ByVal distancia As Integer) As Integer

        If ClienteRazonSocial = "" Then Return -1




     



        Try



            Dim strsql = "select * from " & _
                    " ( " & _
                    "  Select " & _
                    "  traduccion,palabra," & _
                    "  dbo.Levenshtein2(palabra,'" & Replace(ClienteRazonSocial, "'", "''") & "'," & distancia & " ) as lev " & _
                    "  FROM DiccionarioEquivalencias " & _
                        "  WHERE ltrim(palabra)<>''  " & _
                        "  ) as query  " & _
                    "  where lev is not null " & _
                    "  order by lev  asc"

            Dim ds2 = EntidadManager.ExecDinamico(SC, strsql)
            'Dim ds2 = EntidadManager.ExecDinamico(SC, "SELECT TOP 5 traduccion,palabra FROM DiccionarioEquivalencias WHERE ltrim(palabra)<>'' AND dbo.Levenshtein2(palabra,'" & Replace(ClienteRazonSocial, "'", "''") & "'," & distancia & " ) < " & distancia _
            '  & "  order by dbo.Levenshtein2(palabra,'" & Replace(ClienteRazonSocial, "'", "''") & "'," & distancia & ") " & " asc", 100)



            If ds2.Rows.Count > 0 Then

                Dim equivalencia As String = ds2.Rows(0).Item("traduccion")

                Dim id = BuscaIdLocalidadPreciso(equivalencia, SC)
                If id > 0 Then Return id
                End If



            Dim strsql3 = "select * from " & _
                " ( " & _
                "  Select " & _
                "  IdLocalidad,nombre," & _
                "  dbo.Levenshtein2(nombre,'" & Replace(ClienteRazonSocial, "'", "''") & "'," & distancia & " ) as lev " & _
                "  FROM Localidades " & _
                    "  WHERE ltrim(nombre)<>''  " & _
                    "  ) as query  " & _
                "  where lev is not null " & _
                "  order by lev  asc"

            'Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 5 IdLocalidad, nombre FROM Localidades WHERE ltrim(nombre)<>'' AND dbo.LevenshteinDistance(nombre,'" & Replace(ClienteRazonSocial, "'", "''") & "'," & distancia & ") < " & distancia _
            '      & "  order by dbo.LevenshteinDistance(nombre,'" & Replace(ClienteRazonSocial, "'", "''") & "'," & distancia & ") " & " asc", 100)
            Dim ds3 = EntidadManager.ExecDinamico(SC, strsql3, 5)



            If ds3.Rows.Count > 0 Then Return ds3.Rows(0).Item("IdLocalidad")



        Catch ex As Exception
            ErrHandler2.WriteError(ex)

            Return -1
        End Try

    End Function





    Public Function BuscaIdClientePreciso(ByVal ClienteRazonSocial As String, ByVal SC As String) As Integer

        If ClienteRazonSocial = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdCliente FROM Clientes WHERE RazonSocial='" & Replace(ClienteRazonSocial, "'", "''") & "'")

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdCliente")
    End Function



    Public Function BuscaIdClientePrecisoConCUIT(ByVal ClienteRazonSocial As String, ByVal SC As String) As Integer

        If Trim(ClienteRazonSocial) = "" Then Return -1

        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////

        'http://www.codeproject.com/KB/database/SelectQueryBuilder.aspx

        Dim query As New SelectQueryBuilder
        query.SelectFromTable("Clientes")
        query.SelectAllColumns()
        query.TopRecords = 1
        query.AddWhere("RazonSocial", Enums.Comparison.Equals, ClienteRazonSocial, 1) 'el ultimo parametro es para el OR
        query.AddWhere("CUIT + ' ' + RazonSocial COLLATE Modern_Spanish_ci_as", Enums.Comparison.Equals, ClienteRazonSocial, 2) 'el ultimo parametro es para el OR
        query.AddWhere("RazonSocial + ' ' + CUIT COLLATE Modern_Spanish_ci_as", Enums.Comparison.Equals, ClienteRazonSocial, 3) 'el ultimo parametro es para el OR
        query.AddWhere("CUIT", Enums.Comparison.Equals, ClienteRazonSocial, 4) 'el ultimo parametro es para el OR


        Dim statement = query.BuildQuery()

        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////



        Dim ds = ExecDinamico(SC, statement)

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdCliente")
    End Function






    Public Function BuscaIdCuentaPrecisoConCodigoComoSufijo(ByVal CuentaDescripcion As String, ByVal SC As String, Optional ByVal bBuscarTambienSinSufijo As Boolean = False) As Integer
        If CuentaDescripcion = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdCuenta FROM Cuentas WHERE Descripcion + ' ' + Convert(varchar,Codigo) ='" & Replace(CuentaDescripcion, "'", "''") & "'")

        If ds.Rows.Count < 1 Then
            'no encontró nada. Hacer la intentona sin sufijo?
            If bBuscarTambienSinSufijo Then
                ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdCuenta FROM Cuentas WHERE Descripcion='" & Replace(CuentaDescripcion, "'", "''") & "'")
                If ds.Rows.Count < 1 Then Return -1
            Else
                Return -1
            End If
        End If

        Return ds.Rows(0).Item("IdCuenta")

    End Function



    Public Function NombreEstablecimientoWilliams(ByVal SC As String, ByVal IdEstablecimiento As Object) As String
        If Not IsNumeric(IdEstablecimiento) Then Return Nothing
        If IdEstablecimiento <= 0 Then Return Nothing
        Try
            'Return EntidadManager.TablaSelect(SC, "isnull(Descripcion,'') + ' ' + Convert(varchar(200),isnull(AuxiliarString1,'') COLLATE SQL_Latin1_General_CP1_CI_AS)+ ' '" & _
            '                                       "  + Convert(varchar(200),isnull(AuxiliarString2,'')  COLLATE SQL_Latin1_General_CP1_CI_AS)", _
            '                                          "CDPEstablecimientos", "IdEstablecimiento", IdEstablecimiento)



            Return EntidadManager.ExecDinamico(SC, "SELECT TOP 1  " & _
                                             " isnull(Descripcion,'')  COLLATE SQL_Latin1_General_CP1_CI_AS  + ' ' " & _
                                             " + isnull(Clientes.RazonSocial,'')  COLLATE SQL_Latin1_General_CP1_CI_AS  + ' ' " & _
                                             " + Convert(varchar(200),isnull(AuxiliarString1,'')  COLLATE SQL_Latin1_General_CP1_CI_AS)+ ' ' " & _
                                             " + Convert(varchar(200),isnull(AuxiliarString2,'')  COLLATE SQL_Latin1_General_CP1_CI_AS) " & _
                                             " FROM CDPEstablecimientos left JOIN CLIENTES on  CLIENTES.idcliente=CDPEstablecimientos.idtitular " & _
                                             "  WHERE IdEstablecimiento=" & IdEstablecimiento & "").Rows(0).Item(0).ToString

        Catch ex As Exception
            Return Nothing
        End Try
    End Function

    Public Function BuscaIdEstablecimientoWilliams(ByVal Nombre As String, ByVal SC As String) As Integer
        If Nombre = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdEstablecimiento FROM CDPEstablecimientos WHERE Descripcion='" & Replace(Nombre, "'", "''") & "'")


        If ds.Rows.Count < 1 Then
            'no encontró nada. Hacer la intentona sin sufijo?
            If True Then


                ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdEstablecimiento FROM CDPEstablecimientos left JOIN CLIENTES on  CLIENTES.idcliente=CDPEstablecimientos.idtitular  WHERE " & _
                                                 " isnull(Descripcion,'')  COLLATE SQL_Latin1_General_CP1_CI_AS  + ' ' " & _
                                                 " + isnull(Clientes.RazonSocial,'')  COLLATE SQL_Latin1_General_CP1_CI_AS  + ' ' " & _
                                                 " + Convert(varchar(200),isnull(AuxiliarString1,'')  COLLATE SQL_Latin1_General_CP1_CI_AS)+ ' ' " & _
                                                 " + Convert(varchar(200),isnull(AuxiliarString2,'')  COLLATE SQL_Latin1_General_CP1_CI_AS)    ='" & Replace(Nombre, "'", "''") & "'")
                If ds.Rows.Count < 1 Then Return -1
            Else
                Return -1
            End If
        End If



        Return ds.Rows(0).Item("IdEstablecimiento")
    End Function









    Public Function BuscaIdCalidadPreciso(ByVal Nombre As String, ByVal SC As String) As Integer
        If Nombre = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdCalidad FROM Calidades WHERE Descripcion='" & Replace(Nombre, "'", "''") & "'")

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdCalidad")
    End Function

    Public Function BuscaIdLocalidadPreciso(ByVal Nombre As String, ByVal SC As String) As Integer
        If Nombre = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdLocalidad FROM Localidades WHERE Nombre='" & Replace(Nombre, "'", "''") & "'")

        If ds.Rows.Count < 1 Then

            Dim s As String = "SELECT TOP 1 IdLocalidad FROM Localidades   " & _
                                              " LEFT JOIN PROVINCIAS ON PROVINCIAS.IdProvincia=Localidades.IdProvincia WHERE " & _
                                               "           isnull(CodigoPostal,'') COLLATE Modern_Spanish_ci_as + ' ' + " & _
                                               "           isnull(Localidades.Nombre,'') COLLATE Modern_Spanish_ci_as + ' - ' + " & _
                                               "           isnull(Partido,'') COLLATE Modern_Spanish_ci_as + ' ' + " & _
                                               "           isnull(PROVINCIAS.Nombre,'')   COLLATE Modern_Spanish_ci_as = '" & Replace(Nombre, "'", "''") & "'"
            ds = EntidadManager.ExecDinamico(SC, s)

            If ds.Rows.Count < 1 Then Return -1
        End If

        Return ds.Rows(0).Item("IdLocalidad")
    End Function


    Function BuscaIdObraPreciso(ByVal ArticuloDescripcion As String, ByVal SC As String) As Integer

        If ArticuloDescripcion = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdObra FROM Obras WHERE  " & _
                                             " isnull(NumeroObra,'') + ' - ' + Convert(varchar(200),isnull(Descripcion,'')  COLLATE SQL_Latin1_General_CP1_CI_AS) = '" & Replace(ArticuloDescripcion, "'", "''") & "'")


        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdObra")
    End Function


    Function BuscaIdArticuloEquipoDestinoPreciso(ByVal ArticuloDescripcion As String, ByVal SC As String) As Integer
        'usar el mismo formato que el webservice

        If ArticuloDescripcion = "" Then Return -1

        ArticuloDescripcion = Replace(ArticuloDescripcion, "'", "''")

        'podria llamar directamente un storeproc....
        Dim sTabla = "Articulos"
        Dim sColumnaDescripcion = "Descripcion"
        Dim sColumnaCodigo = "NumeroInventario"




        Dim s = "SELECT TOP 1 IdArticulo  " & _
               " FROM Articulos " & _
                " WHERE " & _
                "           isnull(" & sColumnaCodigo & ",'') COLLATE Modern_Spanish_ci_as + ' ' + " & _
                "           isnull(" & sColumnaDescripcion & ",'') + '' COLLATE Modern_Spanish_ci_as    " & _
                    "                                = '" & ArticuloDescripcion & "'" & _
                " OR " & _
                "           isnull(" & sColumnaCodigo & ",'') COLLATE Modern_Spanish_ci_as  + " & _
                "           isnull(" & sColumnaDescripcion & ",'') + '' COLLATE Modern_Spanish_ci_as    " & _
                    "                                = '" & ArticuloDescripcion & "'"

        Dim ds = EntidadManager.ExecDinamico(SC, s)

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdArticulo")
    End Function

    Function BuscaIdArticuloPreciso(ByVal ArticuloDescripcion As String, ByVal SC As String) As Integer

        If ArticuloDescripcion = "" Then Return -1

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdArticulo FROM Articulos WHERE REPLACE(Descripcion, CHAR(13) + CHAR(10), '') COLLATE Modern_Spanish_ci_as ='" & Replace(ArticuloDescripcion, "'", "''") & "'  COLLATE Modern_Spanish_ci_as ")

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdArticulo")
    End Function



    Function BuscaIdTransportistaPreciso(ByVal RazonSocial As String, ByVal SC As String) As Integer

        'Usually, string comparisons are case-insensitive. If your database is configured to 
        'case sensitive collation, you need to force to use a case insensitive one:
        'SELECT balance FROM people WHERE email = 'billg@microsoft.com'  COLLATE SQL_Latin1_General_CP1_CI_AS


        If RazonSocial = "" Then Return -1
        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdTransportista FROM Transportistas WHERE RazonSocial='" & RazonSocial & "'")

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdTransportista")
    End Function

    Function BuscaIdTransportistaPrecisoConCUIT(ByVal RazonSocial As String, ByVal SC As String) As Integer
        If RazonSocial = "" Then Return -1

        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////

        'http://www.codeproject.com/KB/database/SelectQueryBuilder.aspx

        Dim query As New SelectQueryBuilder
        query.SelectFromTable("Transportistas")
        query.SelectAllColumns()
        query.TopRecords = 1
        query.AddWhere("RazonSocial", Enums.Comparison.Equals, RazonSocial, 1) 'el ultimo parametro es para el OR
        query.AddWhere("CUIT + ' ' + RazonSocial", Enums.Comparison.Equals, RazonSocial, 2) 'el ultimo parametro es para el OR


        Dim statement = query.BuildQuery()

        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////

        Dim ds = ExecDinamico(SC, statement)

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdTransportista")
    End Function

    Function BuscaIdChoferPreciso(ByVal RazonSocial As String, ByVal SC As String) As Integer
        If RazonSocial = "" Then Return -1
        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdChofer FROM Choferes WHERE Nombre='" & RazonSocial & "'")

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdChofer")
    End Function


    Function BuscaIdChoferPrecisoConCUIT(ByVal RazonSocial As String, ByVal SC As String) As Integer
        If RazonSocial = "" Then Return -1

        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////

        'http://www.codeproject.com/KB/database/SelectQueryBuilder.aspx

        Dim query As New SelectQueryBuilder
        query.SelectFromTable("Choferes")
        query.SelectAllColumns()
        query.TopRecords = 1
        query.AddWhere("Nombre", Enums.Comparison.Equals, RazonSocial, 1) 'el ultimo parametro es para el OR
        query.AddWhere("CUIL + ' ' + Nombre", Enums.Comparison.Equals, RazonSocial, 2) 'el ultimo parametro es para el OR


        Dim statement = query.BuildQuery()

        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////

        Dim ds = ExecDinamico(SC, statement)

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdChofer")

    End Function
    'Function BuscaIdWilliamsDestino(ByVal Destino As String, ByVal SC As String) As Integer
    '    Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdWilliamsDestino FROM WilliamsDestinos WHERE Desqipcion='" & Destino & "'")

    '    If ds.Rows.Count < 1 Then Return -1

    '    Return ds.Rows(0).Item("IdWilliamsDestino")
    'End Function

    Function BuscaIdWilliamsDestinoPreciso(ByVal Destino As String, ByVal SC As String) As Integer
        If Destino = "" Then Return -1

        'de donde salió con tabs????? -de la gridview?

        Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdWilliamsDestino FROM WilliamsDestinos WHERE Descripcion='" & Destino & "'")

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdWilliamsDestino")
    End Function


    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////

End Module
