﻿
Option Infer On

Imports System
Imports System.Web
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Configuration
Imports System.Linq   '"namespace or type specified in ... doesn't contain any " -Sorry Linq is only available in .net 3.5 http://forums.asp.net/t/1332780.aspx  Advanced Compile Options
Imports System.Data.Linq 'lo necesita el CompileQuery?
Imports ADODB.DataTypeEnum
Imports System.Diagnostics
Imports System.Data
Imports System.Data.DataSetExtensions
Imports Microsoft.Reporting.WebForms
Imports System.IO

Imports System.Data.SqlClient

Imports System.Web.Security
Imports System.Security

Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager

Imports ClaseMigrar.SQLdinamico

'Namespace Pronto.ERP.Bll

Imports System.Collections.Generic

Imports System.Xml
Imports System.Text
Imports System.Security.Cryptography

Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging
Imports OpenXmlPowerTools
Imports DocumentFormat.OpenXml.Drawing.Wordprocessing

Imports System.Web.UI.WebControls

Imports Word = Microsoft.Office.Interop.Word
Imports Excel = Microsoft.Office.Interop.Excel


Imports CartaDePorteManager



<DataObjectAttribute()> _
<Transaction(TransactionOption.Required)> _
Public Class CartaDePorteManager
    Inherits ServicedComponent

    'Shared dt As DataTable

    Public Const SESSIONPRONTO_UserId = "UserId"
    Public Const SESSIONPRONTO_USUARIO = "USUARIO"
    Public Const SESSIONPRONTO_NombreEmpresa = "NombreEmpresa"
    Public Const SESSIONPRONTO_glbIdObraAsignadaUsuario = "glbIdObraAsignadaUsuario"
    Public Const SESSIONPRONTO_glbIdUsuario = "glbIdUsuario"
    Public Const SESSIONPRONTO_UserName = "UserName"
    Public Const SESSIONPRONTO_MiRequestUrl = "MiRequestUrl"


    Public Const SESSIONPRONTO_Filtro = "Filtro"
    Public Const SESSIONPRONTO_Busqueda = "Busqueda"
    Public Const SESSIONPRONTO_glbLegajo = "glbLegajo"
    Public Const SESSIONPRONTO_glbWebCUIT = "glbWebCUIT"
    Public Const SESSIONPRONTO_glbPathPlantillas = "glbPathPlantillas"
    Public Const SESSIONPRONTO_IdEmpleado = "IdEmpleado"
    Public Const SESSIONPRONTO_SelectedIndexAnteriorDelAcordion = "SelectedIndexAnteriorDelAcordion"
    Public Const SESSIONPRONTO_glbWebRazonSocial = "glbWebRazonSocial"
    Public Const SESSIONPRONTO_glbIdWebProveedor = "glbIdWebProveedor"
    Public Const SESSIONPRONTO_glbIdCuentaFFUsuario = "glbIdCuentaFFUsuario"
    Public Const SESSIONPRONTO_glbIdSector = "glbIdSector"
    Public Const SESSIONPRONTO_glbWebIdProveedor = "glbWebIdProveedor"

    Public Const SESSIONPRONTO_DirectorioFTP = "DirectorioFTP"

    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////



    'Public Const _CONST_MAXROWS = 100000  'hace falta levantar la cantidad de filas que levanto (15000!), por compensar la falta de paginacion?
    '                                   en todo caso, estaría bueno aumentar tambien el timeout...

    Public Shared ReadOnly Property _CONST_MAXROWS As Long
        Get
            Return ConfigurationManager.AppSettings("_CONST_MAXROWS")
        End Get
    End Property



    Public Const CONSTANTE_HTML = False


    'cuestion con la opcion "AMBAS" vs ""

    'Public Shared excepciones As String() ' = New String() {"", "Agro", "Seeds", "CDC Pehua.", "CDC Olavar", "CDC Naon", "CDC G.Vill", "CDC Iriart", "CDC Wright", "CDC ACA", "GUALEGUAY", "GLGUAYCHU", "Rufino", "Bragado", "Las Flores", "OTROS"} 'usar como maximo 10 caracteres, por sql



    Sub New(ByVal s As String)
        'excepciones = New String() {"", "Agro", "Seeds", "CDC Pehua.", "CDC Olavar", "CDC Naon", "CDC G.Vill", "CDC Iriart", "CDC Wright", "CDC ACA", "GUALEGUAY", "GLGUAYCHU", "OTROS"} 'usar como maximo 10 caracteres, por sql
        'excepciones = ConfigurationManager.AppSettings("WilliamsAcopios").Split(",")



    End Sub




    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    'por ahora están en una lista, hay que pasarlos a una tabla

    Public Shared Property excepciones As String()
        Get
            Return ConfigurationManager.AppSettings("WilliamsAcopios").Split(",") 'verificar que no se pasen de 10 caracteres
        End Get
        Set(ByVal excepciones As String())
            'newPropertyValue = value
        End Set
    End Property

    Shared Function BuscarIdAcopio(descripcionAcopio As String) As Integer
        'excepciones.Where(Function(x) x = descripcionAcopio).FirstOrDefault()
        Dim s As String() = excepciones
        For n = 0 To excepciones.Count - 1
            If s(n) = descripcionAcopio Then Return n
        Next
        Return -1
    End Function

    Shared Function BuscarTextoAcopio(IdAcopio As Integer) As String
        If IdAcopio < 0 Then Return ""
        Try
            Return excepciones(IdAcopio)
        Catch ex As Exception
            Return ""
        End Try
    End Function


    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    'Esta es la funcion estrella que debería canalizar todos los filtros. Tipar bien bien
    Public Shared Function GetDataTableFiltradoYPaginado( _
            ByVal SC As String, _
            ByVal ColumnaParaFiltrar As String, _
            ByVal TextoParaFiltrar As String, _
            ByVal sortExpression As String, _
            ByVal startRowIndex As Long, _
            ByVal maximumRows As Long, _
            ByVal estado As EntidadManager.enumCDPestado, _
            ByVal QueContenga As String, _
            ByVal idVendedor As Integer, _
            ByVal idCorredor As Integer, _
            ByVal idDestinatario As Integer, _
            ByVal idIntermediario As Integer, _
            ByVal idRemComercial As Integer, _
            ByVal idArticulo As Integer, _
            ByVal idProcedencia As Integer, _
            ByVal idDestino As Integer, _
            ByVal AplicarANDuORalFiltro As FiltroANDOR, _
            ByVal ModoExportacion As String, _
            ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
            ByVal puntoventa As Integer, Optional ByRef sTituloFiltroUsado As String = "", _
            Optional ByVal optDivisionSyngenta As String = "Ambas", _
            Optional ByVal bTraerDuplicados As Boolean = False, _
            Optional ByVal Contrato As String = "", _
            Optional ByVal QueContenga2 As String = "", _
            Optional ByVal idClienteAuxiliar As Integer = -1, _
            Optional ByVal AgrupadorDeTandaPeriodos As Integer = -1, _
            Optional ByVal Vagon As Integer = Nothing, Optional ByVal Patente As String = "", _
            Optional bInsertarEnTablaTemporal As Boolean = False _
                    ) As DataTable

        'ojo al agregar parametros opcionales http://stackoverflow.com/questions/9884664/system-missingmethodexception-after-adding-an-optional-parameter
        'ojo al agregar parametros opcionales http://stackoverflow.com/questions/9884664/system-missingmethodexception-after-adding-an-optional-parameter
        'ojo al agregar parametros opcionales http://stackoverflow.com/questions/9884664/system-missingmethodexception-after-adding-an-optional-parameter
        'ojo al agregar parametros opcionales http://stackoverflow.com/questions/9884664/system-missingmethodexception-after-adding-an-optional-parameter
        'ojo al agregar parametros opcionales http://stackoverflow.com/questions/9884664/system-missingmethodexception-after-adding-an-optional-parameter


        sTituloFiltroUsado = ""





        Dim sWHERE As String = CartaDePorteManager.generarWHEREparaDatasetParametrizado(SC, _
                              sTituloFiltroUsado, _
                              estado, QueContenga, idVendedor, idCorredor, _
                              idDestinatario, idIntermediario, _
                              idRemComercial, idArticulo, idProcedencia, idDestino, _
                              AplicarANDuORalFiltro, ModoExportacion, _
                              fechadesde, fechahasta, _
                               puntoventa, optDivisionSyngenta, bTraerDuplicados, Contrato, QueContenga2, idClienteAuxiliar, Vagon, Patente)



        '///////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////
        '        metodo 1 
        '       If AgrupadorDeTandaPeriodos <> -1 Then sWHERE &= " AND AgrupadorDeTandaPeriodos=" & AgrupadorDeTandaPeriodos
        '
        '     metodo 2
        If AgrupadorDeTandaPeriodos <> -1 Then

            'cómo puede ser que este dt traiga informacion repetida
            'https://mail.google.com/mail/u/0/#inbox/13f5c9dc24580285
            'gran sospecha de que haya sido por este inner join
            'lo que podría poner es un indice unique en CartasDePorteMailClusters que impida que se dupliquen


            sWHERE = " INNER JOIN CartasDePorteMailClusters CLUST " & _
                     "       ON CDP.IdCartaDePorte = CLUST.IdCartaDePorte AND   " & _
                     "       CLUST.AgrupadorDeTandaPeriodos=" & AgrupadorDeTandaPeriodos & "        WHERE " & sWHERE



        Else
            sWHERE = " WHERE " & sWHERE

        End If
        '///////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////


        Try

            Dim dt As DataTable



            dt = GetListDataTableDinamicoConWHERE_2(SC, estado, sWHERE, bInsertarEnTablaTemporal, maximumRows)  'de ultima se puede safar con esto tambien...





            'If maximumRows > 0 Or startRowIndex > 0 Then
            '    dt = (From r In dt.AsEnumerable Skip startRowIndex Take maximumRows)
            'End If


            'If estado = EntidadManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones Then
            '    dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_DescargasDeHoyMasTodasLasPosiciones", Today)
            '    sWHERE = sWHERE.Replace("CDP.", "")
            '    dt = DataTableWHERE(dt, sWHERE)

            'ElseIf estado = EntidadManager.enumCDPestado.Posicion Then
            '    dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_Posiciones", iisValidSqlDate(fechadesde, #1/1/1753#), iisValidSqlDate(fechahasta, #1/1/2100#))
            '    sWHERE = sWHERE.Replace("CDP.", "")
            '    dt = DataTableWHERE(dt, sWHERE)

            'ElseIf False Then
            '    dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_Todas", -1, iisValidSqlDate(fechadesde, #1/1/1753#), iisValidSqlDate(fechahasta, #1/1/2100#))
            '    sWHERE = sWHERE.Replace("CDP.", "")
            '    dt = DataTableWHERE(dt, sWHERE)

            'Else

            '    'GetListDatasetWHERE()
            '    'EstadoWHERE()
            '    'sWHERE = sWHERE.Replace("CDP.", "")
            '    sWHERE += "    AND (isnull(FechaDescarga, FechaArribo) Between '" & iisValidSqlDate(fechadesde, #1/1/1753#) & "' AND '" & iisValidSqlDate(fechahasta, #1/1/2100#) & "')"
            '    'sWHERE = sWHERE.Replace("WHERE", "")
            '    dt = GetListDataTableDinamicoConWHERE_2(SC, estado, "WHERE " & sWHERE)  'de ultima se puede safar con esto tambien...
            'End If


            Return dt
        Catch ex As Exception
            'loguear el filtro que se intentó usar:
            Debug.Print(ex.ToString)


            Dim tipo As String = ConfigurationManager.AppSettings("AvisoTipoDeSitioDesarrolloDebugTestReleaseExterno")


            Dim s = If(Membership.GetUser IsNot Nothing, Membership.GetUser.UserName, "<nadie>") & " Error en GetDataTableFiltradoYPaginado.  maxrows " & maximumRows & " en " & tipo & ". Probable timeout.         ver si el error es de system memory " & _
                                          "o de report processing, recomendar reinicio del IIS por las sesiones con basura. " & _
                                          "Incluir sp_who2. Filtro: " & sTituloFiltroUsado & "   periodo " & fechadesde.ToString & " " & fechahasta.ToString & "Error: " & ex.ToString & "      " & sWHERE


            MandarMailDeError(s)

            ErrHandler.WriteAndRaiseError(s)

            'nohay manera de saber qué instancia lo tiró, si el de clientes o el normal? no hay manera de saber (en el mail) si fue desde un sincro, un informe,
            '    o la facturacion, etc?



        End Try




    End Function






    'ReadOnly s_compQuery = CompiledQuery.Compile(Of CartasDePortes, Decimal, IQueryable(Of CartasDePorte))( _
    '        Function(cdp, mySearchParams) _
    '            From sale In cdp.CartasDePortes _
    '            Where (mySearchParams = -1 Or cdp.Vendedor = mySearchParams) _
    '            Select sale)
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Public Shared Function CartasLINQ(ByVal SC As String, _
            ByVal ColumnaParaFiltrar As String, _
            ByVal TextoParaFiltrar As String, _
            ByVal sortExpression As String, _
            ByVal startRowIndex As Long, _
            ByVal maximumRows As Long, _
            ByVal estado As EntidadManager.enumCDPestado, _
            ByVal QueContenga As String, _
            ByVal idVendedor As Integer, _
            ByVal idCorredor As Integer, _
            ByVal idDestinatario As Integer, _
            ByVal idIntermediario As Integer, _
            ByVal idRemComercial As Integer, _
            ByVal idArticulo As Integer, _
            ByVal idProcedencia As Integer, _
            ByVal idDestino As Integer, _
            ByVal AplicarANDuORalFiltro As FiltroANDOR, _
            ByVal ModoExportacion As String, _
            ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
            ByVal puntoventa As Integer, _
            Optional ByRef sTituloFiltroUsado As String = "", _
            Optional ByVal optDivisionSyngenta As String = "Ambas", _
            Optional ByVal bTraerDuplicados As Boolean = False, _
            Optional ByVal Contrato As String = "", _
            Optional ByVal QueContenga2 As String = "", _
            Optional ByVal idClienteAuxiliar As Integer = -1, _
            Optional ByVal AgrupadorDeTandaPeriodos As Integer = -1, _
            Optional ByVal Vagon As Integer = Nothing, Optional ByVal Patente As String = "" _
    ) As IQueryable(Of CartasDePorte)

        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


        '       Remember, the query is nothing more than an object which represents the query. Think of it 
        'like a SQL query string, just way smarter. Passing a query string around doesn't execute the query; executing 
        'the query executes the query. – Eric Lippert J

        'http://www.codinghorror.com/blog/2010/03/compiled-or-bust.html
        'I must admit, these results seem ... unbelievable. Querying the database is so slow (relative 
        'to typical code execution) that if you have to ask how long it will take, you can't afford it. I have a 
        'very hard time accepting the idea that dynamically parsing a Linq query would take longer than round-tripping 
        'to the database. Pretend I'm from Missouri: show me. Because I am unconvinced.

        'Parece que tarda banda en hacer el parsing de la linq. La consulta SQL generada se ejecuta rapido

        'Para compilar la LINQ, necesito dejar de devolver un anonymous type


        ' What 's the problem? Well…
        '           CompiledQuery can't project to anonymous types
        '           Itdoesn't work in dynamic scenarios where criteria are added based on e.g an input form
        '           The delegate can only take 3 input parameters (can be solved by wrapping the parameters in containers)
        '           And above all… Developers are lazy….Well, not all, but many. I know I am..

        Dim q As IQueryable(Of CartasDePorte) = From cdp In db.CartasDePortes _
    Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor _
    From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
    From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
    From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
    From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
    From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
    From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
    From cal In db.Calidades.Where(Function(i) i.IdCalidad = CInt(cdp.Calidad)).DefaultIfEmpty _
    From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
    From estab In db.linqCDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
    From tr In db.Transportistas.Where(Function(i) i.IdTransportista = cdp.IdTransportista).DefaultIfEmpty _
    From loc In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(cdp.Procedencia)).DefaultIfEmpty _
    From chf In db.Choferes.Where(Function(i) i.IdChofer = cdp.IdChofer).DefaultIfEmpty _
    From emp In db.linqEmpleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty _
    Where _
        cdp.Vendedor > 0 _
        And cli.RazonSocial IsNot Nothing _
        And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
        And (cdp.Anulada <> "SI") _
        And (ModoExportacion <> "Entregas" Or cdp.Exporta <> "SI") _
        And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
        And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
        And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
        And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
        And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
        And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
        And (idDestino = -1 Or cdp.Destino = idDestino) _
        And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
    Select cdp



        'Select  New CartaDePorte With { _
        ' .Id = cdp.IdCartaDePorte, _
        '.NumeroCartaDePorte = cdp.NumeroCartaDePorte, _
        '.NumeroSubfijo = cdp.NumeroSubfijo, _
        ' .SubnumeroVagon = cdp.SubnumeroVagon, _
        ' .FechaArribo = cdp.FechaArribo, _
        '.FechaModificacion = cdp.FechaModificacion, _
        '.FechaDescarga = cdp.FechaDescarga _
        ' } Skip startRowIndex Take maximumRows

        '.Articulo = art.Descripcion, _
        '   .Obs = cdp.Observaciones, _
        '    .NetoFinal = cdp.NetoFinal, _
        '            .TitularDesc = clitit.RazonSocial, _
        '    .IntermediarioDesc = cliint.RazonSocial, _
        '    .RComercialDesc = clircom.RazonSocial, _
        '    .CorredorDesc = corr.Nombre, _
        '    .DestinatarioDesc = clidest.RazonSocial, _
        '    .ProcedenciaDesc = loc.Nombre, _
        '    .DestinoDesc = dest.Descripcion, _
        '      .CalidadDesc = cal.Descripcion, _
        '   .UsuarioIngreso = emp.Nombre _


        Return q
    End Function



    Shared Function CartasLINQlocal(ByVal SC As String, _
            ByVal ColumnaParaFiltrar As String, _
            ByVal TextoParaFiltrar As String, _
            ByVal sortExpression As String, _
            ByVal startRowIndex As Long, _
            ByVal maximumRows As Long, _
            ByVal estado As EntidadManager.enumCDPestado, _
            ByVal QueContenga As String, _
            ByVal idVendedor As Integer, _
            ByVal idCorredor As Integer, _
            ByVal idDestinatario As Integer, _
            ByVal idIntermediario As Integer, _
            ByVal idRemComercial As Integer, _
            ByVal idArticulo As Integer, _
            ByVal idProcedencia As Integer, _
            ByVal idDestino As Integer, _
            ByVal AplicarANDuORalFiltro As FiltroANDOR, _
            ByVal ModoExportacion As String, _
            ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
            ByVal puntoventa As Integer, _
            Optional ByRef sTituloFiltroUsado As String = "", _
            Optional ByVal optDivisionSyngenta As String = "Ambas", _
            Optional ByVal bTraerDuplicados As Boolean = False, _
            Optional ByVal Contrato As String = "") As Object

        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


        '       Remember, the query is nothing more than an object which represents the query. Think of it 
        'like a SQL query string, just way smarter. Passing a query string around doesn't execute the query; executing 
        'the query executes the query. – Eric Lippert J

        'por qué no uso una vista?

        Dim q = From cdp In db.CartasDePortes _
    Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor _
    From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
    From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
    From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
    From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
    From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
    From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
    From cal In db.Calidades.Where(Function(i) i.IdCalidad = cdp.Calidad).DefaultIfEmpty _
    From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
    From estab In db.linqCDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
    From tr In db.Transportistas.Where(Function(i) i.IdTransportista = cdp.IdTransportista).DefaultIfEmpty _
    From loc In db.Localidades.Where(Function(i) i.IdLocalidad = cdp.Procedencia).DefaultIfEmpty _
    From chf In db.Choferes.Where(Function(i) i.IdChofer = cdp.IdChofer).DefaultIfEmpty _
    From emp In db.linqEmpleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty _
    Where _
        cdp.Vendedor > 0 _
        And cli.RazonSocial IsNot Nothing _
        And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
        And (cdp.Anulada <> "SI") _
        And (ModoExportacion <> "Entregas" Or cdp.Exporta <> "SI") _
        And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
        And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
        And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
        And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
        And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
        And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
        And (idDestino = -1 Or cdp.Destino = idDestino) _
        And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
    Order By cdp.FechaModificacion Descending _
    Select New With { _
        .Producto = art.Descripcion, .id = cdp.IdCartaDePorte, _
        cdp.NumeroCartaDePorte, cdp.NumeroSubfijo, cdp.SubnumeroVagon, _
        cdp.FechaArribo, cdp.FechaModificacion, cdp.FechaDescarga, _
            .Obs = cdp.Observaciones, _
            .NetoFinal = cdp.NetoFinal, _
                    .TitularDesc = clitit.RazonSocial, _
            .IntermediarioDesc = cliint.RazonSocial, _
            .RComercialDesc = clircom.RazonSocial, _
            .CorredorDesc = corr.Nombre, _
            .DestinatarioDesc = clidest.RazonSocial, _
            .ProcedenciaDesc = loc.Nombre, _
            .DestinoDesc = dest.Descripcion, _
              .CalidadDesc = cal.Descripcion, _
           .UsuarioIngreso = emp.Nombre _
        } Skip startRowIndex Take maximumRows

        Return q
    End Function


    Shared Function CartasLINQlocalSimplificado(ByVal SC As String, _
          ByVal ColumnaParaFiltrar As String, _
          ByVal TextoParaFiltrar As String, _
          ByVal sortExpression As String, _
          ByVal startRowIndex As Long, _
          ByVal maximumRows As Long, _
          ByVal estado As EntidadManager.enumCDPestado, _
          ByVal QueContenga As String, _
          ByVal idVendedor As Integer, _
          ByVal idCorredor As Integer, _
          ByVal idDestinatario As Integer, _
          ByVal idIntermediario As Integer, _
          ByVal idRemComercial As Integer, _
          ByVal idArticulo As Integer, _
          ByVal idProcedencia As Integer, _
          ByVal idDestino As Integer, _
          ByVal AplicarANDuORalFiltro As FiltroANDOR, _
          ByVal ModoExportacion As String, _
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
          ByVal puntoventa As Integer, _
          Optional ByRef sTituloFiltroUsado As String = "", _
          Optional ByVal optDivisionSyngenta As String = "Ambas", _
          Optional ByVal bTraerDuplicados As Boolean = False, _
          Optional ByVal Contrato As String = "") As Object



        Using db As New LinqCartasPorteDataContext(Encriptar(SC))
            db.ObjectTrackingEnabled = False


            '       Remember, the query is nothing more than an object which represents the query. Think of it 
            'like a SQL query string, just way smarter. Passing a query string around doesn't execute the query; executing 
            'the query executes the query. – Eric Lippert J

            'y qué pasa si vuelvo a usar Equals? (en lugar de DefaultIfEmpty que me permite traer los nulls)

            Dim q = From cdp In db.CartasDePortes _
                    From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                    From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                    From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
                    From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
                    From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
                    From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
                    From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                    From loc In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(cdp.Procedencia)).DefaultIfEmpty _
                    From cal In db.Calidades.Where(Function(i) i.IdCalidad = cdp.Calidad).DefaultIfEmpty _
                    Where _
                cdp.Vendedor > 0 _
                And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
                And (cdp.Anulada <> "SI") _
                And (ModoExportacion <> "Entregas" Or cdp.Exporta <> "SI") _
                And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
                And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                And (idDestino = -1 Or cdp.Destino = idDestino) _
                And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
                Order By cdp.FechaModificacion Descending _
                Select New With { _
                .Producto = "", .id = cdp.IdCartaDePorte, _
                cdp.NumeroCartaDePorte, cdp.NumeroSubfijo, cdp.SubnumeroVagon, _
                cdp.FechaArribo, cdp.FechaModificacion, cdp.FechaDescarga, _
                .Obs = cdp.Observaciones, _
                .NetoFinal = cdp.NetoFinal, _
                        .TitularDesc = clitit.RazonSocial, _
                .IntermediarioDesc = cliint.RazonSocial, _
                .RComercialDesc = clircom.RazonSocial, _
                .CorredorDesc = corr.Nombre, _
                .DestinatarioDesc = clidest.RazonSocial, _
                .ProcedenciaDesc = loc.Nombre, _
                .DestinoDesc = dest.Descripcion, _
                  .CalidadDesc = "", _
               .UsuarioIngreso = "" _
            } Skip startRowIndex Take maximumRows

            Dim resq = q.ToList

            If False Then
                'Dim lista = From c In resq Select ID
                ''si la lista es chica (por ejemplo, paginada para la gridview, en lugar del socotroco que pediría una exportacion de sincro) quizas
                ''sirve hacer el join despues del select.....
                'Dim q2 = From cdp In db.CartasDePortes _
                '          From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                '        From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                '        From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
                '        From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
                '        From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
                '        From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
                '        From cal In db.Calidades.Where(Function(i) i.IdCalidad = cdp.Calidad).DefaultIfEmpty _
                '        From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                '        From estab In db.linqCDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
                '        From tr In db.Transportistas.Where(Function(i) i.IdTransportista = cdp.IdTransportista).DefaultIfEmpty _
                '        From loc In db.Localidades.Where(Function(i) i.IdLocalidad = cdp.Procedencia).DefaultIfEmpty _
                '        From chf In db.Choferes.Where(Function(i) i.IdChofer = cdp.IdChofer).DefaultIfEmpty _
                '        From emp In db.linqEmpleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty() _
                '        Where lista.Contains(cdp.IdCartaDePorte)

                'Dim aa = q2.ToList
            End If

            Return resq 'hago el tolist porque estoy en un using
        End Using
    End Function


    Shared Function CartasLINQlocalSimplificadoPrimeraPagina(ByVal SC As String, _
          ByVal ColumnaParaFiltrar As String, _
          ByVal TextoParaFiltrar As String, _
          ByVal sortExpression As String, _
          ByVal startRowIndex As Long, _
          ByVal maximumRows As Long, _
          ByVal estado As EntidadManager.enumCDPestado, _
          ByVal QueContenga As String, _
          ByVal idVendedor As Integer, _
          ByVal idCorredor As Integer, _
          ByVal idDestinatario As Integer, _
          ByVal idIntermediario As Integer, _
          ByVal idRemComercial As Integer, _
          ByVal idArticulo As Integer, _
          ByVal idProcedencia As Integer, _
          ByVal idDestino As Integer, _
          ByVal AplicarANDuORalFiltro As FiltroANDOR, _
          ByVal ModoExportacion As String, _
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
          ByVal puntoventa As Integer, _
          Optional ByRef sTituloFiltroUsado As String = "", _
          Optional ByVal optDivisionSyngenta As String = "Ambas", _
          Optional ByVal bTraerDuplicados As Boolean = False, _
          Optional ByVal Contrato As String = "") As Object



        Using db As New LinqCartasPorteDataContext(Encriptar(SC))
            db.ObjectTrackingEnabled = False


            '       Remember, the query is nothing more than an object which represents the query. Think of it 
            'like a SQL query string, just way smarter. Passing a query string around doesn't execute the query; executing 
            'the query executes the query. – Eric Lippert J

            'y qué pasa si vuelvo a usar Equals? (en lugar de DefaultIfEmpty que me permite traer los nulls)

            Dim q = From cdp In db.CartasDePortes _
                    From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                    From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                    From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
                    From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
                    From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
                    From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
                    From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                    From loc In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(cdp.Procedencia)).DefaultIfEmpty _
                Order By cdp.FechaModificacion Descending _
                Select New With { _
                .Producto = "", .id = cdp.IdCartaDePorte, _
                cdp.NumeroCartaDePorte, cdp.NumeroSubfijo, cdp.SubnumeroVagon, _
                cdp.FechaArribo, cdp.FechaModificacion, cdp.FechaDescarga, _
                .Obs = cdp.Observaciones, _
                .NetoFinal = cdp.NetoFinal, _
                        .TitularDesc = clitit.RazonSocial, _
                .IntermediarioDesc = cliint.RazonSocial, _
                .RComercialDesc = clircom.RazonSocial, _
                .CorredorDesc = corr.Nombre, _
                .DestinatarioDesc = clidest.RazonSocial, _
                .ProcedenciaDesc = loc.Nombre, _
                .DestinoDesc = dest.Descripcion, _
               .UsuarioIngreso = "" _
            } Skip startRowIndex Take maximumRows

            Dim resq = q.ToList

            If False Then
                'Dim lista = From c In resq Select ID
                ''si la lista es chica (por ejemplo, paginada para la gridview, en lugar del socotroco que pediría una exportacion de sincro) quizas
                ''sirve hacer el join despues del select.....
                'Dim q2 = From cdp In db.CartasDePortes _
                '          From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                '        From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                '        From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
                '        From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
                '        From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
                '        From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
                '        From cal In db.Calidades.Where(Function(i) i.IdCalidad = cdp.Calidad).DefaultIfEmpty _
                '        From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                '        From estab In db.linqCDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
                '        From tr In db.Transportistas.Where(Function(i) i.IdTransportista = cdp.IdTransportista).DefaultIfEmpty _
                '        From loc In db.Localidades.Where(Function(i) i.IdLocalidad = cdp.Procedencia).DefaultIfEmpty _
                '        From chf In db.Choferes.Where(Function(i) i.IdChofer = cdp.IdChofer).DefaultIfEmpty _
                '        From emp In db.linqEmpleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty() _
                '        Where lista.Contains(cdp.IdCartaDePorte)

                'Dim aa = q2.ToList
            End If

            Return resq 'hago el tolist porque estoy en un using
        End Using
    End Function

    Shared Function CartasLINQlocalSimplificadoTipado(ByVal SC As String, _
              ByVal ColumnaParaFiltrar As String, _
              ByVal TextoParaFiltrar As String, _
              ByVal sortExpression As String, _
              ByVal startRowIndex As Long, _
              ByVal maximumRows As Long, _
              ByVal estado As EntidadManager.enumCDPestado, _
              ByVal QueContenga As String, _
              ByVal idVendedor As Integer, _
              ByVal idCorredor As Integer, _
              ByVal idDestinatario As Integer, _
              ByVal idIntermediario As Integer, _
              ByVal idRemComercial As Integer, _
              ByVal idArticulo As Integer, _
              ByVal idProcedencia As Integer, _
              ByVal idDestino As Integer, _
              ByVal AplicarANDuORalFiltro As FiltroANDOR, _
              ByVal ModoExportacion As String, _
              ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
              ByVal puntoventa As Integer, _
              Optional ByRef sTituloFiltroUsado As String = "", _
              Optional ByVal optDivisionSyngenta As String = "Ambas", _
              Optional ByVal bTraerDuplicados As Boolean = False, _
              Optional ByVal Contrato As String = "") As Generic.List(Of ExTipoAnonimo)


        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        db.ObjectTrackingEnabled = False


        '       Remember, the query is nothing more than an object which represents the query. Think of it 
        'like a SQL query string, just way smarter. Passing a query string around doesn't execute the query; executing 
        'the query executes the query. – Eric Lippert J

        'y qué pasa si vuelvo a usar Equals? (en lugar de DefaultIfEmpty que me permite traer los nulls)

        Dim q As Generic.List(Of ExTipoAnonimo) = (From cdp In db.CartasDePortes _
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
                From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
                From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
                From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
                From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                From loc In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(cdp.Procedencia)).DefaultIfEmpty _
                From cal In db.Calidades.Where(Function(i) i.IdCalidad = cdp.Calidad).DefaultIfEmpty _
                Where _
            cdp.Vendedor > 0 _
            And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
            And (cdp.Anulada <> "SI") _
            And (ModoExportacion <> "Entregas" Or cdp.Exporta <> "SI") _
            And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
            And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
            And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
            And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
            And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
            And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
            And (idDestino = -1 Or cdp.Destino = idDestino) _
            And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
            Order By cdp.FechaModificacion Descending _
            Select New ExTipoAnonimo With { _
             .IdCartaDePorte = cdp.IdCartaDePorte, _
             .NumeroCartaDePorte = cdp.NumeroCartaDePorte, _
             .NumeroSubfijo = cdp.NumeroSubfijo, _
             .SubnumeroVagon = cdp.SubnumeroVagon, _
             .FechaArribo = cdp.FechaArribo, _
             .FechaModificacion = cdp.FechaModificacion, _
             .FechaDescarga = cdp.FechaDescarga, _
             .Observaciones = cdp.Observaciones, _
             .NetoFinal = cdp.NetoFinal, _
             .TitularDesc = clitit.RazonSocial, _
             .IntermediarioDesc = cliint.RazonSocial, _
             .RComercialDesc = clircom.RazonSocial, _
             .CorredorDesc = corr.Nombre, _
             .DestinatarioDesc = art.Descripcion, _
             .Producto = art.Descripcion, _
             .ProcedenciaDesc = loc.Nombre, _
             .DestinoDesc = dest.Descripcion, _
             .CalidadDesc = "", _
             .UsuarioIngreso = "" _
            } Skip startRowIndex Take maximumRows).ToList

        ' .id = cdp.IdCartaDePorte, _,
        '       .   cdp.NumeroCartaDePorte, cdp.NumeroSubfijo, cdp.SubnumeroVagon, _
        '          cdp.FechaArribo, cdp.FechaModificacion, cdp.FechaDescarga, _
        '          .Obs = cdp.Observaciones, _
        '          .NetoFinal = cdp.NetoFinal, _
        '                  .TitularDesc = clitit.RazonSocial, _
        '          .IntermediarioDesc = cliint.RazonSocial, _
        '          .RComercialDesc = clircom.RazonSocial, _
        '          .CorredorDesc = corr.Nombre, _
        '          .DestinatarioDesc = clidest.RazonSocial, _
        '          .ProcedenciaDesc = loc.Nombre, _
        '          .DestinoDesc = dest.Descripcion, _
        '            .CalidadDesc = "", _
        '         .UsuarioIngreso = "" _



        If False Then
            'Dim lista = From c In resq Select ID
            ''si la lista es chica (por ejemplo, paginada para la gridview, en lugar del socotroco que pediría una exportacion de sincro) quizas
            ''sirve hacer el join despues del select.....
            'Dim q2 = From cdp In db.CartasDePortes _
            '          From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
            '        From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
            '        From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
            '        From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
            '        From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
            '        From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
            '        From cal In db.Calidades.Where(Function(i) i.IdCalidad = cdp.Calidad).DefaultIfEmpty _
            '        From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
            '        From estab In db.linqCDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
            '        From tr In db.Transportistas.Where(Function(i) i.IdTransportista = cdp.IdTransportista).DefaultIfEmpty _
            '        From loc In db.Localidades.Where(Function(i) i.IdLocalidad = cdp.Procedencia).DefaultIfEmpty _
            '        From chf In db.Choferes.Where(Function(i) i.IdChofer = cdp.IdChofer).DefaultIfEmpty _
            '        From emp In db.linqEmpleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty() _
            '        Where lista.Contains(cdp.IdCartaDePorte)

            'Dim aa = q2.ToList
        End If

        Return q 'hago el tolist porque estoy en un using

    End Function



    Shared Function CartasLINQlocalSimplificadoTipado2(ByVal SC As String, _
              ByVal ColumnaParaFiltrar As String, _
              ByVal TextoParaFiltrar As String, _
              ByVal sortExpression As String, _
              ByVal startRowIndex As Long, _
              ByVal maximumRows As Long, _
              ByVal estado As EntidadManager.enumCDPestado, _
              ByVal QueContenga As String, _
              ByVal idVendedor As Integer, _
              ByVal idCorredor As Integer, _
              ByVal idDestinatario As Integer, _
              ByVal idIntermediario As Integer, _
              ByVal idRemComercial As Integer, _
              ByVal idArticulo As Integer, _
              ByVal idProcedencia As Integer, _
              ByVal idDestino As Integer, _
              ByVal AplicarANDuORalFiltro As FiltroANDOR, _
              ByVal ModoExportacion As String, _
              ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
              ByVal puntoventa As Integer, _
              Optional ByRef sTituloFiltroUsado As String = "", _
              Optional ByVal optDivisionSyngenta As String = "Ambas", _
              Optional ByVal bTraerDuplicados As Boolean = False, _
              Optional ByVal Contrato As String = "") As Generic.List(Of CartaDePorte)


        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        db.ObjectTrackingEnabled = False


        '       Remember, the query is nothing more than an object which represents the query. Think of it 
        'like a SQL query string, just way smarter. Passing a query string around doesn't execute the query; executing 
        'the query executes the query. – Eric Lippert J

        'y qué pasa si vuelvo a usar Equals? (en lugar de DefaultIfEmpty que me permite traer los nulls)

        Dim q As Generic.List(Of CartaDePorte) = (From cdp In db.CartasDePortes _
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
                From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
                From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
                From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
                From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                From loc In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(cdp.Procedencia)).DefaultIfEmpty _
                From cal In db.Calidades.Where(Function(i) i.IdCalidad = cdp.Calidad).DefaultIfEmpty _
                Where _
            cdp.Vendedor > 0 _
            And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
            And (cdp.Anulada <> "SI") _
            And (ModoExportacion <> "Entregas" Or cdp.Exporta <> "SI") _
            And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
            And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
            And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
            And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
            And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
            And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
            And (idDestino = -1 Or cdp.Destino = idDestino) _
            And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
            Order By cdp.FechaModificacion Descending _
            Select New CartaDePorte With { _
             .Id = cdp.IdCartaDePorte, _
             .NumeroCartaDePorte = cdp.NumeroCartaDePorte, _
             .NumeroSubfijo = cdp.NumeroSubfijo, _
             .SubnumeroVagon = cdp.SubnumeroVagon, _
             .FechaArribo = cdp.FechaArribo, _
             .FechaModificacion = cdp.FechaModificacion, _
             .FechaDescarga = cdp.FechaDescarga, _
             .Observaciones = cdp.Observaciones, _
             .NetoFinalSinMermas = cdp.NetoFinal, _
             .TitularDesc = clitit.RazonSocial, _
             .IntermediarioDesc = cliint.RazonSocial, _
             .RComercialDesc = clircom.RazonSocial, _
             .CorredorDesc = corr.Nombre, _
             .DestinatarioDesc = art.Descripcion, _
             .Producto = art.Descripcion, _
             .ProcedenciaDesc = loc.Nombre, _
             .DestinoDesc = dest.Descripcion, _
             .CalidadDesc = "", _
             .UsuarioIngreso = "", _
            .NobleExtranos = cdp.NobleExtranos, _
            .NobleNegros = cdp.NobleNegros, _
            .NobleQuebrados = cdp.NobleQuebrados, _
            .NobleDaniados = cdp.NobleDaniados, _
            .NobleChamico = cdp.NobleChamico, _
            .NobleChamico2 = cdp.NobleChamico2, _
            .NobleRevolcado = cdp.NobleRevolcado, _
            .NobleObjetables = cdp.NobleObjetables _
            } Skip startRowIndex Take maximumRows).ToList



        'Public NobleAmohosados As Double = 0
        'Public NobleHectolitrico As Double = 0
        'Public NobleCarbon As Double = 0
        'Public NoblePanzaBlanca As Double = 0
        'Public NoblePicados As Double = 0
        'Public NobleMGrasa As Double = 0
        'Public NobleAcidezGrasa As Double = 0
        'Public NobleVerdes As Double = 0
        'Public NobleGrado As Integer = 0
        'Public NobleConforme As Boolean
        'Public NobleACamara As Boolean

        'Public CalidadGranosQuemados As Double = 0
        'Public CalidadGranosQuemadosBonifRebaja As Integer
        'Public CalidadTierra As Double = 0
        'Public CalidadTierraBonifRebaja As Integer
        'Public CalidadMermaChamico As Double = 0
        'Public CalidadMermaChamicoBonifRebaja As Integer
        'Public CalidadMermaZarandeo As Double = 0
        'Public CalidadMermaZarandeoBonifRebaja As Integer
        'Public FueraDeEstandar As Boolean

        'Public CobraAcarreo As Boolean = True
        'Public LiquidaViaje As Boolean = False

        'Public SubnumeroDeFacturacion As Integer = 0


        Return q 'hago el tolist porque estoy en un using

    End Function








    Public Class InformeYPF
        Inherits CartasConCalada

        Public Camara As String
    End Class

    Public Class ExTipoAnonimo
        Public IdCartaDePorte As Integer
        Public Producto As String
        Public NumeroCartaDePorte As Long
        Public NumeroSubfijo As Integer
        Public SubnumeroVagon As Integer
        Public FechaArribo As Date
        Public FechaModificacion As Date
        Public FechaDescarga As Date
        Public Observaciones As String
        Public NetoFinal As Decimal
        Public TitularDesc As String
        Public IntermediarioDesc As String
        Public RComercialDesc As String
        Public CorredorDesc As String
        Public DestinatarioDesc As String
        Public TitularCUIT As String
        Public IntermediarioCUIT As String
        Public RComercialCUIT As String
        Public CorredorCUIT As String
        Public DestinatarioCUIT As String
        Public ProcedenciaDesc As String
        Public DestinoDesc As String
        Public CalidadDesc As String
        Public UsuarioIngreso As String

    End Class







    Shared Function CartasLINQlocalSimplificadoQueryable(ByVal SC As String, _
              ByVal ColumnaParaFiltrar As String, _
              ByVal TextoParaFiltrar As String, _
              ByVal sortExpression As String, _
              ByVal startRowIndex As Long, _
              ByVal maximumRows As Long, _
              ByVal estado As EntidadManager.enumCDPestado, _
              ByVal QueContenga As String, _
              ByVal idVendedor As Integer, _
              ByVal idCorredor As Integer, _
              ByVal idDestinatario As Integer, _
              ByVal idIntermediario As Integer, _
              ByVal idRemComercial As Integer, _
              ByVal idArticulo As Integer, _
              ByVal idProcedencia As Integer, _
              ByVal idDestino As Integer, _
              ByVal AplicarANDuORalFiltro As FiltroANDOR, _
              ByVal ModoExportacion As String, _
              ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
              ByVal puntoventa As Integer, _
              Optional ByRef sTituloFiltroUsado As String = "", _
              Optional ByVal optDivisionSyngenta As String = "Ambas", _
              Optional ByVal bTraerDuplicados As Boolean = False, _
              Optional ByVal Contrato As String = "") As IQueryable(Of CartasDePorte)


        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        db.ObjectTrackingEnabled = False


        '       Remember, the query is nothing more than an object which represents the query. Think of it 
        'like a SQL query string, just way smarter. Passing a query string around doesn't execute the query; executing 
        'the query executes the query. – Eric Lippert J

        'y qué pasa si vuelvo a usar Equals? (en lugar de DefaultIfEmpty que me permite traer los nulls)

        Dim q As IQueryable(Of CartasDePorte) = From cdp In db.CartasDePortes _
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
                From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
                From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
                From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
                From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                From loc In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(cdp.Procedencia)).DefaultIfEmpty _
                From cal In db.Calidades.Where(Function(i) i.IdCalidad = cdp.Calidad).DefaultIfEmpty _
                Where _
            cdp.Vendedor > 0 _
            And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
            And (cdp.Anulada <> "SI") _
            And (ModoExportacion <> "Entregas" Or cdp.Exporta <> "SI") _
            And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
            And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
            And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
            And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
            And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
            And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
            And (idDestino = -1 Or cdp.Destino = idDestino) _
            And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
            Order By cdp.FechaModificacion Descending _
                 Select cdp _
                 Skip startRowIndex Take maximumRows




        Return q

    End Function


    Function ArmarVista()



    End Function





    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




    'Este filtro lo uso en los sincronismos, porque ahí está el dataset tipado
    Public Shared Function generarWHEREparaDatasetParametrizadoConFechaEnNumerales( _
                    ByVal sc As String, ByRef sTituloFiltroUsado As String, _
                    ByVal estado As EntidadManager.enumCDPestado, _
                    ByVal QueContenga As String, _
                    ByVal idVendedor As Integer, _
                    ByVal idCorredor As Integer, _
                    ByVal idDestinatario As Integer, _
                    ByVal idIntermediario As Integer, _
                    ByVal idRemComercial As Integer, _
                    ByVal idArticulo As Integer, _
                    ByVal idProcedencia As Integer, _
                    ByVal idDestino As Integer, _
                    ByVal AplicarANDuORalFiltro As FiltroANDOR, _
                    ByVal ModoExportacion As String, _
                    ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
                    ByVal puntoventa As Integer, _
                    Optional ByVal optDivisionSyngenta As String = "Ambas", _
                    Optional ByVal Vagon As Integer = Nothing, Optional ByVal Patente As String = "" _
                ) As String


        Dim strWHERE As String = "1=1 "




        If QueContenga <> "" Then
            Dim idVendedorQueContiene = BuscaIdClientePreciso(QueContenga, sc)
            Dim idCorredorQueContiene = BuscaIdVendedorPreciso(QueContenga, sc)

            If idVendedorQueContiene <> -1 Or idCorredorQueContiene <> -1 Then
                strWHERE += "  " & _
                 "           AND (Vendedor = " & idVendedorQueContiene & _
                "           OR CuentaOrden1 = " & idVendedorQueContiene & _
                "           OR CuentaOrden2 = " & idVendedorQueContiene & _
                "             OR Corredor=" & idCorredorQueContiene & _
                "             OR Corredor2=" & idCorredorQueContiene & _
                "             OR Entregador=" & idVendedorQueContiene & ")"
            End If


        End If





        If AplicarANDuORalFiltro = 1 Then
            strWHERE += iisIdValido(idVendedor, "           AND CDP.Vendedor = " & idVendedor, "") & _
                    iisIdValido(idIntermediario, "             AND CDP.CuentaOrden1=" & idIntermediario, "") & _
                    iisIdValido(idRemComercial, "             AND CDP.CuentaOrden2=" & idRemComercial, "") & _
                    iisIdValido(idDestinatario, "             AND  CDP.Entregador=" & idDestinatario, "")
        Else
            Dim s = " AND (1=0 " & _
                     iisIdValido(idVendedor, "           OR CDP.Vendedor = " & idVendedor, "") & _
                    iisIdValido(idIntermediario, "             OR CDP.CuentaOrden1=" & idIntermediario, "") & _
                    iisIdValido(idRemComercial, "             OR CDP.CuentaOrden2=" & idRemComercial, "") & _
                    iisIdValido(idDestinatario, "             OR  CDP.Entregador=" & idDestinatario, "") & _
                    "  )  "

            If s <> " AND (1=0   )  " Then strWHERE += s
        End If


        strWHERE += iisIdValido(idCorredor, "             AND (CDP.Corredor=" & idCorredor & " OR CDP.Corredor2=" & idCorredor & ") ", "")
        strWHERE += iisIdValido(idArticulo, "           AND CDP.IdArticulo=" & idArticulo, "")
        strWHERE += iisIdValido(idProcedencia, "             AND CDP.Procedencia=" & idProcedencia, "")
        strWHERE += iisIdValido(idDestino, "             AND CDP.Destino=" & idDestino, "")



        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////
        'como hacer cuando hay periodo y es descarga+posicion?
        'sWHERE += "    AND (isnull(FechaDescarga, FechaArribo) Between '" & iisValidSqlDate(fechadesde, #1/1/1753#) & "' AND '" & iisValidSqlDate(fechahasta, #1/1/2100#) & "')"


        strWHERE += CartaDePorteManager.EstadoWHERE(estado, "CDP.").Replace("#", "'")

        '

        'dddd()
        ' no debo filtrar por fecha las posiciones....



        If True Then 'estado = EntidadManager.enumCDPestado.DescargasMasFacturadas Then

            strWHERE += "    AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') >= #" & Convert.ToDateTime(iisValidSqlDate(fechadesde, #1/1/1753#)).ToString("yyyy/MM/dd") & "# " & _
                        "    AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') <= #" & Convert.ToDateTime(iisValidSqlDate(fechahasta, #1/1/2100#)).ToString("yyyy/MM/dd") & "# "
        Else
            strWHERE += "    AND isnull(FechaArribo,'1/1/1753') >= #" & Convert.ToDateTime(iisValidSqlDate(fechadesde, #1/1/1753#)).ToString("yyyy/MM/dd") & "# " & _
                        "    AND isnull(FechaArribo,'1/1/1753') <= #" & Convert.ToDateTime(iisValidSqlDate(fechahasta, #1/1/2100#)).ToString("yyyy/MM/dd") & "# "
        End If

        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////




        If Vagon > 0 Then
            strWHERE += "AND (CDP.SubnumeroVagon=" & Vagon & ")"
        End If
        If Patente <> "" Then
            strWHERE += "AND (CDP.Patente='" & puntoventa & "')"
        End If




        If ModoExportacion = "Local" Or ModoExportacion = "Entregas" Then
            strWHERE += "  AND ISNULL(CDP.Exporta,'NO')='NO'  "
        ElseIf ModoExportacion = "Export" Then
            strWHERE += "  AND ISNULL(CDP.Exporta,'NO')='SI'  "
        Else
        End If


        If puntoventa > 0 Then
            strWHERE += "AND (CDP.PuntoVenta=" & puntoventa & ")"  ' OR PuntoVenta=0)"  'lo del punto de venta=0 era por las importaciones donde alguien (con acceso a todos los puntos de venta) no tenía donde elegir cual 
        End If

        Dim desde As String = iisValidSqlDate(fechadesde.ToString)
        Dim hasta As String = iisValidSqlDate(fechahasta.ToString)
        'no se por qué no está andando el formateaFecha
        'Dim hasta As String = formateaFecha(iisValidSqlDate(fechadesde.ToString))
        'Dim desde As String = formateaFecha(iisValidSqlDate(fechahasta.ToString))


        If optDivisionSyngenta <> "Ambas" And optDivisionSyngenta <> "" Then strWHERE += " AND isnull(CDP.EnumSyngentaDivision,'')='" & optDivisionSyngenta & "'"


        If sTituloFiltroUsado = "" Then
            Select Case estado
                Case EntidadManager.enumCDPestado.TodasMenosLasRechazadas
                    sTituloFiltroUsado &= "Todas (menos las rechazadas), "
                Case EntidadManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones
                    sTituloFiltroUsado &= "Descargas de Hoy + Todas las Posiciones, "
                Case EntidadManager.enumCDPestado.Posicion
                    sTituloFiltroUsado &= "Posición, "
                Case enumCDPestado.DescargasMasFacturadas
                    sTituloFiltroUsado &= "Descargas, "
                Case EntidadManager.enumCDPestado.Rechazadas
                    sTituloFiltroUsado &= "Rechazadas, "
                Case Else
                    sTituloFiltroUsado &= estado.ToString
            End Select
        End If





        sTituloFiltroUsado &= FormatearTitulo(sc, _
                              sTituloFiltroUsado, _
                              estado, QueContenga, idVendedor, idCorredor, _
                              idDestinatario, idIntermediario, _
                              idRemComercial, idArticulo, idProcedencia, idDestino, _
                              AplicarANDuORalFiltro, ModoExportacion, _
                              fechadesde, fechahasta, _
                              puntoventa, optDivisionSyngenta, False, "", "", -1)


        If Trim(sTituloFiltroUsado) = "" Then sTituloFiltroUsado = "(sin filtrar)"



        'strWHERE = strWHERE.Replace("CDP.", "")
        strWHERE = strWHERE.Replace("WHERE", "")

        Return strWHERE
    End Function


    Shared Function FormatearTitulo( _
                    ByVal sc As String, ByRef sTituloFiltroUsado As String, _
                    ByVal estado As EntidadManager.enumCDPestado, _
                    ByVal QueContenga As String, _
                    ByVal idVendedor As Integer, _
                    ByVal idCorredor As Integer, _
                    ByVal idDestinatario As Integer, _
                    ByVal idIntermediario As Integer, _
                    ByVal idRemComercial As Integer, _
                    ByVal idArticulo As Integer, _
                    ByVal idProcedencia As Integer, _
                    ByVal idDestino As Integer, _
                    ByVal AplicarANDuORalFiltro As FiltroANDOR, _
                    ByVal ModoExportacion As String, _
                    ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
                    ByVal puntoventa As Integer, _
                    Optional ByVal optDivisionSyngenta As String = "Ambas", _
                    Optional ByVal bTraerDuplicados As Boolean = False, _
                    Optional ByVal Contrato As String = "", _
                    Optional ByVal QueContenga2 As String = "", Optional ByVal idClienteAuxiliar As Integer = -1 _
                   ) As String

        Dim desde As String = iisValidSqlDate(fechadesde.ToString)
        Dim hasta As String = iisValidSqlDate(fechahasta.ToString)


        Dim s = String.Format("{15} {0} {1} {2} {3} {4} {5} {6} {7} {8} {9} {14}  ({10}, {11}, {12})", _
                        IIf(IsDate(fechadesde) AndAlso fechadesde >= #1/1/1800#, "del " & FechaChica(desde), ""), _
                        IIf(IsDate(fechahasta) AndAlso fechahasta <= #1/1/2099#, "al " & FechaChica(hasta), ""), _
                        IIf(idVendedor > 0, "Titular: " & NombreCliente(sc, idVendedor), ""), _
                        IIf(idIntermediario > 0, "Intermediario " & NombreCliente(sc, idIntermediario), ""), _
                        IIf(idRemComercial > 0, "R.Comercial: " & NombreCliente(sc, idRemComercial), ""), _
                        IIf(idCorredor > 0, "Corredor: " & NombreVendedor(sc, idCorredor), ""), _
                        IIf(idDestinatario > 0, "Destinatario: " & NombreCliente(sc, idDestinatario), ""), _
                        IIf(idProcedencia > 0, "Origen: " & NombreLocalidad(sc, idProcedencia), ""), _
                        IIf(idDestino > 0, "Destino: " & NombreDestino(sc, idDestino), ""), _
                        IIf(idArticulo > 0, "Producto: " & NombreArticulo(sc, idArticulo), ""), _
                        "Exporta: " & iisNull(ModoExportacion, "NO"), _
                        "Punto de venta: " & IIf(puntoventa < 0, "Todos", PuntoVentaWilliams.NombrePuntoVentaWilliams4(puntoventa)), _
                        "Criterio: " & IIf(AplicarANDuORalFiltro = "1", "TODOS", "ALGUNOS") & IIf(optDivisionSyngenta = "Seeds", " Syngenta " & optDivisionSyngenta, "") & IIf(QueContenga <> "", " Contiene: " & QueContenga, ""), _
                        " ", _
                         IIf(idClienteAuxiliar > 0, " Cliente Observaciones: " & NombreCliente(sc, idClienteAuxiliar), ""), _
                          sTituloFiltroUsado _
                        )

        'String.Format("{11} - {13} de Williams Entregas - {0} {1}", _


        '        Modificar el asunto de los mails para que queden de la siguiente manera:

        '* Si el mail es de Descargas:

        'Descargas del 04/07 al 04/07 - Nombre del cliente


        '* Si el mail es de Posición o Descargas del día + Posiciones:

        'Posición del 04/07 al 04/07 - Nombre del cliente





        Return s
    End Function

    Public Shared Function FormatearAsunto( _
                    ByVal sc As String, ByRef sTituloFiltroUsado As String, _
                    ByVal estado As EntidadManager.enumCDPestado, _
                    ByVal QueContenga As String, _
                    ByVal idVendedor As Integer, _
                    ByVal idCorredor As Integer, _
                    ByVal idDestinatario As Integer, _
                    ByVal idIntermediario As Integer, _
                    ByVal idRemComercial As Integer, _
                    ByVal idArticulo As Integer, _
                    ByVal idProcedencia As Integer, _
                    ByVal idDestino As Integer, _
                    ByVal AplicarANDuORalFiltro As FiltroANDOR, _
                    ByVal ModoExportacion As String, _
                    ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
                    ByVal puntoventa As Integer, _
                    Optional ByVal optDivisionSyngenta As String = "Ambas", _
                    Optional ByVal bTraerDuplicados As Boolean = False, _
                    Optional ByVal Contrato As String = "", _
                    Optional ByVal QueContenga2 As String = "", Optional ByVal idClienteAuxiliar As Integer = -1 _
                   ) As String


        Dim s As String

        Try

            'Dim desde As String = iisValidSqlDate(fechadesde.ToString) 'ojo acá que estás pasando a ingles
            'Dim hasta As String = iisValidSqlDate(fechahasta.ToString)



            Dim Cliente As String
            If (idCorredor > 0) Then
                Cliente = "Corredor: " & NombreVendedor(sc, idCorredor)
            Else

                If idRemComercial > 0 Then Cliente = NombreCliente(sc, idRemComercial)
                If idDestinatario > 0 Then Cliente = NombreCliente(sc, idDestinatario)
                If idVendedor > 0 Then Cliente = NombreCliente(sc, idVendedor)

            End If





            'uso el estado o sTituloFiltroUsado?
            Dim sEst As String = GetEstadoString(estado)







            'ojo con mandar los minutos en lugar del mes!!!!!!!!!!!!!!!!!!!!!
            'ojo con mandar los minutos en lugar del mes!!!!!!!!!!!!!!!!!!!!!
            'ojo con mandar los minutos en lugar del mes!!!!!!!!!!!!!!!!!!!!!
            'ojo con mandar los minutos en lugar del mes!!!!!!!!!!!!!!!!!!!!!
            'ojo con mandar los minutos en lugar del mes!!!!!!!!!!!!!!!!!!!!!
            'Dim ci = New CultureInfo.("es-AR")

            s = String.Format("{11} {0} {1} - {2}", _
                                IIf(IsDate(fechadesde) AndAlso fechadesde >= #1/1/1800#, "del " & fechadesde.ToString("dd/MM/yyyy"), ""), _
                                IIf(IsDate(fechahasta) AndAlso fechahasta <= #1/1/2099#, "al " & fechahasta.ToString("dd/MM/yyyy"), ""), _
                                Cliente, _
                                IIf(idProcedencia > 0, "Origen: " & NombreLocalidad(sc, idProcedencia), ""), _
                                IIf(idDestino > 0, "Destino: " & NombreDestino(sc, idDestino), ""), _
                                IIf(idArticulo > 0, "Producto: " & NombreArticulo(sc, idArticulo), ""), _
                                "Exporta: " & iisNull(ModoExportacion, "NO"), _
                                "Punto de venta: " & IIf(puntoventa < 0, "Todos", PuntoVentaWilliams.NombrePuntoVentaWilliams4(puntoventa)), _
                                "Criterio: " & IIf(AplicarANDuORalFiltro = "1", "TODOS", "ALGUNOS") & IIf(optDivisionSyngenta = "Seeds", " Syngenta " & optDivisionSyngenta, "") & IIf(QueContenga <> "", " Contiene: " & QueContenga, ""), _
                                " ", _
                                IIf(idClienteAuxiliar > 0, " Cliente Observaciones: " & NombreCliente(sc, idClienteAuxiliar), ""), _
                                IIf(sTituloFiltroUsado = "", sEst, sTituloFiltroUsado) _
                            )

            'String.Format("{11} - {13} de Williams Entregas - {0} {1}", _


            '        Modificar el asunto de los mails para que queden de la siguiente manera:

            '* Si el mail es de Descargas:

            'Descargas del 04/07 al 04/07 - Nombre del cliente

            '* Si el mail es de Posición o Descargas del día + Posiciones:

            'Posición del 04/07 al 04/07 - Nombre del cliente



        Catch ex As Exception
            s = "mal formateado " + ex.ToString
            ErrHandler.WriteError(ex.ToString + " asunto mal formateado")
        End Try


        Return s
    End Function



    Public Shared Function generarWHEREparaDatasetParametrizado( _
                    ByVal sc As String, ByRef sTituloFiltroUsado As String, _
                    ByVal estado As EntidadManager.enumCDPestado, _
                    ByVal QueContenga As String, _
                    ByVal idVendedor As Integer, _
                    ByVal idCorredor As Integer, _
                    ByVal idDestinatario As Integer, _
                    ByVal idIntermediario As Integer, _
                    ByVal idRemComercial As Integer, _
                    ByVal idArticulo As Integer, _
                    ByVal idProcedencia As Integer, _
                    ByVal idDestino As Integer, _
                    ByVal AplicarANDuORalFiltro As FiltroANDOR, _
                    ByVal ModoExportacion As String, _
                    ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
                    ByVal puntoventa As Integer, _
                    Optional ByVal optDivisionSyngenta As String = "Ambas", _
                    Optional ByVal bTraerDuplicados As Boolean = False, _
                    Optional ByVal Contrato As String = "", _
                    Optional ByVal QueContenga2 As String = "", Optional ByVal idClienteAuxiliar As Integer = -1, _
                    Optional ByVal Vagon As Integer = Nothing, Optional ByVal Patente As String = "" _
                ) As String


        Dim strWHERE As String = "1=1 "




        If QueContenga <> "" Then
            Dim idVendedorQueContiene = BuscaIdClientePreciso(QueContenga, sc)
            Dim idCorredorQueContiene = BuscaIdVendedorPreciso(QueContenga, sc)


            '  strWHERE += "  AND (NumeroCartaDePorte LIKE  '%" & QueContenga & "%'" & ") "

            If idVendedorQueContiene <> -1 Or idCorredorQueContiene <> -1 Then
                'no hay que agregar el prefijo .CDP acá para que funcione?????
                'no hay que agregar el prefijo .CDP acá para que funcione?????
                'no hay que agregar el prefijo .CDP acá para que funcione?????
                'no hay que agregar el prefijo .CDP acá para que funcione?????
                strWHERE += "  " & _
                 "           AND (Vendedor = " & idVendedorQueContiene & _
                "           OR CuentaOrden1 = " & idVendedorQueContiene & _
                "           OR CuentaOrden2 = " & idVendedorQueContiene & _
                "             OR Corredor=" & idCorredorQueContiene & _
                "             OR Corredor2=" & idCorredorQueContiene & _
                "             OR Entregador=" & idVendedorQueContiene & _
                "           OR idClienteAuxiliar = " & idVendedorQueContiene & _
                "           )"
            End If


        End If


        If QueContenga2 <> "" Then
            strWHERE += "  AND (NumeroCartaDePorte LIKE  '%" & QueContenga2 & "%'" & ") "
        End If






        If AplicarANDuORalFiltro = 1 Then
            strWHERE += iisIdValido(idVendedor, "           AND CDP.Vendedor = " & idVendedor, "") & _
                    iisIdValido(idIntermediario, "             AND CDP.CuentaOrden1=" & idIntermediario, "") & _
                    iisIdValido(idRemComercial, "             AND CDP.CuentaOrden2=" & idRemComercial, "") & _
                    ""
            'iisIdValido(idClienteAuxiliar, "             AND CDP.idClienteAuxiliar=" & idClienteAuxiliar, "")
        Else
            Dim s = " AND (1=0 " & _
                    iisIdValido(idVendedor, "           OR CDP.Vendedor = " & idVendedor, "") & _
                    iisIdValido(idIntermediario, "             OR CDP.CuentaOrden1=" & idIntermediario, "") & _
                    iisIdValido(idRemComercial, "             OR CDP.CuentaOrden2=" & idRemComercial, "") & _
                                                       "  )  "

            'iisIdValido(idClienteAuxiliar, "             OR CDP.idClienteAuxiliar=" & idClienteAuxiliar, "") & _

            If s <> " AND (1=0   )  " Then strWHERE += s
        End If




        'Estos son excluyentes:
        strWHERE += iisIdValido(idCorredor, "             AND (CDP.Corredor=" & idCorredor & " OR CDP.Corredor2=" & idCorredor & ") ", "")
        strWHERE += iisIdValido(idArticulo, "           AND CDP.IdArticulo=" & idArticulo, "")
        strWHERE += iisIdValido(idProcedencia, "             AND CDP.Procedencia=" & idProcedencia, "")
        strWHERE += iisIdValido(idDestino, "             AND CDP.Destino=" & idDestino, "")
        strWHERE += iisIdValido(idDestinatario, "             AND  CDP.Entregador=" & idDestinatario, "")
        strWHERE += iisIdValido(idClienteAuxiliar, "             AND CDP.idClienteAuxiliar=" & idClienteAuxiliar, "")


        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////
        'como hacer cuando hay periodo y es descarga+posicion?
        'sWHERE += "    AND (isnull(FechaDescarga, FechaArribo) Between '" & iisValidSqlDate(fechadesde, #1/1/1753#) & "' AND '" & iisValidSqlDate(fechahasta, #1/1/2100#) & "')"


        strWHERE += CartaDePorteManager.EstadoWHERE(estado, "CDP.").Replace("#", "'")

        '

        'dddd()


        If True Then '            If estado = EntidadManager.enumCDPestado.DescargasMasFacturadas Then

            strWHERE += "    AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') >= '" & FechaANSI(iisValidSqlDate(fechadesde, #1/1/1753#)) & "' " & _
                        "    AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') <= '" & FechaANSI(iisValidSqlDate(fechahasta, #1/1/2100#)) & "' "
        Else
            strWHERE += "    AND isnull(FechaArribo,'1/1/1753') >= '" & FechaANSI(iisValidSqlDate(fechadesde, #1/1/1753#)) & "' " & _
                        "    AND isnull(FechaArribo,'1/1/1753') <= '" & FechaANSI(iisValidSqlDate(fechahasta, #1/1/2100#)) & "' "
        End If

        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////


        If Vagon > 0 Then
            strWHERE += " AND (CDP.SubnumeroVagon=" & Vagon & ") "
        End If
        If Patente <> "" Then
            strWHERE += " AND (Patente='" & Patente.ToUpper & "') "
        End If



        If Contrato <> "" And Contrato <> "0" Then
            strWHERE += "  AND Contrato='" & Contrato & "' "
        End If


        If puntoventa > 0 Then
            strWHERE += " AND (CDP.PuntoVenta=" & puntoventa & ") "  ' OR PuntoVenta=0)"  'lo del punto de venta=0 era por las importaciones donde alguien (con acceso a todos los puntos de venta) no tenía donde elegir cual 
        End If

        Dim desde As String = iisValidSqlDate(fechadesde.ToString)
        Dim hasta As String = iisValidSqlDate(fechahasta.ToString)
        'no se por qué no está andando el formateaFecha
        'Dim hasta As String = formateaFecha(iisValidSqlDate(fechadesde.ToString))
        'Dim desde As String = formateaFecha(iisValidSqlDate(fechahasta.ToString))


        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////


        Dim IdAcopio = BuscarIdAcopio(optDivisionSyngenta)


        If optDivisionSyngenta <> "Ambas" And optDivisionSyngenta <> "" Then
            strWHERE += " AND ("

            strWHERE += " isnull(CDP.EnumSyngentaDivision,'')='" & optDivisionSyngenta & "'"

            strWHERE += " OR Acopio1=" & IdAcopio & ""
            strWHERE += " OR Acopio2=" & IdAcopio & ""
            strWHERE += " OR Acopio3=" & IdAcopio & ""
            strWHERE += " OR Acopio4=" & IdAcopio & ""
            strWHERE += " OR Acopio5=" & IdAcopio & ""

            strWHERE += " )"


        End If
        '            strWHERE += " AND isnull(CDP.EnumSyngentaDivision,'Agro')='" & optDivisionSyngenta & "'"




        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////      Cuestiones con las copias de cartas   //////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////




        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10268
        'acá como hacemos para lo del tilde de exportacion en las copias????
        '    -Si una carta de porte original tiene el tilde de exportacion y alguna de las copias no (o viceversa) la 
        'carta de porte debe salir una vez en las planillas que tengan el tilde de exportacion y una vez en las planillas de descargas.



        Dim strWHEREexportacion = ""

        If ModoExportacion = "Local" Or ModoExportacion = "Entregas" Then
            strWHEREexportacion += "  AND ISNULL(COPIAS.Exporta,'NO')='NO'  "   'fijate que hace el where sobre COPIAS, ojito
        ElseIf ModoExportacion = "Export" Then
            strWHEREexportacion += "  AND ISNULL(COPIAS.Exporta,'NO')='SI'  " 'fijate que hace el where sobre COPIAS, ojito
        ElseIf ModoExportacion = "Ambos" Or ModoExportacion = "Ambas" Or ModoExportacion = "Buques" Or ModoExportacion = "" Then
            'pasan todos
        Else
            Throw New Exception("ModoExportacion desconocido: " & ModoExportacion)


        End If


        If estado <> enumCDPestado.Rechazadas Then
            strWHEREexportacion += " AND ISNULL(COPIAS.Anulada,'NO')<>'SI'"
        End If


        If True Then
            strWHERE += " and EXISTS ( SELECT * FROM CartasDePorte COPIAS " & _
                        " where COPIAS.NumeroCartaDePorte=CDP.NumeroCartaDePorte and COPIAS.SubnumeroVagon=CDP.SubnumeroVagon  " & _
                           strWHEREexportacion & "  ) "
        End If




        If Not bTraerDuplicados Then
            strWHERE += " AND ISNULL(CDP.SubnumeroDeFacturacion, 0) <= 0 "
        End If

        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////




        If sTituloFiltroUsado = "" Then
            Select Case estado
                Case EntidadManager.enumCDPestado.TodasMenosLasRechazadas
                    sTituloFiltroUsado &= "Todas (menos las rechazadas), "
                Case EntidadManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones
                    sTituloFiltroUsado &= "Descargas de Hoy + Todas las Posiciones, "
                Case EntidadManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha
                    sTituloFiltroUsado &= "Descargas de Hoy + Posiciones filtradas, "
                Case EntidadManager.enumCDPestado.Posicion
                    sTituloFiltroUsado &= "Posición, "
                Case EntidadManager.enumCDPestado.DescargasMasFacturadas
                    sTituloFiltroUsado &= "Descargas, "
                Case EntidadManager.enumCDPestado.Rechazadas
                    sTituloFiltroUsado &= "Rechazadas, "
                Case Else
                    sTituloFiltroUsado &= estado.ToString
            End Select
        End If



        'String.Format("{13} {0} {1} {2} {3} {4} {5} {6} {7} {8} {9} {14}.   ({10}, {11}, {12})", _
        'String.Format("{11} - {13} de Williams Entregas - {0} {1}", _

        sTituloFiltroUsado = FormatearTitulo(sc, _
                              sTituloFiltroUsado, _
                              estado, QueContenga, idVendedor, idCorredor, _
                              idDestinatario, idIntermediario, _
                              idRemComercial, idArticulo, idProcedencia, idDestino, _
                              AplicarANDuORalFiltro, ModoExportacion, _
                              fechadesde, fechahasta, _
                              puntoventa, optDivisionSyngenta, bTraerDuplicados, Contrato, QueContenga2, idClienteAuxiliar)


        If Trim(sTituloFiltroUsado) = "" Then sTituloFiltroUsado = "(sin filtrar)"



        'strWHERE = strWHERE.Replace("CDP.", "")
        strWHERE = strWHERE.Replace("WHERE", "")

        Return strWHERE
    End Function


    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    ''' <summary>
    ''' Por default trae la cotizacion del Dolar del dia de hoy
    ''' </summary>
    ''' <param name="Fecha"></param>
    ''' <param name="IdMoneda"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Shared Function Cotizacion(ByVal SC As String, Optional ByVal Fecha As DateTime = Nothing, Optional ByVal IdMoneda As Long = -1) As Double

        If IdMoneda = -1 Then 'por default busco el Dolar
            Dim drParam As System.Data.DataRow = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
            IdMoneda = drParam.Item("IdMonedaDolar")
        End If

        If IsNothing(Fecha) Then Fecha = Today 'por default busco la cotizacion de hoy
        Fecha = iisValidSqlDate(Fecha, Today)



        Dim oRs As System.Data.DataRow
        Dim ds As System.Data.DataSet
        Dim mvarIdMonedaPesos As Integer


        oRs = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
        With oRs

            mvarIdMonedaPesos = iisNull(.Item("IdMoneda"), 0)

            If IdMoneda <> mvarIdMonedaPesos Then

                '///////////////////////////////////
                '///////////////////////////////////
                'Busca la cotizacion de esa fecha
                '///////////////////////////////////
                '/////////////////////////////////// 
                'oRs = Aplicacion.Cotizaciones.TraerFiltrado("_PorFechaMoneda", Array(Fecha, IdMoneda))
                ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cotizaciones", "TX_PorFechaMoneda", CDate(Fecha), IdMoneda)

                Cotizacion = 0
                If ds.Tables(0).Rows.Count > 0 Then
                    Cotizacion = iisNull(ds.Tables(0).Rows(0).Item("CotizacionLibre"), 0)
                End If

                ' Return Cotizacion


                '///////////////////////////////////
                '///////////////////////////////////
                'si no encontré la de la fecha, puedo intentar con la ultima... 
                '   (agregado ProntoWeb para Williams)
                '///////////////////////////////////
                '///////////////////////////////////

                If False Then
                    Dim dt = EntidadManager.ExecDinamico(SC, "select top 1  Cotizacion,Fecha from cotizaciones " & _
                                                       "where(IdMoneda = " & IdMoneda & ") " & _
                                                    "order by fecha desc")

                    If dt.Rows.Count > 0 Then
                        Cotizacion = iisNull(dt.Rows(0).Item("Cotizacion"), 0)
                    End If
                End If



            Else
                Cotizacion = 1  'si es en pesos, devuelvo uno
            End If

            oRs = Nothing
        End With

    End Function


    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////MIGRAR SQL ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    Shared Function SQL_ListaDeCDPsFiltradas2(ByVal sWHEREadicional As String, ByVal optFacturarA As Long, ByVal txtFacturarATerceros As String, _
                                         ByVal HFSC As String, ByVal txtTitular As String, ByVal txtCorredor As String, _
                                         ByVal txtDestinatario As String, ByVal txtIntermediario As String, ByVal txtRcomercial As String, _
                                         ByVal txt_AC_Articulo As String, ByVal txtProcedencia As String, ByVal txtDestino As String, _
                                         ByVal txtBuscar As String, ByVal cmbCriterioWHERE As String, ByVal cmbmodo As String, _
                                         ByVal optDivisionSyngenta As String, ByVal txtFechaDesde As String, ByVal txtFechaHasta As String, _
                                         ByVal cmbPuntoVenta As String, Optional ByVal sJOIN As String = "", Optional ByVal txtClienteAuxiliar As String = "", _
                                         Optional ByVal txtFacturarA As String = "") _
                                As String
        'As IQueryable(Of CartasDePorte)


        If optFacturarA = 5 Then
            'Err.Raise(4444)
            'Exit Function
            'Return ListaUsandoAsignacionAutomatica(sWHEREadicional)
        End If


        'Está bien que para el paso 1 tambien se meta por acá?


        txtFacturarATerceros = txtFacturarATerceros.Replace("'", "''") '_c(txtFacturarATerceros)

        Dim IdFacturarselaA, tablafact As String
        Dim facturarselaA As String = ""
        Select Case optFacturarA
            Case 1
                'facturar a titular
                tablafact = "CLIVEN"
                IdFacturarselaA = "CLIVEN.idCliente"
                facturarselaA = "CLIVEN.Razonsocial"
            Case 2
                'facturar a destinatario
                tablafact = "CLIENT"
                IdFacturarselaA = "CLIENT.IdCliente"
                facturarselaA = "CLIENT.Razonsocial"
            Case 3
                'facturar a corredor
                tablafact = "CLICORCLI"
                IdFacturarselaA = "CLICORCLI.IdCliente"
                facturarselaA = "CLICORCLI.Razonsocial" 'Como no puedo facturarle a un vendedor, busco la razon social en el maestro de clientes
            Case 4
                'facturar todas a un tercero especifico
                tablafact = "CLIVEN" 'esto esta mallllllll
                If BuscaIdClientePreciso(txtFacturarATerceros, HFSC) = -1 Then
                    'si no encontras el cliente, por qué no te quejás en lugar de hacer esto?
                    optFacturarA = 1
                    IdFacturarselaA = "CLIVEN.IdCliente"
                    facturarselaA = "CLIVEN.Razonsocial"
                    txtFacturarATerceros = ""
                Else
                    'este es el caso correcto. Pero entonces pasás el tablafact.CUIT, tablafact.IdCodigoIVA y 
                    'el tablafact.Confirmado; y, como pusiste tablafact="CLIVEN", cuando factures a terceros vas 
                    ' a mostrar el nombre bien, pero vas a estar usando los datos del Vendedor/Titular
                    '-Hacé así: es dificil hacerlo por la cadena SQL. Así que resolvelo en la 
                    ' funcion VerificarClientesFacturables()
                    'tablafact = 
                    IdFacturarselaA = BuscaIdClientePreciso(txtFacturarATerceros, HFSC)
                    facturarselaA = "'" & txtFacturarATerceros & "'"
                End If

                'If facturarselaA = -1 Then Exit Sub 'facturarselaA = ""
            Case 5

                'facturar a titular
                tablafact = "CLIVEN"
                IdFacturarselaA = "CLIVEN.idCliente"
                facturarselaA = "CLIVEN.Razonsocial"

                'Err.Raise(4444)
                'Exit Function
                'ListaUsandoAsignacionAutomatica()
        End Select

        'uso distinct porque, por el join loco de razonsocial con Vendedores, si
        'hay una razonsocial repetida en clietnes, se repite la cdp

        'Facturación: tomar kg neto (sin mermas) y no el final




















        Dim strSQL = String.Format("SELECT DISTINCT    0 as ColumnaTilde,IdCartaDePorte, CDP.IdArticulo," & _
    "      NumeroCartaDePorte, SubNumeroVagon, CDP.SubNumerodeFacturacion   , FechaArribo, " & _
    "       FechaDescarga  , " & _
        facturarselaA & " as FacturarselaA, " & IdFacturarselaA & " as IdFacturarselaA," & _
    "          isnull(" & tablafact & ".Confirmado,'NO') as Confirmado, " & _
    "          " & tablafact & ".IdCodigoIVA, " & _
    "          " & tablafact & ".CUIT, " & _
    "          '' as ClienteSeparado, " & _
    "    ISNULL(dbo.wTarifaWilliams( " & IdFacturarselaA & "  ,CDP.IdArticulo,CDP.Destino , case when isnull(Exporta,'NO')='SI' then 1 else 0 end ,0  ),0) as TarifaFacturada  , " & _
    "         Articulos.Descripcion as  Producto, " & _
    "        NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,  CuentaOrden1 as IdIntermediario, CuentaOrden2 as IdRComercial, Entregador as IdDestinatario,      " & _
    "       CLIVEN.Razonsocial as   Titular  , " & _
    "       CLICO1.Razonsocial as   Intermediario  , " & _
    "       CLICO2.Razonsocial as   [R. Comercial]  , " & _
    "       CLICOR.Nombre as    [Corredor ], " & _
    "       CLIENT.Razonsocial  as  [Destinatario], " & _
    "         LOCDES.Descripcion   as  DestinoDesc, " & _
    "        LOCORI.Nombre as    [Procedcia.] , " & _
    "           CDP.Destino as IdDestino, CDP.AgregaItemDeGastosAdministrativos,CDP.Exporta,IdClienteAFacturarle,IdClienteEntregador " & _
                  " FROM CartasDePorte CDP " & _
                   " LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente " & _
                   " LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente " & _
                   " LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente " & _
                   " LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor " & _
                  " LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre) " & _
                  " LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente " & _
                   " LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo " & _
                   " LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista " & _
                   " LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer " & _
                   " LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & _
                   " LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino " & _
                   " LEFT OUTER JOIN ListasPreciosDetalle LPD ON " & tablafact & ".idListaPrecios = LPD.idListaPrecios" & _
                        "	AND LPD.idArticulo=CDP.IdArticulo " & _
                        "	AND isnull(LPD.IdDestinoDeCartaDePorte,isnull(CDP.Destino,''))=isnull(CDP.Destino,'') " _
            )





        Dim idVendedor = BuscaIdClientePreciso(txtTitular, HFSC)
        Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor, HFSC)
        Dim idDestinatario = BuscaIdClientePreciso(txtDestinatario, HFSC)
        Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario, HFSC)
        Dim idRComercial = BuscaIdClientePreciso(txtRcomercial, HFSC)
        Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo, HFSC)
        Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia, HFSC)
        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino, HFSC)
        Dim idClienteAuxiliar = BuscaIdClientePreciso(txtClienteAuxiliar, HFSC)
        Dim idFacturarA = BuscaIdClientePreciso(txtFacturarA, HFSC)
        'Dim idCuentaOrden2 = BuscaIdClientePreciso(txtDestinatario,hfsc)



        Dim strWHERE As String = sJOIN & "    WHERE 1=1 "

        '///////////////////////////////
        'truco para usar el idfacturaA
        strWHERE += " AND (  "
        strWHERE += iisIdValido(idFacturarA, "     CDP.IdClienteAFacturarle=" & idFacturarA, "1=0")
        strWHERE += "       OR ( 1=1 "
        '/////////////////////////////////


        Dim QueContenga = txtBuscar
        If QueContenga <> "" Then
            Dim idVendedorQueContiene = BuscaIdClientePreciso(QueContenga, HFSC)
            Dim idCorredorQueContiene = BuscaIdVendedorPreciso(QueContenga, HFSC)

            If idVendedorQueContiene <> -1 Or idCorredorQueContiene <> -1 Then

                strWHERE += "  " & _
                 "           AND (CDP.Vendedor = " & idVendedorQueContiene & _
                "           OR CDP.CuentaOrden1 = " & idVendedorQueContiene & _
                "           OR CDP.CuentaOrden2 = " & idVendedorQueContiene & _
                "           OR CDP.idClienteAuxiliar = " & idVendedorQueContiene & _
                "           OR CDP.IdClienteAFacturarle = " & idVendedorQueContiene & _
                "             OR CDP.Entregador=" & idVendedorQueContiene & ")"

                'strWHERE += "  " & _
                ' "           AND (CDP.Vendedor = " & idVendedorQueContiene & _
                '"           OR CDP.CuentaOrden1 = " & idVendedorQueContiene & _
                '"           OR CDP.CuentaOrden2 = " & idVendedorQueContiene & _
                '"             OR CDP.Corredor=" & idCorredorQueContiene & _
                '"             OR CDP.Entregador=" & idVendedorQueContiene & ")"
            End If
        End If


        If cmbCriterioWHERE = "todos" Then
            strWHERE += iisIdValido(idVendedor, "           AND CDP.Vendedor = " & idVendedor, "") & _
                            iisIdValido(idIntermediario, "             AND CDP.CuentaOrden1=" & idIntermediario, "") & _
                            iisIdValido(idRComercial, "             AND CDP.CuentaOrden2=" & idRComercial, "") & _
                            iisIdValido(idClienteAuxiliar, "             AND CDP.idClienteAuxiliar=" & idClienteAuxiliar, "")
        Else
            'criterio "algunos"
            Dim s = " AND (1=0 " & _
                             iisIdValido(idVendedor, "           OR CDP.Vendedor = " & idVendedor, "") & _
                            iisIdValido(idIntermediario, "             OR CDP.CuentaOrden1=" & idIntermediario, "") & _
                            iisIdValido(idRComercial, "             OR CDP.CuentaOrden2=" & idRComercial, "") & _
                            iisIdValido(idClienteAuxiliar, "             OR CDP.idClienteAuxiliar=" & idClienteAuxiliar, "") & _
                               "  )  "

            If s <> " AND (1=0   )  " Then strWHERE += s
        End If


        'en facturacion, volví a poner como excluyente al destinatrio. eso le quita funcionalidad al filtro de idFacturarA
        '-bueno, directamente podrías poner que los que tengan ese idFacturarA se incluyan sí o sí
        strWHERE += iisIdValido(idDestinatario, "             AND  CDP.Entregador=" & idDestinatario, "")


        strWHERE += iisIdValido(idCorredor, "             AND CDP.Corredor=" & idCorredor, "")
        strWHERE += iisIdValido(idArticulo, "           AND CDP.IdArticulo=" & idArticulo, "")
        strWHERE += iisIdValido(idProcedencia, "             AND CDP.Procedencia=" & idProcedencia, "")
        strWHERE += iisIdValido(idDestino, "             AND CDP.Destino=" & idDestino, "")


        strWHERE += " ) )  " 'truco para usar el idfacturaA












        If optDivisionSyngenta <> "Ambas" And optDivisionSyngenta <> "" Then strWHERE += " AND isnull(CDP.EnumSyngentaDivision,'')='" & optDivisionSyngenta & "'"
        'strWHERE += " and isnull(CDP.EnumSyngentaDivision,'Agro')='" & optDivisionSyngenta & "'"



        strWHERE += "    AND    NetoProc>0 AND ( isnull(FechaDescarga,FechaArribo) Between " & _
                "convert(datetime,'" & Convert.ToDateTime(iisValidSqlDate(txtFechaDesde, #1/1/1753#)).ToString("yyyy/MM/dd") & "',111) " & _
                " AND " & _
                "convert(datetime,'" & Convert.ToDateTime(iisValidSqlDate(txtFechaHasta, #1/1/2100#)).ToString("yyyy/MM/dd") & "',111) " & _
                " ) " & _
    "         AND (isnull(CDP.PuntoVenta," & cmbPuntoVenta & ")=" & cmbPuntoVenta & " OR CDP.PuntoVenta = 0)" & _
   "  AND (ISNULL(IdFacturaImputada,-1)=0 OR ISNULL(IdFacturaImputada,-1)=-1) " & _
   "  "


        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////

        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10275
        '        Si la carta de porte tiene un cliente distinto de Williams Entregas en el campo Entregador la carta no se debe facturar.
        'En el paso 1 de facturación mostrar un mensaje con la cantidad de cartas de porte que cumplen con los filtros pero no se muestran por cumplir con el caso de esta consulta.
        '////////////////////////////////
        'copia pendiente de asignar
        'FiltrarCartasConCopiaPendiente()
        'strWHERE += " AND (NOT (SubNumeroDeFacturacion>=0 AND IdClienteAFacturarle IS NULL )) "

        '////////////////////////////////
        'entregador externo
        'FiltrarLasQueNoSonEntregadorWilliamsYavisarEnMensaje()
        'strWHERE += " AND (idclienteentregador=12454 OR idclienteentregador IS NULL ) "


        'EN FACTURACION, NO USAMOS LA REGLA DE QUE "BASTA CON UNA COPIA QUE CUMPLA LA CONDICION DE EXPORTACION ETC"
        'EN FACTURACION, NO USAMOS LA REGLA DE QUE "BASTA CON UNA COPIA QUE CUMPLA LA CONDICION DE EXPORTACION ETC"
        'EN FACTURACION, NO USAMOS LA REGLA DE QUE "BASTA CON UNA COPIA QUE CUMPLA LA CONDICION DE EXPORTACION ETC"
        'EN FACTURACION, NO USAMOS LA REGLA DE QUE "BASTA CON UNA COPIA QUE CUMPLA LA CONDICION DE EXPORTACION ETC"
        If cmbmodo = "Local" Or cmbmodo = "Entregas" Then
            strWHERE += "  AND ISNULL(CDP.Exporta,'NO')='NO'  "
        ElseIf cmbmodo = "Export" Then
            strWHERE += "  AND ISNULL(CDP.Exporta,'NO')='SI'  "
        End If

        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////



        'iisIdValido(.Item("CuentaOrden2"), "         AND CDP.CuentaOrden2=" & .Item("CuentaOrden2"), "") & _

        strWHERE += sWHEREadicional
        strWHERE += CartaDePorteManager.EstadoWHERE(EntidadManager.enumCDPestado.DescargasMasFacturadas, "CDP.")


        'http://www.sqlteam.com/forums/topic.asp?TOPIC_ID=71950

        strWHERE += " group by IdCartaDePorte, CDP.IdArticulo,      NumeroCartaDePorte ,SubNumeroVagon ,CDP.SubNumeroDeFacturacion , FechaArribo, " & _
                     " FechaDescarga  , " _
                        & IIf(optFacturarA <> 4, facturarselaA & ", " & IdFacturarselaA & ", ", "") & _
                    " Articulos.Descripcion,         NetoFinal   ,  Corredor, Vendedor,  CuentaOrden1 , CuentaOrden2 , Entregador ,           CLIVEN.Razonsocial   ,        " & _
                    " CLICO1.Razonsocial  ,        CLICO2.Razonsocial  ,        " & _
                    " CLICOR.Nombre ,        CLIENT.Razonsocial  ,          " & _
                    " LOCDES.Descripcion  ,         LOCORI.Nombre  , CDP.Exporta,            " & _
                    "     CDP.Destino, CDP.AgregaItemDeGastosAdministrativos, TarifaFacturada,IdClienteAFacturarle, IdClienteEntregador, " & _
"          " & tablafact & ".Confirmado, " & _
"          " & tablafact & ".IdCodigoIVA,   " & _
"          " & tablafact & ".CUIT   "

        'strWHERE += " ORDER BY  " & facturarselaA & " ASC,NumeroCartaDePorte ASC " 'este explotaba en "a terceros", porque ponía ORDER 'PIRULO' ASC
        'strWHERE += " ORDER BY  NumeroCartaDePorte ASC, FacturarselaA ASC " 'el order lo pongo en la funcion que pagina

        strSQL += strWHERE
        Debug.Print(strWHERE)




        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        'Dim q = _
        '        (From i In db.CartasDePortes Where i.SubnumeroDeFacturacion >= 0 And i.IdClienteAFacturarle Is Nothing _
        '         And If(i.IdFacturaImputada, 0) = 0 And i.Anulada <> "SI")


        Return strSQL
    End Function


    Shared Function strSQLsincronismo() As String
        '        El nombre de columna 'PuntoVenta' no es válido. 
        'El nombre de columna 'CodigoONCAA' no es válido. 
        'El nombre de columna 'MotivoAnulacion' no es válido


        'strWHERE += " 1=1 " & _
        'iisIdValido(idVendedor, "           AND Vendedor = " & idVendedor, "") & _
        'iisIdValido(idCorredor, "             AND Corredor=" & idCorredor, "") & _
        'iisIdValido(idArticulo, "           AND IdArticulo=" & idArticulo, "") & _
        'iisIdValido(idProcedencia, "             AND Procedencia=" & idProcedencia, "") & _
        'iisIdValido(idDestino, "             AND Destino=" & idDestino, "") & _
        'iisIdValido(idDestinatario, "             AND Entregador=" & idDestinatario, "") '& _

        Dim strSQL = String.Format("  SELECT TOP " & _CONST_MAXROWS & _
      "    Exporta, Vendedor, Corredor, CuentaOrden1, CuentaOrden2, Entregador, NetoFinal, Anulada, " & _
    "      NumeroCartaDePorte   as  [C.Porte]  , " & _
    "       FechaDeCarga   as  Arribo , " & _
    "        convert(char, Hora, 108)   as  Hora, " & _
    "       FechaDescarga  , FechaArribo, " & _
    "        CONVERT(VARCHAR(8),FechaDescarga,108) as  HoraDescarga, " & _
    "       CDP.FechaIngreso  , " & _
    "         Articulos.Descripcion as  Producto, " & _
    "       Contrato  as  Contrato , " & _
    "       NetoPto   as  [Kg.Proc.] , " & _
    "       TaraPto   as  [Kg.Tara Proc.] , " & _
    "       BrutoPto   as  [Kg.Bruto Proc.], " & _
    "       BrutoFinal   as  [Kg.Bruto Desc.] , " & _
    "       TaraFinal   as  [Kg.Tara Desc.] , " & _
    "       NetoFinal   as  [Kg.Neto Desc.] , " & _
    "       NetoPto-NetoFinal   as  [Kg.Dif.] , " & _
    "         Humedad as  [H.%]	 , " & _
    "         HumedadDesnormalizada as [Mer.Kg.] , " & _
    "         Merma as Otras , " & _
    "        NetoProc  as  [Kg.Netos] , " & _
    "       CLIVEN.Razonsocial as   Titular  , " & _
    "       CLIVEN.CUIT as   TitularCUIT  , " & _
    "       CLICO1.Razonsocial as   Intermediario  , " & _
    "       CLICO1.CUIT as   IntermediarioCUIT  , " & _
    "       CLICO2.Razonsocial as   [R. Comercial]  , " & _
    "       CLICO2.CUIT as   [R. ComercialCUIT]  , " & _
    "       CLICOR.Nombre as    [Corredor ], " & _
    "       CLICOR.CUIT as    [CorredorCUIT], " & _
    "       CLIENT.Razonsocial  as  [Destinatario], " & _
    "       CLIENT.CUIT  as  [DestinatarioCUIT], " & _
    "       CLIENT.Razonsocial  as  [FacturadaA], " & _
    "       CLIENT.CUIT  as  [FacturadaACUIT], " & _
    "        Patente as  [Pat. Chasis] , " & _
    "         Acoplado as [Pat. Acoplado] , " & _
    "        TRANS.CUIT as [CUIT Transp.] , " & _
    "         TRANS.RazonSocial as Trasportista , " & _
    "         TRANS.RazonSocial as TrasportistaCUIT , " & _
    "         LOCDES.IdWilliamsDestino   as  Destino , " & _
    "         LOCDES.Descripcion   as  DestinoDesc , " & _
    "	    isnull(LOCDES.CUIT,'') 	 AS  DestinoCUIT, " & _
    "        LOCORI.Nombre as    [Procedcia.] , " & _
    "         FechaDescarga as   [Desc.], " & _
    "         CDP.Observaciones  as  [Cal.-Observaciones], " & _
    "         CHOF.CUIL as   [CUIT chofer], " & _
    "         CHOF.Nombre as   Chofer, " & _
    "         '' as  [Nro ONCA] , " & _
    "         '' as   [Pta ONCA], " & _
    "         '' as   Provincia, " & _
    "         '' as   [Nro CAC]	, " & _
    "          FechaVencimiento as  [Vencim.CP], " & _
    "          '' as  [Emision CP], " & _
    "          ''  as Sucursal, PuntoVenta, " & _
    "          KmARecorrer as  Km, " & _
    "          Tarifa as Tarifa, " & _
    "         Articulos.AuxiliarString5 as  [EspecieONCAA] , " & _
    "          LOCORI.IdLocalidad, " & _
    "          LOCDES.IdWilliamsDestino, " & _
    "          LOCORI.CodigoPostal as LocalidadProcedenciaCodigoPostal, " & _
    "          LOCDES.Codigo as LocalidadDestinoCodigoPostal, " & _
    "          LOCORI.CodigoONCAA as LocalidadProcedenciaCodigoONCAA, " & _
    "          LOCDES.CodigoONCAA as LocalidadDestinoCodigoONCAA, " & _
    "          LOCORI.CodigoLosGrobo as LocalidadProcedenciaCodigoLosGrobo, " & _
    "          LOCDES.CodigoLosGrobo as LocalidadDestinoCodigoLosGrobo, " & _
    "         Articulos.AuxiliarString6 as  [CodigoSagypa] , " & _
    "         Articulos.AuxiliarString7 as  [CodigoZeni] , " & _
    "          NumeroSubfijo as SufijoCartaDePorte, " & _
    "          Tarifa as Tarifa, " & _
    "          CDP.IdArticulo, " & _
    "           Calidad, " & _
    "          Cosecha, NobleGrado,Factor, ESTAB.Descripcion as CodigoEstablecimientoProcedencia, ESTAB.AuxiliarString1 as DescripcionEstablecimientoProcedencia, " & _
    "           CTG as CTG, CEE, FechaAnulacion,MotivoAnulacion, " & _
    "          '' as CadenaVacia, NetoProc, EnumSyngentaDivision, IdTipoMovimiento,CobraAcarreo,LiquidaViaje,IdCartaDePorte,SubNumeroVagon,Procedencia, Corredor2  " & _
      " FROM CartasDePorte CDP " & _
                   " LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente " & _
                   " LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente " & _
                   " LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente " & _
                   " LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor " & _
                   " LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente " & _
                   " LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo " & _
                   " LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista " & _
                   " LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer " & _
                   " LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & _
                   " LEFT OUTER JOIN Provincias PROVORI ON LOCORI.IdProvincia = PROVORI.IdProvincia " & _
                   " LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino " & _
                   " LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento " & _
                "")


        Return strSQL
    End Function



    Shared Function GetListDataTableDinamicoConWHERE_2(ByVal SC As String, ByVal estado As EntidadManager.enumCDPestado, _
                                                       ByVal strWHERE As String, bInsertarEnTablaTemporal As Boolean, _
                                                       Optional maxrows As Integer = 0) As DataTable

        'lo que sea dinámico, lo tendré que migrar para evitar inyeccion

        If maxrows > 0 Then
            maxrows = Min(maxrows, _CONST_MAXROWS)
        Else
            maxrows = _CONST_MAXROWS
        End If

        'hace falta levantar la cantidad de filas que levanto, no teniendo paginacion?


        Dim strSQL = String.Format("  SELECT TOP " & maxrows & "  CDP.*, " & _
"			cast (cdp.NumeroCartaDePorte as varchar) +" & _
"					CASE WHEN cdp.numerosubfijo<>0 OR cdp.subnumerovagon<>0 THEN " & _
"           '  ' + cast (cdp.numerosubfijo as varchar) + '/' +cast (cdp.subnumerovagon as varchar) 	" & _
"					ELSE " & _
"            ''" & _
"            End" & _
"				as NumeroCompleto," & _
"			datediff(minute,cdp.FechaModificacion,GETDATE()) as MinutosModifico, " & _
" 			ISNULL(Articulos.AuxiliarString5,'') AS EspecieONCAA,	 " & _
" 			ISNULL(Articulos.AuxiliarString6,'') AS CodigoSAJPYA,	 " & _
" 			ISNULL(Articulos.AuxiliarString7,'') AS txtCodigoZeni,	 " & _
"			isnull(CLIVEN.Razonsocial,'') AS TitularDesc, " & _
"            isnull(CLIVEN.cuit,'') AS TitularCUIT, " & _
"			isnull(CLICO1.Razonsocial,'') AS IntermediarioDesc, " & _
"            isnull(CLICO1.cuit,'') AS IntermediarioCUIT, " & _
"			isnull(CLICO2.Razonsocial,'') AS RComercialDesc, " & _
"            isnull(CLICO2.cuit,'') AS RComercialCUIT, " & _
"			isnull(CLICOR.Nombre,'') AS CorredorDesc, " & _
"            isnull(CLICOR.cuit,'') AS CorredorCUIT, " & _
"			isnull(CLIENT.Razonsocial,'') AS DestinatarioDesc, " & _
"			isnull(CLIENTREG.Razonsocial,'') AS EntregadorDesc, " & _
"            isnull(CLIENT.cuit,'') AS DestinatarioCUIT, " & _
"			isnull(CLIAUX.Razonsocial,'') AS ClienteAuxiliarDesc, " & _
"			isnull(CLIAUX.cuit,'') AS ClienteAuxiliarCUIT, " & _
"			isnull(CLISC1.Razonsocial,'') AS Subcontr1Desc, " & _
"            isnull(CLISC2.Razonsocial,'') AS Subcontr2Desc, " & _
"             isnull(Articulos.Descripcion,'') AS Producto, " & _
"			 Transportistas.cuit as  TransportistaCUIT, " & _
"            isnull(Transportistas.RazonSocial,'') AS TransportistaDesc, " & _
"			choferes.cuil as  ChoferCUIT, " & _
"			choferes.Nombre as  ChoferDesc, " & _
"           isnull(LOCORI.Nombre,'') AS ProcedenciaDesc, " & _
"		isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal, " & _
"		isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA, " & _
"           isnull(PROVORI.Nombre,'') AS ProcedenciaProvinciaDesc, " & _
"       isnull(LOCDES.Descripcion,'') AS DestinoDesc, " & _
"            '' AS  DestinoCodigoPostal, " & _
"			isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA, " & _
"           DATENAME(month, FechaDescarga) AS Mes, " & _
"          DATEPART(year, FechaDescarga) AS Ano,  " & _
"      	FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura, " & _
"           FAC.FechaFactura, " & _
"          isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado, " & _
"         isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT, " & _
"		Calidades.Descripcion AS CalidadDesc, " & _
"	    E1.Nombre as UsuarioIngreso,isnull(ESTAB.Descripcion,'') COLLATE SQL_Latin1_General_CP1_CI_AS +' '+ isnull(ESTAB.AuxiliarString1,'') COLLATE SQL_Latin1_General_CP1_CI_AS+ ' '+ isnull(ESTAB.AuxiliarString2,'') COLLATE SQL_Latin1_General_CP1_CI_AS  " & _
"                                                                                               as EstablecimientoDesc, " & _
"			isnull(CLIENTFLET.Razonsocial,'') AS ClientePagadorFleteDesc ,        " & _
"   isnull(LOCORI.Partido,'') AS ProcedenciaProvinciaPartido,   " & _
"   isnull(PARTORI.Codigo,'') AS ProcedenciaPartidoNormalizadaCodigo, " & _
"   isnull(PROVDEST.Nombre,'') AS DestinoProvinciaDesc, " & _
"  isnull(PARTORI.Nombre,'') AS ProcedenciaPartidoNormalizada   , " & _
"			isnull(CLICOR2.Nombre,'') AS CorredorDesc2, " & _
"            isnull(CLICOR2.cuit,'') AS CorredorCUIT2 " _
        )


        Dim strFROM = _
        "   FROM    CartasDePorte CDP " & _
        "          LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente " & _
        "       LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente " & _
        "       LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente " & _
        "       LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar= CLIAUX.IdCliente " & _
        "       LEFT OUTER JOIN Clientes CLIENTREG ON CDP.IdClienteEntregador= CLIENTREG.IdCliente " & _
        "       LEFT OUTER JOIN Clientes CLIENTFLET ON CDP.IdClientePagadorFlete= CLIENTFLET.IdCliente " & _
        "       LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor " & _
        "       LEFT OUTER JOIN Vendedores CLICOR2 ON CDP.Corredor2 = CLICOR2.IdVendedor " & _
        "       LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente " & _
        "        LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente " & _
        "         LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente " & _
        "         LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo " & _
        "          LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad " & _
        "           LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista " & _
        "			LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer " & _
        "           LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & _
        "           LEFT OUTER JOIN Provincias PROVORI ON LOCORI.IdProvincia = PROVORI.IdProvincia " & _
        "           LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino " & _
        "           LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento " & _
        "            LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura " & _
        "            LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente " & _
        "            LEFT OUTER JOIN Partidos PARTORI ON LOCORI.IdPartido = PARTORI.IdPartido " & _
        "            LEFT OUTER JOIN Provincias PROVDEST ON LOCDES.IdProvincia = PROVDEST.IdProvincia " & _
        "  LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado "




        strWHERE += CartaDePorteManager.EstadoWHERE(estado, "CDP.").Replace("#", "'")


        strSQL += strFROM + strWHERE
        Debug.Print(strWHERE)



        Dim dt As DataTable

        bInsertarEnTablaTemporal = False

        If bInsertarEnTablaTemporal Then
            EntidadManager.ExecDinamico(SC, "drop table CartasDePorteTempParaReportingServices ")
            dt = EntidadManager.ExecDinamico(SC, " select *  into CartasDePorteTempParaReportingServices  from ( " + strSQL + " ) as A ")
            Return Nothing
        Else
            Try
                dt = EntidadManager.ExecDinamico(SC, strSQL)

            Catch ex As Exception
                'seguramente timeout
                ErrHandler.WriteError("GetListDataTableDinamicoConWHERE_2. Seguramente timeout. Aumentar el tiempo maximo de timeout o limitar la cantidad de renglones " & ex.ToString)
                Throw
            End Try




            If dt.Rows.Count = _CONST_MAXROWS Then
                Dim count As Long
                Dim usuario As String
                Try
                    count = EntidadManager.ExecDinamico(SC, "Select count (*) " & strFROM + strWHERE).Rows(0).Item(0)

                    ' usuario = User.Identity.Name()
                Catch ex As Exception

                End Try

                ErrHandler.WriteError(" GetListDataTableDinamicoConWHERE_2 llegó al máximo de renglones  " & strSQL)


                Dim tipo As String = ConfigurationManager.AppSettings("AvisoTipoDeSitioDesarrolloDebugTestReleaseExterno")

                MandarMailDeError("Count total   " & count & " " & usuario & ".  GetListDataTableDinamicoConWHERE_2 llegó al máximo de renglones en " & tipo & " " & strSQL)



            End If


            Return dt
        End If

    End Function



    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////


    Shared Function MandarMailDeError(ByVal sErr As String) As String

        'ErrHandlerWriteErrorLogPronto(srr, )

        Dim Body As String = sErr

        Dim direccion As String


        Try
            direccion = ConfigurationManager.AppSettings("ErrorMail")
        Catch ex As Exception
            direccion = ""
            'Dim direccion = "mscalella911@gmail.com"
        End Try
        If iisNull(direccion, "") = "" Then direccion = "mscalella911@gmail.com,apgurisatti@bdlconsultores.com.ar"


        'me fijo si estoy depurando en el IDE. No lo hago antes para probar el pedazo de codigo de arriba. Es el mail
        'lo que traba todo
        If System.Diagnostics.Debugger.IsAttached() Then
            'Return ""
        End If

        Body.Replace(Environment.NewLine, "<br />")

        Try
            'apgurisatti@bdlconsultores.com.ar", _
            MandaEmailSimple(direccion, _
                            "An Error Has Occurred! " & sErr, _
                           Body, _
                            ConfigurationManager.AppSettings("SmtpUser"), _
                            ConfigurationManager.AppSettings("SmtpServer"), _
                            ConfigurationManager.AppSettings("SmtpUser"), _
                            ConfigurationManager.AppSettings("SmtpPass"), _
                             , _
                            ConfigurationManager.AppSettings("SmtpPort"), , , )

        Catch ex As Exception
            ErrHandler.WriteError(ex)
        End Try


    End Function

    Shared Function MandarMailDeError(ByVal e As Exception) As String

        Dim Body As String = e.ToString + "    STACKTRACE:" + e.StackTrace 'mandate tambien el stacktrace

        Dim direccion As String


        Try
            direccion = ConfigurationManager.AppSettings("ErrorMail")
        Catch ex As Exception
            direccion = ""
            'Dim direccion = "mscalella911@gmail.com"
        End Try
        If iisNull(direccion, "") = "" Then direccion = "mscalella911@gmail.com,apgurisatti@bdlconsultores.com.ar"


        'me fijo si estoy depurando en el IDE. No lo hago antes para probar el pedazo de codigo de arriba. Es el mail
        'lo que traba todo
        If System.Diagnostics.Debugger.IsAttached() Then Return ""


        Try
            'apgurisatti@bdlconsultores.com.ar", _
            MandaEmailSimple(direccion, _
                            "An Error Has Occurred! " & e.ToString, _
                           Body, _
                            ConfigurationManager.AppSettings("SmtpUser"), _
                            ConfigurationManager.AppSettings("SmtpServer"), _
                            ConfigurationManager.AppSettings("SmtpUser"), _
                            ConfigurationManager.AppSettings("SmtpPass"), _
                             , _
                            ConfigurationManager.AppSettings("SmtpPort"), , , )

        Catch ex As Exception
            ErrHandler.WriteError(ex)
        End Try

    End Function

    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Shared Function Log_sp_who2(sc As String) As String


        'http://stackoverflow.com/questions/2945135/i-have-data-about-deadlocks-but-i-cant-understand-why-they-occur
        'You need to capture the deadlock graph. Attach Profiler and capture the Deadlock Graph Event class. Save the .XDL graph and add that info to your post.

        'TO DO: agregar formateo al sp_who2  para encolumnar y mas datos sobre quien bloquea
        'http://stackoverflow.com/questions/20047/diagnosing-deadlocks-in-sql-server-2005
        'https://www.simple-talk.com/sql/learn-sql-server/how-to-track-down-deadlocks-using-sql-server-2005-profiler/



        Dim dt As DataTable = Pronto.ERP.Bll.EntidadManager.ExecDinamico(sc, "EXEC sp_who2") 'tendrá problemas de timeout tambien para ejecutar esto???


        Dim s = DatatableToString(dt)

        Dim spid As String = (From myRow In dt.AsEnumerable() Order By myRow("DiskIO") Descending Select myRow("SPID")).FirstOrDefault()


        Dim dt2 = Pronto.ERP.Bll.EntidadManager.ExecDinamico(sc, "DBCC INPUTBUFFER(" & Val(spid) & ")")


        s &= "<br/><br/>" & DatatableToString(dt2)



        Return s
    End Function



    Shared Function DatatableToString(dt As DataTable) As String
        Dim s As String = ""

        For Each r As DataRow In dt.Rows
            Dim rowAsString As String = "" '= String.Join(", ", r.ItemArray.Cast(Of String)().ToArray())
            For Each item In r.ItemArray
                rowAsString &= item.ToString & ";"
            Next
            s &= rowAsString & ";" & vbCrLf & "<br/>"
        Next

        Return s
    End Function



    <DataObjectMethod(DataObjectMethodType.Select, True)> _
    Public Shared Function GetList(ByVal SC As String, Optional ByVal IdObra As Integer = -1, Optional ByVal TipoFiltro As String = "", Optional ByVal IdProveedor As Integer = -1) As CartaDePorteList

        'Dim Lista As CartaDePorteList = CartaDePorteDB.GetList(SC)

        'If Lista Is Nothing Then Return Nothing



        ''metodo 1: borro sobre la lista original
        'Dim lstBorrar As New List(Of Integer)

        ''metodo 2: hago una segunda lista sobre la que copio los objetos filtrados
        'Dim Lista2 As New CartaDePorteList
        'Try
        '    For Each cp As CartaDePorte In Lista
        '        'If IIf(IdObra = -1, True, cp.IdObra = IdObra) And 
        '        'If IIf(IdProveedor = -1, True, cp.Proveedor = IdProveedor) Then

        '        Select Case TipoFiltro
        '            Case "", "AConfirmarEnObra"
        '                If iisNull(cp.ConfirmadoPorWeb, "NO") = "NO" Then 'And iisNull(cp.Aprobo, 0) = 0 Then


        '                    'Lista.Remove(cp)  'http://www.velocityreviews.com/forums/t104020-how-can-i-delete-a-item-in-foreach-loop.html
        '                    'metodo 1 
        '                    'lstBorrar.Add(Lista.IndexOf(cp))
        '                    'metodo 2

        '                    Lista2.Add(cp)

        '                End If
        '            Case "AConfirmarEnCentral"
        '                If iisNull(cp.ConfirmadoPorWeb, "NO") = "SI" And iisNull(cp.IdAprobo, 0) = 0 Then
        '                    'lstBorrar.Add(Lista.IndexOf(cp))

        '                    Lista2.Add(cp)
        '                End If
        '            Case "Confirmados"
        '                'If iisNull(cp.Aprobo, 0) <> 0 Then
        '                If iisNull(cp.ConfirmadoPorWeb, "NO") = "SI" Then 'And iisNull(cp.Aprobo, 0) = 0 Then
        '                    'lstBorrar.Add(Lista.IndexOf(cp))

        '                    Lista2.Add(cp)
        '                End If
        '            Case Else
        '                Err.Raise(222222222)
        '        End Select

        '        'End If
        '    Next
        'Catch ex As Exception
        '    Debug.Print(ex.ToString)
        '    Throw New ApplicationException("Error en la grabacion " + ex.ToString, ex)
        'End Try


        ' ''metodo 1: 'borrar marcha atras porque si no cambia el indice!!!!
        ''For Each i As Integer In New ReverseIterator(lstBorrar)
        ''    Lista.RemoveAt(i) 'al final se trula y se excede del indice
        ''Next

        ''Return Lista



        ''metodo 2 
        'Return Lista2

    End Function







    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








    Public Shared Function ReasignoTarifaSubcontratistasDeTodasLasCDPsDescargadasSinFacturarYLasGrabo(ByVal SC As String, ByVal IdUsuario As Integer, ByVal NombreUsuario As String, Optional ByVal IdListaPrecio As Long = -1) As Integer

        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


        'me traigo la lista de subcontratistas que usan esa lista de precios
        Dim lSubcontratistasParaActualizar = (From c In db.linqClientes _
                                                From l In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = c.IdListaPrecios).DefaultIfEmpty _
                                                From pd In db.ListasPreciosDetalles.Where(Function(i) i.IdListaPrecios = l.IdListaPrecios).DefaultIfEmpty _
                                                Where c.IdListaPrecios = IdListaPrecio Select c.IdCliente, pd.PrecioCaladaLocal, pd.PrecioCaladaExportacion, pd.PrecioDescargaLocal, pd.PrecioDescargaExportacion).ToList



        Dim sublista = From i In lSubcontratistasParaActualizar Select i.IdCliente

        Dim q = (From cdp In db.CartasDePortes _
               Where _
                     (cdp.IdFacturaImputada Is Nothing Or cdp.IdFacturaImputada = 0 Or cdp.IdFacturaImputada = -1) _
                 And (cdp.Anulada <> "SI") _
                 And (sublista.Contains(cdp.Subcontr1) Or sublista.Contains(cdp.Subcontr2)) _
                ).ToList







        Dim cartasactualizadas As Integer = 0
        Dim r = 0
        '            Dim total = dt.Rows.Count

        For Each cdp In q

            ' Dim cdp As CartaDePorte = CartaDePorteManager.GetItem(SC, idcdp)

            'en realidad, lo que me pueden pasar como parametro es la lista de precios. Y ahí podría 
            'filtrar los subcontratistas (clientes) que usen esa lista de precios

            For Each i In lSubcontratistasParaActualizar
                If cdp.Subcontr1 = i.IdCliente Or cdp.Subcontr2 = i.IdCliente Then

                    If True Then
                        'cdp.TarifaSubcontratista1 = tarifaDefaultCalada
                        'cdp.TarifaSubcontratista2 = tarifaDefaultBalanza
                        If cdp.Exporta = "SI" Then
                            cdp.TarifaSubcontratista1 = i.PrecioCaladaExportacion
                            cdp.TarifaSubcontratista2 = i.PrecioDescargaExportacion
                        Else
                            cdp.TarifaSubcontratista1 = i.PrecioCaladaLocal
                            cdp.TarifaSubcontratista2 = i.PrecioDescargaLocal
                        End If
                        'db.wTarifaWilliams(
                    Else
                        ' ReasignoTarifaSubcontratistas(SC, cdp)
                        ' CartaDePorteManager.Save(SC, cdp, IdUsuario, NombreUsuario)
                    End If

                    cartasactualizadas += 1
                    'Exit For
                End If
            Next
            r = r + 1
        Next

        db.SubmitChanges()

        Return cartasactualizadas
    End Function

    Public Shared Sub ReasignoTarifaSubcontratistas(ByVal SC As String, ByRef myCartaDePorte As CartaDePorte)
        With myCartaDePorte
            '////////////////////////////////////////////////////////////////////////
            'Asigno los precios de los subcontratistas elegidos (que son como proveedores
            'de servicios)
            Try
                Dim dr1 = ListaPreciosManager.GetPreciosSubcontratistaPorIdCliente(SC, .Subcontr1)
                If Not IsNothing(dr1) Then
                    'dependiendo del combo, elijo PrecioCalada o PrecioDescarga(balanza)
                    Dim nombreColumna1 As String = IIf(.Contrato1, "PrecioCalada", "PrecioDescarga") & IIf(.Exporta, "Exportacion", "Local")
                    .TarifaSubcontratista1 = iisNull(dr1.Item(nombreColumna1), 0)
                End If
            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try

            Try
                Dim dr2 = ListaPreciosManager.GetPreciosSubcontratistaPorIdCliente(SC, .Subcontr2)
                If Not IsNothing(dr2) Then
                    'dependiendo del combo, elijo PrecioCalada o PrecioDescarga(balanza)
                    Dim nombreColumna2 As String = IIf(.Contrato2, "PrecioCalada", "PrecioDescarga") & IIf(.Exporta, "Exportacion", "Local")
                    .TarifaSubcontratista2 = iisNull(dr2.Item(nombreColumna2), 0)
                End If

            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try
            '////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////
        End With
    End Sub



    Shared Function DuplicarCartaporteConOtroSubnumeroDeFacturacion(ByVal SC As String, ByRef myCartaDePorte As CartaDePorte) As CartaDePorte

        Dim copiaocdp = GetItem(SC, myCartaDePorte.Id)
        copiaocdp.Id = -1
        copiaocdp.IdFacturaImputada = 0
        copiaocdp.IdClienteAFacturarle = -1
        copiaocdp.SubnumeroDeFacturacion = ProximoSubNumeroParaNumeroCartaPorte(SC, myCartaDePorte)
        Save(SC, copiaocdp, 1, "")
        Return copiaocdp

    End Function


    Shared Function ProximoSubNumeroParaNumeroCartaPorte(ByVal SC As String, ByVal myCartaDePorte As CartaDePorte) As Integer

        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        Dim subnumeromaximo = From e In db.CartasDePortes _
                                      Where e.NumeroCartaDePorte.GetValueOrDefault = myCartaDePorte.NumeroCartaDePorte And e.SubnumeroVagon.GetValueOrDefault = myCartaDePorte.SubnumeroVagon _
                                      Select e.SubnumeroDeFacturacion.GetValueOrDefault

        If subnumeromaximo.Count = 0 Then Return 1
        If subnumeromaximo.Count = 1 Then Return 1

        Return subnumeromaximo.Max + 1
        ' Return establecimientos

    End Function




    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////

    'Function generarWHERE(ByRef sTituloFiltroUsado As String, ByVal estado As EntidadManager.enumCDPestado,optional CriterioWHERE="todos") As String


    '    With dr



    '        Dim idVendedor = .Item("Vendedor")
    '        Dim idCorredor = .Item("Corredor")
    '        Dim idDestinatario = .Item("Entregador")
    '        Dim idIntermediario = .Item("CuentaOrden1")
    '        Dim idRemComercial = .Item("CuentaOrden2")
    '        Dim idArticulo = .Item("IdArticulo")
    '        Dim idProcedencia = .Item("Procedencia")
    '        Dim idDestino = .Item("Destino")


    '        Dim strWHERE As String = "    WHERE 1=1 "


    '        If CriterioWHERE = "todos" Then
    '            strWHERE += iisIdValido(idVendedor, "           AND CDP.Vendedor = " & idVendedor, "") & _
    '                    iisIdValido(idCorredor, "             AND CDP.Corredor=" & idCorredor, "") & _
    '                    iisIdValido(idArticulo, "           AND CDP.IdArticulo=" & idArticulo, "") & _
    '                    iisIdValido(idProcedencia, "             AND CDP.Procedencia=" & idProcedencia, "") & _
    '                    iisIdValido(idIntermediario, "             AND CDP.CuentaOrden1=" & idIntermediario, "") & _
    '                    iisIdValido(idRemComercial, "             AND CDP.CuentaOrden2=" & idRemComercial, "") & _
    '                    iisIdValido(idDestino, "             AND CDP.Destino=" & idDestino, "") & _
    '                    iisIdValido(idDestinatario, "             AND  CDP.Entregador=" & idDestinatario, "")
    '        Else
    '            strWHERE += " AND (1=0 " & _
    '                     iisIdValido(idVendedor, "           OR CDP.Vendedor = " & idVendedor, "") & _
    '                    iisIdValido(idCorredor, "             OR CDP.Corredor=" & idCorredor, "") & _
    '                    iisIdValido(idArticulo, "           OR CDP.IdArticulo=" & idArticulo, "") & _
    '                    iisIdValido(idProcedencia, "             OR CDP.Procedencia=" & idProcedencia, "") & _
    '                    iisIdValido(idIntermediario, "             OR CDP.CuentaOrden1=" & idIntermediario, "") & _
    '                    iisIdValido(idRemComercial, "             OR CDP.CuentaOrden2=" & idRemComercial, "") & _
    '                    iisIdValido(idDestino, "             OR CDP.Destino=" & idDestino, "") & _
    '                    iisIdValido(idDestinatario, "             OR  CDP.Entregador=" & idDestinatario, "") & _
    '                    "  )  "

    '        End If



    '        If estado = EntidadManager.enumCDPestado.DescargasMasFacturadas Then
    '            generarWHERE += "    AND (isnull(FechaDescarga,'1/1/1753') Between '" & iisValidSqlDate(FechaDesde, #1/1/1753#) & "' AND '" & iisValidSqlDate(FechaHasta, #1/1/2100#) & "')"
    '        Else
    '            generarWHERE += "    AND (isnull(FechaArribo,'1/1/1753') Between '" & iisValidSqlDate(FechaDesde, #1/1/1753#) & "' AND '" & iisValidSqlDate(fechaHasta, #1/1/2100#) & "')"
    '        End If

    '        If .Item("modo") = "Local" Then
    '            generarWHERE += "  AND ISNULL(CDP.Exporta,'NO')='NO'  "
    '        ElseIf .Item("modo") = "Export" Then
    '            generarWHERE += "  AND ISNULL(CDP.Exporta,'NO')='SI'  "
    '        End If


    '        'If cmbPuntoVenta.SelectedValue > 0 Then
    '        '    generarWHERE += "AND (PuntoVenta=" & cmbPuntoVenta.SelectedValue & ")"  ' OR PuntoVenta=0)"  'lo del punto de venta=0 era por las importaciones donde alguien (con acceso a todos los puntos de venta) no tenía donde elegir cual 
    '        'End If


    '    End With
    'End Function

    Public Shared Function EstadoWHERE(ByVal estado As enumCDPestado, Optional ByVal tablaPrefijo As String = "", Optional ByVal SC As String = "") As String

        Select Case estado
            Case enumCDPestado.Todas
                EstadoWHERE = ""

            Case enumCDPestado.TodasMenosLasRechazadas

                EstadoWHERE = " AND ISNULL(" & tablaPrefijo & "Anulada,'NO')<>'SI'" 'hay registros que no tienen NO ni SI ni null. Quizas tengan cadena vacia

            Case enumCDPestado.Incompletas
                EstadoWHERE = " AND (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR " & tablaPrefijo & "IdArticulo IS NULL) AND ISNULL(IdFacturaImputada,0)=0 AND ISNULL(" & tablaPrefijo & "Anulada,'NO')<>'SI'"
                's += " AND (ConfirmadoPorWeb='NO' OR ConfirmadoPorWeb IS NULL)"

            Case enumCDPestado.Posicion
                EstadoWHERE = " AND NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR " & tablaPrefijo & "IdArticulo IS NULL) AND ISNULL(NetoProc,0)=0 AND ISNULL(IdFacturaImputada,0)=0 AND ISNULL(" & tablaPrefijo & "Anulada,'NO')<>'SI' "

            Case enumCDPestado.DescargasDeHoyMasTodasLasPosiciones
                EstadoWHERE = " AND " & _
                                " (                                               " & _
                                "       ( NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR " & tablaPrefijo & "IdArticulo IS NULL) AND ISNULL(NetoProc,0)=0 AND ISNULL(IdFacturaImputada,0)=0 AND ISNULL(" & tablaPrefijo & "Anulada,'NO')<>'SI' ) " & _
                                "   OR                                              " & _
                                "       ( ISNULL(NetoProc,0)>0 AND fechadescarga >= #" & FechaANSI(Today) & "# )" & _
                                " ) "


            Case enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha
                EstadoWHERE = " AND " & _
                                " (                                               " & _
                                "       ( NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR " & _
                                tablaPrefijo & "IdArticulo IS NULL) AND ISNULL(NetoProc,0)=0 AND ISNULL(IdFacturaImputada,0)=0 AND " & _
                                "       ISNULL(" & tablaPrefijo & "Anulada,'NO')<>'SI' ) " & _
                                "   OR                                              " & _
                                "       ( ISNULL(NetoProc,0)>0 AND fechadescarga >= #" & FechaANSI(Today) & "# )" & _
                                " ) "

            Case enumCDPestado.DescargasMasFacturadas
                EstadoWHERE = " AND NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR " & tablaPrefijo & "IdArticulo IS NULL) AND ISNULL(NetoProc,0)>0 AND ISNULL(" & tablaPrefijo & "Anulada,'NO')<>'SI'"
                's += " AND (ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL)"
            Case enumCDPestado.DescargasSinFacturar
                EstadoWHERE = " AND NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR " & tablaPrefijo & "IdArticulo IS NULL) AND ISNULL(NetoProc,0)>0 AND ISNULL(" & tablaPrefijo & "Anulada,'NO')<>'SI' AND ISNULL(IdFacturaImputada,0)=0 "
            Case enumCDPestado.Facturadas
                EstadoWHERE = " AND ISNULL(IdFacturaImputada,0)>0 AND ISNULL(" & tablaPrefijo & "Anulada,'NO')<>'SI'"
            Case enumCDPestado.NoFacturadas
                EstadoWHERE = " AND NOT(ISNULL(IdFacturaImputada,0)>0 AND ISNULL(" & tablaPrefijo & "Anulada,'NO')<>'SI')"
            Case enumCDPestado.Rechazadas
                EstadoWHERE = " AND ISNULL(" & tablaPrefijo & "Anulada,'NO')='SI'"
            Case enumCDPestado.FacturadaPeroEnNotaCredito
                Dim dt As DataTable = EntidadManager.ExecDinamico(SC, "           Select distinct  " & _
                           "               CuentasCorrientesDeudores.idcomprobante " & _
                           "               FROM DetalleNotasCreditoImputaciones DetCre" & _
                           "               LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=DetCre.IdNotaCredito" & _
                           "               LEFT OUTER JOIN CuentasCorrientesDeudores ON CuentasCorrientesDeudores.IdCtaCte=DetCre.IdImputacion " & _
                           "               LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CuentasCorrientesDeudores.IdTipoComp " & _
                           "               where TiposComprobante.DescripcionAB='FA' and CuentasCorrientesDeudores.idcomprobante <>0 " & _
                           "              ")

                Dim listaIdFactura As New System.Collections.Generic.List(Of String)
                listaIdFactura.Add("-800") 'para que haya algo y no explote el WHERE
                For Each dr As DataRow In dt.Rows
                    listaIdFactura.Add(dr("IdComprobante"))
                Next
                Dim s = Join(listaIdFactura.Distinct.ToArray, ",")
                EstadoWHERE = " AND idFacturaImputada in (" & s & ")   "

            Case Else
                EstadoWHERE = Nothing
        End Select
    End Function



    Public Shared Function BuscaMermaSegunHumedadArticulo(ByVal SC As String, ByVal IdArticulo As Long, ByVal Humedad As Double) As Double

        Dim strSQL = " select * from CDPHumedades  " & _
                                        " WHERE    IdArticulo = " & IdArticulo & _
                                        "      AND Humedad<=" & DecimalToString(Humedad) & _
                                        " ORDER BY Humedad DESC"
        '" ORDER BY IdCDPHumedad DESC" <--- por qué estaba así???

        Dim dt = EntidadManager.ExecDinamico(SC, strSQL)
        If dt.Rows.Count > 0 Then
            Return dt.Rows(0).Item("Merma")
        Else
            Return 0
        End If
    End Function

    Shared Function CopiarEnHistorico(ByVal SC As String, ByVal IdCartaPorte As Long)
        Try
            'ojo que la tabla no tiene orden.
            'trayendote las FechaModicacion del historico y la oficial, tenes todo
            Dim sSql = "insert into cartasdeportehistorico(IdCartaDePorte, NumeroCartaDePorte, IdUsuarioIngreso, FechaIngreso, Anulada, IdUsuarioAnulo, FechaAnulacion, Observaciones, Vendedor, CuentaOrden1, CuentaOrden2, Corredor, Entregador, Procedencia, Patente, IdArticulo, IdStock, Partida, IdUnidad, IdUbicacion, Cantidad, Cupo, NetoProc, Calidad, BrutoPto, TaraPto, NetoPto, Acoplado, Humedad, Merma, NetoFinal, FechaDeCarga, FechaVencimiento, CEE, IdTransportista, TransportistaCUITdesnormalizado, IdChofer, ChoferCUITdesnormalizado, CTG, Contrato, Destino, Subcontr1, Subcontr2, Contrato1, contrato2, KmARecorrer, Tarifa, FechaDescarga, Hora, NRecibo, CalidadDe, TaraFinal, BrutoFinal, Fumigada, Secada, Exporta, NobleExtranos, NobleNegros, NobleQuebrados, NobleDaniados, NobleChamico, NobleChamico2, NobleRevolcado, NobleObjetables, NobleAmohosados, NobleHectolitrico, NobleCarbon, NoblePanzaBlanca, NoblePicados, NobleMGrasa, NobleAcidezGrasa, NobleVerdes, NobleGrado, NobleConforme, NobleACamara, Cosecha, HumedadDesnormalizada, Factor, IdFacturaImputada, PuntoVenta, SubnumeroVagon, TarifaFacturada, TarifaSubcontratista1, TarifaSubcontratista2, FechaArribo, Version, MotivoAnulacion, NumeroSubfijo, IdEstablecimiento, EnumSyngentaDivision, Corredor2, IdUsuarioModifico, FechaModificacion, FechaEmision, EstaArchivada, ExcluirDeSubcontratistas, IdTipoMovimiento, IdClienteAFacturarle, SubnumeroDeFacturacion, AgregaItemDeGastosAdministrativos, CalidadGranosQuemados, CalidadGranosQuemadosBonifica_o_Rebaja, CalidadTierra, CalidadTierraBonifica_o_Rebaja, CalidadMermaChamico, CalidadMermaChamicoBonifica_o_Rebaja, CalidadMermaZarandeo, CalidadMermaZarandeoBonifica_o_Rebaja, FueraDeEstandar, CalidadPuntaSombreada)" & _
                        " select IdCartaDePorte, NumeroCartaDePorte, IdUsuarioIngreso, FechaIngreso, Anulada, IdUsuarioAnulo, FechaAnulacion, Observaciones, Vendedor, CuentaOrden1, CuentaOrden2, Corredor, Entregador, Procedencia, Patente, IdArticulo, IdStock, Partida, IdUnidad, IdUbicacion, Cantidad, Cupo, NetoProc, Calidad, BrutoPto, TaraPto, NetoPto, Acoplado, Humedad, Merma, NetoFinal, FechaDeCarga, FechaVencimiento, CEE, IdTransportista, TransportistaCUITdesnormalizado, IdChofer, ChoferCUITdesnormalizado, CTG, Contrato, Destino, Subcontr1, Subcontr2, Contrato1, contrato2, KmARecorrer, Tarifa, FechaDescarga, Hora, NRecibo, CalidadDe, TaraFinal, BrutoFinal, Fumigada, Secada, Exporta, NobleExtranos, NobleNegros, NobleQuebrados, NobleDaniados, NobleChamico, NobleChamico2, NobleRevolcado, NobleObjetables, NobleAmohosados, NobleHectolitrico, NobleCarbon, NoblePanzaBlanca, NoblePicados, NobleMGrasa, NobleAcidezGrasa, NobleVerdes, NobleGrado, NobleConforme, NobleACamara, Cosecha, HumedadDesnormalizada, Factor, IdFacturaImputada, PuntoVenta, SubnumeroVagon, TarifaFacturada, TarifaSubcontratista1, TarifaSubcontratista2, FechaArribo, Version, MotivoAnulacion, NumeroSubfijo, IdEstablecimiento, EnumSyngentaDivision, Corredor2, IdUsuarioModifico, FechaModificacion, FechaEmision, EstaArchivada, ExcluirDeSubcontratistas, IdTipoMovimiento, IdClienteAFacturarle, SubnumeroDeFacturacion, AgregaItemDeGastosAdministrativos, CalidadGranosQuemados, CalidadGranosQuemadosBonifica_o_Rebaja, CalidadTierra, CalidadTierraBonifica_o_Rebaja, CalidadMermaChamico, CalidadMermaChamicoBonifica_o_Rebaja, CalidadMermaZarandeo, CalidadMermaZarandeoBonifica_o_Rebaja, FueraDeEstandar, CalidadPuntaSombreada " & _
                        " from cartasdeporte where IdCartaDePorte=" & IdCartaPorte
            ExecDinamico(SC, sSql)
        Catch ex As Exception
            ErrHandler.WriteError(ex)
        End Try

        LogPronto(SC, IdCartaPorte, "CARTAPORTE", "")
    End Function


    <DataObjectMethod(DataObjectMethodType.Select, True)> _
    Public Shared Function GetListTX(ByVal SC As String, ByVal TX As String) As System.Data.DataSet
        'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
        ' variable para guardar el valor del checkbox


        'If Parametros Is Nothing Then Parametros = New String() {""}
        Dim ds As DataSet
        Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
        With dc
            .ColumnName = "ColumnaTilde"
            .DataType = System.Type.GetType("System.Int32")
            .DefaultValue = 0
        End With


        If TX = "" Then
            ds = GeneralDB.TraerDatos(SC, "wCartasDePorte_T", -1)
        Else
            Try
                ds = GeneralDB.TraerDatos(SC, "wCartasDePorte_TX" & TX)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "CartasDePorte_TX" & TX)
            End Try
        End If


        ds.Tables(0).Columns.Add(dc)
        Return ds
    End Function


    <DataObjectMethod(DataObjectMethodType.Select, True)> _
    Public Shared Function GetListDatasetWHERE(ByVal SC As String, ByVal ColumnaParaFiltrar As String, ByVal TextoParaFiltrar As String, ByVal sortExpression As String, ByVal startRowIndex As Long, ByVal maximumRows As Long) As System.Data.DataTable
        Dim ds As DataSet

        ds = GeneralDB.TraerDatos(SC, "wCartasPorte_TTpaginadoYfiltrado", ColumnaParaFiltrar, TextoParaFiltrar, sortExpression, startRowIndex, maximumRows)



        Dim dt As DataTable = ds.Tables(0)
        '////////////////////////////////////
        '////////////////////////////////////
        'viendo si lo puedo ordenar
        '////////////////////////////////////
        '////////////////////////////////////
        'dt.DefaultView.Sort = sortExpression

        If dt.Rows.Count > 0 Then
            Debug.Print(dt.Rows(0).Item("NumeroCartaDePorte"))
            Dim v As DataView = dt.DefaultView
            v.Sort = sortExpression
            dt = v.ToTable()
            Debug.Print(dt.Rows(0).Item("NumeroCartaDePorte"))
            'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????

        End If
        'e.SortExpression(+" " + ConvertSortDirectionToSql(e.SortDirection))

        '////////////////////////////////////

        'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
        'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
        With ds.Tables(0)
            .Columns("IdCartaDePorte").ColumnName = "Id"
            '.Columns("Numero").ColumnName = "Numero"
            '.Columns("FechaRequerimiento").ColumnName = "Fecha"
        End With

        'ds.Tables(0).Columns.Add(dc)
        'Return ds
        Return ds.Tables(0)

        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
    End Function


    <DataObjectMethod(DataObjectMethodType.Select, True)> _
    Public Shared Function GetListDataset(ByVal SC As String, ByVal sortExpression As String) As System.Data.DataTable

        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????


        'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
        ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
        Dim ds As DataSet
        'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
        'With dc
        '    .ColumnName = "ColumnaTilde"
        '    .DataType = System.Type.GetType("System.Int32")
        '    .DefaultValue = 0
        'End With


        Try
            ds = GeneralDB.TraerDatos(SC, "wCartasDePorte_T", -1)
        Catch ex As Exception
            ds = GeneralDB.TraerDatos(SC, "CartasDePorte_T", -1)
        End Try




        Dim dt As DataTable = ds.Tables(0)


        '////////////////////////////////////
        '////////////////////////////////////
        'viendo si lo puedo ordenar
        '////////////////////////////////////
        '////////////////////////////////////
        'dt.DefaultView.Sort = sortExpression

        If dt.Rows.Count > 0 Then
            Debug.Print(dt.Rows(0).Item("NumeroCartaDePorte"))
            Dim v As DataView = dt.DefaultView
            v.Sort = sortExpression
            dt = v.ToTable()
            Debug.Print(dt.Rows(0).Item("NumeroCartaDePorte"))
            'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
            'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
            'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
            'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
            'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
            'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
            'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
            'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
            'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????

        End If
        'e.SortExpression(+" " + ConvertSortDirectionToSql(e.SortDirection))

        '////////////////////////////////////
        '////////////////////////////////////
        '////////////////////////////////////
        '////////////////////////////////////

        'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
        'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
        With ds.Tables(0)
            .Columns("IdCartaDePorte").ColumnName = "Id"
            '.Columns("Numero").ColumnName = "Numero"
            '.Columns("FechaRequerimiento").ColumnName = "Fecha"
        End With

        'ds.Tables(0).Columns.Add(dc)
        'Return ds
        Return ds.Tables(0)

        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
    End Function







    Shared Function GetListDataTableDinamicoConWHERE(ByVal SC As String, ByVal estado As EntidadManager.enumCDPestado, ByVal strWHERE As String) As DataTable

        'lo que sea dinámico, lo tendré que migrar para evitar SQL injection.


        Dim strSQL = String.Format("SELECT  " & _
"                                       cast(NumeroCartaDePorte as varchar) +  ' ' + " & _
"CASE  " & _
"WHEN isnull(NumeroSubfijo,'0') =0  THEN '' " & _
"ELSE cast(NumeroSubfijo as varchar) " & _
"            End " & _
"+ " & _
"CASE " & _
"WHEN isnull( SubnumeroVagon,'0') =0  THEN '' " & _
"ELSE cast(SubnumeroVagon as varchar) " & _
"            End  as  [C.Porte]  , " & _
"       FechaArribo   as  Arribo , " & _
"        convert(char, Hora, 108)   as  Hora, " & _
"         Articulos.Descripcion as  Producto, " & _
"       Contrato  as  Contrato , " & _
"       NetoPto   as  [Kg.Proc.] , " & _
"       TaraPto   as  [Kg.Tara Proc.] , " & _
"       BrutoPto   as  [Kg.Bruto Proc.], " & _
"       BrutoFinal   as  [Kg.Bruto Desc.] , " & _
"       TaraFinal   as  [Kg.Tara Desc.] , " & _
"       NetoFinal   as  [Kg.Neto Desc.] , " & _
"       NetoFinal-NetoPto   as  [Kg.Dif.] , " & _
"         Humedad as  [H.%]	 , " & _
"         HumedadDesnormalizada as [Mer.Kg.] , " & _
"         Merma as Otras , " & _
"        NetoProc  as  [Kg.Netos] , " & _
"       CLIVEN.Razonsocial as   Titular  , " & _
"       CLICO1.Razonsocial as   Intermediario  , " & _
"       CLICO2.Razonsocial as   [R. Comercial]  , " & _
"       CLICOR.Nombre as    [Corredor ], " & _
"       CLIENT.Razonsocial  as  [Destinatario], " & _
"        Patente as  [Pat. Chasis] , " & _
"         Acoplado as [Pat. Acoplado] , " & _
"        TRANS.CUIT as [CUIT Transp.] , " & _
"         TRANS.RazonSocial as Trasportista , " & _
"         LOCDES.Descripcion   as  Destino , " & _
"        LOCORI.Nombre as    [Procedcia.] , " & _
"         FechaDescarga as   [Desc.], " & _
"       Calidades.Descripcion AS  [Calidad], " & _
"         CDP.Observaciones  as  [Observaciones], " & _
"         CHOF.CUIL as   [CUIT chofer], " & _
"         CHOF.Nombre as   Chofer, " & _
"         LOCORI.CodigoONCAA as  [Nro ONCA] , " & _
"         LOCDES.CodigoONCAA as   [Pta ONCA], " & _
"         '' as   Provincia, " & _
"         CEE as   [Nro CEE]	, " & _
"          FechaVencimiento as  [Vencim.CP], " & _
"          FechaDeCarga as  [Emision CP], " & _
"          PuntoVenta  as Sucursal, " & _
"          KmARecorrer as  Km, " & _
"          Tarifa as Tarifa, " & _
"           CTG as CTG, FechaAnulacion,MotivoAnulacion " & _
                  " FROM CartasDePorte CDP " & _
                   " LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente " & _
                   " LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente " & _
                   " LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente " & _
                   " LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor " & _
                   " LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente " & _
                   " LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo " & _
                   " LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista " & _
                    " LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad " & _
                    " LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer " & _
                   " LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & _
                   " LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino " & _
                "")




        strWHERE += CartaDePorteManager.EstadoWHERE(estado, "CDP.")



        strSQL += strWHERE
        Debug.Print(strWHERE)

        Dim dt = EntidadManager.ExecDinamico(SC, strSQL)

        Return dt
    End Function



    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    Public Shared Function GetListDataview(ByVal SC As String, ByVal sortExpression As String) As System.Data.DataView



        'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
        ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
        Dim ds As DataSet
        'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
        'With dc
        '    .ColumnName = "ColumnaTilde"
        '    .DataType = System.Type.GetType("System.Int32")
        '    .DefaultValue = 0
        'End With


        Try
            ds = GeneralDB.TraerDatos(SC, "wCartasDePorte_T", -1)
        Catch ex As Exception
            ds = GeneralDB.TraerDatos(SC, "CartasDePorte_T", -1)
        End Try




        Dim dt As DataTable = ds.Tables(0)



        'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
        'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
        With ds.Tables(0)
            .Columns("IdCartaDePorte").ColumnName = "Id"
            '.Columns("Numero").ColumnName = "Numero"
            '.Columns("FechaRequerimiento").ColumnName = "Fecha"
        End With

        'ds.Tables(0).Columns.Add(dc)
        'Return ds

        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????
        'pinta que tengo que devolver un Dataview si quiero ordenar, y un Dataset/table si quiero filtrar. Cómo hago las dos cosas????




        Dim dv As New DataView(ds.Tables(0))
        dv.Sort = sortExpression
        Return dv


    End Function



    <DataObjectMethod(DataObjectMethodType.Select, True)> _
    Public Shared Function GetListTX(ByVal SC As String, ByVal TX As String, ByVal ParamArray Parametros() As Object) As System.Data.DataSet
        'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
        ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
        Dim ds As DataSet
        Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
        With dc
            .ColumnName = "ColumnaTilde"
            .DataType = System.Type.GetType("System.Int32")
            .DefaultValue = 0
        End With


        Try
            ds = GeneralDB.TraerDatos(SC, "wCartasDePorte_TX" & TX, Parametros)
        Catch ex As Exception
            ds = GeneralDB.TraerDatos(SC, "CartasDePorte_TX" & TX, Parametros)
        End Try
        ds.Tables(0).Columns.Add(dc)
        Return ds
    End Function


    <DataObjectMethod(DataObjectMethodType.Select, True)> _
    Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
        Return CartaDePorteDB.GetList_fm(SC)
    End Function

    <DataObjectMethod(DataObjectMethodType.Select, False)> _
    Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As CartaDePorte
        Return GetItem(SC, id, False)
    End Function

    <DataObjectMethod(DataObjectMethodType.Select, False)> _
    Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, ByVal getCartaDePorteDetalles As Boolean) As CartaDePorte
        Dim myCartaDePorte As CartaDePorte
        myCartaDePorte = CartaDePorteDB.GetItem(SC, id)

        With myCartaDePorte

            Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
            Dim oCarta = (From i In db.CartasDePortes Where i.IdCartaDePorte = id).SingleOrDefault

            Try
                .CalidadGranosQuemados = iisNull(oCarta.CalidadGranosQuemados, 0)
                .CalidadGranosQuemadosBonifRebaja = iisNull(oCarta.CalidadGranosQuemadosBonifica_o_Rebaja, 0)
                .CalidadTierra = iisNull(oCarta.CalidadTierra, 0)
                .CalidadTierraBonifRebaja = iisNull(oCarta.CalidadTierraBonifica_o_Rebaja, 0)
                .CalidadMermaChamico = iisNull(oCarta.CalidadMermaChamico, 0)
                .CalidadMermaChamicoBonifRebaja = iisNull(oCarta.CalidadMermaChamicoBonifica_o_Rebaja, 0)
                .CalidadMermaZarandeo = iisNull(oCarta.CalidadMermaZarandeo, 0)
                .CalidadMermaZarandeoBonifRebaja = iisNull(oCarta.CalidadMermaZarandeoBonifica_o_Rebaja, 0)
                .FueraDeEstandar = iisNull(oCarta.FueraDeEstandar, "NO") <> "NO"
                .CalidadPuntaSombreada = iisNull(oCarta.CalidadPuntaSombreada, 0)
                .LiquidaViaje = iisNull(oCarta.LiquidaViaje, "NO") <> "NO"
                .CobraAcarreo = iisNull(oCarta.CobraAcarreo, "NO") <> "NO"

                .IdClienteAuxiliar = If(oCarta.IdClienteAuxiliar, -1)
                .IdClienteEntregador = If(oCarta.IdClienteEntregador, -1)
                .IdClientePagadorFlete = If(oCarta.IdClientePagadorFlete, -1)



                .SojaSustentableCodCondicion = iisNull(oCarta.SojaSustentableCodCondicion, "")
                .SojaSustentableCondicion = iisNull(oCarta.SojaSustentableCondicion, "")
                .SojaSustentableNroEstablecimientoDeProduccion = iisNull(oCarta.SojaSustentableNroEstablecimientoDeProduccion, "")


                .CalidadDescuentoFinal = iisNull(oCarta.CalidadDescuentoFinal, 0)

                .PathImagen = iisNull(oCarta.PathImagen)
                .PathImagen2 = iisNull(oCarta.PathImagen2)


                .Acopio1 = If(oCarta.Acopio1, -1)
                .Acopio2 = If(oCarta.Acopio2, -1)
                .Acopio3 = If(oCarta.Acopio3, -1)
                .Acopio4 = If(oCarta.Acopio4, -1)
                .Acopio5 = If(oCarta.Acopio5, -1)

            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try

        End With

        'If Not (myCartaDePorte Is Nothing) AndAlso getCartaDePorteDetalles Then
        '    myCartaDePorte.Detalles = CartaDePorteItemDB.GetList(SC, id)
        'End If
        Return myCartaDePorte
    End Function




    '<DataObjectMethod(DataObjectMethodType.Select, False)> _
    Public Shared Function GetItemPorNumero(ByVal SC As String, ByVal NumeroCartaDePorte As Long, ByVal SubNumeroVagon As Long, ByVal SubnumeroFacturacion As Integer) As CartaDePorte

        Dim ds As Data.DataSet '= GeneralDB.TraerDatos(SC, "wCartasDePorte_TX_PorNumero", NumeroCartaDePorte, SubNumeroVagon)
        '        CREATE PROCEDURE [dbo].wCartasDePorte_TX_PorNumero
        '    @Numero BIGINT,
        '    @SubNumeroVagon INT = NULL
        '	--,@NumeroSubFijo  INT = NULL
        'AS 
        '    SELECT  *
        '    FROM    CartasDePorte
        '    WHERE   NumeroCartaDePorte = @Numero --AND SubNumero=@SubNumero
        '            AND SubNumeroVagon = ISNULL(@SubnumeroVagon, SubNumeroVagon)
        '            --AND NumeroSubFijo = ISNULL(@NumeroSubFijo, NumeroSubFijo)
        '			--AND isnull(Anulada,'NO')<>'SI'
        '	order by subnumerodefacturacion desc
        'go


        'arreglar esto, porque la segunda vez que se llama con el mismo subnumerodefacturacion, va a devolver un error



        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        Dim familia = (From e In db.CartasDePortes _
                                      Where e.NumeroCartaDePorte.GetValueOrDefault = NumeroCartaDePorte _
                                            And e.SubnumeroVagon.GetValueOrDefault = SubNumeroVagon _
                                            Order By e.FechaAnulacion Descending _
                                      Select e).ToList()


        Dim sss = familia.Where(Function(x) x.SubnumeroDeFacturacion = SubnumeroFacturacion).FirstOrDefault


        If familia.Count = 0 Then Return New CartaDePorte
        If sss IsNot Nothing Then Return CartaDePorteDB.GetItem(SC, sss.IdCartaDePorte)
        If SubnumeroFacturacion > 0 Then Return New CartaDePorte
        If familia.Count = 1 Then Return CartaDePorteDB.GetItem(SC, familia(0).IdCartaDePorte)

        ErrHandler.WriteAndRaiseError("Ya existe una carta con ese número y vagon: " & NumeroCartaDePorte & " " & SubNumeroVagon & ".  Puede ser una con otro Subnumero de facturacion ")







        If ds.Tables(0).Rows.Count = 1 Then


            'devuelvo la primera que encontré -está MAL. si hay mas de uno, es un error
            Dim myCartaDePorte As CartaDePorte
            myCartaDePorte = CartaDePorteDB.GetItem(SC, ds.Tables(0).Rows(0).Item("IdCartaDePorte"))

            'es un error. si estoy buscando un subnumero de facturacion especifico, me va a cagar
            If SubnumeroFacturacion > 0 And myCartaDePorte.SubnumeroDeFacturacion <> SubnumeroFacturacion Then Return New CartaDePorte

            Return myCartaDePorte

        ElseIf ds.Tables(0).Rows.Count > 1 Then
            'OJO:  puede ser una con otro subnumerodefacturacion...
            ErrHandler.WriteAndRaiseError("Ya existe una carta con ese número y vagon: " & NumeroCartaDePorte & " " & SubNumeroVagon & ".  Puede ser una con otro Subnumero de facturacion ")




            '            __________________________()

            '            Log(Entry)
            '04/11/2013 17:45:34
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=-1. Error Message:System.Exception
            'Application-defined or object-defined error.
            '   at Microsoft.VisualBasic.ErrObject.Raise(Int32 Number, Object Source, Object Description, Object HelpFile, Object HelpContext)
            '   at ErrHandler.WriteAndRaiseError(String errorMessage) in E:\Backup\BDL\ProntoWeb\BusinessObject\ErrHandler.vb:line 120
            '   at CartaDePorteManager.GetItemPorNumero(String SC, Int64 NumeroCartaDePorte, Int64 SubNumeroVagon)
            '   at CartaDePorteManager.validarUnicidad(String SC, String txtNumeroCDP, String txtSubNumeroVagon, Int32 IdEntity, CartaDePorte actualCartaDePorte)
            '            at(CartadeporteABM.RefrescarValidadorDuplicidad())
            '   at CartadeporteABM.txtNumeroCDP_TextChanged(Object sender, EventArgs e)
            '   at System.EventHandler.Invoke(Object sender, EventArgs e)
            '   at System.Web.UI.WebControls.TextBox.OnTextChanged(EventArgs e)
            '            at(System.Web.UI.WebControls.TextBox.RaisePostDataChangedEvent())
            '            at(System.Web.UI.WebControls.TextBox.System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent())
            '            at(System.Web.UI.Page.RaiseChangedEvents())
            '   at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
            'Más de una carta tiene ese numero y vagon
            Return Nothing
        Else

            'no encontré nada, le creo una nueva
            Return New CartaDePorte

        End If

    End Function





    Public Const kMaximoSubnumeroDePresupuestoAceptable As Integer = 12 'por ahora, como la grilla de CartaDePorte es estatica y estoy usando el subnumero como columna, estoy frito
    Public Const ColumnasFijas = 2






    '//////////////////////////////////

    Shared Function TraerUltimoTimeStamp(ByVal SC As String, id As Integer) As Long
        Dim ultimoTimeStamp As Long = BitConverter.ToInt64(EntidadManager.ExecDinamico(SC, "SELECT TOP 1 FechaTimeStamp from CartasDePorte where idCartaDePorte=" & id).Rows(0).Item(0), 0)

        Return ultimoTimeStamp
    End Function


    Shared Function VerificarConcurrenciaTimeStamp(ByVal SC As String, id As Integer, timeStamp As Long) As Boolean
        Dim ultimoTimeStamp As Long = BitConverter.ToInt64(EntidadManager.ExecDinamico(SC, "SELECT TOP 1 FechaTimeStamp from CartasDePorte where idCartaDePorte=" & id).Rows(0).Item(0), 0)

        Return (ultimoTimeStamp = timeStamp)
    End Function


    Public Shared Function EsUnoDeLosClientesExportador(ByVal SC As String, ByVal myCartaDePorte As CartaDePorte) As Boolean
        '        * La magia quedaría así: el usuario llena la carta, y pone grabar...
        '*Si la carta usa un cliente exportador en Destinatario, Intermediario o Rte Comercial,
        '*entonces te hago de prepo una duplicacion de la carta
        '*La que queda como exportacion, tendrá el A Facturar con el dichoso cliente exportador
        '*Y la otra carta, la local, quedará para que le rellenen el A Facturar, por las fuerzas superiores

        Try

            If _
              IIf(myCartaDePorte.Entregador <= 0, False, ClienteManager.GetItem(SC, myCartaDePorte.Entregador).EsClienteExportador = "SI") Or _
              IIf(myCartaDePorte.CuentaOrden1 <= 0, False, ClienteManager.GetItem(SC, myCartaDePorte.CuentaOrden1).EsClienteExportador = "SI") Or _
              IIf(myCartaDePorte.CuentaOrden2 <= 0, False, ClienteManager.GetItem(SC, myCartaDePorte.CuentaOrden2).EsClienteExportador = "SI") Then

                Return True


            End If


        Catch ex As Exception
            ErrHandler.WriteError(ex)
        End Try
        Return False
    End Function

    Public Shared Sub CrearleDuplicadaConEl_FacturarA_Indicado(ByVal SC As String, ByVal myCartaDePorte As CartaDePorte)
        '        * La magia quedaría así: el usuario llena la carta, y pone grabar...
        '*Si la carta usa un cliente exportador en Destinatario, Intermediario o Rte Comercial,
        '*entonces te hago de prepo una duplicacion de la carta
        '*La que queda como exportacion, tendrá el A Facturar con el dichoso cliente exportador
        '*Y la otra carta, la local, quedará para que le rellenen el A Facturar, por las fuerzas superiores
        ' efasdfasdf()

        Dim idclienteexportador As Integer

        If IIf(myCartaDePorte.Entregador <= 0, False, ClienteManager.GetItem(SC, myCartaDePorte.Entregador).EsClienteExportador = "SI") Then
            idclienteexportador = myCartaDePorte.Entregador
        End If
        If IIf(myCartaDePorte.CuentaOrden1 <= 0, False, ClienteManager.GetItem(SC, myCartaDePorte.CuentaOrden1).EsClienteExportador = "SI") Then
            idclienteexportador = myCartaDePorte.CuentaOrden1
        End If
        If IIf(myCartaDePorte.CuentaOrden2 <= 0, False, ClienteManager.GetItem(SC, myCartaDePorte.CuentaOrden2).EsClienteExportador = "SI") Then
            idclienteexportador = myCartaDePorte.CuentaOrden2
        End If
   



        'por más que pongas ByVal, un objeto se pasa por referencia creo. -Tendrías que sobrecargar el igual, o hacer un constructor que use una carta existente

        Dim tempid = myCartaDePorte.Id
        Dim tempidcli = IIf(myCartaDePorte.IdClienteAFacturarle = idclienteexportador, -1, myCartaDePorte.IdClienteAFacturarle)


        myCartaDePorte.Id = -1
        myCartaDePorte.IdClienteAFacturarle = idclienteexportador
        myCartaDePorte.Exporta = "SI"

        'como evitar la recursion?
        CartaDePorteManager.Save(SC, myCartaDePorte, 0, "", False)


        myCartaDePorte.Id = tempid
        myCartaDePorte.IdClienteAFacturarle = tempidcli
        myCartaDePorte.Exporta = "NO"

        CartaDePorteManager.Save(SC, myCartaDePorte, 0, "", False)


    End Sub




    <DataObjectMethod(DataObjectMethodType.Update, True)> _
    Public Shared Function Save(ByVal SC As String, ByVal myCartaDePorte As CartaDePorte, ByVal IdUsuario As Integer, ByVal NombreUsuario As String, Optional ByVal bCopiarDuplicados As Boolean = True) As Integer
        Dim CartaDePorteId As Integer

        'Dim myTransactionScope As TransactionScope = New TransactionScope
        Try

            Dim ms As String
            If Not IsValid(SC, myCartaDePorte, ms) Then
                ErrHandler.WriteError(ms)
                Return -1
            End If




            With myCartaDePorte
                If .Id <= 0 Then
                    .FechaIngreso = Now
                    .IdUsuarioIngreso = IdUsuario

                Else
                    'If .IdFacturaImputadaOriginal Then
                    If .IdFacturaImputada >= 0 Then


                        If Not VerificarConcurrenciaTimeStamp(SC, .Id, .FechaTimeStamp) Then
                            'si es un duplicado, por ahora no verifiquemos la concurrencia, porque creo que modifican primero la original
                            If .SubnumeroDeFacturacion = -1 Then
                                Throw New Exception(". Otro usuario actualizó la carta mientras vos la editabas. Por favor, volvé a cargar la carta y hacé nuevamente las modificaciones. Es posible que no esté más disponible para editar")
                            End If
                        End If

                        'LogPronto( SC,.Id,"C)


                        'EntidadManager.Tarea(SC, "Log_InsertarRegistro", "ALTAINF", _
                        '            dr.Item(0), 0, Now, 0, Mid(logtexto, 1, 100), _
                        '         Mid(logtexto, 101, 50), Mid(logtexto, 151, 50), Mid(logtexto, 201, 50), _
                        '         Mid(logtexto, 251, 50), Mid(logtexto, 301, 50), DBNull.Value, DBNull.Value, _
                        '          DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, _
                        '          99990, DBNull.Value, DBNull.Value)

                        CopiarEnHistorico(SC, .Id)
                    End If





                End If
                .FechaModificacion = Now
                .IdUsuarioModifico = IdUsuario




                'TODO: cuando anulan, pinta que pasa el isvalid.   logear el id y numero de carta si no lo estas haciendo ya

                'si manotearon la unicidad (numerocdp, vagon) tambien debería loguearse el cambio (lo ideal sería que no pudiesen cambiarlo...)
                'si manotearon la unicidad (numerocdp, vagon) tambien debería loguearse el cambio (lo ideal sería que no pudiesen cambiarlo...)
                'si manotearon la unicidad (numerocdp, vagon) tambien debería loguearse el cambio (lo ideal sería que no pudiesen cambiarlo...)



                CartaDePorteId = CartaDePorteDB.Save(SC, myCartaDePorte)

                'hay que tomar tambien el nuevo timestamp
                'hay que tomar tambien el nuevo timestamp
                'hay que tomar tambien el nuevo timestamp
                'hay que tomar tambien el nuevo timestamp
                'hay que tomar tambien el nuevo timestamp
                'hay que tomar tambien el nuevo timestamp

                '- Replicar todas las modificaciones realizadas en el original inclusive la imagen y exceptuando los campos liberados según el punto anterior.



                Try

                    Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


                    Dim oCarta = (From i In db.CartasDePortes Where i.IdCartaDePorte = CartaDePorteId).SingleOrDefault
                    oCarta.CalidadGranosQuemados = CDec(iisNull(.CalidadGranosQuemados, 0))
                    oCarta.CalidadGranosQuemadosBonifica_o_Rebaja = iisNull(.CalidadGranosQuemadosBonifRebaja, 0)
                    oCarta.CalidadTierra = CDec(iisNull(.CalidadTierra, 0))
                    oCarta.CalidadTierraBonifica_o_Rebaja = iisNull(.CalidadTierraBonifRebaja, 0)
                    oCarta.CalidadMermaChamico = CDec(iisNull(.CalidadMermaChamico, 0))
                    oCarta.CalidadMermaChamicoBonifica_o_Rebaja = iisNull(.CalidadMermaChamicoBonifRebaja, 0)
                    oCarta.CalidadMermaZarandeo = CDec(iisNull(.CalidadMermaZarandeo, 0))
                    oCarta.CalidadMermaZarandeoBonifica_o_Rebaja = iisNull(.CalidadMermaZarandeoBonifRebaja, 0)
                    oCarta.FueraDeEstandar = IIf(.FueraDeEstandar, "SI", "NO")
                    oCarta.CalidadPuntaSombreada = CDec(iisNull(.CalidadPuntaSombreada, 0))

                    oCarta.LiquidaViaje = IIf(.LiquidaViaje, "SI", "NO")
                    oCarta.CobraAcarreo = IIf(.CobraAcarreo, "SI", "NO")

                    If .IdClienteAuxiliar > 0 Then oCarta.IdClienteAuxiliar = .IdClienteAuxiliar Else oCarta.IdClienteAuxiliar = Nothing
                    If .IdClienteEntregador > 0 Then oCarta.IdClienteEntregador = .IdClienteEntregador Else oCarta.IdClienteEntregador = Nothing
                    If .IdClientePagadorFlete > 0 Then oCarta.IdClientePagadorFlete = .IdClientePagadorFlete Else oCarta.IdClientePagadorFlete = Nothing

                    oCarta.CalidadDescuentoFinal = .CalidadDescuentoFinal
                    oCarta.PathImagen = .PathImagen
                    oCarta.PathImagen2 = .PathImagen2

                    oCarta.Acopio1 = .Acopio1
                    oCarta.Acopio2 = .Acopio2
                    oCarta.Acopio3 = .Acopio3
                    oCarta.Acopio4 = .Acopio4
                    oCarta.Acopio5 = .Acopio5


                    oCarta.ClaveEncriptada = EntidadManager.encryptQueryString(CartaDePorteId)


                    oCarta.SojaSustentableCodCondicion = .SojaSustentableCodCondicion
                    oCarta.SojaSustentableCondicion = .SojaSustentableCondicion
                    oCarta.SojaSustentableNroEstablecimientoDeProduccion = .SojaSustentableNroEstablecimientoDeProduccion




                    oCarta.NumeroCartaEnTextoParaBusqueda = oCarta.NumeroCartaDePorte & " " & oCarta.NumeroSubfijo & "-" & oCarta.SubnumeroVagon
                    oCarta.SubnumeroVagonEnTextoParaBusqueda = oCarta.SubnumeroVagon
                    'If IsNothing(ue) Then
                    '    ue = New UserDatosExtendido
                    '    ue.UserId = New Guid(userid)
                    '    ue.RazonSocial = razonsocial
                    '    ue.CUIT = cuit

                    '    db.UserDatosExtendidos.InsertOnSubmit(ue)
                    'Else
                    '    ue.RazonSocial = razonsocial
                    'End If




                    '                    Log(Entry)
                    '06/01/2014 18:25:32
                    'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=1519792. Error Message:System.NotSupportedException
                    'The query operator 'ElementAtOrDefault' is not supported.
                    '   at System.Data.Linq.SqlClient.QueryConverter.VisitSequenceOperatorCall(MethodCallExpression mc)
                    '   at System.Data.Linq.SqlClient.QueryConverter.VisitMethodCall(MethodCallExpression mc)
                    '   at System.Data.Linq.SqlClient.QueryConverter.VisitInner(Expression node)
                    '   at System.Data.Linq.SqlClient.QueryConverter.ConvertOuter(Expression node)
                    '   at System.Data.Linq.SqlClient.SqlProvider.BuildQuery(Expression query, SqlNodeAnnotations annotations)
                    '   at System.Data.Linq.SqlClient.SqlProvider.System.Data.Linq.Provider.IProvider.Execute(Expression query)
                    '   at System.Data.Linq.DataQuery`1.System.Linq.IQueryProvider.Execute[S](Expression expression)
                    '   at System.Linq.Queryable.ElementAtOrDefault[TSource](IQueryable`1 source, Int32 index)
                    '   at CartaDePorteManager.Save(String SC, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario, Boolean bCopiarDuplicados)
                    '                    System.Data.Linq()
                    '                    _________________()




                    '////////////////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////////////////
                    'si la carta tiene duplicados (y no es un alta, es decir, no está siendo llamada ahora mismo desde 
                    '   el original), pasarle los cambios

                    'Dim duplicados As IQueryable(Of CartasDePorte) = _
                    If myCartaDePorte.Id > 0 And bCopiarDuplicados Then '



                        Dim duplicados = _
                                           (From e In db.CartasDePortes _
                                           Where e.NumeroCartaDePorte = oCarta.NumeroCartaDePorte _
                                           And e.SubnumeroVagon = oCarta.SubnumeroVagon _
                                            And e.IdCartaDePorte <> CartaDePorteId).ToList

                        If myCartaDePorte.Anulada = "SI" Then
                            'si está anulando una copia, y el unico que queda es el original, entonces ponerlo "como no copiado"
                            If duplicados.Count = 1 Then
                                duplicados(0).SubnumeroDeFacturacion = -1
                            End If
                        Else
                            'si no es una anulacion, entonces le paso normalmente a su familia los cambios
                            Try
                                For Each c In duplicados
                                    CopiarCarta(oCarta, c)
                                    'db.CartasDePortes.
                                    db.SubmitChanges()
                                Next

                            Catch ex As Exception

                                ErrHandler.WriteError(ex)

                            End Try

                        End If

                    End If




                    db.SubmitChanges()

                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                    MandarMailDeError("Error al grabar carta con linq - " & ex.ToString)
                End Try






                If .Exporta And False Then 'por ahora, desactivar los movimientos automaticos. El informe tambien revisa la tabla de Cartas
                    CDPStockMovimientoManager.Save(SC, CartaDePorteId, .Titular, .Entregador, .IdArticulo, .NetoFinalIncluyendoMermas, True, .Destino)
                End If



                If .Anulada = "SI" Then
                    'si de la familia solo queda una sin rechazar, ponela como original independiente (o sea, subnumerodefacturacion=-1)
                    Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
                    Dim duplicados = ( _
                                From e In db.CartasDePortes _
                                Where e.NumeroCartaDePorte = .NumeroCartaDePorte _
                                And e.SubnumeroVagon = .SubnumeroVagon _
                                 And e.IdCartaDePorte <> CartaDePorteId _
                                 And e.Anulada <> "SI").AsEnumerable

                    If duplicados.Count = 1 Then
                        duplicados(0).SubnumeroDeFacturacion = -1 'esto es un tema, porque si anulás el original, un duplicado pasa a ser el original, y te queda el link a los dos
                        db.SubmitChanges()
                    End If

                    db = Nothing
                End If


            End With







            'CDPStockMovimientoManager.Save(SC, myCartaDePorte)

            'For Each myCartaDePorteItem As CartaDePorteItem In myCartaDePorte.Detalles
            '    myCartaDePorteItem.IdCartaDePorte = CartaDePorteId
            '    CartaDePorteItemDB.Save(myCartaDePorteItem)
            'Next



            '/////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////

            'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13223
            If bCopiarDuplicados Then
                If EsUnoDeLosClientesExportador(SC, myCartaDePorte) Then

                    CrearleDuplicadaConEl_FacturarA_Indicado(SC, myCartaDePorte)

                End If
            End If


            '/////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////
            'loguear si es intermediario COTOSAICA  'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=12319

            If myCartaDePorte.CuentaOrden1 = 5757 Then

                Try
                    LogPronto(SC, CartaDePorteId, "COTOBUG", NombreUsuario, , , , )
                    MandarMailDeError("COTOBUG POSIBLE " & CartaDePorteId & " " & NombreUsuario & "     idoriginal " & myCartaDePorte.Id)
                Catch ex As Exception
                    MandarMailDeError("ERROR EN COTOBUG")
                End Try
            End If
            '/////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////




            'loguear si la carta está facturada, qué fue lo que cambió. No se puede grabar un historico?????






            Try
                EntidadManager.Tarea(SC, "Log_InsertarRegistro", IIf(myCartaDePorte.Id <= 0, "ALTA", "MODIF"), _
                                          CartaDePorteId, 0, Now, 0, "Tabla : CartaPorte", "", NombreUsuario, _
                                        DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, _
                                        DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, _
                                        DBNull.Value, DBNull.Value, DBNull.Value)
                'GetStoreProcedure(SC, enumSPs.Log_InsertarRegistro, IIf(myCartaDePorte.Id <= 0, "ALTA", "MODIF"), _
                '                          CartaDePorteId, 0, Now, 0, "Tabla : CartaPorte", "", NombreUsuario)

            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try


            'myCartaDePorte.FechaTimeStamp = TraerUltimoTimeStamp(SC, myCartaDePorte.Id)
            myCartaDePorte.FechaTimeStamp = TraerUltimoTimeStamp(SC, CartaDePorteId) 'si está haciendo un duplicado, el id del objeto es -1
            myCartaDePorte.Id = CartaDePorteId




            'myTransactionScope.Complete()
            'ContextUtil.SetComplete()
            Return CartaDePorteId
        Catch ex As Exception
            'ContextUtil.SetAbort()
            ErrHandler.WriteError(ex)
            Debug.Print(ex.ToString)
            Throw New ApplicationException("Error en la grabacion " + ex.ToString, ex)
            'Return -1
        Finally
            'CType(myTransactionScope, IDisposable).Dispose()
        End Try
        Return myCartaDePorte.Id
    End Function


    Shared Sub CopiarCarta(ByVal orig As CartasDePorte, ByRef dest As CartasDePorte)




        Dim sourceProps() As System.Reflection.PropertyInfo = orig.GetType().GetProperties()
        Dim destinationProps() As System.Reflection.PropertyInfo = dest.GetType().GetProperties()

        For Each sourceProp As System.Reflection.PropertyInfo In sourceProps

            Dim column As System.Data.Linq.Mapping.ColumnAttribute = DirectCast(Attribute.GetCustomAttribute(sourceProp, GetType(System.Data.Linq.Mapping.ColumnAttribute)), System.Data.Linq.Mapping.ColumnAttribute)

            'If sourceProp.Name = "NumeroCartaDePorte" Then Continue For
            If sourceProp.Name = "IdFacturaImputada" Then Continue For
            If sourceProp.Name = "IdClienteAFacturarle" Then Continue For
            If sourceProp.Name = "SubnumeroDeFacturacion" Then Continue For
            If sourceProp.Name = "FechaTimeStamp" Then Continue For




            '10474 Desarrollar la posibilidad de anular una duplicación (dando usuario y motivo) sin afectar a las copias restantes.
            If sourceProp.Name = "Anulada" Then Continue For
            If sourceProp.Name = "MotivoAnulacion" Then Continue For
            If sourceProp.Name = "FechaAnulacion" Then Continue For



            ' Replicar todas las modificaciones realizadas en el original inclusive la imagen y exceptuando los 
            '    campos liberados según el punto anterior.
            '- En las duplicaciones deben estar habilitados los campos:
            '. * Tilde de exportacion
            '. * Calidad en pestaña de Descarga
            '. * Observaciones
            If sourceProp.Name = "Exporta" Then Continue For
            If sourceProp.Name = "CalidadDe" Then Continue For
            If sourceProp.Name = "Observaciones" Then Continue For
            If sourceProp.Name = "AgregaItemDeGastosAdministrativos" Then Continue For
            If sourceProp.Name = "IdClienteEntregador" Then Continue For

            If sourceProp.Name = "Titular" Then Continue For
            If sourceProp.Name = "CuentaOrden1" Then Continue For
            If sourceProp.Name = "CuentaOrden2" Then Continue For
            If sourceProp.Name = "Corredor" Then Continue For
            If sourceProp.Name = "Corredor2" Then Continue For
            If sourceProp.Name = "Entregador" Then Continue For
            If sourceProp.Name = "IdClienteAuxiliar" Then Continue For
            If sourceProp.Name = "IdChofer" Then Continue For
            If sourceProp.Name = "IdTransportista" Then Continue For








            If (column IsNot Nothing AndAlso Not column.IsPrimaryKey) Then

                For Each destinationProp As System.Reflection.PropertyInfo In destinationProps


                    If sourceProp.Name = destinationProp.Name And destinationProp.CanWrite Then

                        destinationProp.SetValue(dest, sourceProp.GetValue(orig, Nothing), Nothing)

                        Exit For

                    End If

                Next

            End If

        Next
    End Sub


    <DataObjectMethod(DataObjectMethodType.Delete, True)> _
    Public Shared Function Delete(ByVal SC As String, ByVal myCartaDePorte As CartaDePorte) As Boolean
        Return CartaDePorteDB.Delete(SC, myCartaDePorte.Id)
    End Function


    Private Shared Function TodosRespondidos(ByVal SC As String, ByVal NumeroCartaDePorte As Integer) As Boolean 'Lo que diferencia a los CartasDePorte del mismo origen es el "Subnumero" ("Orden" en el ABM de Pronto)
        Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "CartasDePorte", "TX_PorNumero", NumeroCartaDePorte)
        If ds.Tables(0).Rows.Count > 0 Then
            For Each dr As Data.DataRow In ds.Tables(0).Rows
                If iisNull(dr.Item("ConfirmadoPorWeb"), "NO") = "NO" Then Return False
            Next
        End If
        Return True
    End Function


    Public Shared Function UltimaCDP(ByVal SC As String) As Integer
        Return EntidadManager.ExecDinamico(SC, "SELECT TOP 1 idCartaDePorte from CartasDePorte order by idCartaDePorte desc").Rows(0).Item(0)
    End Function

    Shared Function UsaClientesQueExigenDatosDeDescargaCompletos(ByVal SC As String, ByVal myCartaDePorte As CartaDePorte, Optional ByRef ms As String = "") As Boolean
        Dim titular, destinatario, intermediario, corredor, remitcomercial As Cliente
        titular = ClienteManager.GetItem(SC, myCartaDePorte.Titular)
        destinatario = ClienteManager.GetItem(SC, myCartaDePorte.Entregador)
        intermediario = ClienteManager.GetItem(SC, myCartaDePorte.CuentaOrden1)
        corredor = ClienteManager.GetItem(SC, BuscaIdClientePreciso(EntidadManager.NombreVendedor(SC, myCartaDePorte.Corredor), SC))
        remitcomercial = ClienteManager.GetItem(SC, myCartaDePorte.CuentaOrden2)

        If myCartaDePorte.Titular > 0 AndAlso titular.ExigeDatosCompletosEnCartaDePorteQueLoUse = "SI" Then
            ms += " " & titular.RazonSocial
        End If

        If myCartaDePorte.Entregador > 0 AndAlso destinatario.ExigeDatosCompletosEnCartaDePorteQueLoUse = "SI" Then
            ms += " " & destinatario.RazonSocial
        End If


        If myCartaDePorte.CuentaOrden1 > 0 AndAlso intermediario.ExigeDatosCompletosEnCartaDePorteQueLoUse = "SI" Then
            ms += " " & intermediario.RazonSocial
        End If

        Try
            If Not IsNothing(corredor) AndAlso corredor.ExigeDatosCompletosEnCartaDePorteQueLoUse = "SI" Then
                ms += " " & corredor.RazonSocial
            End If
        Catch ex As Exception
            ErrHandler.WriteError(ex)
        End Try


        If myCartaDePorte.CuentaOrden2 > 0 AndAlso remitcomercial.ExigeDatosCompletosEnCartaDePorteQueLoUse = "SI" Then
            ms += " " & remitcomercial.RazonSocial
        End If



        If ms = "" Then
            Return False
        Else
            Return True
        End If

    End Function

    Public Shared Function IsValid(ByVal SC As String, ByVal myCartaDePorte As CartaDePorte, Optional ByRef ms As String = "", Optional ByRef sWarnings As String = "") As Boolean

        With myCartaDePorte
            'validarUnicidad()

            If iisNull(.SubnumeroVagon, 0) < 0 Then
                Return False
            End If


            'si manotearon la unicidad (numerocdp, vagon) tambien debería loguearse el cambio (lo ideal sería que no pudiesen cambiarlo...)
            'si manotearon la unicidad (numerocdp, vagon) tambien debería loguearse el cambio (lo ideal sería que no pudiesen cambiarlo...)
            'si manotearon la unicidad (numerocdp, vagon) tambien debería loguearse el cambio (lo ideal sería que no pudiesen cambiarlo...)
            'si manotearon la unicidad (numerocdp, vagon) tambien debería loguearse el cambio (lo ideal sería que no pudiesen cambiarlo...)



            'If iisNull(.NumeroCartaDePorte, 0) < 100000000 Or iisNull(.NumeroCartaDePorte, 0) > 9999999999 Then
            '    ms = "El número de CDP debe tener 9 o 10 dígitos"
            '    Return False
            'End If

            'If .NumeroCartaDePorte > 1999999999 Then ' > Int32.MaxValue Then
            '    ms = "El número de CDP debe ser menor que 2.000.000.000"
            '    Return False
            'End If

            If IsNothing(.FechaArribo) Or .FechaArribo = #12:00:00 AM# Then
                ms = "Falta la fecha de arribo"
                Return False
            End If

            If iisNull(.FechaDescarga, #12:00:00 AM#) <> #12:00:00 AM# Then
                If iisNull(.FechaDescarga) < iisNull(.FechaArribo) Then
                    ms = "La fecha de la descarga es anterior a la de arribo"
                    Return False
                End If
            End If




            If False Then
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '            Si se da esta combinación en una CP, poner automáticamente el tilde de exportación.
                'Si se lo sacan (si se graba sin el tilde) mostrar advertencia.
                'BLD como Corredor 
                'CCI (Centro de Comercialización de Insumos) como Titular, RteComercial o Intermediario
                'Entregador que no sea Williams
                Dim idBLD = 43 'BuscaIdVendedorClientePrecisoConCUIT("30-70359905-9", SC)  'buscar por cuit
                Dim idCCI = BuscaIdClientePrecisoConCUIT("30-70914230-1", SC)
                Dim idWilliams = BuscaIdClientePrecisoConCUIT("30-70738607-6", SC)
                If .Corredor = idBLD And (.Titular = idCCI Or .CuentaOrden1 = idCCI Or .CuentaOrden2 = idCCI) And .IdClienteEntregador <> idWilliams Then
                    If Not .Exporta And Not .ObviarAdvertencias Then
                        sWarnings &= "Con CCI de cliente y BLD de corredor, se recomienda poner la carta como exportación" & vbCrLf
                        'Return False
                    End If
                End If
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
            End If


            If .NetoFinalIncluyendoMermas > 0 Then
                If .FechaDescarga = #12:00:00 AM# Then
                    ms = "Se necesita la fecha de la descarga (porque se ingresó el peso final de la descarga)"
                    Return False
                End If


            End If



            If False Then
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11839
                'Cada vez que se graba la carta de porte, si el Entregador no es Williams ni está vacío (es decir,
                '    que pusieron explicitamente otro Entregador), entonces no dejar grabar hasta que no pongan el tilde de Exportación

                If iisNull(.IdClienteEntregador, 0) > 0 And Not iisNull(NombreCliente(SC, iisNull(.IdClienteEntregador, 0)), "").ToUpper.Contains("WILLIAMS") And Not .Exporta Then
                    ms = "Una carta porte con entregador debe tener el tilde de exportación"
                    Return False
                End If

            End If




            If False Then
                If iisNull(.SubnumeroDeFacturacion, 0) > 0 Then
                    If .IdClienteAFacturarle <= 0 Then
                        ms = "Las cartas duplicadas exigen el cliente a facturarsele"
                        Return False
                    End If

                    If iisNull(.SubnumeroDeFacturacion, 0) >= 1 Then
                        'VerificarQueElOriginalTieneExplicitadoElClienteFacturado
                        Try
                            If CartaDePorteManager.GetItemPorNumero(SC, .NumeroCartaDePorte, .SubnumeroVagon, .SubnumeroDeFacturacion).IdClienteAFacturarle <= 0 Then
                                ms = "El original de este duplicado no tiene marcado el cliente al que se factura"
                                Return False
                            End If
                        Catch ex As Exception
                            ErrHandler.WriteError(ex) 'probablemente se queja de que hay copias de subfacturacion. Justo en este caso, no importa
                        End Try
                    End If
                End If
            End If



            If .NobleACamara And .NobleConforme Then
                ms = "No pueden estar tildados Conforme y A camara en Noble"
                Return False
            End If

            If .Titular > 0 Then
                If InStr(EntidadManager.NombreCliente(SC, .Titular).ToUpper, "SYNGENTA") > 0 And .EnumSyngentaDivision = "" Then
                    If Not (.bSeLeFactura_a_SyngentaDivisionAgro Xor .bSeLeFactura_a_SyngentaDivisionAgro) Then
                        ms = "Debe elegir a cuál de las divisiones de Syngenta se le facturará (a división Agro o a división Seeds)"
                        Return False
                    End If
                End If



                If (InStr(EntidadManager.NombreCliente(SC, .Titular).ToUpper, "A.C.A") > 0 And .Acopio1 <= 0) Then
                    ms = "Falta elegir a qué acopio de A.C.A corresponde el titular"
                    Return False
                End If

                If (.CuentaOrden2 > 0) Then
                    If (InStr(EntidadManager.NombreCliente(SC, .CuentaOrden2).ToUpper, "A.C.A") > 0 And .Acopio3 <= 0) Then
                        'rcomercial
                        ms = "Falta elegir a qué acopio de A.C.A corresponde el remitente comercial"
                        Return False
                    End If
                End If

                If (.CuentaOrden1 > 0) Then
                    If (InStr(EntidadManager.NombreCliente(SC, .CuentaOrden1).ToUpper, "A.C.A") > 0 And .Acopio2 <= 0) Then
                        'intermediario
                        ms = "Falta elegir a qué acopio de A.C.A corresponde el intermediario"
                        Return False
                    End If
                End If
                'Or InStr(If(EntidadManager.NombreCliente(SC, .CuentaOrden1), "").ToUpper, "A.C.A") > 0 _
                'Or InStr(If(EntidadManager.NombreCliente(SC, .CuentaOrden2), "").ToUpper, "A.C.A") > 0) _
                'And .EnumSyngentaDivision = "" Then




                'cuanto tarda en leer el cliente?
                Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


                Dim cli As String() = (From i In db.linqClientes _
                                    Where i.HabilitadoParaCartaPorte = "NO" _
                                    And (i.IdCliente = .Titular Or i.IdCliente = .Entregador Or i.IdCliente = .CuentaOrden1 Or i.IdCliente = .CuentaOrden2) _
                                    Select i.RazonSocial).ToArray


                If cli.Count > 0 Then
                    ms = "El cliente no está habilitado para cartas de porte " & Join(cli, ",")
                    Return False
                End If

            End If






            If .PuntoVenta < 1 Or .PuntoVenta > 4 Then
                ms = "El punto de venta debe estar entre 1 y 4"
                Return False
            End If



            Dim sClientesExigentes As String
            If .NetoFinalIncluyendoMermas > 0 And UsaClientesQueExigenDatosDeDescargaCompletos(SC, myCartaDePorte, sClientesExigentes) Then
                'Está en descarga y usa clientes exigentes: se debe hacer validacion completa


                'Consulta 7562 http://bdlconsultores2.dynalias.com/Consultas/Admin/verConsultas1.php?recordid=7562



                Dim K = " Algunos clientes usados en esta carta exigen completar " & _
                     " todos los campos de una carta en Descarga  (" & sClientesExigentes & ") "

                'verificar que esta completa


                If .Titular = 0 Or .Entregador = 0 Or .CuentaOrden1 = 0 Or .Corredor = 0 Then


                    ms = "Hay que completar Titular, Destinatario, Intermediario y Corredor. " & K
                    Return False

                End If


                If .Destino = 0 Or .Procedencia = 0 Or .IdChofer = 0 Or .IdTransportista = 0 Then

                    ms = "Hace falta completar Procedencia, Destino, Tranportista y Chofer. " & K
                    Return False

                End If



                If iisNull(.NetoFinalIncluyendoMermas, 0) <= 0 Or _
                    iisNull(.TaraFinal, 0) <= 0 Or _
                    iisNull(.BrutoFinal, 0) <= 0 Or _
                    iisNull(.NetoPto, 0) <= 0 Or _
                    iisNull(.NetoFinalSinMermas, 0) <= 0 Then

                    ms = "Hay pesajes sin completar. " & K
                    Return False
                End If



                If iisNull(.CEE, 0) <= 0 Or _
                    iisNull(.CTG, 0) <= 0 Or _
                    IsNothing(.FechaDeCarga) Or _
                    IsNothing(.FechaVencimiento) Or _
                    IsNothing(.FechaDescarga) Or _
                    .Contrato = "" Or _
                    .Patente = "" Or _
                    .NRecibo = 0 Or _
                    .CalidadDe = 0 Then

                    ms = "Hace falta CEE, CTG, Fechas de carga/vencimiento/descarga,Contrato, Patente, Recibo y Calidad. " & K
                    Return False

                End If


            End If



        End With

        '"La lista de items está vacía"

        'Dim eliminados As Integer
        'verifico el detalle
        'If myCartaDePorte.Detalles IsNot Nothing Then
        '    For Each det As CartaDePorteItem In myCartaDePorte.Detalles
        '        If det.IdArticulo = 0 Then 'verifico que no pase un renglon en blanco
        '            det.Eliminado = True
        '        End If
        '        If det.Eliminado Then eliminados = eliminados + 1
        '    Next

        '    If myCartaDePorte.Detalles.Count = eliminados Or myCartaDePorte.Detalles.Count = 0 Then
        '        'Return False
        '    End If
        'End If

        Return True
    End Function




    Public Shared Function validarUnicidad(ByVal SC As String, ByVal txtNumeroCDP As String, ByVal txtSubNumeroVagon As String, ByVal IdEntity As Integer, ByVal actualCartaDePorte As CartaDePorte) As Boolean

        If actualCartaDePorte Is Nothing Then Return False

        Dim BusquedaCartaDePorte = CartaDePorteManager.GetItemPorNumero(SC, Val(txtNumeroCDP), Val(txtSubNumeroVagon), -1)




        If actualCartaDePorte.SubnumeroDeFacturacion > 0 Then Return True 'los duplicados de facturacion no los valido

        If BusquedaCartaDePorte.Id <> -1 Then
            'encontró algo
            If IdEntity = -1 Then
                'nuevo
                Return True
            Else
                'edicion
                If IdEntity <> BusquedaCartaDePorte.Id Then
                    'encontro uno que no es el que está editando, con la misma unicidad
                    Return True
                Else
                    'se encontró a sí mismo
                    Return False

                End If
            End If
        Else
            'no encontró nada, está limpio
            Return False
        End If
    End Function

    Public Shared Function Anular(ByVal sc As String, ByVal myCartaDePorte As CartaDePorte, ByVal IdUsuario As Integer, ByVal NombreUsuario As String) As Integer
        With myCartaDePorte

            'esto tiene que estar en el manager, dios!
            .FechaAnulacion = Now
            '.UsuarioAnulacion = cmbUsuarioAnulo.SelectedValue
            '.Cumplido = "AN"

            .Anulada = "SI"

            'For Each i As CartaDePorteItem In .Detalles
            '    With i
            '        .Cumplido = "AN"
            '        '.EnviarEmail = 1
            '    End With
            'Next

            'revisar queda una en la familia, y ponerla como original
            Return CartaDePorteManager.Save(sc, myCartaDePorte, IdUsuario, NombreUsuario)




            '                tira un error de duplicacion al anular
            '                _
            'URL:	/ProntoWeb/CartaDePorte.aspx?Id=1090650
            'User:           scabrera()
            '                Exception(Type) : System.ApplicationException()
            'Message:	Error en la grabacion Error en la grabacion Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'. The statement has been terminated.
            'Stack Trace:	 at CartaDePorteManager.Save(String SC, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario)
            'at CartaDePorteManager.Anular(String sc, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario)
            'at CartadeporteABM.btnAnularOk_Click(Object sender, EventArgs e)
            'at System.Web.UI.WebControls.Button.OnClick(EventArgs e)
            'at System.Web.UI.WebControls.Button.RaisePostBackEvent(String eventArgument)
            'at System.Web.UI.WebControls.Button.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument)
            'at System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument)
            'at System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData)
            'at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
        End With
    End Function


    Public Shared Function DesAnular(ByVal sc As String, ByVal myCartaDePorte As CartaDePorte, ByVal IdUsuario As Integer, ByVal NombreUsuario As String) As Integer
        With myCartaDePorte

            'esto tiene que estar en el manager, dios!
            .FechaAnulacion = Now
            '.UsuarioAnulacion = cmbUsuarioAnulo.SelectedValue
            '.Cumplido = "AN"

            .Anulada = "NO"

            'For Each i As CartaDePorteItem In .Detalles
            '    With i
            '        .Cumplido = "AN"
            '        '.EnviarEmail = 1
            '    End With
            'Next
            Return CartaDePorteManager.Save(sc, myCartaDePorte, IdUsuario, NombreUsuario)
        End With
    End Function


    Public Shared Function GetEstado(ByVal SC As String, ByVal myCartaDePorte As CartaDePorte) As enumCDPestado
        If myCartaDePorte.NetoFinalIncluyendoMermas > 0 Then
            Return enumCDPestado.DescargasSinFacturar
        Else
            Return enumCDPestado.Posicion
        End If
    End Function


    Public Shared Function GetEstadoString(estado As enumCDPestado) As String

        Select Case estado
            Case EntidadManager.enumCDPestado.TodasMenosLasRechazadas
                Return "Todas (menos las rechazadas) "
            Case EntidadManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones
                Return "Descargas de Hoy + Todas las Posiciones "
            Case EntidadManager.enumCDPestado.Posicion
                Return "Posición "
            Case EntidadManager.enumCDPestado.DescargasMasFacturadas
                Return "Descargas "
            Case EntidadManager.enumCDPestado.Rechazadas
                Return "Rechazadas "
            Case EntidadManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha
                Return "Descargas de Hoy + Todas las Posiciones "
            Case Else
                Return ""
        End Select

    End Function



    Public Shared Function UsaAcondicionadoras(ByVal SC As String, ByVal IdFactura As Integer) As Boolean
        'la factura es a corredor?
        '-igual tenes que ver en el encabezado si el remitente comercial o el intermediario
        'son acondicionadoras para mostrarlo
        Dim f = FacturaManager.GetItem(SC, IdFactura)
        If BuscaIdVendedorPreciso(NombreCliente(SC, f.IdCliente), SC) <> -1 Then Return True

        'If IdFactura es de corredor             Return True
        Using db = New LinqCartasPorteDataContext(Encriptar(SC))

            'If ClienteManager.GetItem(SC, f.IdCliente) Then

            'Dim f = (From i In db.linqFacturas Where i.IdFactura = IdFactura).SingleOrDefault
            'Dim c = (From i In db.linqClientes Where i.IdCliente = f.IdCliente).SingleOrDefault
            'c.corred()




        End Using

    End Function

    Public Shared Function InformeAdjuntoDeFacturacionWilliamsEPSON(ByVal SC As String, ByVal IdFactura As Integer, ArchivoExcelDestino As String, ByRef ReportViewer2 As ReportViewer) As String


        ErrHandler.WriteError("InformeAdjuntoDeFacturacionWilliamsEPSON Idfactura=" & IdFactura)


        If CartaDePorteManager.UsaAcondicionadoras(SC, IdFactura) Then
            Return CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsAcondicionadorasEPSON(SC, IdFactura, ReportViewer2, "")
        End If


        Dim dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_PorIdFactura", IdFactura)

        If ArchivoExcelDestino = "" Then
            ArchivoExcelDestino = IO.Path.GetTempPath & "AdjuntoDeFactura " & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        End If

        'Dim vFileName As String = "c:\archivo.txt"
        ' FileOpen(1, ArchivoExcelDestino, OpenMode.Output)




        'Using ReportViewer2 As New ReportViewer
        With ReportViewer2
            .ProcessingMode = ProcessingMode.Local

            .Visible = False

            With .LocalReport

                .ReportPath = "ProntoWeb\Informes\Adjuntos de Facturacion (a impresora de matriz de puntos).rdl"
                .EnableHyperlinks = True
                .DataSources.Clear()

                .EnableExternalImages = True

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.

            End With

            .DocumentMapCollapsed = True

            '.LocalReport.Refresh()
            '.DataBind()




            'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType, encoding, extension As String

            Dim format = "Excel"

            Dim bytes As Byte() = ReportViewer2.LocalReport.Render( _
                       format, Nothing, mimeType, encoding, _
                         extension, _
                        streamids, warnings)

            Dim fs = New IO.FileStream(ArchivoExcelDestino, IO.FileMode.Create)
            fs.Write(bytes, 0, bytes.Length)
            fs.Close()





            'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es la mitad de la normal)
            'Notas de Entrega: 160 ancho x 36 alt
            'Facturas y Adjuntos: 160 ancho x 78 alto

            ArchivoExcelDestino = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextWilliamsAdjunto(ArchivoExcelDestino)

        End With
        'End Using


        Return ArchivoExcelDestino

    End Function


    Public Shared Function InformeAdjuntoDeFacturacionWilliamsEPSON_A4(ByVal SC As String, ByVal IdFactura As Integer, ArchivoExcelDestino As String, ByRef ReportViewer2 As ReportViewer) As String

        ErrHandler.WriteError("InformeAdjuntoDeFacturacionWilliamsEPSON_A4 Idfactura=" & IdFactura)

        If CartaDePorteManager.UsaAcondicionadoras(SC, IdFactura) And False Then
            Return CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsAcondicionadorasEPSON_A4(SC, IdFactura, ReportViewer2, "")
        End If


        Dim dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_PorIdFactura", IdFactura)

        If ArchivoExcelDestino = "" Then
            ArchivoExcelDestino = IO.Path.GetTempPath & "AdjuntoDeFactura " & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        End If

        'Dim vFileName As String = "c:\archivo.txt"
        ' FileOpen(1, ArchivoExcelDestino, OpenMode.Output)




        'Using ReportViewer2 As New ReportViewer
        With ReportViewer2
            .ProcessingMode = ProcessingMode.Local

            .Visible = False

            With .LocalReport




                .ReportPath = "ProntoWeb\Informes\Adjuntos de Facturacion (a impresora de matriz de puntos).rdl"
                .EnableHyperlinks = True
                .DataSources.Clear()

                .EnableExternalImages = True

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.

            End With

            .DocumentMapCollapsed = True

            '.LocalReport.Refresh()
            '.DataBind()




            'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType, encoding, extension As String

            Dim format = "Excel"

            Dim bytes As Byte() = ReportViewer2.LocalReport.Render( _
                       format, Nothing, mimeType, encoding, _
                         extension, _
                        streamids, warnings)

            Dim fs = New IO.FileStream(ArchivoExcelDestino, IO.FileMode.Create)
            fs.Write(bytes, 0, bytes.Length)
            fs.Close()





            'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es la mitad de la normal)
            'Notas de Entrega: 160 ancho x 36 alt
            'Facturas y Adjuntos: 160 ancho x 78 alto

            ArchivoExcelDestino = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextWilliamsAdjunto_A4(ArchivoExcelDestino)


        End With
        'End Using


        Return ArchivoExcelDestino

    End Function


    Public Shared Function InformeAdjuntoDeFacturacionWilliamsAcondicionadorasEPSON(ByVal SC As String, ByVal IdFactura As Integer, ByRef ReportViewer2 As ReportViewer, ByRef ArchivoExcelDestino As String) As String

        ErrHandler.WriteError("InformeAdjuntoDeFacturacionWilliamsAcondicionadorasEPSON Idfactura=" & IdFactura)


        Dim dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_PorIdFactura", IdFactura)

        If ArchivoExcelDestino = "" Then
            ArchivoExcelDestino = IO.Path.GetTempPath & "AdjuntoDeFactura " & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        End If

        'Dim vFileName As String = "c:\archivo.txt"
        ' FileOpen(1, ArchivoExcelDestino, OpenMode.Output)

        dt.Columns.Add("HayAcondicionadora", GetType(String))
        For Each r In dt.Rows
            r("HayAcondicionadora") = "NO"


            If iisNull(r("Acond1"), "NO") = "SI" Or iisNull(r("Acond2"), "NO") = "SI" Or iisNull(r("Acond3"), "NO") = "SI" Or iisNull(r("Acond4"), "NO") = "SI" Then
                r("HayAcondicionadora") = "SI"
            End If
        Next



        '        Using ReportViewer2 As New ReportViewer
        With ReportViewer2
            .ProcessingMode = ProcessingMode.Local

            .Visible = False

            With .LocalReport

                .ReportPath = "ProntoWeb\Informes\Adjuntos de Facturacion Acondicionadoras (a impresora de matriz de puntos).rdl"
                .EnableHyperlinks = True
                .DataSources.Clear()

                .EnableExternalImages = True

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.

            End With

            .DocumentMapCollapsed = True

            '.LocalReport.Refresh()
            '.DataBind()




            'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType, encoding, extension As String

            Dim format = "Excel"

            Dim bytes As Byte() = ReportViewer2.LocalReport.Render( _
                       format, Nothing, mimeType, encoding, _
                         extension, _
                        streamids, warnings)

            Dim fs = New IO.FileStream(ArchivoExcelDestino, IO.FileMode.Create)
            fs.Write(bytes, 0, bytes.Length)
            fs.Close()





            'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es la mitad de la normal)
            'Notas de Entrega: 160 ancho x 36 alt
            'Facturas y Adjuntos: 160 ancho x 78 alto

            ArchivoExcelDestino = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextWilliamsAdjunto(ArchivoExcelDestino)

        End With
        ' End Using


        Return ArchivoExcelDestino

    End Function


    Public Shared Function InformeAdjuntoDeFacturacionWilliamsAcondicionadorasEPSON_A4(ByVal SC As String, ByVal IdFactura As Integer, ByRef ReportViewer2 As ReportViewer, ByRef ArchivoExcelDestino As String) As String


        ErrHandler.WriteError("InformeAdjuntoDeFacturacionWilliamsAcondicionadorasEPSON_A4 Idfactura=" & IdFactura)

        Dim dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_PorIdFactura", IdFactura)

        If ArchivoExcelDestino = "" Then
            ArchivoExcelDestino = IO.Path.GetTempPath & "AdjuntoDeFactura " & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        End If

        'Dim vFileName As String = "c:\archivo.txt"
        ' FileOpen(1, ArchivoExcelDestino, OpenMode.Output)

        dt.Columns.Add("HayAcondicionadora", GetType(String))
        For Each r In dt.Rows
            r("HayAcondicionadora") = "NO"



            If iisNull(r("Acond1"), "NO") = "SI" Or iisNull(r("Acond2"), "NO") = "SI" Or iisNull(r("Acond3"), "NO") = "SI" Or iisNull(r("Acond4"), "NO") = "SI" Then
                r("HayAcondicionadora") = "SI"
            End If
        Next



        '  Using ReportViewer2 As New ReportViewer
        With ReportViewer2
            .ProcessingMode = ProcessingMode.Local

            .Visible = False

            With .LocalReport

                .ReportPath = "ProntoWeb\Informes\Adjuntos de Facturacion Acondicionadoras (a impresora de matriz de puntos).rdl"
                .EnableHyperlinks = True
                .DataSources.Clear()

                .EnableExternalImages = True

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.

            End With

            .DocumentMapCollapsed = True

            '.LocalReport.Refresh()
            '.DataBind()




            'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType, encoding, extension As String

            Dim format = "Excel"

            Dim bytes As Byte() = ReportViewer2.LocalReport.Render( _
                       format, Nothing, mimeType, encoding, _
                         extension, _
                        streamids, warnings)

            Dim fs = New IO.FileStream(ArchivoExcelDestino, IO.FileMode.Create)
            fs.Write(bytes, 0, bytes.Length)
            fs.Close()





            'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es la mitad de la normal)
            'Notas de Entrega: 160 ancho x 36 alt
            'Facturas y Adjuntos: 160 ancho x 78 alto

            If True Then

                Threading.Thread.Sleep(5000)
                For n = 1 To 2
                    ArchivoExcelDestino = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextWilliamsAdjunto_A4(ArchivoExcelDestino)
                Next

            End If




        End With
        '  End Using


        Return ArchivoExcelDestino

    End Function



    Public Shared Function InformeAdjuntoDeFacturacionWilliamsExcel(ByVal SC As String, ByVal IdFactura As Integer, ByRef ArchivoExcelDestino As String, ByRef ReportViewer2 As ReportViewer) As String

        ErrHandler.WriteError("InformeAdjuntoDeFacturacionWilliamsExcel Idfactura=" & IdFactura)


        Dim dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_PorIdFactura", IdFactura)

        If ArchivoExcelDestino = "" Then
            ArchivoExcelDestino = IO.Path.GetTempPath & "AdjuntoDeFactura " & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        End If

        'Dim vFileName As String = "c:\archivo.txt"
        ' FileOpen(1, ArchivoExcelDestino, OpenMode.Output)




        'Using ReportViewer2 As New ReportViewer
        With ReportViewer2
            .ProcessingMode = ProcessingMode.Local

            .Visible = False

            With .LocalReport

                .ReportPath = "ProntoWeb\Informes\Adjuntos de Facturacion para exportar a Excel.rdl"
                .EnableHyperlinks = True
                .DataSources.Clear()

                .EnableExternalImages = True

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.

            End With

            .DocumentMapCollapsed = True

            '.LocalReport.Refresh()
            '.DataBind()

            'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType, encoding, extension As String

            Dim format = "Excel"

            Dim bytes As Byte() = ReportViewer2.LocalReport.Render( _
                       format, Nothing, mimeType, encoding, _
                         extension, _
                        streamids, warnings)

            Dim fs = New IO.FileStream(ArchivoExcelDestino, IO.FileMode.Create)
            fs.Write(bytes, 0, bytes.Length)
            fs.Close()





            'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es la mitad de la normal)
            'Notas de Entrega: 160 ancho x 36 alt
            'Facturas y Adjuntos: 160 ancho x 78 alto

            'ArchivoExcelDestino = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextWilliamsAdjunto(ArchivoExcelDestino)

        End With
        '  End Using


        Return ArchivoExcelDestino

    End Function



    Shared Sub ImputoElEmbarque(ByVal idMov As Integer, ByVal idfactura As Integer, ByVal SC As String, ByVal nombreUsuario As String)



        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        'Dim embarques = From i In db.CartasPorteMovimientos _
        '                Where i.Tipo = 4 _
        '                And i.FechaIngreso >= FechaDesde And i.FechaIngreso <= FechaHasta _
        '                And i.IdFacturaImputada <= 0


        'METODO 1
        'oCDP.IdFacturaImputada = idfactura
        'CartaDePorteManager.Save(HFSC.Value, oCDP, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))

        'METODO 2



        Dim dt = EntidadManager.ExecDinamico(SC, "SELECT IdFacturaImputada from CartasPorteMovimientos WHERE IdCDPMovimiento=" & idMov)
        If iisNull(dt(0)("IdFacturaimputada"), 0) > 0 Then
            Err.Raise(6464, , "Ya tiene una factura imputada")
        End If

        EntidadManager.ExecDinamico(SC, "UPDATE CartasPorteMovimientos SET IdFacturaImputada=" & idfactura & "  WHERE IdCDPMovimiento=" & idMov)

        EntidadManager.LogPronto(SC, idfactura, "Imputacion de IdCPorteMovimiento " & idMov & " IdFacturaImputada " & idfactura, nombreUsuario)


    End Sub

    Shared Sub ImputoLaCDP(ByVal oCDP As Pronto.ERP.BO.CartaDePorte, ByVal idfactura As Integer, ByVal SC As String, ByVal nombreUsuario As String)

        'METODO 1
        'oCDP.IdFacturaImputada = idfactura
        'CartaDePorteManager.Save(HFSC.Value, oCDP, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))

        'METODO 2

        Try
            'verificar que no tiene nada imputado
            Dim dt = EntidadManager.ExecDinamico(SC, "SELECT IdFacturaImputada from CartasDePorte WHERE IdCartaDePorte=" & oCDP.Id)
            If iisNull(dt(0)("IdFacturaimputada"), 0) > 0 Then
                Err.Raise(6464, , "Ya tiene una factura imputada")
            End If

            EntidadManager.ExecDinamico(SC, "UPDATE CartasDePorte SET IdFacturaImputada=" & idfactura & "  WHERE IdCartaDePorte=" & oCDP.Id)

            'actualizar el item de la factura



            EntidadManager.LogPronto(SC, idfactura, "Imputacion de IdCartaPorte" & oCDP.Id & "CDP:" & oCDP.NumeroCartaDePorte & " " & oCDP.SubnumeroVagon & "  IdFacturaImputada " & idfactura, nombreUsuario)

        Catch ex As Exception
            'ErrHandler.WriteError("Ya tiene una factura imputada")
            ErrHandler.WriteError("Explota la imputacion")
            Throw
        End Try


    End Sub


    Shared Function EsteTitularSeleFacturaAlCorredorPorSeparadoId(ByVal idCDP As Long, ByVal SC As String) As Long

        Try

            If idCDP < 1 Then Return 0

            'Dim oCDP As Pronto.ERP.BO.CartaDePorte = CartaDePorteManager.GetItem(SC, idCDP)

            Dim drCDP As DataRow = EntidadManager.ExecDinamico(SC, "SELECT Vendedor as Titular,Corredor FROM CartasDePorte WHERE IdCartaDePorte=" & idCDP).Rows(0)

            Dim IdClienteEquivalenteAlCorredor = BuscaIdClientePreciso(EntidadManager.NombreVendedor(SC, drCDP("Corredor")), SC)
            If IdClienteEquivalenteAlCorredor < 1 Then Return 0


            'Dim l = ClienteManager.GetItem(SC, IdClienteEquivalenteAlCorredor).ExpresionRegularNoAgruparFacturasConEstosVendedores
            Dim l As String = iisNull(EntidadManager.ExecDinamico(SC, "SELECT ExpresionRegularNoAgruparFacturasConEstosVendedores FROM Clientes WHERE IdCliente=" & IdClienteEquivalenteAlCorredor).Rows(0).Item(0), "")


            Dim a() As String = Split(l, "|")

            Dim titular As String = EntidadManager.GetItem(SC, "Clientes", drCDP("Titular")).Item("RazonSocial")
            For Each s In a
                If s = "" Then Continue For
                If (InStr(titular.ToUpper, Trim(s).ToUpper) > 0) Then
                    Return drCDP("Titular")
                    'Return oCDP.Titular
                End If
            Next

        Catch ex As Exception
            ErrHandler.WriteError(ex.ToString)
        End Try

        Return 0
    End Function

    Public Shared Function IdClienteEquivalenteDelIdVendedor(ByVal IdVendedor As Long, ByVal SC As String) As Long
        Dim vendedornombre As String = NombreVendedor(SC, IdVendedor)

        Dim idcliente As String = BuscaIdClientePreciso(vendedornombre, SC)

        Return idcliente
    End Function


    Shared Function EsteClienteSeleFacturaAlCorredorPorSeparadoId(ByVal idCliente As Long, ByVal idCorredor As Long, ByVal SC As String) As Long

        Try


            Dim idClienteEquivalente = IdClienteEquivalenteDelIdVendedor(idCorredor, SC)

            Dim l As String = iisNull(EntidadManager.ExecDinamico(SC, "SELECT ExpresionRegularNoAgruparFacturasConEstosVendedores FROM Clientes WHERE IdCliente=" & idClienteEquivalente).Rows(0).Item(0), "")

            Dim a() As String = Split(l, "|")

            Dim cliente As String = NombreCliente(SC, idCliente)

            For Each s In a
                If Trim(s).ToUpper = "" Then Continue For
                If (InStr(cliente.ToUpper, Trim(s).ToUpper) > 0) Then
                    Return idCliente 'oCDP.Corredor
                End If
            Next

        Catch ex As Exception
            ErrHandler.WriteError(ex.ToString)
        End Try

        Return 0

    End Function



    Shared Function EsteCorredorSeleFacturaAlClientePorSeparadoId(ByVal idCliente As Long, ByVal idCorredor As Long, ByVal SC As String) As Long

        Try

            '        If idCDP < 1 Then Return 0

            'Dim oCDP As Pronto.ERP.BO.CartaDePorte = CartaDePorteManager.GetItem(HFSC.Value, idCDP)
            'Dim l = ClienteManager.GetItem(HFSC.Value, oCDP.Titular).ExpresionRegularNoAgruparFacturasConEstosVendedores


            'Dim drCDP As DataRow = EntidadManager.ExecDinamico(SC, "SELECT Vendedor as Titular,Corredor FROM CartasDePorte WHERE IdCartaDePorte=" & idCDP).Rows(0)


            If False Then
                'no se le separará al corredor. Ahora lo que haremos es asignarsela como si 
                'fuese el cliente del encabezado, así que esto no va mas, y se 
                'usa la funcion LogicaFacturacion.ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor()

                Dim bSeparaSiempre As String = iisNull(EntidadManager.ExecDinamico(SC, "SELECT SeLeDerivaSuFacturaAlCorredorDeLaCarta " & _
                                                                      " FROM Clientes WHERE IdCliente=" & idCliente).Rows(0).Item(0), "")

                If bSeparaSiempre = "SI" Then Return IdClienteEquivalenteDelIdVendedor(idCorredor, SC)
            End If



            Dim l As String = iisNull(EntidadManager.ExecDinamico(SC, "SELECT ExpresionRegularNoAgruparFacturasConEstosVendedores  " & _
                                                                  " FROM Clientes WHERE IdCliente=" & idCliente).Rows(0).Item(0), "")


            Dim a() As String = Split(l, "|")

            'Dim corredor As String = EntidadManager.GetItem(SC, "Vendedores", oCDP.Corredor).Item("Nombre")

            Dim corredor As String = EntidadManager.GetItem(SC, "Vendedores", idCorredor).Item("Nombre")

            For Each s In a
                If Trim(s).ToUpper = "" Then Continue For
                If (InStr(corredor.ToUpper, Trim(s).ToUpper) > 0) Then
                    Return IdClienteEquivalenteDelIdVendedor(idCorredor, SC) 'oCDP.Corredor
                End If
            Next

        Catch ex As Exception
            If idCorredor = -1 Then ErrHandler.WriteError("Sin Corredor")
            ErrHandler.WriteError(" EsteCorredorSeleFacturaAlClientePorSeparadoId(). " & ex.ToString & "Quizas es un buque (sin corredor). ")
        End Try

        Return 0
    End Function













    'Shared Function EsteCorredorSeleFacturaAlTitularPorSeparado(ByVal oCDP As Pronto.ERP.BO.CartaDePorte, ByVal SC As String) As Boolean
    '    Dim l = ClienteManager.GetItem(SC, oCDP.Titular).ExpresionRegularNoAgruparFacturasConEstosVendedores
    '    Dim a() As String = Split(l, "|")

    '    For Each s In a
    '        If s = "" Then Continue For
    '        Dim corredor As String = EntidadManager.GetItem(SC, "Vendedores", oCDP.Corredor).Item("Nombre")
    '        If (InStr(corredor, s) > 0) Then Return True
    '    Next

    '    Return False

    'End Function


    Public Shared Function ActualizarPrecioFacturado(ByVal SC As String, ByVal idCDP As Long, ByVal tarifa As Double)
        Return EntidadManager.TablaUpdate(SC, "CartasDePorte", "idCartaDePorte", idCDP, "TarifaFacturada", DecimalToString(tarifa))
    End Function



    Public Class CartaPorteChica
        Public IdCartaPorte
        Public NumeroCartaPorte
        Public SubNumeroVagon
        Public SubNumeroFacturacion
    End Class

    Shared Function FamiliaDeDuplicadosDeCartasPorte(ByVal SC As String, ByVal oCP As CartaDePorte) As IQueryable(Of CartasDePorte)
        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        'http://stackoverflow.com/questions/534690/linq-to-sql-return-anonymous-type

        Dim duplicados As IQueryable(Of CartasDePorte) = _
                            From e In db.CartasDePortes _
                            Where e.NumeroCartaDePorte = oCP.NumeroCartaDePorte _
                            And e.SubnumeroVagon = oCP.SubnumeroVagon

        Return duplicados

    End Function

    Shared Function ListaDeLinks(ByVal oListaCartasPorte As IQueryable(Of CartasDePorte), ByVal DeEste As Long) As String

        If oListaCartasPorte.Count <= 1 Then Return ""

        ListaDeLinks = "<strong><strong><strong> <span style=""width: 210px; font-weight:bold; font-size:  20px;""> /" & IIf(DeEste <= 0, "ORIGINAL", DeEste) & "</span> </strong></strong></strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ir al "

        For Each s In oListaCartasPorte
            Dim slabel = IIf(iisNull(s.SubnumeroDeFacturacion, 0) <= 0, "ORIGINAL", iisNull(s.SubnumeroDeFacturacion, 0))

            If DeEste = s.SubnumeroDeFacturacion Then
                'ListaDeLinks &= "<strong><strong>" & slabel & "</strong></strong> "
            Else
                ListaDeLinks &= " | <a href=""CartaDePorte.aspx?Id=" & s.IdCartaDePorte & """ target=""_blank"">" & slabel & "</a> "
            End If

        Next

    End Function










    Public Shared Function EnviarEmailDeAdjuntosDeWilliams(ByVal sc As String, ByVal idfactura As Long, ByVal patharchivoadjunto As String, Optional ByVal email As String = "", Optional ByVal CCO As String = "")
        '(ByVal Para As String, ByVal Asunto As String, ByVal Cuerpo As String, ByVal De As String, ByVal SmtpServer As String, ByVal SmtpUser As String, ByVal SmtpPass As String, Optional ByVal sFileNameAdjunto As String = "", Optional ByVal SmtpPort As Long = 587, Optional ByVal EnableSSL As Integer = 1, Optional ByVal CCO As String = "", Optional ByVal img As String = "", Optional ByVal FriendlyName As String = "") As Boolean


        ErrHandler.WriteError("EnviarEmailDeAdjuntosDeWilliams Idfactura=" & idfactura)



        Dim myFactura = FacturaManager.GetItem(sc, idfactura, True) 'va a editar ese ID

        If email = "" Then email = ClienteManager.GetItem(sc, myFactura.IdCliente).Email ' MailDestino ' txtDireccionMailAdjuntoWilliams.Text


        Dim sAsunto = "Adjunto de la factura " & myFactura.TipoABC & " " & myFactura.PuntoVenta & "-" & myFactura.Numero


        EnviarEmail(email, sAsunto, "", _
                ConfigurationManager.AppSettings("SmtpUser"), _
                ConfigurationManager.AppSettings("SmtpServer"), _
                ConfigurationManager.AppSettings("SmtpUser"), _
                ConfigurationManager.AppSettings("SmtpPass"), _
                 patharchivoadjunto, _
                ConfigurationManager.AppSettings("SmtpPort"), , CCO, , "Williams Entregas")

    End Function




    Shared Function QuitarImagen1(SC As String, idcarta As Long)
        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim oCarta = (From i In db.CartasDePortes Where i.IdCartaDePorte = idcarta).SingleOrDefault
        oCarta.PathImagen = "" 'nombrenuevo
        db.SubmitChanges()


    End Function

    Shared Function QuitarImagen2(SC As String, idcarta As Long)
        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim oCarta = (From i In db.CartasDePortes Where i.IdCartaDePorte = idcarta).SingleOrDefault
        oCarta.PathImagen2 = "" ' 'nombrenuevo
        db.SubmitChanges()


    End Function


    Sub refrescaIdEncriptados(SC As String)
        Using db As New LinqCartasPorteDataContext(Encriptar(SC))
            Dim q = From c In db.CartasDePortes Where (If(c.PathImagen, "") <> "" Or If(c.PathImagen2, "") <> "") And (If(c.ClaveEncriptada, "") = "") Select c.IdCartaDePorte

            For Each i In q
                Dim s = EntidadManager.encryptQueryString(i.ToString)
                ExecDinamico(SC, "update cartasdeporte set  ClaveEncriptada ='" & s & "' where idcartadeporte=" & i)
            Next
        End Using
    End Sub


    Shared Sub ParseNombreCarta(nombre As String, ByRef numeroCarta As Long, ByRef vagon As Long)
        Dim no As String() = Split(nombre)
        numeroCarta = Val(no(0))
        vagon = 0
        Try
            If no.Count > 1 Then vagon = Val(no(1)) ' Val(Mid(nombre, InStr(nombre, " ")))
        Catch ex As Exception
            ErrHandler.WriteError("ParseNombreCarta " + nombre + " " + ex.ToString)
        End Try

    End Sub



    Shared Function AdjuntarImagen(SC As String, AsyncFileUpload1 As AjaxControlToolkit.AsyncFileUpload, _
                                   forzarID As Long, ByRef sError As String, DirApp As String, NameOnlyFromFullPath As String) As String


        Dim DIRFTP = DirApp & "\DataBackupear\"
        Dim nombre = NameOnlyFromFullPath '(AsyncFileUpload1.PostedFile.FileName)
        Randomize()
        Dim nombrenuevo = Int(Rnd(100000) * 100000).ToString.Replace(".", "") + Now.ToString("ddMMMyyyy_HHmmss") + "_" + nombre


        Dim numeroCarta, vagon As Long
        ParseNombreCarta(nombre, numeroCarta, vagon)





        If (AsyncFileUpload1.HasFile) Then
            Try


                'Dim nombresolo As String = Mid(nombre, nombre.LastIndexOf("\"))

                '    Session("NombreArchivoSubido") = DIRFTP + nombrenuevo

                Dim MyFile1 As New FileInfo(DIRFTP + nombrenuevo)
                Try
                    If MyFile1.Exists Then
                        MyFile1.Delete()
                    End If
                Catch ex As Exception
                End Try


                AsyncFileUpload1.SaveAs(DIRFTP + nombrenuevo)

            Catch ex As Exception
                ErrHandler.WriteError(ex.ToString)
                Throw
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If










        GrabarImagen(forzarID, SC, numeroCarta, vagon, nombrenuevo, sError, DirApp)


        Return nombrenuevo
    End Function


    Shared Function GrabarImagen(forzarID As Long, SC As String, numeroCarta As Long, vagon As Long, nombrenuevo As String, ByRef sError As String, DirApp As String) As String

        'quien se encarga de borrar la imagen que no se pudo adjuntar?

        If forzarID = -1 Then
            Dim cdp As CartaDePorte
            Try
                cdp = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon, -1) 'aca tira la bronca si estaba duplicada

                If cdp.Id = -1 Then
                    sError &= numeroCarta & "/" & vagon & " no existe <br/> "
                    Return ""
                    Return nombrenuevo
                    Exit Function
                    'cdp.NumeroCartaDePorte = numeroCarta
                    'cdp.SubnumeroVagon = vagon
                End If
                forzarID = cdp.Id

            Catch ex As Exception
                ErrHandler.WriteError(ex)

                Dim db2 As New LinqCartasPorteDataContext(Encriptar(SC))
                Dim o = (From i In db2.CartasDePortes Where i.NumeroCartaDePorte = numeroCarta And i.SubnumeroVagon = vagon And i.SubnumeroDeFacturacion <= 0).SingleOrDefault


                If o Is Nothing Then
                    sError &= numeroCarta & "/" & vagon & " no existe <br/> "
                    Return ""
                    Return nombrenuevo
                    Exit Function
                    'cdp.NumeroCartaDePorte = numeroCarta
                    'cdp.SubnumeroVagon = vagon
                End If
                forzarID = o.IdCartaDePorte
            End Try



        End If



        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim oCarta = (From i In db.CartasDePortes Where i.IdCartaDePorte = forzarID).SingleOrDefault


        If InStr(nombrenuevo.ToUpper, "TK") Then
            If oCarta.PathImagen2 <> "" Then
                'qué hago con el archivo anterior? -por ahora lo conservo
                If True Then
                    Dim DIRFTP = DirApp & "\DataBackupear\"
                    Dim MyFile1 As New FileInfo(DIRFTP + oCarta.PathImagen2)
                    Try
                        If MyFile1.Exists Then
                            MyFile1.Delete()
                        End If
                    Catch ex As Exception
                    End Try
                End If
            End If
            oCarta.PathImagen2 = nombrenuevo
        ElseIf InStr(nombrenuevo.ToUpper, "CP") Then
            If oCarta.PathImagen <> "" Then
                'qué hago con el archivo anterior? -por ahora lo conservo 
                If True Then
                    Dim DIRFTP = DirApp & "\DataBackupear\"
                    Dim MyFile1 As New FileInfo(DIRFTP + oCarta.PathImagen)
                    Try
                        If MyFile1.Exists Then
                            MyFile1.Delete()
                        End If
                    Catch ex As Exception
                    End Try
                End If
            End If

            oCarta.PathImagen = nombrenuevo
        Else
            If oCarta.PathImagen = "" Then
                oCarta.PathImagen = nombrenuevo 'nombrenuevo
            ElseIf oCarta.PathImagen2 = "" Then
                oCarta.PathImagen2 = nombrenuevo 'nombrenuevo
            Else
                sError &= "<a href=""CartaDePorte.aspx?Id=" & forzarID & """ target=""_blank"">" & oCarta.NumeroCartaDePorte & "/" & oCarta.SubnumeroVagon & "</a> tiene las dos imagenes ocupadas;  <br/> "
                'sError &= vbCrLf & numeroCarta & " tiene las dos imagenes ocupadas  <br/>"
                Return ""
            End If
        End If

        sError &= "<a href=""CartaDePorte.aspx?Id=" & forzarID & """ target=""_blank"">" & oCarta.NumeroCartaDePorte & "/" & oCarta.SubnumeroVagon & "</a>;  <br/> "

        db.SubmitChanges()

        Return nombrenuevo
    End Function



    Shared Function AdjuntarImagen2(SC As String, AsyncFileUpload1 As AjaxControlToolkit.AsyncFileUpload, forzarID As Long, ByRef sError As String, DirApp As String, NameOnlyFromFullPath As String) As String

        Dim DIRFTP = DirApp & "\DataBackupear\"
        Dim nombre = NameOnlyFromFullPath ' (AsyncFileUpload1.PostedFile.FileName)
        Randomize()
        Dim nombrenuevo = Int(Rnd(100000) * 100000).ToString.Replace(".", "") + Now.ToString("ddMMMyyyy_HHmmss") + "_" + nombre

        Dim numeroCarta = Val(nombre)
        Dim vagon = 0



        If (AsyncFileUpload1.HasFile) Then
            Try


                'Dim nombresolo As String = Mid(nombre, nombre.LastIndexOf("\"))

                '    Session("NombreArchivoSubido") = DIRFTP + nombrenuevo

                Dim MyFile1 As New FileInfo(DIRFTP + nombrenuevo)
                Try
                    If MyFile1.Exists Then
                        MyFile1.Delete()
                    End If
                Catch ex As Exception
                End Try


                AsyncFileUpload1.SaveAs(DIRFTP + nombrenuevo)

            Catch ex As Exception
                ErrHandler.WriteError(ex.ToString)
                Throw
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If



        If forzarID = -1 Then
            Dim cdp = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon, -1)
            If cdp.Id = -1 Then
                sError = "No se encontró la carta " & numeroCarta
                Return nombrenuevo
                Exit Function
            End If
            forzarID = cdp.Id
        End If

        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim oCarta = (From i In db.CartasDePortes Where i.IdCartaDePorte = forzarID).SingleOrDefault
        oCarta.PathImagen2 = nombrenuevo 'nombrenuevo
        db.SubmitChanges()
        sError &= "<a href=""CartaDePorte.aspx?Id=" & forzarID & """ target=""_blank"">" & oCarta.NumeroCartaDePorte & "</a>; "


        Return nombrenuevo


    End Function


    ' How to add a new image part to a package.
    'Public Shared Sub AddImagePart(wordDoc As WordprocessingDocument, ByVal fileName As String)
    Public Shared Sub AddImagePart(document As String, ByVal fileName As String)
        'http://msdn.microsoft.com/en-us/library/bb497430(v=office.12).aspx
        Dim wordDoc As WordprocessingDocument = WordprocessingDocument.Open(document, True)
        Dim mainPart As MainDocumentPart = wordDoc.MainDocumentPart
        Dim imagePart As ImagePart = mainPart.AddImagePart(ImagePartType.Jpeg)
        Dim stream As FileStream = New FileStream(fileName, FileMode.Open)
        imagePart.FeedData(stream)




        Dim docText As String = Nothing
        Dim sr As StreamReader = New StreamReader(wordDoc.MainDocumentPart.GetStream)

        Using (sr)
            docText = sr.ReadToEnd
        End Using

        Dim sw As StreamWriter = New StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create))
        Using (sw)
            sw.Write(docText)
        End Using


        wordDoc.Close()

    End Sub


    Shared Function insertarcodigobarras(wordDoc As WordprocessingDocument)
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////codigo de barras////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////



        Dim imageId As String = "default value"

        'http://stackoverflow.com/questions/2810138/replace-image-in-word-doc-using-openxml


        ' go through the document and pull out the inline image elements
        Dim imageElements As IEnumerable(Of DocumentFormat.OpenXml.Drawing.Wordprocessing.Inline) = _
                                        From run In wordDoc.MainDocumentPart.Document.Descendants(Of Wordprocessing.Run)() _
                                        Where run.Descendants(Of Inline)().First() IsNot Nothing _
                                        Select run.Descendants(Of DocumentFormat.OpenXml.Drawing.Wordprocessing.Inline)().First()

        ' select the image that has the correct filename (chooses the first if there are many)
        Dim selectedImage As DocumentFormat.OpenXml.Drawing.Wordprocessing.Inline = (From image In imageElements _
                                       Where (image.DocProperties IsNot Nothing AndAlso (True Or image.DocProperties.Equals("image filename")))).First()

        ' get the ID from the inline element

        Dim blipElement As DocumentFormat.OpenXml.Drawing.Blip = selectedImage.Descendants(Of DocumentFormat.OpenXml.Drawing.Blip)().First()
        If blipElement IsNot Nothing Then
            imageId = blipElement.Embed.Value
        End If




        'barras.crear()



        Dim imagePart As ImagePart = DirectCast(wordDoc.MainDocumentPart.GetPartById(imageId), ImagePart)
        Dim imageBytes As Byte() = File.ReadAllBytes("C:\barras.png")
        Dim writer As New BinaryWriter(imagePart.GetStream())
        writer.Write(imageBytes)
        writer.Close()


        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////


        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    End Function











    Public Shared Function ImprimirFacturaElectronica(IdFactura As Integer, bMostrarPDF As Boolean, SC As String, DirApp As String) As String

        ErrHandler.WriteError("ImprimirFacturaElectronica idfac " & IdFactura) ' & " " & Encriptar(SC))

        Dim ofac = FacturaManager.GetItem(SC, IdFactura, True)
        Dim output As String
        Randomize()
        Dim prefijo As String = Int(Rnd() * 10000)
        Dim p = DirApp & "\Documentos\" & "FactElec_Williams.docx"


        output = System.IO.Path.GetTempPath() & "\" & prefijo & "FacturaElectronica_Numero" & ofac.Numero & ".docx"
        'tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
        Dim MyFile2 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra
        If MyFile2.Exists Then
            MyFile2.Delete()
            'Ports qué explota? cómo puede ser que ya exista? hay un postback?
        End If


        Try
            System.IO.File.Copy(p, output) 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 

        Catch ex As Exception
            ErrHandler.WriteError("Problema de acceso en el directorio de plantillas. Verificar permisos. " & ex.ToString)
            Throw
        End Try

        ErrHandler.WriteError("Creando docx")


        CartaDePorteManager.FacturaXML_DOCX_Williams(output, ofac, SC)

        ErrHandler.WriteError("docx creado")

        Dim ocli = ClienteManager.GetItem(SC, ofac.IdCliente)


        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim tipoafip = db.TiposComprobantes.First().CodigoAFIP_Letra_A

        ' cuit, tipo_cbte, punto_vta, cae, fch_venc_cae
        'Dim barras As String = "202675653930240016120303473904220110529"


        ErrHandler.WriteError("Creando codigo barras")

        Dim imagen = barras.crear(ocli.Cuit.Replace("-", ""), _
                                  JustificadoDerecha(tipoafip, 2, "0"), _
                                  JustificadoDerecha(ofac.PuntoVenta, 4, "0"), _
                                  JustificadoDerecha(ofac.CAE, 14, "0"), _
                                  ofac.FechaVencimientoORechazoCAE.Date.ToString("yyyyMMdd"))

        ErrHandler.WriteError("Creando pdf")
        output = ConvertirEnPDF_y_PonerCodigoDeBarras(output, imagen, bMostrarPDF)

        ErrHandler.WriteError("salgo")

        Return output

    End Function



    Public Shared Function ConvertirEnPDF_y_PonerCodigoDeBarras(output As String, fImagenBarras As String, bMostrarPDF As Boolean) As String


        ' Quilombo con Office 2010
        '        Previously, Word 2007 had interoperated with an Adobe Acrobat plug-in to properly convert such files 
        'and embed all fonts according to Acrobat’s preference settings. But for Word 2010, there is no working Acrobat plug-in, 
        'and Microsoft has proudly included their own PDF generator, which is the problem. It will embed the Times Roman or Arial 
        'used by Word in the text, but not the Times Roman or Arial that occurs in an inserted graphic. So the Fonts report (in the File > Properties menu) will show both, one as embedded the other as not.
        'Word 2010 now allows you to embed fonts when saving a file (in the File > Options > Save menu), but this does not 
        'correct the problem with PDF files mentioned above.




        Dim oW As Word.Application
        Dim oDoc As Microsoft.Office.Interop.Word.Document
        'Dim oBooks As Excel.Workbooks 'haciendolo así, no queda abierto el proceso en el servidor http://support.microsoft.com/?kbid=317109
        Try

            oW = CreateObject("Word.Application")

            oDoc = oW.Documents.Open(output)


            oW.DisplayAlerts = False ' Word.WdAlertLevel.wdAlertsNone





            If True Then

                Dim range As Word.Range
                'range = oDoc.Bookmarks..Item(oBarcodeBookmark).Range
                range = oDoc.Sections(1).Footers(Word.WdHeaderFooterIndex.wdHeaderFooterPrimary).Range()
                range.Find.Text = "#ImagenCAE#"
                range.Find.Execute(, , , , , , , , , "")

                'oDoc.InlineShapes.AddPicture(fImagenBarras) ', Nothing, Nothing, range)
                range.InlineShapes.AddPicture(fImagenBarras) ', Nothing, Nothing, range)
            End If








            If False Then
                'http://stackoverflow.com/questions/11770821/save-as-pdf-using-c-sharp-and-interop-not-saving-embedded-pdf-in-a-word-document
                'http://www.codeproject.com/Questions/607279/e-cValueplusdoesplusnotplusfallpluswithinplus
                'http://www.microsoft.com/en-us/download/confirmation.aspx?id=7
                'oDoc..EmbedTrueTypeFonts
                oDoc.ExportAsFixedFormat(output, Word.WdExportFormat.wdExportFormatPDF, False, Word.WdExportOptimizeFor.wdExportOptimizeForOnScreen, _
                    Word.WdExportRange.wdExportAllDocument, 1, 1, Word.WdExportItem.wdExportDocumentContent, True, True, _
                    Word.WdExportCreateBookmarks.wdExportCreateHeadingBookmarks, True, True, False, Nothing)

            Else

                If Not bMostrarPDF Then

                    oDoc.SaveAs(output)

                Else
                    output += ".pdf"
                    oDoc.SaveAs(output, Word.WdSaveFormat.wdFormatPDF, , , , , , True)

                End If
            End If

            oDoc.Close(False)

        Catch ex As Exception
            ErrHandler.WriteError(ex)
        Finally

            'Huyo. Pero antes cierro todo
            Try
                NAR(oDoc)
                'quit and dispose app
                oW.Quit()
                NAR(oW)
                'VERY IMPORTANT
                GC.Collect()
            Catch ex As Exception
                ErrHandler.WriteError(ex)
                'COM object that has been separated from its underlying RCW cannot be used.?????
            End Try


        End Try


        Return output
    End Function




    '////////////////////////////////////////////////////////////////
    ' To search and replace content in a document part. 
    Public Shared Sub FacturaXML_DOCX_Williams(ByVal document As String, ByVal oFac As Pronto.ERP.BO.Factura, ByVal SC As String)

        'Dim oFac As Pronto.ERP.BO.Requerimiento = CType(Me.ViewState(mKey), Pronto.ERP.BO.Requerimiento)

        'Try
        If If(oFac.RechazoCAE, "").ToString() <> "" And Not Diagnostics.Debugger.IsAttached Then Throw New Exception("El CAE está rechazado")
        If If(oFac.CAE, "").ToString() = "" And Not Diagnostics.Debugger.IsAttached Then Throw New Exception("Falta el CAE")
        'Catch ex As Exception
        '    ErrHandler.WriteError(ex)
        'End Try



        Dim wordDoc As WordprocessingDocument = WordprocessingDocument.Open(document, True)



        Dim settings As New SimplifyMarkupSettings
        With settings
            .RemoveComments = True
            .RemoveContentControls = True
            .RemoveEndAndFootNotes = True
            .RemoveFieldCodes = False
            .RemoveLastRenderedPageBreak = True
            .RemovePermissions = True
            .RemoveProof = True
            .RemoveRsidInfo = True
            .RemoveSmartTags = True
            .RemoveSoftHyphens = True
            .ReplaceTabsWithSpaces = True
        End With
        MarkupSimplifier.SimplifyMarkup(wordDoc, settings)



        'openxmlcsharp.openxmlcsharp.InsertAPicture(document, "c:\barras.jpg")
        'openxmlcsharp.openxmlcsharp.InsertAPicture(wordDoc, "c:\barras.jpg")
        'wordDoc.Close()
        'AddImagePart(document, "c:\barras.jpg")
        'Return


        Using (wordDoc)



            Try
                ' insertarcodigobarras(wordDoc)
            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try



            Dim docText As String = Nothing
            Dim sr As StreamReader = New StreamReader(wordDoc.MainDocumentPart.GetStream)



            Using (sr)
                docText = sr.ReadToEnd
            End Using

            '/////////////////////////////
            '/////////////////////////////
            'Hace el reemplazo
            '/////////////////////////////




            Try
                oFac.Cliente = ClienteManager.GetItem(SC, oFac.IdCliente)


                regexReplace(docText, "#Cliente#", oFac.Cliente.RazonSocial.Replace("&", "Y"))
                regexReplace(docText, "#CodigoCliente#", oFac.Cliente.CodigoCliente)


                regexReplace(docText, "#Direccion#", oFac.Cliente.Direccion) 'oFac.Domicilio)
                'regexReplace(docText, "#DomicilioRenglon2#", oFac.Domicilio) 'oFac.Domicilio)


                regexReplace(docText, "#Localidad#", NombreLocalidad(SC, oFac.Cliente.IdLocalidad)) 'oFac.Domicilio)

                regexReplace(docText, "#CodPostal#", oFac.Cliente.CodigoPostal)
                regexReplace(docText, "#Provincia#", NombreProvincia(SC, oFac.Cliente.IdProvincia))

                regexReplace(docText, "#CUIT#", oFac.Cliente.Cuit)
            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try

            regexReplace(docText, "#NumeroFactura#", JustificadoDerecha(oFac.Numero, 8, "0"))
            regexReplace(docText, "#PV#", JustificadoDerecha(oFac.PuntoVenta, 4, "0"))
            regexReplace(docText, "#Fecha#", oFac.Fecha)


            oFac.CondicionVentaDescripcion = NombreCondicionVenta_y_Compra(SC, oFac.IdCondicionVenta)
            oFac.CondicionIVADescripcion = NombreCondicionIVA(SC, oFac.IdCodigoIva)

            regexReplace(docText, "#CondicionIVA#", oFac.CondicionIVADescripcion)
            regexReplace(docText, "#CondicionVenta#", oFac.CondicionVentaDescripcion)







            'hay que agregar lo de la http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=12175
            'mostrar el numero de orden de compra
            Dim numeroordencompra As String
            Try

                numeroordencompra = EntidadManager.ExecDinamico(SC, "SELECT numeroordencompraexterna from facturas where idfactura=" & oFac.Id.ToString).Rows(0).Item(0).ToString()
            Catch ex As Exception

                ErrHandler.WriteError(ex)
            End Try

            If numeroordencompra <> "" Then
                regexReplace(docText, "#OrdenCompra#", "N° Orden Compra: " & numeroordencompra)
            Else
                regexReplace(docText, "#OrdenCompra#", "")
            End If



            Dim posObs As Integer
            posObs = InStr(oFac.Observaciones, "Periodo") - 1
            If posObs <= 0 Then posObs = 1


            regexReplace(docText, "#CorredorEnObservaciones#", Left(oFac.Observaciones, posObs).Replace("&", " "))


            regexReplace(docText, "#ObservacionesSinIncluirCorredor#", Mid(oFac.Observaciones, posObs))

            Dim SyngentaLeyenda = LogicaFacturacion.LeyendaSyngenta(oFac.Id, SC) 'oFac.Cliente.AutorizacionSyngenta
            regexReplace(docText, "#LeyendaSyngenta#", SyngentaLeyenda)

            'si se hizo por Pronto, mostrar las observaciones al final
            'pero cómo sé? -mostrar si no tiene periodo
            'If posObs <= 0 Then Selection.TypeText(Text:=oRs.Fields("Observaciones").Value)


            'regexReplace(docText, "#Observaciones#", oFac.Observaciones)
            'regexReplace(docText, "lugarentrega", oFac.LugarEntrega)




            'NO USAR. El reemplazo del pie está al final de esta funcion
            'NO USAR. El reemplazo del pie está al final de esta funcion
            'NO USAR. El reemplazo del pie está al final de esta funcion
            'NO USAR. El reemplazo del pie está al final de esta funcion
            'regexReplace(docText, "#Subtotal#", oFac.SubTotal)  'NO USAR. El reemplazo del pie está al final de esta funcion
            'regexReplace(docText, "#IVA#", oFac.ImporteIva1)
            'regexReplace(docText, "#Total#", oFac.Total)









            Dim sw As StreamWriter = New StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create))
            Using (sw)
                sw.Write(docText)
            End Using







            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            Dim mainPart = wordDoc.MainDocumentPart
            'Dim contentBloc = mainPart.HeaderParts..Descendants(Of Wordprocessing.SdtBlock)().First

            'http://stackoverflow.com/questions/7026449/replacing-bookmarks-in-docx-file-using-openxml-sdk-and-c-cli
            'http://openxmldeveloper.org/blog/b/openxmldeveloper/archive/2011/09/01/how-to-retrieve-the-text-of-a-bookmark-from-an-openxml-wordprocessingml-document.aspx
            'http://openxmldeveloper.org/blog/b/openxmldeveloper/archive/2011/09/06/replacing-text-of-a-bookmark-in-an-openxml-wordprocessingml-document.aspx





            Dim formfield As Wordprocessing.FormFieldData

            Try
                formfield = wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.FormFieldData)().FirstOrDefault
            Catch ex As Exception
                ErrHandler.WriteError("Ver si hay caracteres extraños. Error por el & en la razon social 'CAIO BABILONI & etc'  ")
                ErrHandler.WriteError("archivo:" + document + "  IdFac:" + oFac.Id + "    Error: " + ex.ToString)
                Throw
            End Try

            'Dim e = formfield.GetFirstChild(Of Wordprocessing.Enabled)()
            'e.Val = True
            'Dim parent = formfield.Parent
            'Dim runEEE = New Wordprocessing.Run(New Wordprocessing.Text("sfsdf"))
            'parent.ReplaceChild(runEEE, formfield)

            'Dim t = formfield.GetFirstChild(Of Wordprocessing.TextInput)()


            Dim bookmarkstartCliente = (From bookmark In _
                             wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
                           Where bookmark.Name = "Cliente" _
                           Select bookmark).SingleOrDefault

            'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
            'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
            'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
            'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
            'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
            'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
            'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
            'http://stackoverflow.com/a/4725777/1054200
            'http://stackoverflow.com/a/4725777/1054200
            'http://stackoverflow.com/a/4725777/1054200
            'http://stackoverflow.com/a/4725777/1054200
            'Dim textoCliente = bmCliente.NextSibling(Of Wordprocessing.Run)()
            'If Not IsNull(textoCliente) Then
            '    Dim textito = textoCliente.GetFirstChild(Of Wordprocessing.Text)()
            '    textito.Text = "blah"
            'End If
            '
            '   
            '

            Try

                Dim textoRellenar = "RazonSocial S.A." 'EntidadManager.NombreCliente(sc, oFac.IdCliente)

                If bookmarkstartCliente IsNot Nothing Then
                    Dim bsText As DocumentFormat.OpenXml.OpenXmlElement = bookmarkstartCliente.NextSibling
                    If Not bsText Is Nothing Then
                        If TypeOf bsText Is Wordprocessing.BookmarkEnd Then
                            'Add Text element after start bookmark
                            bookmarkstartCliente.Parent.InsertAfter(New Wordprocessing.Run(New Wordprocessing.Text(textoRellenar)), _
                                                                    bookmarkstartCliente)
                        Else
                            'Change Bookmark Text
                            If TypeOf bsText Is Wordprocessing.Run Then
                                If bsText.GetFirstChild(Of Wordprocessing.Text)() Is Nothing Then
                                    'bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 2)
                                    'bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 1)
                                    bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 0)
                                End If
                                bsText.GetFirstChild(Of Wordprocessing.Text)().Text = textoRellenar 'bookmarkstartCliente.Name
                            End If
                        End If
                    End If
                End If
            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try




            'Dim ccWithTable As Wordprocessing.SdtBlock = mainPart.Document.Body.Descendants(Of Wordprocessing.SdtBlock)().Where _
            '                        (Function(r) r.SdtProperties.GetFirstChild(Of Wordprocessing.Tag)().Val = tblTag).Single()


            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            'CUERPO  (repetir renglones)
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            'http://msdn.microsoft.com/en-us/library/cc850835(office.14).aspx

            '///////////////////////////////////////////////////////////////////////////////////
            '   http://stackoverflow.com/a/3783607/1054200
            '@Matt S: I've put in a few extra links that should also help you get started. There are a number of ways 
            'to do repeaters with Content Controls - one is what you mentioned. The other way is to use Building Blocks. 
            'Another way is to kind of do the opposite of what you mentioned - put a table with just a header row and then 
            'create rows populated with CCs in the cells (creo que esto es lo que hago yo). Do take a look 
            'at the Word Content Control Kit as well - that will save your life in working with CCs until you 
            'become much more familiar. – Otaku Sep 25 '10 at 15:46
            '/////////////////////////////////////////////////////////////////////////////////////

            '  'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk




            '///////////////////////////////////////
            'en VBA, Edu busca el sector así:
            '
            '            Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
            '
            '-no encuentro en qué lugar dice "Detalles"!!! -ahí está (Ctrl-I). no sé como mostrarlos. Edu se maneja
            ' con bookmarks. Para hacer la migracion, debería imitar lo mas posible esa idea (haciendolo
            ' compatible, mostrando los bookmarks como placeholders, etc.
            ' APARECEN CON CORCHETES SI TIENEN UN ITEM. SI ES UNA UBICACION, APARECEN CON EL I-beam (una "I" grande)
            '- y cómo sé el nombre que tiene???????
            '///////////////////////////////////////

            'mostrar bookmarks en Word2007
            'http://www.google.com.ar/imgres?um=1&hl=es&safe=off&sa=N&biw=1163&bih=839&tbm=isch&tbnid=VBegw7vZDThDNM:&imgrefurl=http://www.howtogeek.com/76142/navigate-long-documents-in-word-2007-and-2010-using-bookmarks/&docid=lavUxX3WcLhNAM&imgurl=http://www.howtogeek.com/wp-content/uploads/2011/10/05_turning_on_show_bookmarks.png&w=544&h=414&ei=cNNiT7OYAoKgtwfd2eWLCA&zoom=1&iact=rc&dur=312&sig=101947458089387539527&page=1&tbnh=145&tbnw=191&start=0&ndsp=20&ved=1t:429,r:1,s:0&tx=113&ty=93

            '            Isn() 't there a way in Word 2007 to show all bookmarks in a document
            'In any version of Word, you can get the Bookmark dialog to display the names 
            'of all the bookmarks by both checking the "Hidden bookmarks" box *and* 
            'selecting "Sort by: Location." You can select any given bookmark name and 
            'click Go To to find it.

            '//////////////////////////////////////////////////////////////
            'cómo mostrar el tab de DEVELOPER en office
            'Click the Microsoft Office Button, and then click Excel Options, PowerPoint Options, or Word Options.
            'Click Popular, and then select the Show Developer tab in the Ribbon check box.
            '//////////////////////////////////////////////////////////////

            '//////////////////////////////////////////////////
            'en VBA, Edu busca el sector así:
            '
            '            Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
            '
            'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
            '//////////////////////////////////////////////////////////




            Dim bookmarkDetalles = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
       Where bookmark.Name = "Detalles" Or bookmark.Name = "Detalle" _
       Select bookmark).FirstOrDefault


            Dim tempParent

            Dim placeholderCANT = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.Text)() _
                                      Where bookmark.Text = "#Descripcion#" _
                                      Select bookmark).FirstOrDefault

            If Not placeholderCANT Is Nothing Then
                tempParent = placeholderCANT.Parent
            Else
                tempParent = bookmarkDetalles.Parent
            End If




            '////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////

            'qué tabla contiene al bookmark "Detalles"? (es el que usa Edu en VBA)
            Dim table As Wordprocessing.Table

            ' Find the second row in the table.
            Dim row1 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(0)
            Dim row2 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(1)


            If True Then

                'METODO B:
                'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                ' loop till we get the containing element in case bookmark is inside a table etc.
                ' keep checking the element's parent and update it till we reach the Body
                'Dim tempParent = bookmarkDetalles.Parent
                Dim isInTable As Boolean = False

                While Not TypeOf (tempParent.Parent) Is Wordprocessing.Body ',) <> mainPart.Document.Body
                    tempParent = tempParent.Parent
                    If (TypeOf (tempParent) Is Wordprocessing.TableRow And Not isInTable) Then
                        isInTable = True
                        Exit While
                    End If
                End While

                If isInTable Then
                    'table = tempParent
                    'no basta con saber la tabla. necesito saber la posicion del bookmark en la tabla
                    'table.ChildElements(
                    'bookmarkDetalles.
                    row1 = tempParent
                    table = row1.Parent
                Else
                    Err.Raise(5454, "asdasdasa")
                End If

            Else

                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                'METODO A:
                ' Find the first table in the document.
                table = wordDoc.MainDocumentPart.Document.Body.Elements(Of Wordprocessing.Table)().First

            End If

            '////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////







            ''Make a copy of the 2nd row (assumed that the 1st row is header) http://patrickyong.net/tags/openxml/
            'Dim rows = table.Elements(Of Wordprocessing.TableRow)()
            For Each i As FacturaItem In oFac.Detalles
                Dim dupRow As DocumentFormat.OpenXml.OpenXmlElement = row1.CloneNode(True)
                'Dim dupRow2 = row2.CloneNode(True)

                'CeldaReemplazos(dupRow, -1, i)


                For CeldaColumna As Long = 0 To row1.Elements(Of Wordprocessing.TableCell)().Count - 1
                    Try

                        '///////////////////////////
                        'renglon 1
                        '///////////////////////////

                        CeldaReemplazosFactura_Williams(dupRow, CeldaColumna, i, oFac.Cliente.IncluyeTarifaEnFactura = "SI")


                        '///////////////////////////
                        'renglon 2
                        '///////////////////////////

                        '    CeldaReemplazos(dupRow2, CeldaColumna, i)
                        '    table.AppendChild(dupRow2)



                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                Next

                table.AppendChild(dupRow)


            Next

            table.RemoveChild(row1)
            'row2.Parent.RemoveChild(row2)



            If False Then AppendPageBreak(wordDoc)


            '/////////////////////////////
            '/////////////////////////////
            'PIE
            '/////////////////////////////
            '/////////////////////////////

            For Each pie As FooterPart In wordDoc.MainDocumentPart.FooterParts
                'Dim pie = wordDoc.MainDocumentPart.FooterParts.First
                pie.GetStream()

                docText = Nothing
                sr = New StreamReader(pie.GetStream())

                Using (sr)
                    docText = sr.ReadToEnd
                End Using

                regexReplace(docText, "observaciones", oFac.Observaciones)
                regexReplace(docText, "lugarentrega", oFac.LugarEntrega)
                regexReplace(docText, "libero", oFac.Aprobo)
                regexReplace(docText, "fecharecepcion", oFac.Fecha)
                regexReplace(docText, "jefesector", "")

                regexReplace(docText, "#Subtotal#", "$ " + FF2(FF2(oFac.Total) - FF2(oFac.ImporteIva1) - oFac.IBrutos))
                regexReplace(docText, "#PorcIVA#", oFac.PorcentajeIva1.ToString("0.0", System.Globalization.CultureInfo.InvariantCulture))
                regexReplace(docText, "#IVA#", "$ " + FF2(oFac.ImporteIva1))
                regexReplace(docText, "#IIBB#", oFac.IBrutos)
                regexReplace(docText, "#Total#", "$ " + FF2(oFac.Total))

                regexReplace(docText, "#TotalPalabras#", "Pesos " + Numalet.ToCardinal(oFac.Total))

                regexReplace(docText, "#CAE#", oFac.CAE)
                regexReplace(docText, "#VenceCAE#", oFac.FechaVencimientoORechazoCAE)







                sw = New StreamWriter(pie.GetStream(FileMode.Create))
                Using (sw)
                    sw.Write(docText)
                End Using
            Next


            'buscar bookmark http://openxmldeveloper.org/discussions/formats/f/13/p/2539/8302.aspx
            'Dim mainPart As MainDocumentPart = wordDoc.MainDocumentPart()
            'Dim bookmarkStart = mainPart.Document.Body.Descendants().Where(bms >= bms.Name = "testBookmark").SingleOrDefault()
            'Dim bookmarkEnd = mainPart.Document.Body.Descendants().Where(bme >= bme.Id.Value = bookmarkStart.Id.Value).SingleOrDefault()
            'BookmarkStart.Remove()
            'BookmarkEnd.Remove()






        End Using


        'Dim CANTIDAD_COPIAS As Integer = ConfigurationManager.AppSettings("Debug_CantidadCopiasCartaPorte")  'BuscarClaveINI("CantidadCopiasCartaPorte", sc, )
        'For n = 1 To CANTIDAD_COPIAS

        '    Dim wordDoc1 As WordprocessingDocument = WordprocessingDocument.Open(document, False)
        '    Dim wordDoc2 As WordprocessingDocument = WordprocessingDocument.Open(document, True)
        '    Using (wordDoc2)
        '        Dim themePart1 As ThemePart = wordDoc1.MainDocumentPart.ThemePart
        '        Dim themePart2 As ThemePart = wordDoc2.MainDocumentPart.ThemePart
        '        Dim streamReader As StreamReader = New StreamReader(themePart1.GetStream())
        '        Dim streamWriter As StreamWriter = New StreamWriter(themePart2.GetStream(FileMode.Create))
        '        Using (streamWriter)
        '            streamWriter.Write(streamReader.ReadToEnd)
        '        End Using
        '    End Using

        'Next


    End Sub



    Public Shared Sub FacturaXML_DOCX_Williams_Lote(ByVal document As String, ByVal listFac As Generic.List(Of Pronto.ERP.BO.Factura), ByVal SC As String)

        'Dim oFac As Pronto.ERP.BO.Requerimiento = CType(Me.ViewState(mKey), Pronto.ERP.BO.Requerimiento)






        Dim wordDoc As WordprocessingDocument = WordprocessingDocument.Open(document, True)



        Dim settings As New SimplifyMarkupSettings
        With settings
            .RemoveComments = True
            .RemoveContentControls = True
            .RemoveEndAndFootNotes = True
            .RemoveFieldCodes = False
            .RemoveLastRenderedPageBreak = True
            .RemovePermissions = True
            .RemoveProof = True
            .RemoveRsidInfo = True
            .RemoveSmartTags = True
            .RemoveSoftHyphens = True
            .ReplaceTabsWithSpaces = True
        End With
        MarkupSimplifier.SimplifyMarkup(wordDoc, settings)





        Using (wordDoc)
            Dim docText As String = Nothing
            Dim sr As StreamReader = New StreamReader(wordDoc.MainDocumentPart.GetStream)



            Using (sr)
                docText = sr.ReadToEnd
            End Using

            '/////////////////////////////
            '/////////////////////////////
            'Hace el reemplazo
            '/////////////////////////////



            For Each oFac As Pronto.ERP.BO.Factura In listFac

                If oFac.RechazoCAE.ToString <> "" Then Throw New Exception("El CAE está rechazado")
                If oFac.CAE.ToString = "" Then Throw New Exception("Falta el CAE")



                Try
                    oFac.Cliente = ClienteManager.GetItem(SC, oFac.IdCliente)


                    regexReplace(docText, "#Cliente#", oFac.Cliente.RazonSocial.Replace("&", "Y"))
                    regexReplace(docText, "#CodigoCliente#", oFac.Cliente.CodigoCliente)


                    regexReplace(docText, "#Direccion#", oFac.Cliente.Direccion) 'oFac.Domicilio)
                    'regexReplace(docText, "#DomicilioRenglon2#", oFac.Domicilio) 'oFac.Domicilio)


                    regexReplace(docText, "#Localidad#", NombreLocalidad(SC, oFac.Cliente.IdLocalidad)) 'oFac.Domicilio)

                    regexReplace(docText, "#CodPostal#", oFac.Cliente.CodigoPostal)
                    regexReplace(docText, "#Provincia#", NombreProvincia(SC, oFac.Cliente.IdProvincia))

                    regexReplace(docText, "#CUIT#", oFac.Cliente.Cuit)
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try

                regexReplace(docText, "#NumeroFactura#", oFac.Numero)
                regexReplace(docText, "#Fecha#", oFac.Fecha)


                oFac.CondicionVentaDescripcion = NombreCondicionVenta_y_Compra(SC, oFac.IdCondicionVenta)
                oFac.CondicionIVADescripcion = NombreCondicionIVA(SC, oFac.IdCodigoIva)

                regexReplace(docText, "#CondicionIVA#", oFac.CondicionIVADescripcion)
                regexReplace(docText, "#CondicionVenta#", oFac.CondicionVentaDescripcion)



                regexReplace(docText, "#CAE#", oFac.CAE)





                Dim posObs As Integer
                posObs = InStr(oFac.Observaciones, "Periodo") - 1
                If posObs <= 0 Then posObs = 1


                regexReplace(docText, "#CorredorEnObservaciones#", Left(oFac.Observaciones, posObs).Replace("&", " "))


                regexReplace(docText, "#ObservacionesSinIncluirCorredor#", Mid(oFac.Observaciones, posObs))
                'si se hizo por Pronto, mostrar las observaciones al final
                'pero cómo sé? -mostrar si no tiene periodo
                'If posObs <= 0 Then Selection.TypeText(Text:=oRs.Fields("Observaciones").Value)


                'regexReplace(docText, "#Observaciones#", oFac.Observaciones)
                'regexReplace(docText, "lugarentrega", oFac.LugarEntrega)




                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'regexReplace(docText, "#Subtotal#", oFac.SubTotal)  'NO USAR. El reemplazo del pie está al final de esta funcion
                'regexReplace(docText, "#IVA#", oFac.ImporteIva1)
                'regexReplace(docText, "#Total#", oFac.Total)




                Dim sw As StreamWriter = New StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create))
                Using (sw)
                    sw.Write(docText)
                End Using







                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                Dim mainPart = wordDoc.MainDocumentPart
                'Dim contentBloc = mainPart.HeaderParts..Descendants(Of Wordprocessing.SdtBlock)().First

                'http://stackoverflow.com/questions/7026449/replacing-bookmarks-in-docx-file-using-openxml-sdk-and-c-cli
                'http://openxmldeveloper.org/blog/b/openxmldeveloper/archive/2011/09/01/how-to-retrieve-the-text-of-a-bookmark-from-an-openxml-wordprocessingml-document.aspx
                'http://openxmldeveloper.org/blog/b/openxmldeveloper/archive/2011/09/06/replacing-text-of-a-bookmark-in-an-openxml-wordprocessingml-document.aspx





                Dim formfield As Wordprocessing.FormFieldData

                Try
                    formfield = wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.FormFieldData)().FirstOrDefault
                Catch ex As Exception
                    ErrHandler.WriteError("Ver si hay caracteres extraños. Error por el & en la razon social 'CAIO BABILONI & etc'  ")
                    ErrHandler.WriteError("archivo:" + document + "  IdFac:" + oFac.Id + "    Error: " + ex.ToString)
                    Throw
                End Try

                'Dim e = formfield.GetFirstChild(Of Wordprocessing.Enabled)()
                'e.Val = True
                'Dim parent = formfield.Parent
                'Dim runEEE = New Wordprocessing.Run(New Wordprocessing.Text("sfsdf"))
                'parent.ReplaceChild(runEEE, formfield)

                'Dim t = formfield.GetFirstChild(Of Wordprocessing.TextInput)()


                Dim bookmarkstartCliente = (From bookmark In _
                                 wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
                               Where bookmark.Name = "Cliente" _
                               Select bookmark).SingleOrDefault

                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/a/4725777/1054200
                'http://stackoverflow.com/a/4725777/1054200
                'http://stackoverflow.com/a/4725777/1054200
                'http://stackoverflow.com/a/4725777/1054200
                'Dim textoCliente = bmCliente.NextSibling(Of Wordprocessing.Run)()
                'If Not IsNull(textoCliente) Then
                '    Dim textito = textoCliente.GetFirstChild(Of Wordprocessing.Text)()
                '    textito.Text = "blah"
                'End If
                '
                '   
                '

                Try

                    Dim textoRellenar = "RazonSocial S.A." 'EntidadManager.NombreCliente(sc, oFac.IdCliente)

                    If bookmarkstartCliente IsNot Nothing Then
                        Dim bsText As DocumentFormat.OpenXml.OpenXmlElement = bookmarkstartCliente.NextSibling
                        If Not bsText Is Nothing Then
                            If TypeOf bsText Is Wordprocessing.BookmarkEnd Then
                                'Add Text element after start bookmark
                                bookmarkstartCliente.Parent.InsertAfter(New Wordprocessing.Run(New Wordprocessing.Text(textoRellenar)), _
                                                                        bookmarkstartCliente)
                            Else
                                'Change Bookmark Text
                                If TypeOf bsText Is Wordprocessing.Run Then
                                    If bsText.GetFirstChild(Of Wordprocessing.Text)() Is Nothing Then
                                        'bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 2)
                                        'bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 1)
                                        bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 0)
                                    End If
                                    bsText.GetFirstChild(Of Wordprocessing.Text)().Text = textoRellenar 'bookmarkstartCliente.Name
                                End If
                            End If
                        End If
                    End If
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try




                'Dim ccWithTable As Wordprocessing.SdtBlock = mainPart.Document.Body.Descendants(Of Wordprocessing.SdtBlock)().Where _
                '                        (Function(r) r.SdtProperties.GetFirstChild(Of Wordprocessing.Tag)().Val = tblTag).Single()


                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                'CUERPO  (repetir renglones)
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                'http://msdn.microsoft.com/en-us/library/cc850835(office.14).aspx

                '///////////////////////////////////////////////////////////////////////////////////
                '   http://stackoverflow.com/a/3783607/1054200
                '@Matt S: I've put in a few extra links that should also help you get started. There are a number of ways 
                'to do repeaters with Content Controls - one is what you mentioned. The other way is to use Building Blocks. 
                'Another way is to kind of do the opposite of what you mentioned - put a table with just a header row and then 
                'create rows populated with CCs in the cells (creo que esto es lo que hago yo). Do take a look 
                'at the Word Content Control Kit as well - that will save your life in working with CCs until you 
                'become much more familiar. – Otaku Sep 25 '10 at 15:46
                '/////////////////////////////////////////////////////////////////////////////////////

                '  'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk




                '///////////////////////////////////////
                'en VBA, Edu busca el sector así:
                '
                '            Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
                '
                '-no encuentro en qué lugar dice "Detalles"!!! -ahí está (Ctrl-I). no sé como mostrarlos. Edu se maneja
                ' con bookmarks. Para hacer la migracion, debería imitar lo mas posible esa idea (haciendolo
                ' compatible, mostrando los bookmarks como placeholders, etc.
                ' APARECEN CON CORCHETES SI TIENEN UN ITEM. SI ES UNA UBICACION, APARECEN CON EL I-beam (una "I" grande)
                '- y cómo sé el nombre que tiene???????
                '///////////////////////////////////////

                'mostrar bookmarks en Word2007
                'http://www.google.com.ar/imgres?um=1&hl=es&safe=off&sa=N&biw=1163&bih=839&tbm=isch&tbnid=VBegw7vZDThDNM:&imgrefurl=http://www.howtogeek.com/76142/navigate-long-documents-in-word-2007-and-2010-using-bookmarks/&docid=lavUxX3WcLhNAM&imgurl=http://www.howtogeek.com/wp-content/uploads/2011/10/05_turning_on_show_bookmarks.png&w=544&h=414&ei=cNNiT7OYAoKgtwfd2eWLCA&zoom=1&iact=rc&dur=312&sig=101947458089387539527&page=1&tbnh=145&tbnw=191&start=0&ndsp=20&ved=1t:429,r:1,s:0&tx=113&ty=93

                '            Isn() 't there a way in Word 2007 to show all bookmarks in a document
                'In any version of Word, you can get the Bookmark dialog to display the names 
                'of all the bookmarks by both checking the "Hidden bookmarks" box *and* 
                'selecting "Sort by: Location." You can select any given bookmark name and 
                'click Go To to find it.

                '//////////////////////////////////////////////////////////////
                'cómo mostrar el tab de DEVELOPER en office
                'Click the Microsoft Office Button, and then click Excel Options, PowerPoint Options, or Word Options.
                'Click Popular, and then select the Show Developer tab in the Ribbon check box.
                '//////////////////////////////////////////////////////////////

                '//////////////////////////////////////////////////
                'en VBA, Edu busca el sector así:
                '
                '            Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
                '
                'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                '//////////////////////////////////////////////////////////




                Dim bookmarkDetalles = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
                       Where bookmark.Name = "Detalles" Or bookmark.Name = "Detalle" _
                       Select bookmark).FirstOrDefault


                Dim tempParent

                Dim placeholderCANT = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.Text)() _
                                          Where bookmark.Text = "#Descripcion#" _
                                          Select bookmark).FirstOrDefault

                If Not placeholderCANT Is Nothing Then
                    tempParent = placeholderCANT.Parent
                Else
                    tempParent = bookmarkDetalles.Parent
                End If



                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////

                'qué tabla contiene al bookmark "Detalles"? (es el que usa Edu en VBA)
                Dim table As Wordprocessing.Table

                ' Find the second row in the table.
                Dim row1 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(0)
                Dim row2 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(1)


                If True Then

                    'METODO B:
                    'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                    ' loop till we get the containing element in case bookmark is inside a table etc.
                    ' keep checking the element's parent and update it till we reach the Body
                    'Dim tempParent = bookmarkDetalles.Parent
                    Dim isInTable As Boolean = False

                    While Not TypeOf (tempParent.Parent) Is Wordprocessing.Body ',) <> mainPart.Document.Body
                        tempParent = tempParent.Parent
                        If (TypeOf (tempParent) Is Wordprocessing.TableRow And Not isInTable) Then
                            isInTable = True
                            Exit While
                        End If
                    End While

                    If isInTable Then
                        'table = tempParent
                        'no basta con saber la tabla. necesito saber la posicion del bookmark en la tabla
                        'table.ChildElements(
                        'bookmarkDetalles.
                        row1 = tempParent
                        table = row1.Parent
                    Else
                        Err.Raise(5454, "asdasdasa")
                    End If

                Else

                    '////////////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////////////
                    'METODO A:
                    ' Find the first table in the document.
                    table = wordDoc.MainDocumentPart.Document.Body.Elements(Of Wordprocessing.Table)().First

                End If

                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////







                ''Make a copy of the 2nd row (assumed that the 1st row is header) http://patrickyong.net/tags/openxml/
                'Dim rows = table.Elements(Of Wordprocessing.TableRow)()
                For Each i As FacturaItem In oFac.Detalles
                    Dim dupRow As DocumentFormat.OpenXml.OpenXmlElement = row1.CloneNode(True)
                    'Dim dupRow2 = row2.CloneNode(True)

                    'CeldaReemplazos(dupRow, -1, i)


                    For CeldaColumna As Long = 0 To row1.Elements(Of Wordprocessing.TableCell)().Count - 1
                        Try

                            '///////////////////////////
                            'renglon 1
                            '///////////////////////////

                            CeldaReemplazosFactura_Williams(dupRow, CeldaColumna, i, oFac.Cliente.IncluyeTarifaEnFactura = "SI")


                            '///////////////////////////
                            'renglon 2
                            '///////////////////////////

                            '    CeldaReemplazos(dupRow2, CeldaColumna, i)
                            '    table.AppendChild(dupRow2)



                        Catch ex As Exception
                            ErrHandler.WriteError(ex)
                        End Try

                    Next

                    table.AppendChild(dupRow)


                Next

                table.RemoveChild(row1)
                'row2.Parent.RemoveChild(row2)



                If False Then AppendPageBreak(wordDoc)


                '/////////////////////////////
                '/////////////////////////////
                'PIE
                '/////////////////////////////
                '/////////////////////////////

                For Each pie As FooterPart In wordDoc.MainDocumentPart.FooterParts
                    'Dim pie = wordDoc.MainDocumentPart.FooterParts.First
                    pie.GetStream()

                    docText = Nothing
                    sr = New StreamReader(pie.GetStream())

                    Using (sr)
                        docText = sr.ReadToEnd
                    End Using

                    regexReplace(docText, "observaciones", oFac.Observaciones)
                    regexReplace(docText, "lugarentrega", oFac.LugarEntrega)
                    regexReplace(docText, "libero", oFac.Aprobo)
                    regexReplace(docText, "fecharecepcion", oFac.Fecha)
                    regexReplace(docText, "jefesector", "")

                    regexReplace(docText, "#Subtotal#", "$ " + FF2(FF2(oFac.Total) - FF2(oFac.ImporteIva1) - oFac.IBrutos))
                    regexReplace(docText, "#PorcIVA#", oFac.PorcentajeIva1.ToString("0.0", System.Globalization.CultureInfo.InvariantCulture))
                    regexReplace(docText, "#IVA#", "$ " + FF2(oFac.ImporteIva1))
                    regexReplace(docText, "#IIBB#", oFac.IBrutos)
                    regexReplace(docText, "#Total#", "$ " + FF2(oFac.Total))

                    regexReplace(docText, "#TotalPalabras#", "Pesos " + Numalet.ToCardinal(oFac.Total))


                    sw = New StreamWriter(pie.GetStream(FileMode.Create))
                    Using (sw)
                        sw.Write(docText)
                    End Using
                Next


                'buscar bookmark http://openxmldeveloper.org/discussions/formats/f/13/p/2539/8302.aspx
                'Dim mainPart As MainDocumentPart = wordDoc.MainDocumentPart()
                'Dim bookmarkStart = mainPart.Document.Body.Descendants().Where(bms >= bms.Name = "testBookmark").SingleOrDefault()
                'Dim bookmarkEnd = mainPart.Document.Body.Descendants().Where(bme >= bme.Id.Value = bookmarkStart.Id.Value).SingleOrDefault()
                'BookmarkStart.Remove()
                'BookmarkEnd.Remove()



            Next



        End Using


        'Dim CANTIDAD_COPIAS As Integer = ConfigurationManager.AppSettings("Debug_CantidadCopiasCartaPorte")  'BuscarClaveINI("CantidadCopiasCartaPorte", sc, )
        'For n = 1 To CANTIDAD_COPIAS

        '    Dim wordDoc1 As WordprocessingDocument = WordprocessingDocument.Open(document, False)
        '    Dim wordDoc2 As WordprocessingDocument = WordprocessingDocument.Open(document, True)
        '    Using (wordDoc2)
        '        Dim themePart1 As ThemePart = wordDoc1.MainDocumentPart.ThemePart
        '        Dim themePart2 As ThemePart = wordDoc2.MainDocumentPart.ThemePart
        '        Dim streamReader As StreamReader = New StreamReader(themePart1.GetStream())
        '        Dim streamWriter As StreamWriter = New StreamWriter(themePart2.GetStream(FileMode.Create))
        '        Using (streamWriter)
        '            streamWriter.Write(streamReader.ReadToEnd)
        '        End Using
        '    End Using

        'Next


    End Sub



    Public Shared Sub AppendPageBreak(myDoc As WordprocessingDocument)

        Dim mainPart As MainDocumentPart = myDoc.MainDocumentPart

        Dim last As OpenXmlElement = myDoc.MainDocumentPart.Document.Body().Elements() _
                                     .LastOrDefault(Function(e) TypeOf e Is DocumentFormat.OpenXml.Wordprocessing.Paragraph Or TypeOf e Is DocumentFormat.OpenXml.Wordprocessing.AltChunk)

        last.InsertAfterSelf(New DocumentFormat.OpenXml.Wordprocessing.Paragraph(New DocumentFormat.OpenXml.Wordprocessing. _
                                                                                Run(New DocumentFormat.OpenXml.Wordprocessing.Break() With {.Type = DocumentFormat.OpenXml.Wordprocessing.BreakValues.Page})))
    End Sub

    Shared Sub CeldaReemplazosFactura_Williams(ByRef row As Wordprocessing.TableRow, ByVal numcelda As Integer, ByVal itemFactura As Pronto.ERP.BO.FacturaItem, IncluyeTarifaEnFactura As Boolean)


        'METODO 2
        'al editar varias veces el tag, el texto puede estar desperdigado en varios Run's del Paragraph...

        'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
        'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
        'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
        'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
        'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
        'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
        'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
        'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
        'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
        'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!


        'http://stackoverflow.com/questions/7752932/simplify-clean-up-xml-of-a-docx-word-document
        'lo recomienda Otaku! http://stackoverflow.com/a/5293425/1054200
        'http://ericwhite.com/blog/2011/03/09/getting-started-with-open-xml-powertools-markup-simplifier/
        'http://powertools.codeplex.com/releases/view/74771
        'http://www.youtube.com/watch?v=LBFAXNlEBFA&feature=player_embedded



        Dim texto As String = row.InnerXml

        regexReplace(texto, "#Numero#", iisNull(itemFactura.NumeroItem))



        If iisNull(itemFactura.Articulo) <> "CAMBIO DE CARTA DE PORTE" Then
            regexReplace(texto, "#Cant#", Int(iisNull(itemFactura.Cantidad) * 1000)) 'dfdfdfdf  ehhhh? no se graban los decimales.... no tengo tantos decimales para la cantidad
        Else
            regexReplace(texto, "#Cant#", Int(iisNull(itemFactura.Cantidad))) 'dfdfdfdf  ehhhh? no se graban los decimales.... no tengo tantos decimales para la cantidad
        End If
        'te mató lo del int!!!!!




        regexReplace(texto, "Unidad", iisNull(itemFactura.Unidad))
        regexReplace(texto, "Codigo", iisNull(itemFactura.Codigo))


        If IncluyeTarifaEnFactura Then
            regexReplace(texto, "#Precio#", Math.Round(iisNull(itemFactura.Precio), 2))
        Else
            regexReplace(texto, "#Precio#", "")
        End If





        regexReplace(texto, "#Importe#", FF2(iisNull(itemFactura.Precio) * iisNull(itemFactura.Cantidad)))
        regexReplace(texto, "#Descripcion#", iisNull(itemFactura.Articulo))
        regexReplace(texto, "FechaEntrega", iisNull(itemFactura.FechaEntrega))






        '///////////////////////////////////////////


        Dim mvarArticulo As String = iisNull(itemFactura.Observaciones)
        Dim posx
        posx = InStr(mvarArticulo, "__")
        If posx > 2 Then mvarArticulo = Left(mvarArticulo, posx - 2)
        mvarArticulo = Trim(mvarArticulo)
        regexReplace(texto, "#ObsItem#", mvarArticulo)



        '///////////////////////////////////////////


        row.InnerXml = texto



    End Sub













End Class

Public Class LogicaFacturacion
    Public Const IDEMBARQUES = -2
    
    Public Shared ReadOnly Property MAXRENGLONES As Integer
        Get
            Return ConfigurationManager.AppSettings("RenglonesFactura")
        End Get
    End Property






    Shared Function CartasConEntregadorExternoLINQ(SC As String) As IQueryable(Of CartasDePorte)
        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


        Dim q = _
                (From i In db.CartasDePortes Where If(i.IdFacturaImputada, 0) = 0 And If(i.IdClienteEntregador, 12454) <> 12454 And i.IdClienteEntregador <> 5822)


        Return q
    End Function


    Shared Sub CorrectorSubnumeroFacturacion(SC As String, ByRef mensajes As String)
        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        'busco todas las cartas con copia sin incluir originales, a ver cuales solo tienen 1 carta en el grupo, lo que quiere decir que está mal
        'el subnumero de facturacion debería poder ser -1 tambien!!!
        '-nono... a las que tienen copia le pongo 0 en el original... no?

        'Esto corrige las que estásn solas y deben ponerse como originales
        'NO CORRIGE las que están mal duplicadas como 0 y -1 en el SubnumeroDeFacturacion
        Dim q2 = (From cdp In db.CartasDePortes _
                Where If(cdp.SubnumeroDeFacturacion, 0) >= 0 _
                 And If(cdp.IdFacturaImputada, 0) = 0 And cdp.Anulada <> "SI" _
                Group cdp By _
                    numerocartadeporte = cdp.NumeroCartaDePorte, _
                    subnumerovagon = cdp.SubnumeroVagon _
                Into g = Group _
                Select New With { _
                    .numerocartadeporte = numerocartadeporte, _
                    .subnumerovagon = subnumerovagon, _
                    .CantCartas = g.Count, _
                    .IdCartaDePorte = g.Sum(Function(x) x.IdCartaDePorte) _
                }).Where(Function(i) i.CantCartas = 1).Select(Function(i) i.IdCartaDePorte).Distinct().ToList.Take(100)


        Try

            'si habia un -1 y un 1, solo toma en cuenta el 1, intenta arreglarlo 
            'poniendole -1, no puede, y termina poniendole -2, y te queda un -1 y un -2, que 
            ' es lo que pasó en http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11785
            '-y por qué no incluías las que tienen -1? -porque esas supuestamente estan sueltas, sin copia!

            'Esto corrige las que estásn solas y deben ponerse como originales
            'NO CORRIGE las que están mal duplicadas como 0 y -1 en el SubnumeroDeFacturacion

            For Each cdp In q2
                Dim ccc = db.CartasDePortes.Where(Function(x) x.IdCartaDePorte = cdp).FirstOrDefault()
                ccc.SubnumeroDeFacturacion = -1
                Try
                    db.SubmitChanges()
                Catch ex As Exception

                    'System.Data.SqlClient.SqlException: Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert 
                    'duplicate key in object 'CartasDePorte'. The statement has been terminated. at 
                    'System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection) at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection) at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateOb

                    'pensá que el subnumerodefacturacion forma parte del UNIQUE, y al cambiarlo quizas pisas a alguien...
                    '-no debería! si..
                    '-y si ya había una carta con -1 en subnumerofacturacion????????? 
                    '-claro... entonces no aparece en el q2... y sería la original de la que estás corrigiendo acá... entonces tendrías que ponerle =1.
                    'ccc.SubnumeroDeFacturacion = -2
                    MandarMailDeError("Se intentará emparchar. Error en CorrectorSubnumeroFacturacion: Carta Porte " & ccc.IdCartaDePorte & " numero " & _
                                        ccc.NumeroCartaDePorte & " " & ccc.SubnumeroVagon & " " & ex.ToString)
                    ErrHandler.WriteError(ex.ToString)
                    Dim ccorig = db.CartasDePortes.Where(Function(x) x.NumeroCartaDePorte = ccc.NumeroCartaDePorte And x.SubnumeroVagon = ccc.SubnumeroVagon And x.SubnumeroDeFacturacion = -1).FirstOrDefault()
                    ccorig.SubnumeroDeFacturacion = 0
                    ccc.SubnumeroDeFacturacion = 1
                    Try
                        db.SubmitChanges()
                    Catch ex2 As Exception
                        MandarMailDeError("Falló el parche")
                        ErrHandler.WriteError(ex.ToString)
                    End Try

                End Try




            Next
        Catch ex As Exception
            ErrHandler.WriteError(ex.ToString)
        End Try

        db = Nothing



        If True Then
            'Esto corrige las que están mal duplicadas como 0 y -1 en el SubnumeroDeFacturacion

            '-anda mal y es ineficiente
            'ok, pero por qué anda mal? va bajando el contador del corrector?
            'el tema era el unique que no incluía la FechaAnulacion (ni U_numerorestringido, ni el index del superbuscador)
            'el tema era el unique que no incluía la FechaAnulacion (ni U_numerorestringido, ni el index del superbuscador)
            'el tema era el unique que no incluía la FechaAnulacion (ni U_numerorestringido, ni el index del superbuscador)
            'el tema era el unique que no incluía la FechaAnulacion (ni U_numerorestringido, ni el index del superbuscador)
            'el tema era el unique que no incluía la FechaAnulacion (ni U_numerorestringido, ni el index del superbuscador)
            'el tema era el unique que no incluía la FechaAnulacion (ni U_numerorestringido, ni el index del superbuscador)


            db = New LinqCartasPorteDataContext(Encriptar(SC))


            Dim q10 = (From cdp In db.CartasDePortes _
            Where (If(cdp.SubnumeroDeFacturacion, 0) = 0 Or If(cdp.SubnumeroDeFacturacion, 0) = -1) _
             And cdp.Anulada <> "SI" _
            Group cdp By _
                numerocartadeporte = cdp.NumeroCartaDePorte, _
                subnumerovagon = cdp.SubnumeroVagon _
            Into g = Group _
            Select New With { _
                .numerocartadeporte = numerocartadeporte, _
                .subnumerovagon = subnumerovagon, _
                .CantCartas = g.Count _
            }).Where(Function(i) i.CantCartas > 2).Distinct()
            ErrHandler.WriteError("Fuera de 2da etapa: faltan " & q10.Count)



            Dim q3 = (From cdp In db.CartasDePortes _
            Where (If(cdp.SubnumeroDeFacturacion, 0) = 0 Or If(cdp.SubnumeroDeFacturacion, 0) = -1) _
             And cdp.Anulada <> "SI" _
            Group cdp By _
                numerocartadeporte = cdp.NumeroCartaDePorte, _
                subnumerovagon = cdp.SubnumeroVagon _
            Into g = Group _
            Select New With { _
                .numerocartadeporte = numerocartadeporte, _
                .subnumerovagon = subnumerovagon, _
                .CantCartas = g.Count _
            }).Where(Function(i) i.CantCartas = 2).Distinct()
            'y si hay mas de 2?



            ErrHandler.WriteError("Corrector: faltan " & q3.Count)

            Dim q4 = q3.ToList.Take(100)

            For Each cdp In q4
                Dim ccc = db.CartasDePortes.Where(Function(x) x.NumeroCartaDePorte = cdp.numerocartadeporte And x.SubnumeroVagon = cdp.subnumerovagon And x.Anulada <> "SI").AsEnumerable
                If ccc.Count > 2 Then
                    Dim a = ccc.Where(Function(x) x.SubnumeroDeFacturacion = -1).FirstOrDefault
                    a.SubnumeroDeFacturacion = 10
                Else
                    If ccc(0).SubnumeroDeFacturacion = -1 Then ccc(0).SubnumeroDeFacturacion = 1
                    If ccc(1).SubnumeroDeFacturacion = -1 Then ccc(1).SubnumeroDeFacturacion = 1
                End If


            Next

            Try
                db.SubmitChanges()
            Catch ex As Exception

                MandarMailDeError("Falló el parche 2da etapa " + ex.ToString) ' + cdp.numerocartadeporte.ToString + " " + cdp.subnumerovagon.ToString + " " + ex.ToString)
                ErrHandler.WriteError(ex.ToString)

            End Try
        End If


        If False Then

            'falta buscar las que quedaron sin un original!!!

            Dim q5 = (From cdp In db.CartasDePortes _
                    Where If(cdp.SubnumeroDeFacturacion, 0) >= 0 _
                     And If(cdp.IdFacturaImputada, 0) = 0 _
                    Group cdp By _
                        numerocartadeporte = cdp.NumeroCartaDePorte, _
                        subnumerovagon = cdp.SubnumeroVagon _
                    Into g = Group _
                    Select New With { _
                        .numerocartadeporte = numerocartadeporte, _
                        .subnumerovagon = subnumerovagon, _
                        .CantCartas = g.Count, _
                        .IdCartaDePorte = g.Sum(Function(x) x.IdCartaDePorte) _
                    }).Select(Function(i) i.IdCartaDePorte).Distinct().ToList.Take(100)

            ErrHandler.WriteError("Corrector2: faltan " & q5.Count)


            Dim a5 = From x In q5 Order By x Select CStr(x)

            ErrHandler.WriteError(vbCrLf & Join(a5.ToArray, vbCrLf))
        End If


    End Sub


    Shared Function CartasConCopiaPendiente(q As IQueryable(Of CartasDePorte), ByRef mensajes As String) As IQueryable(Of CartasDePorte) ' este se queda con los pendientes, para mostrar en informe
        Dim rows = (From i In q _
                          Where If(i.SubnumeroDeFacturacion, -1) >= 0 And _
                               If(i.IdFacturaImputada, 0) = 0 And _
                               i.IdClienteAFacturarle Is Nothing)

        Return rows

    End Function

    Shared Sub CartasConCopiaPendiente(ByRef dt As DataTable, ByRef mensajes As String) 'este se queda con los pendientes, para mostrar en informe
        Dim rows = (From i In dt.AsEnumerable _
                  Where If(IsNull(i("SubnumeroDeFacturacion")), 0, i("SubnumeroDeFacturacion")) >= 0 And _
                       IsNull(i("IdClienteAFacturarle")) _
              )
        If rows.Any() Then dt = rows.CopyToDataTable() Else dt = dt.Clone


    End Sub

    Shared Sub FiltrarCartasConCopiaPendiente(ByRef dt As DataTable, ByRef mensajes As String) 'este se queda con los NO pendientes
        'http://stackoverflow.com/questions/656167/hitting-the-2100-parameter-limit-sql-server-when-using-contains

        'hacer que se llame al CorrectorSubnumeroFacturacion() 
        Try

            Dim l = (From i In dt.AsEnumerable _
                       Where If(IsNull(i("SubnumeroDeFacturacion")), 0, CInt(i("SubnumeroDeFacturacion"))) >= 0 And _
                             IsNull(i("IdClienteAFacturarle")) _
                Select New With { _
                        .IdCartaDePorte = CLng(If(i("IdCartaDePorte"), 0)), _
                        .NumeroCartaDePorte = CLng(If(i("NumeroCartaDePorte"), 0)), _
                        .SubnumeroVagon = If(IsNull(i("SubnumeroVagon")), 0, CInt(i("SubnumeroVagon"))), _
                        .SubnumeroDeFacturacion = If(IsNull(i("SubnumeroDeFacturacion")), 0, CInt(i("SubnumeroDeFacturacion"))) _
                                 } _
            ).ToList


            Dim rows = (From i In dt.AsEnumerable _
                        Where Not (If(IsNull(i("SubnumeroDeFacturacion")), 0, i("SubnumeroDeFacturacion")) >= 0 And _
                             IsNull(i("IdClienteAFacturarle"))) _
                    )
            If rows.Any() Then dt = rows.CopyToDataTable() Else dt = dt.Clone




            'Dim q = ConsultasLinq.CartasConCopiaSinAsignarLINQ(HFSC.Value)
            'q = q.Where(Function(c) l.Contains(c.IdCartaDePorte)).ToList()

            '

            'si se está mostrando mal, llamá al corrector
            If False Then
                'LogicaFacturacion.CorrectorSubnumeroFacturacion(hfcs.va)
            End If



            Dim o = (From i In l Select ( _
                "<a href=""CartaDePorte.aspx?Id=" & i.IdCartaDePorte.ToString() & """ target=""_blank"">" & i.NumeroCartaDePorte.ToString() & " " & i.SubnumeroVagon.ToString() & " /" & i.SubnumeroDeFacturacion.ToString() & "</a> " _
                    )).ToList.Take(500)

            If o.Count > 0 Then
                mensajes &= "<br/> Cartas con copia pendiente de asignar (maximo 500)  <br/> " & Join(o.ToArray(), " <br/>")
            End If

        Catch ex As Exception
            MandarMailDeError("Error en FiltrarCartasConCopiaPendiente. " & ex.ToString)
        End Try


    End Sub


    Shared Function TodasLasQueNoSonEntregadorWilliamsYavisarEnMensaje(SC As String) As IQueryable(Of CartasDePorte)
        Try

            Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


            Dim q = _
                    (From i In db.CartasDePortes Where If(i.SubnumeroDeFacturacion, 0) >= 0 And i.IdClienteAFacturarle Is Nothing _
                     And If(i.IdFacturaImputada, 0) = 0 And i.Anulada <> "SI")


            'efectivamente, no respeto ningun filtro... y parece que no basta conque el subnumero sea mayor 
            '    que cero para asegurarme de que sea una con duplicados
            '-ok, pero para lo primero, la culpa no es de esta funcion sino de quienes la llaman
            'Y si devuelvo un iqueriable, no debería recibir el db como parametro? -no parece haber problema con eso: http://stackoverflow.com/questions/534690/linq-to-sql-return-anonymous-type


            Return q
        Catch ex As Exception
            MandarMailDeError("Error en TodasLasQueNoSonEntregadorWilliamsYavisarEnMensaje. " & ex.ToString)
        End Try

    End Function

    Shared Sub FiltrarLasQueYaTienenClienteAQuienFacturarle(ByRef dt As DataTable, ByRef mensajes As String)

        'a menos que sea el mismo que me quieran asignar.......

        dt = DataTableWHERE(dt, "IdClienteAFacturarle is NULL or IdClienteAFacturarle<=0 or IdClienteAFacturarle=IdFacturarselaA")
        Dim dt2 = DataTableWHERE(dt, "NOT (IdClienteAFacturarle is NULL or IdClienteAFacturarle<=0 or IdClienteAFacturarle=IdFacturarselaA)")
        If (dt2.Rows.Count > 0) Then mensajes &= " <br/> Cartas con Cliente a Facturar ya asignado <br/>" & dt2.Rows.Count & " <br/>"

    End Sub


    Shared Sub FiltrarLasQueNoSonEntregadorWilliamsYavisarEnMensaje(ByRef dt As DataTable, ByRef mensajes As String)

        Try

            Dim l = (From i In dt.AsEnumerable _
                        Where If(IsNull(i("SubnumeroDeFacturacion")), 0, i("SubnumeroDeFacturacion")) <= 0 And _
                            If(IsNull(i("IdClienteEntregador")), 12454, i("IdClienteEntregador")) <> 12454 _
                          And If(IsNull(i("IdClienteEntregador")), 12454, i("IdClienteEntregador")) <> 5822 _
                Select New With { _
                        .IdCartaDePorte = CLng(i("IdCartaDePorte")), _
                        .NumeroCartaDePorte = CLng(i("NumeroCartaDePorte")), _
                        .SubnumeroVagon = CInt(i("SubnumeroVagon")) _
                                 } _
            ).ToList


            Dim rows = From i In dt.AsEnumerable _
                       Where Not (If(IsNull(i("IdClienteEntregador")), 12454, i("IdClienteEntregador")) <> 12454 _
                          And If(IsNull(i("IdClienteEntregador")), 12454, i("IdClienteEntregador")) <> 5822)


            If rows.Any() Then dt = rows.CopyToDataTable() Else dt = dt.Clone




            'Dim q = ConsultasLinq.CartasConEntregadorExternoLINQ(HFSC.Value)
            'q = q.Where(Function(c) If(c.SubnumeroDeFacturacion, 0) <= 0 And l.Contains(c.IdCartaDePorte)).ToList


            Dim o = (From i In l _
                     Select ( _
                "<a href=""CartaDePorte.aspx?Id=" & i.IdCartaDePorte & """ target=""_blank"">" & i.NumeroCartaDePorte.ToString() & " " & i.SubnumeroVagon.ToString() & "</a> " _
                    )).ToList

            If o.Count > 0 Then
                mensajes &= " <br/> Cartas con Entregador externo <br/>" & Join(o.ToArray(), " <br/>")
            End If

            'For Each x In q
            '    Dim r = (From i In dt.AsEnumerable Where CInt(i("IdCartaDePorte")) = x.)
            '    dt.Rows.Remove(r)
            'Next






            'CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
            '                    "", "", "", 1, 0, _
            '                    estadofiltro, "", idVendedor, idCorredor, _
            '                    idDestinatario, idIntermediario, _
            '                    idRComercial, idArticulo, idProcedencia, idDestino, _
            '                                                      IIf(cmbCriterioWHERE.SelectedValue = "todos", EntidadManager.FiltroANDOR.FiltroAND, EntidadManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
            '                     Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
            '                    Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
            '                     cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, True, txtContrato.Text, , idClienteAuxiliar)
        Catch ex As Exception
            MandarMailDeError("Error en FiltrarLasQueNoSonEntregadorWilliamsYavisarEnMensaje. " & ex.ToString)

        End Try


    End Sub




    Shared Function RecalcGastosAdminDeCambioDeCartaUsandoTablaTemporal(ByVal IdTanda As Integer, ByRef dtCartas As DataTable, _
                                                     ByRef dtRenglonesManuales As DataTable, ByVal hfsc As String) As DataTable

        'Return Nothing


        Dim dtGastosAdmin As DataTable

        If IsNothing(dtCartas) Then Return Nothing

        Dim IdArticuloGastoAdministrativo = GetIdArticuloParaCambioDeCartaPorte(hfsc)

        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8526





        Dim ids As Integer = IdTanda


        Dim db As New LinqCartasPorteDataContext(Encriptar(hfsc))

        'no sé si agrupar tambien por ClienteSeparado....          ' , ClienteSeparado = i("ClienteSeparado") Into Group
        Dim GastoAdmin = From i In db.wTempCartasPorteFacturacionAutomaticas _
                    Where i.IdSesion = ids And i.AgregaItemDeGastosAdministrativos = "SI" _
                         Group By i.IdFacturarselaA, i.FacturarselaA Into Group _
                         Select IdFacturarselaA, FacturarselaA, cantidadGastosAdministrativos = Group.Count


        Dim aaGastoAdmin = From i In db.wTempCartasPorteFacturacionAutomaticas Where i.AgregaItemDeGastosAdministrativos = "SI"



        If dtRenglonesManuales Is Nothing Then dtRenglonesManuales = dtCartas.Clone
        dtGastosAdmin = dtCartas.Clone

        For Each r In GastoAdmin

            Dim PrecioArticuloGastoAdministrativo = ListaPreciosManager.Tarifa(hfsc, r.IdFacturarselaA, IdArticuloGastoAdministrativo)
            '¿http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8526


            'y si ya existen? -borralos todos 'dtRenglonesManuales = DataTableWHERE(dtRenglonesManuales, "Producto<>" & IdArticuloGastoAdministrativo)
            'dtRenglonesManuales.Rows.Find("Id )




            Dim match = dtRenglonesManuales.Select("IdFacturarselaA=" & r.IdFacturarselaA & " AND  IdArticulo=" & IdArticuloGastoAdministrativo)
            Dim nr As DataRow

            If match.Count > 0 Then
                nr = match(0)
            Else
                nr = dtRenglonesManuales.NewRow
            End If

            nr.Item("FacturarselaA") = r.FacturarselaA
            nr.Item("IdFacturarselaA") = r.IdFacturarselaA
            nr.Item("TarifaFacturada") = PrecioArticuloGastoAdministrativo
            nr.Item("KgNetos") = r.cantidadGastosAdministrativos
            nr.Item("Producto") = NombreArticulo(hfsc, IdArticuloGastoAdministrativo)
            nr.Item("IdArticulo") = IdArticuloGastoAdministrativo


            If match.Count > 0 Then
                '
                Dim newRow = dtGastosAdmin.NewRow()
                newRow.ItemArray = nr.ItemArray
                dtGastosAdmin.Rows.Add(newRow)
            Else
                'dtRenglonesManuales.Rows.Add(nr)


                Dim newRow = dtGastosAdmin.NewRow()
                newRow.ItemArray = nr.ItemArray
                dtGastosAdmin.Rows.Add(newRow)
            End If

        Next



        Return dtGastosAdmin

    End Function







    Shared Function RecalcGastosAdminDeCambioDeCarta(ByRef dtCartas As DataTable, _
                                                     ByRef dtRenglonesManuales As DataTable, ByVal hfsc As String) As DataTable

        'Return Nothing

        Dim dtGastosAdmin As DataTable

        If IsNothing(dtCartas) Then Return Nothing

        Dim IdArticuloGastoAdministrativo = GetIdArticuloParaCambioDeCartaPorte(hfsc)

        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8526




        'no sé si agrupar tambien por ClienteSeparado....          ' , ClienteSeparado = i("ClienteSeparado") Into Group
        Dim GastoAdmin = From i In dtCartas.AsEnumerable _
                         Where iisNull(i("AgregaItemDeGastosAdministrativos"), "NO") = "SI" _
                         Group By IdFacturarselaA = i("IdFacturarselaA"), FacturarselaA = i("FacturarselaA") Into Group _
                         Select IdFacturarselaA, FacturarselaA, cantidadGastosAdministrativos = Group.Count



        If dtRenglonesManuales Is Nothing Then dtRenglonesManuales = dtCartas.Clone
        dtGastosAdmin = dtCartas.Clone

        For Each r In GastoAdmin

            Dim PrecioArticuloGastoAdministrativo = ListaPreciosManager.Tarifa(hfsc, r.IdFacturarselaA, IdArticuloGastoAdministrativo)
            '¿http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8526


            'y si ya existen? -borralos todos 'dtRenglonesManuales = DataTableWHERE(dtRenglonesManuales, "Producto<>" & IdArticuloGastoAdministrativo)
            'dtRenglonesManuales.Rows.Find("Id )




            Dim match = dtRenglonesManuales.Select("IdFacturarselaA=" & r.IdFacturarselaA & " AND  IdArticulo=" & IdArticuloGastoAdministrativo)
            Dim nr As DataRow

            If match.Count > 0 Then
                nr = match(0)
            Else
                nr = dtRenglonesManuales.NewRow
            End If

            nr.Item("FacturarselaA") = r.FacturarselaA
            nr.Item("IdFacturarselaA") = r.IdFacturarselaA
            nr.Item("TarifaFacturada") = PrecioArticuloGastoAdministrativo
            nr.Item("KgNetos") = r.cantidadGastosAdministrativos
            nr.Item("Producto") = NombreArticulo(hfsc, IdArticuloGastoAdministrativo)
            nr.Item("IdArticulo") = IdArticuloGastoAdministrativo


            If match.Count > 0 Then
                '
                Dim newRow = dtGastosAdmin.NewRow()
                newRow.ItemArray = nr.ItemArray
                dtGastosAdmin.Rows.Add(newRow)
            Else
                'dtRenglonesManuales.Rows.Add(nr)


                Dim newRow = dtGastosAdmin.NewRow()
                newRow.ItemArray = nr.ItemArray
                dtGastosAdmin.Rows.Add(newRow)
            End If

        Next



        Return dtGastosAdmin

    End Function

    Shared Function ListadoManualConTablaTemporal( _
                        ByVal sc As String, ByVal sLista As String, ByVal sWHEREadicional As String, ByVal optFacturarA As Long, _
                        ByVal txtFacturarATerceros As String, ByVal HFSC As String, ByVal txtTitular As String, ByVal txtCorredor As String, _
                        ByVal txtDestinatario As String, ByVal txtIntermediario As String, ByVal txtRcomercial As String, _
                        ByVal txt_AC_Articulo As String, ByVal txtProcedencia As String, ByVal txtDestino As String, ByVal txtBuscar As String, _
                        ByVal cmbCriterioWHERE As String, ByVal cmbmodo As String, ByVal optDivisionSyngenta As String, _
                        ByVal txtFechaDesde As String, ByVal txtFechaHasta As String, ByVal cmbPuntoVenta As String, ByVal sesionId As String, _
                        ByVal startRowIndex As Long, ByVal maximumRows As Long, ByVal txtClienteAuxiliar As String, ByRef ms As String, ByVal txtFacturarA As String) As DataTable

        Dim dt As DataTable

        If False Then
            'dt = EntidadManager.ExecDinamico(sc, SQL_ListaDeCDPsFiltradas2(" AND IdCartaDePorte IN (" & sLista & ") ", optFacturarA, _
            '                        txtFacturarATerceros, sc, _
            '                        txtTitular, txtCorredor, txtDestinatario, _
            '                        txtIntermediario, txtRcomercial, txt_AC_Articulo, txtProcedencia, txtDestino, txtBuscar, cmbCriterioWHERE, _
            '                        cmbmodo, optDivisionSyngenta, txtFechaDesde, txtFechaHasta, cmbPuntoVenta, , txtClienteAuxiliar))
            'Debug.Print(dt.Rows.Count)
            'Return dt

        End If





        Try
            EntidadManager.ExecDinamico(sc, " IF object_id('tempdb..#TEMPTAB') IS NOT NULL    BEGIN     DROP TABLE #TEMPTAB    END")
        Catch ex As Exception
            ErrHandler.WriteError("explota el drop table. guarda!, porque tarda mucho tiempo en revisar esto!!!")
        End Try


        Dim sInsertEnTablaTemporal As String


        'http://stackoverflow.com/questions/1009008/temporary-tables-in-linq-anyone-see-a-problem-with-this


        sInsertEnTablaTemporal = "create table #temptab (IdCarta int primary key not null)    " & vbCrLf

        If False Then
            ' metodo 1 
            'http://stackoverflow.com/q/5375997/60485
            Dim sa = "insert into  #temptab  (IdCarta) values (" & iisNull(sLista, "-99").ToString().Replace(",", "); insert into  #temptab  (IdCarta) values (") & ");" 'esto no se puede hacer en SQL2000

            'EntidadManager.ExecDinamico(sc, "insert into  #temptab  (IdCarta) values " & sa)

            sInsertEnTablaTemporal &= "  " & sa & vbCrLf
        ElseIf False Then
            ' metodo 2
            '            Dim li = ListaDeCDPTildadosEnEl1erPaso()

            'For Each i As Long In tildadosEnPrimerPaso
            '    sInsertEnTablaTemporal &= "insert into  #temptab  (IdCarta) values (" & i & ")" & vbCrLf
            'Next

            EntidadManager.ExecDinamico(sc, sInsertEnTablaTemporal)

        End If


        'Dim sJoinTablaTemporal = "" '" INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta"










        Dim sJoinTablaTemporal As String
        Dim s As String

        If False Then
            'sJoinTablaTemporal = SQL_ListaDeCDPsFiltradas2("", _
            '                                         optFacturarA, txtFacturarATerceros, HFSC, txtTitular, txtCorredor, txtDestinatario, _
            '                                         txtIntermediario, txtRcomercial, txt_AC_Articulo, txtProcedencia, txtDestino, txtBuscar, _
            '                                         cmbCriterioWHERE, cmbmodo, optDivisionSyngenta, txtFechaDesde, txtFechaHasta, cmbPuntoVenta, _
            '                                         " JOIN #temptab as TEMPORAL ON (CDP.IdCartaDePorte = TEMPORAL.IdCarta)  ", txtClienteAuxiliar)
            's = sInsertEnTablaTemporal & sJoinTablaTemporal
        Else


            sJoinTablaTemporal = CartaDePorteManager.SQL_ListaDeCDPsFiltradas2("", _
                                                 optFacturarA, txtFacturarATerceros, HFSC, txtTitular, txtCorredor, txtDestinatario, _
                                                 txtIntermediario, txtRcomercial, txt_AC_Articulo, txtProcedencia, txtDestino, txtBuscar, _
                                                 cmbCriterioWHERE, cmbmodo, optDivisionSyngenta, txtFechaDesde, txtFechaHasta, cmbPuntoVenta, _
                                                  " JOIN wGrillaPersistencia as TEMPORAL ON (CDP.IdCartaDePorte = TEMPORAL.IdRenglon) " & _
                                                  "             AND TEMPORAL.Sesion=" & _c(sesionId), txtClienteAuxiliar, txtFacturarA)



            s = sJoinTablaTemporal

        End If






        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////paginado sin usar ROW_NUMBER (que no está en sql2000)
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////

        Dim s0, s1, s2, s30, s3, s4 As String

        s0 = "DECLARE @first_id bigint" & vbCrLf 'le puse bigint porque numerocartadeporte es bigint

        ' Get the first employeeID for our page of records 
        s1 = "SET ROWCOUNT " & startRowIndex & vbCrLf

        s2 = "SELECT @first_id = NumeroCartaDePorte  FROM (" + sJoinTablaTemporal + ") as A ORDER BY  NumeroCartaDePorte ASC, FacturarselaA ASC " & vbCrLf '+ " ORDER BY IdCartaDePorte DESC"



        '-- Now, set the row count to MaximumRows and get
        '-- all records >= @first_id
        s30 = "SET ROWCOUNT " & maximumRows & vbCrLf


        'llamo otra vez al select, esta
        s3 = "SELECT * FROM (" + sJoinTablaTemporal + ") as A " & _
             "WHERE NumeroCartaDePorte >= @first_id " + " ORDER BY  NumeroCartaDePorte ASC, FacturarselaA ASC " & vbCrLf '+


        'pero y si no quiero ordenar por idcartadeporte?????
        'pero y si no quiero ordenar por idcartadeporte?????
        'pero y si no quiero ordenar por idcartadeporte?????
        'pero y si no quiero ordenar por idcartadeporte?????
        'bueno, tenes que usar como índice a lo que estes usando como orden dentro del select principal (en este caso, 
        ' estas ordenando en SQL_ListaDeCDPsFiltradas por: ORDER BY NumeroCartaDePorte ASC, FacturarselaA ASC 


        s4 = "SET ROWCOUNT 0" & vbCrLf


        's = s0 & s1 & s2 + s30 + s3 + s4
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////



        Try



            'http://support.microsoft.com/kb/288095
            'Se produce un desbordamiento de pila cuando ejecuta una consulta que contenga un gran número de argumentos dentro de un IN o una cláusula NOT IN en SQL Server


            'generarTablaParaModosNoAutomaticos()

            Debug.Print(s)
            dt = EntidadManager.ExecDinamico(sc, s)






            '///////////////////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////////////////
            'filtradores
            'Dim ms As String = ""

            If True Then
                SoloMostrarElOriginalDeLosDuplicados(dt, ms)
                FiltrarCartasConCopiaPendiente(dt, ms)
                FiltrarLasQueNoSonEntregadorWilliamsYavisarEnMensaje(dt, ms)
                FiltrarLasQueYaTienenClienteAQuienFacturarle(dt, ms)
            End If



            '///////////////////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////////////////


        Catch ex As Exception
            ErrHandler.WriteError(ex)
            Throw
        End Try






        'hago el filtro
        Try
            EntidadManager.ExecDinamico(sc, "IF object_id('tempdb..#TEMPTAB') IS NOT NULL    BEGIN     DROP TABLE #TEMPTAB    END")

        Catch ex As Exception
            ErrHandler.WriteError(ex)
        End Try



        Return dt

    End Function





    Shared Sub generarTablaParaModosNoAutomaticos(ByVal sc As String, ByVal ViewState As System.Web.UI.StateBag, ByVal sLista As String, ByVal sWHEREadicional As String, ByVal optFacturarA As Long, _
                        ByVal txtFacturarATerceros As String, ByVal HFSC As String, ByVal txtTitular As String, ByVal txtCorredor As String, _
                        ByVal txtDestinatario As String, ByVal txtIntermediario As String, ByVal txtRcomercial As String, _
                        ByVal txt_AC_Articulo As String, ByVal txtProcedencia As String, ByVal txtDestino As String, ByVal txtBuscar As String, _
                        ByVal cmbCriterioWHERE As String, ByVal cmbmodo As String, ByVal optDivisionSyngenta As String, ByVal txtFechaDesde As String, ByVal txtFechaHasta As String, ByVal cmbPuntoVenta As String, _
                         ByVal sesionId As String, ByVal startRowIndex As Long, ByVal maximumRows As Long, ByVal txtclienteauxiliar As String, ByRef sErrores As String, txtFacturarA As String, agruparArticulosPor As String)


        Try



            Dim tildadosEnPrimerPaso As String() = Split(sLista, ",")
            ' = 
            'Dim a = Array.ConvertAll(Of String, Decimal)(tildadosEnPrimerPaso, Convert.ToDecimal) ' ViewState("ListaIDsLongs")       'ListaDeCDPTildadosEnEl1erPaso()
            Dim tildadosEnPrimerPasoLongs As Generic.List(Of Integer) = tildadosEnPrimerPaso.Select(Function(itemID) CInt(IIf(IsNumeric(itemID), itemID, -1))).ToList

            Dim lista As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult)

            Dim dtAutomatico As DataTable

            Dim db As New LinqCartasPorteDataContext(Encriptar(sc))





            'lista = (From cdp In db.wCartasDePorte_TX_FacturacionAutomatica(CInt(cmbPuntoVenta.Text)) _
            '          Where cdp.SubnumeroDeFacturacion > 0 And tildadosEnPrimerPasoLongs.Contains(CLng(iisNull(cdp.IdCartaOriginal, -1))) _
            '          ).ToList

            Dim dtNoAutomatico As DataTable = ListadoManualConTablaTemporal(sc, sLista, "", optFacturarA, _
                                                        txtFacturarATerceros, HFSC, txtTitular, txtCorredor, _
                                                        txtDestinatario, txtIntermediario, txtRcomercial, txt_AC_Articulo, _
                                                        txtProcedencia, txtDestino, txtBuscar, cmbCriterioWHERE, _
                                                        cmbmodo, optDivisionSyngenta, txtFechaDesde, txtFechaHasta, _
                                                        cmbPuntoVenta, sesionId, 0, 1012012, txtclienteauxiliar, sErrores, txtFacturarA)






            lista = (From cdp In dtNoAutomatico.AsEnumerable _
                      Where tildadosEnPrimerPasoLongs.Contains(If(cdp("IdCartaDePorte"), -1)) _
                            Or (iisNull(cdp("SubnumeroDeFacturacion"), 0) > 0) _
                            Select New wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult With { _
                                .ColumnaTilde = CInt(iisNull(cdp("ColumnaTilde"), 0)), _
                                .IdCartaDePorte = CInt(iisNull(cdp("IdCartaDePorte"))), _
                                .IdArticulo = CInt(iisNull(cdp("IdArticulo"))), _
                                .NumeroCartaDePorte = iisNull(cdp("NumeroCartaDePorte"), 0), _
                                .SubNumeroVagon = CInt(iisNull(cdp("SubNumeroVagon"), 0)), _
                                .SubnumeroDeFacturacion = CInt(iisNull(cdp("SubnumeroDeFacturacion"), 0)), _
                                .FechaArribo = CDate(iisNull(cdp("FechaArribo"), Today)), _
                                .FechaDescarga = CDate(iisNull(cdp("FechaDescarga"), Today)), _
                                .FacturarselaA = CStr(iisNull(cdp("FacturarselaA"))), _
                                .IdFacturarselaA = CInt(iisNull(cdp("IdFacturarselaA"), -1)), _
                                .Confirmado = iisNull(cdp("Confirmado")), _
                                .IdCodigoIVA = CInt(iisNull(cdp("IdCodigoIVA"), -1)), _
                                .CUIT = CStr(iisNull(cdp("CUIT"))), _
                                .ClienteSeparado = CStr(iisNull(cdp("ClienteSeparado"))), _
                                .TarifaFacturada = CDec(iisNull(cdp("TarifaFacturada"), 0)), _
                                .Producto = CStr(iisNull(cdp("Producto"))), _
                                .KgNetos = CDec(iisNull(cdp("KgNetos"))), _
                                .IdCorredor = CInt(iisNull(cdp("IdCorredor"), -1)), _
                                .IdTitular = CInt(iisNull(cdp("IdTitular"), -1)), _
                                .IdIntermediario = CInt(iisNull(cdp("IdIntermediario"), -1)), _
                                .IdRComercial = CInt(iisNull(cdp("IdRComercial"), -1)), _
                                .IdDestinatario = CInt(iisNull(cdp("IdDestinatario"), -1)), _
                                .Titular = CStr(iisNull(cdp("Titular"))), _
                                .Intermediario = CStr(iisNull(cdp("Intermediario"))), _
                                .R__Comercial = CStr(iisNull(cdp("R. Comercial"))), _
                                .Corredor = CStr(iisNull(cdp("Corredor "))), _
                                .Destinatario = CStr(iisNull(cdp("Destinatario"))), _
                                .DestinoDesc = CStr(iisNull(cdp("DestinoDesc"))), _
                                .Procedcia_ = CStr(iisNull(cdp("Procedcia."))), _
                                .IdDestino = CInt(iisNull(cdp("IdDestino"), -1)), _
                                .AgregaItemDeGastosAdministrativos = CStr(iisNull(cdp("AgregaItemDeGastosAdministrativos"))) _
                            } _
                              ).ToList




            'tengo q incluir los explicitos duplicados porque solo tengo el ID de los originales para filtrar. Lo filtro luego, viendo si está el original de ellos



            ''agrego a la lista de tildes los duplicados explicitos
            ''quitar los duplicados explicitos sin original
            'Dim duplicadosexplicitos = From cdp In lista Where cdp.SubnumeroDeFacturacion > 0 Select cdp.NumeroCartaDePorte
            ''      Join cdpjoin In lista On cdp.NumeroCartaDePorte Equals cdpjoin.NumeroCartaDePorte

            'Dim duplicadosexplicitosIncluidos = From cdp In lista _
            '                                  Where duplicadosexplicitos.Contains(cdp.NumeroCartaDePorte) _
            '                                        And Not cdp.SubnumeroDeFacturacion > 0 _
            '                                        Select cdp.IdCartaDePorte


            'lista = (From cdp In lista _
            '          Where tildadosEnPrimerPasoLongs.Contains(CLng(iisNull(cdp.IdCartaDePorte, -1))) _
            '                Or cdp.SubnumeroDeFacturacion > 0 And  _
            '          ).ToList








            '¿como hacer la union de la consulta de titular, y el filtro de cartas problematicas, así queda el skiptake al final

            Debug.Print(lista.Count)



            'ejecutar inmediatamente LINQ usando la conversion a .ToList()
            'http://blogs.msdn.com/b/charlie/archive/2007/12/09/deferred-execution.aspx
            Dim IdsEnElAutomatico = (From i In lista Select i.IdCartaDePorte).ToList
            Debug.Print(IdsEnElAutomatico.ToString)


            'como agregar las cartas sin automatico posible? haces un filtro de lo que vino con las Id tildadas en el primer paso, antes de filtrar por repetido. Si no vino nada, es que no hay automatico.
            Dim IdcartasSinAutomaticoEncontrado = (From i In tildadosEnPrimerPasoLongs Select id = CStr(i) _
                                                 Where Not IdsEnElAutomatico.Contains(CLng(id))).ToArray

            If IdcartasSinAutomaticoEncontrado.Count > 0 Then

                Dim sWhere = " AND IdCartaDePorte IN (" & Join(IdcartasSinAutomaticoEncontrado, ",") & ")"
                '///////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////

                Dim dtForzadasAlTitular = SQLSTRING_FacturacionCartas_por_Titular(sWhere, sc, sesionId)


                For Each cdp In dtForzadasAlTitular.Rows
                    Dim x As New wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult
                    With x
                        .ColumnaTilde = CInt(cdp("ColumnaTilde"))
                        .IdCartaDePorte = CInt(iisNull(cdp("IdCartaDePorte")))
                        .IdArticulo = CInt(iisNull(cdp("IdArticulo")))
                        .NumeroCartaDePorte = iisNull(cdp("NumeroCartaDePorte"))
                        Try
                            .SubNumeroVagon = CInt(iisNull(cdp("SubNumeroVagon")))
                        Catch ex As Exception
                            'raro
                            ErrHandler.WriteError(ex)
                        End Try

                        .SubnumeroDeFacturacion = CInt(iisNull(cdp("SubnumeroDeFacturacion"), 0))
                        .FechaArribo = CDate(iisNull(cdp("FechaArribo")))
                        .FechaDescarga = CDate(iisNull(cdp("FechaDescarga")))
                        .FacturarselaA = CStr(iisNull(cdp("FacturarselaA")))
                        .IdFacturarselaA = CInt(iisNull(cdp("IdFacturarselaA")))
                        .Confirmado = iisNull(cdp("Confirmado"))
                        .IdCodigoIVA = CInt(iisNull(cdp("IdCodigoIVA"), -1))
                        .CUIT = CStr(iisNull(cdp("CUIT")))
                        .ClienteSeparado = CStr(iisNull(cdp("ClienteSeparado")))
                        .TarifaFacturada = CDec(iisNull(cdp("TarifaFacturada"), 0))
                        .Producto = CStr(iisNull(cdp("Producto")))
                        .KgNetos = CDec(iisNull(cdp("KgNetos")))
                        .IdCorredor = CInt(iisNull(cdp("IdCorredor")))
                        .IdTitular = CInt(iisNull(cdp("IdTitular")))
                        .IdIntermediario = CInt(iisNull(cdp("IdIntermediario"), -1))
                        .IdRComercial = CInt(iisNull(cdp("IdRComercial"), -1))
                        .IdDestinatario = CInt(iisNull(cdp("IdDestinatario")))
                        .Titular = CStr(iisNull(cdp("Titular")))
                        .Intermediario = CStr(iisNull(cdp("Intermediario")))
                        .R__Comercial = CStr(iisNull(cdp("R. Comercial")))
                        .Corredor = CStr(iisNull(cdp("Corredor ")))
                        .Destinatario = CStr(iisNull(cdp("Destinatario")))
                        .DestinoDesc = CStr(iisNull(cdp("DestinoDesc")))
                        .Procedcia_ = CStr(iisNull(cdp("Procedcia.")))
                        .IdDestino = CInt(iisNull(cdp("IdDestino")))
                        .AgregaItemDeGastosAdministrativos = CStr(iisNull(cdp("AgregaItemDeGastosAdministrativos")))
                        lista.Add(x)
                    End With
                Next

            End If



            'consulta 8413
            '        * Ordenar alfabeticamente por la columna "Facturarle a"
            '       * Poner las que tienen tarifa en 0 al principio

            'Dim unionAutomaticoConTitularesDefault = (From i In lista).Union( _
            '                From cdp In dtForzadasAlTitular.AsEnumerable _
            '                Select _
            '                ColumnaTilde = CInt(cdp("ColumnaTilde")), _
            '                IdCartaDePorte = CInt(iisNull(cdp("IdCartaDePorte"))), _
            '                IdArticulo = CInt(iisNull(cdp("IdArticulo"))), _
            '                NumeroCartaDePorte = iisNull(cdp("NumeroCartaDePorte")), _
            '                SubNumeroVagon = CInt(iisNull(cdp("SubNumeroVagon"))), _
            '                SubnumeroDeFacturacion = CInt(iisNull(cdp("SubnumeroDeFacturacion"))), _
            '                FechaArribo = CDate(iisNull(cdp("FechaArribo"))), _
            '                FechaDescarga = CDate(iisNull(cdp("FechaDescarga"))), _
            '                FacturarselaA = CDate(iisNull(cdp("FacturarselaA"))), _
            '                IdFacturarselaA = CInt(iisNull(cdp("IdFacturarselaA"))), _
            '                Confirmado = iisNull(cdp("Confirmado")), _
            '                IdCodigoIVA = CInt(iisNull(cdp("IdCodigoIVA"))), _
            '                CUIT = CStr(iisNull(cdp("CUIT"))), _
            '                ClienteSeparado = CStr(iisNull(cdp("ClienteSeparado"))), _
            '                TarifaFacturada = iisNull(cdp("wTarifaWilliams")), _
            '                Producto = CStr(iisNull(cdp("Producto"))), _
            '                KgNetos = CDec(iisNull(cdp("KgNetos"))), _
            '                IdCorredor = CInt(iisNull(cdp("IdCorredor"))), _
            '                IdTitular = CInt(iisNull(cdp("IdTitular"))), _
            '                IdIntermediario = CInt(iisNull(cdp("IdIntermediario"))), _
            '                IdRComercial = CInt(iisNull(cdp("IdRComercial"))), _
            '                IdDestinatario = CInt(iisNull(cdp("IdDestinatario"))), _
            '                Titular = CStr(iisNull(cdp("Titular"))), _
            '                Intermediario = CStr(iisNull(cdp("Intermediario"))), _
            '                R__Comercial = CStr(iisNull(cdp("R__Comercial"))), _
            '                Corredor_ = CStr(iisNull(cdp("Corredor_"))), _
            '                Destinatario = CStr(iisNull(cdp("Destinatario"))), _
            '                DestinoDesc = CStr(iisNull(cdp("DestinoDesc"))), _
            '                Procedcia_ = CStr(iisNull(cdp("Procedcia_"))), _
            '                IdDestino = CInt(iisNull(cdp("IdDestino"))) _
            '                )



            'dtAutomatico = DataTableUNION(dtAutomatico, dtForzadasAlTitular)



            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////
            '* Los Movimientos que sean Embarques (solo los embarques) se facturarán como una Carta de Porte más. 
            'Tomar el cereal, la cantidad de Kg y el Destinatario para facturar.

            'AgregarEmbarques(lista, sc, desde, hasta, -1)

            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////

            'RecalcGastosAdminDeCambioDeCartaUsandoTablaTemporal(lista, SC, dt, dtViewstateRenglonesManuales)

            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////





            '* Nueva función en Facturación Automática: "Facturarle al Corredor". Agregar un tilde en los clientes con ese nombre. En el Automático, las Cartas de Porte que corresponda facturarle a estos clientes se le facturarán al Corredor de cada Carta de Porte

            ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor(lista, sc)



            'hay que hacer un update de la lista por si se derivó a un corredor?
            '-parece ser que, al derivar al corredor, no viene la tarifa.
            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////



            Dim slinks As String
            lista = LinksDeCartasConflictivasDelAutomatico(lista, slinks, sc)

            slinks &= VerificarClientesFacturables(lista)

            ViewState("sLinks") = slinks


            EmparcharClienteSeparadoParaCasosQueSuperenUnMontoDeterminado(lista, sc)
            EmparcharClienteSeparadoParaFacturasQueSuperanCantidadDeRenglones(lista, optFacturarA, agruparArticulosPor, sc, "")

            PostProcesoFacturacion_ReglaExportadores(lista, sc)





            Dim qqqq = lista.Where(Function(x) x.ClienteSeparado <> "").ToList()

            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            'excluir (del modo no automático) las que tengan facturación explicita 
            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9323
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            'Dim copialista As New Generic.List(Of    wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult)(lista)

            'For Each i In copialista
            '    If i.IdFacturarselaA > 0 Then
            '        lista.Find()
            '    End If
            'Next

            'lista = (From i In lista Where Not i.IdClienteAFacturarle > 0).ToList

            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            'guardo los datos temporales
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            Randomize()
            ViewState("pagina") = 1
            ViewState("IdTanda") = CInt(Rnd() * 10000)

            Dim c = ExecDinamico(sc, "select count(*) from wTempCartasPorteFacturacionAutomatica")
            If c.Rows(0).Item(0) > 40000 Then
                ExecDinamico(sc, "DELETE wTempCartasPorteFacturacionAutomatica")
            End If


            Dim dt = ExecDinamico(sc, "SELECT * FROM wTempCartasPorteFacturacionAutomatica where 1=0")

            Dim l As New Generic.List(Of wTempCartasPorteFacturacionAutomatica)
            For Each x In lista
                Dim a = New wTempCartasPorteFacturacionAutomatica
                a.IdSesion = ViewState("IdTanda")

                a.IdCartaDePorte = x.IdCartaDePorte
                a.IdFacturarselaA = x.IdFacturarselaA
                a.TarifaFacturada = x.TarifaFacturada
                a.ClienteSeparado = x.ClienteSeparado
                a.ColumnaTilde = x.ColumnaTilde
                a.Confirmado = x.Confirmado
                a.Corredor = x.Corredor
                a.Corredor = x.ClienteSeparado
                a.FacturarselaA = Left(iisNull(x.FacturarselaA, ""), 50) 'esto puede traer problemas?
                a.KgNetos = iisNull(x.KgNetos, 0)
                a.DestinoDesc = x.DestinoDesc
                a.NumeroCartaDePorte = iisNull(x.NumeroCartaDePorte, -10)
                a.SubNumeroVagon = x.SubNumeroVagon
                a.SubnumeroDeFacturacion = x.SubnumeroDeFacturacion
                a.FechaArribo = x.FechaArribo
                a.FechaDescarga = x.FechaDescarga
                a.Producto = x.Producto
                a.IdArticulo = x.IdArticulo
                a.IdCodigoIVA = x.IdCodigoIVA
                a.CUIT = x.CUIT
                a.IdDestino = x.IdDestino
                a.Procedcia = x.Procedcia_
                a.Destinatario = x.Destinatario
                a.Titular = Left(x.Titular, 50)
                a.RComercial = x.R__Comercial
                a.IdIntermediario = x.IdIntermediario
                a.IdCorredor = x.IdCorredor
                a.IdTitular = x.IdTitular
                a.IdRComercial = x.IdRComercial
                a.IdIntermediario = x.IdIntermediario
                a.IdRComercial = x.IdRComercial

                a.AgregaItemDeGastosAdministrativos = x.AgregaItemDeGastosAdministrativos

                ' l.Add(a) 'con linq
                dt.Rows.Add(Nothing, a.IdSesion, x.IdCartaDePorte) 'con datatable
            Next


            'se podría usar bulkCopy http://msdn.microsoft.com/en-us/library/system.data.sqlclient.sqlbulkcopy.aspx
            ' db.wTempCartasPorteFacturacionAutomaticas.InsertAllOnSubmit(l)
            ' db.SubmitChanges()


            If False Then 'con el datatable no anduvo mas rapido
                Dim myConnection = New SqlConnection(Encriptar(sc))
                myConnection.Open()
                Dim adapterForTable1 = New SqlDataAdapter("select * from  wTempCartasPorteFacturacionAutomatica ", myConnection)
                Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
                'si te tira error acá, ojito con estar usando el dataset q usaste para el 
                'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update
                adapterForTable1.Update(dt)
            End If

            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////


            'Dim liston = (From i In lista Select i, IdSesion = ViewState("IdTanda")).ToList

            'Dim listaConOrden = (From i In lista Order By (IIf(i.TarifaFacturada = 0, " ", "") & i.FacturarselaA) Ascending).ToList

            For Each r In lista
                r.Titular = Left(r.Titular, 50)
                r.FacturarselaA = Left(r.FacturarselaA, 50)
            Next

            Dim dtlista As DataTable = ToDataTableNull(lista)
            dtlista.Columns.Remove("IdCartaOriginal")

            Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            With dc
                .ColumnName = "IdSesion"
                .DataType = System.Type.GetType("System.Int32")
                .DefaultValue = ViewState("IdTanda")
            End With
            dtlista.Columns.Add(dc)
            'For Each r In dtlista
            '    r("IdSesion") = ViewState("IdTanda")
            'Next

            BulkCopy(dtlista, sc)


            'como la query dinamica no trae la tarifa en el caso de a terceros, tengo que refrescarla
            '-podrías hacer el refresco cuando todavía tenes en memoria la tarifa, no?, en lugar de ir a hacer en la base
            If optFacturarA = 4 Then
                'no llega el idtanda....
                RefrescaTarifaTablaTemporal(dtNoAutomatico, sc, optFacturarA, txtFacturarATerceros, Val(ViewState("IdTanda")), , , , cmbmodo <> "Entregas")
            End If

            If optFacturarA = 3 Then
                ValidaQueHayaClienteCorredorEquivalente()
            End If






            ViewState("filas") = dtlista.Rows.Count

        Catch ex As Exception
            ErrHandler.WriteError("GenerarTablaparamodosnoautomaticos")
            ErrHandler.WriteError(ex)
            Throw
        End Try

    End Sub


    Shared Function ValidaQueHayaClienteCorredorEquivalente() As Boolean

        'adasd()
        'en los casos que se pone facturar a corredor
    End Function


    Shared Sub generarTabla(ByVal SC As String, ByVal ViewState As System.Web.UI.StateBag, ByVal iPageSize As Long, _
                            ByVal puntoVenta As Integer, ByVal desde As DateTime, ByVal hasta As DateTime, _
                            ByVal sLista As String, ByVal sesionId As String, Optional bNoUsarLista As Boolean = False)

        ErrHandler.WriteError("entrando en generar tabla. tanda " & sesionId)

        Try
            Dim tildadosEnPrimerPaso As String() = Split(sLista, ",")
            Dim tildadosEnPrimerPasoLongs As Generic.List(Of Integer)
            'If sLista Is Nothing Then
            '    tildadosEnPrimerPaso = Nothing
            '    tildadosEnPrimerPasoLongs = Nothing
            'End If
            'Dim tildadosEnPrimerPasoLongs As Generic.List(Of Integer) = ViewState("ListaIDsLongs")       'ListaDeCDPTildadosEnEl1erPaso()
            tildadosEnPrimerPasoLongs = tildadosEnPrimerPaso.Select(Function(itemID) CInt(IIf(IsNumeric(itemID), itemID, -1))).ToList

            Dim lista As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult)

            Dim dtAutomatico As DataTable

            Dim db As New LinqCartasPorteDataContext(Encriptar(SC))





            If False Then
                'como antes ocultaba los hijos en el primer paso, en el segundo los incluia dependiendo del padre original
                lista = (From cdp In db.wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistencia(CInt(puntoVenta), sesionId) _
                          Where tildadosEnPrimerPasoLongs.Contains(If(cdp.IdCartaDePorte, -1)) _
                                Or (cdp.SubnumeroDeFacturacion > 0 And tildadosEnPrimerPasoLongs.Contains(If(cdp.IdCartaOriginal, -1))) _
                          ).ToList
            Else
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9281
                'ahora solo incluyo lo que se tildó explícitamente en el primer paso
                If bNoUsarLista Then
                    lista = (From cdp In db.wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistencia(CInt(puntoVenta), sesionId) _
                            Where If(cdp.IdCartaOriginal, -1) <= 0 _
                          ).ToList
                Else
                    lista = (From cdp In db.wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistencia(CInt(puntoVenta), sesionId) _
                              Where tildadosEnPrimerPasoLongs.Contains(If(cdp.IdCartaDePorte, -1)) _
                              And If(cdp.IdCartaOriginal, -1) <= 0 _
                            ).ToList
                End If

            End If


            'tengo q incluir los explicitos duplicados porque solo tengo el ID de los originales para filtrar. Lo filtro luego, viendo si está el original de ellos



            ''agrego a la lista de tildes los duplicados explicitos
            ''quitar los duplicados explicitos sin original
            'Dim duplicadosexplicitos = From cdp In lista Where cdp.SubnumeroDeFacturacion > 0 Select cdp.NumeroCartaDePorte
            ''      Join cdpjoin In lista On cdp.NumeroCartaDePorte Equals cdpjoin.NumeroCartaDePorte

            'Dim duplicadosexplicitosIncluidos = From cdp In lista _
            '                                  Where duplicadosexplicitos.Contains(cdp.NumeroCartaDePorte) _
            '                                        And Not cdp.SubnumeroDeFacturacion > 0 _
            '                                        Select cdp.IdCartaDePorte


            'lista = (From cdp In lista _
            '          Where tildadosEnPrimerPasoLongs.Contains(CLng(iisNull(cdp.IdCartaDePorte, -1))) _
            '                Or cdp.SubnumeroDeFacturacion > 0 And  _
            '          ).ToList








            '¿como hacer la union de la consulta de titular, y el filtro de cartas problematicas, así queda el skiptake al final

            Debug.Print(lista.Count)



            ErrHandler.WriteError("punto 2. tanda " & sesionId)

            'ejecutar inmediatamente LINQ usando la conversion a .ToList()
            'http://blogs.msdn.com/b/charlie/archive/2007/12/09/deferred-execution.aspx
            Dim IdsEnElAutomatico = (From i In lista Select i.IdCartaDePorte).ToList
            Debug.Print(IdsEnElAutomatico.ToString)


            'como agregar las cartas sin automatico posible? haces un filtro de lo que vino con las Id tildadas en el primer paso, antes de filtrar por repetido. Si no vino nada, es que no hay automatico.
            Dim IdcartasSinAutomaticoEncontrado = (From i In tildadosEnPrimerPasoLongs Select id = CStr(i) _
                                                 Where Not IdsEnElAutomatico.Contains(CLng(id))).ToArray


            ErrHandler.WriteError("punto 3. tanda " & sesionId)

            If IdcartasSinAutomaticoEncontrado.Count > 0 And Not bNoUsarLista Then
                Dim sWhere = " AND IdCartaDePorte IN (" & Join(IdcartasSinAutomaticoEncontrado, ",") & ")"

                '///////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////

                'ineficiente
                Dim dtForzadasAlTitular = SQLSTRING_FacturacionCartas_por_Titular(sWhere, SC, sesionId)

                ErrHandler.WriteError("punto 4. tanda " & sesionId)
                'ineficiente
                For Each cdp In dtForzadasAlTitular.Rows
                    Dim x As New wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult
                    With x
                        .ColumnaTilde = CInt(cdp("ColumnaTilde"))
                        .IdCartaDePorte = CInt(iisNull(cdp("IdCartaDePorte")))
                        .IdArticulo = CInt(iisNull(cdp("IdArticulo")))
                        .NumeroCartaDePorte = iisNull(cdp("NumeroCartaDePorte"))

                        Try
                            .SubNumeroVagon = CInt(iisNull(cdp("SubNumeroVagon")))
                        Catch ex As Exception
                            'raro
                            ErrHandler.WriteError(ex)
                        End Try

                        .SubnumeroDeFacturacion = CInt(iisNull(cdp("SubnumeroDeFacturacion"), 0))
                        .FechaArribo = CDate(iisNull(cdp("FechaArribo")))
                        .FechaDescarga = CDate(iisNull(cdp("FechaDescarga")))
                        .FacturarselaA = CStr(iisNull(cdp("FacturarselaA")))
                        .IdFacturarselaA = CInt(iisNull(cdp("IdFacturarselaA")))
                        .Confirmado = iisNull(cdp("Confirmado"))
                        .IdCodigoIVA = CInt(iisNull(cdp("IdCodigoIVA"), -1))
                        .CUIT = CStr(iisNull(cdp("CUIT")))
                        .ClienteSeparado = CStr(iisNull(cdp("ClienteSeparado")))
                        .TarifaFacturada = CDec(iisNull(cdp("TarifaFacturada"), 0))
                        .Producto = CStr(iisNull(cdp("Producto")))
                        .KgNetos = CDec(iisNull(cdp("KgNetos")))
                        .IdCorredor = CInt(iisNull(cdp("IdCorredor")))
                        .IdTitular = CInt(iisNull(cdp("IdTitular")))
                        .IdIntermediario = CInt(iisNull(cdp("IdIntermediario"), -1))
                        .IdRComercial = CInt(iisNull(cdp("IdRComercial"), -1))
                        .IdDestinatario = CInt(iisNull(cdp("IdDestinatario")))
                        .Titular = CStr(iisNull(cdp("Titular")))
                        .Intermediario = CStr(iisNull(cdp("Intermediario")))
                        .R__Comercial = CStr(iisNull(cdp("R. Comercial")))
                        .Corredor = CStr(iisNull(cdp("Corredor ")))
                        .Destinatario = CStr(iisNull(cdp("Destinatario")))
                        .DestinoDesc = CStr(iisNull(cdp("DestinoDesc")))
                        .Procedcia_ = CStr(iisNull(cdp("Procedcia.")))
                        .IdDestino = CInt(iisNull(cdp("IdDestino")))
                        .AgregaItemDeGastosAdministrativos = CStr(iisNull(cdp("AgregaItemDeGastosAdministrativos")))
                        lista.Add(x)
                    End With
                Next
            End If
            'consulta 8413
            '        * Ordenar alfabeticamente por la columna "Facturarle a"
            '       * Poner las que tienen tarifa en 0 al principio

            'Dim unionAutomaticoConTitularesDefault = (From i In lista).Union( _
            '                From cdp In dtForzadasAlTitular.AsEnumerable _
            '                Select _
            '                ColumnaTilde = CInt(cdp("ColumnaTilde")), _
            '                IdCartaDePorte = CInt(iisNull(cdp("IdCartaDePorte"))), _
            '                IdArticulo = CInt(iisNull(cdp("IdArticulo"))), _
            '                NumeroCartaDePorte = iisNull(cdp("NumeroCartaDePorte")), _
            '                SubNumeroVagon = CInt(iisNull(cdp("SubNumeroVagon"))), _
            '                SubnumeroDeFacturacion = CInt(iisNull(cdp("SubnumeroDeFacturacion"))), _
            '                FechaArribo = CDate(iisNull(cdp("FechaArribo"))), _
            '                FechaDescarga = CDate(iisNull(cdp("FechaDescarga"))), _
            '                FacturarselaA = CDate(iisNull(cdp("FacturarselaA"))), _
            '                IdFacturarselaA = CInt(iisNull(cdp("IdFacturarselaA"))), _
            '                Confirmado = iisNull(cdp("Confirmado")), _
            '                IdCodigoIVA = CInt(iisNull(cdp("IdCodigoIVA"))), _
            '                CUIT = CStr(iisNull(cdp("CUIT"))), _
            '                ClienteSeparado = CStr(iisNull(cdp("ClienteSeparado"))), _
            '                TarifaFacturada = iisNull(cdp("wTarifaWilliams")), _
            '                Producto = CStr(iisNull(cdp("Producto"))), _
            '                KgNetos = CDec(iisNull(cdp("KgNetos"))), _
            '                IdCorredor = CInt(iisNull(cdp("IdCorredor"))), _
            '                IdTitular = CInt(iisNull(cdp("IdTitular"))), _
            '                IdIntermediario = CInt(iisNull(cdp("IdIntermediario"))), _
            '                IdRComercial = CInt(iisNull(cdp("IdRComercial"))), _
            '                IdDestinatario = CInt(iisNull(cdp("IdDestinatario"))), _
            '                Titular = CStr(iisNull(cdp("Titular"))), _
            '                Intermediario = CStr(iisNull(cdp("Intermediario"))), _
            '                R__Comercial = CStr(iisNull(cdp("R__Comercial"))), _
            '                Corredor_ = CStr(iisNull(cdp("Corredor_"))), _
            '                Destinatario = CStr(iisNull(cdp("Destinatario"))), _
            '                DestinoDesc = CStr(iisNull(cdp("DestinoDesc"))), _
            '                Procedcia_ = CStr(iisNull(cdp("Procedcia_"))), _
            '                IdDestino = CInt(iisNull(cdp("IdDestino"))) _
            '                )



            'dtAutomatico = DataTableUNION(dtAutomatico, dtForzadasAlTitular)



            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////
            '* Los Movimientos que sean Embarques (solo los embarques) se facturarán como una Carta de Porte más. 
            'Tomar el cereal, la cantidad de Kg y el Destinatario para facturar.

            ErrHandler.WriteError("punto 5. tanda " & sesionId)
            AgregarEmbarques(lista, SC, desde, hasta, -1, puntoVenta)

            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////

            'RecalcGastosAdminDeCambioDeCartaUsandoTablaTemporal(lista, SC, dt, dtViewstateRenglonesManuales)

            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////





            '* Nueva función en Facturación Automática: "Facturarle al Corredor". Agregar un tilde en los clientes con ese nombre. En el Automático, las Cartas de Porte que corresponda facturarle a estos clientes se le facturarán al Corredor de cada Carta de Porte
            ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor(lista, SC)






            'hay que hacer un update de la lista por si se derivó a un corredor?

            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////




            'Para la facturación automática, de haber cartas de porte Agro y cartas de Porte Seeds, armar dos facturas separadas.
            'Como las cartas de porte duplicadas solamente se pueden facturar mediante la facturación automática, entran en el automático. Para que no se pase la facturación separada, armar dos facturas distintas automaticamente.
            CasosSyngenta(lista, SC)

            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////







            Dim slinks As String
            lista = LinksDeCartasConflictivasDelAutomatico(lista, slinks, SC)

            slinks &= VerificarClientesFacturables(lista)

            ViewState("sLinks") = slinks



            EmparcharClienteSeparadoParaCasosQueSuperenUnMontoDeterminado(lista, SC)

            PostProcesoFacturacion_ReglaExportadores(lista, SC)




            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            'guardo los datos temporales
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////

            ErrHandler.WriteError("punto 6. tanda " & sesionId)
            Randomize()
            ViewState("pagina") = 1
            ViewState("IdTanda") = CInt(Rnd() * 10000)


            Dim c = ExecDinamico(SC, "select count(*) from wTempCartasPorteFacturacionAutomatica")
            If c.Rows(0).Item(0) > 40000 Then
                ExecDinamico(SC, "DELETE wTempCartasPorteFacturacionAutomatica")
            End If


            Dim dt = ExecDinamico(SC, "SELECT * FROM wTempCartasPorteFacturacionAutomatica where 1=0")

            Dim l As New Generic.List(Of wTempCartasPorteFacturacionAutomatica)
            For Each x In lista
                Dim a = New wTempCartasPorteFacturacionAutomatica
                a.IdSesion = ViewState("IdTanda")

                a.IdCartaDePorte = x.IdCartaDePorte
                a.IdFacturarselaA = x.IdFacturarselaA
                a.TarifaFacturada = x.TarifaFacturada
                a.ClienteSeparado = x.ClienteSeparado
                a.ColumnaTilde = x.ColumnaTilde
                a.Confirmado = x.Confirmado
                a.Corredor = x.Corredor
                a.Corredor = x.ClienteSeparado
                a.FacturarselaA = Left(iisNull(x.FacturarselaA, ""), 50) 'esto puede traer problemas?
                a.KgNetos = iisNull(x.KgNetos, 0)
                a.DestinoDesc = x.DestinoDesc
                a.NumeroCartaDePorte = iisNull(x.NumeroCartaDePorte, -10)
                a.SubNumeroVagon = x.SubNumeroVagon
                a.SubnumeroDeFacturacion = x.SubnumeroDeFacturacion
                a.FechaArribo = x.FechaArribo
                a.FechaDescarga = x.FechaDescarga
                a.Producto = x.Producto
                a.IdArticulo = x.IdArticulo
                a.IdCodigoIVA = x.IdCodigoIVA
                a.CUIT = x.CUIT
                a.IdDestino = x.IdDestino
                a.Procedcia = x.Procedcia_
                a.Destinatario = x.Destinatario
                a.Titular = Left(x.Titular, 50)
                a.RComercial = x.R__Comercial
                a.IdIntermediario = x.IdIntermediario
                a.IdCorredor = x.IdCorredor
                a.IdTitular = x.IdTitular
                a.IdRComercial = x.IdRComercial
                a.IdIntermediario = x.IdIntermediario
                a.IdRComercial = x.IdRComercial

                a.AgregaItemDeGastosAdministrativos = x.AgregaItemDeGastosAdministrativos

                ' l.Add(a) 'con linq
                dt.Rows.Add(Nothing, a.IdSesion, x.IdCartaDePorte) 'con datatable
            Next


            'se podría usar bulkCopy http://msdn.microsoft.com/en-us/library/system.data.sqlclient.sqlbulkcopy.aspx
            ' db.wTempCartasPorteFacturacionAutomaticas.InsertAllOnSubmit(l)
            ' db.SubmitChanges()


            If False Then 'con el datatable no anduvo mas rapido
                Dim myConnection = New SqlConnection(Encriptar(SC))
                myConnection.Open()
                Dim adapterForTable1 = New SqlDataAdapter("select * from  wTempCartasPorteFacturacionAutomatica ", myConnection)
                Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
                'si te tira error acá, ojito con estar usando el dataset q usaste para el 
                'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update
                adapterForTable1.Update(dt)
            End If

            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////


            'Dim liston = (From i In lista Select i, IdSesion = ViewState("IdTanda")).ToList

            'Dim listaConOrden = (From i In lista Order By (IIf(i.TarifaFacturada = 0, " ", "") & i.FacturarselaA) Ascending).ToList

            For Each r In lista
                r.Titular = Left(r.Titular, 50)
                r.FacturarselaA = Left(r.FacturarselaA, 50)
            Next

            Dim dtlista As DataTable = ToDataTableNull(lista)
            dtlista.Columns.Remove("IdCartaOriginal")

            Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            With dc
                .ColumnName = "IdSesion"
                .DataType = System.Type.GetType("System.Int32")
                .DefaultValue = ViewState("IdTanda")
            End With
            dtlista.Columns.Add(dc)
            'For Each r In dtlista
            '    r("IdSesion") = ViewState("IdTanda")
            'Next

            ErrHandler.WriteError("punto 7. tanda " & sesionId)

            BulkCopy(dtlista, SC)


            ViewState("filas") = dtlista.Rows.Count


            ErrHandler.WriteError("salgo. tanda " & sesionId)

        Catch ex As Exception
            ErrHandler.WriteError("generarTabla")
            ErrHandler.WriteError(ex)
            Throw
        End Try

    End Sub


    Shared Function GetDatatableAsignacionAutomatica(ByVal SC As String, ByVal ViewState As System.Web.UI.StateBag, ByVal iPageSize As Long, ByVal puntoVenta As Integer, ByVal desde As Date, ByVal hasta As Date, ByVal sesionId As String, ByRef sErrores As String, AgruparArticulosPor As String) As DataTable

        Return GetDatatableAsignacionAutomatica(SC, ViewState, iPageSize, puntoVenta, desde, hasta, _
                                                    "", "", 0, _
                                                    "", "", "", "", _
                                                    "", "", "", "", _
                                                    "", "", "", "", "", "", "", "", "", sesionId, 0, 0, "", sErrores, "", AgruparArticulosPor)


    End Function

    Shared Function GetDatatableAsignacionAutomatica(ByVal SC As String, ByVal ViewState As System.Web.UI.StateBag, ByVal iPageSize As Long, ByVal puntoVenta As Integer, ByVal desde As Date, ByVal hasta As Date, _
                        ByVal sLista As String, ByVal sWHEREadicional As String, ByVal optFacturarA As Long, _
                        ByVal txtFacturarATerceros As String, ByVal HFSC As String, ByVal txtTitular As String, ByVal txtCorredor As String, _
                        ByVal txtDestinatario As String, ByVal txtIntermediario As String, ByVal txtRcomercial As String, _
                        ByVal txt_AC_Articulo As String, ByVal txtProcedencia As String, ByVal txtDestino As String, ByVal txtBuscar As String, _
                        ByVal cmbCriterioWHERE As String, ByVal cmbmodo As String, ByVal optDivisionSyngenta As String, ByVal txtFechaDesde As String, ByVal txtFechaHasta As String, ByVal cmbPuntoVenta As String, _
                         ByVal sesionId As String, ByVal startRowIndex As Long, ByVal maximumRows As Long, ByVal txtPopClienteAuxiliar As String, ByRef sErrores As String, txtFacturarA As String, agruparArticulosPor As String) As DataTable

        'Si una Carta de Porte no tiene ningún cliente que tenga marcado en que si aparece en 
        'esa posición se le debe facturar, entonces se le facturará al 

        ErrHandler.WriteError("entrando en GetDatatableAsignacionAutomatica . tanda " & sesionId)

        Try


            Dim pag As Integer = Val(ViewState("pagina"))
            If pag <= 0 Then pag = 1


            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////

            Dim ids As Integer = Val(ViewState("IdTanda"))
            If ids <= 0 Then
                If optFacturarA = 5 Then
                    generarTabla(SC, ViewState, iPageSize, puntoVenta, desde, hasta, sLista, sesionId)
                Else
                    generarTablaParaModosNoAutomaticos(SC, ViewState, sLista, "", optFacturarA, _
                                                        txtFacturarATerceros, HFSC, txtTitular, txtCorredor, _
                                                        txtDestinatario, txtIntermediario, txtRcomercial, txt_AC_Articulo, _
                                                        txtProcedencia, txtDestino, txtBuscar, cmbCriterioWHERE, _
                                                        cmbmodo, optDivisionSyngenta, txtFechaDesde, txtFechaHasta, _
                                                        cmbPuntoVenta, sesionId, startRowIndex, maximumRows, txtPopClienteAuxiliar, sErrores, txtFacturarA, agruparArticulosPor)
                End If
                ids = ViewState("IdTanda")
            End If



            ErrHandler.WriteError("punto 2 en GetDatatableAsignacionAutomatica . tanda " & sesionId)


            Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
            Dim o = (From i In db.wTempCartasPorteFacturacionAutomaticas _
                        Where i.IdSesion = ids _
                        Order By CStr(IIf(i.TarifaFacturada = 0, " ", "")) & CStr(i.FacturarselaA) & CStr(i.NumeroCartaDePorte.ToString) Ascending _
                        Select i.ColumnaTilde, i.IdCartaDePorte, i.IdArticulo, i.NumeroCartaDePorte, i.SubNumeroVagon, i.SubnumeroDeFacturacion, _
                                i.FechaArribo, i.FechaDescarga, i.FacturarselaA, i.IdFacturarselaA, i.Confirmado, i.IdCodigoIVA, _
                                i.CUIT, i.ClienteSeparado, i.TarifaFacturada, i.Producto, i.KgNetos, i.IdCorredor, i.IdTitular, _
                                i.IdIntermediario, i.IdRComercial, _
                                idDestinatario = 0, i.Titular, Intermediario = "", i.RComercial, i.Corredor, i.Destinatario, _
                                i.DestinoDesc, i.Procedcia, i.IdDestino, i.IdTempCartasPorteFacturacionAutomatica, i.AgregaItemDeGastosAdministrativos _
                        Skip (pag - 1) * iPageSize Take iPageSize _
                    ).ToList

            db = Nothing

            'RecalcGastosAdminDeCambioDeCartaUsandoTablaTemporal()


            ErrHandler.WriteError("punto 3 en GetDatatableAsignacionAutomatica . tanda " & sesionId)

            Dim dtlistaAuto As DataTable = ToDataTableNull(o)
            dtlistaAuto.Columns.Remove("IdTempCartasPorteFacturacionAutomatica") 'parece q tengo q incluirla en LINQ porque sql2000 llora si no incluyo el ID al usa Skip
            'dtlistaAuto.Columns.Remove("IdSesion")

            ErrHandler.WriteError("punto 4 en GetDatatableAsignacionAutomatica . tanda " & sesionId)

            Return dtlistaAuto


            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
        Catch ex As Exception
            ErrHandler.WriteError("explota en GetDatatableAsignacionAutomatica")
            Throw

        End Try



    End Function


    '/////////////////////////////////////////////////////////////////////////////////////////////////


    'http://stackoverflow.com/a/9405173/1054200 la idea era usar el truco de los genericos, y terminé haciendo una grasada
    ' http://www.elguille.info/net/revistas/dotnetmania/pdf/dotnetmania_8.pdf
    Public Shared Function ToDataTableNull(Of T)(ByVal data As Generic.IList(Of T)) As DataTable


        Dim props As System.ComponentModel.PropertyDescriptorCollection = System.ComponentModel.TypeDescriptor.GetProperties(GetType(T))
        Dim table As New DataTable()
        For i As Integer = 0 To props.Count - 1
            Dim prop As System.ComponentModel.PropertyDescriptor = props(i)
            table.Columns.Add(prop.Name, If(Nullable.GetUnderlyingType(prop.PropertyType), prop.PropertyType))
        Next
        Dim values As Object() = New Object(props.Count - 1) {}
        For Each item As T In data
            For i As Integer = 0 To values.Length - 1
                values(i) = If(props(i).GetValue(item), DBNull.Value)
            Next
            table.Rows.Add(values)
        Next
        Return table
    End Function


    '/////////////////////////////////////////////////////////////////////////////////////////////////


    Shared Function GetIQueryableAsignacionAutomatica(ByVal SC As String, ByVal ViewState As System.Web.UI.StateBag, ByVal iPageSize As Long, ByVal puntoVenta As Integer, ByVal desde As Date, ByVal hasta As Date, _
                       ByVal sLista As String, ByVal sWHEREadicional As String, ByVal optFacturarA As Long, _
                       ByVal txtFacturarATerceros As String, ByVal HFSC As String, ByVal txtTitular As String, ByVal txtCorredor As String, _
                       ByVal txtDestinatario As String, ByVal txtIntermediario As String, ByVal txtRcomercial As String, _
                       ByVal txt_AC_Articulo As String, ByVal txtProcedencia As String, ByVal txtDestino As String, ByVal txtBuscar As String, _
                       ByVal cmbCriterioWHERE As String, ByVal cmbmodo As String, ByVal optDivisionSyngenta As String, ByVal txtFechaDesde As String, ByVal txtFechaHasta As String, ByVal cmbPuntoVenta As String, _
                        ByVal sesionId As String, ByVal startRowIndex As Long, ByVal maximumRows As Long, ByVal txtPopClienteAuxiliar As String, ByRef sErrores As String, txtFacturarA As String _
                        , Optional bNoUsarLista As Boolean = False, _
                        Optional referenciaDB As LinqCartasPorteDataContext = Nothing _
                            , Optional agruparArticulosPor As String = "" _
                        ) As IQueryable(Of wTempCartasPorteFacturacionAutomatica)

        'Si una Carta de Porte no tiene ningún cliente que tenga marcado en que si aparece en 
        'esa posición se le debe facturar, entonces se le facturará al 


        Try


            Dim pag As Integer = Val(ViewState("pagina"))
            If pag <= 0 Then pag = 1


            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////

            Dim ids As Integer = Val(ViewState("IdTanda"))
            If ids <= 0 Then
                If optFacturarA = 5 Then
                    generarTabla(SC, ViewState, iPageSize, puntoVenta, desde, hasta, sLista, sesionId, bNoUsarLista)
                Else
                    generarTablaParaModosNoAutomaticos(SC, ViewState, sLista, "", optFacturarA, _
                                                        txtFacturarATerceros, HFSC, txtTitular, txtCorredor, _
                                                        txtDestinatario, txtIntermediario, txtRcomercial, txt_AC_Articulo, _
                                                        txtProcedencia, txtDestino, txtBuscar, cmbCriterioWHERE, _
                                                        cmbmodo, optDivisionSyngenta, txtFechaDesde, txtFechaHasta, _
                                                        cmbPuntoVenta, sesionId, startRowIndex, maximumRows, txtPopClienteAuxiliar, sErrores, txtFacturarA, agruparArticulosPor)
                End If
                ids = ViewState("IdTanda")
            End If

            Dim db As New LinqCartasPorteDataContext
            If referenciaDB Is Nothing Then
                db = New LinqCartasPorteDataContext(Encriptar(SC))
            Else
                db = referenciaDB
            End If


            Dim o As IQueryable(Of wTempCartasPorteFacturacionAutomatica) = (From i In db.wTempCartasPorteFacturacionAutomaticas _
                        Where i.IdSesion = ids _
                        Order By CStr(IIf(i.TarifaFacturada = 0, " ", "")) & CStr(i.FacturarselaA) & CStr(i.NumeroCartaDePorte.ToString) Ascending _
                        Select i _
                        Skip (pag - 1) * iPageSize Take iPageSize _
                    )

            If referenciaDB Is Nothing Then db = Nothing

            'RecalcGastosAdminDeCambioDeCartaUsandoTablaTemporal()



            Return o


            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
        Catch ex As Exception
            ErrHandler.WriteError("explota en GetDatatableAsignacionAutomatica")
            Throw

        End Try

    End Function



    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Shared Sub ActualizarCampoClienteSeparador(ByRef dt As DataTable, ByVal SeSeparaPorCorredor_O_porTitular As Boolean, ByVal sc As String, Optional sesion As Integer = -1)

        'TODO: funcion ineficiente
        '-es porque las llamadas a EsteCorredor...() son ineficientes...

        'por qué necesito esta funcion??? efectivamente, me pisa lo que emparché en CasoSyngenta() y EmparcharClienteSeparadoParaCasosQueSuperenUnMontoDeterminado()
        'por qué necesito esta funcion???

        Dim r = 0
        Dim total = dt.Rows.Count
        ErrHandler.WriteError("ActualizarCampoClienteSeparador " & total & " filas")

        Dim idSyngentaAGRO = BuscaIdClientePreciso("SYNGENTA AGRO S.A.", sc)

        Dim flag = SeSeparaPorCorredor_O_porTitular





        Dim db As New LinqCartasPorteDataContext(Encriptar(sc))
        Dim o = (From i In db.wTempCartasPorteFacturacionAutomaticas _
                 Join c In db.linqClientes On i.IdFacturarselaA Equals c.IdCliente _
                 Where i.IdSesion = sesion _
                Select i.IdCartaDePorte, c.RazonSocial, c.ExpresionRegularNoAgruparFacturasConEstosVendedores _
                ).ToList _
                .ToDictionary(Function(x) x.IdCartaDePorte, Function(x) x.ExpresionRegularNoAgruparFacturasConEstosVendedores)



        'por qué necesito esta funcion??? efectivamente, me pisa lo que emparché en CasoSyngenta() y EmparcharClienteSeparadoParaCasosQueSuperenUnMontoDeterminado()

        For Each row In dt.Rows
            If row("ClienteSeparado").ToString.Contains("montomax") Then Continue For
            If row("ClienteSeparado").ToString.Contains("renglones maximos") Then Continue For

            row("ClienteSeparado") = 0

            If row("IdFacturarselaA") = idSyngentaAGRO Then Continue For 'conflictos con CasoSyngenta()

            If sesion <> -1 Then
                If o.Item(row("IdCartaDePorte")) = "" Then
                    'el valor de .ExpresionRegularNoAgruparFacturasConEstosVendedores es "" 

                    Continue For
                Else
                    Debug.Print(o.Item(row("IdCartaDePorte")))
                End If
            End If



            If flag Then

                'separando por corredores
                row("ClienteSeparado") = CartaDePorteManager.EsteCorredorSeleFacturaAlClientePorSeparadoId(row("IdFacturarselaA"), iisNull(row("IdCorredor"), -1), sc)

            Else
                'si le facturo al corredor, separo por titulares

                'row("ClienteSeparado") = CartaDePorteManager.EsteTitularSeleFacturaAlCorredorPorSeparadoId(iisNull(row("idCartadePorte"), -1), sc.Value)
                row("ClienteSeparado") = CartaDePorteManager.EsteClienteSeleFacturaAlCorredorPorSeparadoId(iisNull(row("IdTitular"), -1), iisNull(row("IdCorredor"), -1), sc)
            End If

            r = r + 1
        Next

    End Sub


    Shared Sub CasosSyngenta(ByRef listaDeCartasPorteAFacturar As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByVal SC As String)


        'Para la facturación automática, de haber cartas de porte Agro y cartas de Porte Seeds, armar dos facturas separadas.
        'Como las cartas de porte duplicadas solamente se pueden facturar mediante la facturación automática, entran en el automático.
        ' Para que no se pase la facturación separada, armar dos facturas distintas automaticamente.


        'A nombre de AGRO las dos?    -SOLO DOS????
        '-si las dos facturas van a ser a nombre de agro, cómo le aviso a GenerarLoteFacturas_NUEVO() que , sin usar el truco del corredor, 2 que tienen 
        'el mismo idFacturarselaA  salen en 2 facturas distintas???
        '-muy facil chavalín: con el ClienteSeparado

        'BUG BUG en GenerarLoteFacturas_NUEVO
        'BUG BUG en GenerarLoteFacturas_NUEVO
        'BUG BUG en GenerarLoteFacturas_NUEVO
        'BUG BUG en GenerarLoteFacturas_NUEVO
        'la datatable "tablaEditadaDeFacturasParaGenerar" se está quedando sin el dato de ClienteSeparado que viene en la datatable "dtf"!!!!!!!!
        'Dim tablaEditadaDeFacturasParaGenerar As DataTable = DataTableUNION(dtf, dtItemsManuales)  
        'BUG BUG en GenerarLoteFacturas_NUEVO
        'BUG BUG en GenerarLoteFacturas_NUEVO
        'BUG BUG en GenerarLoteFacturas_NUEVO
        'BUG BUG en GenerarLoteFacturas_NUEVO


        'te lo pisa ActualizarCampoClienteSeparador(). tenes que verlo tambien ahí
        'te lo pisa ActualizarCampoClienteSeparador(). tenes que verlo tambien ahí
        'te lo pisa ActualizarCampoClienteSeparador(). tenes que verlo tambien ahí
        'te lo pisa ActualizarCampoClienteSeparador(). tenes que verlo tambien ahí


        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim a As linqCliente

        Try
            Dim idSyngentaAGRO = BuscaIdClientePreciso("SYNGENTA AGRO S.A.", SC)
            Dim idSyngentaSEEDS = BuscaIdClientePreciso("NO USAR !!!SYNGENTA SEEDS S.A.", SC)

            Dim q = (From i In listaDeCartasPorteAFacturar Where i.IdFacturarselaA = idSyngentaAGRO Select i.IdCartaDePorte, i.IdFacturarselaA)

            For Each c In q


                Dim tiposyng As String = (From x In db.CartasDePortes Where x.IdCartaDePorte = c.IdCartaDePorte Select x.EnumSyngentaDivision).First

                Dim lambdaTemp = c
                Dim carta = listaDeCartasPorteAFacturar.Find(Function(o) o.IdCartaDePorte = lambdaTemp.IdCartaDePorte)
                If tiposyng = "Seeds" Then
                    carta.ClienteSeparado = idSyngentaSEEDS
                Else
                    carta.ClienteSeparado = idSyngentaAGRO
                End If
            Next

        Catch ex As OutOfMemoryException
            ErrHandler.WriteError("Problema de linq en CasosSyngenta!!!!!")
            Throw
        Catch ex As Exception
            ErrHandler.WriteError("CasosSyngenta")
            Throw
        End Try



    End Sub


    Shared Sub PostProcesoFacturacion_ReglaExportadores(ByRef listaDeCartasPorteAFacturar As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByVal SC As String)
        'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13223
        'Identificar a los clientes que son exportadores clientes de Williams con una marca en el formulario de clientes.
        'Si una carta de porte donde uno de estos clientes aparece como Destinatario, Intermediario o Rte Comercial se duplica y 
        'una copia es de entrega y una de exportación, en la copia de exportación el campo "Facturar a" debe completarse con el cliente en cuestión.
        'lo que no entiendo es el caso de uso
        'la duplican en el momento... y ahí no le ponen a quién se factura? No era obligatorio?

        ' La magia quedaría así: el usuario llena la carta, y pone grabar...
        'Si la carta usa un cliente exportador en Destinatario, Intermediario o Rte Comercial,
        'entonces te hago de prepo una duplicacion de la carta
        'La que queda como exportacion, tendrá el A Facturar con el dichoso cliente exportador
        'Y la otra carta, la local, quedará para que le rellenen el A Facturar, por las fuerzas superiores

        '-ok, así que lo solucionás en la carta, no en la facturacion. Joya Nano.

        'For Each x In listaDeCartasPorteAFacturar

        '    x.SubnumeroDeFacturacion>
        '        x.
        '    x.FacturarselaA
        'Next

        'Esto no debería hacerse cuando se hace la duplicancion

        'ssss()
    End Sub


    Shared Sub EmparcharClienteSeparadoParaCasosQueSuperenUnMontoDeterminado(ByRef listaDeCartasPorteAFacturar As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByVal SC As String)
        'esto es porque para syngenta querrían separar 
        'Buen día Andrés, como te adelanté por teléfono, necesito que en el caso del cliente Syngenta, Agro y Seeds, 
        '    cada factura corte en $ 8.000 final. Ësto podré tenerlo para esta facturación?
        'Aguardo(respuesta.Gracias)
        'http://bdlconsultores.sytes.net/Consultas/Admin/VerConsultas1.php?recordid=12878

        '-recordemos que para facturar, agrupo por [IdFacturarselaA , ClienteSeparado]

        'revisá el metodo CasosSyngenta()

        'no me pisará ActualizarCampoClienteSeparador()?

        Dim idSyngentaAGRO = BuscaIdClientePreciso("SYNGENTA AGRO S.A.", SC)
        Dim idSyngentaSEEDS = BuscaIdClientePreciso("NO USAR !!!SYNGENTA SEEDS S.A.", SC)

        Dim montomax As Decimal
        Try
            montomax = ParametroManager.TraerValorParametro2(SC, "MontoMaximoFacturaDeCartaPorte")
        Catch ex As Exception
            ErrHandler.WriteError(ex)
        End Try
        If montomax = 0 Then
            ParametroManager.GuardarValorParametro2(SC, "MontoMaximoFacturaDeCartaPorte", "150")
            montomax = ParametroManager.TraerValorParametro2(SC, "MontoMaximoFacturaDeCartaPorte")
        End If



        Dim clientescontrolados As New List(Of Integer)
        'clientescontrolados.Add(idSyngentaAGRO)
        'clientescontrolados.Add(idSyngentaSEEDS)
        'clientescontrolados.Add(2871) ' grobo



        Dim q = (From i In listaDeCartasPorteAFacturar _
              Group By i.IdFacturarselaA, i.ClienteSeparado _
              Into g = Group _
                Select New With { _
                    IdFacturarselaA, _
                    ClienteSeparado, _
                    .Monto = g.Sum(Function(x) x.KgNetos * x.TarifaFacturada / 1000 * 1.21) _
                } _
            ).ToList()

        Dim q2 = q.Where(Function(x) x.Monto > montomax And (clientescontrolados.Contains(x.IdFacturarselaA) Or True)).ToList()




        'Dim l As String = iisNull(EntidadManager.ExecDinamico(SC, "SELECT ExpresionRegularNoAgruparFacturasConEstosVendedores FROM Clientes WHERE IdCliente=" & IdClienteEquivalenteAlCorredor).Rows(0).Item(0), "")
        'ParametroManager.GuardarValorParametro2(SC, "MontoMaximoCartaPorteClientes", "SYNGENTA AGRO S.A.|SYNGENTA SEEDS S.A.")
        Dim l As String = ParametroManager.TraerValorParametro2(SC, "MontoMaximoCartaPorteClientes").ToString()

        Dim a() As String = Split(l, "|")

        For Each s In a
            If s = "" Then Continue For
            Dim idcliente As Long = BuscaIdClientePreciso(s, SC)
            clientescontrolados.Add(idcliente)
        Next



        'se debe ejecutar despues del filtro de cartas conflictivas
        Dim total As Decimal = 0
        Dim reasignador As Integer = 0
        Dim ClienteSeparadoanterior As String
        listaDeCartasPorteAFacturar = listaDeCartasPorteAFacturar.OrderBy(Function(x) x.FacturarselaA).ThenBy(Function(x) x.ClienteSeparado).ToList()
        For n = 0 To listaDeCartasPorteAFacturar.Count - 1
            Dim x = listaDeCartasPorteAFacturar(n)
            Dim xant = listaDeCartasPorteAFacturar(IIf(n > 0, n - 1, 0))


            If x.ClienteSeparado <> ClienteSeparadoanterior Or x.IdFacturarselaA <> xant.IdFacturarselaA Then
                total = 0
            End If

            total += x.KgNetos * x.TarifaFacturada / 1000 * 1.21

            If total > montomax And clientescontrolados.Contains(x.IdFacturarselaA) Then
                reasignador += 1
                total = x.KgNetos * x.TarifaFacturada / 1000 * 1.21 'reinicia el total
            End If

            ClienteSeparadoanterior = x.ClienteSeparado

            If reasignador > 0 And clientescontrolados.Contains(x.IdFacturarselaA) Then
                x.ClienteSeparado = (reasignador).ToString() + "° montomaximo" + " " + x.ClienteSeparado + "" 'le reasigno un clienteseparador de fantasía, ya que no tengo un tempIdFacturaAgenerar"
            End If
        Next


        'no me pisará ActualizarCampoClienteSeparador()?

    End Sub


    Shared Sub EmparcharClienteSeparadoParaFacturasQueSuperanCantidadDeRenglones _
            (ByRef listaDeCartasPorteAFacturar As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), _
              ByVal optFacturarA As Integer, ByVal agruparArticulosPor As String, ByVal SC As String, _
                                            ByVal sBusqueda As String)



        '-recordemos que para facturar, agrupo por [IdFacturarselaA , ClienteSeparado]


        Dim clientescontrolados As New List(Of Integer)
        'clientescontrolados.Add(idSyngentaAGRO)
        'clientescontrolados.Add(idSyngentaSEEDS)
        'clientescontrolados.Add(2871) ' grobo


        Dim q = (From i In listaDeCartasPorteAFacturar _
              Group By i.IdFacturarselaA, i.ClienteSeparado _
              Into g = Group _
                Select New With { _
                    IdFacturarselaA, _
                    ClienteSeparado _
                } _
            ).ToList()

        'Dim q2 = q.Where(Function(x) x.Monto > montomax And (clientescontrolados.Contains(x.IdFacturarselaA) Or True)).ToList()



        'Dim a() As String = Split(l, "|")

        'For Each s In a
        '    If s = "" Then Continue For
        '    Dim idcliente As Long = BuscaIdClientePreciso(s, SC)
        '    clientescontrolados.Add(idcliente)
        'Next

        'Dim lotecito = (From i In tablaEditadaDeFacturasParaGenerarComoLista _
        '            Where i.FacturarselaA = cli And i.ClienteSeparado = clisep _
        '         ).ToList

        Dim reasignador As Integer = 1



        For Each owhere In q

            Dim cli = owhere.IdFacturarselaA
            Dim clisep = owhere.ClienteSeparado





            Dim lotecito As List(Of CartaDePorte) = (From c In listaDeCartasPorteAFacturar _
                        Where c.IdFacturarselaA = cli And c.ClienteSeparado = clisep _
                        Select New CartaDePorte With { _
                            .IdArticulo = c.IdArticulo _
                             , .Destino = c.IdDestino, _
                       .Titular = c.IdTitular, _
                   .Entregador = c.IdDestinatario, _
                   .NetoFinalIncluyendoMermas = c.KgNetos, _
               .TarifaCobradaAlCliente = c.TarifaFacturada _
                        } _
                     ).ToList

            Dim grupo As IEnumerable(Of grup) = AgruparItemsDeLaFactura(lotecito, optFacturarA, agruparArticulosPor, SC, sBusqueda)
            grupo.ToList()

            If grupo.Count > MAXRENGLONES Then
                For n = MAXRENGLONES To grupo.Count - 1
                    'marco esas cartas como de otra agrupacion

                    Dim g = grupo(n)

                    Dim carts = From c In listaDeCartasPorteAFacturar _
                                Where (g.IdArticulo = -1 Or c.IdArticulo = g.IdArticulo) _
                                    And (g.Destino = -1 Or c.IdDestino = g.Destino) _
                                    And (g.Entregador = -1 Or c.IdDestinatario = g.Entregador) _
                                    And (g.Titular = -1 Or c.IdTitular = g.Titular)



                    For Each cdp In carts

                        'Dim c As wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult = listaDeCartasPorteAFacturar.Where(Function(x) x.IdCartaDePorte = cdp.Id).FirstOrDefault
                        Dim c As wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult = cdp
                        c.ClienteSeparado = (reasignador).ToString() + "° renglones maximos" + " " + c.ClienteSeparado + "" 'le reasigno un clienteseparador de fantasía, ya que no tengo un tempIdFacturaAgenerar"

                    Next
                Next
            End If


        Next



    End Sub
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Shared Sub ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor(ByRef listaDeCartasPorteAFacturar As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByVal SC As String)

        Return 'se separa el corredor desde EsteCorredorSeleFacturaAlClientePorSeparadoId(). Esta funcion por ahora no sirve mas

        'todo
        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim a As linqCliente

        Try
            Dim sss = (From i In listaDeCartasPorteAFacturar Select i.IdCartaDePorte, i.IdFacturarselaA).ToList

            Dim CartasAFacturarleAlCorredor = (From i In sss _
                                            Join c In db.linqClientes On c.IdCliente Equals i.IdFacturarselaA _
                                            Where c.SeLeDerivaSuFacturaAlCorredorDeLaCarta = "SI" _
                                            Select i.IdCartaDePorte, i.IdFacturarselaA).ToList ', c.SeLeDerivaSuFacturaAlCorredorDeLaCarta

            For Each c In CartasAFacturarleAlCorredor
                Dim lambdaTemp = c
                Dim carta = listaDeCartasPorteAFacturar.Find(Function(o) o.IdCartaDePorte = lambdaTemp.IdCartaDePorte)
                carta.IdFacturarselaA = CartaDePorteManager.IdClienteEquivalenteDelIdVendedor(carta.IdCorredor, SC)
                carta.FacturarselaA = NombreCliente(SC, carta.IdFacturarselaA)


                'habría que refrescar tambien la tarifa? 
                carta.TarifaFacturada = iisNull(db.wTarifaWilliams(carta.IdFacturarselaA, carta.IdArticulo, carta.IdDestino, 0, carta.KgNetos), 0)

                'agregarlo a la lista de corredores que se le separa a este cliente????

                'pero de qué manera la paga? aparece en el encabezado, o el truco de pronto????
                '-pero eso se hace poniendolo en el "separar a corredor".... qué diferencia hay en esta funcionalidad?????

                'sería una extension del "separar estos corredores". Es decir, un check que diga "SEPARARLE TODOS"
                '-Creo que esa es la posta
            Next

        Catch ex As OutOfMemoryException
            ErrHandler.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            ErrHandler.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            ErrHandler.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            ErrHandler.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            ErrHandler.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            ErrHandler.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            ErrHandler.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            ErrHandler.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            Throw
        Catch ex As Exception
            ErrHandler.WriteError("ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor")
            Throw
        End Try


    End Sub

    Public Shared Function ListaEmbarques(ByVal sc As String, ByVal FechaDesde As Date, ByVal FechaHasta As Date, Optional ByVal idTitular As Integer = -1, Optional ByVal pventa As Integer = 0, Optional ByVal idQueContenga As Integer = -1)
        Dim db As New LinqCartasPorteDataContext(Encriptar(sc))

        ' Dim q = From i In db.CartasPorteMovimientos
        Dim embarques = From i In db.CartasPorteMovimientos _
                        Join c In db.linqClientes On c.IdCliente Equals i.IdExportadorOrigen _
                          Where ( _
                                i.Tipo = 4 _
                                And If(i.Anulada, "NO") <> "SI" _
                                And (i.IdStock Is Nothing Or i.IdStock = pventa Or i.IdStock = 0 Or pventa = 0) _
                                And i.FechaIngreso >= FechaDesde And i.FechaIngreso <= FechaHasta _
                                And (i.IdExportadorOrigen = idTitular Or idTitular = -1) _
                                And (idQueContenga = -1 Or i.IdExportadorOrigen = idQueContenga Or i.IdExportadorDestino = idQueContenga) _
                                And (i.IdFacturaImputada <= 0 Or i.IdFacturaImputada Is Nothing) _
                                And i.FechaIngreso >= FechaDesde And i.FechaIngreso <= FechaHasta _
                           ) _
                        Select i.IdCDPMovimiento, Producto = NombreArticulo(sc, i.IdArticulo), i.Cantidad, c.RazonSocial, _
                                i.IdArticulo, i.FechaIngreso, i.IdExportadorOrigen, i.Puerto, i.Vapor

        Return embarques
    End Function


    Public Shared Function ListaEmbarquesQueryable(ByVal sc As String, ByVal FechaDesde As Date, ByVal FechaHasta As Date, Optional ByVal idTitular As Integer = -1, Optional ByVal pventa As Integer = 0, Optional ByVal idQueContenga As Integer = -1) As IQueryable(Of CartasPorteMovimiento)
        Dim db As New LinqCartasPorteDataContext(Encriptar(sc))

        ' Dim q = From i In db.CartasPorteMovimientos
        Dim embarques = From i In db.CartasPorteMovimientos _
                        Join c In db.linqClientes On c.IdCliente Equals i.IdExportadorOrigen _
                          Where ( _
                                i.Tipo = 4 _
                                And If(i.Anulada, "NO") <> "SI" _
                                And i.FechaIngreso >= FechaDesde And i.FechaIngreso <= FechaHasta _
                                And (i.IdExportadorOrigen = idTitular Or idTitular = -1) _
                                And (i.IdStock Is Nothing Or i.IdStock = pventa Or i.IdStock = 0 Or pventa = 0) _
                                And (idQueContenga = -1 Or i.IdExportadorOrigen = idQueContenga Or i.IdExportadorDestino = idQueContenga) _
                           ) _
                        Select i

        '                                And (i.IdFacturaImputada <= 0 Or i.IdFacturaImputada Is Nothing) _






        Return embarques
    End Function




    Shared Sub AgregarEmbarques(ByRef lista As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByVal sc As String, ByVal FechaDesde As Date, ByVal FechaHasta As Date, Optional ByVal idTitular As Integer = -1, Optional ByVal pventa As Integer = 0)
        '* Los Movimientos que sean Embarques (solo los embarques) se facturarán como una Carta de Porte más. 
        'Tomar el cereal, la cantidad de Kg y el Destinatario para facturar.


        'todo
        Try

            Dim embarques = ListaEmbarques(sc, FechaDesde, FechaHasta, idTitular, pventa)

            Dim db As New LinqCartasPorteDataContext(Encriptar(sc))

            For Each i In embarques
                Dim a As New wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult

                'If lista.Count>0 then a=lista(0).

                a.IdCartaOriginal = i.IdCDPMovimiento 'uso IdCartaOriginal al boleo (obviamente, no es una cartaporte)
                a.SubNumeroVagon = i.IdCDPMovimiento

                a.IdFacturarselaA = i.IdExportadorOrigen
                a.IdArticulo = i.IdArticulo
                a.Producto = NombreArticulo(sc, i.IdArticulo)
                a.KgNetos = i.Cantidad

                a.IdDestino = i.Puerto
                a.DestinoDesc = NombreDestino(sc, i.Puerto)

                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8946
                a.Corredor = i.Vapor 'es un texto
                a.NumeroCartaDePorte = Val(i.Vapor)  ' -1


                'a.FacturarselaA &="-EMBARQUE- "
                a.FacturarselaA &= NombreCliente(sc, i.IdExportadorOrigen)


                Const kTarifaEmbarque = 2


                a.TarifaFacturada = iisNull(db.wTarifaWilliams(a.IdFacturarselaA, a.IdArticulo, iisNull(i.Puerto, 0), kTarifaEmbarque, a.KgNetos), 0)
                'todo: tengo q usar la tarifa de embarques
                'acá tambien tengo que safar de alguna manera


                'ListaPreciosManager.GetPrecioPor()
                a.FechaArribo = i.FechaIngreso


                With a

                    .FechaDescarga = i.FechaIngreso
                    .IdCartaDePorte = i.IdCDPMovimiento * -1 'IDEMBARQUES
                    .IdCodigoIVA = 0



                    .IdCartaOriginal = -1

                    a.AgregaItemDeGastosAdministrativos = "NO"
                    .ClienteSeparado = ""
                    '.ColumnaTilde = ""
                    .Confirmado = ""
                    '.Corredor = ""
                    .CUIT = ""
                    .Destinatario = ""
                    '.DestinoDesc = ""

                End With



                lista.Add(a)
            Next

        Catch ex As Exception
            ErrHandler.WriteError(ex)
        End Try


    End Sub


    Shared Sub BulkCopy(ByVal dt As DataTable, ByVal sc As String)
        Using destinationConnection As SqlConnection = New SqlConnection(Encriptar(sc))
            destinationConnection.Open()

            ' Set up the bulk copy object. 
            ' The column positions in the source data reader 
            ' match the column positions in the destination table, 
            ' so there is no need to map columns.
            Using bulkCopy As SqlBulkCopy = New SqlBulkCopy(destinationConnection)
                bulkCopy.DestinationTableName = "dbo.wTempCartasPorteFacturacionAutomatica"

                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdCartaDePorte", "IdCartaDePorte"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdSesion", "IdSesion"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdFacturarselaA", "IdFacturarselaA"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("FacturarselaA", "FacturarselaA"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("TarifaFacturada", "TarifaFacturada"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("ClienteSeparado", "ClienteSeparado"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("ColumnaTilde", "ColumnaTilde"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Confirmado", "Confirmado"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Corredor", "Corredor"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("DestinoDesc", "DestinoDesc"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("KgNetos", "KgNetos"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("NumeroCartaDePorte", "NumeroCartaDePorte"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("SubNumeroVagon", "SubNumeroVagon"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("SubnumeroDeFacturacion", "SubnumeroDeFacturacion"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("FechaArribo", "FechaArribo"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("FechaDescarga", "FechaDescarga"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Producto", "Producto"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdArticulo", "IdArticulo"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdDestino", "IdDestino"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("CUIT", "CUIT"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdCodigoIVA", "IdCodigoIVA"))
                'bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Procedcia_", "Procedcia"))
                'bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Destinatario", "Destinatario"))
                ''bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("R__Comercial", "RComercial"))
                'bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Intermediario", "Intermediario"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdCorredor", "IdCorredor"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdTitular", "IdTitular"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdRComercial", "IdRComercial"))
                'bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdIntermediario", "IdIntermediario"))

                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("AgregaItemDeGastosAdministrativos", "AgregaItemDeGastosAdministrativos"))

                Try
                    ' Write from the source to the destination.
                    bulkCopy.WriteToServer(dt)
                Catch ex As Exception
                    Console.WriteLine(ex.ToString)  'que no te confunda el orden de los colid. Por ejemplo, Titular era el 11. Es decir, depende del datatable. No?
                    ErrHandler.WriteError(ex)
                    Throw
                End Try

            End Using
        End Using
    End Sub


    Shared Sub SoloMostrarElOriginalDeLosDuplicados(ByRef dt As DataTable, ByRef ms As String)
        '
        'todo: hacer esto
        '
    End Sub


    Shared Function GetIdArticuloParaCambioDeCartaPorte(ByVal sc As String) As Long
        Return BuscaIdArticuloPreciso("CAMBIO DE CARTA DE PORTE", sc)
    End Function



    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Shared Function LinksDeCartasConflictivasDelAutomatico(ByVal l As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByRef sLinks As String, ByVal sc As String) As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult)

        'Filtra las conflictivas, y tambien las muestra en un texto.



        Dim cartasrepetidas = (From i In l _
                Group By Id = i.IdCartaDePorte, _
                                 Numero = i.NumeroCartaDePorte, _
                         SubnumeroVagon = i.SubNumeroVagon, _
                         SubNumeroFacturacion = i.SubnumeroDeFacturacion _
                    Into Group _
                Where iisNull(SubNumeroFacturacion, 0) < 1 _
                         And Group.Count() > 1 _
                         And Id <> IDEMBARQUES _
                Select Id).ToList ' new with {.id = Id , .Numero = Numero, .SubnumeroVagon = SubnumeroVagon}).ToList

        Dim sErr As String

        ' Debug.Print(dt.Rows.Count)
        Debug.Print(cartasrepetidas.Count)



        sErr = "TOTAL " & cartasrepetidas.Count & " <br/> "



        Dim LasNoRepetidas = (From i In l Where Not cartasrepetidas.Contains(i.IdCartaDePorte) Order By i.NumeroCartaDePorte, i.FacturarselaA).ToList



        sLinks = "" 'ya no hago sLinks=sErr, ahora uso MostrarConflictivasEnPaginaAparte
        Return LasNoRepetidas
    End Function

    Shared Function MostrarConflictivasEnPaginaAparte(ByVal l As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByVal sc As String) As String

        'http://msdn.microsoft.com/en-us/vstudio/bb737926#grpbysum
        'http://msdn.microsoft.com/en-us/vstudio/bb737926#grpbysum

        '        'se queda sin memoria...
        '        URL:	/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados
        'User:   sgomez()
        '        Exception(Type) : System.OutOfMemoryException()
        'Message:	Exception of type 'System.OutOfMemoryException' was thrown.
        'Stack Trace:	 at System.String.ConcatArray(String[] values, Int32 totalLength)
        'at System.String.Concat(String[] values)
        'at LogicaFacturacion.MostrarConflictivasEnPaginaAparte(List`1 l, String sc)


        ErrHandler.WriteError("punto 1 en MostrarConflictivasEnPaginaAparte .")

        Dim cartasrepetidasaa = (From i In l _
                Group By Id = i.IdCartaDePorte, _
                                 Numero = i.NumeroCartaDePorte, _
                         SubnumeroVagon = i.SubNumeroVagon, _
                         SubNumeroFacturacion = i.SubnumeroDeFacturacion _
                    Into Group _
                Where iisNull(SubNumeroFacturacion, 0) < 1 _
                         And Group.Count() > 1 _
                         And Id <> IDEMBARQUES _
                Select Id, link = Group.SelectMany(Function(x) x.FacturarselaA) _
                ).ToList ' new with {.id = Id , .Numero = Numero, .SubnumeroVagon = SubnumeroVagon}).ToList

        Dim sErr As String

        Dim cartasrepetidaso = cartasrepetidasaa.Select(Function(x) x.Id).ToList

        sErr = "TOTAL " & cartasrepetidaso.Distinct.Count & " (se muestran las primeras 200) <br/> "

        Dim cartasrepetidas = cartasrepetidaso.Take(200).ToList

        If True Then
            ErrHandler.WriteError("punto 2 en MostrarConflictivasEnPaginaAparte .")

            Dim cartasconflic = (From i In l _
                         Where cartasrepetidas.Contains(i.IdCartaDePorte) _
                         Select i.IdCartaDePorte, i.NumeroCartaDePorte, i.SubNumeroVagon, i.IdFacturarselaA, i.FacturarselaA _
                         Order By NumeroCartaDePorte, SubNumeroVagon, IdFacturarselaA Ascending).ToList





            Dim ultimoid As Long


            ErrHandler.WriteError("punto 3 en MostrarConflictivasEnPaginaAparte .")

            Dim linksconflic As String

            If False Then

                If cartasconflic.Count > 0 Then
                    'linksconflic = cartasconflic.SelectMany(Function(dr) "<br/> <a href=""CartaDePorte.aspx?Id=" & """ target=""_blank""> </a>   ")
                    linksconflic = Join(cartasconflic.Select(Function(dr) "<br/> <a href=""CartaDePorte.aspx?Id=" & If(dr.IdCartaDePorte, 0).ToString & """ target=""_blank"">" & dr.NumeroCartaDePorte.ToString & " " & If(dr.SubNumeroVagon, 0).ToString & "</a>   ").ToList.Take(500).ToArray)
                End If

                sErr &= linksconflic


            Else  'ineficiente
                For Each dr In cartasconflic

                    If ultimoid <> dr.IdCartaDePorte Then
                        sErr &= "<br/> <a href=""CartaDePorte.aspx?Id=" & dr.IdCartaDePorte & """ target=""_blank"">" & dr.NumeroCartaDePorte & " " & dr.SubNumeroVagon & "</a>   "
                        's &= "<a href=""Cliente.aspx?Id=" & dr.id & """ target=""_blank"">" & dr.Numero & " " & dr.SubnumeroVagon & "</a>; "

                    End If
                    ultimoid = dr.IdCartaDePorte


                    'sErr &= " ("
                    sErr &= "<a href=""Cliente.aspx?Id=" & dr.IdFacturarselaA & """ target=""_blank""> &nbsp; " & dr.FacturarselaA & "   </a> "
                    'sErr &= " )"

                Next
            End If
        End If







        ErrHandler.WriteError("punto 4 en MostrarConflictivasEnPaginaAparte .")

        Return sErr
    End Function


    'Shared Function LinksDeCartasConflictivas(ByRef dt As DataTable, ByRef sLinks As String) As String


    '    Return "" 'solo se buscan las repetidas del automatico, no del manual. -El manual no tiene conflictivas?



    '    'IdFacturarselaA = CLng(iisNull(i("IdFacturarselaA"), 0)), _

    '    'Dim renglonesdistintas=

    '    Dim cartasrepetidas = From i In dt.AsEnumerable() _
    '            Group By Id = CLng(iisNull(i("IdCartaDePorte"), 0)), _
    '                             Numero = i("NumeroCartaDePorte"), _
    '                     SubnumeroVagon = i("SubnumeroVagon"), _
    '                     SubNumeroFacturacion = i("SubNumeroDeFacturacion") _
    '                Into Group _
    '            Where iisNull(SubNumeroFacturacion, 0) = 0 _
    '                     And Group.Count() > 1 _
    '                     And Id <> IDEMBARQUES _
    '            Select New With {.id = Id, .Numero = Numero, .SubnumeroVagon = SubnumeroVagon}


    '    Dim s As String

    '    Debug.Print(dt.Rows.Count)
    '    Debug.Print(cartasrepetidas.Count)


    '    For Each dr In cartasrepetidas
    '        s &= "<a href=""CartaDePorte.aspx?Id=" & dr.id & """ target=""_blank"">" & dr.Numero & " " & dr.SubnumeroVagon & "</a>; "

    '        Dim numero = dr.Numero
    '        Dim vagon = dr.SubnumeroVagon

    '        Dim cartas = From i In dt.AsEnumerable() _
    '                     Where numero = i("NumeroCartaDePorte") And vagon = i("SubnumeroVagon") _
    '                     Select i("IdFacturarselaA")

    '        s &= "clientes ("
    '        For Each c In cartas

    '            s &= c
    '        Next


    '        's &= "<a href=""Cliente.aspx?Id=" & dr.id & """ target=""_blank"">" & dr.Numero & " " & dr.SubnumeroVagon & "</a>; "
    '    Next


    '    Dim IdCartasRepetidas = From o In cartasrepetidas Select Str(o.id) 'si no lo convierto en string, me llora el Join

    '    If IdCartasRepetidas.Count > 0 Then
    '        'dt = dt.Select("IdCartaDePorte NOT IN (" & String.Join(",", IdCartasRepetidas.ToArray) & ")")

    '        dt = DataTableWHERE(dt, "IdCartaDePorte NOT IN (" & String.Join(",", IdCartasRepetidas.ToArray) & ")")
    '    End If




    '    'Dim q2 = From i In dt.AsEnumerable() _
    '    'Where(Not IdCartasRepetidas.Contains(CLng(i("IdCartaDePorte"))))
    '    '        'dt = q2.todatatable
    '    '       dt = q2.CopyToDataTable()



    '    Return s
    'End Function

    Shared Function LinksDeCartasConflictivasDelAutomaticoSobreElTempDirecto(ByVal l As Generic.List(Of wTempCartasPorteFacturacionAutomatica), ByRef sLinks As String, ByVal sc As String) As Generic.List(Of wTempCartasPorteFacturacionAutomatica)

        'Filtra las conflictivas, y tambien las muestra en un texto.

        Err.Raise("No podes... en la tabla temporal solo quedan las que son válidas")

        Dim cartasrepetidas = (From i In l _
                Group By Id = i.IdCartaDePorte, _
                                 Numero = i.NumeroCartaDePorte, _
                         SubnumeroVagon = i.SubNumeroVagon, _
                         SubNumeroFacturacion = i.SubnumeroDeFacturacion _
                    Into Group _
                Where iisNull(SubNumeroFacturacion, 0) < 1 _
                         And Group.Count() > 1 _
                         And Id <> IDEMBARQUES _
                Select Id).ToList ' new with {.id = Id , .Numero = Numero, .SubnumeroVagon = SubnumeroVagon}).ToList

        Dim sErr As String

        ' Debug.Print(dt.Rows.Count)
        Debug.Print(cartasrepetidas.Count)



        sErr = "TOTAL " & cartasrepetidas.Count & " <br/> "



        Dim LasNoRepetidas = (From i In l Where Not cartasrepetidas.Contains(i.IdCartaDePorte) Order By i.NumeroCartaDePorte, i.FacturarselaA).ToList



        sLinks = "" ' sErr
        Return LasNoRepetidas
    End Function

    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Function TraerSubconjuntoDeRepetidosAutomaticos(ByVal dt As DataTable) As IEnumerable

        Dim q = From i In dt.AsEnumerable() _
                Group By Numero = i("NumeroCartaDePorte"), _
                         IdFacturarselaAExplicito = i("IdFacturarselaA") Into Group _
                Where IdFacturarselaAExplicito <= 0 _
                         And Group.Count() > 1 _
                Select New With {.Numero = Numero, .Count = Group.Count()}

        Return q 'como devuelve un anonimous type, despues no le puedo llamar el contain
    End Function


    Function TraerSubconjuntoDeRepetidosAutomaticosYtambienDuplicadosExplicitos(ByVal dt As DataTable) As IEnumerable

        Dim q = From i In dt.AsEnumerable() _
                Group By Numero = i("NumeroCartaDePorte"), _
                         IdFacturarselaAExplicito = i("IdFacturarselaA") Into Group _
                Where IdFacturarselaAExplicito <= 0 _
                         And Group.Count() > 1 _
                Select New With {.Numero = Numero, .Count = Group.Count()}

        Return q
    End Function




    Shared Function GenerarDatatableDelPreviewDeFacturacion(ByRef dt As DataTable, ByVal sc As String) As DataTable
        'me quedo con dos tablas, la segunda es la que tiene los corredores separados
        'Dim tablaEditadaDeFacturasParaGenerarFiltradaPorCorredoresSeparados = tablaEditadaDeFacturasParaGenerar.Clone

        'En los archivos de Vista Resumida y Vista Detallada, poner las columnas Tarifa,	KgDescargados y Total en formato número

        Dim q = From i In dt.AsEnumerable() _
                Group By _
                    Titular = i("FacturarselaA"), Destino = i("DestinoDesc"), _
                    Articulo = i("Producto"), Tarifa = i("TarifaFacturada"), _
                    SeSepara = i("ClienteSeparado") _
                Into Group _
                Select New With {.Factura = "", .Cliente = Titular, _
                                 .IdClienteSeparado = SeSepara, _
                                 .ClienteSeparado = IIf(EntidadManager.NombreCliente(sc, SeSepara) = "", SeSepara, EntidadManager.NombreCliente(sc, SeSepara)), _
                                .CantidadCDPs = Group.Count(), Destino, Articulo, _
                                .Tarifa = CDec(Tarifa), _
                                .KgDescargados = Group.Sum(Function(i) i.Field(Of Decimal)("KgNetos")), _
                                .Total = Group.Sum(Function(i) CDec(i.Field(Of Decimal)("KgNetos") * i.Field(Of Decimal)("TarifaFacturada") / 1000D)) _
                }


        'parar aca y ver el valor de la columna Total
        '(PASO 3) Excel detallado y resumido despues de facturación -> No muestra los totales (precios)
        'eso iria en una última columna, que sí esta saliendo en los excel antes de la facturacion



        'EsteCorredorSeleFacturaAlTitularPorSeparadoId(i("idCartadePorte"))



        ' cómo separar de ahí las de corredor escpecífico?


        'separar corredores
        'If Not (optFacturarA.SelectedValue = 1 And EsteCorredorSeleFacturaAlTitularPorSeparado(ocdp)) Then








        'DataTableGROUPBY("IdArticulo, Destino, Titular", ".NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinal / 1000), _
        '                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinal / 1000 * i.TarifaCobradaAlCliente)", dt)
        Dim ret = q.ToDataTable()
        ret.Columns.Add("Por destino?", GetType(System.String))
        Return ret
    End Function





    Sub MandarMailsDelPaso2(ByVal dt As DataTable)
        Dim whereClientes = DataTableDISTINCT(dt, "Cliente")
        For Each i In whereClientes.Rows

            'MandaEmail()

        Next



    End Sub







    Public Const _DEBUG_FACTURACION_PRECIOS As Boolean = False






    'Shared Sub GenerarLoteFacturas(ByRef grilla As DataTable, ByVal SC As String, ByRef ViewState As StateBag, ByVal optFacturarA As Long, ByRef gvFacturasGeneradas As GridView, ByVal txtFacturarATerceros As String, ByVal SeEstaSeparandoPorCorredor As Boolean, ByRef Session As HttpSessionState, ByVal PuntoVenta As Integer, ByVal dtViewstateRenglonesManuales As DataTable, ByVal agruparArticulosPor As String, ByVal txtBuscar As String, ByVal txtTarifaGastoAdministrativo As String, ByRef errLog As String, ByVal txtCorredor As String, ByVal chkPagaCorredor As Boolean)

    '    Dim idFactura As Long
    '    Dim ultimo = 0
    '    Dim primera = 0
    '    Dim ultima = 0




    '    Dim tTemp, tHoraEmpieza, tHoraTermina As Date
    '    tHoraEmpieza = Now

    '    '/////////////////////////////////////////////////////////////////////////////
    '    'Acá hago un DISTINCT (en el ToTable) para saber las distintas facturas que tengo que armar
    '    '/////////////////////////////////////////////////////////////////////////////

    '    ErrHandler.WriteError("Separo las facturas que se generan en el lote." & Now.ToString)

    '    Dim dtf = grilla.Copy ' dtDatasourcePaso2.Copy
    '    'If optFacturarA >= 4 Then
    '    '    RefrescaTarifaTablaTemporal(dtf, SC, optFacturarA, txtFacturarATerceros)
    '    'End If




    '    If dtf.Rows.Count < 1 Then

    '        ErrHandler.WriteError("No hay cartas seleccionadas para facturar")

    '        Throw New Exception("No hay cartas seleccionadas para facturar")


    '        Exit Sub
    '    End If

    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'TODO: como agrupar en facturas los items agregados manualmente
    '    'Por cada renglon de dtViewstateRenglonesManuales
    '    '    filtrar la tabla de cartas, ordenando de manera ascendiente el IdclienteSeparado (primero los vacios)
    '    '    tomar el primero IdClienteSeparado que aparezca, y asignarselo al renglon
    '    Dim dtItemsManuales = dtViewstateRenglonesManuales.Copy
    '    For Each r In dtItemsManuales.Rows


    '        Dim strwhere = "FacturarselaA=" & _c(r("FacturarselaA"))
    '        Dim dtLotecito = ProntoFuncionesGenerales.DataTableWHERE(dtf, strwhere)

    '        'Dim q = From i In dtLotecito _
    '        '        Order By i.("IdClienteSeparado") Ascending
    '        '        Select top 1 

    '        ActualizarCampoClienteSeparador(dtLotecito, SeEstaSeparandoPorCorredor, SC)
    '        Try

    '            Dim dtlotecitoordenado = DataTableORDER(dtLotecito, "ClienteSeparado DESC").Item(0)

    '            r("IdFacturarselaA") = dtlotecitoordenado("IdFacturarselaA")
    '            r("ClienteSeparado") = dtlotecitoordenado("ClienteSeparado")
    '            r("IdTitular") = dtlotecitoordenado("IdTitular") 'a proposito le meto Idtitular=Clienteseparado, para que no me vuelva a separar al llamar de nuevo a acutalizarcampoclienteseparador
    '            r("IdCorredor") = dtlotecitoordenado("IdCorredor") 'a proposito le meto IdCorredor=Clienteseparado, para que no me vuelva a separar al llamar de nuevo a acutalizarcampoclienteseparador
    '        Catch ex As Exception
    '            ErrHandler.WriteError("Hay un renglon agregado que se le facturaría a un cliente que no está en la generacion. " & ex.ToString)
    '            'MsgBoxAjax(Me, "Hay un renglon agregado que se le facturaría a un cliente que no está en la generacion")
    '            'Return
    '        End Try

    '    Next
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////


    '    Dim tablaEditadaDeFacturasParaGenerar As DataTable = DataTableUNION(dtf, dtItemsManuales)  'esta es la grilla, incluye las manuales
    '    ActualizarCampoClienteSeparador(tablaEditadaDeFacturasParaGenerar, SeEstaSeparandoPorCorredor, SC) 'TODO: ineficiente

    '    Dim dt = GenerarDatatableDelPreviewDeFacturacion(tablaEditadaDeFacturasParaGenerar, SC)
    '    Dim dtwhere = ProntoFuncionesGenerales.DataTableDISTINCT(dt, New String() {"Factura", "Cliente", "IdClienteSeparado"})





    '    '/////////////////////////////////////////////////////////////////////////////
    '    '/////////////////////////////////////////////////////////////////////////////
    '    '/////////////////////////////////////////////////////////////////////////////
    '    '/////////////////////////////////////////////////////////////////////////////

    '    ErrHandler.WriteError("Empiezo a facturar en serio." & Now.ToString)

    '    Dim n = 0
    '    tTemp = Now






    '    For Each owhere As DataRow In dtwhere.Rows

    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////PASO 1        (Lote 14s, Compronto 7s, Imputacion 2s)
    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////////////////////////////////////////////////////////////////////////////

    '        n = n + 1
    '        Debug.Print("lote " & n & "/" & dtwhere.Rows.Count & " " & Now.ToString)

    '        'chupo la agrupacion del datatable y lo pongo en una List (porque antes lo hacía así, y la
    '        'funcion que genera las facturas usa una List )
    '        Dim idClienteAfacturarle As Long = iisNull(BuscaIdClientePreciso(owhere("Cliente"), SC), -1)

    '        If idClienteAfacturarle = -1 Then
    '            'verificar que no sea por el largo del nombre
    '            If Len(owhere("Cliente").ToString) = 50 Then
    '                Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdCliente FROM Clientes WHERE RazonSocial like '" & Replace(owhere("Cliente"), "'", "''") & "%'")
    '                If ds.Rows.Count < 1 Then
    '                    ErrHandler.WriteError("No se encuentra el cliente " & owhere("Cliente"))
    '                    Continue For
    '                End If
    '                idClienteAfacturarle = ds.Rows(0).Item("IdCliente")
    '            Else
    '                ErrHandler.WriteError("No se encuentra el cliente " & owhere("Cliente"))
    '                Continue For
    '            End If
    '        End If
    '        'If idClienteAfacturarle <> owhere("IdCliente") - 1 Then
    '        ' 'error
    '        ' End If

    '        Dim lote As New System.Collections.Generic.List(Of Pronto.ERP.BO.CartaDePorte)
    '        Dim listEmbarques As New System.Collections.Generic.List(Of DataRow)
    '        Dim strwhere = "FacturarselaA=" & _c(owhere("Cliente")) & " AND [ClienteSeparado]=" & _c(owhere("IdClienteSeparado"))
    '        'para filtrar las que no tienen el corredor separado, no puedo poner filtrar por vacío, hombre
    '        'justamente porque en Corredor hay datos!
    '        'la solucion es agregarle al tablaEditadaDeFacturasParaGenerar la columna con la separacion del corredor...




    '        Dim dtRenglonesAgregados As DataTable = tablaEditadaDeFacturasParaGenerar.Clone 'copio SOLAMENTE la estructura



    '        Dim dtLotecito = ProntoFuncionesGenerales.DataTableWHERE(tablaEditadaDeFacturasParaGenerar, strwhere)
    '        Dim n2tot = dtLotecito.Rows.Count
    '        Dim n2 = 0


    '        For Each i As DataRow In dtLotecito.Rows
    '            n2 = n2 + 1
    '            Debug.Print("                   lote " & n & "/" & dtwhere.Rows.Count & " cdp " & n2 & "/" & n2tot & " " & Now.ToString)


    '            If iisNull(i("idCartaDePorte"), 0) > 0 Then 'es un renglon agregado a mano? 


    '                'TODO: es este FOR el que hace ineficiente la facturacion
    '                'qué es lo molesto? El GetItem o el SavePrecioPorCliente?

    '                Dim stopWatch As New Stopwatch()
    '                ' Get the elapsed time as a TimeSpan value.
    '                'Dim ts As TimeSpan = stopWatch.Elapsed

    '                stopWatch.Start()
    '                Dim ocdp As Pronto.ERP.BO.CartaDePorte = CartaDePorteManager.GetItem(SC, i("idCartaDePorte"))
    '                stopWatch.Stop()
    '                Debug.Print("GetItem " & stopWatch.Elapsed.Milliseconds)


    '                If ocdp.IdFacturaImputada > 0 Then
    '                    If optFacturarA = 5 Then
    '                        'facturacion automatica
    '                        'MODIFICACION: ya no permitir la duplicacion automatica de cartas
    '                        'ocdp = CartaDePorteManager.DuplicarCartaporteConOtroSubnumeroDeFacturacion(sc, ocdp)
    '                        Dim sErr = "Esta carta ya está imputada. No se permite la duplicación automatica de cartas. " & ocdp.Id & " " & ocdp.NumeroCartaDePorte & " " & ocdp.SubnumeroVagon & " " & ocdp.SubnumeroDeFacturacion
    '                        'Err.Raise(64646, , sErr)
    '                        ErrHandler.WriteError(sErr)
    '                        Continue For
    '                    Else
    '                        'tiene q haber algun error. Solo debería haber cartasporte sin facturar si no se usó la facturacion automatica
    '                        Err.Raise(64646, , "Esta carta ya está imputada. Tiene que haber algun error. Solo debería haber cartasporte sin facturar si no se usó la facturacion automatica", "Tiene que haber algun error. Solo debería haber cartasporte sin facturar si no se usó la facturacion automatica")
    '                    End If
    '                End If


    '                ocdp.TarifaCobradaAlCliente = iisNull(i("TarifaFacturada"), 0)


    '                If False Then 'voy a sacarlo, qué tanto!
    '                    If Not _DEBUG_FACTURACION_PRECIOS Then
    '                        stopWatch.Start()



    '                        'ListaPreciosManager.SavePrecioPorCliente(SC, idClienteAfacturarle, ocdp.IdArticulo, ocdp.Destino, ocdp.TarifaCobradaAlCliente)

    '                        'cómo se acá si el precio no lo traje de un destino, y al pisar el generico, estoy jodiendolo? -serian pocos los casos, no?
    '                        'ListaPreciosManager.SavePrecioPorCliente(SC, idClienteAfacturarle, ocdp.IdArticulo, ocdp.Destino, ocdp.TarifaCobradaAlCliente)
    '                        ListaPreciosManager.SavePrecioPorCliente(SC, idClienteAfacturarle, ocdp.IdArticulo, ocdp.TarifaCobradaAlCliente)
    '                        stopWatch.Stop()
    '                        Debug.Print("SavePrecioPorCliente " & stopWatch.Elapsed.Milliseconds)
    '                    End If
    '                End If




    '                lote.Add(ocdp)
    '            Else
    '                'renglon agregado a mano o embarque

    '                If iisNull(i("IdCartaDePorte"), 0) = IDEMBARQUES Then
    '                    listEmbarques.Add(i)
    '                Else
    '                    dtRenglonesAgregados.ImportRow(i)
    '                End If
    '            End If

    '        Next


    '        Debug.Print("1 - Lote armado en " & DateDiff(DateInterval.Second, tTemp, Now))
    '        tTemp = Now


    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////PASO 2
    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////////////////////////////////////////////////////////////////////////////
    '        'Debug.Print("Creando Factura " & Now.ToString)


    '        'creo la factura
    '        '-¿Cómo verifico que no se haya imputado la carta en los lotecitos anteriores?
    '        '-Ya se está haciendo arriba, en la llamada a CrearleAlaCartaporteUnSubnumeroParaFacturarselo

    '        idFactura = CreaFacturaCOMpronto(lote, idClienteAfacturarle, PuntoVenta, dtRenglonesAgregados, SC, Session, optFacturarA, agruparArticulosPor, txtBuscar, txtTarifaGastoAdministrativo, SeEstaSeparandoPorCorredor, txtCorredor, chkPagaCorredor, listEmbarques)

    '        Debug.Print("2- ComPronto llamado en " & DateDiff(DateInterval.Second, tTemp, Now))
    '        tTemp = Now




    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////PASO 3
    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////////////////////////////////////////////////////////////////////////////


    '        'control de primera y ultima y errores
    '        If primera = 0 And idFactura <> -1 Then primera = idFactura

    '        If idFactura > 0 Then
    '            'se facturó bien

    '            ultima = idFactura

    '            'hago las imputaciones
    '            For Each o In lote
    '                'TODO: la imputacion tambien es ineficiente, porque llama para grabar a la cdp, que a su vez revisa clientes, etc
    '                'Debug.Print("               imputo " & Now.ToString)

    '                If True Then
    '                    'If InStr(o.FacturarselaA, "<EMBARQUE>") = 0 Then
    '                    CartaDePorteManager.ImputoLaCDP(o, idFactura, SC, Session(SESSIONPRONTO_UserName))
    '                Else
    '                    'y si es un embarque? -pero los embarques no estan en la coleccion lote !!!!!!
    '                End If

    '            Next

    '            For Each o In listEmbarques
    '                'CartaDePorteManager.ImputoElEmbarque(o("NumeroCartaDePorte"), idFactura, SC, Session(SESSIONPRONTO_UserName))
    '            Next

    '        Else
    '            Try
    '                'hubo un error al generar la factura de este lote
    '                errLog &= "No se pudo crear la factura para " & _
    '                "<a href=""Cliente.aspx?Id=" & idClienteAfacturarle & """ target=""_blank"">" & NombreCliente(SC, idClienteAfacturarle) & "</a>; " & _
    '                " verificar IVA y CUIT, o que la carta no estuviese imputada anteriormente; Verificar que no " & _
    '                " se haya disparado el error 'listacdp vacia' o no haya otro cliente con el mismo nombre" & vbCrLf
    '            Catch ex As Exception
    '                ErrHandler.WriteError(ex)
    '            End Try
    '            ErrHandler.WriteError(errLog)
    '        End If


    '        'limpio el lote -no te conviene hacer un new en cada iteracion?
    '        lote.Clear()


    '        Debug.Print("3- Imputacion y limpieza en " & DateDiff(DateInterval.Second, tTemp, Now))
    '        tTemp = Now
    '    Next


    '    Debug.Print("Fin " & Now.ToString)



    '    'está grabando las lineas agregadas?





    '    '/////////////////////////////////////////////////////////////////////////////
    '    '/////////////////////////////////////////////////////////////////////////////
    '    '/////////////////////////////////////////////////////////////////////////////
    '    'Despues de facturar, muestro la grilla de generadas y mensajes de error
    '    '/////////////////////////////////////////////////////////////////////////////
    '    '/////////////////////////////////////////////////////////////////////////////

    '    ' FacturaManager.GetItemComPronto(sc, primera, False).Numero
    '    '& FacturaManager.GetItemComPronto(sc, ultima, False).Numero
    '    If primera = 0 Then
    '        ErrHandler.WriteError("No se han podido generar facturas")
    '        Throw New Exception("No se han podido generar facturas")

    '    End If


    '    Dim s = "SELECT 'Factura.aspx?Id='+ cast(idFactura as varchar) as URLgenerada,tipoabc,puntoventa, " & _
    '            "NumeroFactura as [NumeroFactura],clientes.RazonSocial  FROM Facturas " & _
    '            "JOIN Clientes on Facturas.Idcliente=Clientes.Idcliente   WHERE idFactura between " & primera & " AND " & ultima


    '    gvFacturasGeneradas.DataSource = EntidadManager.ExecDinamico(SC, s)
    '    gvFacturasGeneradas.DataBind()



    '    Try
    '        ViewState("PrimeraIdFacturaGenerada") = primera
    '        ViewState("UltimaIdFacturaGenerada") = ultima

    '        primera = iisNull(EntidadManager.ExecDinamico(SC, _
    '                                                         "SELECT NumeroFactura FROM Facturas WHERE idFactura= " & primera).Rows(0).Item("NumeroFactura"), 1)
    '        ultima = iisNull(EntidadManager.ExecDinamico(SC, _
    '                                                         "SELECT NumeroFactura FROM Facturas WHERE idFactura= " & ultima).Rows(0).Item("NumeroFactura"), 1)



    '        tHoraTermina = Now
    '        ErrHandler.WriteError("Fin facturacion." & primera & " " & ultima & "  Tiempo usado: " & DateDiff(DateInterval.Second, tHoraEmpieza, tHoraTermina) & " segundos. ")





    '    Catch ex As Exception
    '        ErrHandler.WriteError("Error al buscar facturas generadas. " & ex.ToString)
    '    End Try

    '    'lblMensaje.Text = errLog ' "Creadas facturas de la " & primera & " a la " & ultima & ". Facturacion terminada"

    'End Sub


    Shared Function VerificarQueNoHayaCambiadoElLoteDesdeQueSeCreoLaFacturacion(lista As Generic.List(Of Integer), SC As String, ByRef sErr As String) As Boolean
        '  Verificar si esta anulada, que no haya cambiado el estado de las cartas desde que generé el lote, 
        'porque ya no cargo individualmente cada carta
        'lo ideal quizas es verificar que la fecha de modificacion no haya cambiado desde la fecha del 
        'Me conformo con que ninguna carta esté anulada o imputada

        Try

            Using db = New LinqCartasPorteDataContext(Encriptar(SC))

                Dim l = (From i In db.CartasDePortes _
                                    Where lista.Contains(i.IdCartaDePorte) _
                                    And (i.IdFacturaImputada > 0 _
                                    Or i.Anulada = "SI") _
                                    Select CStr(i.NumeroCartaDePorte) _
                                   ).ToArray
                'And i.FechaModificacion _


                If l.Count > 0 Then
                    sErr = "Hay cartas que dejaron de ser facturables (" & Join(l, ",") & ") en estos minutos mientras editabas la grilla. Quitales el tilde o volvé al primer paso"
                    Return False
                Else
                    sErr = ""
                End If

            End Using
        Catch ex As Exception
            MandarMailDeError("Error en VerificarQueNoHayaCambiadoElLoteDesdeQueSeCreoLaFacturacion. Revisar si es el de 'severe error' o el de 'transport level'.       Tamaño de lista: " & lista.Count & "   " & ex.ToString)
            'A severe error occurred on the current command.  The results, if any, should be discarded.????

            'tambien tira el de "A transport-level error has occurred when receiving results from the server"

        End Try


        Return True


        '        Log(Entry)
        '03/07/2014 16:34:43
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:System.Data.SqlClient.SqlException
        'A severe error occurred on the current command.  The results, if any, should be discarded.
        'A severe error occurred on the current command.  The results, if any, should be discarded.
        '   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)
        '   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection)
        '   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
        '   at System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)
        '        at(System.Data.SqlClient.SqlDataReader.ConsumeMetaData())
        '        at(System.Data.SqlClient.SqlDataReader.get_MetaData())
        '   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
        '   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)
        '   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)
        '   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method)
        '   at System.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior, String method)
        '   at System.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
        '        at(System.Data.Common.DbCommand.ExecuteReader())
        '   at System.Data.Linq.SqlClient.SqlProvider.Execute(Expression query, QueryInfo queryInfo, IObjectReaderFactory factory, Object[] parentArgs, Object[] userArgs, ICompiledSubQuery[] subQueries, Object lastResult)
        '   at System.Data.Linq.SqlClient.SqlProvider.ExecuteAll(Expression query, QueryInfo[] queryInfos, IObjectReaderFactory factory, Object[] userArguments, ICompiledSubQuery[] subQueries)
        '   at System.Data.Linq.SqlClient.SqlProvider.System.Data.Linq.Provider.IProvider.Execute(Expression query)
        '   at System.Data.Linq.DataQuery`1.System.Collections.Generic.IEnumerable<T>.GetEnumerator()
        '   at System.Linq.Buffer`1..ctor(IEnumerable`1 source)
        '   at System.Linq.Enumerable.ToArray[TSource](IEnumerable`1 source)
        '   at LogicaFacturacion.VerificarQueNoHayaCambiadoElLoteDesdeQueSeCreoLaFacturacion(List`1 lista, String SC, String& sErr)
        '   at LogicaFacturacion.GenerarLoteFacturas_NUEVO(DataTable& grilla, String SC, StateBag& ViewState, Int64 optFacturarA, GridView& gvFacturasGeneradas, String txtFacturarATerceros, Boolean SeEstaSeparandoPorCorredor, HttpSessionState& Session, Int32 PuntoVenta, DataTable dtViewstateRenglonesManuales, String agruparArticulosPor, String txtBuscar, String txtTarifaGastoAdministrativo, String& errLog, String txtCorredor, Boolean chkPagaCorredor)
        '   at CDPFacturacion.btnGenerarFacturas_Click(Object sender, EventArgs e)
        '.Net SqlClient Data Provider


    End Function


    Shared Sub GenerarLoteFacturas_NUEVO(ByRef grilla As DataTable, ByVal SC As String, ByRef ViewState As System.Web.UI.StateBag, ByVal optFacturarA As Long, _
                                         ByRef gvFacturasGeneradas As GridView, ByVal txtFacturarATerceros As String, _
                                         ByVal SeEstaSeparandoPorCorredor As Boolean, ByRef Session As System.Web.SessionState.HttpSessionState, _
                                         ByVal PuntoVenta As Integer, ByVal dtViewstateRenglonesManuales As DataTable, _
                                         ByVal agruparArticulosPor As String, ByVal txtBuscar As String, _
                                         ByVal txtTarifaGastoAdministrativo As String, ByRef errLog As String, _
                                         ByVal txtCorredor As String, ByVal chkPagaCorredor As Boolean, numeroOrdenCompra As String)

        Dim idFactura As Long
        Dim ultimo = 0
        Dim primera = 0
        Dim ultima = 0




        Dim tTemp, tHoraEmpieza, tHoraTermina As Date
        tHoraEmpieza = Now

        '/////////////////////////////////////////////////////////////////////////////
        'Acá hago un DISTINCT (en el ToTable) para saber las distintas facturas que tengo que armar
        '/////////////////////////////////////////////////////////////////////////////

        ErrHandler.WriteError("Separo las facturas que se generan en el lote." & Now.ToString)

        Dim dtf = grilla.Copy ' dtDatasourcePaso2.Copy
        'If optFacturarA >= 4 Then
        '    RefrescaTarifaTablaTemporal(dtf, SC, optFacturarA, txtFacturarATerceros)
        'End If




        If dtf.Rows.Count < 1 Then

            ErrHandler.WriteError("No hay cartas seleccionadas para facturar")

            Throw New Exception("No hay cartas seleccionadas para facturar")


            Exit Sub
        End If

        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'TODO: como agrupar en facturas los items agregados manualmente
        'Por cada renglon de dtViewstateRenglonesManuales
        '    filtrar la tabla de cartas, ordenando de manera ascendiente el IdclienteSeparado (primero los vacios)
        '    tomar el primero IdClienteSeparado que aparezca, y asignarselo al renglon
        Dim dtItemsManuales = dtViewstateRenglonesManuales.Copy
        For Each r In dtItemsManuales.Rows


            Dim strwhere = "FacturarselaA=" & _c(r("FacturarselaA"))
            Dim dtLotecito = ProntoFuncionesGenerales.DataTableWHERE(dtf, strwhere)

            'Dim q = From i In dtLotecito _
            '        Order By i.("IdClienteSeparado") Ascending
            '        Select top 1 

            ActualizarCampoClienteSeparador(dtLotecito, SeEstaSeparandoPorCorredor, SC)
            Try

                Dim dtlotecitoordenado = DataTableORDER(dtLotecito, "ClienteSeparado DESC").Item(0)

                r("IdFacturarselaA") = dtlotecitoordenado("IdFacturarselaA")
                r("ClienteSeparado") = dtlotecitoordenado("ClienteSeparado")
                r("IdTitular") = dtlotecitoordenado("IdTitular") 'a proposito le meto Idtitular=Clienteseparado, para que no me vuelva a separar al llamar de nuevo a acutalizarcampoclienteseparador
                r("IdCorredor") = dtlotecitoordenado("IdCorredor") 'a proposito le meto IdCorredor=Clienteseparado, para que no me vuelva a separar al llamar de nuevo a acutalizarcampoclienteseparador
            Catch ex As Exception
                ErrHandler.WriteError("Hay un renglon agregado que se le facturaría a un cliente que no está en la generacion. " & ex.ToString)
                'MsgBoxAjax(Me, "Hay un renglon agregado que se le facturaría a un cliente que no está en la generacion")
                'Return
            End Try

        Next
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////

        'la datatable "tablaEditadaDeFacturasParaGenerar" se está quedando sin el dato de ClienteSeparado que viene en la datatable "dtf"!!!!!!!!
        '-naboooooo es ActualizarCampoClienteSeparador el que te lo refresca!!!!

        Dim tablaEditadaDeFacturasParaGenerar As DataTable = DataTableUNION(dtf, dtItemsManuales)
        'Dim tablaEditadaDeFacturasParaGenerar As DataTable = dtf.Copy()  'esta es la grilla, incluye las manuales

        ' Dim tablaEditadaDeFacturasParaGenerar alguna manera de hacerlo tipado y en una lista???

        ActualizarCampoClienteSeparador(tablaEditadaDeFacturasParaGenerar, SeEstaSeparandoPorCorredor, SC) 'TODO: ineficiente

        Dim dt = GenerarDatatableDelPreviewDeFacturacion(tablaEditadaDeFacturasParaGenerar, SC)


        'Dim dtwhere = ProntoFuncionesGenerales.DataTableDISTINCT(dt, New String() {"Factura", "Cliente", "IdClienteSeparado"})

        Dim dtwhere = (From i In dt.AsEnumerable _
                      Select Factura = CInt(Val(i("Factura").ToString)), _
                                Cliente = i("Cliente").ToString, _
                                IdCliente = Convert.ToInt32(iisNull(BuscaIdClientePreciso(i("Cliente").ToString, SC), -1)), _
                                IdClienteSeparado = Convert.ToInt32(Val(i("IdClienteSeparado"))) _
                        ).Distinct.ToList







        '/////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////

        ErrHandler.WriteError("Empiezo a facturar en serio." & Now.ToString)

        Dim n = 0
        tTemp = Now


        'Try

        Dim tablaEditadaDeFacturasParaGenerarComoLista = (From i In tablaEditadaDeFacturasParaGenerar.AsEnumerable _
                                Select _
                                        FacturarselaA = i("FacturarselaA").ToString, _
                                        ClienteSeparado = CInt(Val(i("ClienteSeparado"))), _
                                        idCartaDePorte = CInt(iisNull(i("idCartaDePorte"), -1)), _
                                        NumeroCartaDePorte = CLng(iisNull(i("NumeroCartaDePorte"), -1)), _
                                        TarifaFacturada = CDbl(i("TarifaFacturada")), _
                                        FechaDescarga = CDate(iisNull(i("FechaDescarga"), Today)), _
                                        Destino = CInt(iisNull(i("IdDestino"), -1)), _
                                        IdArticulo = CInt(iisNull(i("IdArticulo"), -1)), _
                                        NetoFinal = CInt(iisNull(i("KgNetos"), -1)), _
                                        Titular = CInt(iisNull(i("IdTitular"), -1)), _
                                        CuentaOrden1 = CInt(iisNull(i("IdIntermediario"), -1)), _
                                        CuentaOrden2 = CInt(iisNull(i("IdRComercial"), -1)), _
                                        Corredor = CInt(iisNull(i("IdCorredor"), -1)), _
                                        Entregador = CInt(iisNull(i("IdDestinatario"), -1)), _
                                        AgregaItemDeGastosAdministrativos = CStr(iisNull(i("AgregaItemDeGastosAdministrativos"))) _
                                    ).ToList


        'Catch ex As Exception
        ' ErrHandler.WriteError("Explota el tablaEditadaDeFacturasParaGenerarComoLista")
        ' throw
        ' End Try







        '.ColumnaTilde = CInt(cdp("ColumnaTilde"))
        '.IdCartaDePorte = CInt(iisNull(cdp("IdCartaDePorte")))
        '.IdArticulo = CInt(iisNull(cdp("IdArticulo")))
        '.NumeroCartaDePorte = iisNull(cdp("NumeroCartaDePorte"))
        '.SubNumeroVagon = CInt(iisNull(cdp("SubNumeroVagon")))
        '.SubnumeroDeFacturacion = CInt(iisNull(cdp("SubnumeroDeFacturacion"), 0))
        '.FechaArribo = CDate(iisNull(cdp("FechaArribo")))
        '.FechaDescarga = CDate(iisNull(cdp("FechaDescarga")))
        '.FacturarselaA = CStr(iisNull(cdp("FacturarselaA")))
        '.IdFacturarselaA = CInt(iisNull(cdp("IdFacturarselaA")))
        '.Confirmado = iisNull(cdp("Confirmado"))
        '.IdCodigoIVA = CInt(iisNull(cdp("IdCodigoIVA"), -1))
        '.CUIT = CStr(iisNull(cdp("CUIT")))
        '.ClienteSeparado = CStr(iisNull(cdp("ClienteSeparado")))
        '.TarifaFacturada = CDec(iisNull(cdp("TarifaFacturada"), 0))
        '.Producto = CStr(iisNull(cdp("Producto")))
        '.KgNetos = CDec(iisNull(cdp("KgNetos")))
        '.IdCorredor = CInt(iisNull(cdp("IdCorredor")))
        '.IdTitular = CInt(iisNull(cdp("IdTitular")))
        '.IdIntermediario = CInt(iisNull(cdp("IdIntermediario"), -1))
        '.IdRComercial = CInt(iisNull(cdp("IdRComercial"), -1))
        '.IdDestinatario = CInt(iisNull(cdp("IdDestinatario")))
        '.Titular = CStr(iisNull(cdp("Titular")))
        '.Intermediario = CStr(iisNull(cdp("Intermediario")))
        '.R__Comercial = CStr(iisNull(cdp("R. Comercial")))
        '.Corredor = CStr(iisNull(cdp("Corredor ")))
        '.Destinatario = CStr(iisNull(cdp("Destinatario")))
        '.DestinoDesc = CStr(iisNull(cdp("DestinoDesc")))
        '.Procedcia_ = CStr(iisNull(cdp("Procedcia.")))
        '.IdDestino = CInt(iisNull(cdp("IdDestino")))
        '.AgregaItemDeGastosAdministrativos = CStr(iisNull(cdp("AgregaItemDeGastosAdministrativos")))

        Dim l = tablaEditadaDeFacturasParaGenerarComoLista.Select(Function(x) x.idCartaDePorte).ToList
        Dim ss As String
        If Not VerificarQueNoHayaCambiadoElLoteDesdeQueSeCreoLaFacturacion(l, SC, ss) Then
            Throw New Exception(ss)
            Return
        End If



        Dim TOPEFACTURAS As Integer = ConfigurationManager.AppSettings("Debug_TopeFacturasCartaPorte")  ' = 20000 'BuscarClaveINI("TopeFacturasCartaPorte")


        Dim db = New LinqCartasPorteDataContext(Encriptar(SC))


        For Each owhere In dtwhere


            If n >= TOPEFACTURAS Then
                errLog &= "Se llegó al máximo de " & n & " facturas  <br/>" & vbCrLf

                Exit For
            End If

            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////PASO 1        (Lote 14s, Compronto 7s, Imputacion 2s)
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////

            n = n + 1
            Debug.Print("lote " & n & "/" & dtwhere.Count & " " & Now.ToString)

            'chupo la agrupacion del datatable y lo pongo en una List (porque antes lo hacía así, y la
            'funcion que genera las facturas usa una List )
            Dim idClienteAfacturarle As Long = owhere.IdCliente

            If idClienteAfacturarle = -1 Then
                'verificar que no sea por el largo del nombre
                If Len(owhere.Cliente.ToString) = 50 Then
                    Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdCliente FROM Clientes WHERE RazonSocial like '" & Replace(owhere.Cliente, "'", "''") & "%'")
                    If ds.Rows.Count < 1 Then
                        ErrHandler.WriteError("No se encuentra el cliente " & owhere.Cliente)
                        Continue For
                    End If
                    idClienteAfacturarle = ds.Rows(0).Item("IdCliente")
                Else
                    ErrHandler.WriteError("No se encuentra el cliente " & owhere.Cliente)
                    Continue For
                End If
            End If
            'If idClienteAfacturarle <> owhere("IdCliente") - 1 Then
            ' 'error
            ' End If

            Dim lote As New System.Collections.Generic.List(Of Pronto.ERP.BO.CartaDePorte)
            Dim listEmbarques As New System.Collections.Generic.List(Of DataRow)
            'Dim strwhere = "FacturarselaA=" & _c(owhere.Cliente) & " AND [ClienteSeparado]=" & _c(owhere.IdClienteSeparado)

            'para filtrar las que no tienen el corredor separado, no puedo poner filtrar por vacío, hombre
            'justamente porque en Corredor hay datos!
            'la solucion es agregarle al tablaEditadaDeFacturasParaGenerar la columna con la separacion del corredor...




            Dim dtRenglonesAgregados As DataTable = tablaEditadaDeFacturasParaGenerar.Clone 'copio SOLAMENTE la estructura
            'Dim dtRenglonesAgregados As DataTable = Nothing


            'Dim dtLotecito = ProntoFuncionesGenerales.DataTableWHERE(tablaEditadaDeFacturasParaGenerar, strwhere)
            Dim cli = owhere.Cliente
            Dim clisep = owhere.IdClienteSeparado
            Dim dtlotecito = (From i In tablaEditadaDeFacturasParaGenerarComoLista _
                                Where i.FacturarselaA = cli And i.ClienteSeparado = clisep _
                             ).ToList


            Dim n2tot = dtlotecito.Count
            Dim n2 = 0


            Dim bucleWatch As New Stopwatch()


            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10460


            'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=12913
            'como hago para crear el tope de renglones?
            '-igual que haces para el tope de monto!!!
            'resolverlo en EmparcharClienteSeparadoParaFacturasQueSuperanCantidadDeRenglones()
            If False Then
                For Each i In dtlotecito
                    Dim q = AgruparItemsDeLaFactura(lote, optFacturarA, agruparArticulosPor, SC, txtBuscar)

                    Dim renglons As Integer = 0
                    For Each o In q
                        renglons += 1 'como es un Enumerable, tengo que iterar, no tengo un metodo Count()
                    Next
                    If renglons > MAXRENGLONES Then
                        Dim s2 = "La factura para " & idClienteAfacturarle.ToString() & " tiene " & renglons.ToString() & " renglones y el máximo es " & MAXRENGLONES.ToString()
                        ErrHandler.WriteAndRaiseError(s2)
                        'Throw New Exception(s2)
                        ' Return -12
                    End If
                Next
            End If


            For Each i In dtlotecito
                bucleWatch.Stop()
                'Debug.Print("Bucle " & bucleWatch.Elapsed.Milliseconds)
                bucleWatch.Reset()
                bucleWatch.Start()

                n2 = n2 + 1
                'Debug.Print("                   lote " & n & "/" & dtwhere.Count & " cdp " & n2 & "/" & n2tot & " " & Now.ToString)



                If iisNull(i.idCartaDePorte, 0) > 0 Then 'es un renglon agregado a mano? 


                    'TODO: es este FOR el que hace ineficiente la facturacion
                    'qué es lo molesto? El GetItem o el SavePrecioPorCliente?

                    Dim stopWatch As New Stopwatch()
                    ' Get the elapsed time as a TimeSpan value.
                    'Dim ts As TimeSpan = stopWatch.Elapsed

                    stopWatch.Start()

                    Dim ocdp As Pronto.ERP.BO.CartaDePorte
                    If False Then
                        ocdp = CartaDePorteManager.GetItem(SC, i.idCartaDePorte)
                    Else
                        'hago un truco: en lugar de llamar al ineficiente Getitem, le paso yo los datos a mano 
                        ocdp = New CartaDePorte
                        With ocdp
                            .Id = i.idCartaDePorte

                            .Destino = i.Destino
                            .IdArticulo = i.IdArticulo
                            .NetoFinalIncluyendoMermas = i.NetoFinal
                            .AgregaItemDeGastosAdministrativos = (i.AgregaItemDeGastosAdministrativos.ToString = "SI")

                            .FechaDescarga = i.FechaDescarga

                            .Titular = i.Titular
                            .CuentaOrden1 = i.CuentaOrden1
                            .CuentaOrden2 = i.CuentaOrden2
                            .Corredor = i.Corredor
                            .Entregador = i.Entregador


                            .TarifaCobradaAlCliente = iisNull(i.TarifaFacturada, 0)
                        End With
                    End If





                    stopWatch.Stop()
                    ' Debug.Print("GetItem " & stopWatch.Elapsed.Milliseconds)


                    If ocdp.IdFacturaImputada > 0 Then
                        If optFacturarA = 5 Then
                            'facturacion automatica
                            'MODIFICACION: ya no permitir la duplicacion automatica de cartas
                            'ocdp = CartaDePorteManager.DuplicarCartaporteConOtroSubnumeroDeFacturacion(sc, ocdp)
                            Dim sErr = "Esta carta ya está imputada. No se permite la duplicación automatica de cartas. " & ocdp.Id & " " & ocdp.NumeroCartaDePorte & " " & ocdp.SubnumeroVagon & " " & ocdp.SubnumeroDeFacturacion
                            'Err.Raise(64646, , sErr)
                            ErrHandler.WriteError(sErr)
                            Continue For
                        Else
                            'tiene q haber algun error. Solo debería haber cartasporte sin facturar si no se usó la facturacion automatica
                            Err.Raise(64646, , "Esta carta ya está imputada. Tiene que haber algun error. Solo debería haber cartasporte sin facturar si no se usó la facturacion automatica", "Tiene que haber algun error. Solo debería haber cartasporte sin facturar si no se usó la facturacion automatica")
                        End If
                    End If



                    If False Then 'voy a sacarlo, qué tanto!

                        If Not _DEBUG_FACTURACION_PRECIOS Then
                            stopWatch.Start()



                            'ListaPreciosManager.SavePrecioPorCliente(SC, idClienteAfacturarle, ocdp.IdArticulo, ocdp.Destino, ocdp.TarifaCobradaAlCliente)

                            'cómo se acá si el precio no lo traje de un destino, y al pisar el generico, estoy jodiendolo? -serian pocos los casos, no?
                            '-y es necesario refrescarlo acá???
                            'ListaPreciosManager.SavePrecioPorCliente(SC, idClienteAfacturarle, ocdp.IdArticulo, ocdp.Destino, ocdp.TarifaCobradaAlCliente)

                            ListaPreciosManager.SavePrecioPorCliente(SC, idClienteAfacturarle, ocdp.IdArticulo, ocdp.TarifaCobradaAlCliente)
                            stopWatch.Stop()
                            Debug.Print("SavePrecioPorCliente " & stopWatch.Elapsed.Milliseconds)
                        End If
                    End If





                    lote.Add(ocdp) 'ojo que es una carta que no tiene todos los datos
                Else
                    'renglon agregado a mano o embarque

                    '/////////////////////////////////////////////////////////////////////////////////
                    'reemplazar este pedazo de codigo para que deje de usar el tablaEditadaDeFacturasParaGenerar y 
                    'use el tablaEditadaDeFacturasParaGenerarComoLista
                    '/////////////////////////////////////////////////////////////////////////////////

                    If iisNull(i.idCartaDePorte, 0) < -1 Then '= IDEMBARQUES Then
                        'es un embarque
                        Try

                            Dim strwhere = "IdCartaDePorte <-1 AND SubNumeroVagon=" & (i.idCartaDePorte * -1) & " And FacturarselaA = " & _c(owhere.Cliente) & " And [ClienteSeparado] = " & _c(owhere.IdClienteSeparado)
                            Dim dtbuque = DataTableWHERE(tablaEditadaDeFacturasParaGenerar, strwhere)
                            If dtbuque.Rows.Count <> 1 Then
                                ErrHandler.WriteAndRaiseError("Se repite un buque")
                            Else

                                Dim r As DataRow = dtbuque.Rows(0)


                                'como pudo agregarlo dos veces? es un bug que está sucediendo

                                If listEmbarques.Contains(r) Then
                                    ErrHandler.WriteAndRaiseError("Se repite un buque")
                                Else
                                    listEmbarques.Add(r)
                                End If
                            End If


                        Catch ex As Exception
                            ErrHandler.WriteError("No se pudo incrustar el renglon de buque")
                            ErrHandler.WriteAndRaiseError(ex)
                        End Try

                    Else
                        'es un renglon agregado a mano
                        Try
                            Dim strwhere = "IdCartaDePorte IS NULL AND FacturarselaA=" & _c(owhere.Cliente) & " AND [ClienteSeparado]=" & _c(owhere.IdClienteSeparado) & " AND KgNetos= " & i.NetoFinal & " AND  TarifaFacturada= " & i.TarifaFacturada


                            Dim dtaa = DataTableWHERE(tablaEditadaDeFacturasParaGenerar, strwhere)
                            If dtaa.Rows.Count <> 1 Then
                                ErrHandler.WriteAndRaiseError("No se pudo incrustar el renglon manual. Más de un renglon cumple el filtro")
                            End If
                            Dim r As DataRow = dtaa.Rows(0)
                            dtRenglonesAgregados.ImportRow(r)

                            'es capaz de traer dos veces el mismo, porque un "CAMBIO CARTA PORTE" y un "GASTOS ANALISIS" pueden tener el mismo FacturarselaA y  FacturarselaA
                            '-pero no tengo el articulo en el "oWhere"!!!!

                        Catch ex As Exception
                            ErrHandler.WriteError("No se pudo incrustar el renglon manual")
                            ErrHandler.WriteAndRaiseError(ex)
                        End Try
                    End If
                End If

            Next


            Debug.Print("1 - Lote armado en " & DateDiff(DateInterval.Second, tTemp, Now))
            tTemp = Now









            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////PASO 2
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            'Debug.Print("Creando Factura " & Now.ToString)


            'creo la factura
            '-¿Cómo verifico que no se haya imputado la carta en los lotecitos anteriores?
            '-Ya se está haciendo arriba, en la llamada a CrearleAlaCartaporteUnSubnumeroParaFacturarselo

            'como puedo averiguar cuantos renglones tendrá la factura? -tantos renglones como agrupamientos devuelva AgruparItemsDeLaFactura()

            Try
                idFactura = CreaFacturaCOMpronto(lote, idClienteAfacturarle, PuntoVenta, dtRenglonesAgregados, SC, Session, optFacturarA, _
                                             agruparArticulosPor, txtBuscar, txtTarifaGastoAdministrativo, SeEstaSeparandoPorCorredor, _
                                             txtCorredor, chkPagaCorredor, listEmbarques)

            Catch ex As AccessViolationException
                'http://stackoverflow.com/questions/5842985/attempted-to-read-or-write-protected-memory-error-when-accessing-com-component
                MandarMailDeError("AccessViolationException. Está todo compilado para x86???")
                Throw
            Catch ex As Exception
                Throw
            End Try

            Debug.Print("2- ComPronto llamado en " & DateDiff(DateInterval.Second, tTemp, Now))
            tTemp = Now




            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////PASO 3
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////

            'el asunto es que si una se pasa, debería parar toda la facturacion, y no saltarse solo esa factura
            If idFactura = -12 Then
                errLog &= "No se pudo crear la factura para " & _
                "<a href=""Cliente.aspx?Id=" & idClienteAfacturarle & """ target=""_blank"">" & NombreCliente(SC, idClienteAfacturarle) & "</a>; " & _
                " Excede el máximo de renglones <br/>"
            End If


            If idFactura = -99 Then
                errLog &= "No se pudo crear la factura para " & _
             "<a href=""Cliente.aspx?Id=" & idClienteAfacturarle & """ target=""_blank"">" & NombreCliente(SC, idClienteAfacturarle) & "</a>; " & _
             " Excede el máximo de renglones <br/>"
                'La factura quizas se generó por la mitad!!!!
                'te descajeta la numeracion
                'el compronto alcanza a armar la factura, pero no crea el subdiario
            End If



            'control de primera y ultima y errores
            If primera = 0 And idFactura <> -1 Then primera = idFactura

            If idFactura > 0 Then
                'se facturó bien

                ultima = idFactura

                'hago las imputaciones
                For Each o In lote
                    'TODO: la imputacion tambien es ineficiente, porque llama para grabar a la cdp, que a su vez revisa clientes, etc
                    'Debug.Print("               imputo " & Now.ToString)

                    If True Then
                        'If InStr(o.FacturarselaA, "<EMBARQUE>") = 0 Then
                        CartaDePorteManager.ImputoLaCDP(o, idFactura, SC, Session(SESSIONPRONTO_UserName))
                    Else
                        'y si es un embarque? -pero los embarques no estan en la coleccion lote !!!!!!
                    End If

                Next

                For Each o In listEmbarques
                    CartaDePorteManager.ImputoElEmbarque(o("SubnumeroVagon"), idFactura, SC, Session(SESSIONPRONTO_UserName))
                Next

                EntidadManager.LogPronto(SC, idFactura, "Factura De CartasPorte: id" & idFactura & " " & optFacturarA & " AGR:" & agruparArticulosPor & " busc:" & txtBuscar, Session(SESSIONPRONTO_UserName))

            Else
                Try
                    'hubo un error al generar la factura de este lote
                    errLog &= "No se pudo crear la factura para " & _
                    "<a href=""Cliente.aspx?Id=" & idClienteAfacturarle & """ target=""_blank"">" & NombreCliente(SC, idClienteAfacturarle) & "</a>; " & _
                    " verificar IVA y CUIT, o que la carta no estuviese imputada anteriormente; Verificar que no " & _
                    " se haya disparado el error 'listacdp vacia' o no haya otro cliente con el mismo nombre <br/>" & vbCrLf
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                    MandarMailDeError(ex)
                End Try
                ErrHandler.WriteError(errLog)
            End If


            'limpio el lote -no te conviene hacer un new en cada iteracion?
            lote.Clear()


            Debug.Print("3- Imputacion y limpieza en " & DateDiff(DateInterval.Second, tTemp, Now))
            tTemp = Now
        Next


        Debug.Print("Fin " & Now.ToString)



        'está grabando las lineas agregadas?





        '/////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////
        'Despues de facturar, muestro la grilla de generadas y mensajes de error
        '/////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////

        ' FacturaManager.GetItemComPronto(sc, primera, False).Numero
        '& FacturaManager.GetItemComPronto(sc, ultima, False).Numero
        If primera = 0 Then
            ErrHandler.WriteError("No se han podido generar facturas. " & vbCrLf & errLog)
            Throw New Exception("No se han podido generar facturas. " & vbCrLf & errLog)

        End If



        Dim s = "SELECT 'Factura.aspx?Id='+ cast(idFactura as varchar) as URLgenerada,tipoabc,puntoventa, " & _
                " NumeroFactura as [NumeroFactura],clientes.RazonSocial, " & _
                " ImporteTotal, ImporteIva1,IVANoDiscriminado , RetencionIBrutos1,RetencionIBrutos2,RetencionIBrutos3,clientes.IdCodigoIVA,clientes.IBcondicion,NumeroCertificadoPercepcionIIBB   " & _
                " FROM Facturas " & _
                " JOIN Clientes on Facturas.Idcliente=Clientes.Idcliente   WHERE idFactura between " & primera & " AND " & ultima & _
                " ORDER BY idFactura  "

        gvFacturasGeneradas.DataSource = EntidadManager.ExecDinamico(SC, s)
        gvFacturasGeneradas.DataBind()



        Try
            ViewState("PrimeraIdFacturaGenerada") = primera
            ViewState("UltimaIdFacturaGenerada") = ultima

            primera = iisNull(EntidadManager.ExecDinamico(SC, _
                                                             "SELECT NumeroFactura FROM Facturas WHERE idFactura= " & primera).Rows(0).Item("NumeroFactura"), 1)
            ultima = iisNull(EntidadManager.ExecDinamico(SC, _
                                                             "SELECT NumeroFactura FROM Facturas WHERE idFactura= " & ultima).Rows(0).Item("NumeroFactura"), 1)



            tHoraTermina = Now
            ErrHandler.WriteError("Fin facturacion." & primera & " " & ultima & "  Tiempo usado: " & DateDiff(DateInterval.Second, tHoraEmpieza, tHoraTermina) & " segundos. ")


            MarcarFacturasConOrdenDeCompra(Val(numeroOrdenCompra), ViewState("PrimeraIdFacturaGenerada"), ViewState("UltimaIdFacturaGenerada"), SC)



        Catch ex As Exception
            ErrHandler.WriteError("Error al buscar facturas generadas. " & ex.ToString)
            MandarMailDeError(ex)

        End Try

        'lblMensaje.Text = errLog ' "Creadas facturas de la " & primera & " a la " & ultima & ". Facturacion terminada"

    End Sub

    Shared Function MarcarFacturasConOrdenDeCompra(numeroorden As Long, idfactpri As Long, idfactult As Long, SC As String)

        Try

            Dim s = "UPDATE    Facturas  SET numeroordencompraexterna=" & numeroorden.ToString() & "   WHERE idFactura>= " & idfactpri.ToString() & "  AND    idFactura <= " & idfactult.ToString()
            ErrHandler.WriteError(s)
            If numeroorden > 0 Then

                EntidadManager.ExecDinamico(SC, s)
            End If

        Catch ex As Exception
            MandarMailDeError(ex)
        End Try


    End Function






    Const SEPAR = ";"




    Class grup
        Public Group As System.Collections.Generic.IEnumerable(Of Pronto.ERP.BO.CartaDePorte)
        Public IdArticulo As Integer
        Public Entregador As Integer
        Public Titular As Integer
        Public Destino As Integer
        Public ObservacionItem As String
        Public NetoFinal As Double
        Public total As Double
        Public cartas As System.Collections.Generic.List(Of Pronto.ERP.BO.CartaDePorte)
    End Class




    Shared Function AgruparItemsDeLaFactura(ByRef oListaCDP As System.Collections.Generic.List(Of Pronto.ERP.BO.CartaDePorte), _
                                            ByVal optFacturarA As Integer, ByVal agruparArticulosPor As String, ByVal SC As String, _
                                            ByVal sBusqueda As String) As IEnumerable(Of grup) 'Generic.List(Of Object) 'grup)

        'Dim q 'As Generic.List(Of Object) 'grup) 
        Dim q As Generic.IEnumerable(Of grup)
        'lo pasé acá para poder meter lo del agrupamiento de titular. Pero pierdo 
        'el tipado anónimo (despues) Tuve que abortar, no me acuerdo por qué




        'TITULAR:
        '                 agrupar por Destinatario + Destino

        'DESTINATARIO:
        '                 agrupar por Titular + Destino

        'CORREDOR:
        '                 agrupar por Destino + Titular + Destinatario

        'A TERCERO default: 
        '                 agrupar por Destino + Destinatario 

        'A TERCERO con EXPORTA='SI': 
        '                 agrupar por Destino

        'A TERCERO excepcion loca: 
        '                 agrupar por Destino + Titular



        '        Log Entry
        '09/18/2014 09:22:42
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. 
        '    Error Message:Error en la llamada a CreaFacturaCOMpronto. System.InvalidCastException: Unable to cast object of 
        '        type 'WhereSelectEnumerableIterator`2[VB$AnonymousType_49`3[System.Int32,System.Int32,System.Collections.Generic.IEnumerable`1[Pronto.ERP.BO.CartaDePorte]],VB$AnonymousType_50`6[System.Collections.Generic.IEnumerable`1[Pronto.ERP.BO.CartaDePorte],System.Int32,System.Int32,System.String,System.Double,System.Double]]'
        ' to type 'System.Collections.Generic.List`1[System.Object]'.
        '   at LogicaFacturacion.AgruparItemsDeLaFactura(List`1& oListaCDP, Int32 optFacturarA, String agruparArticulosPor, 
        '       String SC, String sBusqueda)
        '   at LogicaFacturacion.CreaFacturaCOMpronto(List`1 oListaCDP, Int64 IdClienteAFacturarle, Int64 puntoVentaWilliams, 
        '       DataTable dtRenglonesManuales, String SC, HttpSessionState Session, Int32 optFacturarA, String agruparArticulosPor, 
        '       String txtBuscar, String txtTarifaGastoAdministrativo, Boolean SeSeparaPorCorredor, String txtCorredor, Boolean 
        '       chkPagaCorredor, List`1 listEmbarques)



        If optFacturarA >= 4 And agruparArticulosPor = "Destino" Then
            'si es modo Exporta y A terceros, agrupo solo por IdArticulo y Destino

            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP _
            Group i By i.IdArticulo, i.Destino Into Group _
            Select New grup With {.Group = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = -1, .Titular = -1, _
                                .ObservacionItem = TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino), _
                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000), _
                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente) _
                             }

        ElseIf optFacturarA >= 4 And agruparArticulosPor = "Destino+Destinatario" Then


            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP _
            Group i By i.IdArticulo, i.Destino, i.Entregador Into Group _
            Select New grup With {.Group = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = Entregador, .Titular = -1, _
                                .ObservacionItem = TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino) _
                                     & SEPAR & NombreCliente(SC, Entregador), _
                                     .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000), _
                                    .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente) _
                             }

        ElseIf optFacturarA >= 4 And agruparArticulosPor = "Destino+Titular" Then

            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP _
            Group i By i.IdArticulo, i.Destino, i.Titular Into Group _
            Select New With {.Group = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = -1, .Titular = Titular, _
                                .ObservacionItem = TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino) _
                                                 & SEPAR & NombreCliente(SC, Titular), _
                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000), _
                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente) _
                             }


        ElseIf optFacturarA = 3 And agruparArticulosPor = "Destino+RComercial/Interm+Destinat(CANJE)" Then
            'se le factura al corredor agrupando por el CANJE
            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8530
            'No está funcionando la impresión del Canje cuando se elije un Intermediario/RteComercial en \"Que Contenga\" y CANJE en \"Agrupar Renglones de Cereales por\"


            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP _
            Group i By i.IdArticulo, i.Destino, i.CuentaOrden1, i.CuentaOrden2, i.Entregador Into Group _
            Select New grup With {.Group = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = Entregador, .Titular = -1, _
                                .ObservacionItem = TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino) _
                                        & SEPAR & sBusqueda _
                                        & SEPAR & NombreCliente(SC, Entregador) & Space(80) & "    __" & CuentaOrden1 & " " & CuentaOrden2, _
                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000), _
                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente) _
                             }

        ElseIf optFacturarA <> 3 And agruparArticulosPor = "Destino+RComercial/Interm+Destinat(CANJE)" Then
            'se le factura NO al corredor agrupando por el CANJE
            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8530
            'todo: No está funcionando la impresión del Canje cuando se elije un Intermediario/RteComercial en \"Que Contenga\" y CANJE en \"Agrupar Renglones de Cereales por\"


            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP _
            Group i By i.IdArticulo, i.Destino, i.CuentaOrden1, i.CuentaOrden2, i.Entregador Into Group _
            Select New grup With {.Group = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = Entregador, .Titular = -1, _
                                .ObservacionItem = TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino) _
                                        & SEPAR & sBusqueda _
                                        & SEPAR & NombreCliente(SC, Entregador) & Space(80) & "    __" & CuentaOrden1 & " " & CuentaOrden2, _
                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000), _
                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente) _
                             }


        ElseIf optFacturarA = 3 Then
            'se le factura al corredor

            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP _
            Group i By i.IdArticulo, i.Destino, i.Titular, i.Entregador Into Group _
            Select New grup With {.Group = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = Entregador, .Titular = Titular, _
                                .ObservacionItem = TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino) _
                                        & SEPAR & NombreCliente(SC, Titular) _
                                        & SEPAR & NombreCliente(SC, Entregador), _
                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000), _
                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente) _
                             }



        ElseIf optFacturarA = 2 Then
            'se le factura al destinatario, quitar al titular del agrupamiento

            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP _
            Group i By i.IdArticulo, i.Titular, i.Destino Into Group _
            Select New grup With {.Group = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = -1, .Titular = Titular, _
                                .ObservacionItem = NombreCliente(SC, Titular) _
                                        & SEPAR & TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino), _
                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000), _
                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente) _
                             }

        ElseIf optFacturarA = 1 Then
            'se le factura al titular

            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP _
            Group i By i.IdArticulo, i.Entregador, i.Destino Into Group _
            Select New grup With {.Group = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = Entregador, .Titular = -1, _
                                      .ObservacionItem = NombreCliente(SC, Entregador) _
                                                    & SEPAR & TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino), _
                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000), _
                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente) _
                             }
            '                                   , .cartas = Group.Select(Function(c) c.Id) _

        Else
            Err.Raise(333, "", "No se pudo identificar el criterio de agrupación")
        End If



        'Dim q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP _
        '            Group i By i.IdArticulo, i.Destino, i.Titular, i.Entregador Into Group _
        '            Select New With {Group, IdArticulo, Destino, Titular, Entregador, _
        '                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinal / 1000), _
        '                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinal / 1000 * i.TarifaCobradaAlCliente) _
        '                             }

        'acá se puede empezar a hacer la imputacion a nivel item

        q.ToList()



        Return q
    End Function



    Shared Function VerificadorDeSeparadorEnClientesContraCorredores(ByVal SC As String)

        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        Dim q = From c In db.linqClientes Where c.ExpresionRegularNoAgruparFacturasConEstosVendedores IsNot Nothing _
                Select c.ExpresionRegularNoAgruparFacturasConEstosVendedores

        Dim errores As String = ""
        For Each i In q

            'Si hay mas de un cliente/corredor que use esa razon social, tirar alarma

            Dim a() As String = Split(i, "|")

            'pero cómo sé si es solo un cliente o es un cliente/corredor?????? porque no hay manera de saberlo si no es con la regla de usar el mismo nombre, no hay redundancia para revisar
            '-solo revisá que no haya más de un cliente con ese nombre, y que no haya más de un corredor con ese nombre

            'Dim corredor As String = EntidadManager.GetItem(SC, "Vendedores", oCDP.Corredor).Item("Nombre")



            For Each s In a
                If s = "" Then Continue For

                Dim qclis = (From c In db.linqClientes Where c.RazonSocial = s).DefaultIfEmpty



                Dim qcorr = (From c In db.linqCorredors Where c.Nombre = s).DefaultIfEmpty

                If (qclis.Count = 1 And qcorr.Count = 1) Or _
                    (qclis.Count = 1 And qcorr.Count = 0) Or _
                    (qclis.Count = 0 And qcorr.Count = 1) Then
                    'OK()
                Else
                    'Error 
                    errores += s + " - Como cliente: " + qclis.Count.ToString + ".  Como corredor: " + qcorr.Count.ToString + ". VerificadorDeSeparadorEnClientesContraCorredores" + vbCrLf
                End If

            Next


        Next


        If errores <> "" Then ErrHandler.WriteAndRaiseError(errores)
    End Function


    'Shared Function ActualizarCampoClienteSeparador(q As IQueryable(Of wTempCartasPorteFacturacionAutomatica), ByVal SeSeparaPorCorredor_O_porTitular As Boolean, ByVal sc As String)

    '    'Dim db As New LinqCartasPorteDataContext(Encriptar(sc))
    '    'Dim o = (From i In q _
    '    '        Join 
    '    '        join vendedor   nombrecliente   ExpresionRegularNoAgruparFacturasConEstosVendedores



    '    ''sss()
    'End Function

    Const IdAcopioAgro = 1
    Const IdAcopioSeeds = 2

    Shared Function LeyendaSyngenta(idfactura As Long, SC As String) As String

        '        Log Entry
        '12/09/2014 15:38:31
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/Factura.aspx?Id=66871. Error Message:System.InvalidOperationException
        'Nullable object must have a value.
        '   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
        '   at LogicaFacturacion._Lambda$__167(CartasDePorte c)
        '   at System.Collections.Generic.List`1.FindIndex(Int32 startIndex, Int32 count, Predicate`1 match)
        '   at LogicaFacturacion.LeyendaSyngenta(Int64 idfactura, String SC)
        '   at CartaDePorteManager.FacturaXML_DOCX_Williams(String document, Factura oFac, String SC)
        '   at CartaDePorteManager.ImprimirFacturaElectronica(Int32 IdFactura, Boolean bMostrarPDF, String SC)
        '   at FacturaABM.LinkImprimirXMLFactElectronica_Click(Object sender, EventArgs e)
        '        mscorlib()


        '()

        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        Dim oListaCDP = db.CartasDePortes.Where(Function(x) x.IdFacturaImputada = idfactura).ToList()
        Dim oFac = db.linqFacturas.Where(Function(x) x.IdFactura = idfactura).FirstOrDefault()

        'LeyendaSyngenta(oListaCDP, oFac.IdCliente, SC)

        If oListaCDP.Exists(Function(c) If(c.Acopio1, -1) = IdAcopioAgro Or If(c.Acopio2, -1) = IdAcopioAgro Or If(c.Acopio3, -1) = IdAcopioAgro Or If(c.Acopio4, -1) = IdAcopioAgro Or If(c.Acopio5, -1) = IdAcopioAgro) Then

            'quienautoriza()
            ErrHandler.WriteError("LeyendaSyngenta Agro")

            Dim quienautoriza = ClienteManager.GetItem(SC, oFac.IdCliente).AutorizacionSyngenta
            Return vbCrLf + "Syngenta División Agro. Autoriza: " & IIf(quienautoriza = "", "[vacío]", quienautoriza)

        ElseIf oListaCDP.Exists(Function(c) If(c.Acopio1, -1) = IdAcopioSeeds Or If(c.Acopio2, -1) = IdAcopioSeeds Or If(c.Acopio3, -1) = IdAcopioSeeds Or If(c.Acopio4, -1) = IdAcopioSeeds Or If(c.Acopio5, -1) = IdAcopioSeeds) Then

            ErrHandler.WriteError("LeyendaSyngenta Seeds")

            'quienautoriza()
            Dim quienautoriza = ClienteManager.GetItem(SC, oFac.IdCliente).AutorizacionSyngenta
            Return vbCrLf + "Syngenta División Seeds. Autoriza: " & IIf(quienautoriza = "", "[vacío]", quienautoriza)
        Else
            ErrHandler.WriteError("LeyendaSyngenta Nada")

            Return ""


        End If

    End Function

    Shared Function LeyendaSyngenta(ByRef oListaCDP As System.Collections.Generic.List(Of Pronto.ERP.BO.CartaDePorte), ByVal IdClienteAFacturarle As Long, SC As String) As String


        If oListaCDP.Exists(Function(c) c.Acopio1 = IdAcopioAgro Or c.Acopio2 = IdAcopioAgro Or c.Acopio3 = IdAcopioAgro Or c.Acopio4 = IdAcopioAgro Or c.Acopio5 = IdAcopioAgro) Then
            ErrHandler.WriteError("LeyendaSyngenta Agro")
            'quienautoriza()
            Dim quienautoriza = ClienteManager.GetItem(SC, IdClienteAFacturarle).AutorizacionSyngenta
            Return vbCrLf + "Syngenta División Agro. Autoriza: " & quienautoriza

        ElseIf oListaCDP.Exists(Function(c) c.Acopio1 = IdAcopioSeeds Or c.Acopio2 = IdAcopioSeeds Or c.Acopio3 = IdAcopioSeeds Or c.Acopio4 = IdAcopioSeeds Or c.Acopio5 = IdAcopioSeeds) Then
            ErrHandler.WriteError("LeyendaSyngenta Seeds")
            'quienautoriza()
            Dim quienautoriza = ClienteManager.GetItem(SC, IdClienteAFacturarle).AutorizacionSyngenta
            Return vbCrLf + "Syngenta División Seeds. Autoriza: " & quienautoriza
        Else

            ErrHandler.WriteError("LeyendaSyngenta Nada")
            Return ""


        End If



    End Function









    Shared Function CreaFacturaCOMpronto(ByVal oListaCDP As System.Collections.Generic.List(Of Pronto.ERP.BO.CartaDePorte), _
                                         ByVal IdClienteAFacturarle As Long, ByVal sucursalWilliams As Long, _
                                         ByVal dtRenglonesManuales As DataTable, ByVal SC As String, _
                                         ByVal Session As System.Web.SessionState.HttpSessionState, ByVal optFacturarA As Integer, _
                                         ByVal agruparArticulosPor As String, ByVal txtBuscar As String, _
                                         ByVal txtTarifaGastoAdministrativo As String, _
                                         ByVal SeSeparaPorCorredor As Boolean, ByVal txtCorredor As String, _
                                         ByVal chkPagaCorredor As Boolean, _
                                         ByVal listEmbarques As System.Collections.Generic.List(Of DataRow)) As Integer
        'Revisar tambien en
        ' Pronto el Utilidades->"Generacion de Facturas a partir de Ordenes de Compra automaticas",
        ' (se llama con frmConsulta2 Id = 74) -Eso es un informe!! No genera nada
        'y cómo hace para imprimirlas. Tambien Utilidades->"Prefacturacion"
        ' se llama con GeneracionDeFacturasDesdeOrdenesCompraAutomaticas() -Ese llama a frmExcel1.GenerarFacturasAutomaticas

        'EDU!!!! 
        'si te paras en el principal (visualizando facturas), marcas las facturas que quieras, 
        'boton derecho imprimir (o mandar a pantalla), emite masivamente las facturas.
        'en el frmprincipal esta la funcion EmitirFacturas


        Dim oAp
        Dim oFac 'As ComPronto.Factura 
        Dim oDeb 'As ComPronto.NotaDebito 
        Dim oCre 'As ComPronto.NotaCredito 
        Dim oCli 'As ComPronto.Cliente 
        Dim oVen 'As ComPronto.Vendedor 
        Dim oRs As ADODB.Recordset
        Dim oRsAux As ADODB.Recordset
        Dim oRsErrores As ADODB.Recordset
        Dim mArchivo As String, mTipo As String, mLetra As String, mCliente As String, mCorredor As String, mCuit As String
        Dim mCuitCorredor As String, mCAI As String, mComprobante As String
        Dim fl As Integer, mContador As Integer, mIdMonedaPesos As Integer ', mvarPuntoVenta As Integer
        Dim mIdTipoComprobante As Integer, mIdCodigoIva As Integer
        Dim mIdArticuloParaImportacionFacturas As Long, mNumero As Long, mIdCliente As Long
        Dim mIdConceptoParaImportacionNDNC As Long, mNumeroCliente As Long, mIdCuenta As Long
        Dim mSubtotal As Double, mIVA As Double, mTotal As Double
        Dim mTasa As Single, mCotizacionDolar As Single
        Dim mFecha As Date, mFechaCAI As Date
        Dim mOk As Boolean, mConProblemas As Boolean
        Dim mAux1
        Dim idFacturaCreada As Integer



        'estaba hablando con claudio recien, Williams factura con un solo punto 
        'de venta (con un solo talonario), precisaríamos que todo se facture como talonario 1 y que el 
        'punto de venta de las CdP facturadas se refleje en el campo Centro de Costo de la 
        'factura (daríamos de alta los 4 centros de costo)




        Dim tTemp As Date = Now

        Try

            If (oListaCDP Is Nothing Or oListaCDP.Count < 1) And _
                    (dtRenglonesManuales Is Nothing Or dtRenglonesManuales.Rows.Count < 1) And _
                    (listEmbarques Is Nothing Or listEmbarques.Count < 1) Then
                ErrHandler.WriteError("oListaCDP vacía")
                Return -1
            End If


            mLetra = LetraSegunTipoIVA(ClienteManager.GetItem(SC, IdClienteAFacturarle).IdCodigoIva)



            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////LIOS CON LOS PUNTOS DE VENTA    /////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            Dim numeropuntoVenta = PuntoVentaWilliams.NumeroPuntoVentaSegunSucursalWilliams(sucursalWilliams, SC)
            Dim IdPuntoVenta As Integer = EntidadManager.TablaSelectId(SC, _
                                            "PuntosVenta", _
                                            "PuntoVenta=" & numeropuntoVenta & " AND Letra='" & _
                                            mLetra & "' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.Factura)
            Dim IdObra As Integer = PuntoVentaWilliams.ObraSegunSucursalWilliams(sucursalWilliams, SC)
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////



            oAp = ClaseMigrar.CrearAppCompronto(SC)



            If IdClienteAFacturarle <= 0 Then Return -1








            oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
            mIdMonedaPesos = IIf(IsNull(oRs.Fields("IdMoneda").Value), 1, oRs.Fields("IdMoneda").Value)
            mIdCuenta = IIf(IsNull(oRs.Fields("IdCuentaDeudoresVarios").Value), 0, oRs.Fields("IdCuentaDeudoresVarios").Value)
            oRs.Close()

            If mIdCuenta = 0 Then
                ErrHandler.WriteError("No definio en parametros la cuenta contable deudores varios")
                Return -1
            End If




            mAux1 = ParametroManager.TraerValorParametro2(SC, "IdArticuloParaImportacionFacturas")
            mIdArticuloParaImportacionFacturas = IIf(IsNull(mAux1), 0, mAux1)
            mAux1 = ParametroManager.TraerValorParametro2(SC, "IdConceptoParaImportacionNDNC")
            mIdConceptoParaImportacionNDNC = IIf(IsNull(mAux1), 0, mAux1)

            If mIdArticuloParaImportacionFacturas = 0 Then
                ErrHandler.WriteError("No definio en parametros el articulo generico para importar las facturas")
                Return -1
            End If



            oRsAux = oAp.Facturas.TraerFiltrado("_PorNumeroComprobante", ArrayVB6(mLetra, IdPuntoVenta, mNumero.ToString))
            If oRsAux.RecordCount > 0 Then
                AgregarMensajeProcesoPresto(oRsErrores, "La factura " & mComprobante & " ya existe, no se generará")
                mConProblemas = True
            End If
            oRsAux.Close()


            mTasa = iisNull(ParametroManager.ParametroOriginal(SC, "Iva1"), 0)
            mCAI = CAIsegunPuntoVenta(mLetra, numeropuntoVenta, SC)






            If Not mConProblemas Then
                oFac = oAp.Facturas.Item(-1)
                With oFac

                    'Try
                    '    .Guardar() 'para ver si genera un type mismatch
                    'Catch ex As Exception
                    '    ErrHandler.WriteError("Primer Guardar trucho. " & ex.ToString)
                    'End Try


                    With .Registro
                        '.Fields("TipoABC").Value = mLetra 'ahora se encarga CalculaFactura
                        '.Fields("PuntoVenta").Value = mvarPuntoVenta 'definir esto


                        '.Fields("NumeroFactura").Value = mNumero

                        .Fields("IdCliente").Value = IdClienteAFacturarle 'oCDP.Vendedor ' mIdCliente
                        .Fields("FechaFactura").Value = Today ' mFecha
                        .Fields("ConvenioMultilateral").Value = "NO"
                        .Fields("CotizacionDolar").Value = Cotizacion(SC, Today, mIdMonedaPesos)  ' mCotizacionDolar 'Esta linea tira error "division por 0" si lo dejo en 0
                        .Fields("RetencionIBrutos3").Value = 0
                        .Fields("PorcentajeIBrutos3").Value = 0
                        .Fields("PorcentajeIva1").Value = mTasa
                        .Fields("PorcentajeIva2").Value = 0
                        .Fields("IVANoDiscriminado").Value = 0



                        'depende de la condicion de venta del cliente
                        'hay una tablita de condiciones
                        'se llama "Conciciones Compra"
                        'que tiene la cantidad de dias CantidadDias
                        Dim dtcondiciones As DataTable = EntidadManager.ExecDinamico(SC, "SELECT IdCondicionVenta FROM Clientes WHERE idCliente= " & IdClienteAFacturarle)
                        Dim idcondicion As Integer = iisNull(dtcondiciones.Rows(0).Item("IdCondicionVenta"), 1)
                        .Fields("IdCondicionVenta").Value = idcondicion
                        Dim dias As Integer = iisNull(EntidadManager.ExecDinamico(SC, "SELECT CantidadDias1 FROM  [Condiciones Compra]  WHERE idCondicionCompra=" & idcondicion).Rows(0).Item(0), 0)
                        .Fields("FechaVencimiento").Value = DateAdd(DateInterval.Day, dias, Today) ' mFecha 



                        .Fields("IdMoneda").Value = mIdMonedaPesos
                        .Fields("CotizacionMoneda").Value = 1
                        .Fields("CotizacionDolar").Value = Cotizacion(SC)
                        .Fields("PorcentajeBonificacion").Value = 0
                        '.Fields("OtrasPercepciones1").Value = 1 ' 0     'Esta linea tira error
                        .Fields("OtrasPercepciones1Desc").Value = ""
                        '.Fields("OtrasPercepciones2").Value = 1 ' 0    'Esta linea tira error
                        .Fields("OtrasPercepciones2Desc").Value = ""


                        '//////////////////////////////////////////////////////////////////////////
                        '//////////////////////////////////////////////////////////////////////////
                        '//////////////////////////////////////////////////////////////////////////
                        'estaba hablando con claudio recien, Williams factura con un solo punto 
                        'de venta (con un solo talonario), precisaríamos que todo se facture como talonario 1 y que el 
                        'punto de venta de las CdP facturadas se refleje en el campo Centro de Costo de la 
                        'factura (daríamos de alta los 4 centros de costo)
                        Try
                            '                            Mariano(Scalella)
                            '                            las a y las b salen con el mismo talonario??
                            '                            Andrés(dice)
                            'no hacen facturas b
                            'si tienen que hacer las haran por pronto

                            .Fields("IdPuntoVenta").Value = IdPuntoVenta 'debiera ser 1...


                            '6:                          BUENOS(AIRES)
                            '7:                          COMERCIAL()
                            '8:                          SAN(LORENZO)
                            '9:                          ARROYO(SECO)
                            '10:                         BAHIA(BLANCA)


                            .Fields("IdObra").Value = IdObra

                        Catch ex As Exception
                            ErrHandler.WriteError("Problema al poner el punto de venta/centro de costo")
                        End Try
                        '//////////////////////////////////////////////////////////////////////////
                        '//////////////////////////////////////////////////////////////////////////
                        '//////////////////////////////////////////////////////////////////////////
                        '//////////////////////////////////////////////////////////////////////////




                        .Fields("NumeroCAI").Value = Val(mCAI)
                        .Fields("FechaVencimientoCAI").Value = mFechaCAI
                        .Fields("IdUsuarioIngreso").Value = Session(SESSIONPRONTO_glbIdUsuario)
                        .Fields("FechaIngreso").Value = Today
                        .Fields("IdCodigoIva").Value = mIdCodigoIva   'este no lo estas asignando (ahora)... Igual, la factura graba
                        '.Fields("PercepcionIVA").Value = 1 ' 0   'Esta linea tira error
                        .Fields("PorcentajePercepcionIVA").Value = 0

                    End With



                    Debug.Print("        ComPronto paso 1 listo " & DateDiff(DateInterval.Second, tTemp, Now))
                    tTemp = Now


                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////

                    FormatearFacturaSegunSeSepareONoSeparador_Leyenda_Corredor_Separador(oListaCDP, oFac, IdClienteAFacturarle, SeSeparaPorCorredor, SC, txtCorredor, chkPagaCorredor)





                    Debug.Print("        ComPronto paso 2 listo " & DateDiff(DateInterval.Second, tTemp, Now))
                    tTemp = Now




                    '//////////////////////////////////////
                    '//////////////////////////////////////
                    '//////////////////////////////////////
                    '//////////////////////////////////////



                    'Mostrar el período de facturación (Con la leyenda \\\" Período de Facturación: Fecha1raCdp - FechaUltimaCdp )
                    Dim fecha = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP _
                               Select i.FechaDescarga Order By FechaDescarga


                    'como poner lo de la leyenda de Syngenta?
                    'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13009
                    oFac.Registro.Fields("Observaciones").Value += LeyendaSyngenta(oListaCDP, IdClienteAFacturarle, SC)


                    If listEmbarques.Count > 0 Then
                        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8946
                        oFac.Registro.Fields("Observaciones").Value += vbCrLf & "Periodo " + CDate(listEmbarques(0).Item("FechaDescarga")).ToString("MMMM")
                    Else
                        oFac.Registro.Fields("Observaciones").Value += vbCrLf & "Periodo entre " + fecha(0) + " y " + fecha(fecha.Count - 1)
                    End If




                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////

                    'me guardo a quién se eligió facturar y cómo se agrupó

                    Dim agrupIndex As Integer
                    Select Case agruparArticulosPor
                        Case "Destino"
                            agrupIndex = 1
                        Case "Destino+Destinatario"
                            agrupIndex = 2
                        Case "Destino+Titular"
                            agrupIndex = 3
                        Case "Destino+RComercial/Interm+Destinat(CANJE)"
                            agrupIndex = 4
                        Case Else
                            agrupIndex = 99
                    End Select

                    oFac.Registro.Fields("NumeroExpedienteCertificacionObra").Value = CInt(optFacturarA & "00" & agrupIndex)

                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    'agrupo las cdps que tengan el mismo articulo destino y cliente -no agrupes mas por titular, solo por destinatario
                    'TODO: Facturación: tomar kg neto (sin mermas) y no el final
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////


                    'ver esta funcion. dependiendo de q.count....
                    Dim q = AgruparItemsDeLaFactura(oListaCDP, optFacturarA, agruparArticulosPor, SC, txtBuscar)

                    Dim renglons As Integer = 0
                    For Each o In q
                        renglons += 1 'como es un Enumerable, tengo que iterar, no tengo un metodo Count()
                    Next

                    'el asunto es que si una se pasa, debería parar toda la facturacion, y no saltarse solo esa factura

                    If renglons > MAXRENGLONES Then
                        'ErrHandler.WriteError("No definio en parametros la cuenta contable deudores varios")

                        'si tiro una excepcion acá, la captura el try de esta funcion
                        Dim s2 = "La factura para " & IdClienteAFacturarle.ToString() & " tiene " & renglons.ToString() & " renglones y el máximo es " & MAXRENGLONES.ToString()
                        ErrHandler.WriteError(s2)
                        'Throw New Exception(s2)
                        Return -12
                    End If








                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    'creo los items
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////


                    For Each o In q

                        With .DetFacturas.Item(-1)
                            With .Registro

                                .Fields("IdArticulo").Value = o.IdArticulo 'mIdArticuloParaImportacionFacturas
                                .Fields("Cantidad").Value = o.NetoFinal '/ 1000 '1


                                .Fields("PrecioUnitario").Value = o.total / o.NetoFinal 'o.Tarifa 'tarifa(IdClienteAFacturarle, o.IdArticulo)



                                .Fields("PrecioUnitarioTotal").Value = .Fields("PrecioUnitario").Value 'mTotal - mIVA


                                .Fields("Costo").Value = 0
                                .Fields("Bonificacion").Value = 0
                                .Fields("OrigenDescripcion").Value = 1





                                '//////////////////////////////////////////////////////////////////////////
                                '//////////////////////////////////////////////////////////////////////////
                                '//////////////////////////////////////////////////////////////////////////
                                '//////////////////////////////////////////////////////////////////////////
                                'Consulta 6206
                                'Cuando se factura a Titular, que quede: 
                                'Cereal(-Destinatario - destino)
                                'Y cuando se factura al corredor, que en la misma linea (renglon), salga impreso : 
                                'Cereal - Destinatario - Destino - Cliente.


                                'saco la procedencia, porque quieren agrupar solo por articulo, destino, vendedor
                                'Dim proc = EntidadManager.TablaSelect(sc, "Nombre", "Localidades", "IdLocalidad", o.Procedencia)

                                'Dim destino = EntidadManager.TablaSelect(sc, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", o.Destino)

                                '.Fields("Observaciones").Value = "   " & proc & "    " & destino '& " " & destinatario '& "   " & " CDP:" & o.NumeroCartaDePorte



                                .Fields("Observaciones").Value = o.ObservacionItem

                                'por qué no pongo el armado de Observaciones cuando genero por LINQ el "q"?
                                'If optFacturarA.SelectedValue = 3 Then
                                '    'si facturé al corredor de la cdp, que aparezca el nombre del titular
                                '    Dim titular = EntidadManager.NombreCliente(sc, o.Titular)
                                '    Dim destinatario = EntidadManager.NombreCliente(sc, o.Entregador)
                                '    .Fields("Observaciones").Value = "   " & destino & " " & titular & " " & destinatario & " "
                                'ElseIf optFacturarA.SelectedValue = 4 And cmbModo.Text = "Exporta" Then
                                '    .Fields("Observaciones").Value = "   " & destino
                                'ElseIf optFacturarA.SelectedValue = 4 Then
                                '    'a terceros
                                '    Dim titular = EntidadManager.NombreCliente(sc, o.Titular)
                                '    .Fields("Observaciones").Value = "   " & titular & " " & destino
                                'Else
                                '    'guarda, si es el caso 2 (destinatario) no va a venir el titular -por? Ademas, no tiene sentido agrupar por destinatario si se le factura al destinatario!!!
                                '    Dim destinatario = EntidadManager.NombreCliente(sc, o.Entregador)
                                '    .Fields("Observaciones").Value = "   " & destinatario & " " & destino '& " " & destinatario '& "   " & " CDP:" & o.NumeroCartaDePorte
                                'End If

                                '//////////////////////////////////////////////////////////////////////////
                                '//////////////////////////////////////////////////////////////////////////
                                '//////////////////////////////////////////////////////////////////////////
                                '//////////////////////////////////////////////////////////////////////////




                                'del calculo del total del item y de la factura, se encarga CalculaFacturaSimplificado
                                'mTotal += .Fields("Cantidad").Value * .Fields("PrecioUnitario").Value
                                'buscarel iva del articulo en su tabla
                                'mIVA+=

                            End With
                            .Modificado = True

                        End With
                    Next
                    Debug.Print("        ComPronto paso 3 listo " & DateDiff(DateInterval.Second, tTemp, Now))
                    tTemp = Now



                    '//////////////////////////////////////////
                    '//////////////////////////////////////////
                    '//////////////////////////////////////////

                    '//////////////////////////////////////////
                    '/////////////////////////////////////
                    '//////////////////////////////////////////



                    If Not dtRenglonesManuales Is Nothing Then

                        Dim K_idartcambio As Integer = GetIdArticuloParaCambioDeCartaPorte(SC)

                        For Each dr As DataRow In dtRenglonesManuales.Rows

                            With .DetFacturas.Item(-1)
                                With .Registro
                                    'If iisNull(dr.item("IdArticulo")) = "" Then Continue For
                                    'Debug.Print(dr.item("IdArticulo"))
                                    .Fields("IdArticulo").Value = BuscaIdArticuloPreciso(dr.Item("Producto"), SC) 'mIdArticuloParaImportacionFacturas

                                    'le pasé la división por mil a la tarifa porque acá hacen un truco, y en el Pronto solo tengo 2 decimales


                                    Dim tarif As Double
                                    If .Fields("IdArticulo").Value = K_idartcambio Or InStr(dr.Item("Producto"), "ANALISIS") > 0 Or InStr(dr.Item("Producto"), "FLETE") > 0 Then
                                        'si es un "cambio de carta porte", no dividir por mil. 
                                        'Es decir, la "Tarifa" en los renglones normales es por "Tonelada", y en estos es por "Unidad".
                                        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11379
                                        'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11577

                                        .Fields("Cantidad").Value = dr.Item("KgNetos")
                                        tarif = dr.Item("TarifaFacturada")

                                    Else

                                        'si es un articulo común (un grano) hay que divdir la cantidad


                                        .Fields("Cantidad").Value = dr.Item("KgNetos") / 1000
                                        tarif = dr.Item("TarifaFacturada") '/ 1000
                                    End If




                                    .Fields("PrecioUnitario").Value = tarif
                                    .Fields("PrecioUnitarioTotal").Value = .Fields("PrecioUnitario").Value





                                    .Fields("Costo").Value = 0
                                    .Fields("Bonificacion").Value = 0
                                    .Fields("OrigenDescripcion").Value = 1
                                    .Fields("Observaciones").Value = ""
                                End With
                                .Modificado = True

                            End With
                        Next
                    End If



                    For Each dr In listEmbarques

                        With .DetFacturas.Item(-1)
                            With .Registro
                                'If iisNull(dr.item("IdArticulo")) = "" Then Continue For
                                'Debug.Print(dr.item("IdArticulo"))


                                .Fields("IdArticulo").Value = BuscaIdArticuloPreciso(dr.Item("Producto"), SC) 'mIdArticuloParaImportacionFacturas
                                .Fields("Cantidad").Value = dr.Item("KgNetos") / 1000 'le pasé la división por mil a la tarifa porque acá hacen un truco, y en el Pronto solo tengo 2 decimales
                                .Fields("PrecioUnitario").Value = dr.Item("TarifaFacturada")
                                .Fields("PrecioUnitarioTotal").Value = .Fields("PrecioUnitario").Value
                                .Fields("Costo").Value = 0
                                .Fields("Bonificacion").Value = 0
                                .Fields("OrigenDescripcion").Value = 1


                                '////////////////////////////////////////////////////////////////
                                '////////////////////////////////////////////////////////////////
                                '////////////////////////////////////////////////////////////////
                                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8946
                                'En el primero imprimir la leyenda \"ATENCION BUQUE\"
                                'En el segundo: Nombre del Buque - Cereal - Puerto

                                Dim obsEmbarque As String = "BUQUE " & dr.Item("Corredor") & SEPAR & "  " & dr.Item("DestinoDesc")


                                .Fields("Observaciones").Value = obsEmbarque
                                '////////////////////////////////////////////////////////////////
                                '////////////////////////////////////////////////////////////////
                                '////////////////////////////////////////////////////////////////
                                '////////////////////////////////////////////////////////////////


                            End With
                            .Modificado = True

                        End With
                    Next





                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    'agregar renglon de "Gastos administrativos"
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    Dim IdArticuloGastoAdministrativo = BuscaIdArticuloPreciso("CAMBIO DE CARTA DE PORTE", SC)

                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8526

                    If IdArticuloGastoAdministrativo > 0 Then

                        Dim cantidadGastosAdministrativos = 0


                        For Each cdp In oListaCDP
                            If cdp.AgregaItemDeGastosAdministrativos Then cantidadGastosAdministrativos += 1
                        Next

                        If cantidadGastosAdministrativos > 0 Then


                            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8526
                            Dim PrecioArticuloGastoAdministrativo As Double = ListaPreciosManager.Tarifa(SC, IdClienteAFacturarle, IdArticuloGastoAdministrativo)
                            If PrecioArticuloGastoAdministrativo = 0 Then
                                PrecioArticuloGastoAdministrativo = StringToDecimal(txtTarifaGastoAdministrativo)
                                'PrecioArticuloGastoAdministrativo = ListaPreciosManager.Tarifa(sc, IdClienteAFacturarle, IdArticuloGastoAdministrativo)
                            End If
                            If PrecioArticuloGastoAdministrativo = 0 Then
                                'tanto la lista de precios como el default estan en 0
                                EntidadManager.ErrHandlerWriteErrorLogPronto("No se pudo asignar la tarifa de gasto administrativo para " & IdClienteAFacturarle, SC, "")
                            End If


                            'Solicitan que la tarifa del artículo Cambio de Carta de Porte la tome siempre de la Lista de Precios de 
                            'cada cliente y que la pida en los casos en que la Carta de Porte tiene el tilde y el 
                            'cliente al que se le facturará no tiene elegida una tarifa.
                            '-ah, o sea que no habrá mas default, no?


                            With .DetFacturas.Item(-1)
                                With .Registro
                                    'If iisNull(dr.item("IdArticulo")) = "" Then Continue For
                                    'Debug.Print(dr.item("IdArticulo"))
                                    .Fields("IdArticulo").Value = IdArticuloGastoAdministrativo
                                    .Fields("Cantidad").Value = cantidadGastosAdministrativos 'le pasé la división por mil a la tarifa porque acá hacen un truco, y en el Pronto solo tengo 2 decimales
                                    .Fields("PrecioUnitario").Value = PrecioArticuloGastoAdministrativo
                                    .Fields("PrecioUnitarioTotal").Value = PrecioArticuloGastoAdministrativo


                                    .Fields("Costo").Value = 0
                                    .Fields("Bonificacion").Value = 0
                                    .Fields("OrigenDescripcion").Value = 1
                                    .Fields("Observaciones").Value = "GASTOS ADMINISTRATIVOS" '"POR GASTOS ADMINISTRATIVOS"
                                End With
                                .Modificado = True

                            End With
                        End If

                    End If



                    '//////////////////////////////////////////
                    '//////////////////////////////////////////
                    '//////////////////////////////////////////



                    'CalculaFactura(oFac)
                    Try
                        CalculaFacturaSimplificado(oFac, SC, Session, numeropuntoVenta, IdPuntoVenta) 'recien ahi se asigna la letra de la factura...
                    Catch ex As Exception
                        ErrHandler.WriteError("Error en CalculaFacturaSimplificado. " & ex.ToString)
                        MandarMailDeError(ex)
                        Return -1
                    End Try




                    With .Registro

                        .Fields("ImporteIva2").Value = 0
                        .Fields("ImporteBonificacion").Value = 0

                        If False Then
                            .Fields("RetencionIBrutos1").Value = 0
                            .Fields("PorcentajeIBrutos1").Value = 0
                            .Fields("RetencionIBrutos2").Value = 0
                            .Fields("PorcentajeIBrutos2").Value = 0
                        End If

                    End With





                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////
                    ' Defino el punto de venta
                    ' Talonario=Punto de venta + Letra + Tipo de Comprobante (factura, NC, ND)


                    'Traigo el IdPuntoVenta
                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////

                    'de qué obra es el usuario?

                    Dim mvarNumeracionUnica = False
                    'If parametros.Fields("NumeracionUnica").Value = "SI" Then mvarNumeracionUnica = True 

                    'If mvarNumeracionUnica And oFac.Registro.Fields("TipoABC").Value <> "E" Then
                    '    oRs = ConvertToRecordset(EntidadManager.GetStoreProcedure(sc, "PuntosVenta_TX_PuntosVentaPorIdTipoComprobanteLetra", ArrayVB6(puntoVenta, oFac.Registro.Fields("TipoABC").Value)))

                    'Else
                    '    'oRs = ConvertToRecordset(EntidadManager.GetStoreProcedure(sc, "PuntosVenta_TX_PuntosVentaPorIdTipoComprobanteLetra", ArrayVB6(puntoVenta, oFac.Registro.Fields("TipoABC").Value)))
                    'End If


                    ''If oRs.RecordCount = 1 Then 
                    ''verificar que es de tipocomprobante=Factura
                    'oRs.MoveFirst()

                    'mvarPuntoVenta = oRs.Fields(0).Value


                    IdPuntoVenta = EntidadManager.TablaSelectId(SC, "PuntosVenta", "PuntoVenta=" & numeropuntoVenta & " AND Letra='" & oFac.Registro.Fields("TipoABC").Value & "' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.Factura)

                    oFac.Registro.Fields("IdPuntoVenta").Value = IdPuntoVenta


                    If IdPuntoVenta = 0 Then
                        ErrHandler.WriteError("No hay talonario de facturas para el punto de venta " & numeropuntoVenta & " Letra " & oFac.Registro.Fields("TipoABC").Value)
                        Return -1
                    End If

                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////
                    'Aplico el IdPuntoVenta



                    Dim oPto 'As ComPronto.PuntoVenta 
                    oPto = oAp.PuntosVenta.Item(IdPuntoVenta)
                    With oPto.Registro
                        Dim n = .Fields("ProximoNumero").Value
                        oFac.Registro.Fields("NumeroFactura").Value = n
                        oFac.Registro.Fields("PuntoVenta").Value = numeropuntoVenta

                        .Fields("ProximoNumero").Value = n + 1
                    End With
                    oPto.Guardar()
                    oPto = Nothing

                    For i = -100 To (-100 - (oFac.DetFacturas.Count - 1)) Step -1
                        With oFac.DetFacturas.Item(i).Registro
                            'estos datos recien los tengo cuando termina
                            .Fields("NumeroFactura").Value = mNumero
                            .Fields("TipoABC").Value = mLetra
                            .Fields("PuntoVenta").Value = IdPuntoVenta
                        End With
                    Next

                    'End If
                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////

                    Debug.Print("        ComPronto paso 4 listo " & DateDiff(DateInterval.Second, tTemp, Now))
                    tTemp = Now


                    Dim idfac = TraerUltimaIdFacturaCreada(SC)


                    Try

                        Select Case .Guardar()
                            Case ICompMTSManager.MisEstados.Correcto
                            Case ICompMTSManager.MisEstados.ModificadoPorOtro
                                'MsgBox("El Regsitro ha sido modificado")
                                ErrHandler.WriteError("El Regsitro ha sido modificado")
                                Return -1
                            Case ICompMTSManager.MisEstados.NoExiste
                                'MsgBox("El registro ha sido eliminado")
                                ErrHandler.WriteError("El registro ha sido eliminado")
                                Return -1
                            Case ICompMTSManager.MisEstados.ErrorDeDatos
                                'MsgBox("Error de ingreso de datos")
                                ErrHandler.WriteError("Error de ingreso de datos")
                                Return -1
                        End Select

                    Catch ex As Exception
                        'ver si aumento el idfactura
                        Dim idfac2 = TraerUltimaIdFacturaCreada(SC)


                        Dim s As String = idfac.ToString & " " & idfac2.ToString & "Explosión al llamar a Compronto.Factura.Guardar(). Ojo porque si se generó pero no se manda a imprimir les rompe la numeración!!! " & _
                                " La factura quizas queda por la mitad y no genera el subdiario (eso es un problema del ComPronto).  Si es Type Mismatch se puede dar tanto " & _
                                " cuando se rompe la compatibilidad del COM, como cuando se rompe la compatibilidad del " & _
                                " recordset/storeproc/tabla (y esto es lo mas probable, ya que está pasando en el guardar() )" & _
                                " [verificar que desde Pronto se puede dar de alta esta misma factura con el " & _
                                " mismo cliente. Si sigue el error, verificar que están corridos los storeprocs de " & _
                                " Pronto actualizados]     Si es 'Application uses a value of the wrong type' puede ser el tipo o " & _
                                " un overflow del tipo, una cadena muy larga. Queda algún tipo de rastro en el log sql de Pronto? -no vas a" & _
                                " encontrar mucha informacion ahí. Hay que correr el Profiler mientras facturás y ver cual es la ultima llamada antes de Log_InsertarRegistro. " & _
                                " Puede ser la actualizacion de la entidad Cliente, " & _
                                " así que por Pronto hay que intentar facturarle al mismo cliente Y TAMBIEN ver si se puede editar y grabar el formulario de cliente. " & _
                                "-Por qué fue que tuvimos un problema así en Capen? Qué era lo que tenía el Clientes_M, mal el largo de un campo? " & _
                                                ex.ToString
                        ErrHandler.WriteError(s)
                        MandarMailDeError(s)

                        Return -1  'si la factura se creó, no puedo devolver lo mismo que en los otros casos

                    End Try

                End With
                idFacturaCreada = oFac.Registro.Fields(0).Value
                oFac = Nothing


                Try
                    EntidadManager.LogPronto(SC, idFacturaCreada, "Factura por ProntoWeb", Session(SESSIONPRONTO_glbIdUsuario))
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try


            Else
                'este comentario lo puse ya en un if anterior
                'AgregarMensajeProcesoPresto(oRsErrores, "La factura " & mComprobante & " ya existe, no se generará")
            End If

        Catch ex As Exception

            ErrHandler.WriteError("Error en la llamada a CreaFacturaCOMpronto. " & ex.ToString)
            MandarMailDeError(ex)
        End Try

        Debug.Print("        ComPronto paso 5 listo " & DateDiff(DateInterval.Second, tTemp, Now))
        tTemp = Now


        Return idFacturaCreada

    End Function

    Shared Function TraerUltimaIdFacturaCreada(SC) As Long

        Dim id As Long
        Try
            id = EntidadManager.ExecDinamico(SC, "SELECT MAX(IdFactura) FROM Facturas").Rows(0).Item(0)
        Catch ex As Exception
            ErrHandler.WriteError(ex)
        End Try

        Return id
    End Function

    Shared Sub RefrescaTarifaTablaTemporal(ByRef dt As DataTable, ByVal sc As String, ByVal optFacturarA As Integer, ByVal sClienteTercero As String, ByVal IdTanda As Long, Optional ByVal idClienteAfacturarle As Long = -1, Optional ByVal IdArticulo As Long = -1, Optional ByVal tarif As Double = 0, Optional ByVal exporta As Boolean = False)

        'Return

        If optFacturarA = 4 Then 'opcion a terceros
            idClienteAfacturarle = BuscaIdClientePreciso(sClienteTercero, sc)
        End If



        Dim db As New LinqCartasPorteDataContext(Encriptar(sc))

        Dim ids As Integer = IdTanda
        If ids > 0 Then



            Dim o As Generic.List(Of wTempCartasPorteFacturacionAutomatica) = _
                (From i As wTempCartasPorteFacturacionAutomatica In db.wTempCartasPorteFacturacionAutomaticas _
                        Where i.IdSesion = ids And _
                           (i.IdFacturarselaA = idClienteAfacturarle Or idClienteAfacturarle = -1) And _
                           (i.IdArticulo = IdArticulo Or IdArticulo = -1)).ToList


            'como safamos aca? me tendria que traer el campo "exporta" desde la tabla temporal, que no lo tiene
            'safo desde otro lado?

            For Each x In o
                'x.TarifaFacturada = dr.Item("TarifaFacturada")
                'todo: 8528
                If If(x.IdCartaDePorte, 0) < 0 Then
                    'es un embarque
                    x.TarifaFacturada = If(db.wTarifaWilliams(x.IdFacturarselaA, x.IdArticulo, x.IdDestino, 2, 0), 0)
                ElseIf exporta Then
                    x.TarifaFacturada = If(db.wTarifaWilliams(x.IdFacturarselaA, x.IdArticulo, x.IdDestino, 1, 0), 0)
                Else
                    x.TarifaFacturada = If(db.wTarifaWilliams(x.IdFacturarselaA, x.IdArticulo, x.IdDestino, 0, 0), 0)
                End If
            Next






            db.SubmitChanges()
        End If




        If False And optFacturarA = 4 Then 'opcion a terceros
            Try

                Dim IdFacturarselaA = BuscaIdClientePreciso(sClienteTercero, sc)

                Dim q = From i In dt.AsEnumerable _
                        Group By IdFac = i("IdFacturarselaA"), _
                                 IdArti = i("IdArticulo"), _
                                 IdDestin = iisNull(i("IdDestino"), 0) _
                            Into Group _
                        Select New With { _
                                .IdFac = IdFac, .IdArticulo = IdArti, .IdDestino = IdDestin, _
                               .Tarif = iisNull(db.wTarifaWilliams(IdFac, IdArti, IdDestin, 0, 0), 0) _
                                }



                Dim d = q.ToDataTable 'no tarda demasiado



                Dim total = 0
                For Each tarifrow In d.Rows

                    If optFacturarA = 5 Then IdFacturarselaA = tarifrow.Item("IdFac")
                    Dim idart = tarifrow.Item("IdArticulo")
                    Dim iddest = tarifrow.Item("IdDestino")
                    Dim tarifa = tarifrow.Item("Tarif")


                    Dim drcol As DataRow() = dt.Select("IdFacturarselaA=" & IdFacturarselaA & " AND IdArticulo= " & idart & " AND IdDestino=" & iddest)
                    total += drcol.Count
                    For Each r In drcol
                        r.Item("TarifaFacturada") = tarifa
                    Next

                Next





            Catch ex As Exception
                ErrHandler.WriteError("Error al actualizar la tarifa. " & ex.ToString)
            End Try

        End If


    End Sub

    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////


    Shared Function DataTableWHERE_ClientesNoHabilitados(ByVal dt As DataTable) As DataTable
        Return DataTableWHERE(dt, " CUIT is NULL OR CUIT='' OR NOT (IdCodigoIVA=1 OR IdCodigoIVA=2 OR IdCodigoIVA=9) ")
    End Function

    Shared Function DataTableWHERE_ClientesHabilitados(ByVal dt As DataTable) As DataTable
        Return DataTableWHERE(dt, " NOT isnull(CUIT,'')='' AND (IdCodigoIVA=1 OR IdCodigoIVA=2 OR IdCodigoIVA=9) ")
    End Function



    Shared Function VerificarClientesFacturables(ByRef dtGrillaPasada As DataTable, ByVal sc As String, ByVal ListaIDs As String, ByVal txtFacturarATerceros As String, ByVal optFacturarA As Integer) As String


        Dim s As String = ""


        Dim dtgrilla As DataTable

        If True Then
            dtgrilla = dtGrillaPasada 'esto esta mal. tenes q revisar el datasource entero, sin paginar


        Else
            'If optFacturarA = 5 Then
            '    'TODO: truco para que traiga TODAS las filas, sin paginar
            '    dtgrilla = GetDatatableAsignacionAutomatica(sc, ViewState, 999999, cmbPuntoVenta.Text)
            'Else
            '    dtgrilla = dtGrillaPasada 'esta es la grilla, incluye las manuales
            'End If

            'If optFacturarA.SelectedValue = 5 Then
            '    dtgrilla = GetDatatableAsignacionAutomatica(HFSC.Value, ViewState, GridView2.PageSize, cmbPuntoVenta.Text)
            '    'Dim sLinks = LinksDeCartasConflictivas(dtgrilla)
            '    'If sLinks <> "" Then s &= vbCrLf & "Cartas con conflicto en el automático: " & sLinks
            'Else
            '    dtgrilla = EntidadManager.ExecDinamico(sc, SQL_ListaDeCDPsFiltradas(" AND IdCartaDePorte IN (" & ListaIDs & ") ", _
            '            optFacturarA.SelectedValue, txtFacturarATerceros.Text, HFSC.Value, txtTitular.Text, txtCorredor.Text, _
            '            txtDestinatario.Text, txtIntermediario.Text, txtRcomercial.Text, txt_AC_Articulo.Text, txtProcedencia.Text, 
            '            txtDestino.Text, txtBuscar.Text, cmbCriterioWHERE.SelectedValue, cmbModo.Text, optDivisionSyngenta.SelectedValue, 
            '            txtFechaDesde.Text, txtFechaHasta.Text, cmbPuntoVenta.Text))
            'End If

        End If



        '/////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////
        '- Clientes provisorios: no tienen Cuit o algún otro dato necesario para facturar.

        Dim dt As DataTable

        'cuando facturo a terceros, a veces muestra como provisorio un cliente que no lo es, probablemente
        'porque en realidad el que es provisorio es el titular de la cdp, o algo así
        'SQL_ListaDeCDPsFiltradas la tiene dificil para pasarme el dato, así que lo resuelvo de manera poco elegante por acá
        If optFacturarA = 4 Then
            Dim IdFacturarselaA = BuscaIdClientePreciso(txtFacturarATerceros, sc)
            Dim facturarselaA = "'" & txtFacturarATerceros & "'"
            dt = EntidadManager.ExecDinamico(sc, _
                                "SELECT IdCodigoIVA,CUIT," & facturarselaA & " as FacturarselaA FROM CLIENTES where IdCliente=" & IdFacturarselaA)

            dt = DataTableWHERE_ClientesNoHabilitados(dt)
        Else
            'dt = DataTableWHERE(dtgrilla, "NOT (NOT CUIT is NULL AND IdCodigoIVA>0) ")
            dt = DataTableWHERE_ClientesNoHabilitados(dtgrilla)
        End If

        Try
            'no trae el IdFacturarselaA si es "a Terceros"

            dt = DataTableDISTINCT(dt, "IdFacturarselaA", "FacturarselaA")

            Dim l As New Generic.List(Of String)


            Dim sSinCUIT As String = ""
            For Each dr In dt.Rows
                'l.Add(dr.Columns("FacturarselaA"))

                'agregarlos como links
                sSinCUIT &= "<a href=""Cliente.aspx?Id=" & dr("IdFacturarselaA") & """ target=""_blank"">" & dr("FacturarselaA") & "</a>; "
            Next

            If sSinCUIT <> "" Then s &= vbCrLf & "Sin CUIT/sin confirmar/CAI vencido/Facturas 'B': " & sSinCUIT

        Catch ex As Exception
            'no trae el IdFacturarselaA si es "a Terceros"
            ErrHandler.WriteError("Ojo, no trae el IdFacturarselaA si es a Terceros")
            ErrHandler.WriteError(ex)
        End Try



        '/////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////
        '- Corredores: si no están en la tabla de clientes se llega al segundo paso y al facturar a corredor quedan vacías las casillas de Facturar a.

        Dim sCorredores As String = ""
        If optFacturarA = 3 Then
            Dim dtCorr = DataTableWHERE(dtgrilla, "ISNULL(FacturarselaA,'')=''")
            dtCorr = DataTableDISTINCT(dtCorr, "Corredor ")

            Dim l2 As New Generic.List(Of String)
            For Each dr In dtCorr.Rows
                'l.Add(dr.Columns("FacturarselaA"))
                sCorredores &= dr("Corredor ") & "; "
            Next

        End If

        If sCorredores <> "" Then s &= vbCrLf & "Corredores sin cliente asociado: " & sCorredores

        '/////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////
        'Kg en 0: a veces no se está calculando en el abm de Cartas de Porte el KgNeto final. 
        '(o sea, tiene peso de Descarga, y aparece para facturar. Pero no está el neto final)
        'Cuando esto pasa se debe controlar, de otra manera se hará una factura por 0 pesos.

        Dim sKilosEnCero As String = ""
        Dim dt0 = DataTableWHERE(dtgrilla, "isnull(KgNetos,0)=0")
        For Each dr In dt0.Rows
            'l.Add(dr.Columns("FacturarselaA"))
            sKilosEnCero &= dr("NumeroCartaDePorte") & "; "
        Next

        If sKilosEnCero <> "" Then s &= vbCrLf & "Descargas sin neto final: " & sKilosEnCero
        '/////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////

        Return s
    End Function


    Shared Function VerificarClientesFacturables(ByVal l As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult))

        'Filtra las conflictivas, y tambien las muestra en un texto.



        Dim cartasrepetidas = (From i In l _
                Group By Id = i.IdCartaDePorte, _
                                 Numero = i.NumeroCartaDePorte, _
                         SubnumeroVagon = i.SubNumeroVagon, _
                         SubNumeroFacturacion = i.SubnumeroDeFacturacion _
                    Into Group _
                Where iisNull(SubNumeroFacturacion, 0) = 0 _
                         And Group.Count() > 1 _
                Select New With {.id = Id, .Numero = Numero, .SubnumeroVagon = SubnumeroVagon}).ToList

        Dim s As String
    End Function

    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////






    Shared Sub CalculaFacturaSimplificado(ByRef oFac As Object, ByVal sc As String, ByRef session As System.Web.SessionState.HttpSessionState, puntoventa As Long, IdPuntoVenta As Long) 'As ComPronto.Factura )
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        'Codigo del CalculaFactura que esta en la gui del pronto (frmFactura)
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        Dim i As Integer, mIdProvinciaIIBB As Integer
        Dim mNumeroCertificadoPercepcionIIBB As Long
        Dim t0 As Double, t1 As Double, t2 As Double, t3 As Double, mParteDolar As Double
        Dim mPartePesos As Double, mBonificacion As Double, mKilos As Double
        Dim mPrecioUnitario As Double, mCantidad As Double, mTopeIIBB As Double
        Dim mFecha1 As Date

        Dim mTotal As Double
        Dim mvarImporteBonificacion, mvarNetoGravado, mvarPorcentajeBonificacion, mvarSubTotal, mvarCotizacion, mvarDecimales
        Dim mvarTipoABC, mvarIVANoDiscriminado, mvarPartePesos, txtPorcentajeIva2



        Dim totIVA As Double = 0



        Dim cli As Cliente = ClienteManager.GetItem(sc, oFac.Registro.Fields("IdCliente").Value)
        Dim mvarTipoIVA = cli.IdCodigoIva

        If mvarTipoIVA = 0 Then
            ErrHandler.WriteAndRaiseError("No se encuentra el IdCodigoIVA para el cliente " & oFac.Registro.Fields("IdCliente").Value)
        End If

        mvarTipoABC = LetraSegunTipoIVA(mvarTipoIVA)


        For i = -100 To (-100 - (oFac.DetFacturas.Count - 1)) Step -1

            Dim item 'As ComPronto.DetFactura  
            item = oFac.DetFacturas.Item(i)



            With item.Registro
                If Not item.Eliminado Then

                    '////////////////////////////////////////////////
                    'este pedazo está traido del DetFacturas
                    Dim mAlicuotaIVA_Material = IIf(IsNull(ArticuloManager.GetItem(sc, .Fields("idArticulo").Value).AlicuotaIVA), 0, ArticuloManager.GetItem(sc, .Fields("idArticulo").Value).AlicuotaIVA)
                    If iisNull(mAlicuotaIVA_Material, 0) = 0 Then
                        Throw New Exception("El artículo " & .Fields("idArticulo").Value & " tiene IVA en 0")
                        'errlog& = MsgBoxAjax(Me, "El artículo " & .Fields("idArticulo").Value & " tiene IVA en 0")
                    End If
                    Dim PorcentajeBonificacionOC = 0 ' IIf(IsNull(.Fields("PorcentajeBonificacionOC").Value), 0, .Fields("PorcentajeBonificacionOC").Value)

                    Dim mvarPrecio = IIf(IsNull(.Fields("PrecioUnitario").Value), 0, .Fields("PrecioUnitario").Value)
                    Dim mPorcB = 0 'IIf(IsNull(.Fields("PorcentajeBonificacion").Value), 0, .Fields("PorcentajeBonificacion").Value)



                    'ah ah ah, acá hará 0.21 x 0.56(el precio de uno de los granos), y cagaste.
                    Dim viejoiva As Double = mvarPrecio * mAlicuotaIVA_Material / 100





                    'bueno, acá empieza el show del redondeo
                    'http://msdn.microsoft.com/es-es/library/system.midpointrounding%28v=vs.110%29.aspx
                    '                    This code example produces the following results:
                    ' 3.4 = Math.Round( 3.45, 1)
                    '-3.4 = Math.Round(-3.45, 1)

                    ' 3.4 = Math.Round( 3.45, 1, MidpointRounding.ToEven)
                    ' 3.5 = Math.Round( 3.45, 1, MidpointRounding.AwayFromZero)

                    '-3.4 = Math.Round(-3.45, 1, MidpointRounding.ToEven)
                    '-3.5 = Math.Round(-3.45, 1, MidpointRounding.AwayFromZero)

                    'yo estoy facturando con ToEven, aparentemente
                    'El que usa por default Excel es el bancario (AwayFromZero). 
                    'Lo mismo el abm web y el abm de pronto (muestran el subtotal sumando como excel)




                    'la facturacion hace cant * precio =                       316.225  --->316.22   ESTA MAL
                    'en excel y el abm de pronto y el de web                            --->316.23


                    Dim cant_X_precio_redondeado = Math.Round(.Fields("Cantidad").Value * (mvarPrecio), 2, MidpointRounding.AwayFromZero)
                    mvarSubTotal += cant_X_precio_redondeado

                    ErrHandler.WriteError("cant*precio " & cant_X_precio_redondeado & " mvarSubTotal " & mvarSubTotal & " = + " & .Fields("Cantidad").Value & " *  " & mvarPrecio & "redond  * " & mAlicuotaIVA_Material & "/ 100")


                    Dim iva As Double = Math.Round(.Fields("Cantidad").Value * (mvarPrecio), 2) * mAlicuotaIVA_Material / 100

                    'el total es el total, no importa que discrimine
                    mTotal += .Fields("Cantidad").Value * (mvarPrecio + iva)

                    '
                    If mvarTipoABC = "B" And mvarTipoIVA <> 8 And _
                          EntidadManager.BuscarClaveINI("Ordenes de compra iva incluido", sc, session(SESSIONPRONTO_glbIdUsuario)) <> "SI" Then
                        'acá hace "la magia" de encajarle el iva en el precio del item (recordá que 
                        'no discriminar el iva es solo un tema de presentacion)
                        mvarPrecio = mvarPrecio + iva
                    End If

                    totIVA += iva 'Math.Round(iva * .Fields("Cantidad").Value, 2)   esto no lo debo hacer así, por lo
                    'menos para que me cierre: debo tomar el importe total del item ya redondeado, y a ese tomarle el iva.



                    .Fields("PrecioUnitario").Value = mvarPrecio
                    .Fields("PrecioUnitarioTotal").Value = mvarPrecio
                    .Fields("Bonificacion").Value = mPorcB


                    '.Fields("OrigenDescripcion").Value = .Fields("OrigenDescripcion").Value
                    '.Fields("TipoCancelacion").Value = .Fields("TipoCancelacion").Value
                    '.Fields("Costo").Value = .Fields("CostoPPP").Value

                    '////////////////////////////////////////////////////



                End If
            End With
        Next





        mvarImporteBonificacion = Math.Round(mvarSubTotal * mvarPorcentajeBonificacion / 100, 2)
        mvarNetoGravado = mvarSubTotal - mvarImporteBonificacion


        With oFac.Registro
            .Fields("RetencionIBrutos1").Value = 0
            .Fields("PorcentajeIBrutos1").Value = 0
            .Fields("RetencionIBrutos2").Value = 0
            .Fields("PorcentajeIBrutos2").Value = 0
        End With



        Dim mvarIBrutos As Double = 0
        If True Then
            Try
                Dim ccc = ExecDinamico(sc, "Select AgentePercepcionIIBB from PuntosVenta  where  IdPuntoVenta=" & IdPuntoVenta)
                mvarIBrutos = PercepcionIngresosBrutos(oFac, sc, session, cli, mvarNetoGravado, True, "SI" = iisNull(ccc.Rows(0).Item("AgentePercepcionIIBB"), "NO")) '(puntoventa = 2 Or puntoventa = 3))
            Catch ex As Exception
                ErrHandler.WriteError("Error al calcular ingresos brutos. " & ex.ToString)
            End Try
        End If


        'If mvarEsAgenteRetencionIVA = "NO" And mvarNetoGravado >= mvarBaseMinimaParaPercepcionIVA Then
        '    mvarPercepcionIVA = Math.Round(mvarNetoGravado * mvarPorcentajePercepcionIVA / 100, mvarDecimales)
        'End If


        'If mvarNumeracionUnica And mvarTipoABC <> "E" Then
        '    oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, mvarTipoABC))
        'Else
        '    oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, mvarTipoABC))
        'End If


        'mvarTotalFactura = mvarNetoGravado + mvarIVA1 + mvarIVA2 + mvarIBrutos + mvarIBrutos2 + mvarIBrutos3 + mvarPercepcionIVA + _
        '         Val(txtTotal(6).Text) + Val(txtTotal(7).Text) + Val(txtTotal(10).Text)



        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////

        ErrHandler.WriteError("mTotal       " & mTotal)
        ErrHandler.WriteError("mvarSubTotal " & mvarSubTotal)
        ErrHandler.WriteError("mvarIBrutos  " & mvarIBrutos)
        ErrHandler.WriteError("totIVA       " & totIVA)
        ErrHandler.WriteError("ImporteTotal " & Math.Round(mvarSubTotal + mvarIBrutos + Math.Round(totIVA, 2), 2))



        'agregado por mi para reasignar las cosas de la GUI falsa al objeto
        Try


            With oFac.Registro

                .Fields("TipoABC").Value = mvarTipoABC




                .Fields("ImporteTotal").Value = Math.Round(mvarSubTotal + mvarIBrutos + Math.Round(totIVA, 2), 2)   ' Math.Round(mTotal, 2)

                If mvarTipoABC = "B" And mvarTipoIVA <> 8 And _
                      EntidadManager.BuscarClaveINI("Ordenes de compra iva incluido", sc, session(SESSIONPRONTO_glbIdUsuario)) <> "SI" Then
                    .Fields("IVANoDiscriminado").Value = Math.Round(totIVA, 2) ' totIVA
                    .Fields("ImporteIva1").Value = 0
                Else
                    .Fields("ImporteIva1").Value = Math.Round(totIVA, 2)
                End If

                .Fields("IdCodigoIva").Value = mvarTipoIVA





            End With


        Catch ex As Exception
            ErrHandler.WriteAndRaiseError("Error al calcular totales. " & ex.ToString)
        End Try


    End Sub


    Private Shared Function PercepcionIngresosBrutos(ByRef oFac As Object, ByVal sc As String, ByRef session As System.Web.SessionState.HttpSessionState, cli As Cliente, mvarNetoGravado As Double, Parametros_EsAgenteDePercepcionIIBB As Boolean, Pventa_AgentePercepcionIIBB As Boolean) As Double

        'origen.Registro.Fields("NumeroCertificadoPercepcionIIBB").Value = Null

        Dim mNumeroCertificadoPercepcionIIBB
        Dim mvarIBrutos, mvarIBrutos2, mvarIBrutos3 As Decimal
        Dim mvarPorcentajeIBrutos, mvarPorcentajeIBrutos2, mvarPorcentajeIBrutos3 As Decimal
        Dim mvarMultilateral As String
        Dim mIdProvinciaIIBB, mIdProvinciaIIBBbasico

        Dim mAlicuotaDirecta
        Dim mFechaFinVigenciaIBDirecto, mFechaInicioVigenciaIBDirectoCapital, mFechaFinVigenciaIBDirectoCapital, mFechaInicioVigenciaIBDirecto
        Dim mvarIBCondicion, mFecha1, mAlicuotaDirectaCapital



        Dim fechafactura = Now
        Dim clicatiibb As Integer = cli.IBCondicion '.IdIBCondicionPorDefecto
        Dim facturaTieneCheckCategoria1 = True



        'los montos que importan son los campos "RetencionIBrutos1" / "2" / "3" 
        'no confundirse con el monto por "Otras Percepciones", que van en los campos "OtrasPercepciones1" y "OtrasPercepciones2" y "OtrasPercepciones3"
        With oFac.Registro
            .Fields("RetencionIBrutos1").Value = iisNull(mvarIBrutos, 0)  ' es importante que el campo "IdIBCondicion" esté marcado
            .Fields("PorcentajeIBrutos1").Value = iisNull(mvarPorcentajeIBrutos, 0)
            .Fields("RetencionIBrutos2").Value = iisNull(mvarIBrutos2, 0) ' es importante que el campo "IdIBCondicion2" esté marcado
            .Fields("PorcentajeIBrutos2").Value = iisNull(mvarPorcentajeIBrutos2, 0) '
            .Fields("RetencionIBrutos3").Value = iisNull(mvarIBrutos3, 0) ' ' es importante que el campo "IdIBCondicion3" esté marcado
            .Fields("PorcentajeIBrutos3").Value = iisNull(mvarPorcentajeIBrutos3, 0) '
        End With

        If Not Parametros_EsAgenteDePercepcionIIBB Then Exit Function
        If Not Pventa_AgentePercepcionIIBB Then Exit Function



        If clicatiibb = 2 Or clicatiibb = 3 Then 'Exit Function

            'importantisimo
            'importantisimo
            'importantisimo
            Dim oRs = TraerFiltradoVB6(sc, enumSPs.IBCondiciones_TX_PorId, cli.IdIBCondicionPorDefecto)
            If oRs.RecordCount > 0 Then
                oFac.Registro.Fields("IdIBCondicion").Value = cli.IdIBCondicionPorDefecto  'o "IdIBCondicion2" o "IdIBCondicion3"
                Dim mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
                mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
                mIdProvinciaIIBBbasico = mIdProvinciaIIBB
                Dim mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
                mFecha1 = IIf(IsNull(oRs.Fields("FechaVigencia").Value), Now, oRs.Fields("FechaVigencia").Value)
                Dim mCodigoProvincia = ""


                Dim oRs1 = TraerFiltradoVB6(sc, enumSPs.Provincias_TX_PorId, mIdProvinciaRealIIBB)
                If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
                oRs1.Close()
                If mCodigoProvincia = "902" And fechafactura >= mFechaInicioVigenciaIBDirecto And fechafactura <= mFechaFinVigenciaIBDirecto Then
                    mvarPorcentajeIBrutos = mAlicuotaDirecta
                ElseIf mCodigoProvincia = "901" And fechafactura >= mFechaInicioVigenciaIBDirectoCapital And fechafactura <= mFechaFinVigenciaIBDirectoCapital Then
                    mvarPorcentajeIBrutos = mAlicuotaDirectaCapital
                Else
                    If mvarNetoGravado > mTopeIIBB And fechafactura >= mFecha1 Then
                        If mvarIBCondicion = 2 Then
                            mvarPorcentajeIBrutos = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                            mvarMultilateral = "SI"
                        Else
                            mvarPorcentajeIBrutos = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
                        End If
                    End If
                End If

                mvarIBrutos = Math.Round(mvarNetoGravado * mvarPorcentajeIBrutos / 100, 2) 'Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos / 100, 2)
            End If
            oRs.Close()

        End If

        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        If clicatiibb = 2 Or clicatiibb = 3 Then 'Exit Function
            Dim oRs = TraerFiltradoVB6(sc, enumSPs.IBCondiciones_TX_PorId, cli.IdIBCondicionPorDefecto2)
            If oRs.RecordCount > 0 Then
                oFac.Registro.Fields("IdIBCondicion2").Value = cli.IdIBCondicionPorDefecto2  'o "IdIBCondicion2" o "IdIBCondicion3"
                Dim mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
                mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
                Dim mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
                mFecha1 = IIf(IsNull(oRs.Fields("FechaVigencia").Value), Now, oRs.Fields("FechaVigencia").Value)
                Dim mCodigoProvincia = ""


                Dim oRs1 = TraerFiltradoVB6(sc, enumSPs.Provincias_TX_PorId, mIdProvinciaRealIIBB)
                If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
                oRs1.Close()
                If mCodigoProvincia = "902" And fechafactura >= mFechaInicioVigenciaIBDirecto And fechafactura <= mFechaFinVigenciaIBDirecto Then
                    mvarPorcentajeIBrutos2 = mAlicuotaDirecta
                ElseIf mCodigoProvincia = "901" And fechafactura >= mFechaInicioVigenciaIBDirectoCapital And fechafactura <= mFechaFinVigenciaIBDirectoCapital Then
                    mvarPorcentajeIBrutos2 = mAlicuotaDirectaCapital
                Else
                    If mvarNetoGravado > mTopeIIBB And fechafactura >= mFecha1 Then
                        If mvarIBCondicion = 2 Then
                            mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                            mvarMultilateral = "SI"
                        Else
                            mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
                        End If
                    End If
                End If

                mvarIBrutos2 = Math.Round(mvarNetoGravado * mvarPorcentajeIBrutos2 / 100, 2) 'Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos / 100, 2)
            End If
            oRs.Close()
        End If


        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        If clicatiibb = 2 Or clicatiibb = 3 Then 'Exit Function

            Dim oRs = TraerFiltradoVB6(sc, enumSPs.IBCondiciones_TX_PorId, cli.IdIBCondicionPorDefecto3)
            If oRs.RecordCount > 0 Then
                oFac.Registro.Fields("IdIBCondicion3").Value = cli.IdIBCondicionPorDefecto3  'o "IdIBCondicion2" o "IdIBCondicion3"
                Dim mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
                mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
                Dim mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
                mFecha1 = IIf(IsNull(oRs.Fields("FechaVigencia").Value), Now, oRs.Fields("FechaVigencia").Value)
                Dim mCodigoProvincia = ""


                Dim oRs1 = TraerFiltradoVB6(sc, enumSPs.Provincias_TX_PorId, mIdProvinciaRealIIBB)
                If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
                oRs1.Close()
                If mCodigoProvincia = "902" And fechafactura >= mFechaInicioVigenciaIBDirecto And fechafactura <= mFechaFinVigenciaIBDirecto Then
                    mvarPorcentajeIBrutos3 = mAlicuotaDirecta
                ElseIf mCodigoProvincia = "901" And fechafactura >= mFechaInicioVigenciaIBDirectoCapital And fechafactura <= mFechaFinVigenciaIBDirectoCapital Then
                    mvarPorcentajeIBrutos3 = mAlicuotaDirectaCapital
                Else
                    If mvarNetoGravado > mTopeIIBB And fechafactura >= mFecha1 Then
                        If mvarIBCondicion = 2 Then
                            mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                            mvarMultilateral = "SI"
                        Else
                            mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
                        End If
                    End If
                End If

                mvarIBrutos3 = Math.Round(mvarNetoGravado * mvarPorcentajeIBrutos3 / 100, 2) 'Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos / 100, 2)
            End If
            oRs.Close()



        End If



        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////

        'mIdProvinciaIIBB viene vacio... es nullable? -es que depende... lo levantas con el IdProvincia, despues 
        'de levantar la   TraerFiltradoVB6(sc, enumSPs.IBCondiciones_TX_PorId, cli.IdIBCondicionPorDefecto-XXXXX )
        '-por qué voy a buscar las tres diferentes IdIBCondicionPorDefecto???????
        'EDU USA SOLO LA PRIMERA PROVINCIA, LO PODES VER EN EL CalculaFactura()

        If mvarIBrutos <> 0 Then
            Dim oRs2 = TraerFiltradoVB6(sc, enumSPs.Provincias_TX_PorId, mIdProvinciaIIBBbasico)
            If oRs2.RecordCount > 0 Then
                mNumeroCertificadoPercepcionIIBB = IIf(IsNull(oRs2.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value), 1, oRs2.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value)
            End If
            oFac.Registro.Fields("NumeroCertificadoPercepcionIIBB").Value = iisNull(mNumeroCertificadoPercepcionIIBB, 0)
            oRs2.Close()
        End If




        With oFac.Registro

            .Fields("RetencionIBrutos1").Value = iisNull(mvarIBrutos, 0)  ' es importante que el campo "IdIBCondicion" esté marcado
            .Fields("PorcentajeIBrutos1").Value = iisNull(mvarPorcentajeIBrutos, 0)
            .Fields("RetencionIBrutos2").Value = iisNull(mvarIBrutos2, 0) ' es importante que el campo "IdIBCondicion2" esté marcado
            .Fields("PorcentajeIBrutos2").Value = iisNull(mvarPorcentajeIBrutos2, 0) '
            .Fields("ConvenioMultilateral").Value = iisNull(mvarMultilateral, "NO")
            .Fields("RetencionIBrutos3").Value = iisNull(mvarIBrutos3, 0) ' ' es importante que el campo "IdIBCondicion3" esté marcado
            .Fields("PorcentajeIBrutos3").Value = iisNull(mvarPorcentajeIBrutos3, 0) '


            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            Try

                'el numerador de certificado es por provincia
                Dim dt = ExecDinamico(sc, "SELECT ProximoNumeroCertificadoPercepcionIIBB from provincias where IdProvincia=" & mIdProvinciaIIBB)
                Dim numcertif As Long
                If dt.Rows.Count > 0 Then numcertif = iisNull(dt.Rows(0).Item(0), 1)
                ExecDinamico(sc, "UPDATE  provincias set ProximoNumeroCertificadoPercepcionIIBB= " & numcertif + 1 & " where IdProvincia=" & mIdProvinciaIIBB)

                .Fields("NumeroCertificadoPercepcionIIBB").Value = numcertif
            Catch ex As Exception
                ErrHandlerWriteErrorLogPronto(ex.ToString, sc, "")
            End Try

            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
        End With

        Return mvarIBrutos



        'If dcfields(5).Enabled And Check1(1).Value = 1 And IsNumeric(dcfields(5).BoundText) Then
        '    oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(5).BoundText)
        '    If oRs.RecordCount > 0 Then
        '        mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
        '        mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
        '        mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
        '        mCodigoProvincia = ""
        '        oRs1 = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaRealIIBB)
        '        If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
        '        oRs1.Close()
        '        If mCodigoProvincia = "902" And DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
        '            mvarPorcentajeIBrutos2 = mAlicuotaDirecta
        '        ElseIf mCodigoProvincia = "901" And DTFields(0).Value >= mFechaInicioVigenciaIBDirectoCapital And DTFields(0).Value <= mFechaFinVigenciaIBDirectoCapital Then
        '            mvarPorcentajeIBrutos2 = mAlicuotaDirectaCapital
        '        Else
        '            If mvarNetoGravado > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
        '                If mvarIBCondicion = 2 Then
        '                    mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
        '                    mvarMultilateral = "SI"
        '                Else
        '                    mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
        '                End If
        '            End If
        '        End If
        '        mvarIBrutos2 = Round(mvarNetoGravado * mvarPorcentajeIBrutos2 / 100, 2)  'Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos2 / 100, 2)
        '    End If
        '    oRs.Close()
        '    oRs = Nothing
        'End If





        'If dcfields(6).Enabled And Check1(2).Value = 1 And IsNumeric(dcfields(6).BoundText) Then
        '    oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(6).BoundText)
        '    If oRs.RecordCount > 0 Then
        '        mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
        '        mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
        '        mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
        '        mCodigoProvincia = ""
        '        oRs1 = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaRealIIBB)
        '        If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
        '        oRs1.Close()
        '        If mCodigoProvincia = "902" And DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
        '            mvarPorcentajeIBrutos3 = mAlicuotaDirecta
        '        ElseIf mCodigoProvincia = "901" And DTFields(0).Value >= mFechaInicioVigenciaIBDirectoCapital And DTFields(0).Value <= mFechaFinVigenciaIBDirectoCapital Then
        '            mvarPorcentajeIBrutos3 = mAlicuotaDirectaCapital
        '        Else
        '            If mvarNetoGravado > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
        '                If mvarIBCondicion = 2 Then
        '                    mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
        '                    mvarMultilateral = "SI"
        '                Else
        '                    mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
        '                End If
        '            End If
        '        End If
        '        mvarIBrutos3 = Round(mvarNetoGravado * mvarPorcentajeIBrutos3 / 100, 2)  'Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos3 / 100, 2)
        '    End If
        '    oRs.Close()
        '    oRs = Nothing
        'End If



    End Function





    Public Shared Sub AgregarMensajeProcesoPresto(ByRef oRsErrores As ADODB.Recordset, ByVal Mensaje As String)

        'oRsErrores.AddNew()
        'oRsErrores.Fields(0).Value = 0
        'oRsErrores.Fields(1).Value = Mensaje
        'oRsErrores.Update()

    End Sub


    Shared Function CAIsegunPuntoVenta(ByVal Letra As String, ByVal puntoVenta As Long, ByVal SC As String) As String
        Try

            Dim mvarPuntoVenta = EntidadManager.TablaSelectId(SC, "PuntosVenta", "PuntoVenta=" & puntoVenta & " AND Letra='" & Letra & "'")

            Dim mvarCAI_v, mvarFechaCAI_v As String

            '"SELECT NumeroCAI_C_A from PuntosVenta where
            'oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(10).BoundText)
            Select Case Letra
                Case "A"
                    mvarCAI_v = "NumeroCAI_F_A"
                    mvarFechaCAI_v = "FechaCAI_F_A"
                Case "B"
                    mvarCAI_v = "NumeroCAI_F_B"
                    mvarFechaCAI_v = "FechaCAI_F_B"
                Case "E"
                    mvarCAI_v = "NumeroCAI_F_E"
                    mvarFechaCAI_v = "FechaCAI_F_E"
            End Select

            CAIsegunPuntoVenta = EntidadManager.TablaSelect(SC, mvarCAI_v, "PuntosVenta", "IdPuntoVenta", mvarPuntoVenta)
            Return CAIsegunPuntoVenta

        Catch ex As Exception
            ErrHandler.WriteError("No se encontró el CAI para PuntoVenta=" & puntoVenta & " AND Letra='" & Letra & "'")
            Return ""
        End Try


        'mvarCAI = ""
        'mvarFechaCAI = DateSerial(2000, 1, 1)
        'If Len(mvarCAI_v) > 0 Then
        '    If Not IsNull(oRs.Fields(mvarCAI_v).Value) Then mvarCAI = oRs.Fields(mvarCAI_v).Value
        '    If Not IsNull(oRs.Fields(mvarFechaCAI_v).Value) Then mvarFechaCAI = oRs.Fields(mvarFechaCAI_v).Value
        'End If
        'mWS = IIf(IsNull(oRs.Fields("WebService").Value), "", oRs.Fields("WebService").Value)
        'mModoTest = IIf(IsNull(oRs.Fields("WebServiceModoTest").Value), "", oRs.Fields("WebServiceModoTest").Value)
        'oRs.Close()
        'oRs = Nothing
        'If Len(mvarCAI_v) > 0 And DTFields(0).Value > mvarFechaCAI Then
        '    MsgBox("El CAI vencio el " & mvarFechaCAI & ", no puede grabar el comprobante", vbExclamation)
        '    Exit Function
        'End If
    End Function

    Shared Function LetraSegunTipoIVA(ByVal mvarTipoIVA As Long) As String
        Dim mvarTipoABC As String
        'If Session("glbIdCodigoIva") = 1 Then
        If True Then
            Select Case mvarTipoIVA
                Case 1
                    'acá calcula el iva usando el neto total. por qué no lo hace por item como corresponde?
                    'mvarIVA1 = Math.Round(mvarNetoGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
                    'mvarPartePesos = mvarPartePesos + Math.Round((mvarPartePesos + (mvarParteDolares * mvarCotizacion)) * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
                    mvarTipoABC = "A"
                Case 2
                    'acá calcula el iva usando el neto total. por qué no lo hace por item como corresponde?
                    'mvarIVA1 = Math.Round(mvarNetoGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
                    'mvarIVA2 = Math.Round(mvarNetoGravado * Val(txtPorcentajeIva2.Text) / 100, mvarDecimales)
                    'mvarPartePesos = mvarPartePesos + Math.Round((mvarPartePesos + (mvarParteDolares * mvarCotizacion)) * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales) + _
                    'Math.Round((mvarPartePesos + (mvarParteDolares * mvarCotizacion)) * Val(txtPorcentajeIva2.Text) / 100, mvarDecimales)
                    mvarTipoABC = "A"
                Case 3
                    mvarTipoABC = "E"
                Case 8
                    mvarTipoABC = "B"
                Case 9
                    mvarTipoABC = "A"
                Case Else
                    'mvarIVANoDiscriminado = Math.Round(mvarNetoGravado - (mvarNetoGravado / (1 + (Val(txtPorcentajeIva1.Text) / 100))), mvarDecimales)
                    mvarTipoABC = "B"
            End Select
        Else
            mvarTipoABC = "C"
        End If

        Return mvarTipoABC
    End Function


    Shared Sub FormatearFacturaSegunSeSepareONoSeparador_Leyenda_Corredor_Separador(ByRef oListaCDP As System.Collections.Generic.List(Of Pronto.ERP.BO.CartaDePorte), ByRef oFac As Object, ByRef IdClienteAFacturarle As Long, ByVal SeSeparaPorCorredor As Boolean, ByVal sc As String, ByVal txtCorredor As String, ByVal chkPagaCorredor As Boolean)
        Dim listaPresentesEnEstaFactura As New Generic.List(Of String)


        For Each i In oListaCDP
            If False Then
                If Not _DEBUG_FACTURACION_PRECIOS Then
                    CartaDePorteManager.ActualizarPrecioFacturado(sc, i.Id, i.TarifaCobradaAlCliente) 'esto es cualquiera...
                End If
            End If

            If SeSeparaPorCorredor Then
                listaPresentesEnEstaFactura.Add(EntidadManager.NombreVendedor(sc, i.Corredor)) 'observaciones del encabezado
            Else
                listaPresentesEnEstaFactura.Add(EntidadManager.NombreCliente(sc, i.Titular)) 'observaciones del encabezado
            End If

        Next

        'hago un distinct
        Dim strPresentesEnEstaFactura = Join(listaPresentesEnEstaFactura.Distinct.ToArray, ", ")

        '//////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////

        'If chkMostrarCorredoresApartadosEnObservaciones.checked Then
        'If Not (optFacturarA.SelectedValue = 3 And txtCorredor.Text = "") Then
        'Consulta 8081
        'Si le facturan al titular, el strPresentesEnEstaFactura tiene corredores. Lo muestro si solo hay uno, y si es separado
        'solo mostrarlo si está separado al corredor, o si se eligió explicitamente el corredor como filtro

        Dim flagForzar = False
        Dim VariosCorredores = False

        If txtCorredor <> "" Then            'filtraron por corredor explicitamente, así que lo muestro
            flagForzar = True
            VariosCorredores = False
        ElseIf strPresentesEnEstaFactura <> "" And listaPresentesEnEstaFactura.Distinct.Count <= 1 And strPresentesEnEstaFactura <> "varios" Then
            'capo, si NO está separando por corredor, listaPresentesEnEstaFactura tiene los titulares
            ' http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11500
            VariosCorredores = False

            'confirmo que el unico corredor presente esté separado             '-guarda, en ALABERN, FABREGA & CIA S.A. hay una coma, y pensó q eran varios corredores....
            If CartaDePorteManager.EsteCorredorSeleFacturaAlClientePorSeparadoId(IdClienteAFacturarle, oListaCDP(0).Corredor, sc) > 0 Then
                flagForzar = True
            End If
        Else
            'mas de un corredor, no se imprime la obsevacion
            VariosCorredores = True
        End If



        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '        http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8531
        'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultasCumplidos1.php?recordid=10392
        'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11500
        'https://prontoweb.williamsentregas.com.ar/ProntoWeb/Factura.aspx?Id=56385


        '        Hay inconvenientes con la impresión del corredor en la factura (y grabación del mismo en la factura para el Pronto):

        '*      En facturas confeccionadas con el automático se imprime el Corredor para Clientes que no tienen al Corredor en el 
        '  campo \"Separar a\" (EJ: 2-46652;3-22564;4-595;4-647;1-23010;3-22939;2-46779)
        '   al cliente "BEN TEVI" se le facturó, y en esa factura dice corredor "ZENI", y el cliente tiene vacío el "separar a"

        '
        '*      Aparentemente sucede lo mismo con la facturación manual (sin que el Cliente tenga al Corredor en \"Separar a\" ni 
        '  tampoco se haya elegido un Corredor en el paso 1) No me dieron ejemplos de este tema
        '
        '*      También comentan que sucede lo contrario: en casos que el Cliente tiene un Corredor en el campo \"Separar a\" la 
        'factura se separa pero no sale impreso.

        'Este tema es importante porque que en la factura aparezca el corredor implica que esta se debe cobrar al mismo y deben 
        'tener registro de cuales son.
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        'todo:
        'que pasa cuando se imprime manualmente, y la separacion es implicita? creo recordar que era una excepcion.... o
        'por lo menos había excepciones, no sé si esta... quiero decir, que era un matete


        LogPronto(sc, -1, "FactWilliamsObs " & flagForzar & " " & VariosCorredores & " " & SeSeparaPorCorredor & "  " & chkPagaCorredor & "  " & strPresentesEnEstaFactura & " para cliente " & IdClienteAFacturarle & " - " & txtCorredor, "")



        Dim idvend As Integer



        'chkpagacorredor esta siempre prendido. O sea que el corredor puede no haber sido filtrador explicitado, ni estar como separado en la configuracion del cliente, y 
        'con tener un nombre distinto que el cliente, ya aparece en las observaciones!


        If flagForzar Then ' Or (SeSeparaPorCorredor And chkPagaCorredor And Not VariosCorredores) Then
            'solo un detalle, no hay que aclarar nunca en el encabezado si se está separando a un titular,
            ' en todo caso ellos elegiran que en el detalle se imprima el titular en cada renglon

            If strPresentesEnEstaFactura <> NombreCliente(sc, IdClienteAFacturarle) Then
                'solo pongo el corredor cuando es uno solo


                'si lo haces así, basta conque haya un solo corredor en la factura que no sea el mismo cliente, para que aparezca en la observacion
                'pero tambien hay que verificar que esté separado en la configuracion



                If SeSeparaPorCorredor Then

                    oFac.Registro.Fields("Observaciones").Value = IIf(SeSeparaPorCorredor, "Corredor: ", "Titular: ") + strPresentesEnEstaFactura
                Else
                    'facturada a corredores, separada a titulares

                    'Factura Williams Separada por titular: True False  True  0  ALFA GRAIN S.R.L. para cliente 4883
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10392
                    'andy, por lo del corredor: cuando se elige facturar a corredores (o a terceros y este es corredor), se separa por titular. y es por esto q no aparece la observacion


                    LogPronto(sc, -1, "Factura Williams Separada por titular: " & flagForzar & " " & _
                              SeSeparaPorCorredor & "  " & chkPagaCorredor & "  " & idvend & "  " & _
                              strPresentesEnEstaFactura & " para cliente " & IdClienteAFacturarle, "")
                End If


                'pero q paso entonces con el tema de la http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8997 ???
                'factura: https://prontoweb.williamsentregas.com.ar/ProntoWeb/Factura.aspx?Id=39013
                'había más de un corredor???

            Else
                LogPronto(sc, -1, "Factura Williams sin corredor en obs. regla 2" & flagForzar & " " & SeSeparaPorCorredor & "  " & chkPagaCorredor & "  " & idvend & "  " & strPresentesEnEstaFactura & " para cliente " & IdClienteAFacturarle, "")
            End If

            idvend = BuscaIdVendedorPreciso(strPresentesEnEstaFactura, sc)
            oFac.Registro.Fields("IdVendedor").Value = idvend

            LogPronto(sc, -1, "IdVendedor usado en factura Williams " & idvend & strPresentesEnEstaFactura & " para cliente " & IdClienteAFacturarle, "")


        Else

            LogPronto(sc, -1, "Factura Williams sin corredor en obs. regla 2" & flagForzar & " " & SeSeparaPorCorredor & "  " & chkPagaCorredor & "  " & idvend & "  " & strPresentesEnEstaFactura & " para cliente " & IdClienteAFacturarle, "")

        End If

    End Sub


    Shared Function SQLSTRING_FacturacionCartas_por_Titular(ByVal sWHEREadicional As String, ByVal sc As String, sesionid As String) As DataTable

        '///////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////
        'agregar automatico por campo "Titular"
        '///////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////







        Dim strSQL = _
"        SELECT DISTINCT 0 as ColumnaTilde " & _
",IdCartaDePorte, CDP.IdArticulo,       " & _
"        NumeroCartaDePorte, SubNumeroVagon,CDP.SubnumeroDeFacturacion, FechaArribo, FechaDescarga, " & _
" CLIVEN.razonsocial as FacturarselaA,  CLIVEN.idcliente as IdFacturarselaA " & _
"             		  ,isnull(CLIVEN.Confirmado,'NO') as Confirmado,           CLIVEN.IdCodigoIVA " & _
" 		  ,CLIVEN.CUIT,           '' as ClienteSeparado , " & _
" 		 dbo.wTarifaWilliams(CLIVEN.idcliente,CDP.IdArticulo,CDP.Destino, case when isnull(Exporta,'NO')='SI' then 1 else 0 end,0) as TarifaFacturada    " & _
 "        ,Articulos.Descripcion as  Producto, " & _
  "        NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,    CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,            " & _
" 		 CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,    " & _
" 		 CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],     " & _
" 		 CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " & _
" 		 ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino, CDP.AgregaItemDeGastosAdministrativos " & _
"   from CartasDePorte CDP " & _
" inner join wGrillaPersistencia  on CDP.IdCartaDePorte=wGrillaPersistencia.idrenglon and wGrillaPersistencia.Sesion='" & sesionid & "'" & _
"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " & _
"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIVEN.idListaPrecios = LPD.idListaPrecios " & _
"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " & _
"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " & _
"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " & _
"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " & _
"   LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente  " & _
"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " & _
"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " & _
"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " & _
"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " & _
"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " & _
"   where isnull(CDP.IdClienteAFacturarle,-1) <= 0 "




        strSQL += sWHEREadicional




        Try
            Dim dt = EntidadManager.ExecDinamico(sc, strSQL)
            Return dt

        Catch ex As Exception
            'se estaria quejando porque en el IN (123123,4444,......) hay una banda de ids
            MandarMailDeError("se estaria quejando porque en el IN (123123,4444,......) hay una banda de ids   " + ex.ToString)
            Throw

            '        http://stackoverflow.com/questions/7804201/sql-server-query-processor-ran-out-of-internal-resources

            '        /ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados
            'User:       factsl()
            '            Exception(Type) : System.Data.SqlClient.SqlException()
            'Message:	Internal Query Processor Error: The query processor ran out of stack space during query optimization.
            'Stack Trace:	 at Microsoft.VisualBasic.CompilerServices.Symbols.Container.InvokeMethod(Method TargetProcedure, Object[] Arguments, Boolean[] CopyBack, BindingFlags Flags)
            'at Microsoft.VisualBasic.CompilerServices.NewLateBinding.CallMethod(Container BaseReference, String MethodName, Object[] Arguments, String[] ArgumentNames, Type[] TypeArguments, Boolean[] CopyBack, BindingFlags InvocationFlags, Boolean ReportErrors, ResolutionFailure& Failure)
            'at Microsoft.VisualBasic.CompilerServices.NewLateBinding.LateCall(Object Instance, Type Type, String MemberName, Object[] Arguments, String[] ArgumentNames, Type[] TypeArguments, Boolean[] CopyBack, Boolean IgnoreReturn)
            'at Pronto.ERP.Dal.GeneralDB.ExecDinamico(String SC, String comandoSQLdinamico, Int32 timeoutSegundos) in C:\Backup\BDL\DataAccess\GeneralDB.vb:line 300
            'at Pronto.ERP.Bll.EntidadManager.ExecDinamico(String SC, String sComandoDinamico, Int32 timeoutSegundos) in C:\Backup\BDL\BussinessLogic\EntidadManager.vb:line 358
            'at LogicaFacturacion.SQLSTRING_FacturacionCartas_por_Titular(String sWHEREadicional, String sc, String sesionid)
            'at LogicaFacturacion.generarTablaParaModosNoAutomaticos(String sc, StateBag ViewState, String sLista, String sWHEREadicional, Int64 optFacturarA, String txtFacturarATerceros, String HFSC, String txtTitular, String txtCorredor, String txtDestinatario, String txtIntermediario, String txtRcomercial, String txt_AC_Articulo, String txtProcedencia, String txtDestino, String txtBuscar, String cmbCriterioWHERE, String cmbmodo, String optDivisionSyngenta, String txtFechaDesde, String txtFechaHasta, String cmbPuntoVenta, String sesionId, Int64 startRowIndex, Int64 maximumRows, String txtclienteauxiliar, String& sErrores)

        End Try


    End Function









    '    Shared Function ListaUsandoAsignacionAutomatica(Optional ByVal sWHEREadicional As String = "") As String

    '        'sin cliente automatico
    '        'Si una Carta de Porte no tiene ningún cliente que tenga marcado en que si aparece en 
    '        'esa posición se le debe facturar, entonces se le facturará al 
    '        'Titular (De cualquier manera mostrar una advertencia de que se está tomando el Titular porque no hay otro cliente definido)

    '        '        'mas de un cliente posible
    '        'Si una Carta de Porte tiene más de un cliente que están en una posición en la cuál se le debe 
    '        'facturar, entonces advertir y preguntar a quién se factura. Si se debe facturar a más de un 
    '        'cliente, se deben seguir los pasos para crear copias de la Carta de Porte.

    '        '        'duplicada con cliente explicito. Qué hacer si en estos casos tambien hay un juego de cliente?
    '        'Si una Carta de Porte está duplicada porque se debe facturar a más de 
    '        'un cliente, aparecerá tantas veces como copias haya y cada una se facturará 
    '        'a nombre del cliente elegido en ellas. Mostrar el subnúmero. (Ver más abajo)



    '        Dim strSQL = "select distinct * from (  "

    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        'agregar automatico por campo "Titular"
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////


    '        strSQL &= _
    '"        SELECT DISTINCT 0 as ColumnaTilde " & _
    '",IdCartaDePorte, CDP.IdArticulo,       " & _
    '"        NumeroCartaDePorte, SubNumeroVagon,CDP.SubnumeroDeFacturacion, FechaArribo, FechaDescarga, " & _
    '" CLIVEN.razonsocial as FacturarselaA,  CLIVEN.idcliente as IdFacturarselaA " & _
    '"             		  ,isnull(CLIVEN.Confirmado,'NO') as Confirmado,           CLIVEN.IdCodigoIVA " & _
    '" 		  ,CLIVEN.CUIT,           '' as ClienteSeparado , " & _
    '" 		 0.0 as TarifaFacturada    " & _
    ' "        ,Articulos.Descripcion as  Producto, " & _
    '  "        NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,    CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,            " & _
    '" 		 CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,    " & _
    '" 		 CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],     " & _
    '" 		 CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " & _
    '" 		 ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino " & _
    '"   from CartasDePorte CDP " & _
    '"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " & _
    '"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIVEN.idListaPrecios = LPD.idListaPrecios " & _
    '"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " & _
    '"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " & _
    '"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " & _
    '"   LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente  " & _
    '"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " & _
    '"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " & _
    '"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " & _
    '"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " & _
    '"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " & _
    '"   INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta " & _
    '"   where CLIVEN.SeLeFacturaCartaPorteComoTitular='SI' " & _
    '           "   and isnull(CDP.IdClienteAFacturarle,-1) <= 0 " & _
    '           " and isnull(IdFacturaImputada,0)<=0 "



    '        ' strSQL += sWHEREadicional


    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        'agregar automatico por campo "Intermediario (CLICO1)"
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////


    '        strSQL += _
    '"           union " & _
    '"   SELECT DISTINCT 0 as ColumnaTilde " & _
    '"   ,IdCartaDePorte, CDP.IdArticulo, " & _
    '        "   NumeroCartaDePorte, SubNumeroVagon,CDP.SubnumeroDeFacturacion   , FechaArribo,        FechaDescarga  ,   " & _
    '"   CLICO1.razonsocial as FacturarselaA,  CLICO1.idcliente as IdFacturarselaA " & _
    '"   	  ,isnull(CLICO1.Confirmado,'NO') as Confirmado,           CLICO1.IdCodigoIVA " & _
    '"   		  ,CLICO1.CUIT,           '' as ClienteSeparado , " & _
    '" 		 0 as TarifaFacturada    " & _
    '        "   ,Articulos.Descripcion as  Producto, " & _
    '         "   NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,     CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,           " & _
    '   "   CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,   " & _
    '   "   CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],    " & _
    '   "   CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " & _
    '                   "   ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino " & _
    '"   from CartasDePorte CDP " & _
    '"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " & _
    '"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICO1.idListaPrecios = LPD.idListaPrecios " & _
    '"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " & _
    '"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " & _
    '"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " & _
    '"   LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente  " & _
    '"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " & _
    '"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " & _
    '"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " & _
    '"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " & _
    '"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " & _
    '"   INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta " & _
    '                "   where CLICO1.SeLeFacturaCartaPorteComoIntermediario='SI'" & _
    '        "   and isnull(CDP.IdClienteAFacturarle,-1) <= 0 "




    '        'strSQL += sWHEREadicional

    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        'agregar automatico por campo "RemComercial (CLICO2)"
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////


    '        strSQL += _
    '"           union " & _
    '"   SELECT DISTINCT 0 as ColumnaTilde " & _
    '"   ,IdCartaDePorte, CDP.IdArticulo, " & _
    '"   NumeroCartaDePorte, SubNumeroVagon ,CDP.SubnumeroDeFacturacion  , FechaArribo,        FechaDescarga  ,   " & _
    '"   CLICO2.razonsocial as FacturarselaA,  CLICO2.idcliente as IdFacturarselaA " & _
    '"   	  ,isnull(CLICO2.Confirmado,'NO') as Confirmado,           CLICO2.IdCodigoIVA " & _
    '"   		  ,CLICO2.CUIT,           '' as ClienteSeparado , " & _
    '" 		 0 as TarifaFacturada    " & _
    '"   ,Articulos.Descripcion as  Producto, " & _
    ' "   NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,    CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,            " & _
    '"   CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,   " & _
    '"   CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],    " & _
    '"   CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " & _
    '           "   ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino " & _
    '"   from CartasDePorte CDP " & _
    '"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " & _
    '"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICO2.idListaPrecios = LPD.idListaPrecios " & _
    '"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " & _
    '"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " & _
    '"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " & _
    '"   LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente  " & _
    '"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " & _
    '"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " & _
    '"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " & _
    '"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " & _
    '"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " & _
    ' "   INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta " & _
    '       "   where CLICO2.SeLeFacturaCartaPorteComoRemComercial='SI'" & _
    '        "   and isnull(CDP.IdClienteAFacturarle,-1) <= 0 " & _
    '           " and isnull(IdFacturaImputada,0)<=0 "





    '        ' strSQL += sWHEREadicional

    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        'agregar automatico por campo "Destinatario"
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////

    '        strSQL += _
    '"           union " & _
    '"   SELECT DISTINCT 0 as ColumnaTilde " & _
    '"   ,IdCartaDePorte, CDP.IdArticulo, " & _
    '"   NumeroCartaDePorte, SubNumeroVagon  ,CDP.SubnumeroDeFacturacion , FechaArribo,        FechaDescarga  ,   " & _
    '"   CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA " & _
    '"   	  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,           CLIENT.IdCodigoIVA " & _
    '"   		  ,CLIENT.CUIT,           '' as ClienteSeparado , " & _
    '" 		 0 as TarifaFacturada    " & _
    '"   ,Articulos.Descripcion as  Producto, " & _
    ' "   NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,   CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,             " & _
    '"   CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,   " & _
    '"   CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],    " & _
    '"   CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " & _
    '           "   ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino " & _
    '"   from CartasDePorte CDP " & _
    '"   LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente  " & _
    '"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIENT.idListaPrecios = LPD.idListaPrecios " & _
    '"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " & _
    '"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " & _
    '"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " & _
    '"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " & _
    '"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " & _
    '"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " & _
    '"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " & _
    '"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " & _
    '"   INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta " & _
    '        "   where CLIENT.SeLeFacturaCartaPorteComoDestinatario='SI'" & _
    '        "   and isnull(CDP.IdClienteAFacturarle,-1) <= 0 " & _
    '           " and isnull(IdFacturaImputada,0)<=0 "





    '        '        strSQL += sWHEREadicional

    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        'agregar automatico por campo "Corredor"
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////

    '        strSQL += _
    '"           union " & _
    '"   SELECT DISTINCT 0 as ColumnaTilde " & _
    '"   ,IdCartaDePorte, CDP.IdArticulo, " & _
    '"   NumeroCartaDePorte, SubNumeroVagon,CDP.SubnumeroDeFacturacion   , FechaArribo,        FechaDescarga  ,   " & _
    '"   CLICORCLI.razonsocial as FacturarselaA,  CLICORCLI.idcliente as IdFacturarselaA " & _
    '"   	  ,isnull(CLICORCLI.Confirmado,'NO') as Confirmado,           CLICORCLI.IdCodigoIVA " & _
    '"   		  ,CLICORCLI.CUIT,           '' as ClienteSeparado , " & _
    '" 		 0 as TarifaFacturada    " & _
    '"   ,Articulos.Descripcion as  Producto, " & _
    ' "   NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,  CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,              " & _
    '"   CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,   " & _
    '"   CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],    " & _
    '"   CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " & _
    '           "   ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino " & _
    '"   from CartasDePorte CDP " & _
    '"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " & _
    '"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " & _
    '"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICORCLI.idListaPrecios = LPD.idListaPrecios " & _
    '"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente  " & _
    '"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " & _
    '"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " & _
    '"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " & _
    '"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " & _
    '"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " & _
    ' "   INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta " & _
    '       "   where CLICORCLI.SeLeFacturaCartaPorteComoCorredor='SI'" & _
    '        "   and isnull(CDP.IdClienteAFacturarle,-1) <= 0 " & _
    '           " and isnull(IdFacturaImputada,0)<=0 "






    '        'strSQL += sWHEREadicional

    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        'agregar los duplicados con cliente facturable explícito   -por qué esta dos veces? 
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////

    '        strSQL += _
    '"           union " & _
    '"   SELECT DISTINCT 0 as ColumnaTilde " & _
    '"   ,IdCartaDePorte, CDP.IdArticulo, " & _
    '"   NumeroCartaDePorte, SubNumeroVagon ,CDP.SubnumeroDeFacturacion  , FechaArribo,        FechaDescarga  ,   " & _
    '"   CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA " & _
    '"   	  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,           CLIENT.IdCodigoIVA " & _
    '"   		  ,CLIENT.CUIT,           '' as ClienteSeparado , " & _
    '" 		 0 as TarifaFacturada    " & _
    '"   ,Articulos.Descripcion as  Producto, " & _
    ' "   NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,      CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,          " & _
    '"   CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,   " & _
    '"   CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],    " & _
    '"   CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " & _
    '           "   ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino " & _
    '"   from CartasDePorte CDP " & _
    '"   LEFT OUTER JOIN Clientes CLIENT ON CDP.IdClienteAFacturarle = CLIENT.IdCliente  " & _
    '"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON isnull(CLIENT.idListaPrecios,1 ) = LPD.idListaPrecios " & _
    '"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " & _
    '"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " & _
    '"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " & _
    '"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " & _
    '"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " & _
    '"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " & _
    '"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " & _
    '"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " & _
    ' "   INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta " & _
    '       "   where CDP.IdClienteAFacturarle > 0 "

    '        'strSQL += sWHEREadicional



    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        'agregar los duplicados con cliente facturable explícito   -por qué esta dos veces?
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////

    '        strSQL += _
    '"           union " & _
    '"   SELECT DISTINCT 0 as ColumnaTilde " & _
    '"   ,CDPduplicadas.IdCartaDePorte, CDP.IdArticulo, " & _
    '"   CDP.NumeroCartaDePorte, CDP.SubNumeroVagon ,CDP.SubnumeroDeFacturacion  , CDP.FechaArribo,        CDP.FechaDescarga  ,   " & _
    '"   CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA " & _
    '"   	  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,           CLIENT.IdCodigoIVA " & _
    '"   		  ,CLIENT.CUIT,           '' as ClienteSeparado , " & _
    '" 		 0 as TarifaFacturada    " & _
    '"   ,Articulos.Descripcion as  Producto, " & _
    ' "   CDP.NetoFinal  as  KgNetos , CDP.Corredor as IdCorredor, CDP.Vendedor as IdTitular,   CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,       " & _
    '"   CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,   " & _
    '"   CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],    " & _
    '"   CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " & _
    '           "   ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino " & _
    '"   from CartasDePorte CDP " & _
    '"   LEFT OUTER JOIN CartasDePorte CDPduplicadas ON CDP.NumeroCartaDePorte = CDPduplicadas.NumeroCartaDePorte and  CDP.SubNumeroVagon = CDPduplicadas.SubNumeroVagon and CDPduplicadas.SubnumeroDeFacturacion>0 " & _
    '"   LEFT OUTER JOIN Clientes CLIENT ON CDPduplicadas.IdClienteAFacturarle = CLIENT.IdCliente  " & _
    '"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON isnull(CLIENT.idListaPrecios,1 ) = LPD.idListaPrecios " & _
    '"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " & _
    '"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " & _
    '"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " & _
    '"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " & _
    '"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " & _
    '"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " & _
    '"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " & _
    '"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " & _
    '"   INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta " & _
    '"   where CDP.IdClienteAFacturarle > 0 "

    '        'strSQL += sWHEREadicional.Replace("IdCartaDePorte", "CDP.IdCartaDePorte")













    '        'TODO: como hacer un distinct de cartaporte-clientefacturado, despues de hacer el union? -pero por qué se repite el renglon, o
    '        'mejor dicho, qué tienen de distinto los repetidos? -El destino, la tarifa






    '        strSQL &= "    )  as CDP "



    '        If False Then
    '            strSQL += "WHERE 1=1 " & sWHEREadicional.Replace("IdCartaDePorte", "CDP.IdCartaDePorte")
    '        Else
    '            'strSQL += " INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta"
    '        End If


    '        Return strSQL






    '        Dim idVendedor = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
    '        Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
    '        Dim idDestinatario = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
    '        Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
    '        Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
    '        Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
    '        Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
    '        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)
    '        'Dim idCuentaOrden1 = BuscaIdClientePreciso( txttxtDestinatario.Text, HFSC.Value)
    '        'Dim idCuentaOrden2 = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)



    '        Dim strWHERE As String = "    WHERE 1=1 "




    '        Dim QueContenga = txtBuscar.Text
    '        If QueContenga <> "" Then
    '            Dim idVendedorQueContiene = BuscaIdClientePreciso(QueContenga, HFSC.Value)
    '            Dim idCorredorQueContiene = BuscaIdVendedorPreciso(QueContenga, HFSC.Value)

    '            If idVendedorQueContiene <> -1 Or idCorredorQueContiene <> -1 Then

    '                strWHERE += "  " & _
    '                 "           AND (CDP.Vendedor = " & idVendedorQueContiene & _
    '                "           OR CDP.CuentaOrden1 = " & idVendedorQueContiene & _
    '                "           OR CDP.CuentaOrden2 = " & idVendedorQueContiene & _
    '                "             OR CDP.Entregador=" & idVendedorQueContiene & ")"



    '                'strWHERE += "  " & _
    '                ' "           AND (CDP.Vendedor = " & idVendedorQueContiene & _
    '                '"           OR CDP.CuentaOrden1 = " & idVendedorQueContiene & _
    '                '"           OR CDP.CuentaOrden2 = " & idVendedorQueContiene & _
    '                '"             OR CDP.Corredor=" & idCorredorQueContiene & _
    '                '"             OR CDP.Entregador=" & idVendedorQueContiene & ")"
    '            End If
    '        End If




    '        If cmbCriterioWHERE.SelectedValue = "todos" Then
    '            strWHERE += iisIdValido(idVendedor, "           AND CDP.Vendedor = " & idVendedor, "") & _
    '                            iisIdValido(idIntermediario, "             AND CDP.CuentaOrden1=" & idIntermediario, "") & _
    '                            iisIdValido(idRComercial, "             AND CDP.CuentaOrden2=" & idRComercial, "") & _
    '                            iisIdValido(idDestinatario, "             AND  CDP.Entregador=" & idDestinatario, "") & _
    '                            iisIdValido(idCorredor, "             AND  CDP.Corredor=" & idCorredor, "")
    '        Else
    '            Dim s = " AND (1=0 " & _
    '                             iisIdValido(idVendedor, "           OR CDP.Vendedor = " & idVendedor, "") & _
    '                            iisIdValido(idIntermediario, "             OR CDP.CuentaOrden1=" & idIntermediario, "") & _
    '                            iisIdValido(idRComercial, "             OR CDP.CuentaOrden2=" & idRComercial, "") & _
    '                            iisIdValido(idDestinatario, "             OR  CDP.Entregador=" & idDestinatario, "") & _
    '                            iisIdValido(idCorredor, "             OR  CDP.Corredor=" & idCorredor, "") & _
    '                               "  )  "

    '            If s <> " AND (1=0   )  " Then strWHERE += s
    '        End If

    '        strWHERE += iisIdValido(idCorredor, "             AND CDP.Corredor=" & idCorredor, "")
    '        strWHERE += iisIdValido(idArticulo, "           AND CDP.IdArticulo=" & idArticulo, "")
    '        strWHERE += iisIdValido(idProcedencia, "             AND CDP.Procedencia=" & idProcedencia, "")
    '        strWHERE += iisIdValido(idDestino, "             AND CDP.Destino=" & idDestino, "")







    '        If cmbModo.Text = "Local" Then
    '            strWHERE += "  AND ISNULL(CDP.Exporta,'NO')='NO'  "
    '        ElseIf cmbModo.Text = "Export" Then
    '            strWHERE += "  AND ISNULL(CDP.Exporta,'NO')='SI'  "
    '        End If



    '        strWHERE += " and isnull(CDP.EnumSyngentaDivision,'Agro')='" & optDivisionSyngenta.SelectedValue & "'"



    '        strWHERE += "    AND    NetoProc>0 AND ( (isnull(FechaDescarga,FechaArribo) Between '" & iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#) & "' AND '" & iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#) & "')  )  " & _
    '    "         AND (isnull(CDP.PuntoVenta," & cmbPuntoVenta.Text & ")=" & cmbPuntoVenta.Text & " OR CDP.PuntoVenta = 0)" & _
    '   "  AND ISNULL(IdFacturaImputada,-1)<=0 " & _
    '   "  "


    '        'iisIdValido(.Item("CuentaOrden2"), "         AND CDP.CuentaOrden2=" & .Item("CuentaOrden2"), "") & _

    '        strWHERE += sWHEREadicional
    '        strWHERE += CartaDePorteManager.EstadoWHERE(EntidadManager.enumCDPestado.DescargasMasFacturadas, "CDP.")


    '        'http://www.sqlteam.com/forums/topic.asp?TOPIC_ID=71950


    '        'strWHERE += " ORDER BY  " & facturarselaA & " ASC,NumeroCartaDePorte ASC " 'este explotaba en "a terceros", porque ponía ORDER 'PIRULO' ASC
    '        strWHERE += " ORDER BY  NumeroCartaDePorte ASC, FacturarselaA ASC "

    '        strSQL += strWHERE
    '        Debug.Print(strWHERE)

    '        Return strSQL

    '    End Function

    Private Shared Function optFacturarA() As Integer
        Throw New NotImplementedException
    End Function


End Class




<Serializable()> Public Class CDPEstablecimiento
    Public Descripcion As String
    Public Emails As String

    Public FechaDesde As Date
    Public FechaHasta As Date

    Public EsPosicion As String

    Public Enviar As String
    Public EsMailOesFax As String

    Public Orden As Integer
    Public Modo As String

    Public AplicarANDuORalFiltro As String
    Public Vendedor As Integer
    Public CuentaOrden1 As Integer
    Public CuentaOrden2 As Integer
    Public Corredor As Integer
    Public Entregador As Integer

    Public IdArticulo As Integer
    Public Contrato As Integer

    Public Establecimiento As Integer
    Public Procedencia As Integer
End Class

Public Class CDPEstablecimientosManager

    Const Tabla = "CDPEstablecimientos"
    Const IdTabla = "IdEstablecimiento"

    '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx


    Public Shared Function TraerMetadata(ByVal SC As String, Optional ByVal id As Integer = -1) As DataTable
        If id = -1 Then
            Return ExecDinamico(SC, "select * from " & Tabla & " where 1=0")
        Else
            Return ExecDinamico(SC, "select * from " & Tabla & " where " & IdTabla & "=" & id)
        End If
    End Function

    Public Shared Function Insert(ByVal SC As String, ByVal dt As DataTable) As Integer
        '// Write your own Insert statement blocks 


        'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
        ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
        'y esto? http://www.vbforums.com/showthread.php?t=352219


        ''convertir datarow en datatable
        'Dim ds As New DataSet
        'ds.Tables.Add(dr.Table.Clone())
        'ds.Tables(0).ImportRow(dr)

        Dim myConnection = New SqlConnection(Encriptar(SC))
        myConnection.Open()

        Dim adapterForTable1 = New SqlDataAdapter("select * from " & Tabla & "", myConnection)
        Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
        adapterForTable1.Update(dt)

    End Function








    Public Shared Function Fetch(ByVal SC As String) As DataTable

        'Return EntidadManager.ExecDinamico(SC, Tabla & "_TT")

        Return ExecDinamico(SC, String.Format("SELECT A.*, " & _
                    " LOC.Nombre as Localidad " & _
                    " FROM " & Tabla & " A " & _
                    " LEFT OUTER JOIN Localidades LOC ON A.IdLocalidad = LOC.IdLocalidad " & _
                               ""))
        '" LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & _
    End Function

    Shared Function Update(ByVal sc As String, ByVal codEstab As String, ByVal razonsocial As String, ByVal cuit As String, ByVal aux1 As String, ByVal aux2 As String, ByVal aux3 As String)
        Dim db As LinqCartasPorteDataContext = New LinqCartasPorteDataContext(Encriptar(sc))


        Dim ue As linqCDPEstablecimiento = (From p In db.linqCDPEstablecimientos _
                       Where p.Descripcion.ToString = codEstab _
                       Select p).FirstOrDefault


        If IsNothing(ue) Then
            ue = New linqCDPEstablecimiento

            ue.Descripcion = codEstab

            ue.CUIT = cuit
            ue.AuxiliarString1 = aux1
            ue.AuxiliarString2 = aux2
            ue.AuxiliarString3 = aux3

            db.linqCDPEstablecimientos.InsertOnSubmit(ue)
        Else
            ue.AuxiliarString1 = aux1
            ue.AuxiliarString2 = aux2
            ue.AuxiliarString3 = aux3
        End If


        'buscar todos los establecimientos con codigos con letras y intercambiarlos con la descripcion

        'update establecimientos
        'set aux1=descripcion, descripcion=
        'where descripcion is alfanumeric --recordar que uso descripcion por codigo 
        '

        db.SubmitChanges()
    End Function

    Public Shared Function Update(ByVal SC As String, ByVal dt As DataTable) As Integer
        '// Write your own Insert statement blocks 


        'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
        ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
        'y esto? http://www.vbforums.com/showthread.php?t=352219


        ''convertir datarow en datatable
        'Dim ds As New DataSet
        'ds.Tables.Add(dr.Table.Clone())
        'ds.Tables(0).ImportRow(dr)

        Dim myConnection = New SqlConnection(Encriptar(SC))
        myConnection.Open()

        Dim adapterForTable1 = New SqlDataAdapter("select * from " & Tabla & "", myConnection)
        Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
        'si te tira error acá, ojito con estar usando el dataset q usaste para el 
        'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update
        adapterForTable1.Update(dt)

    End Function



    Public Shared Function Delete(ByVal SC As String, ByVal Id As Long)
        '// Write your own Delete statement blocks. 
        ExecDinamico(SC, String.Format("DELETE  " & Tabla & "  WHERE {1}={0}", Id, IdTabla))
    End Function












End Class




'End Namespace


Public Class barras

    Shared Function crear(cuit As String, tipocbteafip As String, puntoventa As String, cae As String, CAEvencimiento As String) As String



        Dim barras As String = cuit & tipocbteafip & puntoventa & cae & CAEvencimiento

        If Len(barras) <> 39 Then Throw New Exception("Error en los parametros")

        '    http://www.sistemasagiles.com.ar/trac/wiki/ManualPyAfipWs#PyI25:GeneradordeCódigosdeBarras
        Dim PyI25 As Object

        PyI25 = CreateObject("PyI25")

        ' cuit, tipo_cbte, punto_vta, cae, fch_venc_cae
        'Dim barras As String = "202675653930240016120303473904220110529"
        ''                      "CCCCCCCCCCCTTPPPPCCCCCCCCCCCCCCFFFFFFFF"
        'http://www.sistemasagiles.com.ar/trac/wiki/ManualPyAfipWs#PyI25:GeneradordeCódigosdeBarras
        'Los datos a consignar son (ver  RG1702/04 Art. 1 Anexo 1):

        'Clave Unica de Identificación Tributaria (C.U.I.T.) del emisor de la factura (11 caracteres)
        'Código de tipo de comprobante (2 caracteres)
        'Punto de venta (4 caracteres)
        'Código de Autorización de Electrónica (C.A.E.) o Código de Autorización de Impresión (C.A.I.) (14 caracteres)
        'Fecha de vencimiento (8 caracteres)
        'Dígito verificador (1 carácter)



        ' calculo digito verificador:
        barras = barras + PyI25.DigitoVerificadorModulo10(barras)


        'GenerarImagen(codigo, archivo, anchobase, ancho, alto, extension ): recibe el codigo de barras en formato numérico, nombre de archivo de salida, tamaños y formato de imagen (PNG o JPEG) y genera el codigo de barras especificado.

        ' genero imagen en png, aspecto 1x para ver en pantalla o por mail
        'Dim ok = PyI25.GenerarImagen(barras, "C:\barras.png")


        ' formato en jpg, aspecto 3x más ancho para imprimir o incrustar:
        Dim output As String = IO.Path.GetTempPath + barras + ".jpg"
        Dim ok = PyI25.GenerarImagen(barras, output, 3, 0, 40, "JPEG")

        Return output

    End Function



    ' 'CODIGO DE BARRAS
    ' Dim mvarCont As Integer, mvarSuma1 As Integer, mvarSuma2 As Integer, mvarDV As Integer
    'Set oRsTablas = oAp.TablasGenerales.TraerFiltrado("Empresa", "_Datos")
    'With oRsTablas
    '   mvarCuitEmpresa = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
    '   mvarCuitEmpresa = Mid(mvarCuitEmpresa, 1, 2) & Mid(mvarCuitEmpresa, 4, 8) & Mid(mvarCuitEmpresa, 13, 1)
    'End With
    'oRsTablas.Close
    'Set oRsTablas = oAp.TiposComprobante.TraerFiltrado("_PorId", 1)
    'With oRsTablas
    '   mvarTipoComprobanteAFIP = IIf(IsNull(.Fields("CodigoAFIP_Letra_" & mvarTipoABC).Value), "", .Fields("CodigoAFIP_Letra_" & mvarTipoABC).Value)
    'End With
    'oRsTablas.Close
    'mvarFechaCAI_s = Format(Day(mvarFechaCAI), "00") & Format(Month(mvarFechaCAI), "00") & Format(Year(mvarFechaCAI), "0000")
    'mvarCodigoBarra = mvarCuitEmpresa & mvarTipoComprobanteAFIP & mvarPuntoVenta & Mid(mvarCAI, 1, 14) & mvarFechaCAI_s
    'mvarSuma1 = 0
    'mvarSuma2 = 0
    'For mvarCont = 1 To 39
    '   If mvarCont Mod 2 = 1 Then
    '      mvarSuma1 = mvarSuma1 + Val(Mid(mvarCodigoBarra, mvarCont, 1))
    '   Else
    '      mvarSuma2 = mvarSuma2 + Val(Mid(mvarCodigoBarra, mvarCont, 1))
    '   End If
    'Next
    'mvarDV = 10 - (((mvarSuma1 * 3) + mvarSuma2) Mod 10)
    'If mvarDV = 10 Then mvarDV = 0
    'mvarCodigoBarra = mvarCodigoBarra & mvarDV
    ' 'Selection.MoveRight Unit:=wdCell
    'mvarCodigoBarra = mvarCAE
    'Selection.MoveLeft Unit:=wdCell, Count:=2
    'Selection.MoveUp Unit:=wdLine, Count:=4
    ' 'Selection.MoveRight Unit:=wdCell
    'If Len(mvarCodigoBarra) > 0 Then
    '   UserForm1.Inter25Clt1.ValorCodigo = mvarCodigoBarra
    '   UserForm1.Inter25Clt1.AlturaBarra = 30
    '   UserForm1.Inter25Clt1.TamBarra = 1
    '   UserForm1.Inter25Clt1.RealizarCodigo
    '   Selection.Paste
    'End If
    ' '   Selection.MoveRight Unit:=wdCell
    ' '   Selection.MoveRight Unit:=wdCell
    ' '   Selection.TypeText Text:="" & mvarCodigoBarra

    ' 'CODIGO LINK DE PAGO
    'Selection.MoveDown Unit:=wdLine
    'Selection.TypeText Text:="CODIGO LINK DE PAGO : 005" & Format(IIf(IsNull(oRsCli.Fields("CodigoCliente").Value), 0, oRsCli.Fields("CodigoCliente").Value), "0000")

    ' 'CODIGO DE BARRAS - PAGO FACIL
    ' Dim mPF_Cliente As String, mPF_Importe As String, mPF_Vto As String
    ' Dim mPF_Factura As String, mMultiplicador As String
    'mPF_Cliente = "0103"
    'mPF_Importe = Format(Int(Round(mvarTotalFactura * 100, 2)), "00000000")
    'mPF_Vto = VBA.Mid(CStr(Year(mvarFechaVencimiento)), 3, 2) & Format(DatePart("y", mvarFechaVencimiento), "000")
    'mPF_Factura = "01" & Format(mIdFactura, "000000000000")
    'mvarCodigoBarra = mPF_Cliente & mPF_Importe & mPF_Vto & mPF_Factura & "0" & "00000000"
    'mMultiplicador = "135793579357935793579357935793579357935793579"
    'mvarSuma1 = 0
    'For mvarCont = 1 To 40
    '   mvarSuma1 = mvarSuma1 + (CLng(Mid(mvarCodigoBarra, mvarCont, 1)) * CLng(Mid(mMultiplicador, mvarCont, 1)))
    'Next
    'mvarDV = Int(mvarSuma1 / 2) Mod 10
    'mvarCodigoBarra = mvarCodigoBarra & mvarDV
    'mvarSuma1 = 0
    'For mvarCont = 1 To 41
    '   mvarSuma1 = mvarSuma1 + (CLng(Mid(mvarCodigoBarra, mvarCont, 1)) * CLng(Mid(mMultiplicador, mvarCont, 1)))
    'Next
    'mvarDV = Int(mvarSuma1 / 2) Mod 10
    'mvarCodigoBarra = mvarCodigoBarra & mvarDV
    'UserForm1.Inter25Clt1.ValorCodigo = mvarCodigoBarra
    'UserForm1.Inter25Clt1.AlturaBarra = 25
    'UserForm1.Inter25Clt1.TamBarra = 1
    'UserForm1.Inter25Clt1.RealizarCodigo
    'Selection.MoveDown Unit:=wdLine
    'Selection.Paste
    'Selection.MoveDown Unit:=wdLine
    'Selection.TypeText Text:="PF : " & mvarCodigoBarra

    'ActiveWindow.ActivePane.View.SeekView = wdSeekMainDocument
    'Selection.HomeKey Unit:=wdStory

    'oRsDet.Close
    'oRsCli.Close

    'If Len(mPrinter) > 0 Then
    '   ActivePrinter = mPrinter
    '   For i = 1 To mCopias
    '      Select Case i
    '         Case 1
    '            mvarTipoCopia = "Original"
    '         Case 2
    '            mvarTipoCopia = "Duplicado"
    '         Case 3
    '            mvarTipoCopia = "Triplicado"
    '         Case Else
    '            mvarTipoCopia = ""
    '      End Select
    ' '     ActiveDocument.FormFields("Copia").Result = mvarTipoCopia
    '      Documents(1).PrintOut False, , , , , , , 1
    '   Next
    'End If



    Shared Function EnviarFacturaElectronicaEMail(ByVal Facturas As Generic.IList(Of Integer), cliente As String, SC As String, bVistaPrevia As Boolean, sEmail As String) As String



        Dim sErr As String


        For Each idfac In Facturas 'GetListaDeFacturasTildadas()

            ErrHandler.WriteError("idfac " & idfac)

            

            Dim fac = FacturaManager.GetItem(SC, idfac)

            If fac Is Nothing Then
                MandarMailDeError("idfac " & idfac & " no existe")
                Continue For
            End If




            Dim destinatario As String

            Dim idcli As Integer
            Dim cli As Cliente
            Try
                'Dim idcli = BuscaIdClientePreciso(cliente, SC)

                'NUEVO A HACER: El envío de la factura por mail debe salir: 
                '   - A la cuenta del cliente si la factura no tiene CORREDOR 
                '  - A la cuenta del corredor si la factura tiene CORREDOR)

                If fac.IdVendedor > 0 Then
                    idcli = CartaDePorteManager.IdClienteEquivalenteDelIdVendedor(fac.IdVendedor, SC)
                    If idcli = -1 Then idcli = fac.IdCliente
                Else
                    idcli = fac.IdCliente
                End If
                cli = ClienteManager.GetItem(SC, idcli)

                'destinatario = cli.Email
                destinatario = cli.EmailFacturacionElectronica



            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try

            ErrHandler.WriteError("cli " & idcli & " " & destinatario & " " & fac.IdVendedor & " " & fac.IdCliente)


            If destinatario.ToString = "" Then sErr += "El cliente " & cli.RazonSocial & " no tiene casilla de correo " + Environment.NewLine


            If bVistaPrevia Then
                'destinatario = ConfigurationManager.AppSettings("ErrorMail") + "," + sEmail '+ "," + UsuarioSesion.Mail(SC, Session)
                destinatario = sEmail '+ "," + UsuarioSesion.Mail(SC, Session)
            Else
                'destinatario += "," + ConfigurationManager.AppSettings("ErrorMail") + "," + sEmail '+ + UsuarioSesion.Mail(SC, Session)
                destinatario += "," + sEmail '+ + UsuarioSesion.Mail(SC, Session)
            End If






            Dim numerodefactura As String = fac.TipoABC + "-" + JustificadoDerecha(fac.PuntoVenta.ToString(), 4, "0") + "-" + JustificadoDerecha(fac.Numero.ToString, 8, "0")
            Dim idfacEncrip As String = EntidadManager.encryptQueryString(idfac)
            Dim linkalafacturaelectronica As String = _
                    "<a  href='" + ConfigurationManager.AppSettings("UrlDominio") + "ProntoWeb/FacturaElectronicaEncriptada.aspx?Modo=DescargaFactura&Id=" & idfacEncrip + "'>que puede descargar desde AQUÍ " + "</a>"

            Dim linkalosadjuntos As String = _
                    "<a  href='" + ConfigurationManager.AppSettings("UrlDominio") + "ProntoWeb/FacturaElectronicaEncriptada.aspx?Modo=DescargaAdjuntos&Id=" & idfacEncrip + "'>puede descargar el adjunto de factura AQUÍ</a>"

            Dim cuerpo As String = "<html><body>"

            ' cuerpo += linkalafacturaelectronica + "      " + linkalosadjuntos + "<br/> " + vbCrLf




            Dim qqq = "Estimado cliente " & NombreCliente(SC, idcli) & ", " & "<br/><br/>  " + vbCrLf & _
                        "Nos ponemos en contacto con usted para hacerle llegar la factura " & numerodefactura & ",  " & linkalafacturaelectronica & "<br/> " + vbCrLf & _
                       IIf(cli.CartaPorteTipoDeAdjuntoDeFacturacion > 0, "<br/>Si desea ver un detalle de las cartas de porte correspondientes a esta factura, " & linkalosadjuntos, "") & "<br/> " + vbCrLf & _
                        "<br/> Los documentos son PDF, para poder verlos, es necesario que tenga instalado el Acrobat Reader, si no lo tiene, hágalo desde " & "<a href='http://get.adobe.com/es/reader/?no_ab=1'> AQUÍ</a>" & "<br/> " + vbCrLf & _
                        "<br/>Atentamente, <br/>" & _
                        "Williams Entregas SA "

            cuerpo += qqq
            cuerpo += "</body></html>"


            If iisNull(fac.CAE, "") = "" And Not Diagnostics.Debugger.IsAttached Then
                sErr += "La factura " & numerodefactura & " no tiene CAE " + Environment.NewLine
                Continue For 'cuerpo = "Factura sin CAE"
            End If



            'MandaEmail me deja ponerle el friendyname, pero no me deja mandar en html como MandaEmailSimple

            'Dim Usuario As String = ConfigurationManager.AppSettings("SmtpUser")
            Dim Usuario As String = ConfigurationManager.AppSettings("SmtpUserFact") ' "facturacion@williamsentregas.com.ar"
            Dim pass As String = ConfigurationManager.AppSettings("SmtpPassFact") '"3dPifF"  'ConfigurationManager.AppSettings("SmtpPass")

            MandaEmail(destinatario, "Factura Electrónica Williams Entregas. " & numerodefactura, cuerpo, _
                      Usuario, _
                    ConfigurationManager.AppSettings("SmtpServer"), _
                    Usuario, _
                  pass, _
                         "", _
                    ConfigurationManager.AppSettings("SmtpPort"), , "", "", "Factura Electrónica Williams Entregas", "", True)
        Next


        'If sErr <> "" Then Throw New Exception(serr)
        sErr = "Envío Terminado " + Environment.NewLine + Environment.NewLine + sErr
        Return sErr

    End Function

    Shared Function EnviarFacturaElectronicaEMail(desde As Integer, hasta As Integer, cliente As String, SC As String, bVistaPrevia As Boolean, sEmail As String) As String
        Dim listaf = New Generic.List(Of Integer)

        For idfac = desde To hasta
            listaf.Add(idfac)
        Next

        Return EnviarFacturaElectronicaEMail(listaf, cliente, SC, bVistaPrevia, sEmail)

    End Function



End Class



'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Public Class PuntoVentaWilliams

    Public Enum enumWilliamsPuntoVenta
        '        andy donde relaciona edu los puntos de venta y sucursales de pronto?
        '3:      Min()
        '        Mariano(Scalella)
        '        Andrés(Gurisatti)
        'en los puntos de venta hay un campo que es Deposito Asociado
        'y en la tabla depositos se puede relacionar la obra
        'Andrés • 2 min
        'quedaria   pv->deposito->obra  ?
        '        Ahora()
        '        Mariano(Scalella)
        '        Andrés(Gurisatti)
        '        esacto()
        'los depositos habria que crearlos
        'Andrés • Ahora
        '        ok()


        BuenosAires = 1
        SanLorenzo = 2
        ArroyoSeco = 3
        BahiaBlanca = 4
        '6:                          BUENOS(AIRES)
        '7:                          COMERCIAL()
        '8:                          SAN(LORENZO)
        '9:                          ARROYO(SECO)
        '10:                         BAHIA(BLANCA)
    End Enum



    Public Shared Function NumeroPuntoVentaSegunSucursalWilliams(SucursalWilliams As Integer, SC As String) As Integer
        ' Dim PuntoVenta As Integer
        Dim descripcion As String

        Select Case SucursalWilliams
            Case 0
                ' PuntoVenta = 0
                ErrHandler.WriteError("Problema al poner el punto de venta/centro de costo")
            Case PuntoVentaWilliams.enumWilliamsPuntoVenta.BuenosAires
                'PuntoVenta = 10
                descripcion = "BUENOS"
            Case enumWilliamsPuntoVenta.SanLorenzo
                'PuntoVenta = 20
                descripcion = "LORENZO"
            Case enumWilliamsPuntoVenta.ArroyoSeco
                'PuntoVenta = 30
                descripcion = "ARROYO"
            Case enumWilliamsPuntoVenta.BahiaBlanca
                'PuntoVenta = 40
                descripcion = "BLANCA"
            Case Else
                'PuntoVenta = 0

                ErrHandler.WriteError("Problema al poner el punto de venta/centro de costo")
        End Select


        Dim db As LinqCartasPorteDataContext = New LinqCartasPorteDataContext(Encriptar(SC))

        Dim q = (From p In db.PuntosVentas _
                Join d In db.Depositos On p.IdDeposito Equals d.IdDeposito _
                Where d.Descripcion.ToUpper.Contains(descripcion) _
                Select p.PuntoVenta).Distinct.ToList()

        If q.Count <> 1 Then Throw New Exception("Error en el mapeo de puntos de venta. No se encuentra un unico punto venta para la Descripcion " & descripcion)

        If If(q.First(), 0) <= 0 Then Throw New Exception("Error en el mapeo de puntos de venta. valor de puntoventa: " & If(q.First(), 0))


        Return q.First()


    End Function

    Public Shared Function ObraSegunSucursalWilliams(SucursalWilliams As Integer, SC As String) As Integer
        Dim IdObra2 As Integer

        'quedaria   pv->deposito->obra  ?WE


        Dim PV = NumeroPuntoVentaSegunSucursalWilliams(SucursalWilliams, SC)

        Dim db As LinqCartasPorteDataContext = New LinqCartasPorteDataContext(Encriptar(SC))

        Dim q = (From p In db.PuntosVentas _
                Join d In db.Depositos On p.IdDeposito Equals d.IdDeposito _
                Join o In db.linqObras On d.IdObra Equals o.IdObra _
                Where p.PuntoVenta = PV _
                Select o.IdObra).Distinct.ToList

        If q.Count <> 1 Then Throw New Exception("Error en el mapeo de puntos de venta. No se encuentra una unica obra para el pv " & PV)

        IdObra2 = q.First()
        If IdObra2 <= 0 Then Throw New Exception("Error en el mapeo de puntos de venta. valor de puntoventa: " & IdObra2)

        Return IdObra2






        Select Case SucursalWilliams
            Case 0
                IdObra2 = 0
                ErrHandler.WriteError("Problema al poner el punto de venta/centro de costo")
            Case PuntoVentaWilliams.enumWilliamsPuntoVenta.BuenosAires
                IdObra2 = 6
            Case enumWilliamsPuntoVenta.SanLorenzo
                IdObra2 = 8
            Case enumWilliamsPuntoVenta.ArroyoSeco
                IdObra2 = 9
            Case enumWilliamsPuntoVenta.BahiaBlanca
                IdObra2 = 10
            Case Else
                IdObra2 = 0
                ErrHandler.WriteError("Problema al poner el punto de venta/centro de costo")
        End Select

        Return IdObra2
    End Function




    Public Shared Function NombrePuntoVentaWilliams4(ByVal pv As enumWilliamsPuntoVenta) As String

        Try
            Return [Enum].GetName(GetType(enumWilliamsPuntoVenta), pv)
        Catch ex As Exception
            ErrHandler.WriteError(ex)
            Return ""
        End Try
    End Function

    Public Shared Function NombrePuntoVentaWilliams2(ByVal pv As enumWilliamsPuntoVenta) As String


        '        andy donde relaciona edu los puntos de venta y sucursales de pronto?
        '3:      Min()
        '        Mariano(Scalella)
        '        Andrés(Gurisatti)
        'en los puntos de venta hay un campo que es Deposito Asociado
        'y en la tabla depositos se puede relacionar la obra
        'Andrés • 2 min
        'quedaria   pv->deposito->obra  ?
        '        Ahora()
        '        Mariano(Scalella)
        '        Andrés(Gurisatti)
        '        esacto()
        'los depositos habria que crearlos
        'Andrés • Ahora
        '        ok()



        Try
            Select Case pv

                Case enumWilliamsPuntoVenta.BuenosAires
                    Return "1 - Buenos Aires"
                Case enumWilliamsPuntoVenta.SanLorenzo
                    Return "2 - San Lorenzo"
                Case enumWilliamsPuntoVenta.ArroyoSeco
                    Return "3 - Arroyo Seco"
                Case enumWilliamsPuntoVenta.BahiaBlanca
                    Return "4 - Bahía Blanca"
                Case Else
                    Return ""

            End Select

        Catch ex As Exception
            ErrHandler.WriteError(ex)
            Return ""
        End Try
    End Function


    Public Shared Function IdPuntoVentaWilliams(ByVal pv As String) As enumWilliamsPuntoVenta
        Return [Enum].Parse(GetType(enumWilliamsPuntoVenta), pv)
    End Function


    Public Class i
        Public PuntoVenta As String
        Public value As String
        Public text As String
    End Class


    'Shared Function IniciaComboPuntoVentaWilliams(SC As String) As List(Of i)
    Public Shared Function IniciaComboPuntoVentaWilliams3(SC As String) As DataTable
        'System.Web.ui.con()
        Dim dt As DataTable = EntidadManager.ExecDinamico(SC, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
        'cmbPuntoVenta.DataTextField = "PuntoVenta"
        'cmbPuntoVenta.DataValueField = "PuntoVenta"
        'usa lo mismo para text y value....

        Dim db As LinqCartasPorteDataContext = New LinqCartasPorteDataContext(Encriptar(SC))

        Dim l As List(Of i) = New List(Of i)
        For Each dr As DataRow In dt.Rows
            Dim a As New i
            a.PuntoVenta = dr.Item("PuntoVenta")
            l.Add(a)
        Next

        dt.Rows.Clear()
        dt.Rows.Add()
        dt.Rows.Add()
        dt.Rows.Add()
        dt.Rows.Add()
        dt.Rows(0).Item("PuntoVenta") = 1
        dt.Rows(1).Item("PuntoVenta") = 2
        dt.Rows(2).Item("PuntoVenta") = 3
        dt.Rows(3).Item("PuntoVenta") = 4


        'traer los depositos?  pv -> deposito(sucursal) -> obraocentrocosto

        Return dt

    End Function



End Class


'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


Public Class ImpresoraMatrizDePuntosEPSONTexto

    Public Const TAB As String = Chr(9)
    Public Const PAGEFEED As String = Chr(12) 'http://www.lprng.com/DISTRIB/RESOURCES/PPD/epson.htm
    Public Const DRAFT As String = Chr(27) + Chr(120) + Chr(48)
    Public Const CONDENSED As String = Chr(27) + Chr(15) + Chr(15)
    Public Const CANCELCONDENSED As String = Chr(18)
    Public Const RESETEAR As String = Chr(27) + Chr(64)  'para que una impresion con el sistema anterior no me descajete la configuracion



    Public Const RENGLONES_POR_PAGINA = 72
    Public Const RENGLONES_POR_PAGINA_FACTURA = 72 '???



    Public Sub WilliamsFacturaWordToTxtMasMergeOpcional(Optional ByVal fileDirectory As String = "C:\documents\", Optional ByVal output As String = "Merged Document.doc", Optional ByVal plantillaDOT As Object = "", Optional sc As String = "", Optional DesdeIdFactura As Long = 0)
        Dim wdPageBreak = 7
        Dim wdStory = 6
        Dim oMissing = System.Reflection.Missing.Value
        Dim oFalse = False
        Dim oTrue = True
        Dim stringMerge As String = ""

        Const RENGLON_PIE = 61
        Const RENGLON_ANCHO = 93


        Const margenizquierdo = 3
        Const anchosegundacolumna = 30
        Const anchoprimeracolumna = RENGLON_ANCHO - margenizquierdo - anchosegundacolumna


        If plantillaDOT = "" Then plantillaDOT = System.Reflection.Missing.Value

        Try


            'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es 
            'la mitad de la normal, naturalmente los 80 clasicos)
            'Notas de Entrega: 160 ancho x 36 alt
            'Facturas y Adjuntos: 160 ancho x 78 alto

            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '//////////////Leo los txt
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////

            Dim wordFiles As String() = Directory.GetFiles(fileDirectory, "Fact*.doc.txt")

            'stringMerge = RESETEAR & CANCELCONDENSED

            For i = 0 To wordFiles.Length - 1

                Dim FILENAME As String = wordFiles(i)



                Dim incluirtarifa As Boolean = False
                Try
                    'pero y si es una tanda de clientes distintos???????
                    incluirtarifa = IIf(ClienteManager.GetItem(sc, ClaseMigrar.GetItemComProntoFactura(sc, DesdeIdFactura + i, False).IdCliente).IncluyeTarifaEnFactura = "SI", True, False)
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try


                'Get a StreamReader class that can be used to read the file
                Dim objStreamReader As StreamReader
                objStreamReader = File.OpenText(FILENAME)

                'Now, read the entire file into a string
                Dim contents As String = objStreamReader.ReadToEnd()

                'Set the text of the file to a Web control
                objStreamReader.Close()


                '//////////////////////////////
                '//////////////////////////////
                '//////////////////////////////
                'proceso un toque el txt leido

                contents = contents.Replace(vbCr, "")
                contents = contents.Replace(vbLf, vbCrLf)
                contents = contents.Replace("<CR>", vbCrLf)
                contents = contents.Replace("<TAB>", TAB)

                Dim renglonesorig = Split(contents, vbCrLf)
                Dim renglonesdest(RENGLONES_POR_PAGINA_FACTURA - 1) As String

                Dim leyendaBuquesYaPuesta As Boolean = False

                Dim n = 0
                Dim desplazamiento = 0
                For n = 0 To renglonesorig.Length - 1
                    If InStr(renglonesorig(n), "<PIE>") Then
                        desplazamiento = RENGLON_PIE - n
                        renglonesorig(n) = renglonesorig(n).Replace("<PIE>", "")
                    End If

                    If n + desplazamiento >= RENGLONES_POR_PAGINA_FACTURA Then Exit For

                    renglonesorig(n) = renglonesorig(n).Replace("�", "n")

                    Dim posTab = InStr(renglonesorig(n), "<COLUMNA2>") 'busco el separador de columna en el renglon de la factura
                    If posTab > 0 Then
                        'consulta 7971: imprimir Tarifa en factura para algunos clientes/ No está saliendo la tarifa para los clientes que tienen la opcion de Imprimir Tarifa
                        If incluirtarifa Then
                            renglonesorig(n) = renglonesorig(n).Replace("<PU>", "")
                            renglonesorig(n) = renglonesorig(n).Replace("</PU>", "")
                        Else
                            SacarTagsDePrecioUnitario(renglonesorig(n))
                        End If


                        'si está, lo de la izquierda lo justifico a la izquierda, y el pedazo de la derecha con justificado a derecha
                        Dim s1 = Left(renglonesorig(n), posTab - 1)
                        Dim s2 = Mid(renglonesorig(n), posTab + 10) 'me salto los caracteres del tag columna2

                        s1 = Left(s1.PadRight(anchoprimeracolumna), anchoprimeracolumna)
                        s2 = s2.Trim.PadLeft(anchosegundacolumna)


                        If InStr(s1.ToLower, " buque ") Then
                            'si es un buque, quieren que aparezca primero el nombre del buque, y recien despues el nombre del articulo
                            Dim x = InStr(s1, "BUQUE")
                            Dim arti = Left(s1, x - 1)
                            s1 = Space(11) + Mid(s1, x + 5).Replace(";", " " & arti & "  ")
                            s1 = Left(s1.PadRight(anchoprimeracolumna), anchoprimeracolumna)
                        End If




                        renglonesdest(n + desplazamiento) = Space(margenizquierdo) + s1 + s2
                    Else
                        'no tiene la etiqueta <COLUMNA2>

                        'si está, lo de la izquierda lo justifico a la izquierda, y el pedazo de la derecha con justificado a derecha
                        Dim s1 = renglonesorig(n)

                        If InStr(s1.ToLower, " buque ") Then
                            'si es un buque, quieren que aparezca primero el nombre del buque, y recien despues el nombre del articulo
                            Dim x = InStr(s1, "BUQUE")
                            Dim arti = Left(s1, x - 1)
                            s1 = Space(11) + Mid(s1, x + 5).Replace(";", " " & arti & "  ")
                            s1 = Left(s1.PadRight(anchoprimeracolumna), anchoprimeracolumna)
                        End If

                        renglonesdest(n + desplazamiento) = Space(margenizquierdo) + s1  ' renglonesorig(n)
                    End If


                    renglonesdest(n + desplazamiento) = Left(renglonesdest(n + desplazamiento), RENGLON_ANCHO)

                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8946
                    If InStr(renglonesorig(n).ToLower, " buque ") And Not leyendaBuquesYaPuesta Then
                        'renglonesdest(n + desplazamiento - 1) &= vbCrLf & Space(15) & "ATENCION BUQUES"
                        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?&recordid=9182
                        'aca hay que avisar que aumente si usas un salto de linea
                        'lo dejo harcodeado 
                        renglonesdest(21) &= Space(15) & "ATENCION BUQUES"
                        leyendaBuquesYaPuesta = True
                    End If
                    'consulta 7971 : para algunos clientes (que ellos puedan definir cuales 
                    'desde el abm de clientes) quieren que en el detalle de la factura impresa vaya a parte del grano-destinatario-destino la tarifa facturada en esa linea
                Next

                contents = Join(renglonesdest, vbCrLf)


                Dim CANTIDAD_COPIAS As Integer = ConfigurationManager.AppSettings("Debug_CantidadCopiasCartaPorte")  'BuscarClaveINI("CantidadCopiasCartaPorte", sc, )
                For n = 1 To CANTIDAD_COPIAS
                    stringMerge &= RESETEAR & CANCELCONDENSED & vbCrLf & contents
                Next

            Next


            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '/////////// Escribo el rejunte 
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////



            Dim objStreamWriter As StreamWriter
            objStreamWriter = File.CreateText(output)
            objStreamWriter.Write(stringMerge)
            objStreamWriter.Close()




        Catch ex As Exception
            ErrHandler.WriteError(ex.ToString & " Error al hacer el merge de docs")
            Throw
            'MsgBoxAjax(Me, ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro.    Emision """ & DebugCadenaImprimible(Encriptar(HFSC.Value)) & "," & ID)
        Finally
        End Try

    End Sub

    Sub SacarTagsDePrecioUnitario(ByRef s As String)
        Dim regex As New System.Text.RegularExpressions.Regex("(<PU.*?)(?:()+)(.*?)(</PU>)")

        'Dim newString = regex.Replace(s, "$1<a href=""$3"">$3</a>$4$5")
        s = regex.Replace(s, "")
    End Sub



    Public Function ExcelToText(ByVal fileExcelName As String) As String
        'traido de http://www.devcurry.com/2009/07/import-excel-data-into-aspnet-gridview_06.html

        Dim oXL As Excel.Application
        Dim oWB As Excel.Workbook
        Dim oSheet As Excel.Worksheet
        Dim oRng As Excel.Range
        Dim oWBs As Excel.Workbooks




        'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es 
        'la mitad de la normal, naturalmente los 80 clasicos)
        'Notas de Entrega: 160 ancho x 36 alt
        'Facturas y Adjuntos: 160 ancho x 78 alto


        Const MAXCOLS = 20
        Const MAXFILAS = 500
        Const MAXSHEETS = 50

        Try
            '  creat a Application object
            oXL = New Excel.ApplicationClass()
            '   get   WorkBook  object
            oWBs = oXL.Workbooks



            Try
                oWB = oWBs.Open(fileExcelName, Reflection.Missing.Value, Reflection.Missing.Value, _
                    Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, _
                    Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, _
                    Reflection.Missing.Value, Reflection.Missing.Value)
            Catch ex As Exception

                'problemas al abrir T6

                ' http://www.made4dotnet.com/Default.aspx?tabid=141&aid=15
                'http://stackoverflow.com/questions/493178/excel-programming-exception-from-hresult-0x800a03ec-at-microsoft-office-inter

            End Try

            Dim nf = FreeFile()
            'que el usuario asocie esta extension con el PRINT.EXE (Windows\System32\)
            'que el usuario asocie esta extension con el PRINT.EXE (Windows\System32\)
            Dim output As String = fileExcelName + ".prontotxt" 'que el usuario asocie esta extension con el PRINT.EXE (Windows\System32\)
            FileOpen(nf, output, OpenMode.Output)

            Print(nf, CONDENSED)




            Dim maxsht = IIf(oWB.Worksheets.Count > MAXSHEETS, MAXSHEETS, oWB.Worksheets.Count)
            For sht = 1 To maxsht

                'dejé de usar .Sheets 'http://stackoverflow.com/questions/2695229/why-cant-set-cast-an-object-from-excel-interop
                oSheet = CType(oWB.Worksheets(sht), Microsoft.Office.Interop.Excel.Worksheet) 'usá .Worksheets, NO .Sheets



                Dim dt As New Data.DataTable("dtExcel")

                '  creo las columnas
                For j As Integer = 1 To MAXCOLS
                    dt.Columns.Add("column" & j, _
                                   System.Type.GetType("System.String"))
                Next j


                Dim ds As New DataSet()
                ds.Tables.Add(dt)
                Dim dr As DataRow

                Dim iValue As Integer = IIf(oSheet.UsedRange.Cells.Rows.Count > MAXFILAS, MAXFILAS, oSheet.UsedRange.Cells.Rows.Count)




                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '  get data in cell
                'copio los datos nomás

                For i As Integer = 1 To iValue
                    dr = ds.Tables("dtExcel").NewRow()
                    Dim sb As String = ""

                    For j As Integer = 1 To MAXCOLS

                        'traigo la celda y la pongo en una variable Range (no sé por qué)
                        oRng = CType(oSheet.Cells(i, j), Microsoft.Office.Interop.Excel.Range)



                        'Range.Text << Formatted value - datatype is always "string"
                        'Range.Value << actual datatype ex: double, datetime etc
                        'Range.Value2 << actual datatype. slightly different than "Value" property.

                        If IsNumeric(oRng.Value) Then 'me fijo si es numerica, por el asuntillo de la coma
                            sb &= oRng.Value.ToString & TAB
                        Else

                            Dim strValue As String = oRng.Text.ToString() 'acá como la convertís a string, estás trayendo la coma...
                            sb &= Left(strValue, 50) & TAB
                        End If



                    Next j

                    PrintLine(nf, sb)
                Next i

                For i As Integer = iValue To RENGLONES_POR_PAGINA
                    PrintLine(nf, "")
                Next i


                'PrintLine(nf, PAGEFEED) 'poner un page feed?
            Next sht

            FileClose(nf)
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////


            Return output


        Catch ex As Exception
            ErrHandler.WriteError("No pudo extraer el excel. " + ex.ToString)
            Return Nothing


            '            1. In DCOMCNFG, right click on the My Computer and select properties.
            '2. Choose the COM Securities tab
            '3. In Access Permissions, click "Edit Defaults" and add Network Service to it and give it "Allow local access" permission. Do the same for <Machine_name>
            '  \Users.
            '  4. In launch and Activation Permissions, click "Edit Defaults" and add Network Service to it and give it "Local launch" and "Local Activation" permission. Do the same for <Machine_name>
            '    \Users
            '   Press OK and thats it. i can run my application now
        Finally
            Try
                'The service (excel.exe) will continue to run
                If Not oWB Is Nothing Then oWB.Close(False)
                NAR(oWB)
                oWBs.Close()
                NAR(oWBs)
                'quit and dispose app
                oXL.Quit()
                NAR(oXL)
                'VERY IMPORTANT
                GC.Collect()

                'Dispose()  'este me arruinaba todo, me hacia aparecer el cartelote del Prerender
            Catch ex As Exception
                ErrHandler.WriteError("No pudo cerrar el servicio excel. " + ex.ToString)
            End Try
        End Try
    End Function



    Public Shared Function ExcelToTextWilliamsAdjunto(ByVal fileExcelName As String) As String
        'traido de http://www.devcurry.com/2009/07/import-excel-data-into-aspnet-gridview_06.html

        Dim oXL As Excel.Application
        Dim oWB As Excel.Workbook
        Dim oSheet As Excel.Worksheet
        Dim oRng As Excel.Range
        Dim oWBs As Excel.Workbooks




        'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es 
        'la mitad de la normal, naturalmente los 80 clasicos)
        'Notas de Entrega: 160 ancho x 36 alt
        'Facturas y Adjuntos: 160 ancho x 78 alto


        Const MAXCOLS = 15
        Const MAXFILAS = 300
        Const MAXSHEETS = 15

        Try
            '  creat a Application object
            oXL = New Excel.ApplicationClass()
            '   get   WorkBook  object
            oWBs = oXL.Workbooks



            Try
                oWB = oWBs.Open(fileExcelName, Reflection.Missing.Value, Reflection.Missing.Value, _
    Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, _
    Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, _
    Reflection.Missing.Value, Reflection.Missing.Value)
            Catch ex As Exception

                'problemas al abrir T6

                ' http://www.made4dotnet.com/Default.aspx?tabid=141&aid=15
                'http://stackoverflow.com/questions/493178/excel-programming-exception-from-hresult-0x800a03ec-at-microsoft-office-inter

            End Try

            Dim nf = FreeFile()
            'que el usuario asocie esta extension con el PRINT.EXE (Windows\System32\)
            'que el usuario asocie esta extension con el PRINT.EXE (Windows\System32\)
            Dim output As String = fileExcelName + ".prontotxt" 'que el usuario asocie esta extension con el PRINT.EXE (Windows\System32\)
            FileOpen(nf, output, OpenMode.Output)

            Print(nf, CONDENSED)




            Dim maxsht = IIf(oWB.Worksheets.Count > MAXSHEETS, MAXSHEETS, oWB.Worksheets.Count)
            For sht = 1 To maxsht

                Dim bGastoCambio As Boolean = False

                PrintLine(nf, "")
                PrintLine(nf, "")
                PrintLine(nf, "")
                PrintLine(nf, "")
                PrintLine(nf, "_______________________________________________________________________________________")
                Dim rg = 5



                'dejé de usar .Sheets 'http://stackoverflow.com/questions/2695229/why-cant-set-cast-an-object-from-excel-interop
                oSheet = CType(oWB.Worksheets(sht), Microsoft.Office.Interop.Excel.Worksheet) 'usá .Worksheets, NO .Sheets



                Dim dt As New Data.DataTable("dtExcel")

                '  creo las columnas
                For j As Integer = 1 To MAXCOLS
                    dt.Columns.Add("column" & j, _
                                   System.Type.GetType("System.String"))
                Next j


                Dim ds As New DataSet()
                ds.Tables.Add(dt)
                Dim dr As DataRow

                Dim iRowsValue As Integer = IIf(oSheet.UsedRange.Cells.Rows.Count > MAXFILAS, MAXFILAS, oSheet.UsedRange.Cells.Rows.Count)


                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '  get data in cell
                'copio los datos nomás
                Dim rengloncdp = 0
                Dim sb As String = ""


                For iRow As Integer = 1 To iRowsValue


                    dr = ds.Tables("dtExcel").NewRow()

                    For j As Integer = 1 To MAXCOLS

                        'traigo la celda y la pongo en una variable Range (no sé por qué)
                        oRng = CType(oSheet.Cells(iRow, j), Microsoft.Office.Interop.Excel.Range)


                        ' La info de las cdp debería ir en dos columnas (para no hacer tan larga la impresión) 

                        'Range.Text << Formatted value - datatype is always "string"
                        'Range.Value << actual datatype ex: double, datetime etc
                        'Range.Value2 << actual datatype. slightly different than "Value" property.




                        If IsNumeric(oRng.Value) Then 'me fijo si es numerica, por el asuntillo de la coma
                            sb &= oRng.Value.ToString & TAB
                        Else
                            Dim strValue As String = oRng.Text.ToString() 'acá como la convertís a string, estás trayendo la coma...

                            If strValue = "<CDP>" Or strValue = "TOTAL" Then
                                rengloncdp += 1 'llevo el conteo para la doble columna

                                If strValue = "TOTAL" And sb <> "" Then
                                    'para que la columna de total sea siempre la izquierda
                                    sb &= vbCrLf & TAB & TAB & TAB & TAB
                                    rg += 1
                                    rengloncdp = 0
                                End If

                            End If
                            sb &= Left(strValue, 50) & TAB
                        End If
                    Next j


                    If InStr(sb, "*Los asteriscos indican Gastos de Cambio") Then
                        sb = sb.Replace("*Los asteriscos indican Gastos de Cambio", "")
                        bGastoCambio = True
                    End If

                    If InStr(sb, "<CDP>") = 0 Or (rengloncdp Mod 3 = 0) Then 'no es un renglon de doble columna o no 
                        sb = sb.Replace("<CDP>", "").Replace(TAB, " ")
                        PrintLine(nf, sb)
                        rg += 1
                        rengloncdp = 0
                        sb = ""
                    End If
                Next iRow


                If bGastoCambio Then
                    PrintLine(nf, "    *Los asteriscos indican Gastos de Cambio")
                    rg += 1
                End If

                For i As Integer = rg To RENGLONES_POR_PAGINA
                    PrintLine(nf, "")
                Next i


                sb = ""

                'PrintLine(nf, PAGEFEED) 'poner un page feed?
            Next sht


            FileClose(nf)
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////


            Return output


        Catch ex As Exception
            ErrHandler.WriteError("No pudo extraer el excel. " + ex.ToString)
            Return Nothing


            '            1. In DCOMCNFG, right click on the My Computer and select properties.
            '2. Choose the COM Securities tab
            '3. In Access Permissions, click "Edit Defaults" and add Network Service to it and give it "Allow local access" permission. Do the same for <Machine_name>
            '  \Users.
            '  4. In launch and Activation Permissions, click "Edit Defaults" and add Network Service to it and give it "Local launch" and "Local Activation" permission. Do the same for <Machine_name>
            '    \Users
            '   Press OK and thats it. i can run my application now
        Finally
            Try
                'The service (excel.exe) will continue to run
                If Not oWB Is Nothing Then oWB.Close(False)
                NAR(oWB)
                oWBs.Close()
                NAR(oWBs)
                'quit and dispose app
                oXL.Quit()
                NAR(oXL)
                'VERY IMPORTANT
                GC.Collect()

                'Dispose()  'este me arruinaba todo, me hacia aparecer el cartelote del Prerender
            Catch ex As Exception
                ErrHandler.WriteError("No pudo cerrar el servicio excel. " + ex.ToString)
            End Try
        End Try
    End Function



    Public Shared Function ExcelToTextWilliamsAdjunto_A4(ByVal fileExcelName As String) As String
        'traido de http://www.devcurry.com/2009/07/import-excel-data-into-aspnet-gridview_06.html

        Dim oXL As Excel.Application
        Dim oWB As Excel.Workbook
        Dim oSheet As Excel.Worksheet
        Dim oRng As Excel.Range
        Dim oWBs As Excel.Workbooks




        'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es 
        'la mitad de la normal, naturalmente los 80 clasicos)
        'Notas de Entrega: 160 ancho x 36 alt
        'Facturas y Adjuntos: 160 ancho x 78 alto


        Const MAXCOLS = 15
        Const MAXFILAS = 300
        Const MAXSHEETS = 15

        Try
            '  creat a Application object
            If True Then
                oXL = New Excel.ApplicationClass() 'y si uso createobject?
            Else
                oXL = CreateObject("Excel.Application")
            End If

            '   get   WorkBook  object
            oWBs = oXL.Workbooks



            Try
                oWB = oWBs.Open(fileExcelName, Reflection.Missing.Value, Reflection.Missing.Value, _
    Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, _
    Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, _
    Reflection.Missing.Value, Reflection.Missing.Value)
            Catch ex As Exception

                'problemas al abrir T6

                ' http://www.made4dotnet.com/Default.aspx?tabid=141&aid=15
                'http://stackoverflow.com/questions/493178/excel-programming-exception-from-hresult-0x800a03ec-at-microsoft-office-inter

            End Try

            Dim nf = FreeFile()
            'que el usuario asocie esta extension con el PRINT.EXE (Windows\System32\)
            'que el usuario asocie esta extension con el PRINT.EXE (Windows\System32\)
            Dim sufijo As String = Int(Rnd() * 10000)
            Dim output As String = fileExcelName + sufijo + ".txt" 'que el usuario asocie esta extension con el PRINT.EXE (Windows\System32\)
            FileOpen(nf, output, OpenMode.Output)

            Print(nf, CONDENSED)


            Const columnas = 2

            Dim maxsht = IIf(oWB.Worksheets.Count > MAXSHEETS, MAXSHEETS, oWB.Worksheets.Count)
            For sht = 1 To maxsht

                '/////////////////////////////////////////////////////////////
                PrintLine(nf, "")
                PrintLine(nf, "")
                PrintLine(nf, "__________________________________________________________________________________")
                Dim rg = 3
                '/////////////////////////////////////////////////////////////


                Dim bGastoCambio As Boolean = False

                'dejé de usar .Sheets 'http://stackoverflow.com/questions/2695229/why-cant-set-cast-an-object-from-excel-interop
                oSheet = CType(oWB.Worksheets(sht), Microsoft.Office.Interop.Excel.Worksheet) 'usá .Worksheets, NO .Sheets



                Dim dt As New Data.DataTable("dtExcel")

                '  creo las columnas
                For j As Integer = 1 To MAXCOLS
                    dt.Columns.Add("column" & j, _
                                   System.Type.GetType("System.String"))
                Next j


                Dim ds As New DataSet()
                ds.Tables.Add(dt)
                Dim dr As DataRow

                Dim iRowsValue As Integer = IIf(oSheet.UsedRange.Cells.Rows.Count > MAXFILAS, MAXFILAS, oSheet.UsedRange.Cells.Rows.Count)


                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '  get data in cell
                'copio los datos nomás
                Dim rengloncdp = 0
                Dim sb As String = ""


                For iRow As Integer = 1 To iRowsValue


                    dr = ds.Tables("dtExcel").NewRow()

                    For j As Integer = 1 To MAXCOLS

                        'traigo la celda y la pongo en una variable Range (no sé por qué)
                        oRng = CType(oSheet.Cells(iRow, j), Microsoft.Office.Interop.Excel.Range)


                        ' La info de las cdp debería ir en dos columnas (para no hacer tan larga la impresión) 

                        'Range.Text << Formatted value - datatype is always "string"
                        'Range.Value << actual datatype ex: double, datetime etc
                        'Range.Value2 << actual datatype. slightly different than "Value" property.



                        'If primeracelda.Contains("<CAB>") Then
                        '    builder.AppendFormat(COLS_ENCABEZADO, _
                        '                    s(0), _
                        '                    s(1), _
                        '                    s(2), _
                        '                    s(3), _
                        '                    s(4), _
                        '                    s(5), _
                        '                    s(6), _
                        '                    s(7), _
                        '                    s(8), _
                        '                    s(8), _
                        '                    s(9), _
                        '                    s(10), _
                        '                    s(11), _
                        '                    s(12), _
                        '                    s(13))
                        'End If





                        If IsNumeric(oRng.Value) Then 'me fijo si es numerica, por el asuntillo de la coma
                            sb &= oRng.Value.ToString & TAB
                        Else
                            Dim strValue As String = oRng.Text.ToString() 'acá como la convertís a string, estás trayendo la coma...

                            If strValue = "<CDP>" Or strValue = "TOTAL" Then
                                rengloncdp += 1 'llevo el conteo para la doble columna

                                If strValue = "TOTAL" And sb <> "" Then
                                    'para que la columna de total sea siempre la izquierda
                                    sb &= vbCrLf & TAB & TAB & TAB & TAB
                                    rg += 1
                                    rengloncdp = 0
                                End If

                            End If
                            sb &= Left(strValue, 50) & TAB
                        End If














                    Next j

                    '////////////////////////////////
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8624
                    '* Titulo de agrupamiento en dos renglones: el producto y el contrato van en el segundo renglon
                    sb = sb.Replace("Prod:", vbCrLf & " Prod:")
                    '////////////////////////////////


                    If InStr(sb, "*Los asteriscos indican Gastos de Cambio") Then
                        sb = sb.Replace("*Los asteriscos indican Gastos de Cambio", "")
                        bGastoCambio = True
                    End If

                    If InStr(sb, "<CDP>") = 0 Or (rengloncdp Mod columnas = 0) Then 'no es un renglon de doble columna o no 
                        sb = sb.Replace("<CDP>", "").Replace(TAB, " ")
                        PrintLine(nf, sb)
                        rg += 1
                        rengloncdp = 0
                        sb = ""
                    End If
                Next iRow



                If bGastoCambio Then
                    PrintLine(nf, "    *Los asteriscos indican Gastos de Cambio")
                    rg += 1
                End If

                For i As Integer = rg To RENGLONES_POR_PAGINA - 25 '- 10 'le quitamos un poco de renglones en a4
                    PrintLine(nf, "")
                Next i




                sb = ""



                'en el caso de la impresion a A4 sí usamos un pagefeed
                'en el caso de la impresion a A4 sí usamos un pagefeed
                'en el caso de la impresion a A4 sí usamos un pagefeed
                PrintLine(nf, PAGEFEED) 'poner un page feed?
                'en el caso de la impresion a A4 sí usamos un pagefeed
                'en el caso de la impresion a A4 sí usamos un pagefeed
                'en el caso de la impresion a A4 sí usamos un pagefeed

            Next sht


            FileClose(nf)
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////


            Return output


        Catch ex As Exception
            ErrHandler.WriteError("No pudo extraer el excel. " + ex.ToString)
            Return Nothing


            '            1. In DCOMCNFG, right click on the My Computer and select properties.
            '2. Choose the COM Securities tab
            '3. In Access Permissions, click "Edit Defaults" and add Network Service to it and give it "Allow local access" permission. Do the same for <Machine_name>
            '  \Users.
            '  4. In launch and Activation Permissions, click "Edit Defaults" and add Network Service to it and give it "Local launch" and "Local Activation" permission. Do the same for <Machine_name>
            '    \Users
            '   Press OK and thats it. i can run my application now
        Finally
            Try
                'The service (excel.exe) will continue to run
                If Not oWB Is Nothing Then oWB.Close(False)
                NAR(oWB)
                oWBs.Close()
                NAR(oWBs)
                'quit and dispose app
                oXL.Quit()
                NAR(oXL)
                'VERY IMPORTANT
                GC.Collect()

                'Dispose()  'este me arruinaba todo, me hacia aparecer el cartelote del Prerender
            Catch ex As Exception
                ErrHandler.WriteError("No pudo cerrar el servicio excel. " + ex.ToString)
            End Try
        End Try
    End Function



    Public Function ExcelToTextNotasDeEntrega(ByVal fileExcelName As String) As String
        'traido de http://www.devcurry.com/2009/07/import-excel-data-into-aspnet-gridview_06.html

        Dim oXL As Excel.Application
        Dim oWB As Excel.Workbook
        Dim oSheet As Excel.Worksheet
        Dim oRng As Excel.Range
        Dim oWBs As Excel.Workbooks

        'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es 
        'la mitad de la normal, naturalmente los 80 clasicos)
        'Notas de Entrega: 160 ancho x 36 alt
        'Facturas y Adjuntos: 160 ancho x 78 alto



        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        ' ParametroManager.TraerValorParametro2(HFSC.Value, "NotasDeEntregaMatrizDePuntosMargen1")

        Const COLS_ENCABEZADO = "{0,-11}{1,-27}{2,-7}{3,10}{4,-22}{5,10}{6,10}{11,10}{12,10}{13,10}"
        Const COLS_DETALLE = "{0,12}{1,18}     {2,-5}{3,-3}{4,8}{5,9}{6,22}{7,7}{8,13}{9,15}{10,10}{11,4}{12,10}{13,10}"
        Const COLS_DETALLEOBSERVACIONES = "{0,-100}{11,10}{12,10}{13,30}"

        'los renglones por nota son 36 (72/2)
        'los renglones por nota son 36 (72/2)
        'los renglones por nota son 36 (72/2)
        'los renglones por nota son 36 (72/2)
        Const RENGLON_ANCHO = 157

        Const RENGLON_ENCABEZADO = 7
        Const SEPARACION_ENCAB_DETALLE = 3
        Const RENGLON_PIE = 20
        'Const OFFSETFINAL = 12



        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////



        Const MAXCOLS = 20
        Const MAXFILAS = 500
        Const MAXSHEETS = 500

        Try
            '  creat a Application object
            oXL = New Excel.ApplicationClass()
            '   get   WorkBook  object
            oWBs = oXL.Workbooks



            Try
                oWB = oWBs.Open(fileExcelName, Reflection.Missing.Value, Reflection.Missing.Value, _
    Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, _
    Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, _
    Reflection.Missing.Value, Reflection.Missing.Value)
            Catch ex As Exception

                'problemas al abrir T6

                ' http://www.made4dotnet.com/Default.aspx?tabid=141&aid=15
                'http://stackoverflow.com/questions/493178/excel-programming-exception-from-hresult-0x800a03ec-at-microsoft-office-inter

            End Try

            Dim nf = FreeFile()
            'que el usuario asocie esta extension con el PRINT.EXE (Windows\System32\)
            'que el usuario asocie esta extension con el PRINT.EXE (Windows\System32\)
            Dim output As String = fileExcelName + ".prontotxt" 'que el usuario asocie esta extension con el PRINT.EXE (Windows\System32\)
            FileOpen(nf, output, OpenMode.Output)

            Print(nf, "" & RESETEAR & "" & CONDENSED)








            Dim bpuesto As Boolean

            Dim maxsht = IIf(oWB.Worksheets.Count > MAXSHEETS, MAXSHEETS, oWB.Worksheets.Count)
            If oWB.Worksheets.Count > MAXSHEETS Then
                ErrHandler.WriteError("Limite de Notas de entrega " & oWB.Worksheets.Count)
            End If

            Dim iCuentaRenglones = 0

            For sht = 1 To maxsht



                bpuesto = False

                'dejé de usar .Sheets 'http://stackoverflow.com/questions/2695229/why-cant-set-cast-an-object-from-excel-interop
                oSheet = CType(oWB.Worksheets(sht), Microsoft.Office.Interop.Excel.Worksheet) 'usá .Worksheets, NO .Sheets

                Dim dt As New Data.DataTable("dtExcel")

                '  creo las columnas
                For j As Integer = 1 To MAXCOLS
                    dt.Columns.Add("column" & j, _
                                   System.Type.GetType("System.String"))
                Next j

                Dim ds As New DataSet()
                ds.Tables.Add(dt)
                Dim dr As DataRow

                Dim cantFilas As Integer = IIf(oSheet.UsedRange.Cells.Rows.Count > MAXFILAS, MAXFILAS, oSheet.UsedRange.Cells.Rows.Count)


                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '  get data in cell
                'copio los datos nomás



                '            salio todo desde la primera linea, para que encuadre yo le tuve que poner 6 enter antes del primer caracter impreso (antes del Titular)
                'despues de la ultima carta de porte hasta los totales tuve que agregar 11 lineas en blanco para que los totales peguen bien
                'los totales los acomode para que cada uno quede abajo de la columna que totaliza
                'y el ultimo total para que quede abajo de las fechas de descarga
                'el destinatario quedo bien, el destino debe quedar alineado
                'lo mismo con el Contrato, debe queda alineado con el corredor
                'y lo ultimo que veo es que le puse una linea vacia entre la que empieza con el titular y la siguiente (que empieza con el producto)

                PrintLine(nf, "...")
                iCuentaRenglones += 1

                For n = 1 To RENGLON_ENCABEZADO
                    PrintLine(nf, "")
                    iCuentaRenglones += 1
                Next



                Dim s(MAXCOLS) As String

                Dim desplaz As Integer = 0

                For fila As Integer = 1 To cantFilas
                    dr = ds.Tables("dtExcel").NewRow()
                    Dim sb As String = ""


                    'ver si este renglon es el pie, entonces agrego tantos renglones en blanco como corresponda


                    Dim primeracelda = CType(oSheet.Cells(fila, 1), Microsoft.Office.Interop.Excel.Range).Text.ToString
                    If primeracelda.Contains("<PIE>") Then
                        For auxfila = fila To RENGLON_PIE
                            PrintLine(nf, "")
                            desplaz += 1
                            iCuentaRenglones += 1

                            'si es el segundo pie que aparece, van a haber renglones de mas -no es el caso, el informe no agrega un segundo pie
                            'agregar los renglones en blanco, pero despues no agregarlos en el salto de pagina
                        Next
                    End If




                    For col As Integer = 1 To MAXCOLS

                        'traigo la celda y la pongo en una variable Range (no sé por qué)
                        oRng = CType(oSheet.Cells(fila, col), Microsoft.Office.Interop.Excel.Range)



                        'Range.Text << Formatted value - datatype is always "string"
                        'Range.Value << actual datatype ex: double, datetime etc
                        'Range.Value2 << actual datatype. slightly different than "Value" property.

                        If IsNumeric(oRng.Value) Then 'me fijo si es numerica, por el asuntillo de la coma -y si es la hora?????
                            s(col - 1) = oRng.Value.ToString '& TAB
                        Else

                            Dim strValue As String = oRng.Text.ToString() 'acá como la convertís a string, estás trayendo la coma...
                            s(col - 1) = Left(strValue, 50) '& TAB
                        End If


                        s(col - 1) = s(col - 1).Replace("<CAB>", "")
                        s(col - 1) = s(col - 1).Replace("<DET2>", "")
                        s(col - 1) = s(col - 1).Replace("<PIE>", "")

                        'sb&= anchocols(



                    Next col

                    'http://msmvps.com/blogs/deborahk/archive/2009/07/21/formatting-text-files.aspx
                    Dim builder As New System.Text.StringBuilder

                    'tenes 150 caracteres de ancho para usar
                    'tenes 150 caracteres de ancho para usar
                    'tenes 150 caracteres de ancho para usar
                    'tenes 150 caracteres de ancho para usar
                    'tenes 150 caracteres de ancho para usar
                    'tenes 150 caracteres de ancho para usar

                    If primeracelda.Contains("<CAB>") Then
                        builder.AppendFormat(COLS_ENCABEZADO, _
                                        s(0), _
                                        s(1), _
                                        s(2), _
                                        s(3), _
                                        s(4), _
                                        s(5), _
                                        s(6), _
                                        s(7), _
                                        s(8), _
                                        s(8), _
                                        s(9), _
                                        s(10), _
                                        s(11), _
                                        s(12), _
                                        s(13))

                    ElseIf primeracelda.Contains("<DET2>") Then

                        'Const COLS_DETALLEOBSERVACIONES = "{0,-100}{11,10}{12,10}{13,30}"

                        builder.AppendFormat(COLS_DETALLEOBSERVACIONES, _
                                        s(0), _
                                        s(1), _
                                        s(2), _
                                        s(3), _
                                        s(4), _
                                        s(5), _
                                        s(6), _
                                        s(7), _
                                        s(8), _
                                        s(9), _
                                        Left(s(10), 10), _
                                        Left(s(11), 10), _
                                        Left(s(12), 10), _
                                        Left(s(13), 30))
                    Else

                        'Const COLS_DETALLE = "{0,12}{1,18}     {2,-5}{3,-3}{4,8}{5,9}{6,22}{7,7}{8,13}{9,15}{10,10}{11,4}{12,10}{13,10}"

                        builder.AppendFormat(COLS_DETALLE, _
                                       Left(s(0), 12), _
                                       Left(s(1), 18), _
                                       Left(s(2), 5), _
                                       Left(s(3), 3), _
                                       Left(s(4), 8), _
                                       Left(s(5), 9), _
                                       Left(s(6), 22), _
                                       Left(s(7), 7), _
                                       Left(s(8), 13), _
                                       Left(s(9), 15), _
                                       Left(s(10), 10), _
                                       Left(s(11), 4), _
                                       Left(s(12), 10), _
                                        Left(s(13), 10))

                    End If


                    sb = builder.ToString


                    '/////////////////////////////////////
                    'hacer un rtrim de los tabs 
                    For n = sb.Length - 1 To 0 Step -1
                        If sb(n) = vbCr Then Continue For
                        If sb(n) = vbCrLf Then Continue For
                        If sb(n) = vbLf Then Continue For
                        If sb(n) = TAB Then
                            Dim p = New StringBuilder(sb)
                            p(n) = " "
                            sb = p.ToString
                            Continue For
                        End If

                        Exit For 'encontré otro caracter, entonces rajo
                    Next

                    sb = Left(sb, RENGLON_ANCHO)
                    '/////////////////////////////////////



                    PrintLine(nf, sb)
                    iCuentaRenglones += 1



                    If primeracelda.Contains("<CAB>") And bpuesto Then
                        bpuesto = False
                        For n = 1 To SEPARACION_ENCAB_DETALLE
                            PrintLine(nf, "")
                            iCuentaRenglones += 1

                        Next
                    Else
                        bpuesto = True
                    End If



                    If desplaz > 1 Then Exit For 'si es el pie, sale del for

                Next fila




                'For i As Integer = cantFilas + desplaz To RENGLONES_POR_PAGINA / 2 - OFFSETFINAL 'las notas de entrega son 2 por pagina. -6 por los renglones en blanco del principio
                '    PrintLine(nf, "")
                '    iCuentaRenglones += 1

                'Next i

                Do While iCuentaRenglones < RENGLONES_POR_PAGINA / 2
                    PrintLine(nf, "")
                    iCuentaRenglones += 1
                Loop








                'como verificar que hay 36 renglones por notita? ¿me estoy pasando siempre, 
                'o en alguna me quedo corto?




                'PrintLine(nf, PAGEFEED) 'poner un page feed?
                Debug.Assert(iCuentaRenglones = RENGLONES_POR_PAGINA / 2)

                iCuentaRenglones = 0

            Next sht



            FileClose(nf)
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////


            Return output


        Catch ex As Exception
            ErrHandler.WriteError("No pudo extraer el excel. " + ex.ToString)
            Return Nothing


            '            1. In DCOMCNFG, right click on the My Computer and select properties.
            '2. Choose the COM Securities tab
            '3. In Access Permissions, click "Edit Defaults" and add Network Service to it and give it "Allow local access" permission. Do the same for <Machine_name>
            '  \Users.
            '  4. In launch and Activation Permissions, click "Edit Defaults" and add Network Service to it and give it "Local launch" and "Local Activation" permission. Do the same for <Machine_name>
            '    \Users
            '   Press OK and thats it. i can run my application now
        Finally
            Try
                'The service (excel.exe) will continue to run
                If Not oWB Is Nothing Then oWB.Close(False)
                NAR(oWB)
                oWBs.Close()
                NAR(oWBs)
                'quit and dispose app
                oXL.Quit()
                NAR(oXL)
                'VERY IMPORTANT
                GC.Collect()

                'Dispose()  'este me arruinaba todo, me hacia aparecer el cartelote del Prerender
            Catch ex As Exception
                ErrHandler.WriteError("No pudo cerrar el servicio excel. " + ex.ToString)
            End Try
        End Try
    End Function











    Public Shared Sub CopyTreeview(treeview1 As TreeView, treeview2 As TreeView)

        Dim newTn As TreeNode
        For Each tn As TreeNode In treeview1.Nodes

            newTn = New TreeNode(tn.Text, tn.Value, tn.ImageUrl, tn.NavigateUrl, tn.Target)
            newTn.SelectAction = TreeNodeSelectAction.Expand
            newTn.Selected = tn.Selected
            newTn.Expanded = tn.Selected

            CopyChildsTreeview(newTn, tn)
            treeview2.Nodes.Add(newTn)
        Next
    End Sub

    Public Shared Sub CopyChildsTreeview(parent As TreeNode, willCopied As TreeNode)
        Dim newTn As TreeNode
        For Each tn As TreeNode In willCopied.ChildNodes
            newTn = New TreeNode(tn.Text, tn.Value, tn.ImageUrl, tn.NavigateUrl, tn.Target)
            newTn.Selected = tn.Selected
            newTn.Expanded = tn.Selected

            parent.ChildNodes.Add(newTn)
        Next
    End Sub



End Class
