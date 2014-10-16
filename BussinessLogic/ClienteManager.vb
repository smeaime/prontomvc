Imports System
Imports System.ComponentModel
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient


Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    Public Class ClienteManager




        '<DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListCombo(ByVal SC As String) As System.Data.DataSet
            Return EntidadManager.TraerDatos(SC, "wClientes_TL")
        End Function




        ''<DataObjectMethod(DataObjectMethodType.Update Or DataObjectMethodType.Insert, True)> _
        'Public Shared Function Save(ByVal SC As String, ByVal myProveedor As Cliente) As Integer
        '    'myProveedor.Id = ProveedorDB.Save(SC, myProveedor)
        '    Return myProveedor.ID
        'End Function

        '<DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Cliente
            Dim myCliente As Cliente

            If id < 1 Then Return Nothing

            'If True Then
            myCliente = ClienteDB.GetItem(SC, id)
            'Else
            '    myCliente = GetItemComPronto(SC, id, False)
            'End If



            Try
                myCliente.ExpresionRegularNoAgruparFacturasConEstosVendedores = EntidadManager.TablaSelect(SC, "ExpresionRegularNoAgruparFacturasConEstosVendedores", "Clientes", "IdCliente", id)
                myCliente.ExigeDatosCompletosEnCartaDePorteQueLoUse = EntidadManager.TablaSelect(SC, "ExigeDatosCompletosEnCartaDePorteQueLoUse", "Clientes", "IdCliente", id)
                myCliente.IncluyeTarifaEnFactura = EntidadManager.TablaSelect(SC, "IncluyeTarifaEnFactura ", "Clientes", "IdCliente", id)


                myCliente.DireccionDeCorreos = EntidadManager.TablaSelect(SC, "DireccionDeCorreos ", "Clientes", "IdCliente", id)
                myCliente.IdLocalidadDeCorreos = Val(EntidadManager.TablaSelect(SC, "IdLocalidadDeCorreos ", "Clientes", "IdCliente", id))
                myCliente.IdProvinciaDeCorreos = Val(EntidadManager.TablaSelect(SC, "IdProvinciaDeCorreos ", "Clientes", "IdCliente", id))
                myCliente.CodigoPostalDeCorreos = EntidadManager.TablaSelect(SC, "CodigoPostalDeCorreos ", "Clientes", "IdCliente", id)
                myCliente.ObservacionesDeCorreos = EntidadManager.TablaSelect(SC, "ObservacionesDeCorreos ", "Clientes", "IdCliente", id)

              
                myCliente.SeLeFacturaCartaPorteComoTitular = EntidadManager.TablaSelect(SC, "SeLeFacturaCartaPorteComoTitular ", "Clientes", "IdCliente", id)
                myCliente.SeLeFacturaCartaPorteComoIntermediario = EntidadManager.TablaSelect(SC, "SeLeFacturaCartaPorteComoIntermediario ", "Clientes", "IdCliente", id)
                myCliente.SeLeFacturaCartaPorteComoRemcomercial = EntidadManager.TablaSelect(SC, "SeLeFacturaCartaPorteComoRemcomercial ", "Clientes", "IdCliente", id)
                myCliente.SeLeFacturaCartaPorteComoCorredor = EntidadManager.TablaSelect(SC, "SeLeFacturaCartaPorteComoCorredor ", "Clientes", "IdCliente", id)

            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try


            Try

                With myCliente

                    Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
                    Dim oCliente As linqCliente = (From i In db.linqClientes Where i.IdCliente = id).SingleOrDefault

                    Try
                        .SeLeFacturaCartaPorteComoDestinatarioLocal = oCliente.SeLeFacturaCartaPorteComoDestinatario
                        .SeLeFacturaCartaPorteComoDestinatarioExportador = oCliente.SeLeFacturaCartaPorteComoDestinatarioExportador
                        .SeLeDerivaSuFacturaAlCorredorDeLaCarta = oCliente.SeLeDerivaSuFacturaAlCorredorDeLaCarta

                        .SeLeFacturaCartaPorteComoClienteAuxiliar = oCliente.SeLeFacturaCartaPorteComoClienteAuxiliar
                        .EsAcondicionadoraDeCartaPorte = oCliente.EsAcondicionadoraDeCartaPorte

                        .HabilitadoParaCartaPorte = iisNull(oCliente.HabilitadoParaCartaPorte, "SI") <> "NO"

                        .Eventual = IIf(iisNull(oCliente.IdEstado, 1) = 2, "SI", "NO")

                        .Contactos = oCliente.Contactos
                        .CorreosElectronicos = oCliente.CorreosElectronicos
                        .TelefonosFijosOficina = oCliente.TelefonosFijosOficina
                        .TelefonosCelulares = oCliente.TelefonosCelulares

                        .EsEntregador = oCliente.EsEntregador

                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                End With
            Catch ex As Exception
                ErrHandler.WriteError(ex)

            End Try



            Return myCliente
            'Return ProveedorDB.GetItem(SC, id)
        End Function

        ''<DataObjectMethod(DataObjectMethodType.Select, False)> _
        'Public Shared Function GetItemComPronto(ByVal SC As String, ByVal id As Integer, ByVal getClienteDetalles As Boolean) As Pronto.ERP.BO.Cliente
        '    Dim myCliente As Pronto.ERP.BO.Cliente
        '    'myCliente = ClienteDB.GetItem(SC, id)
        '    myCliente = New Pronto.ERP.BO.Cliente

        '    Dim Aplicacion = ClaseMigrar.CrearAppCompronto(SC) '  = CrearAppCompronto(SC)
        '    'myCliente.__COMPRONTO_Cliente = Aplicacion.Clientes.Item(id)

        '    myCliente = ConvertirComProntoClienteAPuntoNET(Aplicacion.Clientes.Item(id))
        '    Try
        '        myCliente.ExpresionRegularNoAgruparFacturasConEstosVendedores = EntidadManager.TablaSelect(SC, "ExpresionRegularNoAgruparFacturasConEstosVendedores", "Clientes", "IdCliente", id)
        '        myCliente.ExigeDatosCompletosEnCartaDePorteQueLoUse = EntidadManager.TablaSelect(SC, "ExigeDatosCompletosEnCartaDePorteQueLoUse", "Clientes", "IdCliente", id)
        '    Catch ex As Exception
        '        ErrHandler.WriteError(ex)
        '    End Try
        '    Return myCliente
        'End Function

        

        '<DataObjectMethod(DataObjectMethodType.Update Or DataObjectMethodType.Insert, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myCliente As Pronto.ERP.BO.Cliente, Optional ByVal sNombreUsuario As String = "") As Integer


            Dim s = Validar(SC, myCliente)
            If s <> "" Then
                Throw New Exception(s)
            End If


            If True Then
                'METODO NORMAL
                myCliente.Id = ClienteDB.Save(SC, myCliente)
            Else

                'METODO COMPRONTO
                Dim oClienteCOMPRONTO = ClaseMigrar.ConvertirPuntoNETClienteAComPronto(SC, myCliente)
                oClienteCOMPRONTO.Guardar()

                'actualizo manualmente campos nuevos
            End If

            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "ExpresionRegularNoAgruparFacturasConEstosVendedores", "'" & myCliente.ExpresionRegularNoAgruparFacturasConEstosVendedores & "'")
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "ExigeDatosCompletosEnCartaDePorteQueLoUse", "'" & myCliente.ExigeDatosCompletosEnCartaDePorteQueLoUse & "'")
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "IncluyeTarifaEnFactura", "'" & myCliente.IncluyeTarifaEnFactura & "'")


            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "DireccionDeCorreos", "'" & myCliente.DireccionDeCorreos & "'")
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "IdLocalidadDeCorreos", myCliente.IdLocalidadDeCorreos)
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "IdProvinciaDeCorreos", myCliente.IdProvinciaDeCorreos)
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "CodigoPostalDeCorreos", "'" & myCliente.CodigoPostalDeCorreos & "'")
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "ObservacionesDeCorreos", "'" & myCliente.ObservacionesDeCorreos & "'")

            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "SeLeFacturaCartaPorteComoTitular", "'" & myCliente.SeLeFacturaCartaPorteComoTitular & "'")
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "SeLeFacturaCartaPorteComoIntermediario", "'" & myCliente.SeLeFacturaCartaPorteComoIntermediario & "'")
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "SeLeFacturaCartaPorteComoRemcomercial", "'" & myCliente.SeLeFacturaCartaPorteComoRemcomercial & "'")
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "SeLeFacturaCartaPorteComoCorredor", "'" & myCliente.SeLeFacturaCartaPorteComoCorredor & "'")
            'EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "SeLeFacturaCartaPorteComoDestinatario", "'" & myCliente.SeLeFacturaCartaPorteComoDestinatario & "'")
            'EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "SeLeFacturaCartaPorteComoDestinatario", "'" & myCliente.SeLeFacturaCartaPorteComoDestinatario & "'")




            Try

                Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
                Dim oCliente As linqCliente = (From i In db.linqClientes Where i.IdCliente = myCliente.Id).SingleOrDefault
                oCliente.SeLeFacturaCartaPorteComoDestinatario = myCliente.SeLeFacturaCartaPorteComoDestinatarioLocal
                oCliente.SeLeFacturaCartaPorteComoDestinatarioExportador = myCliente.SeLeFacturaCartaPorteComoDestinatarioExportador
                oCliente.SeLeDerivaSuFacturaAlCorredorDeLaCarta = myCliente.SeLeDerivaSuFacturaAlCorredorDeLaCarta



                oCliente.HabilitadoParaCartaPorte = IIf(myCliente.HabilitadoParaCartaPorte, "SI", "NO")
                oCliente.IdEstado = IIf(myCliente.Eventual = "SI", 2, 1)


                With oCliente
                    .SeLeFacturaCartaPorteComoClienteAuxiliar = myCliente.SeLeFacturaCartaPorteComoClienteAuxiliar
                    .EsAcondicionadoraDeCartaPorte = myCliente.EsAcondicionadoraDeCartaPorte




                    .Contactos = myCliente.Contactos
                    .CorreosElectronicos = myCliente.CorreosElectronicos
                    .TelefonosFijosOficina = myCliente.TelefonosFijosOficina
                    .TelefonosCelulares = myCliente.TelefonosCelulares

                    .EsEntregador = myCliente.EsEntregador

                End With
                'If IsNothing(ue) Then
                '    ue = New UserDatosExtendido
                '    ue.UserId = New Guid(userid)
                '    ue.RazonSocial = razonsocial
                '    ue.CUIT = cuit

                '    db.UserDatosExtendidos.InsertOnSubmit(ue)
                'Else
                '    ue.RazonSocial = razonsocial
                'End If

                db.SubmitChanges()

            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try





            'todo: no hay manera de grabar los datos anteriores?
            EntidadManager.LogPronto(SC, myCliente.Id, "Cliente", sNombreUsuario)

            Return myCliente.Id

        End Function


        '<DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As ProveedorList
            'Return ProveedorDB.GetList(SC)
        End Function

        '<DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            'Return ProveedorDB.GetList_fm(SC)
        End Function

        '<DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListDataset(ByVal SC As String) As System.Data.DataSet



            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As Data.DataSet
            'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            'With dc
            '    .ColumnName = "ColumnaTilde"
            '    .DataType = System.Type.GetType("System.Int32")
            '    .DefaultValue = 0
            'End With

            ds = EntidadManager.TraerDatos(SC, "wClientes_TT")

            'Try
            '    ds = EntidadManager.TraerDatos(SC, "wClientes_T", -1)
            'Catch ex As Exception
            '    ds = EntidadManager.TraerDatos(SC, "wClientes_TT")
            '    'ds = EntidadManager.TraerDatos(SC, "Clientes_TT")
            'End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdCliente").ColumnName = "Id"
                '.Columns("NumeroRequerimiento").ColumnName = "Numero"
                '.Columns("FechaRequerimiento").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
            Return ds

        End Function

        '<DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListDatasetWHERE(ByVal SC As String, ByVal ColumnaParaFiltrar As String, ByVal TextoParaFiltrar As String, ByVal sortExpression As String, ByVal startRowIndex As Long, ByVal maximumRows As Long) As System.Data.DataSet



            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As Data.DataSet
            'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            'With dc
            '    .ColumnName = "ColumnaTilde"
            '    .DataType = System.Type.GetType("System.Int32")
            '    .DefaultValue = 0
            'End With

            ds = EntidadManager.TraerDatos(SC, "wClientes_TT")

            'Try
            '    ds = EntidadManager.TraerDatos(SC, "wClientes_T", -1)
            'Catch ex As Exception
            '    ds = EntidadManager.TraerDatos(SC, "wClientes_TT")
            '    'ds = EntidadManager.TraerDatos(SC, "Clientes_TT")
            'End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdCliente").ColumnName = "Id"
                '.Columns("NumeroRequerimiento").ColumnName = "Numero"
                '.Columns("FechaRequerimiento").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
            Return ds

        End Function





        


        'Public Shared Function ConvertirComProntoClienteAPuntoNET(ByVal oCliente) As Pronto.ERP.BO.Cliente ' ) As Pronto.ERP.BO.Cliente
        '    Dim oDest As New Pronto.ERP.BO.Cliente

        '    '///////////////////////////
        '    '///////////////////////////
        '    'ENCABEZADO
        '    With oCliente.Registro


        '        oDest.Id = oCliente.Id



        '        'sp_columns Clientes  --para traer lista de columnas de la tabla




        '        oDest.RazonSocial = SQLtoNET(.Fields("RazonSocial"))
        '        oDest.Direccion = SQLtoNET(.Fields("Direccion"))
        '        oDest.IdLocalidad = SQLtoNET(.Fields("IdLocalidad"))
        '        oDest.CodigoPostal = SQLtoNET(.Fields("CodigoPostal"))
        '        oDest.IdProvincia = SQLtoNET(.Fields("IdProvincia"))
        '        oDest.IdPais = SQLtoNET(.Fields("IdPais"))
        '        oDest.Telefono1 = SQLtoNET(.Fields("Telefono"))
        '        oDest.Fax = SQLtoNET(.Fields("Fax"))
        '        oDest.Email = iisNull(.Fields("Email").Value)
        '        oDest.Cuit = iisNull(.Fields("Cuit").Value)
        '        oDest.IdCodigoIva = iisNull(.Fields("IdCodigoIva").Value, 0)
        '        oDest.FechaAlta = SQLtoNET(.Fields("FechaAlta"))
        '        oDest.Contacto = SQLtoNET(.Fields("Contacto"))
        '        oDest.EnviarEmail = SQLtoNET(.Fields("EnviarEmail"))
        '        oDest.IdCuenta = SQLtoNET(.Fields("IdCuenta"))
        '        oDest.IGCondicion = SQLtoNET(.Fields("IGCondicion"))
        '        oDest.IdMoneda = SQLtoNET(.Fields("IdMoneda"))
        '        oDest.IBNumeroInscripcion = SQLtoNET(.Fields("IBNumeroInscripcion"))
        '        oDest.IBCondicion = SQLtoNET(.Fields("IBCondicion"))
        '        oDest.IdUsuarioIngreso = SQLtoNET(.Fields("IdUsuarioIngreso"))
        '        oDest.FechaIngreso = SQLtoNET(.Fields("FechaIngreso"))
        '        oDest.IdUsuarioModifico = SQLtoNET(.Fields("IdUsuarioModifico"))
        '        oDest.FechaModifico = SQLtoNET(.Fields("FechaModifico"))
        '        oDest.PorcentajeIBDirecto = SQLtoNET(.Fields("PorcentajeIBDirecto"))
        '        oDest.FechaInicioVigenciaIBDirecto = SQLtoNET(.Fields("FechaInicioVigenciaIBDirecto"))
        '        oDest.FechaFinVigenciaIBDirecto = SQLtoNET(.Fields("FechaFinVigenciaIBDirecto"))
        '        oDest.GrupoIIBB = SQLtoNET(.Fields("GrupoIIBB"))
        '        oDest.IdListaPrecios = SQLtoNET(.Fields("IdListaPrecios"))
        '        oDest.IdIBCondicionPorDefecto = SQLtoNET(.Fields("IdIBCondicionPorDefecto"))
        '        oDest.Confirmado = SQLtoNET(.Fields("Confirmado"))
        '        oDest.CodigoPresto = SQLtoNET(.Fields("CodigoPresto"))
        '        oDest.Observaciones = iisNull(.Fields("Observaciones").Value)
        '        oDest.Importaciones_NumeroInscripcion = SQLtoNET(.Fields("Importaciones_NumeroInscripcion"))
        '        oDest.Importaciones_DenominacionInscripcion = SQLtoNET(.Fields("Importaciones_DenominacionInscripcion"))
        '        oDest.IdEstado = SQLtoNET(.Fields("IdEstado"))
        '        oDest.NombreFantasia = SQLtoNET(.Fields("NombreFantasia"))
        '        oDest.DireccionEntrega = SQLtoNET(.Fields("DireccionEntrega"))
        '        oDest.idLocalidadEntrega = SQLtoNET(.Fields("idLocalidadEntrega"))
        '        oDest.IdProvinciaEntrega = SQLtoNET(.Fields("IdProvinciaEntrega"))
        '        oDest.CodigoCliente = SQLtoNET(.Fields("CodigoCliente"))
        '        oDest.Saldo = SQLtoNET(.Fields("Saldo"))
        '        oDest.saldoDocumentos = SQLtoNET(.Fields("SaldoDocumentos"))
        '        oDest.Vendedor1 = SQLtoNET(.Fields("Vendedor1"))
        '        oDest.creditoMaximo = SQLtoNET(.Fields("CreditoMaximo"))
        '        oDest.IdCondicionVenta = SQLtoNET(.Fields("IdCondicionVenta"))
        '        oDest.tipoCliente = SQLtoNET(.Fields("TipoCliente"))
        '        oDest.codigo = SQLtoNET(.Fields("Codigo"))
        '        oDest.idcuentaMonedaExt = SQLtoNET(.Fields("IdCuentaMonedaExt"))
        '        oDest.Cobrador = SQLtoNET(.Fields("Cobrador"))
        '        oDest.Auxiliar = SQLtoNET(.Fields("Auxiliar"))
        '        oDest.IdIBCondicionPorDefecto2 = SQLtoNET(.Fields("IdIBCondicionPorDefecto2"))
        '        oDest.IdIBCondicionPorDefecto3 = SQLtoNET(.Fields("IdIBCondicionPorDefecto3"))
        '        oDest.esAgenteRetencionIVA = IIf(iisNull(.Fields("EsAgenteRetencionIVA").Value, "NO") = "SI", True, False)
        '        oDest.BaseMinimaParaPercepcionIVA = SQLtoNET(.Fields("BaseMinimaParaPercepcionIVA"))
        '        oDest.PorcentajePercepcionIVA = SQLtoNET(.Fields("PorcentajePercepcionIVA"))
        '        oDest.idbancoDebito = SQLtoNET(.Fields("IdBancoDebito"))
        '        oDest.CBU = SQLtoNET(.Fields("CBU"))
        '        Try
        '            oDest.PorcentajeIBDirectoCapital = SQLtoNET(.Fields("PorcentajeIBDirectoCapital"))
        '            oDest.FechaInicioVigenciaIBDirectoCapital = SQLtoNET(.Fields("FechaInicioVigenciaIBDirectoCapital"))
        '            oDest.FechaFinVigenciaIBDirectoCapital = SQLtoNET(.Fields("FechaFinVigenciaIBDirectoCapital"))
        '            oDest.GrupoIIBBCapital = SQLtoNET(.Fields("GrupoIIBBCapital"))
        '        Catch ex As Exception

        '        End Try


        '    End With


        '    ''///////////////////////////
        '    ''///////////////////////////
        '    ''DETALLE
        '    'Dim rsDet As adodb.Recordset = oCliente.DetClientes.TraerTodos

        '    'With rsDet
        '    '    If Not .EOF Then .MoveFirst()

        '    '    Do While Not .EOF

        '    '        Dim oDetCliente  = oCliente.DetClientes.Item(rsDet.Fields("IdDetalleCliente"))

        '    '        Dim item As New ClienteItem


        '    '        With oDetCliente.Registro

        '    '            item.IdArticulo = .Fields("IdArticulo").Value
        '    '            item.Articulo = rsDet.Fields(6).Value 'el nombre
        '    '            item.Cantidad = .Fields("Cantidad").Value
        '    '            item.Precio = .Fields("PrecioUnitario").Value
        '    '            item.PrecioUnitarioTotal = .Fields("PrecioUnitarioTotal").Value
        '    '            item.ImporteTotalItem = item.PrecioUnitarioTotal * item.Cantidad


        '    '            'item.Precio = .Fields("PrecioUnitarioTotal").Value
        '    '        End With

        '    '        oDest.Detalles.Add(item)
        '    '        .MoveNext()
        '    '    Loop

        '    'End With


        '    Return oDest
        'End Function







        '<DataObjectMethod(DataObjectMethodType.Delete, True)> _
        'Public Shared Function GetListParaWebService(ByVal SC As String, ByVal Busqueda As String) As ProveedorList
        '    'Return ProveedorDB.GetListParaWebService(SC, Busqueda)
        'End Function




        '<DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As ProveedorContactoList
            'Return ProveedorContactoDB.GetList(SC, id)
        End Function


        Public Shared Function Delete(ByVal SC As String, ByVal idCliente As Long) As Boolean
            Dim Aplicacion = ClaseMigrar.CrearAppCompronto(SC) '  = CrearAppCompronto(SC)
            Dim oClienteCOMPRONTO = Aplicacion.Clientes.Item(idCliente)
            oClienteCOMPRONTO.Eliminar()
        End Function

        '<DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myCliente As Pronto.ERP.BO.Cliente) As Boolean
            Dim Aplicacion = ClaseMigrar.CrearAppCompronto(SC)
            Dim oClienteCOMPRONTO = Aplicacion.Clientes.Item(myCliente.Id)
            oClienteCOMPRONTO.Eliminar()
            'Return ProveedorDB.Delete(SC, myProveedor.Id)
        End Function


        Public Shared Function Validar(ByVal SC As String, ByVal c As Cliente) As String

            If c.Eventual = "NO" Then
                If BDLMasterEmpresasManager.EmpresaPropietariaDeLaBase(SC) = "Williams" Then
                    If Not mkf_validacuit(c.Cuit) Then
                        Return "El CUIT no es valido"
                    End If
                    If c.IdLocalidad <= 0 Then Return "La localidad no es válida"
                    If c.Direccion = "" Then Return "Ingrese la dirección"
                    If c.CodigoPostal = "" Then Return "Ingrese el código postal"
                    If c.IdProvincia <= 0 Then Return "Ingrese la provincia"

                End If
            End If

            If c.Telefono1.Length > 30 Then Return "El telefono tiene como máximo 30 caracteres"

            If Trim(c.RazonSocial) = "" Then
                Return "La razón social está en blanco"
            End If

            '////////////////////////////////////////////////
            '/////////         CUIT           ///////////////
            '////////////////////////////////////////////////
            If c.Cuit <> "" Then
                If Not mkf_validacuit(c.Cuit) Then
                    Return "El CUIT no es valido"
                End If

                If c.IdLocalidad <= 0 Then Return "La localidad no es válida"
                If c.IdCuenta <= 0 Then Return "La cuenta no es válida"


                'verificar que no existe el cuit 'en realidad lo debería verificar el objeto, no?
                'If (mvarId <= 0 Or BuscarClaveINI("Control estricto del CUIT") = "SI") And _
                Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Clientes", "TX_PorCuit", c.Cuit)
                If ds.Tables(0).Rows.Count > 0 Then
                    For Each dr As Data.DataRow In ds.Tables(0).Rows
                        If c.Id <> ds.Tables(0).Rows(0).Item(0) Then 'And IsNull(oRs.Fields("Exterior").Value) Then
                            Return "El CUIT ya fue asignado al cliente " & dr!RazonSocial
                        End If
                    Next
                End If
            Else
                'Se puede poner CUIT provisorio?
                'Return "El CUIT está vacío" 
            End If

            '////////////////////////////////////////////////
            '////////////////////////////////////////////////
            '////////////////////////////////////////////////

            Return ""
        End Function
    End Class


    Class ClienteDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Pronto.ERP.BO.Cliente
            Dim myCliente As Pronto.ERP.BO.Cliente = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try


                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.Clientes_T.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdCliente", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myCliente = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myCliente
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Pronto.ERP.BO.Cliente
            Dim myCliente As Pronto.ERP.BO.Cliente = New Pronto.ERP.BO.Cliente
            With myCliente


                SQLtoNET(myDataRecord, "@IdCliente", .Id)



                SQLtoNET(myDataRecord, "@RazonSocial", .RazonSocial)
                SQLtoNET(myDataRecord, "@Direccion", .Direccion)
                SQLtoNET(myDataRecord, "@IdLocalidad", .IdLocalidad)
                SQLtoNET(myDataRecord, "@CodigoPostal", .CodigoPostal)
                SQLtoNET(myDataRecord, "@IdProvincia", .IdProvincia)
                SQLtoNET(myDataRecord, "@IdPais", .IdPais)
                SQLtoNET(myDataRecord, "@Telefono", .Telefono1)
                SQLtoNET(myDataRecord, "@Fax", .Fax)
                SQLtoNET(myDataRecord, "@Email", .Email)
                SQLtoNET(myDataRecord, "@Cuit", .Cuit)
                SQLtoNET(myDataRecord, "@IdCodigoIva", .IdCodigoIva)
                SQLtoNET(myDataRecord, "@FechaAlta", .FechaAlta)
                SQLtoNET(myDataRecord, "@Contacto", .Contacto)
                SQLtoNET(myDataRecord, "@EnviarEmail", .EnviarEmail)
                SQLtoNET(myDataRecord, "@IdCuenta", .IdCuenta)
                SQLtoNET(myDataRecord, "@IGCondicion", .IGCondicion)



                SQLtoNET(myDataRecord, "@IdMoneda", .IdMoneda)
                SQLtoNET(myDataRecord, "@IBNumeroInscripcion", .IBNumeroInscripcion)
                SQLtoNET(myDataRecord, "@IBCondicion", .IBCondicion)
                SQLtoNET(myDataRecord, "@IdUsuarioIngreso", .IdUsuarioIngreso)
                SQLtoNET(myDataRecord, "@FechaIngreso", .FechaIngreso)





                SQLtoNET(myDataRecord, "@IdUsuarioModifico", .IdUsuarioModifico)
                SQLtoNET(myDataRecord, "@FechaModifico", .FechaModifico)
                SQLtoNET(myDataRecord, "@PorcentajeIBDirecto", .PorcentajeIBDirecto)
                SQLtoNET(myDataRecord, "@FechaInicioVigenciaIBDirecto", .FechaInicioVigenciaIBDirecto)
                SQLtoNET(myDataRecord, "@FechaFinVigenciaIBDirecto", .FechaFinVigenciaIBDirecto)
                SQLtoNET(myDataRecord, "@GrupoIIBB", .GrupoIIBB)
                SQLtoNET(myDataRecord, "@IdListaPrecios", .IdListaPrecios)
                SQLtoNET(myDataRecord, "@IdIBCondicionPorDefecto", .IdIBCondicionPorDefecto)
                SQLtoNET(myDataRecord, "@Confirmado", .Confirmado)
                SQLtoNET(myDataRecord, "@CodigoPresto", .CodigoPresto)
                SQLtoNET(myDataRecord, "@Observaciones", .Observaciones)
                SQLtoNET(myDataRecord, "@Importaciones_NumeroInscripcion", .Importaciones_NumeroInscripcion)



                SQLtoNET(myDataRecord, "@Importaciones_DenominacionInscripcion", .Importaciones_DenominacionInscripcion)
                SQLtoNET(myDataRecord, "@IdEstado", .IdEstado)
                SQLtoNET(myDataRecord, "@NombreFantasia", .NombreFantasia)
                SQLtoNET(myDataRecord, "@DireccionEntrega", .DireccionEntrega)
                SQLtoNET(myDataRecord, "@idLocalidadEntrega", .idLocalidadEntrega)
                SQLtoNET(myDataRecord, "@IdProvinciaEntrega", .IdProvinciaEntrega)
                SQLtoNET(myDataRecord, "@CodigoCliente", .CodigoCliente)
                SQLtoNET(myDataRecord, "@Saldo", .Saldo)
                SQLtoNET(myDataRecord, "@saldoDocumentos", .saldoDocumentos)


                SQLtoNET(myDataRecord, "@Vendedor1", .Vendedor1)
                SQLtoNET(myDataRecord, "@creditoMaximo", .creditoMaximo)
                SQLtoNET(myDataRecord, "@IdCondicionVenta", .IdCondicionVenta)
                SQLtoNET(myDataRecord, "@tipoCliente", .tipoCliente)
                SQLtoNET(myDataRecord, "@codigo", .codigo)
                SQLtoNET(myDataRecord, "@idcuentaMonedaExt", .idcuentaMonedaExt)
                SQLtoNET(myDataRecord, "@Cobrador", .Cobrador)


                SQLtoNET(myDataRecord, "@Auxiliar", .Auxiliar)
                SQLtoNET(myDataRecord, "@IdIBCondicionPorDefecto2", .IdIBCondicionPorDefecto2)
                SQLtoNET(myDataRecord, "@IdIBCondicionPorDefecto3", .IdIBCondicionPorDefecto3)

                Dim sTemp As String
                SQLtoNET(myDataRecord, "@esAgenteRetencionIVA", sTemp)
                IIf(iisNull(sTemp, "NO") = "SI", True, False)

                SQLtoNET(myDataRecord, "@BaseMinimaParaPercepcionIVA", .BaseMinimaParaPercepcionIVA)
                SQLtoNET(myDataRecord, "@PorcentajePercepcionIVA", .PorcentajePercepcionIVA)
                SQLtoNET(myDataRecord, "@idbancoDebito", .idbancoDebito)
                SQLtoNET(myDataRecord, "@CBU", .CBU)
                SQLtoNET(myDataRecord, "@Cobrador", .Cobrador)


                Try
                    SQLtoNET(myDataRecord, "@PorcentajeIBDirectoCapital", .PorcentajeIBDirectoCapital)
                    SQLtoNET(myDataRecord, "@FechaInicioVigenciaIBDirectoCapital", .FechaInicioVigenciaIBDirectoCapital)
                    SQLtoNET(myDataRecord, "@FechaFinVigenciaIBDirectoCapital", .FechaFinVigenciaIBDirectoCapital)
                    SQLtoNET(myDataRecord, "@GrupoIIBBCapital", .GrupoIIBBCapital)


                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try



                Return myCliente
            End With
        End Function


        Public Shared Function Save(ByVal SC As String, ByVal myCliente As Pronto.ERP.BO.Cliente) As Integer



            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand
                With myCliente


                    If .Id = -1 Then

                        myCommand = New SqlCommand("wClientes_A", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdCliente", -1)
                        param.Direction = ParameterDirection.Output

                    Else

                        myCommand = New SqlCommand("wClientes_M", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        myCommand.Parameters.AddWithValue("@IdCliente", .Id)
                    End If



                    NETtoSQL(myCommand, "@RazonSocial", .RazonSocial)
                    NETtoSQL(myCommand, "@Direccion", .Direccion)
                    NETtoSQL(myCommand, "@IdLocalidad", .IdLocalidad)
                    NETtoSQL(myCommand, "@CodigoPostal", .CodigoPostal)
                    NETtoSQL(myCommand, "@IdProvincia", .IdProvincia)
                    NETtoSQL(myCommand, "@IdPais", .IdPais)
                    NETtoSQL(myCommand, "@Telefono", .Telefono1)
                    NETtoSQL(myCommand, "@Fax", .Fax)
                    NETtoSQL(myCommand, "@Email", .Email)
                    NETtoSQL(myCommand, "@Cuit", .Cuit)
                    NETtoSQL(myCommand, "@IdCodigoIva", .IdCodigoIva)
                    NETtoSQL(myCommand, "@FechaAlta", .FechaAlta)
                    NETtoSQL(myCommand, "@Contacto", .Contacto)
                    NETtoSQL(myCommand, "@EnviarEmail", .EnviarEmail)
                    NETtoSQL(myCommand, "@IdCuenta", .IdCuenta)
                    NETtoSQL(myCommand, "@IGCondicion", .IGCondicion)



                    NETtoSQL(myCommand, "@IdMoneda", .IdMoneda)
                    NETtoSQL(myCommand, "@IBNumeroInscripcion", .IBNumeroInscripcion)
                    NETtoSQL(myCommand, "@IBCondicion", .IBCondicion)
                    NETtoSQL(myCommand, "@IdUsuarioIngreso", .IdUsuarioIngreso)
                    NETtoSQL(myCommand, "@FechaIngreso", .FechaIngreso)





                    NETtoSQL(myCommand, "@IdUsuarioModifico", .IdUsuarioModifico)
                    NETtoSQL(myCommand, "@FechaModifico", .FechaModifico)
                    NETtoSQL(myCommand, "@PorcentajeIBDirecto", .PorcentajeIBDirecto)
                    NETtoSQL(myCommand, "@FechaInicioVigenciaIBDirecto", .FechaInicioVigenciaIBDirecto)
                    NETtoSQL(myCommand, "@FechaFinVigenciaIBDirecto", .FechaFinVigenciaIBDirecto)
                    NETtoSQL(myCommand, "@GrupoIIBB", .GrupoIIBB)
                    NETtoSQL(myCommand, "@IdListaPrecios", .IdListaPrecios)
                    NETtoSQL(myCommand, "@IdIBCondicionPorDefecto", .IdIBCondicionPorDefecto)
                    NETtoSQL(myCommand, "@Confirmado", .Confirmado)
                    NETtoSQL(myCommand, "@CodigoPresto", .CodigoPresto)
                    NETtoSQL(myCommand, "@Observaciones", .Observaciones)
                    NETtoSQL(myCommand, "@Importaciones_NumeroInscripcion", .Importaciones_NumeroInscripcion)



                    NETtoSQL(myCommand, "@Importaciones_DenominacionInscripcion", .Importaciones_DenominacionInscripcion)
                    NETtoSQL(myCommand, "@IdEstado", .IdEstado)
                    NETtoSQL(myCommand, "@NombreFantasia", .NombreFantasia)
                    NETtoSQL(myCommand, "@DireccionEntrega", .DireccionEntrega)
                    NETtoSQL(myCommand, "@IdLocalidadEntrega", .IdLocalidadEntrega)
                    NETtoSQL(myCommand, "@IdProvinciaEntrega", .IdProvinciaEntrega)
                    NETtoSQL(myCommand, "@CodigoCliente", .CodigoCliente)
                    NETtoSQL(myCommand, "@Saldo", .Saldo)
                    NETtoSQL(myCommand, "@saldoDocumentos", .saldoDocumentos)


                    NETtoSQL(myCommand, "@Vendedor1", .Vendedor1)
                    NETtoSQL(myCommand, "@creditoMaximo", .creditoMaximo)
                    NETtoSQL(myCommand, "@IdCondicionVenta", .IdCondicionVenta)
                    NETtoSQL(myCommand, "@tipoCliente", .tipoCliente)
                    NETtoSQL(myCommand, "@codigo", .codigo)
                    NETtoSQL(myCommand, "@idcuentaMonedaExt", .idcuentaMonedaExt)
                    NETtoSQL(myCommand, "@Cobrador", .Cobrador)


                    NETtoSQL(myCommand, "@Auxiliar", .Auxiliar)
                    NETtoSQL(myCommand, "@IdIBCondicionPorDefecto2", .IdIBCondicionPorDefecto2)
                    NETtoSQL(myCommand, "@IdIBCondicionPorDefecto3", .IdIBCondicionPorDefecto3)
                    NETtoSQL(myCommand, "@esAgenteRetencionIVA", IIf(.esAgenteRetencionIVA, "SI", "NO"))
                    NETtoSQL(myCommand, "@BaseMinimaParaPercepcionIVA", .BaseMinimaParaPercepcionIVA)
                    NETtoSQL(myCommand, "@PorcentajePercepcionIVA", .PorcentajePercepcionIVA)
                    NETtoSQL(myCommand, "@idbancoDebito", .idbancoDebito)
                    NETtoSQL(myCommand, "@CBU", .CBU)


                    Try
                        NETtoSQL(myCommand, "@PorcentajeIBDirectoCapital", .PorcentajeIBDirectoCapital)
                        NETtoSQL(myCommand, "@FechaInicioVigenciaIBDirectoCapital", .FechaInicioVigenciaIBDirectoCapital)
                        NETtoSQL(myCommand, "@FechaFinVigenciaIBDirectoCapital", .FechaFinVigenciaIBDirectoCapital)
                        NETtoSQL(myCommand, "@GrupoIIBBCapital", .GrupoIIBBCapital)


                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try



                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    'For Each myOrdenPagoItem As OrdenPagoItem In myOrdenPago.DetallesImputaciones
                    '    myOrdenPagoItem.IdOrdenPago = result




                    '    If myOrdenPagoItem.Eliminado Then
                    '        'EntidadManager.GetStoreProcedure(SC, "DetOrdenPagos_E", .Id)
                    '    Else
                    '        Dim IdAntesDeGrabar = myOrdenPagoItem.Id
                    '        myOrdenPagoItem.Id = OrdenPagoItemDB.Save(SC, myOrdenPagoItem)


                    '        'Como un item nuevo consiguió un nuevo id al grabarse, 
                    '        'lo tengo que refrescar en el resto de las colecciones
                    '        'de imputacion (en el prontovb6, se usaba -100,-101,etc)
                    '        '-OK, eso si los items del resto de las colecciones (Valores,Cuentas)
                    '        'estuviesen imputadas contra la de Imputaciones. Pero, de donde demonios saqué
                    '        'que esto es así?

                    '        'For Each o As OrdenPagoAnticiposAlPersonalItem In .DetallesAnticiposAlPersonal
                    '        '    If o. = IdAntesDeGrabar Then
                    '        '        o. = myOrdenPagoItem.Id
                    '        '    End If
                    '        'Next

                    '        'For Each o As OrdenPagoCuentasItem In .DetallesCuentas
                    '        '    If o. = IdAntesDeGrabar Then
                    '        '        o. = myOrdenPagoItem.Id
                    '        '    End If
                    '        'Next
                    '    End If
                    'Next


                    ''//////////////////////////////////////////////////////////////////////////////////////
                    'Colecciones adicionales
                    ''//////////////////////////////////////////////////////////////////////////////////////

                    'For Each myOrdenPagoAnticiposAlPersonalItem As OrdenPagoAnticiposAlPersonalItem In myOrdenPago.DetallesAnticiposAlPersonal
                    '    myOrdenPagoAnticiposAlPersonalItem.IdOrdenPago = result
                    '    OrdenPagoAnticiposAlPersonalItemDB.Save(SC, myOrdenPagoAnticiposAlPersonalItem)
                    'Next
                    'For Each myOrdenPagoCuentasItem As OrdenPagoCuentasItem In myOrdenPago.DetallesCuentas
                    '    myOrdenPagoCuentasItem.IdOrdenPago = result
                    '    OrdenPagoCuentasItemDB.Save(SC, myOrdenPagoCuentasItem)
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
    End Class
End Namespace





