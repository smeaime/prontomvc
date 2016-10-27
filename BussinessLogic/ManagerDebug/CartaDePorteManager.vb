﻿'Option Strict On
Option Explicit On

Option Infer On

Imports System.Data.OleDb

Imports System.Reflection
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

Imports ProntoMVC.Data

Imports System.Web.Security
Imports System.Security

Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager

Imports ClaseMigrar.SQLdinamico

'Namespace Pronto.ERP.Bll

Imports System.Collections.Generic


Imports System.Data.Entity.SqlServer

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

Imports ProntoMVC.Data.Models


Imports System.Net
'Imports System.Configuration
'Imports System.Web.Security

Imports Inlite.ClearImageNet


Imports CartaDePorteManager
Imports CDPMailFiltrosManager2

Imports LogicaImportador.FormatosDeExcel


Imports BitMiracle

Imports BitMiracle.LibTiff.Classic


Imports System.Drawing
Imports System.Drawing.Imaging



'Namespace Pronto.ERP.Bll


<DataObjectAttribute()> _
<Transaction(TransactionOption.Required)> _
Public Class CartaDePorteManager
    Inherits ServicedComponent



    Public Const MAXFILAS = 150
    Public Const MAXCOLS As Integer = 53 ' 35  'oSheet.UsedRange.Cells.Columns.Count


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


    Public Shared ReadOnly Property _dirftp_fisico As String
        Get
            Return ConfigurationManager.AppSettings("DirFTPFisico")
        End Get
    End Property



    Public Const CONSTANTE_HTML = False


    'cuestion con la opcion "AMBAS" vs ""

    'Public Shared excepciones As String() ' = New String() {"", "Agro", "Seeds", "CDC Pehua.", "CDC Olavar", "CDC Naon", "CDC G.Vill", "CDC Iriart", "CDC Wright", "CDC ACA", "GUALEGUAY", "GLGUAYCHU", "Rufino", "Bragado", "Las Flores", "OTROS"} 'usar como maximo 10 caracteres, por sql



    'Sub New(ByVal s As String)
    '    'excepciones = New String() {"", "Agro", "Seeds", "CDC Pehua.", "CDC Olavar", "CDC Naon", "CDC G.Vill", "CDC Iriart", "CDC Wright", "CDC ACA", "GUALEGUAY", "GLGUAYCHU", "OTROS"} 'usar como maximo 10 caracteres, por sql
    '    'excepciones = ConfigurationManager.AppSettings("WilliamsAcopios").Split(",")



    'End Sub



    Public Class CartasConCalada


        Public IdCartaDePorte As Integer


        Public NumeroCartaDePorte As Long
        Public NumeroCartaDePorteFormateada As String
        Public NumeroSubfijo As Integer
        Public SubnumeroVagon As Integer
        Public FechaArribo As Date
        Public FechaModificacion As Date
        Public FechaDescarga As Date
        Public FechaVencimiento As Date
        Public Observaciones As String



        Public NobleExtranos As Decimal = 0
        Public NobleNegros As Decimal = 0
        Public NobleQuebrados As Decimal = 0
        Public NobleDaniados As Decimal = 0
        Public NobleChamico As Decimal = 0
        Public NobleChamico2 As Decimal = 0
        Public NobleRevolcado As Decimal = 0
        Public NobleObjetables As Decimal = 0
        Public NobleAmohosados As Decimal = 0
        Public NobleHectolitrico As Decimal = 0
        Public NobleCarbon As Decimal = 0
        Public NoblePanzaBlanca As Decimal = 0
        Public NoblePicados As Decimal = 0
        Public NobleMGrasa As Decimal = 0
        Public NobleAcidezGrasa As Decimal = 0
        Public NobleVerdes As Decimal = 0
        Public NobleGrado As Integer = 0
        Public NobleConforme As Boolean
        Public NobleACamara As Boolean
        Public CalidadPuntaSombreada As Double = 0
        Public CalidadDescuentoFinal As Double = 0
        Public CalidadGranosQuemados As Double = 0
        Public CalidadGranosQuemadosBonifRebaja As Integer
        Public CalidadTierra As Double = 0
        Public CalidadTierraBonifRebaja As Integer
        Public CalidadMermaChamico As Double = 0
        Public CalidadMermaChamicoBonifRebaja As Integer
        Public CalidadMermaZarandeo As Double = 0
        Public CalidadMermaZarandeoBonifRebaja As Integer
        Public FueraDeEstandar As Boolean



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

        Public KmArecorrer As Integer
        Public Tarifa As Decimal



        Public IdProcedencia As String
        Public ProcedenciaDesc As String
        Public DestinoCUIT As String
        Public DestinoDesc As String
        Public CalidadDesc As String
        Public UsuarioIngreso As String

        Public Producto As String

        Public NetoProc As Decimal
        Public BrutoFinal As Decimal
        Public TaraFinal As Decimal
        Public NetoFinal As Decimal

        Public Merma As Decimal

        Public Humedad As Decimal
        Public HumedadDesnormalizada As Decimal



        Public ProcedenciaLocalidadONCCA_SAGPYA As String
        Public ProcedenciaPartidoONCCA As String

        Public ProcedenciaLocalidadAFIP As String
        Public DestinoLocalidadAFIP As String



        Public Patente As String
        Public Acoplado As String
        Public DestinoCodigoYPF As String

        Public TransportistaCUIT As String
        Public TransportistaDesc As String
        Public ChoferCUIT As String
        Public ChoferDesc As String

        Public EspecieONCCA As String
        Public Cosecha As String
        Public Establecimiento As String

        Public IdFacturaImputada As Integer
        Public IdClienteAFacturarle As Integer
        Public IdDetalleFacturaImputada As Integer
        Public PrecioUnitarioTotal As Decimal

        Public ClienteFacturado As String
        'y si devolves directamente el objeto pulenta?

        Public PathImagen As String


        Public ProductoSagpya As String


        Public NetoPto As Decimal
        Public TaraPto As Decimal
        Public BrutoPto As Decimal

        Public CEE_CAU As String
        Public CTG As Integer

        Public DestinoCodigoSAGPYA As String

        Public Contrato As String

        Public PuntoVenta As Integer


        Public Cosecha2 As String
        Public FechaDeCarga As Date
        Public NRecibo As String

        Public ProcedenciaCodigoPostal As String
        Public DestinoCodigoPostal As String



        Public CalidadGranosDanadosRebaja As Decimal
        Public CalidadGranosExtranosRebaja As Decimal


    End Class

    Enum FiltroANDOR
        FiltroOR = 0
        FiltroAND = 1
    End Enum

    Enum FiltroSyngenta
        SyngentaAMBAS = 3
        SyngentaSEEDS = 1
        SyngentaAGRO = 2
        SyngentaNINGUNA = 0
    End Enum



    Enum enumCDPexportacion
        Entregas
        Export
        Ambas
    End Enum


    Enum enumCDPestado
        Todas
        TodasMenosLasRechazadas
        Incompletas
        Posicion
        DescargasMasFacturadas
        DescargasSinFacturar
        Facturadas
        NoFacturadas
        Rechazadas
        FacturadaPeroEnNotaCredito
        DescargasDeHoyMasTodasLasPosiciones
        DescargasDeHoyMasTodasLasPosicionesEnRangoFecha
    End Enum



    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    'por ahora están en una lista, hay que pasarlos a una tabla

    Class aaa
        Public idacopio As Integer
        Public desc As String
        Public idcliente As Integer?
    End Class


    Public Shared Function excepcionesAcopios(SC As String, Optional idcliente As Integer = 0) As List(Of aaa)
        'Get

        If True Then
            'Dim SC As String = ""
            Dim cli As Integer

            If SC = "" Then Return Nothing '""}

            Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


            Dim q = (From i In db.CartasPorteAcopios1 _
                    Where (idcliente = 0 Or i.IdCliente = idcliente)
                    Select New aaa With {.idacopio = i.IdAcopio, .desc = i.Descripcion, .idcliente = i.IdCliente}).ToList()

            Dim x As New aaa
            x.idacopio = 0
            x.desc = ""
            x.idcliente = 0

            q.Add(x)


            Try
                Dim aaasd = (From y In q _
                            Order By y.idacopio _
                            ).ToList()

                Return aaasd

                'Return q.OrderBy(Function(z) z.idacopio).Select(Function(y) New With {y.idacopio, y.desc})



            Catch ex As Exception
                Dim s As String() = {""}
                Return Nothing 's
            End Try


        Else

            'Return ConfigurationManager.AppSettings("WilliamsAcopios").Split(",") 'verificar que no se pasen de 10 caracteres

        End If



        'End Get
        'Set(ByVal excepciones As String(SC))
        '    'newPropertyValue = value
        'End Set
        'End Property
    End Function


    Shared Function BuscarIdAcopio(descripcionAcopio As String, SC As String) As Integer
        'excepciones.Where(Function(x) x = descripcionAcopio).FirstOrDefault()


        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim q = (From i In db.CartasPorteAcopios1 _
                Where (i.Descripcion = descripcionAcopio)
                Select i.IdAcopio).FirstOrDefault

        Return q


        Dim s = excepcionesAcopios(SC)
        For n = 0 To excepcionesAcopios(SC).Count - 1
            If s(n).desc = descripcionAcopio Then Return s(n).idacopio
        Next



        Return -1
    End Function

    Shared Function BuscarTextoAcopio(IdAcopio As Integer, SC As String) As String
        If IdAcopio <= 0 Then Return ""

        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim q = (From i In db.CartasPorteAcopios1 _
                Where (i.IdAcopio = IdAcopio)
                Select i.Descripcion).FirstOrDefault

        Return q



        'If IdAcopio <= 0 Then Return ""
        'Try
        '    Return excepciones(SC)(IdAcopio)
        'Catch ex As Exception
        '    Return ""
        'End Try
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
            ByVal estado As CartaDePorteManager.enumCDPestado, _
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
            Optional bInsertarEnTablaTemporal As Boolean = False, _
            Optional ByVal optCamionVagon As String = "Ambas" _
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
                               puntoventa, optDivisionSyngenta, bTraerDuplicados, Contrato, QueContenga2, idClienteAuxiliar, Vagon, Patente, optCamionVagon)



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


            'If estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones Then
            '    dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_DescargasDeHoyMasTodasLasPosiciones", Today)
            '    sWHERE = sWHERE.Replace("CDP.", "")
            '    dt = DataTableWHERE(dt, sWHERE)

            'ElseIf estado = CartaDePorteManager.enumCDPestado.Posicion Then
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

            ErrHandler2.WriteAndRaiseError(s)

            'nohay manera de saber qué instancia lo tiró, si el de clientes o el normal? no hay manera de saber (en el mail) si fue desde un sincro, un informe,
            '    o la facturacion, etc?



        End Try




    End Function








    Public Shared Function BuscarTransportistaPorCUIT(cuit As String, SC As String, RazonSocial As String) As Integer

        If (Not ProntoMVC.Data.FuncionesGenericasCSharp.mkf_validacuit(cuit)) Then Return 0


        Dim db As DemoProntoEntities = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        Dim q = (From c In db.Transportistas Where c.Cuit.Trim.Replace("-", "") = cuit.Trim.Replace("-", "")).FirstOrDefault()




        If q Is Nothing Then
            If RazonSocial.Trim.Length > 4 Then
                q = New ProntoMVC.Data.Models.Transportista
                q.RazonSocial = RazonSocial
                q.Cuit = cuit
                'acá había un insertonsubmit
                db.Transportistas.Add(q)
                db.SaveChanges()
                Return q.IdTransportista
            Else
                Return 0
            End If

        Else
            CrearEquivalencia(RazonSocial, q.RazonSocial, SC)

            Return q.IdTransportista
        End If

        'DarDeAltaClienteProvisorio(cuit, SC, RazonSocial)





    End Function



    Public Shared Function BuscarChoferPorCUIT(cuit As String, SC As String, RazonSocial As String) As Integer

        If (Not ProntoMVC.Data.FuncionesGenericasCSharp.mkf_validacuit(cuit)) Then Return 0


        Dim db As DemoProntoEntities = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        Dim q = (From c In db.Choferes Where c.Cuil.Trim.Replace("-", "") = cuit.Trim.Replace("-", "")).FirstOrDefault()




        If q Is Nothing Then
            If RazonSocial.Trim.Length > 4 Then
                q = New ProntoMVC.Data.Models.Chofere
                q.Nombre = RazonSocial
                q.Cuil = cuit
                'acá había un insertonsubmit
                db.Choferes.Add(q)
                db.SaveChanges()
                Return q.IdChofer
            Else
                Return 0
            End If

        Else
            CrearEquivalencia(RazonSocial, q.Nombre, SC)

            Return q.IdChofer
        End If

        'DarDeAltaClienteProvisorio(cuit, SC, RazonSocial)





    End Function






    Public Shared Function BuscarDestinoPorCUIT(cuit As String, SC As String, RazonSocial As String, LocalidadDestino As String) As Integer

        Try

            If (Not ProntoMVC.Data.FuncionesGenericasCSharp.mkf_validacuit(cuit)) Then Return 0


            Dim db As DemoProntoEntities = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


            Dim q = (From dest In db.WilliamsDestinos _
                    From locdes In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(dest.IdLocalidad) Or
                                                                    i.IdLocalidad = CInt(dest.IdLocalidad) Or
                                                                    i.IdLocalidad = CInt(dest.IdLocalidad) Or
                                                                    i.IdLocalidad = CInt(dest.IdLocalidad)
                                                                        ).DefaultIfEmpty() _
                    Select dest, locdes
                    Where dest.CUIT.Trim.Replace("-", "") = cuit.Trim.Replace("-", "")).ToList()




            If q Is Nothing Then
                If RazonSocial.Trim.Length > 4 Then
                    Dim desti = New ProntoMVC.Data.Models.WilliamsDestino
                    desti.Descripcion = RazonSocial
                    desti.CUIT = cuit
                    'acá había un insertonsubmit
                    db.WilliamsDestinos.Add(desti)
                    db.SaveChanges()
                    Return desti.IdWilliamsDestino
                Else
                    Return 0
                End If

            ElseIf (q.Count > 1) Then
                'usar la localidad para guiarse
                'Return q(0).Nombre


                Dim c = (From x In q _
                         Select x.dest.IdWilliamsDestino, nombre = If(If(x.locdes, New Models.Localidad).Nombre, ""), dist = FuncionesGenericasCSharp.levenshtein(
                             If(If(x.locdes, New Models.Localidad).Nombre, "").Trim.ToUpper, LocalidadDestino.Trim.ToUpper)).ToList

                Dim a = c.Where(Function(x) x.dist < 4).OrderBy(Function(x) x.dist).ToList()

                If a.Count = 0 Then
                    Return 0
                Else
                    CrearEquivalencia(RazonSocial, a(0).nombre, SC)
                    Return a(0).IdWilliamsDestino
                End If

            Else
                CrearEquivalencia(RazonSocial, q(0).dest.Descripcion, SC)
                Return q(0).dest.IdWilliamsDestino
            End If

            'DarDeAltaClienteProvisorio(cuit, SC, RazonSocial)

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            Return 0
        End Try




    End Function


    Public Shared Function BuscarClientePorCUIT(cuit As String, SC As String, RazonSocial As String) As Integer

        Dim db As DemoProntoEntities = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))

        If (RazonSocial.ToUpper.Trim = "DIRECTO" Or cuit.Trim.Replace("-", "") = "00000000000") Then
            Dim id = (From c In db.Clientes Where c.RazonSocial = "DIRECTO" Select c.IdCliente).FirstOrDefault()
            Return id
        End If


        If (Not ProntoMVC.Data.FuncionesGenericasCSharp.mkf_validacuit(cuit)) Then Return 0
        If (Not CartaDePorteManager.VerfCuit(cuit)) Then Return 0





        Dim q = (From c In db.Clientes Where c.Cuit.Trim.Replace("-", "") = cuit.Trim.Replace("-", "")).FirstOrDefault()



        If q Is Nothing Then
            If RazonSocial.Trim.Length > 4 Then
                q = New ProntoMVC.Data.Models.Cliente
                q.RazonSocial = RazonSocial

                'hay q guardarlo con guiones????? -sí!!!!!
                q.Cuit = cuit

                'acá había un insertonsubmit
                db.Clientes.Add(q)
                db.SaveChanges()
                Return q.IdCliente
            Else
                Return 0
            End If

        Else
            CrearEquivalencia(RazonSocial, q.RazonSocial, SC)
            Return q.IdCliente
        End If





        'DarDeAltaClienteProvisorio(cuit, SC, RazonSocial)





    End Function




    Public Shared Function BuscarVendedorPorCUIT(cuit As String, SC As String, RazonSocial As String) As Integer

        Dim db As DemoProntoEntities = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        If (RazonSocial.ToUpper.Trim = "DIRECTO" Or cuit.Trim.Replace("-", "") = "00000000000") Then
            Dim id = (From c In db.Vendedores Where c.Nombre = "DIRECTO" Select c.IdVendedor).FirstOrDefault()
            Return id
        End If


        If (Not ProntoMVC.Data.FuncionesGenericasCSharp.mkf_validacuit(cuit)) Then Return 0
        If (Not CartaDePorteManager.VerfCuit(cuit)) Then Return 0


        Dim q = (From c In db.Vendedores Where c.Cuit.Trim.Replace("-", "") = cuit.Trim.Replace("-", "")).FirstOrDefault()




        If q Is Nothing Then
            If RazonSocial.Trim.Length > 4 Then
                q = New ProntoMVC.Data.Models.Vendedor
                q.Nombre = RazonSocial
                q.Cuit = cuit
                'acá había un insertonsubmit
                db.Vendedores.Add(q)
                db.SaveChanges()
                Return q.IdVendedor
            Else
                Return 0
            End If

        Else
            CrearEquivalencia(RazonSocial, q.Nombre, SC)

            Return q.IdVendedor
        End If

        'DarDeAltaClienteProvisorio(cuit, SC, RazonSocial)





    End Function

    Public Shared Function VerfCuit(ByVal e As String) As Boolean

        e = e.Replace("-", "").Replace(" ", "")

        Dim numconst As String = 5432765432
        Dim x As Integer
        Dim valor1 As Integer
        Dim valor2 As Integer
        Dim valor3 As Integer
        Dim comprobante As Integer = CInt(e.ToArray.GetValue(e.ToArray.Length - 1).ToString)

        For x = 0 To CInt(CInt(e.ToArray.Length).ToString - 2)
            valor1 += CInt(e.ToArray.GetValue(x).ToString) * CInt(numconst.ToArray.GetValue(x).ToString)
        Next

        valor2 = valor1 Mod 11
        valor3 = 11 - valor2

        If valor3 = comprobante Then
            Return True
        Else
            Return False
        End If

    End Function




    Public Shared Function CrearEquivalencia(palabra As String, traduccion As String, SC As String)

        If palabra = traduccion Then Return 0

        Dim db As DemoProntoEntities = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        Dim q = (From c In db.DiccionarioEquivalencias Where c.Palabra = palabra).FirstOrDefault()


        If q Is Nothing Then
            q = New ProntoMVC.Data.Models.DiccionarioEquivalencia
            q.Palabra = palabra
            q.Traduccion = traduccion

            db.DiccionarioEquivalencias.Add(q)
            db.SaveChanges()
        Else
            q.Traduccion = traduccion 'actualizo la traduccion. quizas hay alguna diferencia, quedará la consistencia con la ultima planilla importada
            db.SaveChanges()
        End If

        Return q.IdDiccionarioEquivalencia

    End Function





    

    Public Shared Function DarDeAltaClienteProvisorio(cuit As String, SC As String, RazonSocial As String) As Integer
        'Dim oDet As ProntoMVC.Data.Models.Cliente = (From i In db.CartasDePorteDetalles _
        '                            Where i.IdCartaDePorte = id _
        '                            And i.Campo = nombrecampo
        '                        ).SingleOrDefault

    End Function




    ''' <summary>
    ''' el SQL de la funcion estrella
    ''' </summary>
    ''' <param name="SC"></param>
    ''' <param name="ColumnaParaFiltrar"></param>
    ''' <param name="TextoParaFiltrar"></param>
    ''' <param name="sortExpression"></param>
    ''' <param name="startRowIndex"></param>
    ''' <param name="maximumRows"></param>
    ''' <param name="estado"></param>
    ''' <param name="QueContenga"> este cual es?????</param>
    ''' <param name="idVendedor"></param>
    ''' <param name="idCorredor"></param>
    ''' <param name="idDestinatario"></param>
    ''' <param name="idIntermediario"></param>
    ''' <param name="idRemComercial"></param>
    ''' <param name="idArticulo"></param>
    ''' <param name="idProcedencia"></param>
    ''' <param name="idDestino"></param>
    ''' <param name="AplicarANDuORalFiltro"></param>
    ''' <param name="ModoExportacion"></param>
    ''' <param name="fechadesde"></param>
    ''' <param name="fechahasta"></param>
    ''' <param name="puntoventa"></param>
    ''' <param name="sTituloFiltroUsado"></param>
    ''' <param name="optDivisionSyngenta"></param>
    ''' <param name="bTraerDuplicados"></param>
    ''' <param name="Contrato"></param>
    ''' <param name="QueContenga2">y este?????</param>
    ''' <param name="idClienteAuxiliar"></param>
    ''' <param name="AgrupadorDeTandaPeriodos"></param>
    ''' <param name="Vagon"></param>
    ''' <param name="Patente"></param>
    ''' <param name="bInsertarEnTablaTemporal"></param>
    ''' <param name="optCamionVagon"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Shared Function GetDataTableFiltradoYPaginado_CadenaSQL( _
            ByVal SC As String, _
            ByVal ColumnaParaFiltrar As String, _
            ByVal TextoParaFiltrar As String, _
            ByVal sortExpression As String, _
            ByVal startRowIndex As Long, _
            ByVal maximumRows As Long, _
            ByVal estado As CartaDePorteManager.enumCDPestado, _
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
            Optional bInsertarEnTablaTemporal As Boolean = False, _
            Optional ByVal optCamionVagon As String = "Ambas", _
        Optional sqlCount As Boolean = False _
                    ) As String

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
                               puntoventa, optDivisionSyngenta, bTraerDuplicados, Contrato, QueContenga2, idClienteAuxiliar, Vagon, Patente, optCamionVagon)



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


        Dim sqlString As String

        If sqlCount Then
            sqlString = GetListDataTableDinamicoConWHERE_2_CadenaSQL_COUNT(SC, estado, sWHERE, bInsertarEnTablaTemporal, maximumRows)  'de ultima se puede safar con esto tambien...
        Else
            sqlString = GetListDataTableDinamicoConWHERE_2_CadenaSQL(SC, estado, sWHERE, bInsertarEnTablaTemporal, maximumRows)  'de ultima se puede safar con esto tambien...
        End If



        Return sqlString





    End Function



    Public Shared Function GetDataTableFiltradoYPaginado_CadenaSQL_TambienEjecutaCount( _
           ByVal SC As String, _
           ByVal ColumnaParaFiltrar As String, _
           ByVal TextoParaFiltrar As String, _
           ByVal sortExpression As String, _
           ByVal startRowIndex As Long, _
           ByVal maximumRows As Long, _
           ByVal estado As CartaDePorteManager.enumCDPestado, _
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
           ByVal puntoventa As Integer,
           ByRef sqlCount As Long, _
            Optional ByRef sTituloFiltroUsado As String = "", _
           Optional ByVal optDivisionSyngenta As String = "Ambas", _
           Optional ByVal bTraerDuplicados As Boolean = False, _
           Optional ByVal Contrato As String = "", _
           Optional ByVal QueContenga2 As String = "", _
           Optional ByVal idClienteAuxiliar As Integer = -1, _
           Optional ByVal AgrupadorDeTandaPeriodos As Integer = -1, _
           Optional ByVal Vagon As Integer = Nothing, Optional ByVal Patente As String = "", _
           Optional bInsertarEnTablaTemporal As Boolean = False, _
           Optional ByVal optCamionVagon As String = "Ambas" _
                   ) As String




        Dim count = CartaDePorteManager.GetDataTableFiltradoYPaginado_CadenaSQL(SC, _
                     ColumnaParaFiltrar, TextoParaFiltrar, sortExpression, startRowIndex, maximumRows, _
                      estado, QueContenga, idVendedor, idCorredor, _
                      idDestinatario, idIntermediario, _
                      idRemComercial, idArticulo, idProcedencia, idDestino, _
               AplicarANDuORalFiltro, ModoExportacion,
                     fechadesde, fechahasta, _
                     puntoventa, sTituloFiltroUsado, optDivisionSyngenta, , Contrato, , idClienteAuxiliar, AgrupadorDeTandaPeriodos, , , , , True)


        Dim dt = EntidadManager.ExecDinamico(SC, count)
        sqlCount = dt.Rows(0).Item(0)
        'If sqlCount = 0 Then Return -1


        Return CartaDePorteManager.GetDataTableFiltradoYPaginado_CadenaSQL(SC, _
               ColumnaParaFiltrar, TextoParaFiltrar, sortExpression, startRowIndex, maximumRows, _
                estado, QueContenga, idVendedor, idCorredor, _
                idDestinatario, idIntermediario, _
                idRemComercial, idArticulo, idProcedencia, idDestino, _
         AplicarANDuORalFiltro, ModoExportacion,
               fechadesde, fechahasta, _
               puntoventa, sTituloFiltroUsado, optDivisionSyngenta, , Contrato, , idClienteAuxiliar, AgrupadorDeTandaPeriodos, , , , , False)


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
            ByVal estado As CartaDePorteManager.enumCDPestado, _
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
            Optional ByVal Vagon As Integer = Nothing, Optional ByVal Patente As String = "", _
 Optional ByRef db2 As DemoProntoEntities = Nothing _
    ) As IQueryable(Of ProntoMVC.Data.Models.CartasDePorte)

        Dim db As DemoProntoEntities
        If db2 Is Nothing Then db = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC))) Else db = db2

        'db.ObjectTrackingEnabled = False

        If System.Diagnostics.Debugger.IsAttached Then maximumRows = 300


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

        Dim q As IQueryable(Of ProntoMVC.Data.Models.CartasDePorte) = From cdp In db.CartasDePortes _
    Join cli In db.Clientes On cli.IdCliente Equals cdp.Vendedor _
    From art In db.Articulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
    From clitit In db.Clientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
    From clidest In db.Clientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
    From cliint In db.Clientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
    From clircom In db.Clientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
    From corr In db.Vendedores.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
    From cal In db.Calidade_EF.Where(Function(i) i.IdCalidad = CInt(cdp.Calidad)).DefaultIfEmpty _
    From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
    From estab In db.CDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
    From tr In db.Transportistas.Where(Function(i) i.IdTransportista = cdp.IdTransportista).DefaultIfEmpty _
    From loc In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(cdp.Procedencia)).DefaultIfEmpty _
    From chf In db.Choferes.Where(Function(i) i.IdChofer = cdp.IdChofer).DefaultIfEmpty _
    From emp In db.Empleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty _
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
            ByVal estado As CartaDePorteManager.enumCDPestado, _
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
          ByVal estado As CartaDePorteManager.enumCDPestado, _
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
          ByVal estado As CartaDePorteManager.enumCDPestado, _
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


            'optimizar, porque da sensacion de lentitud


            ' si regeneraste el .dbml, tenés que cambiar la  "Public ReadOnly Property CartasDePorte()" a "CartasDePortes"
            ' si regeneraste el .dbml, tenés que cambiar la  "Public ReadOnly Property CartasDePorte()" a "CartasDePortes"
            ' si regeneraste el .dbml, tenés que cambiar la  "Public ReadOnly Property CartasDePorte()" a "CartasDePortes"
            ' si regeneraste el .dbml, tenés que cambiar la  "Public ReadOnly Property CartasDePorte()" a "CartasDePortes"
            ' si regeneraste el .dbml, tenés que cambiar la  "Public ReadOnly Property CartasDePorte()" a "CartasDePortes"
            ' si regeneraste el .dbml, tenés que cambiar la  "Public ReadOnly Property CartasDePorte()" a "CartasDePortes"
            ' si regeneraste el .dbml, tenés que cambiar la  "Public ReadOnly Property CartasDePorte()" a "CartasDePortes"
            ' si regeneraste el .dbml, tenés que cambiar la  "Public ReadOnly Property CartasDePorte()" a "CartasDePortes"

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
              ByVal estado As CartaDePorteManager.enumCDPestado, _
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
              ByVal estado As CartaDePorteManager.enumCDPestado, _
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
              ByVal estado As CartaDePorteManager.enumCDPestado, _
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
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






    Shared Function FormatearTitulo( _
                    ByVal sc As String, ByRef sTituloFiltroUsado As String, _
                    ByVal estado As CartaDePorteManager.enumCDPestado, _
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
                    ByVal estado As CartaDePorteManager.enumCDPestado, _
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



            'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13222
            s = s.Replace("Descargas de Hoy + Todas las Posiciones", "Posición y Descargas de Hoy")



            'String.Format("{11} - {13} de Williams Entregas - {0} {1}", _


            '        Modificar el asunto de los mails para que queden de la siguiente manera:

            '* Si el mail es de Descargas:

            'Descargas del 04/07 al 04/07 - Nombre del cliente

            '* Si el mail es de Posición o Descargas del día + Posiciones:

            'Posición del 04/07 al 04/07 - Nombre del cliente
            s = s.Replace("Posición y Descargas de Hoy  del", "Posición del")






        Catch ex As Exception
            s = "mal formateado " + ex.ToString
            ErrHandler2.WriteError(ex.ToString + " asunto mal formateado")
        End Try


        Return s
    End Function


    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Shared Function CartasLINQlocalSimplificadoTipadoConCalada2(ByVal SC As String, _
      ByVal ColumnaParaFiltrar As String, _
      ByVal TextoParaFiltrar As String, _
      ByVal sortExpression As String, _
      ByVal startRowIndex As Long, _
      ByVal maximumRows As Long, _
      ByVal estado As enumCDPestado, _
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
      ByVal ModoExportacion As enumCDPexportacion, _
      ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
      ByVal puntoventa As Integer, _
      Optional ByRef sTituloFiltroUsado As String = "", _
      Optional ByVal optDivisionSyngenta As String = "Ambas", _
      Optional ByVal bTraerDuplicados As Boolean = False, _
      Optional ByVal Contrato As String = "", _
      Optional ByRef db2 As LinqCartasPorteDataContext = Nothing, _
        Optional ByVal QueContenga2 As String = "", _
        Optional ByVal idClienteAuxiliar As Integer = -1, _
        Optional ByVal AgrupadorDeTandaPeriodos As Integer = -1, _
        Optional ByVal Vagon As Integer = Nothing, Optional ByVal Patente As String = "", _
        Optional ByVal optCamionVagon As String = "Ambas" _
) As IQueryable(Of CartasConCalada)


        Dim s As String = [Enum].GetName(ModoExportacion.GetType(), ModoExportacion)


        Return CartasLINQlocalSimplificadoTipadoConCalada(SC, _
       ColumnaParaFiltrar, _
       TextoParaFiltrar, _
     sortExpression, _
     startRowIndex, _
     maximumRows, _
     estado, _
     QueContenga, _
     idVendedor, _
     idCorredor, _
     idDestinatario, _
     idIntermediario, _
     idRemComercial, _
     idArticulo, _
     idProcedencia, _
     idDestino, _
     AplicarANDuORalFiltro, _
     s, _
     fechadesde, fechahasta, _
     puntoventa, _
        sTituloFiltroUsado, _
      optDivisionSyngenta, _
      bTraerDuplicados, _
      Contrato, _
        db2, _
        QueContenga2, _
        idClienteAuxiliar, _
        AgrupadorDeTandaPeriodos, _
        Vagon, Patente, _
        optCamionVagon)

    End Function


    Shared Function CartasLINQlocalSimplificadoTipadoConCalada3(ByVal SC As String, _
         ByVal ColumnaParaFiltrar As String, _
         ByVal TextoParaFiltrar As String, _
         ByVal sortExpression As String, _
         ByVal startRowIndex As Long, _
         ByVal maximumRows As Long, _
         ByVal estado As enumCDPestado, _
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
         ByVal ModoExportacionString As String, _
         ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
         ByVal puntoventa As Integer, _
         Optional ByRef sTituloFiltroUsado As String = "", _
         Optional ByVal optDivisionSyngenta As String = "Ambas", _
         Optional ByVal bTraerDuplicados As Boolean = False, _
         Optional ByVal Contrato As String = "", _
         Optional ByRef db2 As DemoProntoEntities = Nothing, _
           Optional ByVal QueContenga2 As String = "", _
           Optional ByVal idClienteAuxiliar As Integer = -1, _
           Optional ByVal AgrupadorDeTandaPeriodos As Integer = -1, _
           Optional ByVal Vagon As Integer = Nothing, Optional ByVal Patente As String = "", _
           Optional ByVal optCamionVagon As String = "Ambas" _
) As IQueryable(Of CartasConCalada)


        'con entityframework
        Dim db As DemoProntoEntities
        If db2 Is Nothing Then db = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC))) Else db = db2
        db.Database.CommandTimeout = 200

        'con linqtosql
        'Dim db As LinqCartasPorteDataContext
        'If db2 Is Nothing Then db = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC))) Else db = db2
        ''db.ObjectTrackingEnabled = False


        Dim ModoExportacion As enumCDPexportacion
        Select Case ModoExportacionString
            Case "Entregas"
                ModoExportacion = enumCDPexportacion.Entregas
            Case "Export"
                ModoExportacion = enumCDPexportacion.Export
            Case "Ambas"
                ModoExportacion = enumCDPexportacion.Ambas
            Case Else
                Throw New Exception("Exportacion desconocida")
        End Select



        'If System.Diagnostics.Debugger.IsAttached Then maximumRows = 300


        '       Remember, the query is nothing more than an object which represents the query. Think of it 
        'like a SQL query string, just way smarter. Passing a query string around doesn't execute the query; executing 
        'the query executes the query. – Eric Lippert J

        'y qué pasa si vuelvo a usar Equals? (en lugar de DefaultIfEmpty que me permite traer los nulls)


        '.NumeroCartaDePorteFormateada = cdp.NumeroCartaDePorte.ToString.PadLeft(12, "0").Substring(0, 4) & "-" & cdp.NumeroCartaDePorte.ToString.PadLeft(12, "0").Substring(4, 8)


        Dim q As IQueryable(Of CartasConCalada) = (From cdp In db.CartasDePortes _
                From art In db.Articulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.Clientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                From clidest In db.Clientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
                From cliint In db.Clientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
                From clircom In db.Clientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
                From corr In db.Vendedores.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
                From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                From loc In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(cdp.Procedencia)).DefaultIfEmpty _
                From cal In db.Calidade_EF.Where(Function(i) i.IdCalidad = cdp.Calidad).DefaultIfEmpty _
                From estab In db.CDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
                From tr In db.Transportistas.Where(Function(i) i.IdTransportista = cdp.IdTransportista).DefaultIfEmpty _
                From chf In db.Choferes.Where(Function(i) i.IdChofer = cdp.IdChofer).DefaultIfEmpty _
                From emp In db.Empleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty _
                From fac In db.Facturas.Where(Function(i) i.IdFactura = cdp.IdFacturaImputada).DefaultIfEmpty _
                From detfac In db.DetalleFacturas.Where(Function(i) i.IdDetalleFactura = cdp.IdDetalleFactura).DefaultIfEmpty _
                From clifac In db.Clientes.Where(Function(i) i.IdCliente = fac.IdCliente).DefaultIfEmpty _
                From locdes In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(dest.IdLocalidad)).DefaultIfEmpty _
                From part In db.Partidos.Where(Function(i) i.IdPartido = loc.IdPartido).DefaultIfEmpty _
                Where _
            cdp.Vendedor > 0 _
            And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
            And (estado <> enumCDPestado.Facturadas Or If(cdp.IdFacturaImputada, 0) > 0) _
            And (estado = enumCDPestado.Rechazadas Or cdp.Anulada <> "SI") _
            And (ModoExportacion = enumCDPexportacion.Ambas _
                    Or (ModoExportacion = enumCDPexportacion.Export And cdp.Exporta = "SI") _
                    Or (ModoExportacion = enumCDPexportacion.Entregas And cdp.Exporta <> "SI")) _
            And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
            And ( _
                  (idVendedor = -1 And idIntermediario = -1 And idRemComercial = -1) _
                  Or _
                  (AplicarANDuORalFiltro = FiltroANDOR.FiltroAND _
                    And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                    And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                    And (idRemComercial = -1 Or cdp.CuentaOrden2 = idRemComercial) _
                  ) _
                  Or _
                  (AplicarANDuORalFiltro = FiltroANDOR.FiltroOR And _
                    (cdp.Vendedor = idVendedor Or cdp.CuentaOrden1 = idIntermediario Or cdp.CuentaOrden2 = idRemComercial) _
                   ) _
                ) _
            And (idCorredor = -1 Or cdp.Corredor = idCorredor Or cdp.Corredor2 = idCorredor) _
            And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
            And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
            And (idDestino = -1 Or cdp.Destino = idDestino) _
            And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
            And (idClienteAuxiliar = -1 Or cdp.IdClienteAuxiliar = idClienteAuxiliar) _
            And (QueContenga2 = "" Or cdp.NumeroCartaEnTextoParaBusqueda.Contains(QueContenga2)) _
            Order By cdp.FechaModificacion Descending _
            Select New CartasConCalada With { _
             .IdCartaDePorte = cdp.IdCartaDePorte, _
             .NumeroCartaDePorte = cdp.NumeroCartaDePorte, _
             .NumeroCartaDePorteFormateada = "000" & SqlFunctions.StringConvert(cdp.NumeroCartaDePorte).Substring(1, 1) & "-" & SqlFunctions.StringConvert(cdp.NumeroCartaDePorte).Substring(2, 8), _
             .NumeroSubfijo = cdp.NumeroSubfijo, _
             .SubnumeroVagon = cdp.SubnumeroVagon, _
             .FechaArribo = If(cdp.FechaArribo, DateTime.MinValue), _
             .FechaModificacion = If(cdp.FechaModificacion, DateTime.MinValue), _
             .FechaDescarga = If(cdp.FechaDescarga, DateTime.MinValue), _
             .FechaVencimiento = If(cdp.FechaVencimiento, DateTime.MinValue), _
             .Observaciones = cdp.Observaciones, _
             .CTG = If(cdp.CTG, 0), _
 _
            .NetoProc = cdp.NetoProc, _
            .NetoFinal = cdp.NetoFinal, _
            .TaraFinal = cdp.TaraFinal, _
            .BrutoFinal = cdp.BrutoFinal, _
            .NetoPto = cdp.NetoPto, _
            .TaraPto = cdp.TaraPto, _
            .BrutoPto = cdp.BrutoPto, _
            .Humedad = cdp.Humedad, _
            .HumedadDesnormalizada = cdp.HumedadDesnormalizada, _
            .Merma = cdp.Merma, _
            .CalidadDesc = If(cal.Descripcion, ""), _
             .Tarifa = cdp.Tarifa, _
             .KmArecorrer = cdp.KmARecorrer, _
 _
             .TitularDesc = clitit.RazonSocial, _
             .IntermediarioDesc = cliint.RazonSocial, _
             .RComercialDesc = clircom.RazonSocial, _
             .CorredorDesc = corr.Nombre, _
             .DestinatarioDesc = clidest.RazonSocial, _
             .TitularCUIT = clitit.Cuit.Replace("-", ""), _
             .IntermediarioCUIT = cliint.Cuit.Replace("-", ""), _
             .RComercialCUIT = clircom.Cuit.Replace("-", ""), _
             .CorredorCUIT = corr.Cuit.Replace("-", ""), _
             .DestinatarioCUIT = clidest.Cuit.Replace("-", ""), _
 _
             .Producto = art.Descripcion, _
             .ProductoSagpya = art.AuxiliarString6, _
             .IdProcedencia = cdp.Procedencia, _
             .ProcedenciaDesc = loc.Nombre, _
             .DestinoDesc = dest.Descripcion, _
             .UsuarioIngreso = "", _
            .FechaDeCarga = If(cdp.FechaDeCarga, cdp.FechaArribo), _
            .NobleExtranos = cdp.NobleExtranos, _
            .NobleNegros = cdp.NobleNegros, _
            .NobleQuebrados = cdp.NobleQuebrados, _
            .NobleDaniados = cdp.NobleDaniados, _
            .NobleChamico = cdp.NobleChamico, _
            .NobleChamico2 = cdp.NobleChamico2, _
            .NobleRevolcado = cdp.NobleRevolcado, _
            .NobleObjetables = cdp.NobleObjetables, _
            .NobleAmohosados = cdp.NobleAmohosados, _
            .NobleHectolitrico = cdp.NobleObjetables, _
            .NobleCarbon = cdp.NobleHectolitrico, _
             .NoblePanzaBlanca = cdp.NoblePanzaBlanca, _
            .NoblePicados = cdp.NoblePicados, _
            .NobleMGrasa = cdp.NobleMGrasa, _
            .NobleAcidezGrasa = cdp.NobleAcidezGrasa, _
            .NobleVerdes = cdp.NobleVerdes, _
            .NobleGrado = cdp.NobleGrado, _
            .NobleConforme = cdp.NobleConforme, _
            .NobleACamara = (cdp.NobleACamara = "SI"), _
            .CalidadPuntaSombreada = If(cdp.CalidadPuntaSombreada, 0), _
            .CalidadGranosQuemados = If(cdp.CalidadGranosQuemados, 0), _
            .CalidadGranosQuemadosBonifRebaja = 0, _
            .CalidadTierra = If(cdp.CalidadTierra, 0), _
            .CalidadTierraBonifRebaja = If(cdp.CalidadPuntaSombreada, 0), _
            .CalidadMermaChamico = If(cdp.CalidadMermaChamico, 0), _
            .CalidadMermaChamicoBonifRebaja = 0, _
            .CalidadMermaZarandeo = If(cdp.CalidadMermaZarandeo, 0), _
            .CalidadMermaZarandeoBonifRebaja = 0, _
 _
            .ProcedenciaLocalidadONCCA_SAGPYA = loc.CodigoONCAA, _
            .ProcedenciaPartidoONCCA = part.CodigoONCCA, _
          .ProcedenciaLocalidadAFIP = loc.CodigoAfip, _
            .DestinoLocalidadAFIP = locdes.CodigoAfip, _
 _
             .Patente = cdp.Patente, _
            .Acoplado = cdp.Acoplado, _
             .DestinoCUIT = dest.CUIT.Replace("-", ""), _
            .DestinoCodigoYPF = dest.CodigoYPF, _
            .DestinoCodigoSAGPYA = dest.CodigoONCAA, _
            .TransportistaCUIT = tr.Cuit.Replace("-", ""), _
            .ChoferCUIT = chf.Cuil.Replace("-", ""), _
            .TransportistaDesc = tr.RazonSocial, _
            .ChoferDesc = chf.Nombre, _
            .EspecieONCCA = art.AuxiliarString6, _
            .Cosecha = cdp.Cosecha.Replace("/", "-20"), _
            .Cosecha2 = cdp.Cosecha.Replace("20", "").Replace("/", ""), _
            .Establecimiento = estab.Descripcion, _
 _
            .IdFacturaImputada = If(cdp.IdFacturaImputada, -1), _
            .IdClienteAFacturarle = If(cdp.IdClienteAFacturarle, -1), _
            .IdDetalleFacturaImputada = If(cdp.IdDetalleFactura, -1), _
            .PrecioUnitarioTotal = If(detfac.PrecioUnitarioTotal, 0), _
            .ClienteFacturado = clifac.RazonSocial, _
            .PathImagen = cdp.PathImagen, _
 _
                .CEE_CAU = cdp.CEE _
        , .Contrato = cdp.Contrato _
      , .PuntoVenta = If(cdp.PuntoVenta, 0) _
  , .NRecibo = cdp.NRecibo, _
     .CalidadGranosDanadosRebaja = 0.01, _
             .CalidadGranosExtranosRebaja = 0.01, _
         .DestinoCodigoPostal = dest.CodigoPostal _
        , .ProcedenciaCodigoPostal = loc.CodigoPostal
           }) 'cosecha2 queda 1415, cosecha queda 2014/2015, original es 2014/15








        If False Then
            q = q.Skip(startRowIndex)  'el Skip no anda con SQL2000
        End If
        q = q.Take(maximumRows)





        '      "          LOCORI.CodigoPostal as LocalidadProcedenciaCodigoPostal, " & _
        '"          LOCDES.Codigo as LocalidadDestinoCodigoPostal, " & _
        '"          LOCORI.CodigoONCAA as LocalidadProcedenciaCodigoONCAA, " & _
        '"          LOCDES.CodigoONCAA as LocalidadDestinoCodigoONCAA, " & _
        '"          LOCORI.CodigoLosGrobo as LocalidadProcedenciaCodigoLosGrobo, " & _
        '"          LOCDES.CodigoLosGrobo as LocalidadDestinoCodigoLosGrobo, " & _
        '"         Articulos.AuxiliarString6 as  [CodigoSagypa] , " & _
        '"         Articulos.AuxiliarString7 as  [CodigoZeni] , " & _
        '"          NumeroSubfijo as SufijoCartaDePorte, " & _
        '"          Tarifa as Tarifa, " & _
        '"          CDP.IdArticulo, " & _
        '"           Calidad, " & _
        '"          Cosecha, NobleGrado,Factor, ESTAB.Descripcion as CodigoEstablecimientoProcedencia, ESTAB.AuxiliarString1 as DescripcionEstablecimientoProcedencia, " & _
        '"           CTG as CTG, CEE, FechaAnulacion,MotivoAnulacion, " & _
        '"          '' as CadenaVacia, NetoProc, EnumSyngentaDivision, IdTipoMovimiento,CobraAcarreo,LiquidaViaje,IdCartaDePorte,SubNumeroVagon,Procedencia  " & _


        Debug.Print(q.ToString) '   mejor usá el 
        '                           profiler para traerte la consulta sql. 
        '                           Y despues, la pasas al informe para tener bien el orden de las columnas
        '                           Tuve problemas con los parametros de fecha, las pasé a ANSI en la consulta y listo
        ' -pero tenés los campos que son creados desde linq! por ejemplo, puntoventa!!

        Return q 'hago el tolist porque estoy en un using

    End Function


    Shared Function AdjuntarImagenEnZip2(SC As String, nombrearchivo As String, DirApp As String) As String


        Dim DIRTEMP As String = DirApp & "\Temp\"
        Dim DIRFTP As String = DirApp & "\DataBackupear\"




        Dim destzip = DIRTEMP + "zipeado.zip"
        Dim MyFile3 As New FileInfo(destzip)
        Try
            If MyFile3.Exists Then
                MyFile3.Delete()
            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try



        If False Then
            'no borrar todos los archivos

            Dim files = Directory.GetFiles(DIRTEMP)
            For Each file As String In files
                IO.File.SetAttributes(file, FileAttributes.Normal)
                Try
                    IO.File.Delete(file)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try
            Next

        End If


        Dim archivos As Generic.List(Of String) = ExtraerZip(destzip, DIRTEMP)

    End Function



    Shared Function CartasLINQlocalSimplificadoTipadoConCalada(ByVal SC As String, _
          ByVal ColumnaParaFiltrar As String, _
          ByVal TextoParaFiltrar As String, _
          ByVal sortExpression As String, _
          ByVal startRowIndex As Long, _
          ByVal maximumRows As Long, _
          ByVal estado As enumCDPestado, _
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
          ByVal ModoExportacionString As String, _
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
          ByVal puntoventa As Integer, _
          Optional ByRef sTituloFiltroUsado As String = "", _
          Optional ByVal optDivisionSyngenta As String = "Ambas", _
          Optional ByVal bTraerDuplicados As Boolean = False, _
          Optional ByVal Contrato As String = "", _
          Optional ByRef db2 As LinqCartasPorteDataContext = Nothing, _
            Optional ByVal QueContenga2 As String = "", _
            Optional ByVal idClienteAuxiliar As Integer = -1, _
            Optional ByVal AgrupadorDeTandaPeriodos As Integer = -1, _
            Optional ByVal Vagon As Integer = Nothing, Optional ByVal Patente As String = "", _
            Optional ByVal optCamionVagon As String = "Ambas" _
) As IQueryable(Of CartasConCalada)


        'con entityframework
        'Dim db As DemoProntoEntities
        'If db2 Is Nothing Then db = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC))) Else db = db2

        'con linqtosql

        Dim db As LinqCartasPorteDataContext
        If db2 Is Nothing Then db = New LinqCartasPorteDataContext(Encriptar(SC)) Else db = db2
        db.ObjectTrackingEnabled = False


        Dim ModoExportacion As enumCDPexportacion
        Select Case ModoExportacionString
            Case "Entregas"
                ModoExportacion = enumCDPexportacion.Entregas
            Case "Export"
                ModoExportacion = enumCDPexportacion.Export
            Case "Ambas"
                ModoExportacion = enumCDPexportacion.Ambas
            Case Else
                Throw New Exception("Exportacion desconocida")
        End Select



        'If System.Diagnostics.Debugger.IsAttached Then maximumRows = 300


        '       Remember, the query is nothing more than an object which represents the query. Think of it 
        'like a SQL query string, just way smarter. Passing a query string around doesn't execute the query; executing 
        'the query executes the query. – Eric Lippert J

        'y qué pasa si vuelvo a usar Equals? (en lugar de DefaultIfEmpty que me permite traer los nulls)









        Dim q As IQueryable(Of CartasConCalada) = (From cdp In db.CartasDePortes _
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
                From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
                From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
                From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
                From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                From loc In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(cdp.Procedencia)).DefaultIfEmpty _
                From cal In db.Calidades.Where(Function(i) i.IdCalidad = cdp.Calidad).DefaultIfEmpty _
                From estab In db.linqCDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
                From tr In db.Transportistas.Where(Function(i) i.IdTransportista = cdp.IdTransportista).DefaultIfEmpty _
                From part In db.linqPartido.Where(Function(i) i.IdPartido = loc.IdPartido).DefaultIfEmpty _
                From chf In db.Choferes.Where(Function(i) i.IdChofer = cdp.IdChofer).DefaultIfEmpty _
                From emp In db.linqEmpleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty _
                From fac In db.linqFacturas.Where(Function(i) i.IdFactura = cdp.IdFacturaImputada).DefaultIfEmpty _
                From detfac In db.linqDetalleFacturas.Where(Function(i) i.IdDetalleFactura = cdp.IdDetalleFactura).DefaultIfEmpty _
                From clifac In db.linqClientes.Where(Function(i) i.IdCliente = fac.IdCliente).DefaultIfEmpty _
                Where _
        cdp.Vendedor > 0 _
        And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
        And (estado <> enumCDPestado.Facturadas Or If(cdp.IdFacturaImputada, 0) > 0) _
        And (estado = enumCDPestado.Rechazadas Or cdp.Anulada <> "SI") _
        And (ModoExportacion = enumCDPexportacion.Ambas _
            Or (ModoExportacion = enumCDPexportacion.Export And cdp.Exporta = "SI") _
            Or (ModoExportacion = enumCDPexportacion.Entregas And cdp.Exporta <> "SI")) _
        And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
        And ( _
          (idVendedor = -1 And idIntermediario = -1 And idRemComercial = -1) _
          Or _
          (AplicarANDuORalFiltro = FiltroANDOR.FiltroAND _
            And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
            And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
            And (idRemComercial = -1 Or cdp.CuentaOrden2 = idRemComercial) _
          ) _
          Or _
          (AplicarANDuORalFiltro = FiltroANDOR.FiltroOR And _
            (cdp.Vendedor = idVendedor Or cdp.CuentaOrden1 = idIntermediario Or cdp.CuentaOrden2 = idRemComercial) _
           ) _
        ) _
        And (idCorredor = -1 Or cdp.Corredor = idCorredor Or cdp.Corredor2 = idCorredor) _
        And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
        And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
        And (idDestino = -1 Or cdp.Destino = idDestino) _
        And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
        And (QueContenga2 = "" Or cdp.NumeroCartaEnTextoParaBusqueda.Contains(QueContenga2))
        Order By cdp.FechaModificacion Descending _
           Select New CartasConCalada With { _
             .IdCartaDePorte = cdp.IdCartaDePorte, _
             .NumeroCartaDePorte = cdp.NumeroCartaDePorte, _
             .NumeroCartaDePorteFormateada = cdp.NumeroCartaDePorte.ToString.PadLeft(12, "0").Substring(0, 4) & "-" & cdp.NumeroCartaDePorte.ToString.PadLeft(12, "0").Substring(4, 8), _
             .NumeroSubfijo = cdp.NumeroSubfijo, _
             .SubnumeroVagon = cdp.SubnumeroVagon, _
             .FechaArribo = If(cdp.FechaArribo, DateTime.MinValue), _
             .FechaModificacion = If(cdp.FechaModificacion, DateTime.MinValue), _
             .FechaDescarga = If(cdp.FechaDescarga, DateTime.MinValue), _
             .Observaciones = cdp.Observaciones, _
 _
            .NetoProc = cdp.NetoProc, _
            .NetoFinal = cdp.NetoFinal, _
            .TaraFinal = cdp.TaraFinal, _
            .BrutoFinal = cdp.BrutoFinal, _
            .NetoPto = cdp.NetoPto, _
            .TaraPto = cdp.TaraPto, _
            .BrutoPto = cdp.BrutoPto, _
            .Humedad = cdp.Humedad, _
            .HumedadDesnormalizada = cdp.HumedadDesnormalizada, _
            .Merma = cdp.Merma, _
 _
             .TitularDesc = clitit.RazonSocial, _
             .IntermediarioDesc = cliint.RazonSocial, _
             .RComercialDesc = clircom.RazonSocial, _
             .CorredorDesc = corr.Nombre, _
             .DestinatarioDesc = clidest.RazonSocial, _
             .TitularCUIT = clitit.Cuit.Replace("-", ""), _
             .IntermediarioCUIT = cliint.Cuit.Replace("-", ""), _
             .RComercialCUIT = clircom.Cuit.Replace("-", ""), _
             .CorredorCUIT = corr.Cuit.Replace("-", ""), _
             .DestinatarioCUIT = clidest.Cuit.Replace("-", ""), _
 _
             .Producto = art.Descripcion, _
             .ProductoSagpya = art.AuxiliarString6, _
             .IdProcedencia = cdp.Procedencia, _
             .ProcedenciaDesc = loc.Nombre, _
             .DestinoDesc = dest.Descripcion, _
             .CalidadDesc = cdp.Calidad, _
             .UsuarioIngreso = "", _
            .FechaDeCarga = If(cdp.FechaDeCarga, If(cdp.FechaArribo, DateTime.MinValue)), _
            .NobleExtranos = cdp.NobleExtranos, _
            .NobleNegros = cdp.NobleNegros, _
            .NobleQuebrados = cdp.NobleQuebrados, _
            .NobleDaniados = cdp.NobleDaniados, _
            .NobleChamico = cdp.NobleChamico, _
            .NobleChamico2 = cdp.NobleChamico2, _
            .NobleRevolcado = cdp.NobleRevolcado, _
            .NobleObjetables = cdp.NobleObjetables, _
            .NobleAmohosados = cdp.NobleAmohosados, _
            .NobleHectolitrico = cdp.NobleObjetables, _
            .NobleCarbon = cdp.NobleHectolitrico, _
             .NoblePanzaBlanca = cdp.NoblePanzaBlanca, _
            .NoblePicados = cdp.NoblePicados, _
            .NobleMGrasa = cdp.NobleMGrasa, _
            .NobleAcidezGrasa = cdp.NobleAcidezGrasa, _
            .NobleVerdes = cdp.NobleVerdes, _
            .NobleGrado = cdp.NobleGrado, _
            .NobleConforme = cdp.NobleConforme, _
            .NobleACamara = (cdp.NobleACamara = "SI"), _
            .CalidadPuntaSombreada = If(cdp.CalidadPuntaSombreada, 0), _
            .CalidadGranosQuemados = If(cdp.CalidadGranosQuemados, 0), _
            .CalidadGranosQuemadosBonifRebaja = If(cdp.CalidadGranosQuemadosBonifica_o_Rebaja, 0), _
            .CalidadTierra = If(cdp.CalidadTierra, 0), _
            .CalidadTierraBonifRebaja = If(cdp.CalidadPuntaSombreada, 0), _
            .CalidadMermaChamico = If(cdp.CalidadMermaChamico, 0), _
            .CalidadMermaChamicoBonifRebaja = If(cdp.CalidadMermaChamicoBonifica_o_Rebaja, 0), _
            .CalidadMermaZarandeo = If(cdp.CalidadMermaZarandeo, 0), _
            .CalidadMermaZarandeoBonifRebaja = If(cdp.CalidadMermaZarandeoBonifica_o_Rebaja, 0), _
 _
            .ProcedenciaLocalidadONCCA_SAGPYA = loc.CodigoONCAA, _
            .ProcedenciaPartidoONCCA = part.CodigoONCCA, _
 _
             .Patente = cdp.Patente, _
            .Acoplado = cdp.Acoplado, _
            .DestinoCodigoYPF = dest.CodigoYPF, _
            .DestinoCodigoSAGPYA = dest.CodigoONCAA, _
            .TransportistaCUIT = tr.Cuit.Replace("-", ""), _
            .ChoferCUIT = chf.CUIL.Replace("-", ""), _
            .TransportistaDesc = tr.RazonSocial, _
            .ChoferDesc = chf.Nombre, _
            .EspecieONCCA = art.AuxiliarString6, _
            .Cosecha = cdp.Cosecha.Replace("/", "-20"), _
            .Cosecha2 = cdp.Cosecha.Replace("20", "").Replace("/", ""), _
            .Establecimiento = estab.Descripcion, _
 _
            .IdFacturaImputada = If(cdp.IdFacturaImputada, -1), _
            .IdClienteAFacturarle = If(cdp.IdClienteAFacturarle, -1), _
            .IdDetalleFacturaImputada = If(cdp.IdDetalleFactura, -1), _
            .PrecioUnitarioTotal = If(detfac.PrecioUnitarioTotal, 0), _
            .ClienteFacturado = clifac.RazonSocial, _
            .PathImagen = cdp.PathImagen, _
 _
                .CEE_CAU = cdp.CEE _
        , .Contrato = cdp.Contrato _
      , .PuntoVenta = If(cdp.PuntoVenta, 0) _
  , .NRecibo = cdp.NRecibo _
    , .CalidadGranosDanadosRebaja = If(cdp.CalidadGranosDanadosRebaja, 0) _
            , .CalidadGranosExtranosRebaja = If(cdp.CalidadGranosExtranosRebaja, 0) _
        , .DestinoCodigoPostal = dest.CodigoPostal _
        , .ProcedenciaCodigoPostal = loc.CodigoPostal
           }) 'cosecha2 queda 1415, cosecha queda 2014/2015, original es 2014/15








        If False Then
            q = q.Skip(startRowIndex)  'el Skip no anda con SQL2000
        End If
        q = q.Take(maximumRows)





        '      "          LOCORI.CodigoPostal as LocalidadProcedenciaCodigoPostal, " & _
        '"          LOCDES.Codigo as LocalidadDestinoCodigoPostal, " & _
        '"          LOCORI.CodigoONCAA as LocalidadProcedenciaCodigoONCAA, " & _
        '"          LOCDES.CodigoONCAA as LocalidadDestinoCodigoONCAA, " & _
        '"          LOCORI.CodigoLosGrobo as LocalidadProcedenciaCodigoLosGrobo, " & _
        '"          LOCDES.CodigoLosGrobo as LocalidadDestinoCodigoLosGrobo, " & _
        '"         Articulos.AuxiliarString6 as  [CodigoSagypa] , " & _
        '"         Articulos.AuxiliarString7 as  [CodigoZeni] , " & _
        '"          NumeroSubfijo as SufijoCartaDePorte, " & _
        '"          Tarifa as Tarifa, " & _
        '"          CDP.IdArticulo, " & _
        '"           Calidad, " & _
        '"          Cosecha, NobleGrado,Factor, ESTAB.Descripcion as CodigoEstablecimientoProcedencia, ESTAB.AuxiliarString1 as DescripcionEstablecimientoProcedencia, " & _
        '"           CTG as CTG, CEE, FechaAnulacion,MotivoAnulacion, " & _
        '"          '' as CadenaVacia, NetoProc, EnumSyngentaDivision, IdTipoMovimiento,CobraAcarreo,LiquidaViaje,IdCartaDePorte,SubNumeroVagon,Procedencia  " & _


        Debug.Print(q.ToString) '   mejor usá el 
        '                           profiler para traerte la consulta sql. 
        '                           Y despues, la pasas al informe para tener bien el orden de las columnas
        '                           Tuve problemas con los parametros de fecha, las pasé a ANSI en la consulta y listo
        ' -pero tenés los campos que son creados desde linq! por ejemplo, puntoventa!!

        Return q 'hago el tolist porque estoy en un using

    End Function


    Shared Function RefrescarCartasPorteDetalleFacturas(sc)
        ExecDinamico(sc, "EXEC dbo.RefrescarCartasPorteDetalleFacturas", 120)
    End Function




    Shared Function CartasLINQlocalSimplificadoTipadoConCalada_Todos(ByVal SC As String) As IQueryable(Of CartasConCalada)


        Dim db As LinqCartasPorteDataContext = New LinqCartasPorteDataContext(Encriptar(SC))
        'If db2 Is Nothing Then db = New LinqCartasPorteDataContext(Encriptar(SC)) Else db = db2

        db.ObjectTrackingEnabled = False


        '       Remember, the query is nothing more than an object which represents the query. Think of it 
        'like a SQL query string, just way smarter. Passing a query string around doesn't execute the query; executing 
        'the query executes the query. – Eric Lippert J

        'y qué pasa si vuelvo a usar Equals? (en lugar de DefaultIfEmpty que me permite traer los nulls)





        Dim q As IQueryable(Of CartasConCalada) = (From cdp In db.CartasDePortes _
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
                From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
                From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
                From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
                From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                From proced_loc In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(cdp.Procedencia)).DefaultIfEmpty _
                From cal In db.Calidades.Where(Function(i) i.IdCalidad = cdp.Calidad).DefaultIfEmpty _
                From estab In db.linqCDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
                From tr In db.Transportistas.Where(Function(i) i.IdTransportista = cdp.IdTransportista).DefaultIfEmpty _
                From proced_part In db.linqPartido.Where(Function(i) i.IdPartido = proced_loc.IdPartido).DefaultIfEmpty _
                From chf In db.Choferes.Where(Function(i) i.IdChofer = cdp.IdChofer).DefaultIfEmpty _
                From emp In db.linqEmpleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty _
            Order By cdp.FechaModificacion Descending _
            Select New CartasConCalada With { _
             .IdCartaDePorte = cdp.IdCartaDePorte, _
             .NumeroCartaDePorte = cdp.NumeroCartaDePorte, _
             .NumeroCartaDePorteFormateada = cdp.NumeroCartaDePorte.ToString.PadLeft(12, "0").Substring(0, 4) & "-" & cdp.NumeroCartaDePorte.ToString.PadLeft(12, "0").Substring(4, 8), _
             .NumeroSubfijo = cdp.NumeroSubfijo, _
             .SubnumeroVagon = cdp.SubnumeroVagon, _
             .FechaArribo = cdp.FechaArribo, _
             .FechaModificacion = cdp.FechaModificacion, _
             .FechaDescarga = cdp.FechaDescarga, _
             .Observaciones = cdp.Observaciones, _
 _
            .NetoProc = cdp.NetoProc, _
            .NetoFinal = cdp.NetoFinal, _
            .TaraFinal = cdp.TaraFinal, _
            .BrutoFinal = cdp.BrutoFinal, _
            .Humedad = cdp.Humedad, _
            .HumedadDesnormalizada = cdp.HumedadDesnormalizada, _
            .Merma = cdp.Merma, _
 _
             .TitularDesc = clitit.RazonSocial, _
             .TitularCUIT = clitit.Cuit.Replace("-", ""), _
             .IntermediarioDesc = cliint.RazonSocial, _
             .IntermediarioCUIT = cliint.Cuit.Replace("-", ""), _
             .RComercialDesc = clircom.RazonSocial, _
             .RComercialCUIT = clircom.Cuit.Replace("-", ""), _
             .CorredorDesc = corr.Nombre, _
             .CorredorCUIT = corr.Cuit.Replace("-", ""), _
             .DestinatarioDesc = clidest.RazonSocial, _
             .DestinatarioCUIT = clidest.Cuit.Replace("-", ""), _
             .Producto = art.Descripcion, _
             .ProcedenciaDesc = proced_loc.Nombre, _
             .DestinoDesc = dest.Descripcion, _
             .CalidadDesc = "", _
             .UsuarioIngreso = "", _
 _
            .NobleExtranos = cdp.NobleExtranos, _
            .NobleNegros = cdp.NobleNegros, _
            .NobleQuebrados = cdp.NobleQuebrados, _
            .NobleDaniados = cdp.NobleDaniados, _
            .NobleChamico = cdp.NobleChamico, _
            .NobleChamico2 = cdp.NobleChamico2, _
            .NobleRevolcado = cdp.NobleRevolcado, _
            .NobleObjetables = cdp.NobleObjetables, _
            .NobleAmohosados = cdp.NobleObjetables, _
            .NobleHectolitrico = cdp.NobleObjetables, _
            .NobleCarbon = cdp.NobleObjetables, _
             .NoblePanzaBlanca = cdp.NoblePanzaBlanca, _
            .NoblePicados = cdp.NobleObjetables, _
            .NobleMGrasa = cdp.NobleObjetables, _
            .NobleAcidezGrasa = cdp.NobleObjetables, _
            .NobleVerdes = cdp.NobleObjetables, _
            .NobleGrado = cdp.NobleObjetables, _
            .NobleConforme = cdp.NobleObjetables, _
            .NobleACamara = (cdp.NobleACamara = "SI"), _
            .CalidadPuntaSombreada = cdp.CalidadPuntaSombreada, _
            .CalidadGranosQuemados = cdp.CalidadGranosQuemados, _
            .CalidadGranosQuemadosBonifRebaja = cdp.CalidadGranosQuemadosBonifica_o_Rebaja, _
            .CalidadTierra = cdp.CalidadTierra, _
            .CalidadTierraBonifRebaja = cdp.CalidadPuntaSombreada, _
            .CalidadMermaChamico = cdp.CalidadMermaChamico, _
            .CalidadMermaChamicoBonifRebaja = cdp.CalidadMermaChamicoBonifica_o_Rebaja, _
            .CalidadMermaZarandeo = cdp.CalidadMermaZarandeo, _
            .CalidadMermaZarandeoBonifRebaja = cdp.CalidadMermaZarandeoBonifica_o_Rebaja, _
 _
            .ProcedenciaLocalidadONCCA_SAGPYA = proced_loc.CodigoONCAA, _
            .ProcedenciaPartidoONCCA = proced_part.CodigoONCCA, _
 _
             .Patente = cdp.Patente, _
            .Acoplado = cdp.Acoplado, _
            .DestinoCodigoYPF = dest.CodigoYPF, _
            .TransportistaCUIT = tr.Cuit.Replace("-", ""), _
            .ChoferCUIT = chf.CUIL.Replace("-", ""), _
            .TransportistaDesc = tr.RazonSocial, _
            .ChoferDesc = chf.Nombre, _
            .EspecieONCCA = art.AuxiliarString6, _
            .Cosecha = cdp.Cosecha.Replace("/", "-20"), _
            .Establecimiento = estab.Descripcion, _
 _
            .IdFacturaImputada = If(cdp.IdFacturaImputada, -1), _
            .IdClienteAFacturarle = If(cdp.IdClienteAFacturarle, -1) _
            })

        'If False Then
        '    q = q.Skip(startRowIndex)  'el Skip no anda con SQL2000
        'End If
        'q = q.Take(maximumRows)





        '      "          LOCORI.CodigoPostal as LocalidadProcedenciaCodigoPostal, " & _
        '"          LOCDES.Codigo as LocalidadDestinoCodigoPostal, " & _
        '"          LOCORI.CodigoONCAA as LocalidadProcedenciaCodigoONCAA, " & _
        '"          LOCDES.CodigoONCAA as LocalidadDestinoCodigoONCAA, " & _
        '"          LOCORI.CodigoLosGrobo as LocalidadProcedenciaCodigoLosGrobo, " & _
        '"          LOCDES.CodigoLosGrobo as LocalidadDestinoCodigoLosGrobo, " & _
        '"         Articulos.AuxiliarString6 as  [CodigoSagypa] , " & _
        '"         Articulos.AuxiliarString7 as  [CodigoZeni] , " & _
        '"          NumeroSubfijo as SufijoCartaDePorte, " & _
        '"          Tarifa as Tarifa, " & _
        '"          CDP.IdArticulo, " & _
        '"           Calidad, " & _
        '"          Cosecha, NobleGrado,Factor, ESTAB.Descripcion as CodigoEstablecimientoProcedencia, ESTAB.AuxiliarString1 as DescripcionEstablecimientoProcedencia, " & _
        '"           CTG as CTG, CEE, FechaAnulacion,MotivoAnulacion, " & _
        '"          '' as CadenaVacia, NetoProc, EnumSyngentaDivision, IdTipoMovimiento,CobraAcarreo,LiquidaViaje,IdCartaDePorte,SubNumeroVagon,Procedencia  " & _




        Return q 'hago el tolist porque estoy en un using

    End Function




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







    Shared Function ExcelToHtml(ArchivoExcelDestino As String, Optional grid As GridView = Nothing, Optional constwidth As Long = 3000) As String

        Dim ds As DataSet = New DataSet()

        Dim err As String
        Dim firstSheetName As String
        'Dim connString As String = ConfigurationManager.ConnectionStrings("xls").ConnectionString
        ' Create the connection object
        Dim oledbConn As OleDbConnection
        Try
            'Microsoft.Jet.OLEDB.4.0 to Microsoft.ACE.OLEDB.12.0
            'oledbConn = New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + ArchivoExcelDestino + ";Extended Properties='Excel 8.0;HDR=Yes;IMEX=1';")
            oledbConn = New OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + ArchivoExcelDestino + ";Extended Properties='Excel 8.0;HDR=Yes;IMEX=1';")
            ' Open connection
            oledbConn.Open()






            '                          // Get the name of the first worksheet:
            Dim dbSchema As DataTable = oledbConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, Nothing)
            If (dbSchema Is Nothing Or dbSchema.Rows.Count < 1) Then

                Throw New Exception("Error: Could not determine the name of the first worksheet.")
            End If

            firstSheetName = dbSchema.Rows(0)("TABLE_NAME").ToString()


            ErrHandler2.WriteError("Nombre  " & firstSheetName)

            ' Create OleDbCommand object and select data from worksheet Sheet1
            Dim cmd As OleDbCommand = New OleDbCommand("SELECT * FROM [Listado general de Cartas de Po$]", oledbConn)

            ' Create new OleDbDataAdapter
            Dim oleda As OleDbDataAdapter = New OleDbDataAdapter()

            oleda.SelectCommand = cmd

            ' Create a DataSet which will hold the data extracted from the worksheet.

            ' Fill the DataSet from the data extracted from the worksheet.
            oleda.Fill(ds, "Employees")

            ' Bind the data to the GridView
            'GridView1.DataSource = ds.Tables(0).DefaultView
            'GridView1.DataBind()
        Catch e As Exception


            'http://stackoverflow.com/questions/96150/oledbconnection-open-generates-unspecified-error
            'http://stackoverflow.com/questions/472079/c-asp-net-oledb-ms-excel-read-unspecified-error
            'http://stackoverflow.com/questions/15828/reading-excel-files-from-c-sharp

            err = e.ToString


            ErrHandler2.WriteError(err)
            Throw
        Finally
            ' Close connection
            oledbConn.Close()
        End Try



        Dim s As String
        Try
            If ds.Tables.Count = 0 Then Return "NoSeConvirtieronTablas" & "_" & firstSheetName & "_" & ArchivoExcelDestino & "_" & err
            ErrHandler2.WriteError("Tablas  " & ds.Tables.Count.ToString())
            ErrHandler2.WriteError("Convertido " + ArchivoExcelDestino + " Lineas: " + ds.Tables(0).Rows.Count.ToString())
            s = DatatableToHtmlUsandoGridview(ds.Tables(0), grid, constwidth)
            's = DatatableToHtml(ds.Tables(0))

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            Return "ErrorHtml" + ex.ToString + "          " + ArchivoExcelDestino + " Lineas: " + ds.Tables(0).Rows.Count.ToString()
        End Try


        Return s
    End Function


    Shared Function DatatableToHtmlUsandoGridview(dt As DataTable, Optional gridView As GridView = Nothing, Optional constwidth As Long = 3000) As String
        'http://stackoverflow.com/questions/1018785/asp-net-shortest-way-to-render-datatable-to-a-string-html
        'http://stackoverflow.com/questions/8908363/exporting-gridview-to-xls-paging-issue



        Const maxrows = 400
        'Const constwidth = 3000
        Const fontsize = 6
        Const padding = 2





        dt.Rows.RemoveAt(3)
        dt.Rows.RemoveAt(2)
        dt.Rows.RemoveAt(1)
        dt.Rows.RemoveAt(0)
        dt.Columns.RemoveAt(0)



        dt.Rows.RemoveAt(dt.Rows.Count - 1)



        If gridView Is Nothing Or True Then
            gridView = New GridView()

            gridView.AutoGenerateColumns = False



            gridView.Font.Size = fontsize

            Dim bf1 = New BoundField()
            bf1.DataField = "F2"
            bf1.HeaderText = "Date"
            bf1.ItemStyle.VerticalAlign = VerticalAlign.Middle
            bf1.ItemStyle.HorizontalAlign = HorizontalAlign.Center
            bf1.ItemStyle.Font.Bold = True
            bf1.ItemStyle.ForeColor = System.Drawing.Color.Blue

            '  bf1.ItemStyle.BackColor = System.Drawing.Color.LightBlue 'System.Drawing.ColorTranslator.FromHtml("#EAEAEA")
            '.AlternatingRowStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#EAEAEA")
            gridView.Columns.Add(bf1)



            'http://forums.asp.net/t/1086879.aspx

            Dim comienzo As Integer
            If iisNull(dt.Rows(0).Item(2)) = "Imágenes" Or iisNull(dt.Rows(1).Item(2)) = "Imágenes" Then
                Dim bf12 = New HyperLinkField()
                bf12.DataNavigateUrlFields = New String() {"F3"}
                bf12.DataTextField = "F4"
                'bf12.DataNavigateUrlFormatString = "userProfile.aspx?ID={0}"
                'bf12.HeaderText = "User Name"
                bf12.ItemStyle.VerticalAlign = VerticalAlign.Middle
                bf12.ItemStyle.HorizontalAlign = HorizontalAlign.Center
                'bf12.ItemStyle.Font.Bold = True
                '.AlternatingRowStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#EAEAEA")
                gridView.Columns.Add(bf12)

                comienzo = 5
            Else
                comienzo = 3
            End If




            Dim cols As Integer() = {10, 11, 12, 16, 17, 18, 19, 20}

            For n = comienzo To dt.Columns.Count

                Dim bf2 = New BoundField()
                bf2.DataField = "F" + n.ToString
                bf2.HeaderText = "Description"
                bf2.ItemStyle.VerticalAlign = VerticalAlign.Middle
                bf2.ItemStyle.HorizontalAlign = HorizontalAlign.Center


                'If cols.Contains(n) Then bf2.ItemStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#eef6fd")

                gridView.Columns.Add(bf2)
            Next


        End If
        Dim result = New StringBuilder()
        Dim writer = New StringWriter(result)
        Dim htmlWriter = New System.Web.UI.HtmlTextWriter(writer)

        gridView.Width = constwidth

        'gridView.PageSize = 100
        'gridView.AllowPaging = True

        For n = maxrows To dt.Rows.Count - 1
            Try
                dt.Rows.RemoveAt(n)
            Catch ex As Exception
                ErrHandler2.WriteError("error html row " & n.ToString)
                'Exit For
            End Try
        Next

        gridView.DataSource = dt
        gridView.DataBind()

        If True Then
            'Hay un tema con el Wrap: si lo uso, con el Gmail lo formatea bien, pero a Andy en el Outlook se le angostan muchisimo las columnas
            gridView.HeaderStyle.Wrap = False
            gridView.RowStyle.Wrap = False
            gridView.FooterStyle.Wrap = False
        End If

        'gridView.Columns(0).Visible = False

        gridView.HeaderRow.Visible = False
        gridView.FooterRow.Visible = False
        'gridView.Rows(0).Style.
        gridView.ShowHeader = False
        gridView.AlternatingRowStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#e4effd") 'System.Drawing.ColorTranslator.FromHtml("#EAEAEA")




        gridView.CellPadding = padding
        gridView.GridLines = GridLines.Both
        'gridView.BorderColor = System.Drawing.ColorTranslator.FromHtml("#e5e5e5")
        gridView.BorderColor = System.Drawing.Color.LightGray

        'http://stackoverflow.com/questions/11974039/gridview-column-headers-autowrap-how-to-prevent
        'http://stackoverflow.com/questions/782428/asp-net-gridview-prevent-word-wrapping-in-column
        Dim classcss = "        .myGrid th             {              white-space: nowrap !important;      }     "

        '<ItemStyle Wrap="False" />

        For ii As Integer = 0 To gridView.Rows.Count - 1
            'gridView.Rows(i).Attributes.Add("style", "white-space: nowrap;")

            gridView.Rows(ii).Attributes.Add("style", "white-space: nowrap !important;")

            'word-break:keep-all; word-wrap:normal;table-layout: fixed;


            ' gridView.Rows(i).Attributes.Add("class", "textmode")
        Next

        '   for (int i = 0; i < e.Row.Cells.Count; i++)
        '{
        '    e.Row.Cells[i].Attributes.Add("style", "white-space: nowrap;");
        '}

        '          Since auto generated column is built-in and difficult to change its style, you have two choices:

        '1. Set your GridView's width wide enough.

        '2. Use ItemTemplate  instead, it's more flexible.
        'If you still have this problem, please inform us.

        'gridView.HeaderStyle.Width = "10%"
        'gridView.RowStyle.Width = "10%"
        'gridView.FooterStyle.Width = "10%"

        gridView.HorizontalAlign = HorizontalAlign.Center

        'http://stackoverflow.com/questions/55828/how-does-one-parse-xml-files

        gridView.RenderControl(htmlWriter)


        'http://stackoverflow.com/questions/15970660/html-email-in-outlook-table-width-issue
        'http://stackoverflow.com/questions/9304920/html-email-tables-broken-in-outlook-2007-2010

        'http://putsmail.com/tests/15a674822a291db54828a92a63fdf6


        Dim outlook As String
        outlook = result.ToString
        If dt.Rows.Count > maxrows Then outlook = "Sólo se muestran las primeras " + maxrows.ToString + " líneas de un total de " + dt.Rows.Count.ToString + "<br/><br/>" + outlook

        's = "<div style=""overflow-x:scroll; width: 20000px"">mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmholaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaquuuuuuuuuuuuuuueeeeeeeeeeeeeeeeeeeeetallllllllllllllllllllllllllllllllllllllllllllllllllllllltevaaaaaaaaaaaaaaaaaaaaaaa" + s + "</div>"
        'jugar con constwidth. Cuando me queda bien en Outlook, se me caga en Gmail. Buscar equilibrio, o quizas mandar los dos formatos.

        Dim gmail = outlook

        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////

        'outlook = "Formato Outlook" + outlook
        outlook = outlook.Replace("table ", "table width=""" + (constwidth * 30).ToString + """  ") 'problemas para que outlook no me haga angostas las columnas 
        'outlook = outlook.Replace("<td ", "<td  width=""" + constwidth.ToString + """  style=""width:" + constwidth.ToString + "   px;mso-line-height-rule: exactly;line-height:; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; padding: 2""  ")
        'outlook = outlook.Replace("style=""border-color:#E5E5E5", "style=""border-color:#E5E5E5;	line-height: ;")
        'The path I used was Tools>Options>Mail Format>Editor Options>Advanced



        'outlook = "<!--[if mso]><v:shape>" & outlook & "</v:shape><![endif]-->"

        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////

        gmail = "Formato Gmail" + gmail
        gmail = gmail.Replace("table ", "table width=""" + constwidth.ToString + """  ") 'problemas para que outlook no me haga angostas las columnas 


        gmail = "<!--[if !mso]><!-->" & gmail & "<!--<![endif]-->" 'http://stackoverflow.com/a/5983063/1054200

        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////

        'http://stackoverflow.com/questions/18254711/html-emails-fallback-for-mso-conditional
        'http://stackoverflow.com/questions/5982364/is-there-a-html-conditional-statement-for-everything-not-outlook

        'Return "<br/><br/>" + gmail + "<br/><br/>" + outlook



        Return outlook
        'Console.WriteLine(result)
    End Function


    Shared Function generarNotasDeEntregaConReportViewer_ConServidorDeInformes(ByVal SC As String, ByVal fechadesde As Date, _
                                                         ByVal fechahasta As Date, ByVal dr As DataRow, _
                                                         ByVal estado As CartaDePorteManager.enumCDPestado, _
                                                         ByRef lineasGeneradas As Long, ByRef titulo As String, _
                                                         ByVal logo As String, ByVal puntoventa As Integer, _
                                                         Optional ByRef tiemposql As Integer = 0, _
                                                         Optional ByRef tiempoinforme As Integer = 0, _
                                                         Optional ByVal bDescargaHtml As Boolean = False, _
                                                         Optional grid As GridView = Nothing) As String


        Dim sExcelFileName As String

        Dim stopWatch As New Stopwatch()

        Dim rdl As String

        Dim strRet As String


        Dim strSQL As String

        Dim ReportViewerEscondido As Microsoft.Reporting.WebForms.ReportViewer   'con WebForms

        'Using ReportViewerEscondido As New Microsoft.Reporting.WebForms.ReportViewer
        Try




            '/////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////


            ' la llamada a wCartasDePorte_TX_Todas con DescargasDeHoyMasTodasLasPosiciones es
            ' ineficiente, porque no filtra por fecha. Esta ineficiencia se la banca el mail manual, pero
            ' el automático explota. -Ok, pero con las Posiciones tambien deberias
            ' tener problemas..., puesto que tampoco filtra por fecha. Necesito DE UNA BUENA VEZ, un 
            ' datasource de las cartas de porte pero YA FILTRADAS EN SQL


            With dr
                Dim idVendedor As Long = iisNull(.Item("Vendedor"), -1)
                Dim idCorredor As Long = iisNull(.Item("Corredor"), -1)
                Dim idDestinatario As Long = iisNull(.Item("Entregador"), -1)
                Dim idIntermediario As Long = iisNull(.Item("CuentaOrden1"), -1)
                Dim idRemComercial As Long = iisNull(.Item("CuentaOrden2"), -1)
                Dim IdClienteAuxiliar As Long = iisNull(.Item("IdClienteAuxiliar"), -1)
                Dim idArticulo As Long = iisNull(.Item("IdArticulo"), -1)
                Dim idProcedencia As Long = iisNull(.Item("Procedencia"), -1)
                Dim idDestino As Long = iisNull(.Item("Destino"), -1)

                Dim contrato As String = iisNull(.Item("Contrato"), "")

                Dim EnumSyngentaDivision As String = iisNull(.Item("EnumSyngentaDivision"), "")

                Dim AgrupadorDeTandaPeriodos As String = iisNull(.Item("AgrupadorDeTandaPeriodos"), -1)




                ' bDescargaHtml = (iisNull(.Item("ModoImpresion"), "Excel") = "Html" Or iisNull(.Item("ModoImpresion"), "Excel") = "HtmlIm")

                'antes se filtraba con generarWHEREparaDataset




                ' Get the elapsed time as a TimeSpan value.
                'Dim ts As TimeSpan = stopWatch.Elapsed

                stopWatch.Start()


                'usar agrupador de fechas para marcar los filtros que usen el mismo periodo

                'cómo puede ser que este dt traiga informacion repetida
                'https://mail.google.com/mail/u/0/#inbox/13f5c9dc24580285




                'ya te digo si saben. deberiamos poner alguna marca en los mails aunque no se vea 
                '(quizas en blanco en una celda perdida) para control nuestro




                Dim count = CartaDePorteManager.GetDataTableFiltradoYPaginado_CadenaSQL(SC, _
                              "", "", "", 1, 10000, _
                              estado, "", idVendedor, idCorredor, _
                              idDestinatario, idIntermediario, _
                              idRemComercial, idArticulo, idProcedencia, idDestino, _
                              iisNull(dr.Item("AplicarANDuORalFiltro"), 0), iisNull(dr.Item("modo")), _
                              iisValidSqlDate(fechadesde, #1/1/1753#), _
                             iisValidSqlDate(fechahasta, #1/1/2100#), _
                              puntoventa, titulo, EnumSyngentaDivision, , contrato, , IdClienteAuxiliar, AgrupadorDeTandaPeriodos, , , , , True)

                Dim dt = EntidadManager.ExecDinamico(SC, count)
                lineasGeneradas = dt.Rows(0).Item(0)
                If lineasGeneradas = 0 Then Return -1



                strSQL = CartaDePorteManager.GetDataTableFiltradoYPaginado_CadenaSQL(SC, _
                               "", "", "", 1, 10000, _
                               estado, "", idVendedor, idCorredor, _
                               idDestinatario, idIntermediario, _
                               idRemComercial, idArticulo, idProcedencia, idDestino, _
                               iisNull(dr.Item("AplicarANDuORalFiltro"), 0), iisNull(dr.Item("modo")), _
                               iisValidSqlDate(fechadesde, #1/1/1753#), _
                              iisValidSqlDate(fechahasta, #1/1/2100#), _
                               puntoventa, titulo, EnumSyngentaDivision, , contrato, , IdClienteAuxiliar, AgrupadorDeTandaPeriodos)




                stopWatch.Stop()
                tiemposql = stopWatch.Elapsed.Milliseconds






                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                'tengo que diferenciar si se le envía a un corredor, para mandarle los links o no. Pero no tengo otra manera
                'de diferenciarlo que viendo los filtros...
                'Dim IdClienteEquivalenteAlCorredor = BuscaIdVendedorPreciso(EntidadManager.NombreVendedor(SC, drCDP("Corredor")), SC)
                'If IdClienteEquivalenteAlCorredor < 1 Then Return 0

                rdl = QueInforme(SC, dr)


                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            End With

            'If estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones Then
            '    dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_DescargasDeHoyMasTodasLasPosiciones", Today)
            'ElseIf estado = CartaDePorteManager.enumCDPestado.Posicion Then
            '    dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_Posiciones", iisValidSqlDate(fechadesde, #1/1/1753#), iisValidSqlDate(fechahasta, #1/1/2100#))
            'Else
            '    dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_Todas", -1, iisValidSqlDate(fechadesde, #1/1/1753#), iisValidSqlDate(fechahasta, #1/1/2100#))
            'End If


            ' dejar de usar el strWHERE que recibo, y usar un datasource fijo

            'dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(SC, _
            '                CartaDePorteManager.enumCDPestado.Todas, "", idVendedor, idCorredor, _
            '                idDestinatario, idIntermediario, _
            '                idRComercial, idArticulo, idProcedencia, idDestino, _
            '                "1", DropDownList2.Text, _
            '                Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
            '                Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
            '                cmbPuntoVenta.SelectedValue)



            'Dim sWHERE As String = CDPMailFiltrosManager.generarWHEREparaDatasetParametrizado(HFSC.Value, _
            '                sTitulo, _
            '                CartaDePorteManager.enumCDPestado.Todas, "", idVendedor, idCorredor, _
            '                idDestinatario, idIntermediario, _
            '                idRComercial, idArticulo, idProcedencia, idDestino, _
            '                "1", DropDownList2.Text, _
            '                Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
            '                Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
            '                cmbPuntoVenta.SelectedValue)






            'strWHERE += CartaDePorteManager.EstadoWHERE(estado, "CDP.")
            'strWHERE = strWHERE.Replace("CDP.", "")
            'dt = DataTableWHERE(dt, strWHERE)


            '/////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////


            Try

                sExcelFileName = Path.GetTempPath & "Listado general " & Now.ToString("ddMMMyyyy_HHmmss") & GenerarSufijoRand() & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net


                'lineasGeneradas = 0 ' dt.Rows.Count



                'If System.Diagnostics.Debugger.IsAttached() And dt.Rows.Count > 50000 Then
                '    'Err.Raise(32434, "generarNotasDeEntrega", "Modo IDE. Mail muy grande. No se enviará")
                '    Return -2 'si estoy en modo IDE, no mandar mail grande
                'End If




                Dim logtexto As String = "" ' = Date.Now.ToString() + " cant cdps " + dt.Rows.Count.ToString + " " + _
                'idfiltro: " + dr.Item(0).ToString + " " + _
                ' titulo(+" " + Space(300))



                'EntidadManager.Tarea(SC, "Log_InsertarRegistro", "ALTAINF", _
                '                  dr.Item(0), 0, Now, 0, Mid(logtexto, 1, 100), _
                '               Mid(logtexto, 101, 50), Mid(logtexto, 151, 50), Mid(logtexto, 201, 50), _
                '               Mid(logtexto, 251, 50), Mid(logtexto, 301, 50), DBNull.Value, DBNull.Value, _
                '                DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, _
                '                99990, DBNull.Value, DBNull.Value)



                ' LogPronto(SC, dr.Item(0), Mid(logtexto), , , , "logMails")

            Catch ex As Exception
                ErrHandler2WriteErrorLogPronto("no se pudo hacer log del informe", SC, "")
            End Try


            Dim bServidor = False



            ReportViewerEscondido = New Microsoft.Reporting.WebForms.ReportViewer




            If False Then
                strRet = RebindReportViewer_ServidorExcel(ReportViewerEscondido, _
                            rdl, _
                              strSQL, SC, True, sExcelFileName, titulo, bDescargaHtml)
            Else

                Dim yourParams As ReportParameter() = New ReportParameter(9) {}

                yourParams(0) = New ReportParameter("webservice", "")
                yourParams(1) = New ReportParameter("sServidor", ConfigurationManager.AppSettings("UrlDominio"))
                yourParams(2) = New ReportParameter("idArticulo", -1)
                yourParams(3) = New ReportParameter("idDestino", -1)
                yourParams(4) = New ReportParameter("desde", New DateTime(2012, 11, 1)) ' txtFechaDesde.Text)
                yourParams(5) = New ReportParameter("hasta", New DateTime(2012, 11, 1)) ', txtFechaHasta.Text)
                yourParams(6) = New ReportParameter("quecontenga", "ghkgk")
                yourParams(7) = New ReportParameter("Consulta", strSQL)
                yourParams(8) = New ReportParameter("sServidorSQL", Encriptar(SC))
                yourParams(9) = New ReportParameter("titulo", titulo)



                strRet = RebindReportViewer_ServidorExcel(ReportViewerEscondido, _
                            rdl, yourParams, sExcelFileName, bDescargaHtml)


            End If








            stopWatch.Stop()
            tiempoinforme = stopWatch.Elapsed.Milliseconds
            '  Return sExcelFileName



        Catch ex As Exception
            ErrHandler2.WriteError(ex)

        End Try


        'Return -1
        'End Using



        Return sExcelFileName

        Return -1

    End Function










    Public Shared informesHtml As String() = New String() {"Html", "HtmlIm", "EHOlav", "HOlav", "HImag2"}

    Enum eInformesGeneralFormatos
        Html
        HtmlIm
        EHOlav 'olavarria html + excel
        HOlav 'olavarria html
        HImag2 'html corto con imagenes
        '<asp:ListItem Value="Excel" Text="Excel" />
        '<asp:ListItem Value="Imagen" Text="Excel con imágenes " />
        '<asp:ListItem Value="ExcRec" Text="Excel con n°recibo" />
        '<asp:ListItem Value="Grobo" Text="Excel Grobo" />
        '<asp:ListItem Value="ExcHtm" Text="Excel y Html" Enabled="false" />
        '<asp:ListItem Value="Html" Text="Html"  Enabled="false"  />
        '<asp:ListItem Value="HtmlIm" Text="Html con imágenes " />
        '<asp:ListItem Value="EHOlav" Text="Html corto" />

    End Enum

    'Enum FormatosInforme
    '    Html
    '    HtmlIm
    '    ExcRec
    '    Grobo
    'End Enum




    Shared Function QueInforme(SC As String, dr As DataRow) As String


        Dim rdl As String
        With dr
            Dim idVendedor As Long = iisNull(.Item("Vendedor"), -1)
            Dim idCorredor As Long = iisNull(.Item("Corredor"), -1)
            Dim idDestinatario As Long = iisNull(.Item("Entregador"), -1)
            Dim idIntermediario As Long = iisNull(.Item("CuentaOrden1"), -1)
            Dim idRemComercial As Long = iisNull(.Item("CuentaOrden2"), -1)
            Dim IdClienteAuxiliar As Long = iisNull(.Item("IdClienteAuxiliar"), -1)
            Dim idArticulo As Long = iisNull(.Item("IdArticulo"), -1)
            Dim idProcedencia As Long = iisNull(.Item("Procedencia"), -1)
            Dim idDestino As Long = iisNull(.Item("Destino"), -1)


            If iisNull(.Item("ModoImpresion"), "") = "HtmlIm" Then
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto para html.rdl"


            ElseIf NombreCliente(SC, idVendedor) = "DOW AGROSCIENCES ARG. SA" _
                    Or NombreCliente(SC, idRemComercial) = "DOW AGROSCIENCES ARG. SA" _
                    Or NombreCliente(SC, idIntermediario) = "DOW AGROSCIENCES ARG. SA" _
                    Or NombreCliente(SC, idDestinatario) = "DOW AGROSCIENCES ARG. SA" _
                        Then
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11373
                rdl = "Listado general de Cartas de Porte (simulando original) con foto  - Dow.rdl"
                'hay que mandarle el informe extendido

            ElseIf idCorredor > 0 AndAlso NombreVendedor(SC, idCorredor) <> "BLD S.A" AndAlso Not iisNull(.Item("ModoImpresion"), "") = "Imagen" AndAlso Not iisNull(.Item("ModoImpresion"), "") = "HtmlIm" Then
                'formato para corredores (menos BLD)
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original)  para Corredores.rdl"

            ElseIf NombreCliente(SC, idVendedor) = "CRESUD SACIF Y A" Or NombreCliente(SC, idRemComercial) = "CRESUD SACIF Y A" Then
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11373
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto  - Cresud.rdl"
            ElseIf NombreCliente(SC, IdClienteAuxiliar) = "MULTIGRAIN ARGENTINA S.A." Or NombreCliente(SC, idVendedor) = "MULTIGRAIN ARGENTINA S.A." Or NombreCliente(SC, idRemComercial) = "MULTIGRAIN ARGENTINA S.A." Or NombreCliente(SC, idDestinatario) = "MULTIGRAIN ARGENTINA S.A." Or NombreCliente(SC, idIntermediario) = "MULTIGRAIN ARGENTINA S.A." Then
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11373
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto  - Multigrain.rdl"

            ElseIf iisNull(.Item("ModoImpresion"), "") = "Html" Then
                'este era el tradicional
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl"
            ElseIf iisNull(.Item("ModoImpresion"), "") = "Excel" Then
                'este era el tradicional
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl"
            ElseIf iisNull(.Item("ModoImpresion"), "") = "ExcelIm" Then
                'formato normal para clientes (incluye la foto)
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto .rdl"

            ElseIf iisNull(.Item("ModoImpresion"), "") = "ExcHtm" Then
                'este es de servidor, así que saco el path
                rdl = "Listado general de Cartas de Porte (simulando original) con foto 2"

            ElseIf iisNull(.Item("ModoImpresion"), "") = "EHOlav" Then
                rdl = "Listado general de Cartas de Porte (simulando original) Olavarria"

            ElseIf iisNull(.Item("ModoImpresion"), "") = "HImag2" Then
                rdl = "Listado general de Cartas de Porte (simulando original) para html con imagenes"


            Else
                'formato normal para clientes (incluye la foto)
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto .rdl"
            End If

        End With

        Return rdl
    End Function





    Shared Function PlantillaDeInforme(SC As String, ByRef rdl As String, idVendedor As Long, idRemComercial As Long, idIntermediario As Long, idCorredor As Long, idDestinatario As Long, IdClienteAuxiliar As Long, ByVal fechadesde As Date, _
                                                         ByVal fechahasta As Date, ByVal dr As DataRow, _
                                                         ByVal estado As CartaDePorteManager.enumCDPestado, _
                                                         ByRef lineasGeneradas As Long, ByRef titulo As String, _
                                                         ByVal logo As String, ByVal puntoventa As Integer, _
                                                          ByRef tiemposql As Integer, _
                                                          ByRef tiempoinforme As Integer, _
                                                          ByVal bDescargaHtml As Boolean, _
                                                          grid As GridView) As String

        PlantillaDeInforme = ""

        With dr

            If iisNull(.Item("ModoImpresion"), "") = "HtmlIm" Then
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto para html.rdl"

            ElseIf iisNull(.Item("ModoImpresion"), "") = "ExcRec" Then
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto con numero recibo.rdl"

            ElseIf iisNull(.Item("ModoImpresion"), "") = "Grobo" Then
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto  - Grobo.rdl"


            ElseIf idCorredor > 0 AndAlso NombreVendedor(SC, idCorredor) <> "BLD S.A" AndAlso Not iisNull(.Item("ModoImpresion"), "") = "Imagen" AndAlso Not iisNull(.Item("ModoImpresion"), "") = "HtmlIm" Then
                'formato para corredores (menos BLD)
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original)  para Corredores.rdl"



            ElseIf NombreCliente(SC, idVendedor) = "DOW AGROSCIENCES ARG. SA" _
                    Or NombreCliente(SC, idRemComercial) = "DOW AGROSCIENCES ARG. SA" _
                    Or NombreCliente(SC, idIntermediario) = "DOW AGROSCIENCES ARG. SA" _
                    Or NombreCliente(SC, idDestinatario) = "DOW AGROSCIENCES ARG. SA" _
                        Then

                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11373
                rdl = "Listado general de Cartas de Porte (simulando original) con foto  - Dow"
                'hay que mandarle el informe extendido
                If True Then
                    Return CartaDePorteManager.generarNotasDeEntregaConReportViewer_ConServidorDeInformes(SC, fechadesde, fechahasta, dr, estado, lineasGeneradas, titulo, logo, puntoventa, tiemposql, tiempoinforme, bDescargaHtml, grid)
                Else

                End If


            ElseIf NombreCliente(SC, idVendedor) = "CRESUD SACIF Y A" Or NombreCliente(SC, idRemComercial) = "CRESUD SACIF Y A" Then
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11373
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto  - Cresud.rdl"
            ElseIf NombreCliente(SC, IdClienteAuxiliar) = "MULTIGRAIN ARGENTINA S.A." Or NombreCliente(SC, idVendedor) = "MULTIGRAIN ARGENTINA S.A." Or NombreCliente(SC, idRemComercial) = "MULTIGRAIN ARGENTINA S.A." Or NombreCliente(SC, idDestinatario) = "MULTIGRAIN ARGENTINA S.A." Or NombreCliente(SC, idIntermediario) = "MULTIGRAIN ARGENTINA S.A." Then
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11373
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto  - Multigrain.rdl"

            ElseIf iisNull(.Item("ModoImpresion"), "") = "Html" Then
                'este era el tradicional
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl"
            ElseIf iisNull(.Item("ModoImpresion"), "") = "Excel" Then
                'este era el tradicional
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl"
            ElseIf iisNull(.Item("ModoImpresion"), "") = "ExcelIm" Then
                'formato normal para clientes (incluye la foto)
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto .rdl"


                If False Then
                    Return CartaDePorteManager.generarNotasDeEntregaConReportViewer_ConServidorDeInformes(SC, fechadesde, fechahasta, dr, estado, lineasGeneradas, titulo, logo, puntoventa, tiemposql, tiempoinforme, bDescargaHtml, grid)
                End If


            Else
                'formato normal para clientes (incluye la foto)
                rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto .rdl"

                If False Then
                    Return CartaDePorteManager.generarNotasDeEntregaConReportViewer_ConServidorDeInformes(SC, fechadesde, fechahasta, dr, estado, lineasGeneradas, titulo, logo, puntoventa, tiemposql, tiempoinforme, bDescargaHtml, grid)
                End If

            End If


        End With


        Return ""
    End Function









    Public Shared Function GenerarSufijoRand() As String
        Randomize()
        Dim cadena = "_" & Chr(Rnd() * 25 + 97) & Chr(Rnd() * 25 + 97) & Chr(Rnd() * 25 + 97)

        Return cadena.ToUpper
    End Function






    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////'//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Public Shared Function RebindReportViewerLINQ_Excel(ByRef oReportViewer As Microsoft.Reporting.WebForms.ReportViewer, ByVal rdlFile As String, ByVal q As Object, Optional ByRef ArchivoExcelDestino As String = "", Optional parametros As IEnumerable(Of ReportParameter) = Nothing) As String


        If ArchivoExcelDestino = "" Then
            ArchivoExcelDestino = Path.GetTempPath & "Informe " & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        End If

        'Dim vFileName As String = "c:\archivo.txt"
        ' FileOpen(1, ArchivoExcelDestino, OpenMode.Output)


        'http://forums.asp.net/t/1183208.aspx

        With oReportViewer
            .ProcessingMode = ProcessingMode.Local
            .Visible = True

            .Reset()


            With .LocalReport
                .ReportPath = rdlFile
                .EnableHyperlinks = True

                .DataSources.Clear()

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", q)) '//the first parameter is the name of the datasource which you bind your report table to.

                '.ReportEmbeddedResource = rdlFile


                .EnableExternalImages = True


                '.DataSources.Add(New ReportDataSource("http://www.google.com/intl/en_ALL/images/logo.gif", "Image1"))
                'DataSource.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";
                '.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";



                '/////////////////////
                'parametros (no uses la @ delante del parametro!!!!)
                '/////////////////////
                Try
                    If parametros IsNot Nothing Then
                        .SetParameters(parametros)
                    End If
                    '    If .GetParameters.Count > 1 Then
                    '        If .GetParameters.Item(1).Name = "FechaDesde" Then
                    '            Dim p1 = New ReportParameter("IdCartaDePorte", -1)
                    '            Dim p2 = New ReportParameter("FechaDesde", Today)
                    '            Dim p3 = New ReportParameter("FechaHasta", Today)
                    '            .SetParameters(New ReportParameter() {p1, p2, p3})
                    '        End If
                    '    End If
                Catch ex As Exception
                    ErrHandler2.WriteError(ex.ToString)
                End Try
                '/////////////////////
                '/////////////////////
                '/////////////////////
                '/////////////////////

            End With


            .DocumentMapCollapsed = True



            '.LocalReport.Refresh()
            '.DataBind()




            'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType, encoding, extension As String

            Dim bytes As Byte()



            Try
                bytes = oReportViewer.LocalReport.Render( _
                       "Excel", Nothing, mimeType, encoding, _
                         extension, _
                        streamids, warnings)

            Catch e As System.Exception
                Dim inner As Exception = e.InnerException
                While Not (inner Is Nothing)

                    If System.Diagnostics.Debugger.IsAttached() Then
                        MsgBox(inner.Message)
                    End If

                    ErrHandler2.WriteError(inner.Message)
                    inner = inner.InnerException
                End While
                Throw
            End Try


            Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
            fs.Write(bytes, 0, bytes.Length)
            fs.Close()



        End With

        Return ArchivoExcelDestino
    End Function






    Public Shared Function RebindReportViewer_ServidorExcel(ByRef oReportViewer As Microsoft.Reporting.WebForms.ReportViewer, _
                                                                ByVal rdlFile As String, parametros As IEnumerable(Of ReportParameter),
                                    ByRef ArchivoExcelDestino As String, bDescargaHtml As Boolean) As String


        'errores
        '   rsCredentialsNotSpecified     porque el datasource TestHarcodeada tiene las credenciales no configuradas para windows integrated
        '   rsProcessingAborted           porque la cuenta que corre el repservice no tiene permisos: 
        '                                         GRANT  Execute on [dbo].your_object to [public]
        '                                         REVOKE Execute on [dbo].your_object to [public]
        '                                         grant execute on wCar...  to [NT AUTHORITY\NETWORK SERVICE]
        '                                         grant execute on wCar...  to [NT AUTHORITY\ANONYMOUS LOGON]
        '                                         grant execute on wCart... to public


        For Each i In parametros
            If i Is Nothing Then
                Throw New Exception("Te falta por lo menos un parametro. Recordá que el array que pasás se dimensiona con un elemento de más")
            End If
        Next


        With oReportViewer
            .Reset()
            .ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote
            .Visible = False



            'ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
            .ServerReport.ReportServerUrl = New Uri(ConfigurationManager.AppSettings("ReportServer"))
            .ProcessingMode = ProcessingMode.Remote
            ' IReportServerCredentials irsc = new CustomReportCredentials("administrador", ".xza2190lkm.", "");
            Dim irsc As IReportServerCredentials = New CustomReportCredentials(ConfigurationManager.AppSettings("ReportUser"), ConfigurationManager.AppSettings("ReportPass"), ConfigurationManager.AppSettings("ReportDomain"))
            .ServerReport.ReportServerCredentials = irsc
            .ShowCredentialPrompts = False




            'rdlFile = "/Pronto informes/" + "Resumen Cuenta Corriente Acreedores"
            'Dim reportName = "Listado general de Cartas de Porte (simulando original) con foto Buscador sin Webservice"
            If rdlFile = "" Then

            End If
            rdlFile = rdlFile.Replace(".rdl", "")
            rdlFile = "/Pronto informes/" & rdlFile



            With .ServerReport
                .ReportPath = rdlFile






                Try

                    oReportViewer.ServerReport.SetParameters(parametros)


                Catch ex As Exception
                    ErrHandler2.WriteError(ex.ToString)
                    Dim inner As Exception = ex.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            MsgBox(inner.Message)
                            Stop
                        End If
                        ErrHandler2.WriteError("Error al buscar los parametros.  " & inner.Message)
                        inner = inner.InnerException
                    End While
                End Try

                '/////////////////////
                '/////////////////////
                '/////////////////////
                '/////////////////////

            End With


            .DocumentMapCollapsed = True



            '/////////////////////
            '/////////////////////

            .Visible = False

            'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType, encoding, extension As String
            Dim bytes As Byte()

            'http://pareshjagatia.blogspot.com.ar/2008/05/export-reportviewer-report-to-pdf-excel.html
            '             string mimeType;
            '2 string encoding;
            '3 Warning[] warnings;
            '4 string[] streamids;
            '5 string fileNameExtension;
            '6 byte[] htmlBytes = MyReportViewer.ServerReport.Render("HTML4.0", null, out mimeType, out encoding, out fileNameExtension, out streamids, out warnings);
            '7 string reportHtml = System.Text.Encoding.UTF8.GetString(htmlBytes);
            '8 return reportHtml;


            .Visible = False

            Try
                If bDescargaHtml And False Then

                    'por ahora usar ExcelToHtml(strRet, grid)

                    bytes = .ServerReport.Render( _
                            "HTML4.0", Nothing, mimeType, encoding, _
                              extension, _
                             streamids, warnings)

                Else


                    bytes = .ServerReport.Render( _
                          "Excel", Nothing, mimeType, encoding, _
                            extension, _
                           streamids, warnings)
                End If

            Catch e As System.Exception
                Dim inner As Exception = e.InnerException
                While Not (inner Is Nothing)
                    If System.Diagnostics.Debugger.IsAttached() Then
                        'MsgBox(inner.Message)
                        'Stop
                    End If
                    ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message)
                    inner = inner.InnerException
                End While
                Throw
            End Try


            ErrHandler2.WriteError("Por generar el archivo " + ArchivoExcelDestino)
            Try
                Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()

            Catch ex As Exception

                ErrHandler2.WriteAndRaiseError(ex)
            End Try




            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ErrHandler2.WriteError("Archivo generado " + ArchivoExcelDestino)








            Return ArchivoExcelDestino




            'Dim ArchivoCSVDestino = ExcelToCSV(ArchivoExcelDestino)
            ''ExcelToCSV_SincroBLD

            'Return ArchivoCSVDestino






        End With

        '////////////////////////////////////////////

        'este me salvo! http://social.msdn.microsoft.com/Forums/en-US/winformsdatacontrols/thread/bd60c434-f61a-4252-a7f9-1606fdca6b41

        'http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/505ffb1c-324e-4623-9cce-d84662d92b1a

    End Function

    Public Shared Function RebindReportViewer_ServidorExcel(ByRef oReportViewer As Microsoft.Reporting.WebForms.ReportViewer, _
                                                                ByVal rdlFile As String, strSQL As String, SC As String, _
                                     Optional ByVal bDescargaExcel As Boolean = False, _
                                    Optional ByRef ArchivoExcelDestino As String = "", Optional ByVal titulo As String = "", _
                                    Optional ByVal bDescargaHtml As Boolean = False) As String
        'http://forums.asp.net/t/1183208.aspx




        'no es suficiente con poner permisos al usuario en el server\reports\ "Configuracion de sitio", tambien hay que ponerlo en cada carpeta




        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        'http://stackoverflow.com/questions/12199995/programmatically-exporting-reports-from-sql-2012-reporting-services
        'cómo usar ReportExecutionService ?
        Dim rsExec As ReportingService.ReportingService2010Soap
        Dim rs As ReportExecutionService.ReportExecutionServiceSoap
        'reporte ReportExecution2005.ReportExecutionService = New ReportExecution2005.ReportExecutionService()
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ' REVISAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!




        With oReportViewer
            .Reset()
            .ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote
            .Visible = False



            'ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
            .ServerReport.ReportServerUrl = New Uri(ConfigurationManager.AppSettings("ReportServer"))
            .ProcessingMode = ProcessingMode.Remote
            ' IReportServerCredentials irsc = new CustomReportCredentials("administrador", ".xza2190lkm.", "");
            Dim irsc As IReportServerCredentials = New CustomReportCredentials(ConfigurationManager.AppSettings("ReportUser"), ConfigurationManager.AppSettings("ReportPass"), ConfigurationManager.AppSettings("ReportDomain"))
            .ServerReport.ReportServerCredentials = irsc
            .ShowCredentialPrompts = False




            'rdlFile = "/Pronto informes/" + "Resumen Cuenta Corriente Acreedores"
            'Dim reportName = "Listado general de Cartas de Porte (simulando original) con foto Buscador sin Webservice"
            If rdlFile = "" Then

            End If
            rdlFile = rdlFile.Replace(".rdl", "")
            rdlFile = "/Pronto informes/" & rdlFile



            With .ServerReport
                .ReportPath = rdlFile





                Dim yourParams As ReportParameter() = New ReportParameter(8) {}

                yourParams(0) = New ReportParameter("webservice", "")
                yourParams(1) = New ReportParameter("sServidor", ConfigurationManager.AppSettings("UrlDominio"))
                yourParams(2) = New ReportParameter("idArticulo", -1)
                yourParams(3) = New ReportParameter("idDestino", -1)
                yourParams(4) = New ReportParameter("desde", New DateTime(2012, 11, 1)) ' txtFechaDesde.Text)
                yourParams(5) = New ReportParameter("hasta", New DateTime(2012, 11, 1)) ', txtFechaHasta.Text)
                yourParams(6) = New ReportParameter("quecontenga", "ghkgk")
                yourParams(7) = New ReportParameter("Consulta", strSQL)

                If Diagnostics.Debugger.IsAttached And False Then
                    SC = Encriptar("Data Source=serversql3\TESTING;Initial catalog=Pronto;User ID=sa; Password=.SistemaPronto.;Connect Timeout=500")
                    'estoy teniendo problemas al usar el reporteador desde un servidor distinto que el que tiene la base
                    '-no creo que sea ese el problema, porque anda bien si ejecuto desde
                    '                   terminal en el server3 el informe con el parametro de conexion al server1 
                    '-todo lo que quieras, pero cuando uso una base del server3, el reporte no explota al llamar a .Render
                    '-y si acá usas el numero de ip?
                    '-hagamos así: pasá la base que te interesa del server1 al 3, y listo
                End If
                yourParams(8) = New ReportParameter("sServidorSQL", Encriptar(SC))


                If oReportViewer.ServerReport.GetParameters().Count <> yourParams.Count() Then
                    Throw New Exception("Distinta cantidad de parámetros: " & oReportViewer.ServerReport.GetParameters().Count & " y " & yourParams.Count())
                End If




                '/////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////
                'verificar que todos los datasource esten como "windows credential"
                Dim x = oReportViewer.ServerReport.GetDataSources()
                '/////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////





                Try

                    oReportViewer.ServerReport.SetParameters(yourParams)


                Catch ex As Exception
                    ErrHandler2.WriteError(ex.ToString)
                    Dim inner As Exception = ex.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            MsgBox(inner.Message)
                            Stop
                        End If
                        ErrHandler2.WriteError("Error al buscar los parametros.  " & inner.Message)
                        inner = inner.InnerException
                    End While
                End Try

                '/////////////////////
                '/////////////////////
                '/////////////////////
                '/////////////////////

            End With


            .DocumentMapCollapsed = True



            '/////////////////////
            '/////////////////////

            .Visible = False

            'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType, encoding, extension As String
            Dim bytes As Byte()

            'http://pareshjagatia.blogspot.com.ar/2008/05/export-reportviewer-report-to-pdf-excel.html
            '             string mimeType;
            '2 string encoding;
            '3 Warning[] warnings;
            '4 string[] streamids;
            '5 string fileNameExtension;
            '6 byte[] htmlBytes = MyReportViewer.ServerReport.Render("HTML4.0", null, out mimeType, out encoding, out fileNameExtension, out streamids, out warnings);
            '7 string reportHtml = System.Text.Encoding.UTF8.GetString(htmlBytes);
            '8 return reportHtml;

            If False Then


                Try
                    bytes = .ServerReport.Render( _
                          "HTML4.0", Nothing, mimeType, encoding, _
                            extension, _
                           streamids, warnings)

                Catch e As System.Exception
                    Dim inner As Exception = e.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            'MsgBox(inner.Message)
                            'Stop
                        End If
                        'ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                        inner = inner.InnerException
                    End While
                    Throw
                End Try

                Dim reportHtml As String = System.Text.Encoding.UTF8.GetString(bytes)
                'Return bytes
                Return reportHtml

            Else

                .Visible = False

                Try
                    bytes = .ServerReport.Render( _
                          "Excel", Nothing, mimeType, encoding, _
                            extension, _
                           streamids, warnings)

                Catch e As System.Exception
                    Dim inner As Exception = e.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            'MsgBox(inner.Message)
                            'Stop
                        End If
                        ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message & "   Filtro:" & titulo)
                        inner = inner.InnerException
                    End While
                    Throw
                End Try


                ErrHandler2.WriteError("Por generar el archivo " + ArchivoExcelDestino)
                Try
                    Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
                    fs.Write(bytes, 0, bytes.Length)
                    fs.Close()

                Catch ex As Exception

                    ErrHandler2.WriteAndRaiseError(ex)
                End Try




                '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ErrHandler2.WriteError("Archivo generado " + ArchivoExcelDestino)









                Dim sHtml As String

                If False Then
                    'ExcelToHtml(ArchivoExcelDestino)
                Else
                    sHtml = ArchivoExcelDestino
                End If



                Return sHtml




                'Dim ArchivoCSVDestino = ExcelToCSV(ArchivoExcelDestino)
                ''ExcelToCSV_SincroBLD

                'Return ArchivoCSVDestino



            End If


        End With

        '////////////////////////////////////////////

        'este me salvo! http://social.msdn.microsoft.com/Forums/en-US/winformsdatacontrols/thread/bd60c434-f61a-4252-a7f9-1606fdca6b41

        'http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/505ffb1c-324e-4623-9cce-d84662d92b1a
    End Function









    Public Shared Function RebindReportViewer_ServidorExcel_SinSanata(ByRef oReportViewer As Microsoft.Reporting.WebForms.ReportViewer, _
                                                                ByVal rdlFile As String, strSQL As String, SC As String, _
                                    ByRef ArchivoExcelDestino As String,
                                    IdFactura As Integer) As String
        'http://forums.asp.net/t/1183208.aspx


        With oReportViewer
            .Reset()
            .ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote
            .Visible = False



            'ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
            .ServerReport.ReportServerUrl = New Uri(ConfigurationManager.AppSettings("ReportServer"))
            .ProcessingMode = ProcessingMode.Remote
            ' IReportServerCredentials irsc = new CustomReportCredentials("administrador", ".xza2190lkm.", "");
            Dim irsc As IReportServerCredentials = New CustomReportCredentials(ConfigurationManager.AppSettings("ReportUser"), ConfigurationManager.AppSettings("ReportPass"), ConfigurationManager.AppSettings("ReportDomain"))
            .ServerReport.ReportServerCredentials = irsc
            .ShowCredentialPrompts = False



            If rdlFile = "" Then
                'rdlFile = "/Pronto informes/" + "Resumen Cuenta Corriente Acreedores"
                Dim reportName = "Listado general de Cartas de Porte (simulando original) con foto Buscador sin Webservice"
                rdlFile = "/Pronto informes/" & reportName
            End If


            With .ServerReport
                .ReportPath = rdlFile





                Dim yourParams As ReportParameter() = New ReportParameter(3) {}

                yourParams(0) = New ReportParameter("RenglonesPorBoleta", 8)
                yourParams(1) = New ReportParameter("IdFactura", IdFactura)
                yourParams(2) = New ReportParameter("Consulta", strSQL)

                If Diagnostics.Debugger.IsAttached Then
                    SC = Encriptar("Data Source=serversql3\TESTING;Initial catalog=Pronto;User ID=sa; Password=.SistemaPronto.;Connect Timeout=500")
                    'estoy teniendo problemas al usar el reporteador desde un servidor distinto que el que tiene la base
                End If
                yourParams(3) = New ReportParameter("sServidorSQL", Encriptar(SC))


                Try

                    oReportViewer.ServerReport.SetParameters(yourParams)


                Catch ex As Exception
                    ErrHandler2.WriteError(ex.ToString)
                    Dim inner As Exception = ex.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            MsgBox(inner.Message)
                            'Stop
                        End If
                        ErrHandler2.WriteError("Error al buscar los parametros.  " & inner.Message)
                        inner = inner.InnerException
                    End While
                End Try

                '/////////////////////
                '/////////////////////
                '/////////////////////
                '/////////////////////

            End With


            .DocumentMapCollapsed = True



            '/////////////////////
            '/////////////////////

            .Visible = False

            'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType, encoding, extension As String
            Dim bytes As Byte()

            'http://pareshjagatia.blogspot.com.ar/2008/05/export-reportviewer-report-to-pdf-excel.html
            '             string mimeType;
            '2 string encoding;
            '3 Warning[] warnings;
            '4 string[] streamids;
            '5 string fileNameExtension;
            '6 byte[] htmlBytes = MyReportViewer.ServerReport.Render("HTML4.0", null, out mimeType, out encoding, out fileNameExtension, out streamids, out warnings);
            '7 string reportHtml = System.Text.Encoding.UTF8.GetString(htmlBytes);
            '8 return reportHtml;

            .Visible = False

            Try
                bytes = .ServerReport.Render( _
                      "Excel", Nothing, mimeType, encoding, _
                        extension, _
                       streamids, warnings)

            Catch e As System.Exception
                Dim inner As Exception = e.InnerException
                While Not (inner Is Nothing)
                    If System.Diagnostics.Debugger.IsAttached() Then
                        'MsgBox(inner.Message)
                        'Stop
                    End If
                    ' ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                    inner = inner.InnerException
                End While
                Throw
            End Try



            ErrHandler2.WriteError("Por generar el archivo " + ArchivoExcelDestino)
            Try
                Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()

            Catch ex As Exception

                ErrHandler2.WriteAndRaiseError(ex)
            End Try




            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ErrHandler2.WriteError("Archivo generado " + ArchivoExcelDestino)









            Dim sHtml As String

            If False Then
                'ExcelToHtml(ArchivoExcelDestino)
            Else
                sHtml = ArchivoExcelDestino
            End If



            Return sHtml




            'Dim ArchivoCSVDestino = ExcelToCSV(ArchivoExcelDestino)
            ''ExcelToCSV_SincroBLD

            'Return ArchivoCSVDestino





        End With

        '////////////////////////////////////////////

        'este me salvo! http://social.msdn.microsoft.com/Forums/en-US/winformsdatacontrols/thread/bd60c434-f61a-4252-a7f9-1606fdca6b41

        'http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/505ffb1c-324e-4623-9cce-d84662d92b1a
    End Function








    Public NotInheritable Class CustomReportCredentials
        Implements IReportServerCredentials
        Private _UserName As String
        Private _PassWord As String
        Private _DomainName As String

        Public Sub New(UserName As String, PassWord As String, DomainName As String)
            _UserName = UserName
            _PassWord = PassWord
            _DomainName = DomainName
        End Sub

        Public ReadOnly Property ImpersonationUser() As System.Security.Principal.WindowsIdentity Implements IReportServerCredentials.ImpersonationUser
            Get
                Return Nothing
            End Get
        End Property

        Public ReadOnly Property NetworkCredentials() As ICredentials Implements IReportServerCredentials.NetworkCredentials
            Get
                Return New NetworkCredential(_UserName, _PassWord, _DomainName)
            End Get
        End Property

        Public Function GetFormsCredentials(ByRef authCookie As Cookie, ByRef user As String, ByRef password As String, ByRef authority As String) As Boolean Implements IReportServerCredentials.GetFormsCredentials
            authCookie = Nothing
            user = InlineAssignHelper(password, InlineAssignHelper(authority, Nothing))
            Return False
        End Function
        Private Shared Function InlineAssignHelper(Of T)(ByRef target As T, value As T) As T
            target = value
            Return value
        End Function
    End Class


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


    Shared Function DescargarImagenesAdjuntas(dt As DataTable, SC As String, bJuntarCPconTK As Boolean, DirApp As String) As String



        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)




        'Dim sDirFTP As String = "~/" + "..\Pronto\DataBackupear\" ' Cannot use a leading .. to exit above the top directory..
        'Dim sDirFTP As String = "C:\Inetpub\wwwroot\Pronto\DataBackupear\"
        'Dim sDirFTP As String = "E:\Sites\Pronto\DataBackupear\"


        'gggggg()

        'If System.Diagnostics.Debugger.IsAttached() Then
        '    sDirFTP = "C:\Users\Administrador\Documents\bdl\pronto\ProntoWeb\DataBackupear\"
        '    'sDirFTP = "~/" + "..\ProntoWeb\DataBackupear\"
        '    'sDirFTP = "http://localhost:48391/ProntoWeb/DataBackupear/"
        'Else
        '    'sDirFTP = HttpContext.Current.Server.MapPath("https://prontoweb.williamsentregas.com.ar/DataBackupear/")
        '    'sDirFTP = ConfigurationManager.AppSettings("UrlDominio") + "DataBackupear/"
        '    'sDirFTP = AppDomain.CurrentDomain.BaseDirectory & "\..\Pronto\DataBackupear\"
        'End If

        Dim sDirFTP = DirApp + "\DataBackupear\"
        Dim sDirFTPdest = sDirFTP '+ "\borrar\"
        'xxxxx()


        Dim wordFiles As New List(Of String)

        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


        'Dim idorig = _
        '                 (From c In db.CartasDePortes _
        '                 Where c.NumeroCartaDePorte = myCartaDePorte.NumeroCartaDePorte _
        '                 And c.SubnumeroVagon = myCartaDePorte.SubnumeroVagon _
        '                  And c.SubnumeroDeFacturacion = 0 Select c.IdCartaDePorte).FirstOrDefault


        For Each c As DataRow In dt.Rows
            Dim id As Long = c.Item("IdCartaDePorte")
            Dim myCartaDePorte = CartaDePorteManager.GetItem(SC, id)




            'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13193
            '            La cosa sería que en la opcion de descargar imagenes en el zip renombrar los archivos para que se llamen
            '000123456789-cp
            '000123456789-tk
            'Donde 123456789 es el numero de CP y se debe completar con ceros a la izquierda hasta los 12 dígitos.

            Dim imagenpathcp = myCartaDePorte.PathImagen
            Dim nombrecp As String = JustificadoDerecha(myCartaDePorte.NumeroCartaDePorte, 12, "0") + "-cp" + Path.GetExtension(imagenpathcp)

            Dim imagenpathtk = myCartaDePorte.PathImagen2
            Dim nombretk As String = JustificadoDerecha(myCartaDePorte.NumeroCartaDePorte, 12, "0") + "-tk" + Path.GetExtension(imagenpathtk)

            Dim destinocp = sDirFTPdest + nombrecp
            Dim destinotk = sDirFTPdest + nombretk




            If imagenpathcp <> "" Then

                Try
                    Dim fcp = New FileInfo(sDirFTP + imagenpathcp)
                    If fcp.Exists Then
                        fcp.CopyTo(destinocp, True)
                    End If
                    wordFiles.Add(nombrecp)

                Catch ex As Exception
                    ErrHandler2.WriteError(imagenpathcp + " " + nombrecp)
                End Try
            End If



            If imagenpathtk <> "" Then

                Try

                    Dim ftk = New FileInfo(sDirFTP + imagenpathtk)
                    If ftk.Exists Then
                        ftk.CopyTo(destinotk, True)
                    End If
                    wordFiles.Add(nombretk)
                Catch ex As Exception
                    ErrHandler2.WriteError(imagenpathtk + " " + nombretk)
                End Try
            End If





            If bJuntarCPconTK Then
                Try

                    If True Then
                        'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13607

                        Dim oImg As System.Drawing.Image = System.Drawing.Image.FromStream(New MemoryStream(File.ReadAllBytes(destinotk)))
                        Dim oImg2 As System.Drawing.Image = System.Drawing.Image.FromStream(New MemoryStream(File.ReadAllBytes(destinocp)))

                        Dim bimp = MergeTwoImages(oImg, oImg2)


                        bimp.Save(destinocp)


                        wordFiles.Remove(nombretk)
                    Else


                        'juntar las imagenes para DOW
                        'http://stackoverflow.com/questions/465172/merging-two-images-in-c-net

                        Dim oImg As System.Drawing.Image = System.Drawing.Image.FromStream(New MemoryStream(File.ReadAllBytes(destinotk)))

                        Using grfx As System.Drawing.Graphics = System.Drawing.Graphics.FromImage(oImg)
                            Dim oImg2 As System.Drawing.Image = System.Drawing.Image.FromStream(New MemoryStream(File.ReadAllBytes(destinocp)))
                            grfx.DrawImage(oImg2, 0, oImg.Height, oImg2.Width, oImg.Height + oImg2.Height)


                        End Using

                        oImg.Save(destinocp)



                    End If
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try
            End If


        Next






        '   sDirFTP = HttpContext.Current.Server.MapPath(sDirFTP)

        Dim output = Path.GetTempPath & "ImagenesCartaPorte" & "_" + Now.ToString("ddMMMyyyy_HHmmss") & ".zip"
        Dim MyFile1 = New FileInfo(output)
        If MyFile1.Exists Then
            MyFile1.Delete()
        End If
        Dim zip As Ionic.Zip.ZipFile = New Ionic.Zip.ZipFile(output) 'usando la .NET Zip Library
        For Each s In wordFiles
            If s = "" Then Continue For
            s = sDirFTPdest + s
            Dim MyFile2 = New FileInfo(s)
            If MyFile2.Exists Then
                Try
                    zip.AddFile(s, "")
                Catch ex As Exception
                    ErrHandler2.WriteError(s)
                    ErrHandler2.WriteError(ex)
                End Try

            End If

        Next

        zip.Save()

        Return output

    End Function







    Public Shared Function MergeTwoImages(firstImage As System.Drawing.Image, secondImage As System.Drawing.Image) As Bitmap

        If (firstImage Is Nothing) Then Throw New ArgumentNullException("firstImage")


        If (secondImage Is Nothing) Then Throw New ArgumentNullException("secondImage")


        Dim outputImageWidth As Integer = IIf(firstImage.Width > secondImage.Width, firstImage.Width, secondImage.Width)

        Dim outputImageHeight = firstImage.Height + secondImage.Height + 1

        Dim outputImage As Bitmap = New Bitmap(outputImageWidth, outputImageHeight, System.Drawing.Imaging.PixelFormat.Format32bppArgb)

        Using graphics As Graphics = graphics.FromImage(outputImage)

            graphics.DrawImage(firstImage, New Rectangle(New Point(), firstImage.Size),
                New Rectangle(New Point(), firstImage.Size), GraphicsUnit.Pixel)

            graphics.DrawImage(secondImage, New Rectangle(New Point(0, firstImage.Height + 1), secondImage.Size),
                New Rectangle(New Point(), secondImage.Size), GraphicsUnit.Pixel)

        End Using

        Return outputImage
    End Function



    Public Shared Function MergeTwoImages_TiffMultipage(f1 As String, f2 As String, sOutFilePath As String) As Bitmap




        'http://stackoverflow.com/questions/398388/convert-bitmaps-to-one-multipage-tiff-image-in-net-2-0

        ' Start with the first bitmap by putting it into an Image object

        Dim bitmap As Bitmap = System.Drawing.Image.FromFile(f1)
        'Save the bitmap to memory as tiff

        Dim byteStream As MemoryStream = New MemoryStream()
        bitmap.Save(byteStream, ImageFormat.Tiff)
        'Put Tiff into another Image object

        Dim Tiff As System.Drawing.Image = System.Drawing.Image.FromStream(byteStream)

        'Prepare encoders

        Dim encoderInfo As ImageCodecInfo = GetEncoderInfo("image/tiff")

        Dim encoderParams As EncoderParameters = New EncoderParameters(2)
        'Dim parameter As EncoderParameter = New EncoderParameter(Imaging.Encoder.Compression, EncoderValue.CompressionNone)
        'no va mas rapido sin compresion, y pesa mucho mas
        Dim parameter As EncoderParameter = New EncoderParameter(Imaging.Encoder.Compression, EncoderValue.CompressionCCITT4)
        encoderParams.Param(0) = parameter
        parameter = New EncoderParameter(Imaging.Encoder.SaveFlag, EncoderValue.MultiFrame)
        encoderParams.Param(1) = parameter

        'Save to file:
        Tiff.Save(sOutFilePath, encoderInfo, encoderParams)




        Try

            Dim bitmap2 As Bitmap = System.Drawing.Image.FromFile(f2)
            'Save the bitmap to memory as tiff
            Dim byteStream2 As MemoryStream = New MemoryStream()
            bitmap2.Save(byteStream2, ImageFormat.Tiff)


            'For subsequent pages, prepare encoders:

            Dim encoderParams2 As EncoderParameters = New EncoderParameters(2)
            Dim SaveEncodeParam As EncoderParameter = New EncoderParameter(Imaging.Encoder.SaveFlag, EncoderValue.FrameDimensionPage)
            'Dim CompressionEncodeParam As EncoderParameter = New EncoderParameter(Imaging.Encoder.Compression, EncoderValue.CompressionNone)
            Dim CompressionEncodeParam As EncoderParameter = New EncoderParameter(Imaging.Encoder.Compression, EncoderValue.CompressionCCITT4)
            encoderParams2.Param(0) = CompressionEncodeParam
            encoderParams2.Param(1) = SaveEncodeParam
            Tiff.SaveAdd(bitmap2, encoderParams2)
        Catch ex As Exception
            ErrHandler2.WriteError(ex)

        End Try


        'Finally flush the file:
        Dim SaveEncodeParam2 As EncoderParameter = New EncoderParameter(Imaging.Encoder.SaveFlag, EncoderValue.Flush)
        encoderParams = New EncoderParameters(1)
        encoderParams.Param(0) = SaveEncodeParam2
        Tiff.SaveAdd(encoderParams)

    End Function


    Private Shared Function GetEncoderInfo(ByVal mimeType As String) As ImageCodecInfo
        Dim j As Integer
        Dim encoders() As ImageCodecInfo
        encoders = ImageCodecInfo.GetImageEncoders()

        j = 0
        While j < encoders.Length
            If encoders(j).MimeType = mimeType Then
                Return encoders(j)
            End If
            j += 1
        End While
        Return Nothing

    End Function 'GetEncoderInfo


    Shared Function DescargarImagenesAdjuntas_PDF(dt As DataTable, SC As String, bJuntarCPconTK As Boolean, DirApp As String) As String



        'Dim sDirFTP As String = "~/" + "..\Pronto\DataBackupear\" ' Cannot use a leading .. to exit above the top directory..
        'Dim sDirFTP As String = "C:\Inetpub\wwwroot\Pronto\DataBackupear\"
        'Dim sDirFTP As String

        'If System.Diagnostics.Debugger.IsAttached() Then
        '    sDirFTP = "C:\Backup\BDL\ProntoWeb\DataBackupear\"
        '    'sDirFTP = "~/" + "..\ProntoWeb\DataBackupear\"
        '    'sDirFTP = "http://localhost:48391/ProntoWeb/DataBackupear/"
        'Else
        '    'sDirFTP = HttpContext.Current.Server.MapPath("https://prontoweb.williamsentregas.com.ar/DataBackupear/")
        '    'sDirFTP = ConfigurationManager.AppSettings("UrlDominio") + "DataBackupear/"
        '    'sDirFTP = AppDomain.CurrentDomain.BaseDirectory & "\..\Pronto\DataBackupear\"
        '    sDirFTP = AppDomain.CurrentDomain.BaseDirectory & "\..\Pronto\DataBackupear\"
        '    sDirFTP = "E:\Sites\Pronto\DataBackupear\"
        'End If







        Dim wordFiles As New List(Of String)

        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


        'Dim idorig = _
        '                 (From c In db.CartasDePortes _
        '                 Where c.NumeroCartaDePorte = myCartaDePorte.NumeroCartaDePorte _
        '                 And c.SubnumeroVagon = myCartaDePorte.SubnumeroVagon _
        '                  And c.SubnumeroDeFacturacion = 0 Select c.IdCartaDePorte).FirstOrDefault


        For Each c As DataRow In dt.Rows
            Dim id As Long = c.Item("IdCartaDePorte")
            Dim myCartaDePorte = CartaDePorteManager.GetItem(SC, id)





            'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13193
            '            La cosa sería que en la opcion de descargar imagenes en el zip renombrar los archivos para que se llamen
            '000123456789-cp
            '000123456789-tk
            'Donde 123456789 es el numero de CP y se debe completar con ceros a la izquierda hasta los 12 dígitos.

            Dim imagenpathcp = myCartaDePorte.PathImagen
            Dim nombrecp As String = JustificadoDerecha(myCartaDePorte.NumeroCartaDePorte, 12, "0") + "-cp" + Path.GetExtension(imagenpathcp)

            Dim imagenpathtk = myCartaDePorte.PathImagen2
            Dim nombretk As String = JustificadoDerecha(myCartaDePorte.NumeroCartaDePorte, 12, "0") + "-tk" + Path.GetExtension(imagenpathtk)

            Dim archivopdf = ImagenPDF(SC, id, DirApp)


            wordFiles.Add(archivopdf)




        Next






        '   sDirFTP = HttpContext.Current.Server.MapPath(sDirFTP)

        Dim output = Path.GetTempPath & "ImagenesCartaPorte" & "_" + Now.ToString("ddMMMyyyy_HHmmss") & ".zip"

        Try
            Dim MyFile1 = New FileInfo(output)
            If MyFile1.Exists Then
                MyFile1.Delete()
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(output)
            ErrHandler2.WriteError(ex)
            Throw
        End Try

        Dim zip As Ionic.Zip.ZipFile = New Ionic.Zip.ZipFile(output) 'usando la .NET Zip Library
        For Each s In wordFiles
            If s = "" Then Continue For

            ErrHandler2.WriteError("agrego " & s)
            's = sDirFTP + s

            Dim MyFile2 As FileInfo
            Try
                MyFile2 = New FileInfo(s)
            Catch ex2 As Exception
                ErrHandler2.WriteError(s)
                ErrHandler2.WriteError(ex2)
                Throw
            End Try

            If MyFile2.Exists Then
                Try
                    zip.AddFile(s, "")
                Catch ex As Exception
                    ErrHandler2.WriteError(s)
                    ErrHandler2.WriteError(ex)
                End Try

            End If

        Next

        zip.Save()

        ErrHandler2.WriteError(output)
        Return output

    End Function


    Shared Function DescargarImagenesAdjuntas_TIFF_anterior(dt As DataTable, SC As String, bJuntarCPconTK As Boolean, DirApp As String, reducir As Boolean) As String



        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)




        'Dim sDirFTP As String = "~/" + "..\Pronto\DataBackupear\" ' Cannot use a leading .. to exit above the top directory..
        'Dim sDirFTP As String = "C:\Inetpub\wwwroot\Pronto\DataBackupear\"
        'Dim sDirFTP As String = "E:\Sites\Pronto\DataBackupear\"


        Dim sDIRFTP = DirApp & "\DataBackupear\"
        Dim sDirFTPdest = sDIRFTP '+ "\borrar\"
        'xxxx()



        'If System.Diagnostics.Debugger.IsAttached() Then
        '    sDirFTP = "C:\Backup\BDL\ProntoWeb\DataBackupear\"
        '    'sDirFTP = "~/" + "..\ProntoWeb\DataBackupear\"
        '    'sDirFTP = "http://localhost:48391/ProntoWeb/DataBackupear/"
        'Else
        '    'sDirFTP = HttpContext.Current.Server.MapPath("https://prontoweb.williamsentregas.com.ar/DataBackupear/")
        '    'sDirFTP = ConfigurationManager.AppSettings("UrlDominio") + "DataBackupear/"
        '    'sDirFTP = AppDomain.CurrentDomain.BaseDirectory & "\..\Pronto\DataBackupear\"
        'End If






        Dim wordFiles As New List(Of String)

        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


        'Dim idorig = _
        '                 (From c In db.CartasDePortes _
        '                 Where c.NumeroCartaDePorte = myCartaDePorte.NumeroCartaDePorte _
        '                 And c.SubnumeroVagon = myCartaDePorte.SubnumeroVagon _
        '                  And c.SubnumeroDeFacturacion = 0 Select c.IdCartaDePorte).FirstOrDefault


        Const MAXIMO = 200

        For Each c As DataRow In dt.Rows
            Dim id As Long = c.Item("IdCartaDePorte")
            Dim myCartaDePorte = CartaDePorteManager.GetItem(SC, id)



            'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13193
            '            La cosa sería que en la opcion de descargar imagenes en el zip renombrar los archivos para que se llamen
            '000123456789-cp
            '000123456789-tk
            'Donde 123456789 es el numero de CP y se debe completar con ceros a la izquierda hasta los 12 dígitos.

            Dim imagenpathcp = myCartaDePorte.PathImagen
            Dim nombrecp As String = JustificadoDerecha(myCartaDePorte.NumeroCartaDePorte, 12, "0") + "-cp" + ".tif"

            Dim imagenpathtk = myCartaDePorte.PathImagen2
            Dim nombretk As String = JustificadoDerecha(myCartaDePorte.NumeroCartaDePorte, 12, "0") + "-tk" + ".tif"






            If (reducir) Then
                Try
                    CartaDePorteManager.ResizeImage_ToTIFF(imagenpathcp, 800, 1100, nombrecp, sDIRFTP, DirApp)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try


                Try
                    CartaDePorteManager.ResizeImage_ToTIFF(imagenpathtk, 800, 1100, nombretk, sDIRFTP, DirApp)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try
            Else


                If imagenpathcp <> "" Then

                    Try
                        Dim fcp = New FileInfo(sDIRFTP + imagenpathcp)
                        If fcp.Exists Then
                            fcp.CopyTo(sDirFTPdest + nombrecp, True)
                        End If
                        'wordFiles.Add(nombrecp)

                    Catch ex As Exception
                        ErrHandler2.WriteError(imagenpathcp + " " + nombrecp)
                    End Try
                End If



                If imagenpathtk <> "" Then

                    Try

                        Dim ftk = New FileInfo(sDIRFTP + imagenpathtk)
                        If ftk.Exists Then
                            ftk.CopyTo(sDirFTPdest + nombretk, True)
                        End If
                        'wordFiles.Add(nombretk)
                    Catch ex As Exception
                        ErrHandler2.WriteError(imagenpathtk + " " + nombretk)
                    End Try
                End If


            End If



            'http://stackoverflow.com/questions/398388/convert-bitmaps-to-one-multipage-tiff-image-in-net-2-0

            Try

                'JuntarImagenesYhacerTiff(sDirFTP + nombretk, sDirFTP + nombrecp, sDirFTP + nombrecp)


                Dim archivo As String = Path.GetFileNameWithoutExtension(nombrecp) + ".tif"


                If True Then
                    'metodo 1
                    'Dim bimp = MergeTwoImages_TiffMultipage(sDirFTPdest + nombrecp, sDirFTPdest + nombretk, sDirFTPdest + archivo)

                Else

                    'metodo 2 
                    'sss = {@"C:\Users\Administrador\Documents\bdl\New folder\550466649-cp.jpg",
                    '                          @"C:\Users\Administrador\Documents\bdl\New folder\550558123-cp.jpg"};

                    'SaveAsMultiPageTiff()
                End If


                wordFiles.Add(nombrecp)
                wordFiles.Add(nombretk)
                If wordFiles.Count >= MAXIMO Then Exit For


            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try


        Next






        '   sDirFTP = HttpContext.Current.Server.MapPath(sDirFTP)

        Dim output = Path.GetTempPath & "ImagenesCartaPorte" & "_" + Now.ToString("ddMMMyyyy_HHmmss") & ".zip"
        Dim MyFile1 = New FileInfo(output)
        If MyFile1.Exists Then
            MyFile1.Delete()
        End If
        Dim zip As Ionic.Zip.ZipFile = New Ionic.Zip.ZipFile(output) 'usando la .NET Zip Library
        For Each s In wordFiles
            If s = "" Then Continue For
            s = sDirFTPdest + s
            Dim MyFile2 = New FileInfo(s)
            If MyFile2.Exists Then
                Try
                    zip.AddFile(s, "")
                Catch ex As Exception
                    ErrHandler2.WriteError(s)
                    ErrHandler2.WriteError(ex)
                End Try

            End If

        Next

        zip.Save()



        Return output

    End Function



    Shared Function DescargarImagenesAdjuntas_TIFF(dt As DataTable, SC As String, bJuntarCPconTK As Boolean, DirApp As String, reducir As Boolean) As String



        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)
        ' limitar la cantidad de archivos que se puede bajar (o el tamaño)




        'Dim sDirFTP As String = "~/" + "..\Pronto\DataBackupear\" ' Cannot use a leading .. to exit above the top directory..
        'Dim sDirFTP As String = "C:\Inetpub\wwwroot\Pronto\DataBackupear\"
        'Dim sDirFTP As String = "E:\Sites\Pronto\DataBackupear\"


        Dim sDIRFTP = DirApp & "\DataBackupear\"
        Dim sDirFTPdest = sDIRFTP '+ "\borrar\"
        'xxxx()



        'If System.Diagnostics.Debugger.IsAttached() Then
        '    sDirFTP = "C:\Backup\BDL\ProntoWeb\DataBackupear\"
        '    'sDirFTP = "~/" + "..\ProntoWeb\DataBackupear\"
        '    'sDirFTP = "http://localhost:48391/ProntoWeb/DataBackupear/"
        'Else
        '    'sDirFTP = HttpContext.Current.Server.MapPath("https://prontoweb.williamsentregas.com.ar/DataBackupear/")
        '    'sDirFTP = ConfigurationManager.AppSettings("UrlDominio") + "DataBackupear/"
        '    'sDirFTP = AppDomain.CurrentDomain.BaseDirectory & "\..\Pronto\DataBackupear\"
        'End If






        Dim wordFiles As New List(Of String)

        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


        'Dim idorig = _
        '                 (From c In db.CartasDePortes _
        '                 Where c.NumeroCartaDePorte = myCartaDePorte.NumeroCartaDePorte _
        '                 And c.SubnumeroVagon = myCartaDePorte.SubnumeroVagon _
        '                  And c.SubnumeroDeFacturacion = 0 Select c.IdCartaDePorte).FirstOrDefault


        Const MAXIMO = 200

        For Each c As DataRow In dt.Rows
            Dim id As Long = c.Item("IdCartaDePorte")
            Dim myCartaDePorte = CartaDePorteManager.GetItem(SC, id)



            'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13193
            '            La cosa sería que en la opcion de descargar imagenes en el zip renombrar los archivos para que se llamen
            '000123456789-cp
            '000123456789-tk
            'Donde 123456789 es el numero de CP y se debe completar con ceros a la izquierda hasta los 12 dígitos.

            Dim imagenpathcp = myCartaDePorte.PathImagen
            Dim nombrecp As String = JustificadoDerecha(myCartaDePorte.NumeroCartaDePorte, 12, "0") + "-cp" + ".tif"
            'Dim nombrecp As String = JustificadoDerecha(myCartaDePorte.NumeroCartaDePorte, 12, "0") + "-cp" + ".jpg"

            Dim imagenpathtk = myCartaDePorte.PathImagen2
            Dim nombretk As String = JustificadoDerecha(myCartaDePorte.NumeroCartaDePorte, 12, "0") + "-tk" + ".tif"
            'Dim nombretk As String = JustificadoDerecha(myCartaDePorte.NumeroCartaDePorte, 12, "0") + "-tk" + ".jpg"






            If (reducir) Then
                Try
                    'CartaDePorteManager.ResizeImage(imagenpathcp, 300, 450, nombrecp, sDIRFTP, DirApp)
                    CartaDePorteManager.ResizeImage_ToTIFF(imagenpathcp, 0, 0, nombrecp, sDIRFTP, DirApp)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try


                Try
                    'CartaDePorteManager.ResizeImage(imagenpathtk, 500, 800, nombretk, sDIRFTP, DirApp)
                    CartaDePorteManager.ResizeImage_ToTIFF(imagenpathtk, 0, 0, nombretk, sDIRFTP, DirApp)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try
            Else


                If imagenpathcp <> "" Then

                    Try
                        Dim fcp = New FileInfo(sDIRFTP + imagenpathcp)
                        If fcp.Exists Then
                            fcp.CopyTo(sDirFTPdest + nombrecp, True)
                        End If
                        'wordFiles.Add(nombrecp)

                    Catch ex As Exception
                        ErrHandler2.WriteError(imagenpathcp + " " + nombrecp)
                    End Try
                End If



                If imagenpathtk <> "" Then

                    Try

                        Dim ftk = New FileInfo(sDIRFTP + imagenpathtk)
                        If ftk.Exists Then
                            ftk.CopyTo(sDirFTPdest + nombretk, True)
                        End If
                        'wordFiles.Add(nombretk)
                    Catch ex As Exception
                        ErrHandler2.WriteError(imagenpathtk + " " + nombretk)
                    End Try
                End If


            End If



            'http://stackoverflow.com/questions/398388/convert-bitmaps-to-one-multipage-tiff-image-in-net-2-0

            Try

                'JuntarImagenesYhacerTiff(sDirFTP + nombretk, sDirFTP + nombrecp, sDirFTP + nombrecp)


                'Dim archivo As String = Path.GetFileNameWithoutExtension(nombrecp) + ".tif"


                If True Then
                    'metodo 1
                    'Dim bimp = MergeTwoImages_TiffMultipage(sDirFTPdest + nombrecp, sDirFTPdest + nombretk, sDirFTPdest + archivo)

                Else

                    'metodo 2 
                    'sss = {@"C:\Users\Administrador\Documents\bdl\New folder\550466649-cp.jpg",
                    '                          @"C:\Users\Administrador\Documents\bdl\New folder\550558123-cp.jpg"};

                    'SaveAsMultiPageTiff()
                End If


                wordFiles.Add(nombrecp)
                wordFiles.Add(nombretk)
                If wordFiles.Count >= MAXIMO Then Exit For


            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try


        Next






        '   sDirFTP = HttpContext.Current.Server.MapPath(sDirFTP)

        Dim output = Path.GetTempPath & "ImagenesCartaPorte" & "_" + Now.ToString("ddMMMyyyy_HHmmss") & ".zip"
        Dim MyFile1 = New FileInfo(output)
        If MyFile1.Exists Then
            MyFile1.Delete()
        End If
        Dim zip As Ionic.Zip.ZipFile = New Ionic.Zip.ZipFile(output) 'usando la .NET Zip Library
        For Each s In wordFiles
            If s = "" Then Continue For
            s = sDirFTPdest + s
            Dim MyFile2 = New FileInfo(s)
            If MyFile2.Exists Then
                Try
                    zip.AddFile(s, "")
                Catch ex As Exception
                    ErrHandler2.WriteError(s)
                    ErrHandler2.WriteError(ex)
                End Try

            End If

        Next

        zip.Save()



        Return output

    End Function




    Public Shared Function JuntarImagenesYhacerTiff(archivo1 As String, archivo2 As String, final As String) As String

        Dim arguments As String() = {archivo1, archivo2, final}
        TiffCP.Program.Main(arguments)

        Return final
    End Function




    Shared Function ImagenPDF(SC As String, IdCarta As Long, DirApp As String) As String

        Dim sDirFTP As String

        Dim myCartaDePorte As CartaDePorte


        If System.Diagnostics.Debugger.IsAttached() And False Then
            myCartaDePorte = New CartaDePorte
            myCartaDePorte.PathImagen = "9675224abr2013_071802_30868007-CP.jpg"
            myCartaDePorte.PathImagen2 = "4088624abr2013_071803_30868007-TK.jpg"
        Else
            myCartaDePorte = CartaDePorteManager.GetItem(SC, IdCarta, True)


        End If



        If myCartaDePorte.PathImagen = "" And myCartaDePorte.PathImagen2 = "" Then
            'verificar la carta de porte original a ver si tiene las imagenes
            If myCartaDePorte.SubnumeroDeFacturacion > 0 Then

                Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


                Dim idorig = _
                                 (From c In db.CartasDePortes _
                                 Where c.NumeroCartaDePorte = myCartaDePorte.NumeroCartaDePorte _
                                 And c.SubnumeroVagon = myCartaDePorte.SubnumeroVagon _
                                  And c.SubnumeroDeFacturacion = 0 Select c.IdCartaDePorte).FirstOrDefault

                If idorig > 0 Then
                    myCartaDePorte = CartaDePorteManager.GetItem(SC, idorig)


                    IdCarta = idorig

                End If

            End If




        End If


        If myCartaDePorte.PathImagen = "" And myCartaDePorte.PathImagen2 = "" Then

            ErrHandler2.WriteError("sin imagenes")
            Return ""
        End If




        Dim output As String


        output = Path.GetTempPath & "CP" & myCartaDePorte.NumeroCartaDePorte & "__" & Now.ToString("ddMMMyyyy_HHmmss") & GenerarSufijoRand() & ".pdf" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net




        Try

            If System.Diagnostics.Debugger.IsAttached() And False Then
                sDirFTP = "~/" + "DataBackupear\"
                sDirFTP = DirApp + "\DataBackupear\"



                Try
                    CartaDePorteManager.ResizeImage(myCartaDePorte.PathImagen, 600, 800, myCartaDePorte.PathImagen & ".temp." & Path.GetExtension(myCartaDePorte.PathImagen), sDirFTP, DirApp)
                    CartaDePorteManager.ResizeImage(myCartaDePorte.PathImagen2, 600, 800, myCartaDePorte.PathImagen2 & ".temp." & Path.GetExtension(myCartaDePorte.PathImagen2), sDirFTP, DirApp)

                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try


                CartaDePorteManager.PDFcon_iTextSharp(output, _
                                   HttpContext.Current.Server.MapPath(IIf(myCartaDePorte.PathImagen <> "", sDirFTP, "")) + myCartaDePorte.PathImagen & ".temp." & Path.GetExtension(myCartaDePorte.PathImagen), _
                                 HttpContext.Current.Server.MapPath(IIf(myCartaDePorte.PathImagen2 <> "", sDirFTP, "")) + myCartaDePorte.PathImagen2 & ".temp." & Path.GetExtension(myCartaDePorte.PathImagen2) _
                                , 5)
            Else



                sDirFTP = AppDomain.CurrentDomain.BaseDirectory & "\..\Pronto\DataBackupear\"
                sDirFTP = "E:\Sites\Pronto\DataBackupear\"
                sDirFTP = DirApp + "\DataBackupear\"


                Try
                    CartaDePorteManager.ResizeImage(myCartaDePorte.PathImagen, 600, 800, myCartaDePorte.PathImagen & ".temp." & Path.GetExtension(myCartaDePorte.PathImagen), sDirFTP, DirApp)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try


                Try
                    CartaDePorteManager.ResizeImage(myCartaDePorte.PathImagen2, 600, 800, myCartaDePorte.PathImagen2 & ".temp." & Path.GetExtension(myCartaDePorte.PathImagen2), sDirFTP, DirApp)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try






                CartaDePorteManager.PDFcon_iTextSharp(output, _
                                  IIf(myCartaDePorte.PathImagen <> "", sDirFTP & myCartaDePorte.PathImagen & ".temp." & Path.GetExtension(myCartaDePorte.PathImagen), ""), _
                                IIf(myCartaDePorte.PathImagen2 <> "", sDirFTP & myCartaDePorte.PathImagen2 & ".temp." & Path.GetExtension(myCartaDePorte.PathImagen2), "") _
                                , 1)


            End If


        Catch ex As Exception

            ErrHandler2.WriteError(ex)
            'MsgBoxAjax(Me, "La carta " & myCartaDePorte.Numero & " fue modificada y ya no tiene imágenes adjuntas")
            Return ""

        End Try



        Return output

    End Function



    Shared Function PDFcon_iTextSharp(filepdf As String, filejpg As String, filejpg2 As String, Optional propor As Decimal = 1)


        ErrHandler2.WriteError("PDFcon_iTextSharp " & filepdf & "  " & filejpg & "   " & filejpg2)



        Dim document As iTextSharp.text.Document = New iTextSharp.text.Document()

        Using stream = New FileStream(filepdf, FileMode.Create, FileAccess.Write, FileShare.None)

            iTextSharp.text.pdf.PdfWriter.GetInstance(document, stream)
            document.Open()

            Try





                If filejpg <> "" Then
                    Using imageStream = New FileStream(filejpg, FileMode.Open, FileAccess.Read, FileShare.ReadWrite)
                        Dim Image = iTextSharp.text.Image.GetInstance(imageStream)
                        'Image.SetAbsolutePosition(0, 0)
                        'Image.ScaleToFit(document.PageSize.Width, document.PageSize.Height)
                        Dim percentage As Decimal = 0.0F
                        percentage = 540 / Image.Width
                        Image.ScalePercent(percentage * 100 / propor)
                        'Image.ScaleAbsolute(Image.Width / 5, Image.Height / 5)



                        '// Image.SetDpi(30, 30)


                        document.Add(Image)
                    End Using
                End If

            Catch ex As Exception
                ErrHandler2.WriteError(ex)

            End Try

            Try

                If filejpg2 <> "" Then
                    Using imageStream = New FileStream(filejpg2, FileMode.Open, FileAccess.Read, FileShare.ReadWrite)
                        Dim Image = iTextSharp.text.Image.GetInstance(imageStream)
                        Image.ScaleToFit(document.PageSize.Width, document.PageSize.Height)
                        Dim percentage As Decimal = 0.0F
                        percentage = 540 / Image.Width
                        Image.ScalePercent(percentage * 100 / propor)
                        'Image.SetDpi(30, 30)

                        document.Add(Image)
                    End Using
                End If

            Catch ex As Exception
                ErrHandler2.WriteError(ex)

            End Try


            Try
                document.Close()
            Catch ex As Exception
                ' The document has no pages.
                'Stack(Trace) : at(iTextSharp.text.pdf.PdfPages.WritePageTree())
                'at(iTextSharp.text.pdf.PdfWriter.Close())
                'at(iTextSharp.text.pdf.PdfDocument.Close())
                'at(iTextSharp.text.Document.Close())


                'parece ser que a veces llega a acá y no se le había pasado bien el temp_imagen. Mejor dicho, el nombre estaba en el 
                'filejpg y en el filejpg2, pero el archivo no existe.
                'ok, en ese caso el responsable es ImagenPDF()

                'MandarMailDeError(ex.ToString + " " + filejpg + " " + filejpg2)
                ErrHandler2.WriteError(ex.ToString + " " + filejpg + " " + filejpg2)
                'MsgBoxAjax(Me, "No se pudo generar el documento PDF. Quizas las cartas fueron modificadas y ya no tienen imágenes adjuntas")
                Throw
            End Try





        End Using

    End Function



    'http://www.codeproject.com/Questions/362618/How-to-reduce-image-size-in-asp-net-with-same-clar
    Public Shared Sub ResizeImage(image As String, width As Integer, height As Integer, newimagename As String, sDirVirtual As String, DirApp As String)
        'Dim sDir = AppDomain.CurrentDomain.BaseDirectory & "DataBackupear\"
        'Dim sDir = ConfigurationManager.AppSettings("sDirFTP") ' & "DataBackupear\"


        Dim sDir As String

        If System.Diagnostics.Debugger.IsAttached() And HttpContext.Current IsNot Nothing Then
            'sDirVirtual = "~/DataBackupear\"
            'sDir = HttpContext.Current.Server.MapPath(sDirVirtual)
        Else
            ' sDir = "C:\Inetpub\wwwroot\Pronto\DataBackupear\"
            sDir = "E:\Sites\Pronto\DataBackupear\"
            'sDir = HttpContext.Current.Server.MapPath(AppDomain.CurrentDomain.BaseDirectory & "\..\Pronto\DataBackupear\")
            'sDir = AppDomain.CurrentDomain.BaseDirectory & "\..\Pronto\DataBackupear\"
        End If

        If DirApp <> "" Then
            sDir = DirApp & "\DataBackupear\"
        Else
            sDir = ""
        End If
        Dim sDirDest = sDir '& "\borrar\"

        'nombrenuevo = CreaDirectorioParaImagenCartaPorte(nombrenuevo, DirApp)



        ErrHandler2.WriteError("ResizeImage " & sDir & image)



        'Dim oImg As System.Drawing.Image = System.Drawing.Image.FromFile(HttpContext.Current.Server.MapPath("~/" + ConfigurationManager.AppSettings(Okey) & image))
        Dim oImg As System.Drawing.Image = System.Drawing.Image.FromFile(sDir & image)

        'http://siderite.blogspot.com/2009/09/outofmemoryexception-in.html
        oImg = oImg.GetThumbnailImage(oImg.Width, oImg.Height, Nothing, IntPtr.Zero)


        Dim oThumbNail As System.Drawing.Image = New System.Drawing.Bitmap(width, height)
        ', System.Drawing.Imaging.PixelFormat.Format24bppRgb
        Dim oGraphic As System.Drawing.Graphics = System.Drawing.Graphics.FromImage(oThumbNail)

        oGraphic.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality

        'set smoothing mode to high quality
        oGraphic.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality
        'set the interpolation mode
        oGraphic.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic
        'set the offset mode
        oGraphic.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality

        Dim oRectangle As New System.Drawing.Rectangle(0, 0, width, height)

        oGraphic.DrawImage(oImg, oRectangle)


        Try



            If newimagename = "" Then
                If image.Substring(image.LastIndexOf(".")) <> ".png" Then
                    ErrHandler2.WriteError("resize 1")
                    oThumbNail.Save(sDirDest & image, System.Drawing.Imaging.ImageFormat.Jpeg)
                Else
                    ErrHandler2.WriteError("resize 2")
                    oThumbNail.Save(sDirDest & image, System.Drawing.Imaging.ImageFormat.Png)
                End If
            Else
                If newimagename.Substring(newimagename.LastIndexOf(".")) <> ".png" Then
                    ErrHandler2.WriteError("resize 3")
                    oThumbNail.Save(sDirDest & newimagename, System.Drawing.Imaging.ImageFormat.Jpeg)
                Else
                    ErrHandler2.WriteError("resize 4")
                    oThumbNail.Save(sDirDest & newimagename, System.Drawing.Imaging.ImageFormat.Png)
                End If
            End If

        Catch ex As Exception
            'acá está pasando lo del gdi
            'A generic error occurred in GDI+.
            'parece ser que el archivo ya existe?
            'NO!!!! es por el subdirectorio de destino!!! 
            'http://stackoverflow.com/questions/1053052/a-generic-error-occurred-in-gdi-jpeg-image-to-memorystream
            'If you are getting that error , then I can say that your application doesn't have a write permission on some directory.
            ErrHandler2.WriteError("If you are getting that error , then I can say that your application doesn't have a write permission on some directory.")
            ErrHandler2.WriteError("estabas metiendo _temp como prefijo sobre el subdirectorio en lugar del nombre del archivo!!!")
            ErrHandler2.WriteError(ex)
            ErrHandler2.WriteError(sDirDest & "---" & image & "---" & newimagename)
        End Try



        oImg.Dispose()
    End Sub




    'http://www.codeproject.com/Questions/362618/How-to-reduce-image-size-in-asp-net-with-same-clar
    Public Shared Sub ResizeImage_ToTIFF(image As String, width As Integer, height As Integer, newimagename As String, sDirVirtual As String, DirApp As String)
        'Dim sDir = AppDomain.CurrentDomain.BaseDirectory & "DataBackupear\"
        'Dim sDir = ConfigurationManager.AppSettings("sDirFTP") ' & "DataBackupear\"


        Dim sDir As String

        If System.Diagnostics.Debugger.IsAttached() And HttpContext.Current IsNot Nothing Then
            'sDirVirtual = "~/DataBackupear\"
            'sDir = HttpContext.Current.Server.MapPath(sDirVirtual)
        Else
            ' sDir = "C:\Inetpub\wwwroot\Pronto\DataBackupear\"
            sDir = "E:\Sites\Pronto\DataBackupear\"
            'sDir = HttpContext.Current.Server.MapPath(AppDomain.CurrentDomain.BaseDirectory & "\..\Pronto\DataBackupear\")
            'sDir = AppDomain.CurrentDomain.BaseDirectory & "\..\Pronto\DataBackupear\"
        End If

        If DirApp <> "" Then
            sDir = DirApp & "\DataBackupear\"
        Else
            sDir = ""
        End If
        Dim sDirDest = sDir '& "\borrar\"

        'nombrenuevo = CreaDirectorioParaImagenCartaPorte(nombrenuevo, DirApp)



        ErrHandler2.WriteError("ResizeImage " & sDir & image)



        'Dim oImg As System.Drawing.Image = System.Drawing.Image.FromFile(HttpContext.Current.Server.MapPath("~/" + ConfigurationManager.AppSettings(Okey) & image))
        Dim oImg As System.Drawing.Image = System.Drawing.Image.FromFile(sDir & image)

        'http://siderite.blogspot.com/2009/09/outofmemoryexception-in.html
        oImg = oImg.GetThumbnailImage(oImg.Width, oImg.Height, Nothing, IntPtr.Zero)
        If height = 0 And width = 0 Then
            height = oImg.Height
            width = oImg.Width
        End If


        Dim oThumbNail As System.Drawing.Image = New System.Drawing.Bitmap(width, height)
        ', System.Drawing.Imaging.PixelFormat.Format24bppRgb
        Dim oGraphic As System.Drawing.Graphics = System.Drawing.Graphics.FromImage(oThumbNail)

        oGraphic.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighSpeed

        'set smoothing mode to high quality
        oGraphic.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality
        'set the interpolation mode
        oGraphic.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic
        'set the offset mode
        oGraphic.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighSpeed


        Dim oRectangle As New System.Drawing.Rectangle(0, 0, width, height)

        oGraphic.DrawImage(oImg, oRectangle)


        Try

            Dim encoderInfo As ImageCodecInfo = GetEncoderInfo("image/tiff")
            Dim encoderParams As EncoderParameters = New EncoderParameters(1)

            Dim parameter As EncoderParameter = New EncoderParameter(Imaging.Encoder.Compression, EncoderValue.CompressionCCITT4)
            'Dim parameter As EncoderParameter = New EncoderParameter(Imaging.Encoder.Compression, EncoderValue.CompressionCCITT3)

            encoderParams.Param(0) = parameter
            'parameter = New EncoderParameter(Imaging.Encoder.SaveFlag, EncoderValue.)
            'encoderParams.Param(1) = parameter



            oThumbNail.Save(sDirDest & newimagename, encoderInfo, encoderParams)
            
        Catch ex As Exception
            'acá está pasando lo del gdi
            'A generic error occurred in GDI+.
            'parece ser que el archivo ya existe?
            'NO!!!! es por el subdirectorio de destino!!! 
            'http://stackoverflow.com/questions/1053052/a-generic-error-occurred-in-gdi-jpeg-image-to-memorystream
            'If you are getting that error , then I can say that your application doesn't have a write permission on some directory.
            ErrHandler2.WriteError("If you are getting that error , then I can say that your application doesn't have a write permission on some directory.")
            ErrHandler2.WriteError("estabas metiendo _temp como prefijo sobre el subdirectorio en lugar del nombre del archivo!!!")
            ErrHandler2.WriteError(ex)
            ErrHandler2.WriteError(sDirDest & "---" & image & "---" & newimagename)
        End Try



        oImg.Dispose()
    End Sub




    
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////MIGRAR SQL ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



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




    'Este filtro lo uso en los sincronismos, porque ahí está el dataset tipado
    Public Shared Function generarWHEREparaDatasetParametrizadoConFechaEnNumerales( _
                    ByVal sc As String, ByRef sTituloFiltroUsado As String, _
                    ByVal estado As CartaDePorteManager.enumCDPestado, _
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
                    Optional ByVal Vagon As Integer = Nothing, Optional ByVal Patente As String = "", _
                    Optional ByVal optCamionVagon As String = "Ambas", _
                    Optional ByVal idClienteAuxiliar As Integer = -1 _
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
                    iisIdValido(idClienteAuxiliar, "             AND CDP.idClienteAuxiliar=" & idClienteAuxiliar, "")

        Else
            Dim s = " AND (1=0 " & _
                    iisIdValido(idVendedor, "           OR CDP.Vendedor = " & idVendedor, "") & _
                    iisIdValido(idIntermediario, "             OR CDP.CuentaOrden1=" & idIntermediario, "") & _
                    iisIdValido(idRemComercial, "             OR CDP.CuentaOrden2=" & idRemComercial, "") & _
                    iisIdValido(idClienteAuxiliar, "             OR CDP.idClienteAuxiliar=" & idClienteAuxiliar, "") & _
                    "  )  "

            If s <> " AND (1=0   )  " Then strWHERE += s
        End If


        strWHERE += iisIdValido(idCorredor, "             AND (CDP.Corredor=" & idCorredor & " OR CDP.Corredor2=" & idCorredor & ") ", "")
        strWHERE += iisIdValido(idArticulo, "           AND CDP.IdArticulo=" & idArticulo, "")
        strWHERE += iisIdValido(idProcedencia, "             AND CDP.Procedencia=" & idProcedencia, "")
        strWHERE += iisIdValido(idDestino, "             AND CDP.Destino=" & idDestino, "")
        strWHERE += iisIdValido(idDestinatario, "             AND  CDP.Entregador=" & idDestinatario, "")



        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////
        'como hacer cuando hay periodo y es descarga+posicion?
        'sWHERE += "    AND (isnull(FechaDescarga, FechaArribo) Between '" & iisValidSqlDate(fechadesde, #1/1/1753#) & "' AND '" & iisValidSqlDate(fechahasta, #1/1/2100#) & "')"


        strWHERE += CartaDePorteManager.EstadoWHERE(estado, "CDP.").Replace("#", "'")

        '

        'dddd()
        ' no debo filtrar por fecha las posiciones....



        If True Then 'estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas Then

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
            strWHERE += "AND (CDP.Patente='" & Patente & "')"
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


        'If optDivisionSyngenta <> "Ambas" And optDivisionSyngenta <> "" Then strWHERE += " AND isnull(CDP.EnumSyngentaDivision,'')='" & optDivisionSyngenta & "'"
        Dim IdAcopio = BuscarIdAcopio(optDivisionSyngenta, sc)

        If optDivisionSyngenta <> "Ambas" And optDivisionSyngenta <> "" Then
            strWHERE += " AND ("

            strWHERE += " isnull(CDP.EnumSyngentaDivision,'')='" & optDivisionSyngenta & "'"

            strWHERE += " OR CDP.Acopio1=" & IdAcopio & ""
            strWHERE += " OR CDP.Acopio2=" & IdAcopio & ""
            strWHERE += " OR CDP.Acopio3=" & IdAcopio & ""
            strWHERE += " OR CDP.Acopio4=" & IdAcopio & ""
            strWHERE += " OR CDP.Acopio5=" & IdAcopio & ""
            strWHERE += " OR CDP.Acopio6=" & IdAcopio & ""

            strWHERE += " )"
        End If


        If sTituloFiltroUsado = "" Then
            Select Case estado
                Case CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas
                    sTituloFiltroUsado &= "Todas (menos las rechazadas), "
                Case CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones
                    sTituloFiltroUsado &= "Descargas de Hoy + Todas las Posiciones, "
                Case CartaDePorteManager.enumCDPestado.Posicion
                    sTituloFiltroUsado &= "Posición, "
                Case enumCDPestado.DescargasMasFacturadas
                    sTituloFiltroUsado &= "Descargas, "
                Case CartaDePorteManager.enumCDPestado.Rechazadas
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





    Public Shared Function generarWHEREparaDatasetParametrizado( _
                    ByVal sc As String, ByRef sTituloFiltroUsado As String, _
                    ByVal estado As CartaDePorteManager.enumCDPestado, _
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
                    Optional ByVal Vagon As Integer = Nothing, Optional ByVal Patente As String = "", _
                    Optional ByVal optCamionVagon As String = "Ambas" _
                ) As String


        Dim strWHERE As String = "1=1 "




        If QueContenga <> "" Then
            Dim idVendedorQueContiene = BuscaIdClientePreciso(QueContenga, sc)
            Dim idCorredorQueContiene = BuscaIdVendedorPreciso(QueContenga, sc)


            '  strWHERE += "  AND (NumeroCartaDePorte LIKE  '%" & QueContenga & "%'" & ") "

            strWHERE += "AND (1=0  "

            If idVendedorQueContiene <> -1 Then
                'no hay que agregar el prefijo .CDP acá para que funcione?????
                'no hay que agregar el prefijo .CDP acá para que funcione?????
                'no hay que agregar el prefijo .CDP acá para que funcione?????
                'no hay que agregar el prefijo .CDP acá para que funcione?????
                strWHERE += "  " & _
                 "           OR (Vendedor = " & idVendedorQueContiene & _
                "           OR CuentaOrden1 = " & idVendedorQueContiene & _
                "           OR CuentaOrden2 = " & idVendedorQueContiene & _
                "             OR Entregador=" & idVendedorQueContiene & _
                "           OR idClienteAuxiliar = " & idVendedorQueContiene & _
                "           )"
            End If

            If idCorredorQueContiene <> -1 Then
                strWHERE += "  " & _
                "    OR (   Corredor=" & idCorredorQueContiene & _
                "             OR Corredor2=" & idCorredorQueContiene & _
                "           )"


            End If


            strWHERE += ") "


        End If


        If QueContenga2 <> "" Then
            strWHERE += "  AND (NumeroCartaDePorte LIKE  '%" & QueContenga2 & "%'" & ") "
        End If









        If AplicarANDuORalFiltro = 1 Then
            strWHERE += iisIdValido(idVendedor, "           AND CDP.Vendedor = " & idVendedor, "") & _
                    iisIdValido(idIntermediario, "             AND CDP.CuentaOrden1=" & idIntermediario, "") & _
                    iisIdValido(idRemComercial, "             AND CDP.CuentaOrden2=" & idRemComercial, "") & _
                    iisIdValido(idClienteAuxiliar, "             AND CDP.idClienteAuxiliar=" & idClienteAuxiliar, "") & _
                    ""
        Else
            Dim s = " AND (1=0 " & _
                    iisIdValido(idVendedor, "           OR CDP.Vendedor = " & idVendedor, "") & _
                    iisIdValido(idIntermediario, "             OR CDP.CuentaOrden1=" & idIntermediario, "") & _
                    iisIdValido(idRemComercial, "             OR CDP.CuentaOrden2=" & idRemComercial, "") & _
                    iisIdValido(idClienteAuxiliar, "             OR CDP.idClienteAuxiliar=" & idClienteAuxiliar, "") & _
                                                       "  )  "

            If s <> " AND (1=0   )  " Then strWHERE += s
        End If




        'Estos son excluyentes:
        strWHERE += iisIdValido(idCorredor, "             AND (CDP.Corredor=" & idCorredor & " OR CDP.Corredor2=" & idCorredor & ") ", "")
        strWHERE += iisIdValido(idArticulo, "           AND CDP.IdArticulo=" & idArticulo, "")
        strWHERE += iisIdValido(idProcedencia, "             AND CDP.Procedencia=" & idProcedencia, "")
        strWHERE += iisIdValido(idDestino, "             AND CDP.Destino=" & idDestino, "")
        strWHERE += iisIdValido(idDestinatario, "             AND  CDP.Entregador=" & idDestinatario, "")
        'strWHERE += iisIdValido(idClienteAuxiliar, "             AND CDP.idClienteAuxiliar=" & idClienteAuxiliar, "")


        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////
        'como hacer cuando hay periodo y es descarga+posicion?
        'sWHERE += "    AND (isnull(FechaDescarga, FechaArribo) Between '" & iisValidSqlDate(fechadesde, #1/1/1753#) & "' AND '" & iisValidSqlDate(fechahasta, #1/1/2100#) & "')"


        strWHERE += CartaDePorteManager.EstadoWHERE(estado, "CDP.").Replace("#", "'")

        '

        'dddd()


        If True Then '            If estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas Then

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
        '//////////////////////////////////////////////////////////////////////will/////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////


        Dim IdAcopio = BuscarIdAcopio(optDivisionSyngenta, sc)


        If optDivisionSyngenta <> "Ambas" And optDivisionSyngenta <> "" Then
            strWHERE += " AND ("

            strWHERE += " isnull(CDP.EnumSyngentaDivision,'')='" & optDivisionSyngenta & "'"

            strWHERE += " OR Acopio1=" & IdAcopio & ""
            strWHERE += " OR Acopio2=" & IdAcopio & ""
            strWHERE += " OR Acopio3=" & IdAcopio & ""
            strWHERE += " OR Acopio4=" & IdAcopio & ""
            strWHERE += " OR Acopio5=" & IdAcopio & ""
            strWHERE += " OR Acopio6=" & IdAcopio & ""

            strWHERE += " )"
        End If
        '            strWHERE += " AND isnull(CDP.EnumSyngentaDivision,'Agro')='" & optDivisionSyngenta & "'"




        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////


        If optCamionVagon = "Camiones" Then
            strWHERE += " AND ( isnull(CDP.SubNumeroVagon,'')='') "
        ElseIf optCamionVagon = "Vagones" Then
            strWHERE += " AND ( isnull(CDP.SubNumeroVagon,'')<>'') "
        End If





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
                Case CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas
                    sTituloFiltroUsado &= "Todas (menos las rechazadas), "
                Case CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones
                    sTituloFiltroUsado &= "Descargas de Hoy + Todas las Posiciones, "
                Case CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha
                    sTituloFiltroUsado &= "Descargas de Hoy + Posiciones filtradas, "
                Case CartaDePorteManager.enumCDPestado.Posicion
                    sTituloFiltroUsado &= "Posición, "
                Case CartaDePorteManager.enumCDPestado.DescargasMasFacturadas
                    sTituloFiltroUsado &= "Descargas, "
                Case CartaDePorteManager.enumCDPestado.Rechazadas
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


    Shared Function SQL_ListaDeCDPsFiltradas2(ByVal sWHEREadicional As String, ByVal optFacturarA As Long, ByVal txtFacturarATerceros As String, _
                                         ByVal HFSC As String, ByVal txtTitular As String, ByVal txtCorredor As String, _
                                         ByVal txtDestinatario As String, ByVal txtIntermediario As String, ByVal txtRcomercial As String, _
                                         ByVal txt_AC_Articulo As String, ByVal txtProcedencia As String, ByVal txtDestino As String, _
                                         ByVal txtBuscar As String, ByVal cmbCriterioWHERE As String, ByVal cmbmodo As String, _
                                         ByVal optDivisionSyngenta As String, ByVal txtFechaDesde As String, ByVal txtFechaHasta As String, _
                                         ByVal cmbPuntoVenta As String, Optional ByVal sJOIN As String = "", Optional ByVal txtClienteAuxiliar As String = "", _
                                         Optional ByVal txtFacturarA As String = "", Optional txtCorredorObs As String = "") _
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
    "           CDP.Destino as IdDestino, CDP.AgregaItemDeGastosAdministrativos,CDP.Exporta,IdClienteAFacturarle,IdClienteEntregador,ConDuplicados " & _
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
        Dim idCorredorObs = BuscaIdVendedorPreciso(txtCorredorObs, HFSC)
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
        strWHERE += iisIdValido(idCorredorObs, "             AND CDP.Corredor2=" & idCorredorObs, "")

        strWHERE += iisIdValido(idArticulo, "           AND CDP.IdArticulo=" & idArticulo, "")
        strWHERE += iisIdValido(idProcedencia, "             AND CDP.Procedencia=" & idProcedencia, "")
        strWHERE += iisIdValido(idDestino, "             AND CDP.Destino=" & idDestino, "")


        strWHERE += " ) )  " 'truco para usar el idfacturaA








        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////




        'If optDivisionSyngenta <> "Ambas" And optDivisionSyngenta <> "" Then strWHERE += " AND isnull(CDP.EnumSyngentaDivision,'')='" & optDivisionSyngenta & "'"
        Dim IdAcopio = BuscarIdAcopio(optDivisionSyngenta, HFSC)

        If optDivisionSyngenta <> "Ambas" And optDivisionSyngenta <> "" Then

            strWHERE += " AND ("
            strWHERE += "        isnull(CDP.AcopioFacturarleA,0)=0 "
            strWHERE += "       AND ("
            strWHERE += "           isnull(CDP.EnumSyngentaDivision,'')='" & optDivisionSyngenta & "'"
            strWHERE += "           OR CDP.Acopio1=" & IdAcopio & ""
            strWHERE += "           OR CDP.Acopio2=" & IdAcopio & ""
            strWHERE += "           OR CDP.Acopio3=" & IdAcopio & ""
            strWHERE += "           OR CDP.Acopio4=" & IdAcopio & ""
            strWHERE += "           OR CDP.Acopio5=" & IdAcopio & ""
            strWHERE += "           OR CDP.Acopio6=" & IdAcopio & ""
            strWHERE += "       )"
            strWHERE += "       OR CDP.AcopioFacturarleA=" & IdAcopio & ""
            strWHERE += ")"

        End If


        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////





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
        strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "CDP.")


        'http://www.sqlteam.com/forums/topic.asp?TOPIC_ID=71950

        strWHERE += " group by IdCartaDePorte, CDP.IdArticulo,      NumeroCartaDePorte ,SubNumeroVagon ,CDP.SubNumeroDeFacturacion , FechaArribo, " & _
                     " FechaDescarga  , " _
                        & IIf(optFacturarA <> 4, facturarselaA & ", " & IdFacturarselaA & ", ", "") & _
                    " Articulos.Descripcion,         NetoFinal   ,  Corredor, Vendedor,  CuentaOrden1 , CuentaOrden2 , Entregador ,           CLIVEN.Razonsocial   ,        " & _
                    " CLICO1.Razonsocial  ,        CLICO2.Razonsocial  ,        " & _
                    " CLICOR.Nombre ,        CLIENT.Razonsocial  ,          " & _
                    " LOCDES.Descripcion  ,         LOCORI.Nombre  , CDP.Exporta,            " & _
                    "     CDP.Destino, CDP.AgregaItemDeGastosAdministrativos, TarifaFacturada,IdClienteAFacturarle, IdClienteEntregador, ConDuplicados," & _
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
    "          ''  as Sucursal, CDP.PuntoVenta, " & _
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
    "          '' as CadenaVacia, NetoProc, EnumSyngentaDivision, IdTipoMovimiento,CobraAcarreo,LiquidaViaje,IdCartaDePorte,SubNumeroVagon,Procedencia, Corredor2, IdClienteAuxiliar  " & _
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



        '"			isnull(CLIENTREG.Razonsocial,'') AS EntregadorDesc, " & _
        '"       LEFT OUTER JOIN Clientes CLIENTREG ON CDP.IdClienteEntregador= CLIENTREG.IdCliente " & _

        Return strSQL
    End Function



    Shared Function GetListDataTableDinamicoConWHERE_2(ByVal SC As String, ByVal estado As CartaDePorteManager.enumCDPestado, _
                                                       ByVal strWHERE As String, bInsertarEnTablaTemporal As Boolean, _
                                                       Optional maxrows As Integer = 0) As DataTable

        'lo que sea dinámico, lo tendré que migrar para evitar inyeccion

        If maxrows > 0 Then
            maxrows = Min(maxrows, _CONST_MAXROWS)
        Else
            maxrows = _CONST_MAXROWS
        End If

        'hace falta levantar la cantidad de filas que levanto, no teniendo paginacion?

        Dim strSQL = String.Format("  SELECT TOP " & maxrows & _
      "  CDP.IdCartaDePorte, CDP.NumeroCartaDePorte, CDP.IdUsuarioIngreso, CDP.FechaIngreso, CDP.Anulada, CDP.IdUsuarioAnulo, CDP.FechaAnulacion, CDP.Observaciones, CDP.FechaTimeStamp, CDP.Vendedor, CDP.CuentaOrden1, CDP.CuentaOrden2, CDP.Corredor, CDP.Entregador, CDP.Procedencia, CDP.Patente, CDP.IdArticulo, CDP.IdStock, CDP.Partida, CDP.IdUnidad, CDP.IdUbicacion, CDP.Cantidad, CDP.Cupo, CDP.NetoProc, CDP.Calidad " & _
"      ,CDP.BrutoPto      ,CDP.TaraPto      ,CDP.NetoPto      ,CDP.Acoplado      ,CDP.Humedad      ,CDP.Merma      ,CDP.NetoFinal      ,CDP.FechaDeCarga      ,CDP.FechaVencimiento      ,CDP.CEE      ,CDP.IdTransportista      ,CDP.TransportistaCUITdesnormalizado      ,CDP.IdChofer      ,CDP.ChoferCUITdesnormalizado      ,CDP.CTG      ,CDP.Contrato      ,CDP.Destino      ,CDP.Subcontr1      ,CDP.Subcontr2      ,CDP.Contrato1 " & _
"      ,CDP.contrato2      ,CDP.KmARecorrer      ,CDP.Tarifa      ,CDP.FechaDescarga      ,CDP.Hora      ,CDP.NRecibo      ,CDP.CalidadDe      ,CDP.TaraFinal      ,CDP.BrutoFinal      ,CDP.Fumigada      ,CDP.Secada      ,CDP.Exporta      ,CDP.NobleExtranos      ,CDP.NobleNegros      ,CDP.NobleQuebrados      ,CDP.NobleDaniados      ,CDP.NobleChamico      ,CDP.NobleChamico2      ,CDP.NobleRevolcado      ,CDP.NobleObjetables      ,CDP.NobleAmohosados      ,CDP.NobleHectolitrico      ,CDP.NobleCarbon " & _
"      ,CDP.NoblePanzaBlanca      ,CDP.NoblePicados      ,CDP.NobleMGrasa      ,CDP.NobleAcidezGrasa      ,CDP.NobleVerdes      ,CDP.NobleGrado      ,CDP.NobleConforme      ,CDP.NobleACamara      ,CDP.Cosecha      ,CDP.HumedadDesnormalizada      ,CDP.Factor      ,CDP.IdFacturaImputada      ,CDP.PuntoVenta      ,CDP.SubnumeroVagon      ,CDP.TarifaFacturada      ,CDP.TarifaSubcontratista1      ,CDP.TarifaSubcontratista2      ,CDP.FechaArribo      ,CDP.Version      ,CDP.MotivoAnulacion " & _
"      ,CDP.NumeroSubfijo      ,CDP.IdEstablecimiento      ,CDP.EnumSyngentaDivision      ,CDP.Corredor2      ,CDP.IdUsuarioModifico      ,CDP.FechaModificacion      ,CDP.FechaEmision      ,CDP.EstaArchivada      ,CDP.ExcluirDeSubcontratistas      ,CDP.IdTipoMovimiento      ,CDP.IdClienteAFacturarle      ,CDP.SubnumeroDeFacturacion      ,CDP.AgregaItemDeGastosAdministrativos      ,CDP.CalidadGranosQuemados      ,CDP.CalidadGranosQuemadosBonifica_o_Rebaja      ,CDP.CalidadTierra      ,CDP.CalidadTierraBonifica_o_Rebaja      ,CDP.CalidadMermaChamico " & _
"      ,CDP.CalidadMermaChamicoBonifica_o_Rebaja      ,CDP.CalidadMermaZarandeo      ,CDP.CalidadMermaZarandeoBonifica_o_Rebaja      ,CDP.FueraDeEstandar      ,CDP.CalidadPuntaSombreada      ,CDP.CobraAcarreo      ,CDP.LiquidaViaje      ,CDP.IdClienteAuxiliar      ,CDP.CalidadDescuentoFinal      ,CDP.PathImagen      ,CDP.PathImagen2 " & _
"      ,CDP.AgrupadorDeTandaPeriodos      ,CDP.ClaveEncriptada      ,CDP.NumeroCartaEnTextoParaBusqueda      ,CDP.IdClienteEntregador      ,CDP.IdDetalleFactura      ,CDP.SojaSustentableCodCondicion      ,CDP.SojaSustentableCondicion      ,CDP.SojaSustentableNroEstablecimientoDeProduccion      ,CDP.IdClientePagadorFlete      ,CDP.SubnumeroVagonEnTextoParaBusqueda      ,CDP.IdCorredor2 " & _
"      ,CDP.Acopio1      ,CDP.Acopio2      ,CDP.Acopio3      ,CDP.Acopio4      ,CDP.Acopio5   ,CDP.Acopio6      ,CDP.AcopioFacturarleA      ,CDP.CalidadGranosDanadosRebaja      ,CDP.CalidadGranosExtranosRebaja ,  " & _
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
"			isnull(CLIVEN.Razonsocial,'') + isnull(' - ' + ACO1.Descripcion,'')  AS TitularDesc, " & _
"            isnull(CLIVEN.cuit,'') AS TitularCUIT, " & _
"			isnull(CLICO1.Razonsocial,'') + isnull(' - ' + ACO2.Descripcion,'')  AS IntermediarioDesc, " & _
"            isnull(CLICO1.cuit,'') AS IntermediarioCUIT, " & _
"			isnull(CLICO2.Razonsocial,'') + isnull(' - ' + ACO3.Descripcion,'')  AS RComercialDesc, " & _
"            isnull(CLICO2.cuit,'') AS RComercialCUIT, " & _
"			isnull(CLICOR.Nombre,'') AS CorredorDesc, " & _
"            isnull(CLICOR.cuit,'') AS CorredorCUIT, " & _
"			isnull(CLIENT.Razonsocial,'') + isnull(' - ' + ACO5.Descripcion,'')  AS DestinatarioDesc, " & _
"			isnull(CLIENTREG.Razonsocial,'') AS EntregadorDesc, " & _
"            isnull(CLIENT.cuit,'') AS DestinatarioCUIT, " & _
"			isnull(CLIAUX.Razonsocial,'') AS ClienteAuxiliarDesc, " & _
"			isnull(CLIAUX.cuit,'') + isnull(' - ' + ACO6.Descripcion,'')   AS ClienteAuxiliarCUIT, " & _
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
"            isnull(CLICOR2.cuit,'') AS CorredorCUIT2, " & _
"			isnull(CLIENTREG.cuit,'') AS EntregadorCUIT, " & _
"		isnull(LOCORI.CodigoAFIP,'') AS CodigoAFIP,  " & _
"		TieneRecibidorOficial,  " & _
"		EstadoRecibidor,  " & _
"		MotivoRechazo,  " & _
"		isnull(CLIENTACOND.Razonsocial,'') AS ClienteAcondicionadorDesc   " _
)







        Dim strFROM = _
        "   FROM    CartasDePorte CDP " & _
        "       LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente " & _
        "       LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente " & _
        "       LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente " & _
        "       LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar= CLIAUX.IdCliente " & _
        "       LEFT OUTER JOIN Clientes CLIENTREG ON CDP.IdClienteEntregador= CLIENTREG.IdCliente " & _
        "       LEFT OUTER JOIN Clientes CLIENTFLET ON CDP.IdClientePagadorFlete= CLIENTFLET.IdCliente " & _
        "       LEFT OUTER JOIN Clientes CLIENTACOND ON CDP.ClienteAcondicionador= CLIENTACOND.IdCliente " & _
        "       LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor " & _
        "       LEFT OUTER JOIN Vendedores CLICOR2 ON CDP.Corredor2 = CLICOR2.IdVendedor " & _
        "       LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente " & _
        "       LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente " & _
        "       LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente " & _
        "       LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo " & _
        "       LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad " & _
        "       LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista " & _
        "		LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer " & _
        "       LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & _
        "       LEFT OUTER JOIN Provincias PROVORI ON LOCORI.IdProvincia = PROVORI.IdProvincia " & _
        "       LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino " & _
        "       LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento " & _
        "       LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura " & _
        "       LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente " & _
        "       LEFT OUTER JOIN Partidos PARTORI ON LOCORI.IdPartido = PARTORI.IdPartido " & _
        "       LEFT OUTER JOIN Provincias PROVDEST ON LOCDES.IdProvincia = PROVDEST.IdProvincia " & _
        "       LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado " & _
        "       LEFT OUTER JOIN CartasPorteAcopios ACO1 ON ACO1.IdAcopio= CDP.Acopio1 " & _
        "       LEFT OUTER JOIN CartasPorteAcopios ACO2 ON ACO2.IdAcopio= CDP.Acopio2 " & _
        "       LEFT OUTER JOIN CartasPorteAcopios ACO6 ON ACO6.IdAcopio= CDP.Acopio6 " & _
        "       LEFT OUTER JOIN CartasPorteAcopios ACO3 ON ACO3.IdAcopio= CDP.Acopio3 " & _
        "       LEFT OUTER JOIN CartasPorteAcopios ACO5 ON ACO5.IdAcopio= CDP.Acopio5 "


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
                ErrHandler2.WriteError("GetListDataTableDinamicoConWHERE_2. Seguramente timeout. Aumentar el tiempo maximo de timeout o limitar la cantidad de renglones " & ex.ToString)
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

                ErrHandler2.WriteError(" GetListDataTableDinamicoConWHERE_2 llegó al máximo de renglones  " & strSQL)


                Dim tipo As String = ConfigurationManager.AppSettings("AvisoTipoDeSitioDesarrolloDebugTestReleaseExterno")

                MandarMailDeError("Count total   " & count & " " & usuario & ".  GetListDataTableDinamicoConWHERE_2 llegó al máximo de renglones en " & tipo & " " & strSQL)



            End If


            Return dt
        End If

    End Function



    Shared Function GetListDataTableDinamicoConWHERE_2_CadenaSQL_COUNT(ByVal SC As String, ByVal estado As CartaDePorteManager.enumCDPestado, _
                                                   ByVal strWHERE As String, bInsertarEnTablaTemporal As Boolean, _
                                                   Optional maxrows As Integer = 0) As String


        'lo que sea dinámico, lo tendré que migrar para evitar inyeccion

        If maxrows > 0 Then
            maxrows = Min(maxrows, _CONST_MAXROWS)
        Else
            maxrows = _CONST_MAXROWS
        End If

        'hace falta levantar la cantidad de filas que levanto, no teniendo paginacion?


        Dim strSQL = String.Format("  SELECT count(*) ")

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


        Return strSQL




    End Function


    Shared Function GetListDataTableDinamicoConWHERE_2_CadenaSQL(ByVal SC As String, ByVal estado As CartaDePorteManager.enumCDPestado, _
                                                       ByVal strWHERE As String, bInsertarEnTablaTemporal As Boolean, _
                                                       Optional maxrows As Integer = 0) As String

        'lo que sea dinámico, lo tendré que migrar para evitar inyeccion

        If maxrows > 0 Then
            maxrows = Min(maxrows, _CONST_MAXROWS)
        Else
            maxrows = _CONST_MAXROWS
        End If

        'hace falta levantar la cantidad de filas que levanto, no teniendo paginacion?


        Dim strSQL = String.Format("  SELECT TOP " & maxrows & _
      "  CDP.IdCartaDePorte, CDP.NumeroCartaDePorte, CDP.IdUsuarioIngreso, CDP.FechaIngreso, CDP.Anulada, CDP.IdUsuarioAnulo, CDP.FechaAnulacion, CDP.Observaciones, CDP.FechaTimeStamp, CDP.Vendedor, CDP.CuentaOrden1, CDP.CuentaOrden2, CDP.Corredor, CDP.Entregador, CDP.Procedencia, CDP.Patente, CDP.IdArticulo, CDP.IdStock, CDP.Partida, CDP.IdUnidad, CDP.IdUbicacion, CDP.Cantidad, CDP.Cupo, CDP.NetoProc, CDP.Calidad " & _
"      ,CDP.BrutoPto      ,CDP.TaraPto      ,CDP.NetoPto      ,CDP.Acoplado      ,CDP.Humedad      ,CDP.Merma      ,CDP.NetoFinal      ,CDP.FechaDeCarga      ,CDP.FechaVencimiento      ,CDP.CEE      ,CDP.IdTransportista      ,CDP.TransportistaCUITdesnormalizado      ,CDP.IdChofer      ,CDP.ChoferCUITdesnormalizado      ,CDP.CTG      ,CDP.Contrato      ,CDP.Destino      ,CDP.Subcontr1      ,CDP.Subcontr2      ,CDP.Contrato1 " & _
"      ,CDP.contrato2      ,CDP.KmARecorrer      ,CDP.Tarifa      ,CDP.FechaDescarga      ,CDP.Hora      ,CDP.NRecibo      ,CDP.CalidadDe      ,CDP.TaraFinal      ,CDP.BrutoFinal      ,CDP.Fumigada      ,CDP.Secada      ,CDP.Exporta      ,CDP.NobleExtranos      ,CDP.NobleNegros      ,CDP.NobleQuebrados      ,CDP.NobleDaniados      ,CDP.NobleChamico      ,CDP.NobleChamico2      ,CDP.NobleRevolcado      ,CDP.NobleObjetables      ,CDP.NobleAmohosados      ,CDP.NobleHectolitrico      ,CDP.NobleCarbon " & _
"      ,CDP.NoblePanzaBlanca      ,CDP.NoblePicados      ,CDP.NobleMGrasa      ,CDP.NobleAcidezGrasa      ,CDP.NobleVerdes      ,CDP.NobleGrado      ,CDP.NobleConforme      ,CDP.NobleACamara      ,CDP.Cosecha      ,CDP.HumedadDesnormalizada      ,CDP.Factor      ,CDP.IdFacturaImputada      ,CDP.PuntoVenta      ,CDP.SubnumeroVagon      ,CDP.TarifaFacturada      ,CDP.TarifaSubcontratista1      ,CDP.TarifaSubcontratista2      ,CDP.FechaArribo      ,CDP.Version      ,CDP.MotivoAnulacion " & _
"      ,CDP.NumeroSubfijo      ,CDP.IdEstablecimiento      ,CDP.EnumSyngentaDivision      ,CDP.Corredor2      ,CDP.IdUsuarioModifico      ,CDP.FechaModificacion      ,CDP.FechaEmision      ,CDP.EstaArchivada      ,CDP.ExcluirDeSubcontratistas      ,CDP.IdTipoMovimiento      ,CDP.IdClienteAFacturarle      ,CDP.SubnumeroDeFacturacion      ,CDP.AgregaItemDeGastosAdministrativos      ,CDP.CalidadGranosQuemados      ,CDP.CalidadGranosQuemadosBonifica_o_Rebaja      ,CDP.CalidadTierra      ,CDP.CalidadTierraBonifica_o_Rebaja      ,CDP.CalidadMermaChamico " & _
"      ,CDP.CalidadMermaChamicoBonifica_o_Rebaja      ,CDP.CalidadMermaZarandeo      ,CDP.CalidadMermaZarandeoBonifica_o_Rebaja      ,CDP.FueraDeEstandar      ,CDP.CalidadPuntaSombreada      ,CDP.CobraAcarreo      ,CDP.LiquidaViaje      ,CDP.IdClienteAuxiliar      ,CDP.CalidadDescuentoFinal      ,CDP.PathImagen      ,CDP.PathImagen2 " & _
"      ,CDP.AgrupadorDeTandaPeriodos      ,CDP.ClaveEncriptada      ,CDP.NumeroCartaEnTextoParaBusqueda      ,CDP.IdClienteEntregador      ,CDP.IdDetalleFactura      ,CDP.SojaSustentableCodCondicion      ,CDP.SojaSustentableCondicion      ,CDP.SojaSustentableNroEstablecimientoDeProduccion      ,CDP.IdClientePagadorFlete      ,CDP.SubnumeroVagonEnTextoParaBusqueda      ,CDP.IdCorredor2 " & _
"      ,CDP.Acopio1      ,CDP.Acopio2      ,CDP.Acopio3      ,CDP.Acopio4      ,CDP.Acopio5 ,CDP.Acopio6        ,CDP.AcopioFacturarleA      ,CDP.CalidadGranosDanadosRebaja      ,CDP.CalidadGranosExtranosRebaja , " & _
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
"            isnull(CLICOR2.cuit,'') AS CorredorCUIT2, " & _
"			isnull(CLIENTREG.cuit,'') AS EntregadorCUIT, " & _
"		isnull(LOCORI.CodigoAFIP,'') AS CodigoAFIP " _
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


        Return strSQL






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

        'ErrHandler2WriteErrorLogPronto(srr, )


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
            ErrHandler2.WriteError(ex)
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
            ErrHandler2.WriteError(ex)
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

        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim db As New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))


        'me traigo la lista de subcontratistas que usan esa lista de precios
        Dim lSubcontratistasParaActualizar = (From c In db.Clientes _
                                                From l In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = c.IdListaPrecios).DefaultIfEmpty _
                                                From pd In db.ListasPreciosDetalles.Where(Function(i) i.IdListaPrecios = l.IdListaPrecios).DefaultIfEmpty _
                                                Where c.IdListaPrecios = IdListaPrecio Select c.IdCliente, pd.PrecioCaladaLocal, pd.PrecioCaladaExportacion, pd.PrecioDescargaLocal, pd.PrecioDescargaExportacion, pd.PrecioVagonesBalanza, pd.PrecioVagonesCalada).ToList



        Dim sublista = (From i In lSubcontratistasParaActualizar Select i.IdCliente).ToList

        Dim aaa = (From cdp In db.CartasDePortes _
               Where _
                     (cdp.IdFacturaImputada Is Nothing Or cdp.IdFacturaImputada = 0 Or cdp.IdFacturaImputada = -1) _
                 And (cdp.Anulada <> "SI") _
                 And (sublista.Contains(cdp.Subcontr1) Or sublista.Contains(cdp.Subcontr2)) _
                )

        Debug.Print(aaa.Count)

        Dim q = aaa.ToList()





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
                        If If(cdp.SubnumeroVagon, 0) > 0 Then
                            cdp.TarifaSubcontratista1 = i.PrecioVagonesCalada
                            cdp.TarifaSubcontratista2 = i.PrecioVagonesBalanza
                        ElseIf cdp.Exporta = "SI" Then
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

        db.SaveChanges()

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
                ErrHandler2.WriteError(ex)
            End Try

            Try
                Dim dr2 = ListaPreciosManager.GetPreciosSubcontratistaPorIdCliente(SC, .Subcontr2)
                If Not IsNothing(dr2) Then
                    'dependiendo del combo, elijo PrecioCalada o PrecioDescarga(balanza)
                    Dim nombreColumna2 As String = IIf(.Contrato2, "PrecioCalada", "PrecioDescarga") & IIf(.Exporta, "Exportacion", "Local")
                    .TarifaSubcontratista2 = iisNull(dr2.Item(nombreColumna2), 0)
                End If

            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try
            '////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////
        End With
    End Sub



    Public Shared Function EsUnoDeLosClientesExportador(ByVal SC As String, ByVal myCartaDePorte As CartaDePorte) As Boolean
        '        * La magia quedaría así: el usuario llena la carta, y pone grabar...
        '*Si la carta usa un cliente exportador en Destinatario, Intermediario o Rte Comercial,
        '*entonces te hago de prepo una duplicacion de la carta
        '*La que queda como exportacion, tendrá el A Facturar con el dichoso cliente exportador
        '*Y la otra carta, la local, quedará para que le rellenen el A Facturar, por las fuerzas superiores

        Try


            If myCartaDePorte.Entregador > 0 AndAlso ClienteManager.GetItem(SC, myCartaDePorte.Entregador).EsClienteExportador = "SI" Then
                Return True
            End If
            If myCartaDePorte.CuentaOrden1 > 0 AndAlso ClienteManager.GetItem(SC, myCartaDePorte.CuentaOrden1).EsClienteExportador = "SI" Then
                Return True
            End If
            If myCartaDePorte.CuentaOrden2 > 0 AndAlso ClienteManager.GetItem(SC, myCartaDePorte.CuentaOrden2).EsClienteExportador = "SI" Then
                Return True
            End If





        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try
        Return False
    End Function



    Public Shared Function FacturarA_Automatico(ByVal SC As String, ByVal oCDP As CartaDePorte, ByRef ms As String) As Integer


        'Dim idclienteexportador As Integer

        'If myCartaDePorte.Entregador > 0 AndAlso ClienteManager.GetItem(SC, myCartaDePorte.Entregador).EsClienteExportador = "SI" Then
        '    idclienteexportador = myCartaDePorte.Entregador
        'End If
        'If myCartaDePorte.CuentaOrden1 > 0 AndAlso ClienteManager.GetItem(SC, myCartaDePorte.CuentaOrden1).EsClienteExportador = "SI" Then
        '    idclienteexportador = myCartaDePorte.CuentaOrden1
        'End If
        'If myCartaDePorte.CuentaOrden2 > 0 AndAlso ClienteManager.GetItem(SC, myCartaDePorte.CuentaOrden2).EsClienteExportador = "SI" Then
        '    idclienteexportador = myCartaDePorte.CuentaOrden2
        'End If


        'sssss()

        'CartasDePorteReglasDeFacturacion()

        Try

            Dim db As New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))

            Dim clis As New List(Of Integer)


            Dim q1 = db.CartasDePorteReglasDeFacturacions.Where(Function(x) x.IdCliente = oCDP.Titular And x.PuntoVenta = oCDP.PuntoVenta And x.SeLeFacturaCartaPorteComoTitular = "SI").FirstOrDefault

            If q1 IsNot Nothing Then clis.Add(oCDP.Titular)

            Dim q2 = db.CartasDePorteReglasDeFacturacions.Where(Function(x) x.IdCliente = oCDP.CuentaOrden1 And x.PuntoVenta = oCDP.PuntoVenta And x.SeLeFacturaCartaPorteComoIntermediario = "SI").FirstOrDefault
            If q2 IsNot Nothing Then clis.Add(oCDP.CuentaOrden1)


            Dim q3 = db.CartasDePorteReglasDeFacturacions.Where(Function(x) x.IdCliente = oCDP.CuentaOrden2 And x.PuntoVenta = oCDP.PuntoVenta And x.SeLeFacturaCartaPorteComoRemcomercial = "SI").FirstOrDefault

            If q3 IsNot Nothing Then clis.Add(oCDP.CuentaOrden2)


            Dim idequi As Integer = IdClienteEquivalenteDelIdVendedor(CLng(oCDP.Corredor), SC)
            Dim q4 = db.CartasDePorteReglasDeFacturacions.Where(Function(x) x.IdCliente = idequi _
                                                                    And x.PuntoVenta = oCDP.PuntoVenta And _
                                                                    x.SeLeFacturaCartaPorteComoDestinatario = "SI").FirstOrDefault
            If q4 IsNot Nothing Then clis.Add(idequi)

            If False Then ' el destinatario no lo reviso porque 
                Dim q5 = db.CartasDePorteReglasDeFacturacions.Where(Function(x) x.IdCliente = oCDP.Entregador And x.PuntoVenta = oCDP.PuntoVenta And x.SeLeFacturaCartaPorteComoDestinatario = "SI").FirstOrDefault

                If q5 IsNot Nothing Then Return q5.IdCliente
            End If

            If clis.Distinct.Count = 1 Then Return clis(0)

            If clis.Distinct.Count > 1 Then
                ms &= "No se pudo asignar el cliente a facturar automaticamente, clientes en conflicto ("
                For Each i In clis
                    ms &= NombreCliente(SC, i) & "  "
                Next
                ms &= ")"
            End If

            Return 0
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        Return 0




    End Function






    Public Shared Sub CrearleDuplicadaConEl_FacturarA_Indicado(ByVal SC As String, ByVal myCartaDePorte As CartaDePorte)
        '        * La magia quedaría así: el usuario llena la carta, y pone grabar...
        '*Si la carta usa un cliente exportador en Destinatario, Intermediario o Rte Comercial,
        '*entonces te hago de prepo una duplicacion de la carta
        '*La que queda como exportacion, tendrá el A Facturar con el dichoso cliente exportador
        '*Y la otra carta, la local, quedará para que le rellenen el A Facturar, por las fuerzas superiores
        ' efasdfasdf()

        Dim idclienteexportador As Integer

        If myCartaDePorte.Entregador > 0 AndAlso ClienteManager.GetItem(SC, myCartaDePorte.Entregador).EsClienteExportador = "SI" Then
            idclienteexportador = myCartaDePorte.Entregador
        End If
        If myCartaDePorte.CuentaOrden1 > 0 AndAlso ClienteManager.GetItem(SC, myCartaDePorte.CuentaOrden1).EsClienteExportador = "SI" Then
            idclienteexportador = myCartaDePorte.CuentaOrden1
        End If
        If myCartaDePorte.CuentaOrden2 > 0 AndAlso ClienteManager.GetItem(SC, myCartaDePorte.CuentaOrden2).EsClienteExportador = "SI" Then
            idclienteexportador = myCartaDePorte.CuentaOrden2
        End If




        'por más que pongas ByVal, un objeto se pasa por referencia creo. -Tendrías que sobrecargar el igual, o hacer un constructor que use una carta existente

        Dim tempid = myCartaDePorte.Id
        Dim tempidcli = IIf(myCartaDePorte.IdClienteAFacturarle = idclienteexportador, -1, myCartaDePorte.IdClienteAFacturarle)

        'anda mal en el alta de carta que cumpla estas condiciones (en la edicion anda bien).  
        'Está triplicando la carta, porque pasa dos veces por esta funcion con el Id=-1, y despues una vez más en el Save original


        myCartaDePorte.Id = -1
        myCartaDePorte.IdClienteAFacturarle = idclienteexportador
        myCartaDePorte.Exporta = True
        myCartaDePorte.SubnumeroDeFacturacion = 1


        Try
            'como evitar la recursion?
            CartaDePorteManager.Save(SC, myCartaDePorte, 0, "", False)
        Catch ex As Exception
            ErrHandler2.WriteError("ya existía un duplicado 1 probablemente")
            ErrHandler2.WriteError(ex) 'ya existía un duplicado probablemente
        End Try

        'y si este tempid es -1?

        myCartaDePorte.Id = tempid
        myCartaDePorte.IdClienteAFacturarle = tempidcli
        myCartaDePorte.Exporta = False
        myCartaDePorte.SubnumeroDeFacturacion = 0

        Try

            CartaDePorteManager.Save(SC, myCartaDePorte, 0, "", False)
        Catch ex As Exception
            ErrHandler2.WriteError("ya existía un duplicado 0 probablemente")
            ErrHandler2.WriteError(ex) 'ya existía un duplicado probablemente
        End Try



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

    'Function generarWHERE(ByRef sTituloFiltroUsado As String, ByVal estado As CartaDePorteManager.enumCDPestado,optional CriterioWHERE="todos") As String


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



    '        If estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas Then
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
            ErrHandler2.WriteError(ex)
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







    Shared Function GetListDataTableDinamicoConWHERE(ByVal SC As String, ByVal estado As CartaDePorteManager.enumCDPestado, ByVal strWHERE As String) As DataTable

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
"          CDP.PuntoVenta  as Sucursal, " & _
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
            Dim db As New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))
            'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
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
                .Acopio6 = If(oCarta.Acopio6, -1)

                .AcopioFacturarleA = If(oCarta.AcopioFacturarleA, -1)


                .CalidadGranosExtranosRebaja = iisNull(oCarta.CalidadGranosExtranosRebaja, 0)
                .CalidadGranosDanadosRebaja = iisNull(oCarta.CalidadGranosDanadosRebaja, 0)



                .CalidadGranosExtranosMerma = iisNull(oCarta.CalidadGranosExtranosMerma, 0)
                .CalidadQuebradosMerma = iisNull(oCarta.CalidadQuebradosMerma, 0)
                .CalidadDanadosMerma = iisNull(oCarta.CalidadDanadosMerma, 0)
                .CalidadChamicoMerma = iisNull(oCarta.CalidadChamicoMerma, 0)
                .CalidadRevolcadosMerma = iisNull(oCarta.CalidadRevolcadosMerma, 0)
                .CalidadObjetablesMerma = iisNull(oCarta.CalidadObjetablesMerma, 0)
                .CalidadAmohosadosMerma = iisNull(oCarta.CalidadAmohosadosMerma, 0)
                .CalidadPuntaSombreadaMerma = iisNull(oCarta.CalidadPuntaSombreadaMerma, 0)
                .CalidadHectolitricoMerma = iisNull(oCarta.CalidadHectolitricoMerma, 0)
                .CalidadCarbonMerma = iisNull(oCarta.CalidadCarbonMerma, 0)
                .CalidadPanzaBlancaMerma = iisNull(oCarta.CalidadPanzaBlancaMerma, 0)
                .CalidadPicadosMerma = iisNull(oCarta.CalidadPicadosMerma, 0)
                .CalidadVerdesMerma = iisNull(oCarta.CalidadVerdesMerma, 0)
                .CalidadQuemadosMerma = iisNull(oCarta.CalidadQuemadosMerma, 0)
                .CalidadTierraMerma = iisNull(oCarta.CalidadTierraMerma, 0)
                .CalidadZarandeoMerma = iisNull(oCarta.CalidadZarandeoMerma, 0)
                .CalidadDescuentoFinalMerma = iisNull(oCarta.CalidadDescuentoFinalMerma, 0)
                .CalidadHumedadMerma = iisNull(oCarta.CalidadHumedadMerma, 0)
                .CalidadGastosFumigacionMerma = iisNull(oCarta.CalidadGastosFumigacionMerma, 0)


                .CalidadQuebradosRebaja = iisNull(oCarta.CalidadQuebradosRebaja, 0)
                .CalidadChamicoRebaja = iisNull(oCarta.CalidadChamicoRebaja, 0)
                .CalidadRevolcadosRebaja = iisNull(oCarta.CalidadRevolcadosRebaja, 0)
                .CalidadObjetablesRebaja = iisNull(oCarta.CalidadObjetablesRebaja, 0)
                .CalidadAmohosadosRebaja = iisNull(oCarta.CalidadAmohosadosRebaja, 0)
                .CalidadPuntaSombreadaRebaja = iisNull(oCarta.CalidadPuntaSombreadaRebaja, 0)
                .CalidadHectolitricoRebaja = iisNull(oCarta.CalidadHectolitricoRebaja, 0)
                .CalidadCarbonRebaja = iisNull(oCarta.CalidadCarbonRebaja, 0)
                .CalidadPanzaBlancaRebaja = iisNull(oCarta.CalidadPanzaBlancaRebaja, 0)
                .CalidadPicadosRebaja = iisNull(oCarta.CalidadPicadosRebaja, 0)
                .CalidadVerdesRebaja = iisNull(oCarta.CalidadVerdesRebaja, 0)
                .CalidadQuemadosRebaja = iisNull(oCarta.CalidadQuemadosRebaja, 0)
                .CalidadTierraRebaja = iisNull(oCarta.CalidadTierraRebaja, 0)
                .CalidadZarandeoRebaja = iisNull(oCarta.CalidadZarandeoRebaja, 0)
                .CalidadDescuentoFinalRebaja = iisNull(oCarta.CalidadDescuentoFinalRebaja, 0)
                .CalidadHumedadRebaja = iisNull(oCarta.CalidadHumedadRebaja, 0)
                .CalidadGastosFumigacionRebaja = iisNull(oCarta.CalidadGastosFumigacionRebaja, 0)

                .CalidadHumedadResultado = iisNull(oCarta.CalidadHumedadResultado, 0)
                .CalidadGastosFumigacionResultado = iisNull(oCarta.CalidadGastosFumigacionResultado, 0)


                .TieneRecibidorOficial = (oCarta.TieneRecibidorOficial = "SI")
                .EstadoRecibidor = iisNull(oCarta.EstadoRecibidor, 0)
                .MotivoRechazo = iisNull(oCarta.MotivoRechazo, 0)
                .ClienteAcondicionador = iisNull(oCarta.ClienteAcondicionador, -1)

                .FacturarAManual = oCarta.FacturarA_Manual
                .EntregaSAP = oCarta.EntregaSAP


                Try

                    Dim oDet As ProntoMVC.Data.Models.CartasDePorteDetalle_EF = (From i In db.CartasDePorteDetalle_EF _
                                                        Where i.IdCartaDePorte = id _
                                                        And i.Campo = "CalidadGastoDeSecada"
                                                    ).SingleOrDefault

                    If oDet IsNot Nothing Then .CalidadGastoDeSecada = oDet.Valor Else .CalidadGastoDeSecada = 0
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try


                .CalidadGastoDeSecada = GetDetalle("CalidadGastoDeSecada", db, id)
                .CalidadGastoDeSecadaRebaja = GetDetalle("CalidadGastoDeSecadaRebaja", db, id)
                .CalidadGastoDeSecadaMerma = GetDetalle("CalidadGastoDeSecadaMerma", db, id)
                .TipoMermaGastoDeSecada = GetDetalle("TipoMermaGastoDeSecada", db, id)


                .CalidadMermaVolatil = GetDetalle("CalidadMermaVolatil", db, id)
                .CalidadMermaVolatilRebaja = GetDetalle("CalidadMermaVolatilRebaja", db, id)
                .CalidadMermaVolatilMerma = GetDetalle("CalidadMermaVolatilMerma", db, id)
                .TipoMermaVolatil = GetDetalle("TipoMermaVolatil", db, id)


                .CalidadFondoNidera = GetDetalle("CalidadFondoNidera", db, id)
                .CalidadFondoNideraRebaja = GetDetalle("CalidadFondoNideraRebaja", db, id)
                .CalidadFondoNideraMerma = GetDetalle("CalidadFondoNideraMerma", db, id)
                .TipoMermaFondoNidera = GetDetalle("TipoMermaFondoNidera", db, id)


                .CalidadMermaConvenida = GetDetalle("CalidadMermaConvenida", db, id)
                .CalidadMermaConvenidaRebaja = GetDetalle("CalidadMermaConvenidaRebaja", db, id)
                .CalidadMermaConvenidaMerma = GetDetalle("CalidadMermaConvenidaMerma", db, id)
                .TipoMermaConvenida = GetDetalle("TipoMermaConvenida", db, id)


                .CalidadTalCualVicentin = GetDetalle("CalidadTalCualVicentin", db, id)
                .CalidadTalCualVicentinRebaja = GetDetalle("CalidadTalCualVicentinRebaja", db, id)
                .CalidadTalCualVicentinMerma = GetDetalle("CalidadTalCualVicentinMerma", db, id)
                .TipoMermaTalCualVicentin = GetDetalle("TipoMermaTalCualVicentin", db, id)



            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

        End With

        'If Not (myCartaDePorte Is Nothing) AndAlso getCartaDePorteDetalles Then
        '    myCartaDePorte.Detalles = CartaDePorteItemDB.GetList(SC, id)
        'End If
        Return myCartaDePorte
    End Function


    Shared Function GetDetalle(nombrecampo As String, db As DemoProntoEntities, id As Long) As Decimal

        Try

            Dim oDet As ProntoMVC.Data.Models.CartasDePorteDetalle_EF = (From i In db.CartasDePorteDetalle_EF _
                                                Where i.IdCartaDePorte = id _
                                                And i.Campo = nombrecampo
                                            ).SingleOrDefault

            If oDet IsNot Nothing Then
                Return oDet.Valor
            Else
                Return 0
            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

    End Function

    Shared Sub SetDetalle(nombrecampo As String, db As DemoProntoEntities, id As Long, valor As Decimal)




        Try

            Dim oDet As ProntoMVC.Data.Models.CartasDePorteDetalle_EF = (From i In db.CartasDePorteDetalle_EF _
                                                Where i.IdCartaDePorte = id _
                                                And i.Campo = nombrecampo
                                            ).SingleOrDefault
            If IsNothing(oDet) Then
                oDet = New ProntoMVC.Data.Models.CartasDePorteDetalle_EF
                oDet.IdCartaDePorte = id
                oDet.Campo = nombrecampo
                oDet.Valor = valor
                'acá había un insertonsubmit
                db.CartasDePorteDetalle_EF.Add(oDet)
                'db.SaveChanges()
            Else
                oDet.Valor = valor
            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try



    End Sub



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


        'Dim db As New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))
        ' hay que revisar por qué no se banca el demoprontoentities
        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))        ' hay que revisar por qué no se banca el demoprontoentities

        Dim familia = (From e In db.CartasDePortes _
                                      Where e.NumeroCartaDePorte.GetValueOrDefault = NumeroCartaDePorte _
                                            And e.SubnumeroVagon.GetValueOrDefault = SubNumeroVagon _
                                            Order By e.FechaAnulacion Descending _
                                      Select e).ToList()


        Dim sss = familia.Where(Function(x) x.SubnumeroDeFacturacion = SubnumeroFacturacion).FirstOrDefault


        If familia.Count = 0 Then Return New CartaDePorte
        If sss IsNot Nothing Then Return CartaDePorteManager.GetItem(SC, sss.IdCartaDePorte)
        If SubnumeroFacturacion > 0 Then Return New CartaDePorte
        If familia.Count = 1 Then Return CartaDePorteManager.GetItem(SC, familia(0).IdCartaDePorte)

        ErrHandler2.WriteAndRaiseError("Ya existe una carta con ese número y vagon: " & _
                                       NumeroCartaDePorte & " " & SubNumeroVagon & " " & SubnumeroFacturacion & _
                                       ".  Puede ser una con otro Subnumero de facturacion. " & familia.Count & " " & sss.IdCartaDePorte & _
                                       " Estas haciendo altas usando el -1 en SubnumeroDeFacturacion? estas buscando con -1 cuando solo hay con 0?")







        If ds.Tables(0).Rows.Count = 1 Then


            'devuelvo la primera que encontré -está MAL. si hay mas de uno, es un error
            Dim myCartaDePorte As CartaDePorte
            myCartaDePorte = CartaDePorteManager.GetItem(SC, ds.Tables(0).Rows(0).Item("IdCartaDePorte"))

            'es un error. si estoy buscando un subnumero de facturacion especifico, me va a cagar
            If SubnumeroFacturacion > 0 And myCartaDePorte.SubnumeroDeFacturacion <> SubnumeroFacturacion Then Return New CartaDePorte

            Return myCartaDePorte

        ElseIf ds.Tables(0).Rows.Count > 1 Then
            'OJO:  puede ser una con otro subnumerodefacturacion...
            ErrHandler2.WriteAndRaiseError("Ya existe una carta con ese número y vagon: " & NumeroCartaDePorte & " " & SubNumeroVagon & ".  Puede ser una con otro Subnumero de facturacion ")




            '            __________________________()

            '            Log(Entry)
            '04/11/2013 17:45:34
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=-1. Error Message:System.Exception
            'Application-defined or object-defined error.
            '   at Microsoft.VisualBasic.ErrObject.Raise(Int32 Number, Object Source, Object Description, Object HelpFile, Object HelpContext)
            '   at ErrHandler2.WriteAndRaiseError(String errorMessage) in E:\Backup\BDL\ProntoWeb\BusinessObject\ErrHandler2.vb:line 120
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
        Return True 'tuve problemas

        Dim ultimoTimeStamp As Long = BitConverter.ToInt64(EntidadManager.ExecDinamico(SC, "SELECT TOP 1 FechaTimeStamp from CartasDePorte where idCartaDePorte=" & id).Rows(0).Item(0), 0)

        Return (ultimoTimeStamp = timeStamp)
    End Function



    Shared Function IdFacturaImputadaEnLaBase(ByVal SC As String, id As Long) As Integer?


        Dim db As New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))

        Dim oCarta = (From i In db.CartasDePortes Where i.IdCartaDePorte = id).SingleOrDefault

        Return oCarta.IdFacturaImputada


    End Function



    Shared Function DesfacturarCarta(ByVal SC As String, myCartaDePorte As CartaDePorte, usuario As String)

        Try
            LogPronto(SC, myCartaDePorte.Id, "Se desimputa la carta id" & myCartaDePorte.Id & " de la factura id" & myCartaDePorte.IdFacturaImputada, usuario, , , , , myCartaDePorte.IdFacturaImputada)
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try


        Using db = New LinqCartasPorteDataContext(Encriptar(SC))
            Dim cp = (From i In db.CartasDePortes Where i.IdCartaDePorte = myCartaDePorte.Id).Single
            cp.IdFacturaImputada = 0
            db.SubmitChanges()
            'MsgBoxAjax(Me, "Desfacturada con éxito")
        End Using

    End Function


    <DataObjectMethod(DataObjectMethodType.Update, True)> _
    Public Shared Function Save(ByVal SC As String, ByVal myCartaDePorte As CartaDePorte, ByVal IdUsuario As Integer, ByVal NombreUsuario As String, Optional ByVal bCopiarDuplicados As Boolean = True, Optional ByRef ms As String = "") As Integer
        Dim CartaDePorteId As Integer

        'Dim myTransactionScope As TransactionScope = New TransactionScope
        Try


            If Not IsValid(SC, myCartaDePorte, ms) Then
                ErrHandler2.WriteError(ms)
                Return -1
            End If




            With myCartaDePorte


                If .SubnumeroDeFacturacion < 0 Then .SubnumeroDeFacturacion = 0 'ver si asi podemos dejar de usar el -1



                If .Id <= 0 Then
                    .FechaIngreso = Now
                    .IdUsuarioIngreso = IdUsuario

                Else
                    'If .IdFacturaImputadaOriginal Then
                    If .IdFacturaImputada <= 0 Then

                        'creo que en el caso de la factura Id=85806 no se pasó por estas lineas, porque supongo que cflores tenía
                        '       .IdFacturaImputada  en 0  mientras la mandaron a facturar, y al grabarla cflores evidentemente no pasaría
                        '   por acá. No sería conveniente entonces llamar a CopiarEnHistorico siempre? o directamente impedir que se libere 
                        ' la IdFacturaImputada en este metodo?

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

                        'no permitir desimputar usando el Save. Que se use otro método especifico para eso (DesfacturarCarta())


                        If .IdFacturaImputada <> IdFacturaImputadaEnLaBase(SC, .Id) Then

                            Throw New Exception("Otro usuario actualizó la carta mientras vos la editabas. Por favor, volvé a cargar la carta y hacé nuevamente las modificaciones. Es posible que no esté más disponible para editar")
                        End If

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


                Dim db As New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))

                Try

                    'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
                    'Dim db As New ProntoMVC.Data.Models.DemoProntoEntities(Encriptar(SC))


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
                    oCarta.Acopio6 = IIf(.Acopio6 <= 0, Nothing, .Acopio6)
                    oCarta.AcopioFacturarleA = .AcopioFacturarleA

                    oCarta.ClaveEncriptada = EntidadManager.encryptQueryString(CartaDePorteId)


                    oCarta.SojaSustentableCodCondicion = .SojaSustentableCodCondicion
                    oCarta.SojaSustentableCondicion = .SojaSustentableCondicion
                    oCarta.SojaSustentableNroEstablecimientoDeProduccion = .SojaSustentableNroEstablecimientoDeProduccion



                    oCarta.NumeroCartaEnTextoParaBusqueda = oCarta.NumeroCartaDePorte & " " & oCarta.NumeroSubfijo & "-" & oCarta.SubnumeroVagon
                    oCarta.SubnumeroVagonEnTextoParaBusqueda = oCarta.SubnumeroVagon


                    oCarta.CalidadGranosExtranosRebaja = .CalidadGranosExtranosRebaja
                    oCarta.CalidadGranosDanadosRebaja = .CalidadGranosDanadosRebaja




                    oCarta.CalidadGranosExtranosMerma = .CalidadGranosExtranosMerma
                    oCarta.CalidadQuebradosMerma = .CalidadQuebradosMerma
                    oCarta.CalidadDanadosMerma = .CalidadDanadosMerma
                    oCarta.CalidadChamicoMerma = .CalidadChamicoMerma
                    oCarta.CalidadRevolcadosMerma = .CalidadRevolcadosMerma
                    oCarta.CalidadObjetablesMerma = .CalidadObjetablesMerma
                    oCarta.CalidadAmohosadosMerma = .CalidadAmohosadosMerma
                    oCarta.CalidadPuntaSombreadaMerma = .CalidadPuntaSombreadaMerma
                    oCarta.CalidadHectolitricoMerma = .CalidadHectolitricoMerma
                    oCarta.CalidadCarbonMerma = .CalidadCarbonMerma
                    oCarta.CalidadPanzaBlancaMerma = .CalidadPanzaBlancaMerma
                    oCarta.CalidadPicadosMerma = .CalidadPicadosMerma
                    oCarta.CalidadVerdesMerma = .CalidadVerdesMerma
                    oCarta.CalidadQuemadosMerma = .CalidadQuemadosMerma
                    oCarta.CalidadTierraMerma = .CalidadTierraMerma
                    oCarta.CalidadZarandeoMerma = .CalidadZarandeoMerma
                    oCarta.CalidadDescuentoFinalMerma = .CalidadDescuentoFinalMerma
                    oCarta.CalidadHumedadMerma = .CalidadHumedadMerma
                    oCarta.CalidadGastosFumigacionMerma = .CalidadGastosFumigacionMerma


                    oCarta.CalidadQuebradosRebaja = .CalidadQuebradosRebaja
                    oCarta.CalidadChamicoRebaja = .CalidadChamicoRebaja
                    oCarta.CalidadRevolcadosRebaja = .CalidadRevolcadosRebaja
                    oCarta.CalidadObjetablesRebaja = .CalidadObjetablesRebaja
                    oCarta.CalidadAmohosadosRebaja = .CalidadAmohosadosRebaja
                    oCarta.CalidadPuntaSombreadaRebaja = .CalidadPuntaSombreadaRebaja
                    oCarta.CalidadHectolitricoRebaja = .CalidadHectolitricoRebaja
                    oCarta.CalidadCarbonRebaja = .CalidadCarbonRebaja
                    oCarta.CalidadPanzaBlancaRebaja = .CalidadPanzaBlancaRebaja
                    oCarta.CalidadPicadosRebaja = .CalidadPicadosRebaja
                    oCarta.CalidadVerdesRebaja = .CalidadVerdesRebaja
                    oCarta.CalidadQuemadosRebaja = .CalidadQuemadosRebaja
                    oCarta.CalidadTierraRebaja = .CalidadTierraRebaja
                    oCarta.CalidadZarandeoRebaja = .CalidadZarandeoRebaja
                    oCarta.CalidadDescuentoFinalRebaja = .CalidadDescuentoFinalRebaja
                    oCarta.CalidadHumedadRebaja = .CalidadHumedadRebaja
                    oCarta.CalidadGastosFumigacionRebaja = .CalidadGastosFumigacionRebaja

                    oCarta.CalidadHumedadResultado = .CalidadHumedadResultado
                    oCarta.CalidadGastosFumigacionResultado = .CalidadGastosFumigacionResultado


                    oCarta.TieneRecibidorOficial = IIf(.TieneRecibidorOficial, "SI", "NO")
                    oCarta.EstadoRecibidor = .EstadoRecibidor
                    oCarta.MotivoRechazo = .MotivoRechazo
                    oCarta.ClienteAcondicionador = .ClienteAcondicionador

                    oCarta.FacturarA_Manual = .FacturarAManual

                    oCarta.EntregaSAP = .EntregaSAP
                    'Try

                    '    Dim oDet As CartasDePorteDetalle = (From i In db.CartasDePorteDetalles _
                    '                                        Where i.IdCartaDePorte = CartaDePorteId _
                    '                                        And i.Campo = "CalidadGastoDeSecada"
                    '                                    ).SingleOrDefault
                    '    If IsNothing(oDet) Then
                    '        oDet = New CartasDePorteDetalle
                    '        oDet.IdCartaDePorte = CartaDePorteId
                    '        oDet.Campo = "CalidadGastoDeSecada"
                    '        oDet.Valor = .CalidadGastoDeSecada
                    '        db.CartasDePorteDetalles.InsertOnSubmit(oDet)
                    '    Else
                    '        oDet.Valor = .CalidadGastoDeSecada
                    '    End If
                    'Catch ex As Exception
                    '    ErrHandler2.WriteError(ex)
                    'End Try



                    SetDetalle("CalidadGastoDeSecada", db, CartaDePorteId, .CalidadGastoDeSecada)
                    SetDetalle("CalidadGastoDeSecadaRebaja", db, CartaDePorteId, .CalidadGastoDeSecadaRebaja)
                    SetDetalle("CalidadGastoDeSecadaMerma", db, CartaDePorteId, .CalidadGastoDeSecadaMerma)
                    SetDetalle("TipoMermaGastoDeSecada", db, CartaDePorteId, .TipoMermaGastoDeSecada)


                    SetDetalle("CalidadMermaVolatil", db, CartaDePorteId, .CalidadMermaVolatil)
                    SetDetalle("CalidadMermaVolatilRebaja", db, CartaDePorteId, .CalidadMermaVolatilRebaja)
                    SetDetalle("CalidadMermaVolatilMerma", db, CartaDePorteId, .CalidadMermaVolatilMerma)
                    SetDetalle("TipoMermaVolatil", db, CartaDePorteId, .TipoMermaVolatil)


                    SetDetalle("CalidadFondoNidera", db, CartaDePorteId, .CalidadFondoNidera)
                    SetDetalle("CalidadFondoNideraRebaja", db, CartaDePorteId, .CalidadFondoNideraRebaja)
                    SetDetalle("CalidadFondoNideraMerma", db, CartaDePorteId, .CalidadFondoNideraMerma)
                    SetDetalle("TipoMermaFondoNidera", db, CartaDePorteId, .TipoMermaFondoNidera)


                    SetDetalle("CalidadMermaConvenida", db, CartaDePorteId, .CalidadMermaConvenida)
                    SetDetalle("CalidadMermaConvenidaRebaja", db, CartaDePorteId, .CalidadMermaConvenidaRebaja)
                    SetDetalle("CalidadMermaConvenidaMerma", db, CartaDePorteId, .CalidadMermaConvenidaMerma)
                    SetDetalle("TipoMermaConvenida", db, CartaDePorteId, .TipoMermaConvenida)


                    SetDetalle("CalidadTalCualVicentin", db, CartaDePorteId, .CalidadTalCualVicentin)
                    SetDetalle("CalidadTalCualVicentinRebaja", db, CartaDePorteId, .CalidadTalCualVicentinRebaja)
                    SetDetalle("CalidadTalCualVicentinMerma", db, CartaDePorteId, .CalidadTalCualVicentinMerma)
                    SetDetalle("TipoMermaTalCualVicentin", db, CartaDePorteId, .TipoMermaTalCualVicentin)












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
                                duplicados(0).SubnumeroDeFacturacion = 0 '-1
                                duplicados(0).ConDuplicados = 0
                            End If
                        Else
                            'si no es una anulacion, entonces le paso normalmente a su familia los cambios
                            oCarta.ConDuplicados = duplicados.Count

                            Try
                                For Each c In duplicados
                                    c.ConDuplicados = duplicados.Count
                                    CopiarCarta(oCarta, c)
                                    'db.CartasDePortes.
                                    db.SaveChanges()
                                Next

                            Catch ex As Exception

                                ErrHandler2.WriteError(ex)

                            End Try

                        End If
                    Else
                        ' myCartaDePorte.ConDuplicados = 0
                    End If




                    db.SaveChanges()

                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                    MandarMailDeError("Error al grabar carta con linq - " & ex.ToString)
                End Try






                If .Exporta And False Then 'por ahora, desactivar los movimientos automaticos. El informe tambien revisa la tabla de Cartas
                    CDPStockMovimientoManager.Save(SC, CartaDePorteId, .Titular, .Entregador, .IdArticulo, .NetoFinalIncluyendoMermas, True, .Destino)
                End If



                If .Anulada = "SI" Then
                    'si de la familia solo queda una sin rechazar, ponela como original independiente (o sea, subnumerodefacturacion=-1)
                    Dim duplicados = ( _
                                From e In db.CartasDePortes _
                                Where e.NumeroCartaDePorte = .NumeroCartaDePorte _
                                And e.SubnumeroVagon = .SubnumeroVagon _
                                 And e.IdCartaDePorte <> CartaDePorteId _
                                 And e.Anulada <> "SI").AsEnumerable

                    If duplicados.Count = 1 Then
                        duplicados(0).SubnumeroDeFacturacion = 0 'esto es un tema, porque si anulás el original, un duplicado pasa a ser el original, y te queda el link a los dos
                        duplicados(0).ConDuplicados = 1
                        db.SaveChanges()
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
                If False And EsUnoDeLosClientesExportador(SC, myCartaDePorte) Then
                    If myCartaDePorte.Id = -1 And myCartaDePorte.SubnumeroDeFacturacion = -1 Then myCartaDePorte.SubnumeroDeFacturacion = 0
                    myCartaDePorte.Id = CartaDePorteId
                    CrearleDuplicadaConEl_FacturarA_Indicado(SC, myCartaDePorte)

                    'al original hay que marcarle el FacturarA como usando el automatico
                    myCartaDePorte.IdClienteAFacturarle = FacturarA_Automatico(SC, myCartaDePorte, ms)



                    Dim db As New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))
                    Dim oCarta = (From i In db.CartasDePortes Where i.IdCartaDePorte = CartaDePorteId).SingleOrDefault
                    oCarta.IdClienteAFacturarle = myCartaDePorte.IdClienteAFacturarle
                    db.SaveChanges()
                End If
            End If

            '                      La cosa quedaría así:

            'Si se duplica una carta de porte y en una copia está el tilde y en otra no:

            '* En la que tiene el tilde -> FacturarAExplicito = Destinatario
            '* En la que no tiene el tilde -> FacturarAExplicito = Cliente a determinar según los tildes. Si no se puede determinar porque mas de uno cumple con la regla, quedará vacío y a cargar por el cliente

            'Casos en los que no llenar el FacturarAExplicito:
            '* Si está triplicada
            '* Si está duplicada y ninguna tiene tilde



            VerSiSeEstaCreandoUnDuplicadoYSuOriginalEsExportador(myCartaDePorte, SC, CartaDePorteId, ms)






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
                ErrHandler2.WriteError(ex)
            End Try


            'myCartaDePorte.FechaTimeStamp = TraerUltimoTimeStamp(SC, myCartaDePorte.Id)
            myCartaDePorte.FechaTimeStamp = TraerUltimoTimeStamp(SC, CartaDePorteId) 'si está haciendo un duplicado, el id del objeto es -1
            myCartaDePorte.Id = CartaDePorteId




            'myTransactionScope.Complete()
            'ContextUtil.SetComplete()
            Return CartaDePorteId
        Catch ex As Exception
            'ContextUtil.SetAbort()
            ErrHandler2.WriteError(ex)
            Debug.Print(ex.ToString)
            Throw New ApplicationException("Error en la grabacion " + ex.ToString, ex)
            'Return -1
        Finally
            'CType(myTransactionScope, IDisposable).Dispose()
        End Try
        Return myCartaDePorte.Id
    End Function


    Shared Sub VerSiSeEstaCreandoUnDuplicadoYSuOriginalEsExportador(cartaActual As CartaDePorte, SC As String, CartaDePorteId As Long, ByRef ms As String, Optional bSoloValidar As Boolean = False)



        Dim db As New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))

        Dim familia = ( _
                        From e In db.CartasDePortes _
                        Where e.NumeroCartaDePorte = cartaActual.NumeroCartaDePorte _
                        And e.SubnumeroVagon = cartaActual.SubnumeroVagon _
                         And e.IdCartaDePorte <> CartaDePorteId _
                         And e.Anulada <> "SI").AsEnumerable



        If familia.Count <> 1 Then Return 'tienen que ser dos



        Dim cartaLaOtra = CartaDePorteManager.GetItem(SC, familia(0).IdCartaDePorte)

        If Not (cartaActual.Exporta Xor cartaLaOtra.Exporta) Then Return




        Dim cartaExportadora As CartaDePorte
        Dim cartaNoExportadora As CartaDePorte
        If cartaActual.Exporta Then
            cartaExportadora = cartaActual
            cartaNoExportadora = cartaLaOtra
        Else
            cartaExportadora = cartaLaOtra
            cartaNoExportadora = cartaActual
        End If



        If cartaActual.Id = -1 And cartaActual.SubnumeroDeFacturacion = -1 Then cartaActual.SubnumeroDeFacturacion = 0
        cartaActual.Id = CartaDePorteId



        '///////////////////////////////////////////////////////////////////////////////////
        '* En la que tiene el tilde -> FacturarAExplicito = Destinatario
        '///////////////////////////////////////////////////////////////////////////////////

        'no permitir poner un valor en blanco si ya hay un valor en el idclienteafacturarle
        If Not (cartaExportadora.IdClienteAFacturarle > 0 And cartaExportadora.Entregador <= 0) And Not cartaExportadora.FacturarAManual Then
            cartaExportadora.IdClienteAFacturarle = cartaExportadora.Entregador
            cartaExportadora.AcopioFacturarleA = cartaExportadora.Acopio5
        End If


        '///////////////////////////////////////////////////////////////////////////////////
        '* En la que no tiene el tilde -> FacturarAExplicito = Cliente a determinar según los tildes. Si no se puede 
        'determinar porque mas de uno cumple con la regla, quedará vacío y a cargar por el cliente
        '///////////////////////////////////////////////////////////////////////////////////

        'no permitir poner un valor en blanco si ya hay un valor en el idclienteafacturarle  
        Dim ms2 As String
        If cartaNoExportadora.IdClienteAFacturarle <= 0 And Not cartaNoExportadora.FacturarAManual Then
            Dim idauto = FacturarA_Automatico(SC, cartaNoExportadora, ms2)
            If Not (cartaNoExportadora.IdClienteAFacturarle > 0 And idauto <= 0) Then
                cartaNoExportadora.IdClienteAFacturarle = idauto

                Dim l = New List(Of Integer)
                l.Add(cartaNoExportadora.Acopio1)
                l.Add(cartaNoExportadora.Acopio2)
                l.Add(cartaNoExportadora.Acopio3)
                If l.Where(Function(x) x > 0).Distinct().Count = 1 Then
                    cartaNoExportadora.AcopioFacturarleA = l.Where(Function(x) x > 0).Distinct().First
                ElseIf l.Where(Function(x) x > 0).Distinct().Count > 1 Then
                    cartaNoExportadora.IdClienteAFacturarle = 0
                    'ms &= "No se pudo elegir automaticamente el acopio del cliente a facturale la carta no exportadora" & vbCrLf
                End If
            End If
        End If

        'ms &= "Tirar mensaje de refrescar el formulario original"


        If Not bSoloValidar Then
            Dim oCarta = (From i In db.CartasDePortes Where i.IdCartaDePorte = cartaLaOtra.Id).SingleOrDefault
            oCarta.IdClienteAFacturarle = cartaLaOtra.IdClienteAFacturarle
            oCarta.AcopioFacturarleA = cartaLaOtra.AcopioFacturarleA

            Dim oCarta2 = (From i In db.CartasDePortes Where i.IdCartaDePorte = cartaActual.Id).SingleOrDefault
            oCarta2.IdClienteAFacturarle = cartaActual.IdClienteAFacturarle
            oCarta2.AcopioFacturarleA = cartaActual.AcopioFacturarleA

            db.SaveChanges()
        End If

    End Sub




    Shared Sub CopiarCarta(ByVal orig As ProntoMVC.Data.Models.CartasDePorte, ByRef dest As ProntoMVC.Data.Models.CartasDePorte)




        Dim sourceProps() As System.Reflection.PropertyInfo = orig.GetType().GetProperties()
        Dim destinationProps() As System.Reflection.PropertyInfo = dest.GetType().GetProperties()

        For Each sourceProp As System.Reflection.PropertyInfo In sourceProps

            Dim column As System.Data.Linq.Mapping.ColumnAttribute = DirectCast(Attribute.GetCustomAttribute(sourceProp, GetType(System.Data.Linq.Mapping.ColumnAttribute)), System.Data.Linq.Mapping.ColumnAttribute)

            If sourceProp.Name = "IdCartaDePorte" Then Continue For

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

            If sourceProp.Name = "Acopio1" Then Continue For
            If sourceProp.Name = "Acopio2" Then Continue For
            If sourceProp.Name = "Acopio3" Then Continue For
            If sourceProp.Name = "Acopio4" Then Continue For
            If sourceProp.Name = "Acopio5" Then Continue For
            If sourceProp.Name = "Acopio6" Then Continue For
            If sourceProp.Name = "AcopioFacturarleA" Then Continue For

            If sourceProp.Name = "FacturarA_Manual" Then Continue For



            '       If (column IsNot Nothing AndAlso Not column.IsPrimaryKey) Then

            For Each destinationProp As System.Reflection.PropertyInfo In destinationProps


                If sourceProp.Name = destinationProp.Name And destinationProp.CanWrite Then

                    destinationProp.SetValue(dest, sourceProp.GetValue(orig, Nothing), Nothing)

                    Exit For

                End If

            Next

            'End If

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
        Dim titular, destinatario, intermediario, corredor, remitcomercial As ClienteNuevo
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
            ErrHandler2.WriteError(ex)
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


    Shared Function UsaClientesQueEstanBloqueadosPorCobranzas(ByVal SC As String, ByVal myCartaDePorte As CartaDePorte, Optional ByRef ms As String = "") As Boolean
        Dim titular, destinatario, intermediario, corredor, remitcomercial As ClienteNuevo
        titular = ClienteManager.GetItem(SC, myCartaDePorte.Titular)
        destinatario = ClienteManager.GetItem(SC, myCartaDePorte.Entregador)
        intermediario = ClienteManager.GetItem(SC, myCartaDePorte.CuentaOrden1)
        corredor = ClienteManager.GetItem(SC, BuscaIdClientePreciso(EntidadManager.NombreVendedor(SC, myCartaDePorte.Corredor), SC))
        remitcomercial = ClienteManager.GetItem(SC, myCartaDePorte.CuentaOrden2)

        If myCartaDePorte.Titular > 0 AndAlso titular.DeshabilitadoPorCobranzas = "NO" Then
            ms += " " & titular.RazonSocial
        End If

        'http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=14610
        'El bloqueo para clientes que no están habilitado por cobranzas, debe controlar unicamente si el cliente está en la posición de Titular

        If False Then
            If myCartaDePorte.Entregador > 0 AndAlso destinatario.DeshabilitadoPorCobranzas = "NO" Then
                ms += " " & destinatario.RazonSocial
            End If


            If myCartaDePorte.CuentaOrden1 > 0 AndAlso intermediario.DeshabilitadoPorCobranzas = "NO" Then
                ms += " " & intermediario.RazonSocial
            End If

            Try
                If Not IsNothing(corredor) AndAlso corredor.DeshabilitadoPorCobranzas = "NO" Then
                    ms += " " & corredor.RazonSocial
                End If
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try


            If myCartaDePorte.CuentaOrden2 > 0 AndAlso remitcomercial.DeshabilitadoPorCobranzas = "NO" Then
                ms += " " & remitcomercial.RazonSocial
            End If
        End If



        If ms = "" Then
            Return False
        Else
            Return True
        End If

    End Function


    Public Shared Function IsValid(ByVal SC As String, ByRef myCartaDePorte As CartaDePorte, Optional ByRef ms As String = "", Optional ByRef sWarnings As String = "") As Boolean 'esta funcion no solo está validando, tambien corrige cosas menores...

        With myCartaDePorte
            'validarUnicidad()

            If iisNull(.SubnumeroVagon, 0) < 0 Then
                ms &= "El numero de vagón es menor que 0"
                ms &= vbCrLf   'return false
            End If

            'si manotearon la unicidad (numerocdp, vagon) tambien debería loguearse el cambio (lo ideal sería que no pudiesen cambiarlo...)
            'si manotearon la unicidad (numerocdp, vagon) tambien debería loguearse el cambio (lo ideal sería que no pudiesen cambiarlo...)
            'si manotearon la unicidad (numerocdp, vagon) tambien debería loguearse el cambio (lo ideal sería que no pudiesen cambiarlo...)
            'si manotearon la unicidad (numerocdp, vagon) tambien debería loguearse el cambio (lo ideal sería que no pudiesen cambiarlo...)



            'If iisNull(.NumeroCartaDePorte, 0) < 100000000 Or iisNull(.NumeroCartaDePorte, 0) > 9999999999 Then
            '    ms &= "El número de CDP debe tener 9 o 10 dígitos"
            '    ms &=vbCrLf   'return false
            'End If

            'If .NumeroCartaDePorte > 1999999999 Then ' > Int32.MaxValue Then
            '    ms &= "El número de CDP debe ser menor que 2.000.000.000"
            '    ms &=vbCrLf   'return false
            'End If


            Dim cdp As Pronto.ERP.BO.CartaDePorte
            Try
                cdp = CartaDePorteManager.GetItemPorNumero(SC, .NumeroCartaDePorte, .SubnumeroVagon, 0)

                If cdp.Id <> -1 And myCartaDePorte.SubnumeroDeFacturacion < 1 Then 'ya existe ese numero
                    If .Id = -1 Then 'estoy haciendo un alta
                        ms &= "El numero/vagon ya existe, " & cdp.NumeroCartaDePorte & "/" & cdp.SubnumeroVagon
                        ms &= vbCrLf
                    Else
                        If .Id <> cdp.Id Then 'esta editando esa ahora? si no...
                            ms &= "El numero/vagon ya existe, " & cdp.NumeroCartaDePorte & "/" & cdp.SubnumeroVagon
                            ms &= vbCrLf
                        End If
                    End If
                End If
            Catch ex As Exception
                'a veces llega acá porque ya existe una pero con distinto subnumero de facturacion
                ErrHandler2.WriteError(ex)
            End Try






            If IsNothing(.FechaArribo) Or .FechaArribo = #12:00:00 AM# Then
                ms &= "Falta la fecha de arribo"
                ms &= vbCrLf   'return false
            End If

            If iisNull(.FechaDescarga, #12:00:00 AM#) <> #12:00:00 AM# Then
                If iisNull(.FechaDescarga) < iisNull(.FechaArribo) Then
                    ms &= "La fecha de la descarga es anterior a la de arribo"
                    ms &= vbCrLf   'return false
                End If
            End If


            If IsNothing(.Cosecha) Or .Cosecha = "" Or .Cosecha = "-" Then
                ms &= "Falta la cosecha"
                ms &= vbCrLf   'return false
            End If



            If EsUnoDeLosClientesExportador(SC, myCartaDePorte) And .SubnumeroDeFacturacion < 0 Then
                sWarnings &= "Se usará automáticamente un duplicado para facturarle al cliente exportador" & vbCrLf
            End If




            If .Id > 0 Then
                If .IdFacturaImputada <> IdFacturaImputadaEnLaBase(SC, .Id) Then
                    ms &= "Otro usuario actualizó la carta mientras vos la editabas. Por favor, volvé a cargar la carta y hacé nuevamente las modificaciones. Es posible que no esté más disponible para editar"
                End If
            End If




            Try
                If .CalidadDe > 0 Then
                    If NombreCalidad(SC, .CalidadDe).Contains("GRADO 1") And .NobleGrado <> 1 Then
                        .NobleGrado = 1
                        'sWarnings &= "Se corrigió el grado de la pestaña de calidad para que sea igual al ""GRADO 1"" puesto en la calidad de descarga" & vbCrLf
                    ElseIf NombreCalidad(SC, .CalidadDe).Contains("GRADO 2") And .NobleGrado <> 2 Then
                        .NobleGrado = 2
                        'sWarnings &= "Se corrigió el grado de la pestaña de calidad para que sea igual al ""GRADO 2"" puesto en la calidad de descarga" & vbCrLf
                    ElseIf NombreCalidad(SC, .CalidadDe).Contains("GRADO 3") And .NobleGrado <> 3 Then
                        .NobleGrado = 3
                        'sWarnings &= "Se corrigió el grado de la pestaña de calidad para que sea igual al ""GRADO 3"" puesto en la calidad de descarga" & vbCrLf
                    End If
                End If
            Catch ex As Exception
                ErrHandler2.WriteError("calidad invalida" & .CalidadDe & " " & ex.ToString)
            End Try




            'http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=14488
            'En los campos CEE y CTG controlar que tengan 14 y 8 dígitos, respectivamente.
            'Si no se cumple, avisar al usuario con una advertencia, pero dejar grabar.
            If iisNull(.SubnumeroVagon, 0) = 0 Then

                If Val(.CEE) > 0 And .CEE.Length <> 14 Then
                    sWarnings &= "El CEE no tiene 14 dígitos" & vbCrLf
                End If

                If Val(.CTG) > 0 And .CTG.ToString().Length <> 8 Then
                    sWarnings &= "El CTG no tiene 8 dígitos" & vbCrLf
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
                        'return false
                    End If
                End If
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
            End If


            If .NetoFinalIncluyendoMermas > 0 Then
                If .FechaDescarga = #12:00:00 AM# Then
                    ms &= "Se necesita la fecha de la descarga (porque se ingresó el peso final de la descarga)"
                    ms &= vbCrLf   'return false
                End If


            End If



            Dim pat As String = .Patente.Replace(" ", "")
            If Not (pat.Length = 6 Or pat.Length = 7 Or pat.Length = 0) Then

                ms &= "La patente del camión es inválida "
                ms &= vbCrLf   'return false

            End If


            Dim aco As String = .Acoplado.Replace(" ", "")
            If Not (aco.Length = 6 Or aco.Length = 7 Or aco.Length = 0) Then

                ms &= "La patente del acoplado es inválida "
                ms &= vbCrLf   'return false

            End If




            If False Then
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11839
                'Cada vez que se graba la carta de porte, si el Entregador no es Williams ni está vacío (es decir,
                '    que pusieron explicitamente otro Entregador), entonces no dejar grabar hasta que no pongan el tilde de Exportación

                If iisNull(.IdClienteEntregador, 0) > 0 And Not iisNull(NombreCliente(SC, iisNull(.IdClienteEntregador, 0)), "").ToUpper.Contains("WILLIAMS") And Not .Exporta Then
                    ms &= "Una carta porte con entregador debe tener el tilde de exportación"
                    'ms &=vbCrLf   'return false
                End If

            End If




            If False Then
                If iisNull(.SubnumeroDeFacturacion, 0) > 0 Then
                    If .IdClienteAFacturarle <= 0 Then
                        ms &= "Las cartas duplicadas exigen el cliente a facturarsele"
                        'ms &=vbCrLf   'return false
                    End If

                    If iisNull(.SubnumeroDeFacturacion, 0) >= 1 Then
                        'VerificarQueElOriginalTieneExplicitadoElClienteFacturado
                        Try
                            If CartaDePorteManager.GetItemPorNumero(SC, .NumeroCartaDePorte, .SubnumeroVagon, .SubnumeroDeFacturacion).IdClienteAFacturarle <= 0 Then
                                ms &= "El original de este duplicado no tiene marcado el cliente al que se factura"
                                ms &= vbCrLf   'return false
                            End If
                        Catch ex As Exception
                            ErrHandler2.WriteError(ex) 'probablemente se queja de que hay copias de subfacturacion. Justo en este caso, no importa
                        End Try
                    End If
                End If
            End If



            If .NobleACamara And .NobleConforme Then
                ms &= "No pueden estar tildados Conforme y A camara en Noble"
                ms &= vbCrLf   'return false
            End If




            'revisar si el cliente asignado usa acopios
            If .IdClienteAFacturarle > 0 And .AcopioFacturarleA <= 0 Then
                If Not InStr(EntidadManager.NombreCliente(SC, .IdClienteAFacturarle).ToUpper, "SYNGENTA") > 0 Then
                    If (CartaDePorteManager.excepcionesAcopios(SC, .IdClienteAFacturarle).Count > 1) Then
                        ms &= "El cliente a facturarle exige un acopio" & vbCrLf
                    End If
                End If
            End If



            If .Titular > 0 Then

                If False And InStr(EntidadManager.NombreCliente(SC, .Titular).ToUpper, "SYNGENTA") > 0 And .EnumSyngentaDivision = "" Then
                    If Not (.bSeLeFactura_a_SyngentaDivisionAgro Xor .bSeLeFactura_a_SyngentaDivisionAgro) Then
                        ms &= "Debe elegir a cuál de las divisiones de Syngenta se le facturará (a división Agro o a división Seeds)"
                        ms &= vbCrLf   'return false
                    End If
                End If



                If (InStr(EntidadManager.NombreCliente(SC, .Titular).ToUpper, "A.C.A") > 0) Then 'por ahora solo reviso los casos de A.C.A


                    If (CartaDePorteManager.excepcionesAcopios(SC, .Titular).Count > 1 And .Acopio1 <= 0) Then
                        ms &= "Falta elegir a qué acopio corresponde el titular"
                        ms &= vbCrLf   'return false
                    End If

                End If

                If (.CuentaOrden2 > 0) Then
                    If (InStr(EntidadManager.NombreCliente(SC, .CuentaOrden2).ToUpper, "A.C.A") > 0) Then 'por ahora solo reviso los casos de A.C.A

                        If (.CuentaOrden2 > 0) Then
                            If (CartaDePorteManager.excepcionesAcopios(SC, .CuentaOrden2).Count > 1 And .Acopio3 <= 0) Then
                                'rcomercial
                                ms &= "Falta elegir a qué acopio corresponde el remitente comercial"
                                ms &= vbCrLf   'ms &=vbCrLf   'return false
                            End If
                        End If

                    End If
                End If

                If (.CuentaOrden1 > 0) Then
                    If (InStr(EntidadManager.NombreCliente(SC, .CuentaOrden1).ToUpper, "A.C.A") > 0) Then 'por ahora solo reviso los casos de A.C.A

                        If (.CuentaOrden1 > 0) Then
                            If (CartaDePorteManager.excepcionesAcopios(SC, .CuentaOrden1).Count > 1 And .Acopio2 <= 0) Then
                                'intermediario
                                ms &= "Falta elegir a qué acopio corresponde el intermediario"
                                ms &= vbCrLf   'return false
                            End If
                        End If

                    End If
                End If


                'If (InStr(EntidadManager.NombreCliente(SC, .Titular).ToUpper, "A.C.A") > 0 And .Acopio1 <= 0) Then
                '    ms &= "Falta elegir a qué acopio de A.C.A corresponde el titular"
                '    ms &=vbCrLf   'ms &=vbCrLf   'return false
                'End If

                'If (.CuentaOrden2 > 0) Then
                '    If (InStr(EntidadManager.NombreCliente(SC, .CuentaOrden2).ToUpper, "A.C.A") > 0 And .Acopio3 <= 0) Then
                '        'rcomercial
                '        ms &= "Falta elegir a qué acopio de A.C.A corresponde el remitente comercial"
                '        ms &=vbCrLf   'return false
                '    End If
                'End If

                'If (.CuentaOrden1 > 0) Then
                '    If (InStr(EntidadManager.NombreCliente(SC, .CuentaOrden1).ToUpper, "A.C.A") > 0 And .Acopio2 <= 0) Then
                '        'intermediario
                '        ms &= "Falta elegir a qué acopio de A.C.A corresponde el intermediario"
                '        ms &=vbCrLf   'return false
                '    End If
                'End If
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
                    ms &= "El cliente no está habilitado para cartas de porte " & Join(cli, ",")
                    ms &= vbCrLf   'return false
                End If




            End If


            If .EstadoRecibidor = 1 And .MotivoRechazo = 0 Then
                ms &= "Se debe elegir un motivo de rechazo"
                ms &= vbCrLf   'return false
            End If

            If .ClienteAcondicionador <= 0 Then .ClienteAcondicionador = Nothing






            If .PuntoVenta < 1 Or .PuntoVenta > 4 Then
                ms &= "El punto de venta debe estar entre 1 y 4"
                ms &= vbCrLf   'return false
            End If


            If True Then
                'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=14168
                'Precisan agregar una marca en el formulario de clientes para poder bloquear la carga de estos 
                'en las cartas de porte debido a un conflicto de cobranzas.
                'Este tilde deberán verlo solo algunos usuarios (activaremos a los de cobranzas).
                'Luego, cuando quieran usarlo en una carta de porte el sistema tiene que dar un mensaje de advertencia diciendo 
                'que el usuario no se puede utilizar y que tiene que ponerse en contacto con el sector de cobranzas.
                'La carta de porte no se puede grabar si tiene un cliente en esta condición.


                Dim sClientesCobranzas As String
                If UsaClientesQueEstanBloqueadosPorCobranzas(SC, myCartaDePorte, sClientesCobranzas) Then
                    ms &= "Cliente bloqueado. Ponerse en contacto con el sector de cobranzas (" & sClientesCobranzas & ") "
                    ms &= vbCrLf   'return false
                End If
            End If


            Dim sClientesExigentes As String
            If .NetoFinalIncluyendoMermas > 0 And UsaClientesQueExigenDatosDeDescargaCompletos(SC, myCartaDePorte, sClientesExigentes) Then
                'Está en descarga y usa clientes exigentes: se debe hacer validacion completa


                'Consulta 7562 http://bdlconsultores2.dynalias.com/Consultas/Admin/verConsultas1.php?recordid=7562



                Dim K = " Algunos clientes usados en esta carta exigen completar " & _
                     " todos los campos de una carta en Descarga  (" & sClientesExigentes & ") "

                'verificar que esta completa


                If .Titular = 0 Or .Entregador = 0 Or .CuentaOrden1 = 0 Or .Corredor = 0 Then


                    ms &= "Hay que completar Titular, Destinatario, Intermediario y Corredor. " & K
                    ms &= vbCrLf   'return false

                End If


                If .Destino = 0 Or .Procedencia = 0 Or .IdChofer = 0 Or .IdTransportista = 0 Then

                    ms &= "Hace falta completar Procedencia, Destino, Tranportista y Chofer. " & K
                    ms &= vbCrLf   'return false

                End If



                If iisNull(.NetoFinalIncluyendoMermas, 0) <= 0 Or _
                    iisNull(.TaraFinal, 0) <= 0 Or _
                    iisNull(.BrutoFinal, 0) <= 0 Or _
                    iisNull(.NetoPto, 0) <= 0 Or _
                    iisNull(.NetoFinalSinMermas, 0) <= 0 Then

                    ms &= "Hay pesajes sin completar. " & K
                    ms &= vbCrLf   'return false
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

                    ms &= "Hace falta CEE, CTG, Fechas de carga/vencimiento/descarga,Contrato, Patente, Recibo y Calidad. " & K
                    ms &= vbCrLf   'return false

                End If







            End If



        End With



        VerSiSeEstaCreandoUnDuplicadoYSuOriginalEsExportador(myCartaDePorte, SC, myCartaDePorte.Id, ms, True)



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
        '        'ms &=vbCrLf   'return false
        '    End If
        'End If
        If ms <> "" Then
            ms &= vbCrLf
            Return False
        End If


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
            .FechaAnulacion = Nothing
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
            Case CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas
                Return "Todas (menos las rechazadas) "
            Case CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones
                Return "Descargas de Hoy + Todas las Posiciones "
            Case CartaDePorteManager.enumCDPestado.Posicion
                Return "Posición "
            Case CartaDePorteManager.enumCDPestado.DescargasMasFacturadas
                Return "Descargas "
            Case CartaDePorteManager.enumCDPestado.Rechazadas
                Return "Rechazadas "
            Case CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha
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


        ErrHandler2.WriteError("InformeAdjuntoDeFacturacionWilliamsEPSON Idfactura=" & IdFactura)


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






        ErrHandler2.WriteError("InformeAdjuntoDeFacturacionWilliamsEPSON_A4 Idfactura=" & IdFactura)

        If CartaDePorteManager.UsaAcondicionadoras(SC, IdFactura) And False Then
            Return CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsAcondicionadorasEPSON_A4(SC, IdFactura, ReportViewer2, "")
        End If


        Dim dt As DataTable
        Try
            dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_PorIdFactura", IdFactura)

        Catch ex As Exception
            ErrHandler2.WriteError("tiene muchas cartas imputadas? falta un índice?")
            ErrHandler2.WriteError(ex)
            'timeout en https://prontoweb.williamsentregas.com.ar/ProntoWeb/Factura.aspx?Id=70318 porque tiene muchas imputadas
            '    está muy bloqueada la tabla de cartas?
            '    exec wCartasDePorte_TX_PorIdFactura @IdFactura=70318 tardó 20 segundos!!!!
            '    me reclama otro indice en cartasdeporte

            '    CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
            '    ON [dbo].[CartasDePorte] ([IdFacturaImputada])
            '    INCLUDE([IdCartaDePorte], [NumeroCartaDePorte], [Vendedor], [CuentaOrden1],
            '    [CuentaOrden2], [Corredor], [Entregador], [IdArticulo], [NetoFinal], [Contrato],
            '    [Destino], [FechaDescarga], [IdEstablecimiento], [AgregaItemDeGastosAdministrativos])
            '    GO()
        End Try




        If ArchivoExcelDestino = "" Then
            ArchivoExcelDestino = IO.Path.GetTempPath & "AdjuntoDeFactura " & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        End If

        'Dim vFileName As String = "c:\archivo.txt"
        ' FileOpen(1, ArchivoExcelDestino, OpenMode.Output)



        If False Then
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

                Dim bytes As Byte()


                Try

                    bytes = ReportViewer2.LocalReport.Render( _
                           format, Nothing, mimeType, encoding, _
                             extension, _
                            streamids, warnings)





                Catch e As System.Exception
                    Dim inner As Exception = e.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            'MsgBox(inner.Message)
                            'Stop
                        End If
                        ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message) ' & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                        inner = inner.InnerException
                    End While
                    Throw
                End Try



                Dim fs = New IO.FileStream(ArchivoExcelDestino, IO.FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()






                'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es la mitad de la normal)
                'Notas de Entrega: 160 ancho x 36 alt
                'Facturas y Adjuntos: 160 ancho x 78 alto



            End With
            'End Using



        Else
            RebindReportViewer_ServidorExcel_SinSanata(ReportViewer2, "/Pronto informes/Adjuntos de Facturacion (a impresora de matriz de puntos)  ReportServer", "wCartasDePorte_TX_PorIdFactura " & IdFactura, SC, ArchivoExcelDestino, IdFactura)
        End If



        ArchivoExcelDestino = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextWilliamsAdjunto_A4(ArchivoExcelDestino)

        Return ArchivoExcelDestino

    End Function








    Public Shared Function InformeAdjuntoDeFacturacionWilliamsAcondicionadorasEPSON(ByVal SC As String, ByVal IdFactura As Integer, ByRef ReportViewer2 As ReportViewer, ByRef ArchivoExcelDestino As String) As String

        ErrHandler2.WriteError("InformeAdjuntoDeFacturacionWilliamsAcondicionadorasEPSON Idfactura=" & IdFactura)


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


        If False Then
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




            End With
        Else
            RebindReportViewer_ServidorExcel_SinSanata(ReportViewer2, "/Pronto informes/Adjuntos de Facturacion Acondicionadoras (a impresora de matriz de puntos)  ReportServer", "wCartasDePorte_TX_PorIdFactura " & IdFactura, SC, ArchivoExcelDestino, IdFactura)
        End If



        ArchivoExcelDestino = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextWilliamsAdjunto(ArchivoExcelDestino)

        ' End Using


        Return ArchivoExcelDestino

    End Function


    Public Shared Function InformeAdjuntoDeFacturacionWilliamsAcondicionadorasEPSON_A4(ByVal SC As String, ByVal IdFactura As Integer, ByRef ReportViewer2 As ReportViewer, ByRef ArchivoExcelDestino As String) As String


        ErrHandler2.WriteError("InformeAdjuntoDeFacturacionWilliamsAcondicionadorasEPSON_A4 Idfactura=" & IdFactura)

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

        If False Then



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

                Dim bytes As Byte()



                Try

                    bytes = ReportViewer2.LocalReport.Render( _
                           format, Nothing, mimeType, encoding, _
                             extension, _
                            streamids, warnings)





                Catch e As System.Exception
                    Dim inner As Exception = e.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            'MsgBox(inner.Message)
                            'Stop
                        End If
                        ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message) ' & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                        inner = inner.InnerException
                    End While
                    Throw
                End Try




                Dim fs = New IO.FileStream(ArchivoExcelDestino, IO.FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()





                'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es la mitad de la normal)
                'Notas de Entrega: 160 ancho x 36 alt
                'Facturas y Adjuntos: 160 ancho x 78 alto



            End With
            '  End Using

            RebindReportViewer_ServidorExcel_SinSanata(ReportViewer2, "/Pronto informes/Adjuntos de Facturacion Acondicionadoras (a impresora de matriz de puntos)  ReportServer", "wCartasDePorte_TX_PorIdFactura " & IdFactura, SC, ArchivoExcelDestino, IdFactura)

        End If

        If True Then

            Threading.Thread.Sleep(5000)
            For n = 1 To 2
                ArchivoExcelDestino = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextWilliamsAdjunto_A4(ArchivoExcelDestino)
            Next

        End If




        Return ArchivoExcelDestino

    End Function



    Public Shared Function InformeAdjuntoDeFacturacionWilliamsExcel_ParaBLD(ByVal SC As String, ByVal IdFactura As Integer, ByRef ArchivoExcelDestino As String, ByRef ReportViewer2 As ReportViewer) As String

        ErrHandler2.WriteError("InformeAdjuntoDeFacturacionWilliamsExcel Idfactura=" & IdFactura)


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

                .ReportPath = "ProntoWeb\Informes\Adjuntos de Facturacion para exportar a Excel formato BLD.rdl"
                '.ReportPath = "C:\Users\Administrador\Documents\bdl\prontoweb\ProntoWeb\Informes\Adjuntos de Facturacion para exportar a Excel formato BLD.rdl"

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
    Public Shared Function InformeAdjuntoDeFacturacionWilliamsExcel(ByVal SC As String, ByVal IdFactura As Integer, ByRef ArchivoExcelDestino As String, ByRef ReportViewer2 As ReportViewer) As String

        ErrHandler2.WriteError("InformeAdjuntoDeFacturacionWilliamsExcel Idfactura=" & IdFactura)


        'Dim dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_PorIdFactura", IdFactura)
        Dim dt = EntidadManager.ExecDinamico(SC, "wCartasDePorte_TX_PorIdFactura " & IdFactura, 100)



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

    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Public Shared Function ExtraerZip(ZipAExtraer As String, DirectorioExtraccion As String) As Generic.List(Of String)




        Dim archivos As New Generic.List(Of String)

        Using zip1 As Ionic.Zip.ZipFile = Ionic.Zip.ZipFile.Read(ZipAExtraer)
            Dim e As Ionic.Zip.ZipEntry
            For Each e In zip1
                Try
                    archivos.Add(DirectorioExtraccion + e.FileName)
                    'archivos.Add(DirectorioExtraccion + e..FileName) me incluye los nombres de subdirectorios?
                    e.Extract(DirectorioExtraccion, Ionic.Zip.ExtractExistingFileAction.OverwriteSilently)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try
            Next
        End Using





        Return archivos
    End Function


    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    Shared Sub ImputoElEmbarque(ByVal idMov As Integer, ByVal idfactura As Integer, _
                                ByVal SC As String, ByVal nombreUsuario As String, renglonimputado As Integer)



        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        'Dim embarques = From i In db.CartasPorteMovimientos _
        '                Where i.Tipo = 4 _
        '                And i.FechaIngreso >= FechaDesde And i.FechaIngreso <= FechaHasta _
        '                And i.IdFacturaImputada <= 0


        'METODO 1
        'oCDP.IdFacturaImputada = idfactura
        'CartaDePorteManager.Save(HFSC.Value, oCDP, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))

        'METODO 2




        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        Dim a = (From f In db.linqDetalleFacturas _
                Where f.IdFactura = idfactura _
                Order By f.IdDetalleFactura Select f.IdDetalleFactura).ToList

        Dim iddetallefact As Long = a(renglonimputado)





        Dim dt = EntidadManager.ExecDinamico(SC, "SELECT IdFacturaImputada from CartasPorteMovimientos WHERE IdCDPMovimiento=" & idMov)
        If iisNull(dt(0)("IdFacturaimputada"), 0) > 0 Then
            Err.Raise(6464, , "Ya tiene una factura imputada")
        End If

        EntidadManager.ExecDinamico(SC, "UPDATE CartasPorteMovimientos SET IdFacturaImputada=" & idfactura & "  WHERE IdCDPMovimiento=" & idMov)
        EntidadManager.ExecDinamico(SC, "UPDATE CartasPorteMovimientos SET IdDetalleFactura=" & iddetallefact & "  WHERE IdCDPMovimiento=" & idMov)


        EntidadManager.LogPronto(SC, idfactura, "Imputacion de IdCPorteMovimiento " & idMov & " IdFacturaImputada " & idfactura, nombreUsuario)


    End Sub





    Shared Sub ImputoLaCDP(ByVal oCDP As Pronto.ERP.BO.CartaDePorte, ByVal idfactura As Integer, ByVal SC As String, ByVal nombreUsuario As String, imput As List(Of LogicaFacturacion.grup))

        'METODO 1
        'oCDP.IdFacturaImputada = idfactura
        'CartaDePorteManager.Save(HFSC.Value, oCDP, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))


        'METODO 2

        'si hay un error (de timeout por ejemplo), no se podría volver a intentar?

        Dim q = _
                    (From p In imput _
                    Where p.cartas.Any(Function(x) x.Id = oCDP.Id) _
                    Select p).First

        Dim ind As Integer = imput.IndexOf(q)


        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        Dim a = (From f In db.linqDetalleFacturas _
                Where f.IdFactura = idfactura _
                Order By f.IdDetalleFactura Select f.IdDetalleFactura).ToList

        Dim iddetallefact As Long = a(ind)






        Try
            'verificar que no tiene nada imputado
            Dim dt = EntidadManager.ExecDinamico(SC, "SELECT IdFacturaImputada from CartasDePorte WHERE IdCartaDePorte=" & oCDP.Id)
            If iisNull(dt(0)("IdFacturaimputada"), 0) > 0 Then
                Err.Raise(6464, , "Ya tiene una factura imputada. Carta ID= " & oCDP.Id & "  numero " & oCDP.NumeroCartaDePorte)
            End If

            EntidadManager.ExecDinamico(SC, "UPDATE CartasDePorte SET IdFacturaImputada=" & idfactura & "  WHERE IdCartaDePorte=" & oCDP.Id)
            EntidadManager.ExecDinamico(SC, "UPDATE CartasDePorte SET IdDetalleFactura=" & iddetallefact & "  WHERE IdCartaDePorte=" & oCDP.Id)

            'actualizar el item de la factura



            EntidadManager.LogPronto(SC, idfactura, "Imputacion de IdCartaPorte" & oCDP.Id & "CDP:" & oCDP.NumeroCartaDePorte & " " & oCDP.SubnumeroVagon & "  IdFacturaImputada=" & idfactura & "   IdDetalleFactura=" & iddetallefact, , nombreUsuario)

        Catch ex As Exception
            'ErrHandler2.WriteError("Ya tiene una factura imputada")
            ErrHandler2.WriteError("Explota la imputacion")

            'http://bdlconsultores.sytes.net/Consultas/Admin/VerConsultas1.php?recordid=13368

            Throw
        End Try


    End Sub



    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
            ErrHandler2.WriteError(ex.ToString)
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
            ErrHandler2.WriteError(ex.ToString)
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
            If idCorredor = -1 Then ErrHandler2.WriteError("Sin Corredor")
            ErrHandler2.WriteError(" EsteCorredorSeleFacturaAlClientePorSeparadoId(). " & ex.ToString & "Quizas es un buque (sin corredor). ")
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


        ErrHandler2.WriteError("EnviarEmailDeAdjuntosDeWilliams Idfactura=" & idfactura)



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

        nombre = Path.GetFileNameWithoutExtension(nombre)

        Dim no As String() = Split(nombre)
        numeroCarta = Val(no(0))
        vagon = 0
        Try
            If no.Count > 1 Then vagon = Val(no(1)) ' Val(Mid(nombre, InStr(nombre, " ")))
        Catch ex As Exception
            ErrHandler2.WriteError("ParseNombreCarta " + nombre + " " + ex.ToString)
        End Try

    End Sub



    Shared Function CrearDirectorioParaLoteImagenes(DirApp As String, nombreusuario As String, puntoventa As Integer) As String


        Dim DIRTEMP As String = DirApp & "\Temp\"

        '/////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////
        'crear subdirectorios para clasificar la parva de archivos

        Dim nuevodir = "Lote " & DateTime.Now.ToString("ddMMMHHmmss") & " " & nombreusuario + " PV" & puntoventa & "\"
        If Not IO.Directory.Exists(DIRTEMP + nuevodir) Then IO.Directory.CreateDirectory(DIRTEMP + nuevodir)

        Return nuevodir


    End Function


    Shared Function CreaDirectorioParaImagenCartaPorte(nombrenuevo As String, DirApp As String) As String

        Dim DIRFTP = DirApp & "\DataBackupear\"


        '/////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////
        'crear subdirectorios para clasificar la parva de archivos

        'Dim nuevodir = Left(numeroCarta, 2) + "\"
        Dim nuevodir = Left(nombrenuevo, 2) + "\"
        If Not IO.Directory.Exists(DIRFTP + nuevodir) Then IO.Directory.CreateDirectory(DIRFTP + nuevodir)

        If True Then 'no está andando bien en produccion. no está creando el subdirectorio -por un tema de permisos?
            nombrenuevo = nuevodir + nombrenuevo
        End If

        '/////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////
        Return nombrenuevo

    End Function


    Shared Function AdjuntarImagen(SC As String, AsyncFileUpload1 As AjaxControlToolkit.AsyncFileUpload, _
                                   forzarID As Long, ByRef sError As String, DirApp As String, NameOnlyFromFullPath As String) As String


        Dim DIRFTP = DirApp & "\DataBackupear\"
        Dim nombre = NameOnlyFromFullPath '(AsyncFileUpload1.PostedFile.FileName)
        Randomize()
        Dim nombrenuevo = Int(Rnd(100000) * 100000).ToString.Replace(".", "") + Now.ToString("ddMMMyyyy_HHmmss") + "_" + nombre

        nombrenuevo = CreaDirectorioParaImagenCartaPorte(nombrenuevo, DirApp)


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
                ErrHandler2.WriteError(ex.ToString)
                Throw
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If










        GrabarImagen(forzarID, SC, numeroCarta, vagon, nombrenuevo, sError, DirApp)


        Return nombrenuevo
    End Function

    Shared Function AdjuntarImagen2(SC As String, AsyncFileUpload1 As AjaxControlToolkit.AsyncFileUpload, forzarID As Long, ByRef sError As String, DirApp As String, NameOnlyFromFullPath As String) As String

        Dim DIRFTP = DirApp & "\DataBackupear\"
        Dim nombre = NameOnlyFromFullPath ' (AsyncFileUpload1.PostedFile.FileName)
        Randomize()
        Dim nombrenuevo = Int(Rnd(100000) * 100000).ToString.Replace(".", "") + Now.ToString("ddMMMyyyy_HHmmss") + "_" + nombre


        nombrenuevo = CreaDirectorioParaImagenCartaPorte(nombrenuevo, DirApp)



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
                ErrHandler2.WriteError(ex.ToString)
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



    Shared Function GrabarImagen(forzarID As Long, SC As String, numeroCarta As Long, vagon As Long, archivoImagenSinPathUbicadaEnDATABACKUPEAR As String, ByRef sError As String, DirApp As String, Optional bForzarCasillaCP As Boolean = False, Optional bForzarCasillaTK As Boolean = False) As String

        'quien se encarga de borrar la imagen que no se pudo adjuntar?
        ErrHandler2.WriteError("GrabarImagen 1")

        If forzarID = -1 Then
            'si no viene el ID,  busco por numero de carta

            Dim cdp As CartaDePorte
            Try
                cdp = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon, -1) 'aca tira la bronca si estaba duplicada

                If cdp.Id = -1 Then
                    sError &= numeroCarta & "/" & vagon & " no existe <br/> "
                    Return ""
                    Return archivoImagenSinPathUbicadaEnDATABACKUPEAR
                    Exit Function
                    'cdp.NumeroCartaDePorte = numeroCarta
                    'cdp.SubnumeroVagon = vagon
                End If
                forzarID = cdp.Id

            Catch ex As Exception
                ErrHandler2.WriteError(ex)

                Dim db2 As New LinqCartasPorteDataContext(Encriptar(SC))
                Dim o = (From i In db2.CartasDePortes Where i.NumeroCartaDePorte = numeroCarta And i.SubnumeroVagon = vagon And i.SubnumeroDeFacturacion <= 0).SingleOrDefault


                If o Is Nothing Then
                    sError &= numeroCarta & "/" & vagon & " no existe <br/> "
                    Return ""
                    Return archivoImagenSinPathUbicadaEnDATABACKUPEAR
                    Exit Function
                    'cdp.NumeroCartaDePorte = numeroCarta
                    'cdp.SubnumeroVagon = vagon
                End If
                forzarID = o.IdCartaDePorte
            End Try
        End If





        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim oCarta = (From i In db.CartasDePortes Where i.IdCartaDePorte = forzarID).SingleOrDefault



        Dim DIRDATABACKUPEAR = DirApp & "\DataBackupear\"



        ErrHandler2.WriteError("GrabarImagen 2")




        'si es un .tiff paginado
        If archivoImagenSinPathUbicadaEnDATABACKUPEAR.EndsWith(".tif") Or archivoImagenSinPathUbicadaEnDATABACKUPEAR.EndsWith(".tiff") Then
            Try

                'guardar el tiff original
                '-cómo? hay codigo que borra ese archivo tif original????


                Dim listapaginas As List(Of System.Drawing.Image) = ProntoMVC.Data.FuncionesGenericasCSharp.GetAllPages(DIRDATABACKUPEAR + archivoImagenSinPathUbicadaEnDATABACKUPEAR)


                'primera pagina del tiff
                If Not InStr(archivoImagenSinPathUbicadaEnDATABACKUPEAR.ToUpper, "TK") > 0 And Not bForzarCasillaTK Then
                    listapaginas(0).Save(DIRDATABACKUPEAR + archivoImagenSinPathUbicadaEnDATABACKUPEAR + ".jpg", Imaging.ImageFormat.Jpeg)
                    BorroArchivo(DIRDATABACKUPEAR + oCarta.PathImagen)
                    oCarta.PathImagen = archivoImagenSinPathUbicadaEnDATABACKUPEAR + ".jpg"
                Else
                    listapaginas(0).Save(DIRDATABACKUPEAR + archivoImagenSinPathUbicadaEnDATABACKUPEAR + ".jpg", Imaging.ImageFormat.Jpeg)
                    BorroArchivo(DIRDATABACKUPEAR + oCarta.PathImagen2)
                    oCarta.PathImagen2 = archivoImagenSinPathUbicadaEnDATABACKUPEAR + ".jpg"
                End If

                'segunda pagina del tiff
                'meté el "TK" como sufijo, no como prefijo, porque en el nombre puede venir el subdirectorio de clasificacion
                If listapaginas.Count > 1 Then
                    'listapaginas(1).Save(Path.GetFullPath(archivoImagen) + "TK_" + Path.GetFileName(archivoImagen))
                    listapaginas(1).Save(DIRDATABACKUPEAR + archivoImagenSinPathUbicadaEnDATABACKUPEAR + "_TK" + ".jpg", Imaging.ImageFormat.Jpeg)
                    BorroArchivo(DIRDATABACKUPEAR + oCarta.PathImagen2)
                    oCarta.PathImagen2 = archivoImagenSinPathUbicadaEnDATABACKUPEAR + "_TK" + ".jpg"

                End If

            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                sError &= ex.ToString
                Return ""
            End Try


        ElseIf InStr(archivoImagenSinPathUbicadaEnDATABACKUPEAR.ToUpper, "TK") > 0 Or bForzarCasillaTK Then
            If oCarta.PathImagen2 <> "" Then BorroArchivo(DIRDATABACKUPEAR + oCarta.PathImagen2)
            oCarta.PathImagen2 = archivoImagenSinPathUbicadaEnDATABACKUPEAR
        ElseIf InStr(archivoImagenSinPathUbicadaEnDATABACKUPEAR.ToUpper, "CP") > 0 Then
            If oCarta.PathImagen <> "" Then BorroArchivo(DIRDATABACKUPEAR + oCarta.PathImagen)
            oCarta.PathImagen = archivoImagenSinPathUbicadaEnDATABACKUPEAR
        Else
            If oCarta.PathImagen = "" Or bForzarCasillaCP Then
                oCarta.PathImagen = archivoImagenSinPathUbicadaEnDATABACKUPEAR 'nombrenuevo
            ElseIf oCarta.PathImagen2 = "" Then
                oCarta.PathImagen2 = archivoImagenSinPathUbicadaEnDATABACKUPEAR 'nombrenuevo
            Else
                sError &= "<a href=""CartaDePorte.aspx?Id=" & forzarID & """ target=""_blank"">" & oCarta.NumeroCartaDePorte & "/" & oCarta.SubnumeroVagon & "</a> tiene las dos imagenes ocupadas;  <br/> "
                'sError &= vbCrLf & numeroCarta & " tiene las dos imagenes ocupadas  <br/>"
                Return ""
            End If
        End If


        oCarta.FechaModificacion = Now

        ErrHandler2.WriteError("grabo en base")

        db.SubmitChanges()

        ErrHandler2.WriteError("grabado")

        sError &= "<a href=""CartaDePorte.aspx?Id=" & forzarID & """ target=""_blank"">" & oCarta.NumeroCartaDePorte & "/" & oCarta.SubnumeroVagon & "</a>;  <br/> "


        Return archivoImagenSinPathUbicadaEnDATABACKUPEAR
    End Function




    Shared Sub BorroArchivo(file As String)
        'qué hago con el archivo anterior? -por ahora lo conservo
        Dim MyFile1 As New FileInfo(file)
        Try
            If MyFile1.Exists Then
                MyFile1.Delete()
            End If
        Catch ex As Exception
        End Try
    End Sub








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




    Shared Function ReadBarcode1D_Spire(ByVal fileName As String, ByVal page As Integer) As String
        'https://www.daniweb.com/software-development/csharp/code/481719/barcode-recognition-spire-barcode
        'https://visualstudiogallery.msdn.microsoft.com/e4f65909-2b0a-4c4e-84b2-eccbcc547905
        'la instalacion del paquete incluye unas demos con código 

        Dim reader As New Spire.Barcode.BarcodeScanner


        'scan the barcode
        Dim datas() As String = Spire.Barcode.BarcodeScanner.Scan(fileName, Spire.Barcode.BarCodeType.Code128)
        'JRD.Imaging.Barcode.Scan(JRD.Imaging.Barcode.GetBitmap(fileName), BarcodeType.Code128)


        'show the scan result
        For n = 0 To datas.Count - 1
            Dim largo = Val(datas(n).Trim).ToString.Length
            Dim num As Long = Val(datas(n).Trim)
            If largo = 9 And num >= 500000000 And num < 600000000 Then
                Return datas(n)
            End If
        Next


        Dim datas2() As String = Spire.Barcode.BarcodeScanner.Scan(fileName, Spire.Barcode.BarCodeType.Code39)
        'JRD.Imaging.Barcode.Scan(JRD.Imaging.Barcode.GetBitmap(fileName), BarcodeType.Code128)


        'show the scan result


        For n = 0 To datas2.Count - 1
            Dim largo = Val(datas2(n).Trim).ToString.Length
            Dim num As Long = Val(datas2(n).Trim)
            If largo = 9 Then
                Return datas2(n)
            End If
        Next



        Return ""

        'Return datas(0)





        '        Spire.Barcode.da()

        'Name of Property	Description
        'Data	Stores the data that is to be encoded to one-dimension barcode.
        'Data2D	Stores the data that is to be encoded to two-dimension barcode.
        'Type	Indicates the type of barcode that is to be generated.
        'HasBorder	Indicates whether barcode image has border.
        'BorderDashStyle	Stores the type of border barcode image has.
        'BarHeight	Stores the height of barcode image.
        'CheckB_BarcodeText	Indicates whether to show the barcode text.
        'TextFont	Stores the font of barcode text.
        'ForeColor	Stores the fore color of barcode image.
        'CheckB_Sum	Indicates whether to show the checksum digit in Code128 and EAN128 Barcodes.



    End Function

    Shared Function ReadBarcode1D_ClearImage(ByVal fileName As String, ByVal page As Integer) As String
        'http://how-to.inliteresearch.com/barcode-reading-howto/read-barcodes-from-an-image-page/




        Try
            Dim reader As New BarcodeReader()
            ' Select barcode type(s) to read
            reader.Code128 = True
            reader.Code39 = True


            ' Find the most popular 1D Barcodes
            'reader.Auto1D = True
            '  Look only for Horizontal barcodes
            'reader.Vertical = False
            'reader.Diagonal = False
            '   Set search zone to upper left corner
            'Dim io As New ImageIO()
            'Dim info As ImageInfo = io.Info(fileName, page)
            'reader.Zone = New Rectangle(0, 0, info.Width / 2, info.Height / 2)
            ' Read barcodes


            Dim barcodes As Barcode() = reader.Read(fileName, page)
            ' Process results
            For Each bc As Barcode In barcodes
                Console.Write(bc.Text) ' Use barcode text OR
                ' ProcessBarcode(bc)     ' do other processing
            Next

            If barcodes.Count = 1 Then
                Return barcodes(0).Text
            ElseIf barcodes.Count = 0 Then
                Return ""
            Else
                'Stop
                If barcodes(0).Text.Length >= 14 Then
                    Return barcodes(1).Text
                Else
                    Return barcodes(0).Text
                End If
            End If
            Return ""

        Catch ex As Exception
            'ProcessException(ex)
            'http://www.inliteresearch.com/homepage/support/pdk_vs_sdk.html
            ErrHandler2.WriteError(ex)
        End Try
    End Function


    Shared Function ReadBarcode1D_ZXing(ByVal fileName As String, ByVal page As Integer) As String
        'http://how-to.inliteresearch.com/barcode-reading-howto/read-barcodes-from-an-image-page/

        Try


            '// create a barcode reader instance
            Dim reader As ZXing.IBarcodeReader = New ZXing.BarcodeReader()

            reader.Options.TryHarder = True
            'reader.Options.
            '   var previousFormats = barcodeReader.Options.PossibleFormats;
            '   if (possibleFormats != null)
            '      barcodeReader.Options.PossibleFormats = possibleFormats;
            '   if (tryMultipleBarcodes)
            '      results = barcodeReader.DecodeMultiple(image);
            '   else


            '// load a bitmap
            Dim barcodeBitmap As System.Drawing.Bitmap = New System.Drawing.Bitmap(fileName)   '.LoadFrom(fileName)
            '// detect and decode the barcode inside the bitmap
            Dim result = reader.Decode(barcodeBitmap)
            '// do something with the result
            If (result IsNot Nothing) Then

                'txtDecoderType.Text = result.BarcodeFormat.ToString()
                'txtDecoderContent.Text = result.Text
                Dim largo = Val(result.Text.Trim).ToString.Length
                Dim num As Long = Val(result.Text.Trim)
                If largo = 9 And num >= 500000000 And num < 600000000 Then
                    Return result.Text
                End If
            End If

        Catch ex As Exception
            'ProcessException(ex)
            'http://www.inliteresearch.com/homepage/support/pdk_vs_sdk.html
            ErrHandler2.WriteError(ex)
        End Try
    End Function

    Public Shared Function LeerNumeroDeCartaPorteUsandoCodigoDeBarra(fileImagen As String, ByRef sError As String) As Long


        Dim numeroCarta As Long = 0


        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////

        If numeroCarta = 0 And False Then

            Try
                numeroCarta = Val(ReadBarcode1D_ClearImage(fileImagen, 0))
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            If numeroCarta <> 0 Then
                sError &= "Código de barras detectado con ClearImage. "
            End If

        End If


        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////



        If numeroCarta = 0 Then

            Try
                numeroCarta = Val(ReadBarcode1D_ZXing(fileImagen, 0))
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            If numeroCarta <> 0 Then
                sError &= "Código de barras detectado con Zxing. "

            Else
                'numeroCarta = Val(ReadBarcode1D_ClearImage(origen, 0))
                'If numeroCarta <> 0 Then
                '    sError &= "Código de barras detectado con ClearImage. "
                'End If
            End If

        End If


        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        If numeroCarta = 0 And True Then


            Try
                numeroCarta = Val(ReadBarcode1D_Spire(fileImagen, 0))
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            If numeroCarta <> 0 Then
                sError &= "Código de barras detectado con Spire. "

            Else
                'numeroCarta = Val(ReadBarcode1D_ClearImage(origen, 0))
                'If numeroCarta <> 0 Then
                '    sError &= "Código de barras detectado con ClearImage. "
                'End If
            End If

        End If




        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////


        If numeroCarta = 0 Then
            CartaDePorteManager.ParseNombreCarta(fileImagen, numeroCarta, 0)


            If numeroCarta <> 0 Then
                sError &= " Codigo de barras no detectado. Se usa el numero del nombre del archivo"

            Else

                sError &= " Numero no detectado por ningun medio"
            End If
        End If


        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////

        Return numeroCarta

    End Function


    Shared Function ProcesarImagenesConCodigosDeBarraYAdjuntar(SC As String, archivos As Generic.List(Of String), forzarID As Long, _
                            ByRef sError As String, DirApp As String) As Generic.List(Of ProntoMVC.Data.FuncionesGenericasCSharp.Resultados)


        Dim DIRTEMP = DirApp & "\Temp\"
        Dim DIRFTP = DirApp & "\DataBackupear\"




        ''podria revisar en un bucle anterior cuales son los tif
        'For Each nombre As String In archivos
        '    'si es un .tiff paginado
        '    If nombre.Contains(".tif") Then
        '        Dim listapaginas As List(Of System.Drawing.Image) = ProntoMVC.Data.FuncionesGenericasCSharp.GetAllPages(DIRFTP + nombre)
        '        dsfdf()
        '        listapaginas(0).Save(DIRFTP + oCarta.PathImagen)
        '        listapaginas(1).Save(DIRFTP + oCarta.PathImagen2)
        '    End If
        'Next

        Dim output As New Generic.List(Of ProntoMVC.Data.FuncionesGenericasCSharp.Resultados)()






        For Each nombre As String In archivos




            'http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=13767
            'http://stackoverflow.com/questions/1566188/converting-tiff-files-to-png-in-net

            'convierto los .tiff acá ? 




            If Not nombre.Contains(".jpg") And Not nombre.Contains(".tif") Then
                'si no es un jpg ni tiff (los tif se dividen dentro de la llamada a GrabarImagen)
                Try
                    System.Drawing.Bitmap.FromFile(nombre).Save(nombre + ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                    Continue For
                End Try
                'Path.GetFileNameWithoutExtension()
                nombre += ".jpg"
            End If


            Dim origen = nombre




            Dim bCodigoBarrasDetectado As Boolean = True

            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////


            Dim numeroCarta As Long = 0
            Dim vagon As Long = 0

            'In VB.NET, a variable that is declared inside a for loop keeps its value for the next itaration. This is by design: http://social.msdn.microsoft.com/Forums/en/vblanguage/thread/c9cb4c22-d40b-49ff-b535-19d47e4db38d but this is also dangerous pitfall for programmers.




            numeroCarta = LeerNumeroDeCartaPorteUsandoCodigoDeBarra(origen, sError)




            ErrHandler2.WriteError((origen).ToString() & " " & numeroCarta)

            If numeroCarta = 0 Or numeroCarta.ToString.Length > 9 Or numeroCarta.ToString.Length < 8 Then
                sError &= "Código de barras no detectado en archivo " & nombre & "      "

                bCodigoBarrasDetectado = False

                CartaDePorteManager.ParseNombreCarta(nombre, numeroCarta, vagon)
            End If

            If numeroCarta = 0 Then
                'despues de usar ParseNombreCarta tampoco lo detecta
                sError &= " Número no detectado en el nombre del archivo " & nombre & "<br/> "
                Continue For
            End If

            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////




            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '/////////////  COPIAR AL DIRECTORIO DE ARCHIVOS
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////


            Randomize()
            Dim nombrenuevo = Int(Rnd(100000) * 100000).ToString.Replace(".", "") + Now.ToString("ddMMMyyyy_HHmmss") + "_" + Path.GetFileName(nombre)





            nombrenuevo = CreaDirectorioParaImagenCartaPorte(nombrenuevo, DirApp)






            Dim destino = DIRFTP + nombrenuevo




            Try
                Dim MyFile1 As New FileInfo(destino)
                If MyFile1.Exists Then
                    MyFile1.Delete()
                End If
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            'copio el archivo cambiandole el nombre agregandole un sufijo
            '-qué pasa si ya tenía una imagen la carta?
            'de todas maneras, se esta copiando dos veces con distinto nombre en el mismo segundo

            Try
                Dim MyFile2 As New FileInfo(origen)


                If MyFile2.Exists Then
                    MyFile2.CopyTo(destino)
                End If
            Catch ex As Exception
            End Try



            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////



            'hacer así: si la imagen no se pudo asignar, borrar el archivo del \DataBackupear\



            If True Then




                Dim s = CartaDePorteManager.GrabarImagen(forzarID, SC, numeroCarta, vagon, nombrenuevo, sError, DirApp, bCodigoBarrasDetectado)

                If s = "" Then
                    'hacer así: si la imagen no se pudo asignar, borrar el archivo del \DataBackupear\

                    Dim MyFile5 As New FileInfo(destino)
                    Try
                        If MyFile5.Exists Then
                            MyFile5.Delete()
                        End If
                    Catch ex As Exception
                        ErrHandler2.WriteError(ex)
                    End Try
                End If

                'borro la foto del temp para que no aparezca en el asignador manual

                Dim MyFile6 As New FileInfo(origen)
                Try
                    If MyFile6.Exists Then
                        System.GC.Collect()
                        System.GC.WaitForPendingFinalizers()
                        ' http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=14955

                        Try
                            MyFile6.Delete() 'me está tirando que es usado por otro proceso
                        Catch ex As Exception
                            ErrHandler2.WriteError(ex)
                        End Try
                    End If
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                    MandarMailDeError("No pudo borrar la foto " & ex.ToString)
                End Try


                'si es un tiff paginado, tomar la 2da pagina y asignarla al ticket
                'getallpages()

            Else




                Dim cdp = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon, -1)
                If cdp.Id = -1 Then
                    sError &= numeroCarta & "/" & vagon & " no existe <br/> "

                    Continue For
                End If
                forzarID = cdp.Id


                Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
                Dim oCarta = (From i In db.CartasDePortes Where i.IdCartaDePorte = forzarID).SingleOrDefault



                Dim o As New ProntoMVC.Data.FuncionesGenericasCSharp.Resultados()
                o.IdCarta = oCarta.IdCartaDePorte
                o.numerocarta = oCarta.NumeroCartaDePorte
                o.errores = sError
                o.advertencias = ""
                output.Add(o)



                If InStr(nombrenuevo.ToUpper, "TK") Then
                    oCarta.PathImagen2 = nombrenuevo
                ElseIf InStr(nombrenuevo.ToUpper, "CP") Or bCodigoBarrasDetectado Then
                    oCarta.PathImagen = nombrenuevo
                Else
                    If oCarta.PathImagen = "" Then
                        oCarta.PathImagen = nombrenuevo 'nombrenuevo
                    ElseIf oCarta.PathImagen2 = "" Then
                        oCarta.PathImagen2 = nombrenuevo 'nombrenuevo
                    Else
                        sError &= "<a href=""CartaDePorte.aspx?Id=" & forzarID & """ target=""_blank"">" & oCarta.NumeroCartaDePorte & "/" & oCarta.SubnumeroVagon & "</a> tiene las dos imagenes ocupadas;  <br/> "
                        'sError &= vbCrLf & numeroCarta & " tiene las dos imagenes ocupadas  <br/>"
                        Continue For
                    End If
                End If

                sError &= "<a href=""CartaDePorte.aspx?Id=" & forzarID & """ target=""_blank"">" & oCarta.NumeroCartaDePorte & "/" & oCarta.SubnumeroVagon & "</a>;  <br/> "

                db.SubmitChanges()







            End If


        Next

        Return output

    End Function










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

        ErrHandler2.WriteError("ImprimirFacturaElectronica idfac " & IdFactura) ' & " " & Encriptar(SC))

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
            ErrHandler2.WriteError("Problema de acceso en el directorio de plantillas. Verificar permisos. " & ex.ToString)
            Throw
        End Try

        ErrHandler2.WriteError("Creando docx")


        CartaDePorteManager.FacturaXML_DOCX_Williams(output, ofac, SC)

        ErrHandler2.WriteError("docx creado")

        Dim ocli = ClienteManager.GetItem(SC, ofac.IdCliente)


        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim tipoafip = db.TiposComprobantes.First().CodigoAFIP_Letra_A

        ' cuit, tipo_cbte, punto_vta, cae, fch_venc_cae
        'Dim barras As String = "202675653930240016120303473904220110529"


        ErrHandler2.WriteError("Creando codigo barras")

        Dim imagen = barras.crear(ocli.Cuit.Replace("-", ""), _
                                  JustificadoDerecha(tipoafip, 2, "0"), _
                                  JustificadoDerecha(ofac.PuntoVenta, 4, "0"), _
                                  JustificadoDerecha(ofac.CAE, 14, "0"), _
                                  ofac.FechaVencimientoORechazoCAE.Date.ToString("yyyyMMdd"))





        ErrHandler2.WriteError("Creando pdf")
        Try

            output = ConvertirEnPDF_y_PonerCodigoDeBarras(output, imagen, bMostrarPDF)


        Catch ex As Exception


            '            When you first launch Word programmatically, it connects to Word via an RPC server. When you close the document, this server gets closed without your application knowing about it.

            'The solution is to trap an error and re-initialise your Word object. you will then be able to continue.

            '            George()

            '            Brisbane()

            '()

            '            Log Entry
            '03/28/2016 13:46:10
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/FacturaElectronicaEncriptada.aspx?Modo=DescargaFactura&Id=hWpifvVkVRg=. Error Message:System.Runtime.InteropServices.COMException
            'The remote procedure call failed. (Exception from HRESULT: 0x800706BE)
            '            at Microsoft.Office.Interop.Word.ApplicationClass.get_Documents()
            '   at CartaDePorteManager.ConvertirEnPDF_y_PonerCodigoDeBarras(String output, String fImagenBarras, Boolean bMostrarPDF) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\ManagerDebug\CartaDePorteManager.vb:line 11325
            '            Microsoft.Office.Interop.Word()
            '            __________________________()

            '            Log Entry
            '03/28/2016 13:46:10
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/FacturaElectronicaEncriptada.aspx?Modo=DescargaFactura&Id=hWpifvVkVRg=. Error Message:System.NullReferenceException
            'Object reference not set to an instance of an object.
            '   at System.Runtime.InteropServices.Marshal.ReleaseComObject(Object o)
            '   at ProntoDebug.NAR(Object o)
            '            mscorlib()
            '            __________________________()

            '            Log Entry
            '03/28/2016 13:46:10
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/FacturaElectronicaEncriptada.aspx?Modo=DescargaFactura&Id=hWpifvVkVRg=. Error Message:System.Runtime.InteropServices.COMException
            'The RPC server is unavailable. (Exception from HRESULT: 0x800706BA)
            '   at Microsoft.Office.Interop.Word.ApplicationClass.Quit(Object& SaveChanges, Object& OriginalFormat, Object& RouteDocument)
            '   at CartaDePorteManager.ConvertirEnPDF_y_PonerCodigoDeBarras(String output, String fImagenBarras, Boolean bMostrarPDF) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\ManagerDebug\CartaDePorteManager.vb:line 11386
            '            Microsoft.Office.Interop.Word()


        End Try






        ErrHandler2.WriteError("salgo")

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

                'oDoc.ExportAsFixedFormat(output, Word.WdExportFormat.wdExportFormatPDF, False, Word.WdExportOptimizeFor.wdExportOptimizeForOnScreen, _
                '    Word.WdExportRange.wdExportAllDocument, 1, 1, Word.WdExportItem.wdExportDocumentContent, True, True, _
                '    Word.WdExportCreateBookmarks.wdExportCreateHeadingBookmarks, True, True, False, Nothing)

            Else

                If Not bMostrarPDF Then

                    oDoc.SaveAs(output)

                Else
                    output += ".pdf"
                    oDoc.SaveAs(output, 17, , , , , , True)
                    'oDoc.SaveAs(output, Word.WdSaveFormat.wdFormatPDF, , , , , , True)

                End If
            End If

            oDoc.Close(False)

        Catch ex As Exception



            '        Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/Factura.aspx?Id=81889. Error Message:System.InvalidCastException
            'Unable to cast COM object of type 'Microsoft.Office.Interop.Word.ApplicationClass' to interface type 'Microsoft.Office.Interop.Word._Application'. This operation failed because the QueryInterface call on the COM component for the interface with IID '{00020970-0000-0000-C000-000000000046}' failed due to the following error: The RPC server is unavailable. (Exception from HRESULT: 0x800706BA).
            '   at System.StubHelpers.StubHelpers.GetCOMIPFromRCW(Object objSrc, IntPtr pCPCMD, Boolean& pfNeedsRelease)
            '            at Microsoft.Office.Interop.Word.ApplicationClass.get_Documents()
            '   at CartaDePorteManager.ConvertirEnPDF_y_PonerCodigoDeBarras(String output, String fImagenBarras, Boolean bMostrarPDF) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\ManagerDebug\CartaDePorteManager.vb:line 11693
            '            mscorlib()


            'http://stackoverflow.com/questions/22340518/unable-to-cast-com-object-of-office-interop-word
            'http://stackoverflow.com/questions/12957595/error-accessing-com-components

            ErrHandler2.WriteError(ex)
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
                ErrHandler2.WriteError(ex)
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
        '    ErrHandler2.WriteError(ex)
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
                ErrHandler2.WriteError(ex)
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


                regexReplace2(docText, "#Cliente#", oFac.Cliente.RazonSocial.Replace("&", "Y"))
                regexReplace2(docText, "#CodigoCliente#", oFac.Cliente.CodigoCliente)


                regexReplace2(docText, "#Direccion#", oFac.Cliente.Direccion) 'oFac.Domicilio)
                'regexReplace2(docText, "#DomicilioRenglon2#", oFac.Domicilio) 'oFac.Domicilio)


                regexReplace2(docText, "#Localidad#", NombreLocalidad(SC, oFac.Cliente.IdLocalidad)) 'oFac.Domicilio)

                regexReplace2(docText, "#CodPostal#", oFac.Cliente.CodigoPostal)
                regexReplace2(docText, "#Provincia#", NombreProvincia(SC, oFac.Cliente.IdProvincia))

                regexReplace2(docText, "#CUIT#", oFac.Cliente.Cuit)
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            regexReplace2(docText, "#NumeroFactura#", JustificadoDerecha(oFac.Numero, 8, "0"))
            regexReplace2(docText, "#PV#", JustificadoDerecha(oFac.PuntoVenta, 4, "0"))
            regexReplace2(docText, "#Fecha#", oFac.Fecha)


            oFac.CondicionVentaDescripcion = NombreCondicionVenta_y_Compra(SC, oFac.IdCondicionVenta)
            oFac.CondicionIVADescripcion = NombreCondicionIVA(SC, oFac.IdCodigoIva)

            regexReplace2(docText, "#CondicionIVA#", oFac.CondicionIVADescripcion)
            regexReplace2(docText, "#CondicionVenta#", oFac.CondicionVentaDescripcion)







            'hay que agregar lo de la http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=12175
            'mostrar el numero de orden de compra
            Dim numeroordencompra As String
            Try

                numeroordencompra = EntidadManager.ExecDinamico(SC, "SELECT numeroordencompraexterna from facturas where idfactura=" & oFac.Id.ToString).Rows(0).Item(0).ToString()
            Catch ex As Exception

                ErrHandler2.WriteError(ex)
            End Try

            If numeroordencompra <> "" Then
                regexReplace2(docText, "#OrdenCompra#", "N° Orden Compra: " & numeroordencompra)
            Else
                regexReplace2(docText, "#OrdenCompra#", "")
            End If



            Dim posObs As Integer
            posObs = InStr(oFac.Observaciones, "Periodo") - 1
            If posObs <= 0 Then posObs = 1


            regexReplace2(docText, "#CorredorEnObservaciones#", Left(oFac.Observaciones, posObs).Replace("&", " "))


            regexReplace2(docText, "#ObservacionesSinIncluirCorredor#", Mid(oFac.Observaciones, posObs))



            Dim SyngentaLeyenda = LogicaFacturacion.LeyendaSyngenta(oFac.Id, SC) 'oFac.Cliente.AutorizacionSyngenta
            regexReplace2(docText, "#LeyendaSyngenta#", SyngentaLeyenda)


            'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13220
            '            - Generar Facturas separadas por acopio automáticamente y en la impresión agregar una
            '  leyenda luego del detalle con el nombre del mismo
            '            Con respecto a la impresión, prevalece siempre la del facturar a.
            'Si tiene ese dato, no hay que darle importancia al de la CP propiamente dicha, tanto para filtrar la carta, como para la impresión.
            'Con respecto al "cruce" de acopios, yo les pregunte y me dijeron que no es posible, que las cartas de un cliente nunca van a otro.


            Dim LeyendaAcopio = ""
            If oFac.IdCliente = 2775 Or oFac.IdCliente = 10 Then 'LDC o ACA
                Try
                    LeyendaAcopio = LogicaFacturacion.LeyendaAcopio(oFac.Id, SC) 'oFac.Cliente.AutorizacionSyngenta
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try
            End If

            regexReplace2(docText, "#LeyendaAcopios#", LeyendaAcopio)


            'http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=20516
            'Dim EsElevacionLDC As Boolean = (oFac.IdCliente = 2775 And LogicaFacturacion.EsDeExportacion(oFac.Id, SC))
            Dim EsElevacionLDC As Boolean = LogicaFacturacion.EsDeExportacion(oFac.Id, SC)



            'regexReplace2(docText, "#Observaciones#", oFac.Observaciones)
            'regexReplace2(docText, "lugarentrega", oFac.LugarEntrega)




            'NO USAR. El reemplazo del pie está al final de esta funcion
            'NO USAR. El reemplazo del pie está al final de esta funcion
            'NO USAR. El reemplazo del pie está al final de esta funcion
            'NO USAR. El reemplazo del pie está al final de esta funcion
            'regexReplace2(docText, "#Subtotal#", oFac.SubTotal)  'NO USAR. El reemplazo del pie está al final de esta funcion
            'regexReplace2(docText, "#IVA#", oFac.ImporteIva1)
            'regexReplace2(docText, "#Total#", oFac.Total)









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
                ErrHandler2.WriteError("Ver si hay caracteres extraños. Error por el & en la razon social 'CAIO BABILONI & etc'  ")
                ErrHandler2.WriteError("archivo:" & document & "  IdFac:" & oFac.Id & "    Error: " & ex.ToString)
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
                ErrHandler2.WriteError(ex)
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




                        CeldaReemplazosFactura_Williams(dupRow, CeldaColumna, i, oFac.Cliente.IncluyeTarifaEnFactura = "SI", SC, oFac.Id, EsElevacionLDC)


                        '///////////////////////////
                        'renglon 2
                        '///////////////////////////

                        '    CeldaReemplazos(dupRow2, CeldaColumna, i)
                        '    table.AppendChild(dupRow2)



                    Catch ex As Exception
                        ErrHandler2.WriteError(ex)
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

                regexReplace2(docText, "observaciones", oFac.Observaciones)
                regexReplace2(docText, "lugarentrega", oFac.LugarEntrega)
                regexReplace2(docText, "libero", oFac.Aprobo)
                regexReplace2(docText, "fecharecepcion", oFac.Fecha)
                regexReplace2(docText, "jefesector", "")

                regexReplace2(docText, "#Subtotal#", "$ " + FF2(FF2(oFac.Total) - FF2(oFac.ImporteIva1) - oFac.IBrutos))
                regexReplace2(docText, "#PorcIVA#", oFac.PorcentajeIva1.ToString("0.0", System.Globalization.CultureInfo.InvariantCulture))
                regexReplace2(docText, "#IVA#", "$ " + FF2(oFac.ImporteIva1))
                regexReplace2(docText, "#IIBB#", oFac.IBrutos)
                regexReplace2(docText, "#Total#", "$ " + FF2(oFac.Total))

                regexReplace2(docText, "#TotalPalabras#", "Pesos " + Numalet.ToCardinal(oFac.Total))

                regexReplace2(docText, "#CAE#", oFac.CAE)
                regexReplace2(docText, "#VenceCAE#", oFac.FechaVencimientoORechazoCAE)







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


                    regexReplace2(docText, "#Cliente#", oFac.Cliente.RazonSocial.Replace("&", "Y"))
                    regexReplace2(docText, "#CodigoCliente#", oFac.Cliente.CodigoCliente)


                    regexReplace2(docText, "#Direccion#", oFac.Cliente.Direccion) 'oFac.Domicilio)
                    'regexReplace2(docText, "#DomicilioRenglon2#", oFac.Domicilio) 'oFac.Domicilio)


                    regexReplace2(docText, "#Localidad#", NombreLocalidad(SC, oFac.Cliente.IdLocalidad)) 'oFac.Domicilio)

                    regexReplace2(docText, "#CodPostal#", oFac.Cliente.CodigoPostal)
                    regexReplace2(docText, "#Provincia#", NombreProvincia(SC, oFac.Cliente.IdProvincia))

                    regexReplace2(docText, "#CUIT#", oFac.Cliente.Cuit)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try

                regexReplace2(docText, "#NumeroFactura#", oFac.Numero)
                regexReplace2(docText, "#Fecha#", oFac.Fecha)


                oFac.CondicionVentaDescripcion = NombreCondicionVenta_y_Compra(SC, oFac.IdCondicionVenta)
                oFac.CondicionIVADescripcion = NombreCondicionIVA(SC, oFac.IdCodigoIva)

                regexReplace2(docText, "#CondicionIVA#", oFac.CondicionIVADescripcion)
                regexReplace2(docText, "#CondicionVenta#", oFac.CondicionVentaDescripcion)



                regexReplace2(docText, "#CAE#", oFac.CAE)





                Dim posObs As Integer
                posObs = InStr(oFac.Observaciones, "Periodo") - 1
                If posObs <= 0 Then posObs = 1


                regexReplace2(docText, "#CorredorEnObservaciones#", Left(oFac.Observaciones, posObs).Replace("&", " "))


                regexReplace2(docText, "#ObservacionesSinIncluirCorredor#", Mid(oFac.Observaciones, posObs))
                'si se hizo por Pronto, mostrar las observaciones al final
                'pero cómo sé? -mostrar si no tiene periodo
                'If posObs <= 0 Then Selection.TypeText(Text:=oRs.Fields("Observaciones").Value)


                'regexReplace2(docText, "#Observaciones#", oFac.Observaciones)
                'regexReplace2(docText, "lugarentrega", oFac.LugarEntrega)




                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'regexReplace2(docText, "#Subtotal#", oFac.SubTotal)  'NO USAR. El reemplazo del pie está al final de esta funcion
                'regexReplace2(docText, "#IVA#", oFac.ImporteIva1)
                'regexReplace2(docText, "#Total#", oFac.Total)




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
                    ErrHandler2.WriteError("Ver si hay caracteres extraños. Error por el & en la razon social 'CAIO BABILONI & etc'  ")
                    ErrHandler2.WriteError("archivo:" + document + "  IdFac:" + oFac.Id + "    Error: " + ex.ToString)
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
                    ErrHandler2.WriteError(ex)
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





                Dim EsElevacionLDC As Boolean = (oFac.IdCliente = 2775 And LogicaFacturacion.EsDeExportacion(oFac.Id, SC))


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

                            CeldaReemplazosFactura_Williams(dupRow, CeldaColumna, i, oFac.Cliente.IncluyeTarifaEnFactura = "SI", SC, oFac.Id, EsElevacionLDC)


                            '///////////////////////////
                            'renglon 2
                            '///////////////////////////

                            '    CeldaReemplazos(dupRow2, CeldaColumna, i)
                            '    table.AppendChild(dupRow2)



                        Catch ex As Exception
                            ErrHandler2.WriteError(ex)
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

                    regexReplace2(docText, "observaciones", oFac.Observaciones)
                    regexReplace2(docText, "lugarentrega", oFac.LugarEntrega)
                    regexReplace2(docText, "libero", oFac.Aprobo)
                    regexReplace2(docText, "fecharecepcion", oFac.Fecha)
                    regexReplace2(docText, "jefesector", "")

                    regexReplace2(docText, "#Subtotal#", "$ " + FF2(FF2(oFac.Total) - FF2(oFac.ImporteIva1) - oFac.IBrutos))
                    regexReplace2(docText, "#PorcIVA#", oFac.PorcentajeIva1.ToString("0.0", System.Globalization.CultureInfo.InvariantCulture))
                    regexReplace2(docText, "#IVA#", "$ " + FF2(oFac.ImporteIva1))
                    regexReplace2(docText, "#IIBB#", oFac.IBrutos)
                    regexReplace2(docText, "#Total#", "$ " + FF2(oFac.Total))

                    regexReplace2(docText, "#TotalPalabras#", "Pesos " + Numalet.ToCardinal(oFac.Total))


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

    Shared Sub CeldaReemplazosFactura_Williams(ByRef row As Wordprocessing.TableRow, ByVal numcelda As Integer, ByVal itemFactura As Pronto.ERP.BO.FacturaItem, IncluyeTarifaEnFactura As Boolean, SC As String, idfactura As Integer, EsElevacionLDC As Boolean)


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

        regexReplace2(texto, "#Numero#", iisNull(itemFactura.NumeroItem))



        If iisNull(itemFactura.Articulo) <> "CAMBIO DE CARTA DE PORTE" Then
            regexReplace2(texto, "#Cant#", Int(iisNull(itemFactura.Cantidad) * 1000)) 'dfdfdfdf  ehhhh? no se graban los decimales.... no tengo tantos decimales para la cantidad
        Else
            regexReplace2(texto, "#Cant#", Int(iisNull(itemFactura.Cantidad))) 'dfdfdfdf  ehhhh? no se graban los decimales.... no tengo tantos decimales para la cantidad
        End If
        'te mató lo del int!!!!!




        regexReplace2(texto, "Unidad", iisNull(itemFactura.Unidad))
        regexReplace2(texto, "Codigo", iisNull(itemFactura.Codigo))


        If IncluyeTarifaEnFactura Then
            regexReplace2(texto, "#Precio#", Math.Round(iisNull(itemFactura.Precio), 2))
        Else
            regexReplace2(texto, "#Precio#", "")
        End If





        regexReplace2(texto, "#Importe#", FF2(iisNull(itemFactura.Precio) * iisNull(itemFactura.Cantidad)))
        regexReplace2(texto, "#Descripcion#", iisNull(itemFactura.Articulo))
        regexReplace2(texto, "FechaEntrega", iisNull(itemFactura.FechaEntrega))






        '///////////////////////////////////////////

        '///////////////////////////////////////////

        '///////////////////////////////////////////

        '///////////////////////////////////////////


        Dim mvarArticulo As String = iisNull(itemFactura.Observaciones)
        Dim posx
        posx = InStr(mvarArticulo, "__")
        If posx > 2 Then mvarArticulo = Left(mvarArticulo, posx - 2)
        mvarArticulo = Trim(mvarArticulo)




        If EsElevacionLDC Then mvarArticulo = "ELEVACION " & mvarArticulo


        regexReplace2(texto, "#ObsItem#", mvarArticulo.Replace("&", ""))



        '///////////////////////////////////////////

        '///////////////////////////////////////////

        '///////////////////////////////////////////

        '///////////////////////////////////////////

        '///////////////////////////////////////////



        'si se hizo por Pronto, mostrar las observaciones al final
        'pero cómo sé? -mostrar si no tiene periodo
        'If posObs <= 0 Then Selection.TypeText(Text:=oRs.Fields("Observaciones").Value)


        '///////////////////////////////////////////




        '        Log Entry
        '04/13/2015 10:20:20
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/Factura.aspx?Id=69458. Error Message:System.Xml.XmlException
        'An error occurred while parsing EntityName. Line 1, position 790.
        '   at System.Xml.XmlTextReaderImpl.Throw(Exception e)
        '   at System.Xml.XmlTextReaderImpl.HandleEntityReference(Boolean isInAttributeValue, EntityExpandType expandType, Int32& charRefEndPos)
        '   at System.Xml.XmlTextReaderImpl.ParseText(Int32& startPos, Int32& endPos, Int32& outOrChars)
        '        at System.Xml.XmlTextReaderImpl.FinishPartialValue()
        '        at System.Xml.XmlTextReaderImpl.get_Value()
        '   at DocumentFormat.OpenXml.OpenXmlLeafTextElement.Populate(XmlReader xmlReader, OpenXmlLoadMode loadMode)
        '   at DocumentFormat.OpenXml.OpenXmlElement.Load(XmlReader xmlReader, OpenXmlLoadMode loadMode)
        '   at DocumentFormat.OpenXml.OpenXmlCompositeElement.Populate(XmlReader xmlReader, OpenXmlLoadMode loadMode)
        '   at DocumentFormat.OpenXml.OpenXmlElement.Load(XmlReader xmlReader, OpenXmlLoadMode loadMode)
        '   at DocumentFormat.OpenXml.OpenXmlCompositeElement.Populate(XmlReader xmlReader, OpenXmlLoadMode loadMode)
        '   at DocumentFormat.OpenXml.OpenXmlElement.Load(XmlReader xmlReader, OpenXmlLoadMode loadMode)
        '   at DocumentFormat.OpenXml.OpenXmlCompositeElement.Populate(XmlReader xmlReader, OpenXmlLoadMode loadMode)
        '   at DocumentFormat.OpenXml.OpenXmlElement.Load(XmlReader xmlReader, OpenXmlLoadMode loadMode)
        '   at DocumentFormat.OpenXml.OpenXmlCompositeElement.Populate(XmlReader xmlReader, OpenXmlLoadMode loadMode)
        '        at DocumentFormat.OpenXml.OpenXmlElement.ParseXml()
        '        at DocumentFormat.OpenXml.OpenXmlElement.MakeSureParsed()
        '        at DocumentFormat.OpenXml.OpenXmlCompositeElement.get_FirstChild()
        '   at DocumentFormat.OpenXml.OpenXmlCompositeElement.set_InnerXml(String value)
        '   at CartaDePorteManager.CeldaReemplazosFactura_Williams(TableRow& row, Int32 numcelda, FacturaItem itemFactura, Boolean IncluyeTarifaEnFactura)
        '   at CartaDePorteManager.FacturaXML_DOCX_Williams(String document, Factura oFac, String SC)
        '        System.Xml()

        'creo que explota acá -explotó por el "&"
        Try
            row.InnerXml = texto
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            ErrHandler2.WriteError(texto)
        End Try


    End Sub





























    Shared Function usuariosBLD(SC As String) As List(Of String)
        Dim aaa As String = iisNull(ParametroManager.TraerValorParametro2(SC, "EsClienteBLDcorredor"), "") _
                            + "|" + iisNull(ParametroManager.TraerValorParametro2(SC, "EsClienteBLDcorredor2"), "") _
                            + "|" + iisNull(ParametroManager.TraerValorParametro2(SC, "EsClienteBLDcorredor3"), "")

        Dim sss = aaa.Split("|").ToList
        sss.Add("BLDCORREDOR")
        sss.Add("BLD_ALABERN")
        Return sss
    End Function




    Shared Function EsClienteBLDcorredor(SC As String) As Boolean
        ' Dim sss = {"aasdasd", "BLDCORREDOR"}
        Dim a = Membership.GetUser()


        If usuariosBLD(SC).Contains(a.UserName) Then
            Return True
        Else
            Return False
        End If
    End Function


    Shared Function TraerCUITClientesSegunUsuario(usuario As String, SC As String) As List(Of String)

        'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultasCumplidos1.php?recordid=14187


        Dim a0() As String = iisNull(ParametroManager.TraerValorParametro2(SC, "BLDcorredorCUITsLista0"), "").Split("|")
        Dim a1() As String = iisNull(ParametroManager.TraerValorParametro2(SC, "BLDcorredorCUITsLista1"), "").Split("|")
        Dim a2() As String = iisNull(ParametroManager.TraerValorParametro2(SC, "BLDcorredorCUITsLista2"), "").Split("|")

    

        Dim c1() As String = { _
                                      "20268165178" _
                                    , "20081166383" _
                                    , "20237107870" _
                                    , "20179767326" _
                                    , "30707451013" _
                                    , "30669360750" _
                                    , "30712119698" _
                                    , "30712362819" _
                                    , "23230854149" _
                                    , "xxxxxxxxxxx" _
                                    , "27147533174" _
                                    , "27126988066" _
                                    , "20207552489" _
                                    , "20249152553" _
                                    , "xxxxxxxxxxx" _
                                    , "20176398397" _
                                    , "30712353097" _
                                    , "30510718441" _
                                    , "xxxxxxxxxxx" _
                   }


        



        'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultasCumplidos1.php?recordid=20348
        Dim c2() As String = { _
                              "33708480849" _
                            , "30668239559" _
                            , "30707199896" _
                            , "20104910697" _
                            , "20060748978" _
                            , "30707149864" _
                            , "30708085916" _
                            , "30707355375" _
                            , "30709335304" _
                            , "30708968435" _
                            , "30587526944" _
                            , "30714315400" _
                            , "30714315753" _
                            , "30685688693" _
                            , "20172345205" _
                            , "30708848154" _
                            , "30624243982" _
                            , "33708339569" _
                            , "20201743894" _
                            , "30585806281" _
                            , "30708359366" _
                            , "20061702424" _
                            , "20130469370" _
                            , "20060418080" _
                            , "20237408706" _
                            , "30542418288" _
                            , "30579265201" _
                            , "30601456083" _
                            , "30541766452" _
                            , "30708486058" _
                            , "33714535639" _
                            , "30708134925" _
                            , "30681490465" _
                            , "30709077178" _
                            , "20146839232" _
                            , "30689194903" _
                            , "30708324546" _
                            , "30707120793" _
                            , "30710232268" _
                            , "30707062076" _
                            , "30711219389" _
                            , "30698540334" _
                            , "30641681551" _
                            , "20246137944" _
                            , "33569668919" _
                            , "30620514248" _
                            , "30708134925" _
                            , "30707120793" _
                            , "30500049460" _
                            , "xxxxxxxxxxx" _
                            }


        'http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=20848
        Dim c3() As String = { _
                     "30508255965" _
                    , "30708547758" _
                    , "30613957509" _
                    , "30550246771" _
                    , "30502793175" _
                    , "30712157107" _
                    , "30709054704" _
                    , "30590467010" _
                    , "27173198146" _
                    , "20220775640" _
                    , "30667622707" _
                    , "20162019873" _
                    , "23073814499" _
                    , "30710132395" _
                    , "33693971239" _
                    , "30714038911" _
                    , "20226532537" _
                    , "30552574822" _
                    , "20103905932" _
                    , "30710225733" _
                    , "30700522314" _
                    , "20085369645" _
                    , "30649229755" _
                    , "20170298358" _
                    , "30634408475" _
                    , "98927187872" _
                    , "33710880579" _
                    , "33631032929" _
                    , "20045814484" _
                    , "20135485501" _
                    , "24040384525" _
                    , "30714659258" _
                    , "20107656910" _
                    , "24113366210" _
                    , "30708724463" _
                    , "33615604599" _
                    , "30711806209" _
                    , "30691552590" _
                    , "33623538899" _
                    , "20108993627" _
                    , "20044232619" _
                    , "30709936812" _
                    , "30619381064" _
                    , "30688956427" _
                    , "30617007785" _
                    , "30711544646" _
                    , "30708363827" _
                    , "30665352893" _
                    , "30696150520" _
                    , "30714626945" _
                    , "30711955530" _
                    , "33710309529" _
                    , "33621155429" _
                    , "30708451629" _
                    , "23210571299" _
                    , "20176690772" _
                    , "20265609415" _
                    , "20303380605" _
                    , "27035489733" _
                    , "20229905830" _
                    , "20262092632" _
                    , "20185006183" _
                    , "27217201077" _
                    , "30707049843" _
                    , "20140057453" _
                    , "30711988099" _
                    , "30712210253" _
                    , "30710256507" _
                    , "30547406776" _
                    , "20226480723" _
                    , "30557861420" _
                    , "30607229828" _
                    , "30710194250" _
                    , "20175222791" _
                    , "27066336978" _
                    , "27050046414" _
                    , "20268133985" _
                    , "20125834621" _
                    , "20278570798" _
                    , "27226443237" _
                    , "30511824563" _
                    , "30708924985" _
                    , "30649023316" _
                    , "30683682302" _
                    , "30683044098" _
                    , "30709049565" _
                    , "30710822170" _
                    , "30710328427" _
                    , "30708414308" _
                    , "33709199779" _
                    , "30707818707" _
                    , "30683941499" _
                    , "30528794544" _
                    , "20238353948" _
                    , "30708855703" _
                    , "30710731604" _
                    , "27215151153" _
                    , "27054880206" _
                    , "20239541179" _
                    , "20220470718" _
                    , "30708418788" _
                    , "30711124108" _
                    , "20052568243" _
                    , "27124852515" _
                    , "20043838483" _
                    , "20121825075" _
                    , "30615426829" _
                    , "27042589255" _
                    , "30519261517" _
                    , "27004059730" _
                    , "20043578155" _
                    , "20266070641" _
                    , "33708285639" _
                    , "30619004449" _
                    , "20304689618" _
                    , "30711306958" _
                    , "30713609508" _
                    , "30707463259" _
                    , "20294464418" _
                    , "30709242993" _
                    , "33708714289" _
                    , "30711515719" _
                    , "20050615287" _
                    , "30711731020" _
                    , "20116593700" _
                    , "20228254488" _
                    , "27181169937" _
                    , "20300301593" _
                    , "20206542587" _
                    , "30712149562" _
                    , "30668774268" _
                    , "30696156499" _
                    , "33708414609" _
                    , "30708139846" _
                    , "30708729996" _
                    , "30667592565" _
                    , "30708508094" _
                    , "30538263431" _
                    , "30709917788" _
                    , "30565748811" _
                    , "30528749166" _
                    , "20122852580" _
                    , "20177302164" _
                    , "23125564909" _
                    , "20236836178" _
                    , "30644492563" _
                    , "30640655247" _
                    , "20129916924" _
                    , "30526381943" _
                    , "30710229372" _
                    , "30708047461" _
                    , "30501036125" _
                    , "20139950985" _
                    , "30709042390" _
                    , "30558314539" _
                    , "30595526511" _
                    , "30658938300" _
                    , "33708830599" _
                    , "33594705829" _
                    , "30552646750" _
                    , "30631839319" _
                    , "20052577447" _
                    , "20085369564" _
                    , "30553563182" _
                    , "30522189894" _
                    , "23182504114" _
                    , "27209562389" _
                    , "20939127977" _
                    , "23116523914" _
                    , "20043789083" _
                    , "30619509133" _
                    , "20122393136" _
                    , "20052561575" _
                    }


        c1 = c1.Union(a0).ToArray
        c2 = c2.Union(a1).ToArray
        c3 = c3.Union(a2).ToArray



        Dim lista2 = DirectCast(iisNull(ParametroManager.TraerValorParametro2(SC, "EsClienteBLDcorredor2"), "").Split("|"), IEnumerable(Of String)).ToList
        Dim lista3 = DirectCast(iisNull(ParametroManager.TraerValorParametro2(SC, "EsClienteBLDcorredor3"), "").Split("|"), IEnumerable(Of String)).ToList

        If lista3.Contains(usuario) Then
            Return c3.ToList

        ElseIf lista2.Contains(usuario) Then
            Return c2.ToList
        Else
            Return c1.ToList
        End If

    End Function




    Public Shared Function BajarListadoDeCartaPorte_DLL(usuario As String, password As String, fechadesde As DateTime, fechahasta As DateTime, SC As String, DirApp As String, ConexBDLmaster As String) As Byte()

        'var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
        '      DemoProntoEntities db = new DemoProntoEntities(scEF);

        'Dim IdCartaDePorte = EntidadManager.decryptQueryString(identificador)

        ' ir a http://codebeautify.org/base64-to-image-converter  para probar la respuesta
        ' ir a http://codebeautify.org/base64-to-image-converter  para probar la respuesta
        ' ir a http://codebeautify.org/base64-to-image-converter  para probar la respuesta

        Try

            'validar pass

            If Not Debugger.IsAttached Then
                If Not Membership.ValidateUser(usuario, password) Then
                    ErrHandler2.WriteError("No logra autenticarse")
                    Return Nothing
                End If
            End If




            'verificar q la carta tenga como cliente ese usuario
            'pero como se qué empresa tiene vinculada ese usuario?

            'agregar al where que aparezca la razon social de este cliente
            Dim rs As String
            Try
                Dim idusuario As String
                '
                If Debugger.IsAttached Then
                    idusuario = "920688e1-7e8f-4da7-a793-9d0dac7968e6"
                Else
                    idusuario = Membership.GetUser(usuario).ProviderUserKey.ToString
                End If

                rs = UserDatosExtendidosManager.TraerRazonSocialDelUsuario(idusuario, ConexBDLmaster, SC)
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                Return Nothing
            End Try


            Dim idcliente As Integer = BuscaIdClientePreciso(rs, SC)
            If idcliente <= 0 Then
                ErrHandler2.WriteError("No se encontró usuario equivalente")
                Return Nothing
            End If

            Const limitedecartas = 2222

       
         



            Dim dt As DataTable


            ' If cdp.Titular <> idcliente And cdp.CuentaOrden1 <> idcliente And cdp.CuentaOrden2 <> idcliente And cdp.Entregador <> idcliente And IdClienteEquivalenteDelIdVendedor(cdp.Corredor, SC) <> idcliente And _
            'IdClienteEquivalenteDelIdVendedor(cdp.Corredor2, SC) <> idcliente Then
            '     ErrHandler2.WriteError("La carta no corresponde al usuario")
            '     Return Nothing
            ' End If

            ' dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
            '               "", "", "", 1, 0, _
            '               estadofiltro, "", idVendedor, idCorredor, _
            '               idDestinatario, idIntermediario, _
            '               idRComercial, idArticulo, idProcedencia, idDestino, _
            '                                                 IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
            '                Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
            '               Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
            '                cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, True, txtContrato.Text, , idClienteAuxiliar, , , , )




            Dim FName As String

            'PDF
            Dim dataSet = New DataSet()
            dataSet.Tables.Add(dt)

            dataSet.WriteXml("C:\MyDataset.xml")







            Dim fs1 As System.IO.FileStream = Nothing
            fs1 = System.IO.File.Open("C:\MyDataset.xml", FileMode.Open, FileAccess.Read)
            Dim b1(fs1.Length) As Byte
            fs1.Read(b1, 0, fs1.Length)
            fs1.Close()
            Return b1

            ' ir a http://codebeautify.org/base64-to-image-converter  para probar la respuesta
            ' ir a http://codebeautify.org/base64-to-image-converter  para probar la respuesta
            ' ir a http://codebeautify.org/base64-to-image-converter  para probar la respuesta
            ' ir a http://codebeautify.org/base64-to-image-converter  para probar la respuesta

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            Return Nothing
        End Try

        'usaria la descarga que usa bld en el informe?

        'usando response para que baje el archivo


        'Response.Clear()
        'Response.ClearHeaders()
        'Response.ContentType = "text/html; charset=UTF-8"
        'Response.AddHeader("Content-Disposition", "attachment; filename=\"" & filePath & " \ "")
        'Response.AddHeader("Content-Length", b1.Length)
        'Response.OutputStream.Write(b1, 0, b1.Length)
        'Response.Flush()
        'Response.End()

        'pdfreducido()
        'oenjpg()


        'If Not b Then
        '    output = CartaDePorteManager.DescargarImagenesAdjuntas(dt, HFSC.Value, True)
        'Else
        '    output = CartaDePorteManager.DescargarImagenesAdjuntas_PDF(dt, HFSC.Value, False)
        'End If


    End Function
    Public Shared Function BajarImagenDeCartaPorte_DLL(usuario As String, password As String, numerocarta As Long, SC As String, DirApp As String, ConexBDLmaster As String) As Byte()

        'var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
        '      DemoProntoEntities db = new DemoProntoEntities(scEF);

        'Dim IdCartaDePorte = EntidadManager.decryptQueryString(identificador)

        ' ir a http://codebeautify.org/base64-to-image-converter  para probar la respuesta
        ' ir a http://codebeautify.org/base64-to-image-converter  para probar la respuesta
        ' ir a http://codebeautify.org/base64-to-image-converter  para probar la respuesta

        Try

            'validar pass

            If Not Debugger.IsAttached Then
                If Not Membership.ValidateUser(usuario, password) Then
                    ErrHandler2.WriteError("No logra autenticarse")
                    Return Nothing
                End If
            End If




            'verificar q la carta tenga como cliente ese usuario
            'pero como se qué empresa tiene vinculada ese usuario?

            'agregar al where que aparezca la razon social de este cliente
            Dim rs As String
            Try
                Dim idusuario As String
                '
                If Debugger.IsAttached Then
                    idusuario = "920688e1-7e8f-4da7-a793-9d0dac7968e6"
                Else
                    idusuario = Membership.GetUser(usuario).ProviderUserKey.ToString
                End If

                rs = UserDatosExtendidosManager.TraerRazonSocialDelUsuario(idusuario, ConexBDLmaster, SC)
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                Return Nothing
            End Try


            Dim idcliente As Integer = BuscaIdClientePreciso(rs, SC)
            If idcliente <= 0 Then
                ErrHandler2.WriteError("No se encontró usuario equivalente")
                Return Nothing
            End If

            Dim cdp = CartaDePorteManager.GetItemPorNumero(SC, numerocarta, 0, 0)

            If cdp.Titular <> idcliente And cdp.CuentaOrden1 <> idcliente And cdp.CuentaOrden2 <> idcliente And cdp.Entregador <> idcliente And IdClienteEquivalenteDelIdVendedor(cdp.Corredor, SC) <> idcliente And _
              IdClienteEquivalenteDelIdVendedor(cdp.Corredor2, SC) <> idcliente Then
                ErrHandler2.WriteError("La carta no corresponde al usuario")
                Return Nothing
            End If



            Dim FName As String
            If True Then

                'PDF
                FName = ImagenPDF(SC, cdp.Id, DirApp)

            Else

                'imagen

                Dim DIRFTP As String = DirApp & "\DataBackupear\"

                'Dim FilePath = System.IO.File.Open(FName, FileMode.Open, FileAccess.Read)
                'Dim  FullPath as string= ConfigurationManager.AppSettings["FilePath"]  + FilePath
                'Return File.ReadAllText(FullPath)

                FName = DIRFTP + cdp.PathImagen

            End If





            Dim fs1 As System.IO.FileStream = Nothing
            fs1 = System.IO.File.Open(FName, FileMode.Open, FileAccess.Read)
            Dim b1(fs1.Length) As Byte
            fs1.Read(b1, 0, fs1.Length)
            fs1.Close()
            Return b1

            ' ir a http://codebeautify.org/base64-to-image-converter  para probar la respuesta
            ' ir a http://codebeautify.org/base64-to-image-converter  para probar la respuesta
            ' ir a http://codebeautify.org/base64-to-image-converter  para probar la respuesta
            ' ir a http://codebeautify.org/base64-to-image-converter  para probar la respuesta

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            Return Nothing
        End Try

        'usaria la descarga que usa bld en el informe?

        'usando response para que baje el archivo


        'Response.Clear()
        'Response.ClearHeaders()
        'Response.ContentType = "text/html; charset=UTF-8"
        'Response.AddHeader("Content-Disposition", "attachment; filename=\"" & filePath & " \ "")
        'Response.AddHeader("Content-Length", b1.Length)
        'Response.OutputStream.Write(b1, 0, b1.Length)
        'Response.Flush()
        'Response.End()

        'pdfreducido()
        'oenjpg()


        'If Not b Then
        '    output = CartaDePorteManager.DescargarImagenesAdjuntas(dt, HFSC.Value, True)
        'Else
        '    output = CartaDePorteManager.DescargarImagenesAdjuntas_PDF(dt, HFSC.Value, False)
        'End If


    End Function

    Private Shared Function idClienteAuxiliar() As Object
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

        Try
            PyI25 = CreateObject("PyI25")
        Catch ex As Exception
            If Not Debugger.IsAttached Then
                MandarMailDeError("Falla la imagen del codigo de barras")
                Throw
            End If
            Return ""
        End Try





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



    Shared Function EnviarFacturaElectronicaEMail(desde As Integer, hasta As Integer, cliente As String, SC As String, bVistaPrevia As Boolean, sEmail As String) As String
        Dim listaf = New Generic.List(Of Integer)

        For idfac = desde To hasta
            listaf.Add(idfac)
        Next

        Return EnviarFacturaElectronicaEMail(listaf, cliente, SC, bVistaPrevia, sEmail)

    End Function




    Shared Function EnviarFacturaElectronicaEMail(ByVal Facturas As Generic.IList(Of Integer), cliente As String, SC As String, bVistaPrevia As Boolean, sEmail As String) As String



        Dim sErr As String


        For Each idfac In Facturas 'GetListaDeFacturasTildadas()

            Dim bMarcar As Boolean = True

            ErrHandler2.WriteError("idfac " & idfac)



            Dim fac = FacturaManager.GetItem(SC, idfac)

            If fac Is Nothing Then
                ErrHandler2.WriteError("idfac " & idfac & " no existe")
                Continue For
            End If





            Dim destinatario As String = ""

            Dim idcli As Integer
            Dim cli As ClienteNuevo
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
                destinatario = If(cli.EmailFacturacionElectronica, "")

            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try


            ErrHandler2.WriteError("cli " & idcli & " " & destinatario & " " & fac.IdVendedor & " " & fac.IdCliente)

            Try

                If destinatario = "" Then

                    If cli Is Nothing Then
                        sErr += "El cliente no tiene casilla de correo " + Environment.NewLine

                    Else
                        sErr += "El cliente " & NombreCliente(SC, idcli) & " no tiene casilla de correo " + Environment.NewLine
                        'cli.RazonSocial  no anda...
                    End If

                    bMarcar = False
                End If

            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                ErrHandler2.WriteError("cli está en null???? -NO. el problema es que destinatario ( que es un string) puede ser nothing " & sErr)
            End Try

            If Not bVistaPrevia And destinatario = "" Then
                Continue For
            End If


            If bVistaPrevia Then
                'destinatario = ConfigurationManager.AppSettings("ErrorMail") + "," + sEmail '+ "," + UsuarioSesion.Mail(SC, Session)
                destinatario = sEmail '+ "," + UsuarioSesion.Mail(SC, Session)
            Else
                'destinatario += "," + ConfigurationManager.AppSettings("ErrorMail") + "," + sEmail '+ + UsuarioSesion.Mail(SC, Session)
                destinatario += "," + sEmail '+ + UsuarioSesion.Mail(SC, Session)
            End If






            Dim numerodefactura As String = fac.TipoABC + "-" + JustificadoDerecha(fac.PuntoVenta.ToString(), 4, "0") + "-" + JustificadoDerecha(fac.Numero.ToString, 8, "0")


            If Not bVistaPrevia And VerificarEnviada(SC, idfac) Then
                'sErr += "La factura " & numerodefactura & " ya fue enviada antes" + Environment.NewLine
                'Continue For
            End If



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
                        "<br/>ATENCION: NO RESPONDER A ESTA DIRECCION DE MAIL, HACERLO A ciglesias@williamsentregas.com.ar; sgomez@williamsentregas.com.ar <br/>" & _
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


            '            http://190.17.29.12/Consultas/Admin/verConsultas1.php?recordid=13573
            '            Por favor en el asunto de los mails de facturacion que figure ATENCION: NO RESPONDER A ESTA DIRECCION DE MAIL, HACERLO A ciglesias@williamsentregas.com.ar; sgomez@williamsentregas.com.ar
            'Por favor si puede estar para la facturación del 2 de marzo.

            MandaEmail(destinatario, "Factura Electrónica Williams Entregas. " & numerodefactura & _
                       "", _
                     cuerpo, _
                      Usuario, _
                    ConfigurationManager.AppSettings("SmtpServer"), _
                    Usuario, _
                  pass, _
                            "", _
                      ConfigurationManager.AppSettings("SmtpPort"), , "facturacion@williamsentregas.com.ar", "", _
                      "Factura Electrónica Williams Entregas", _
                      "ciglesias@williamsentregas.com.ar, sgomez@williamsentregas.com.ar", True)


            LogPronto(SC, idfac, "FMAIL", Usuario, numerodefactura, destinatario, , )



            If bMarcar And Not bVistaPrevia Then MarcarEnviada(SC, idfac)

        Next





        'If sErr <> "" Then Throw New Exception(serr)
        sErr = "Envío Terminado " + Environment.NewLine + Environment.NewLine + sErr
        Return sErr

    End Function

    Shared Sub MarcarEnviada(SC As String, idfactura As Integer)

        ExecDinamico(SC, "update facturas set FueEnviadoCorreoConFacturaElectronica='SI' where idfactura=" & idfactura)

    End Sub


    Shared Function VerificarEnviada(SC As String, idfactura As Integer) As Boolean

        Dim dt = ExecDinamico(SC, "select FueEnviadoCorreoConFacturaElectronica from  facturas where idfactura=" & idfactura)

        Try
            If iisNull(dt(0).Item("FueEnviadoCorreoConFacturaElectronica")) = "SI" Then Return True Else Return False
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            Return False
        End Try


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
                ErrHandler2.WriteError("Problema al poner el punto de venta/centro de costo")
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

                ErrHandler2.WriteError("Problema al poner el punto de venta/centro de costo")
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
                ErrHandler2.WriteError("Problema al poner el punto de venta/centro de costo")
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
                ErrHandler2.WriteError("Problema al poner el punto de venta/centro de costo")
        End Select

        Return IdObra2
    End Function




    Public Shared Function NombrePuntoVentaWilliams4(ByVal pv As enumWilliamsPuntoVenta) As String

        Try
            Return [Enum].GetName(GetType(enumWilliamsPuntoVenta), pv)
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
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
            ErrHandler2.WriteError(ex)
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

        dt.Columns.Add("Nombre")
        dt.Rows.Clear()
        dt.Rows.Add()
        dt.Rows.Add()
        dt.Rows.Add()
        dt.Rows.Add()
        dt.Rows(0).Item("PuntoVenta") = 1
        dt.Rows(1).Item("PuntoVenta") = 2
        dt.Rows(2).Item("PuntoVenta") = 3
        dt.Rows(3).Item("PuntoVenta") = 4


        dt.Rows(0).Item("Nombre") = "1 - Buenos Aires"
        dt.Rows(1).Item("Nombre") = "2 - San Lorenzo"
        dt.Rows(2).Item("Nombre") = "3 - Arroyo Seco"
        dt.Rows(3).Item("Nombre") = "4 - Bahía Blanca"


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



    Public Shared Sub WilliamsFacturaWordToTxtMasMergeOpcional(Optional ByVal fileDirectory As String = "C:\documents\", Optional ByVal output As String = "Merged Document.doc", Optional ByVal plantillaDOT As Object = "", Optional sc As String = "", Optional DesdeIdFactura As Long = 0)
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
                    ErrHandler2.WriteError(ex)
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
                            ImpresoraMatrizDePuntosEPSONTexto.SacarTagsDePrecioUnitario(renglonesorig(n))
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
            ErrHandler2.WriteError(ex.ToString & " Error al hacer el merge de docs")
            Throw
            'MsgBoxAjax(Me, ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro.    Emision """ & DebugCadenaImprimible(Encriptar(HFSC.Value)) & "," & ID)
        Finally
        End Try

    End Sub

    Shared Sub SacarTagsDePrecioUnitario(ByRef s As String)
        Dim regex As New System.Text.RegularExpressions.Regex("(<PU.*?)(?:()+)(.*?)(</PU>)")

        'Dim newString = regex.Replace(s, "$1<a href=""$3"">$3</a>$4$5")
        s = regex.Replace(s, "")
    End Sub



    Public Shared Function ExcelToText(ByVal fileExcelName As String) As String
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
            'oXL = New Excel.ApplicationClass()
            'Typically, in .Net 4 you just need to remove the 'Class' suffix and compile the code:
            oXL = New Excel.Application()

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
            ErrHandler2.WriteError("No pudo extraer el excel. " + ex.ToString)
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
                ErrHandler2.WriteError("No pudo cerrar el servicio excel. " + ex.ToString)
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
            'oXL = New Excel.ApplicationClass()
            'Typically, in .Net 4 you just need to remove the 'Class' suffix and compile the code:
            oXL = New Excel.Application()

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
            ErrHandler2.WriteError("No pudo extraer el excel. " + ex.ToString)
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
                ErrHandler2.WriteError("No pudo cerrar el servicio excel. " + ex.ToString)
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
                'oXL = New Excel.ApplicationClass()
                'Typically, in .Net 4 you just need to remove the 'Class' suffix and compile the code:
                oXL = New Excel.Application()

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

                ErrHandler2.WriteError("error en el open. " + fileExcelName + "   " + ex.ToString)

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
            ErrHandler2.WriteError("No pudo extraer el excel. " + ex.ToString)
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
                ErrHandler2.WriteError("No pudo cerrar el servicio excel. " + ex.ToString)
            End Try
        End Try
    End Function



    Public Shared Function ExcelToTextNotasDeEntrega(ByVal fileExcelName As String) As String
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
            'oXL = New Excel.ApplicationClass()
            'Typically, in .Net 4 you just need to remove the 'Class' suffix and compile the code:
            oXL = New Excel.Application()

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
                ErrHandler2.WriteError("Limite de Notas de entrega " & oWB.Worksheets.Count)
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
            ErrHandler2.WriteError("No pudo extraer el excel. " + ex.ToString)
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
                ErrHandler2.WriteError("No pudo cerrar el servicio excel. " + ex.ToString)
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





Public Class CDPMailFiltrosManager2




    Const Tabla = "WilliamsMailFiltros"
    Const IdTabla = "IdWilliamsMailFiltro"
    Shared tipofiltro As Object

    '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx


    Public Shared Function TraerMetadata(ByVal SC As String, Optional ByVal id As Integer = -1) As DataTable
        If id = -1 Then
            Return ExecDinamico(SC, "select * from WilliamsMailFiltros where 1=0")
        Else
            Return ExecDinamico(SC, "select * from WilliamsMailFiltros where idWilliamsMailFiltro=" & id)
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
        Try
            myConnection.Open()

            Dim adapterForTable1 = New SqlDataAdapter("select * from WilliamsMailFiltros", myConnection)
            Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
            adapterForTable1.Update(dt)
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        Finally
            myConnection.Close()

        End Try


    End Function


    Public Shared Function Insert(ByVal SC As String, ByVal o As CDPMailFiltro) As Integer
        '// Write your own Insert statement blocks 

        With o
            ExecDinamico(SC, String.Format("INSERT INTO " & Tabla & " (Emails, IdArticulo, FechaDesde, FechaHasta,    Orden, Modo,  Vendedor,   CuentaOrden1,   CuentaOrden2,  Corredor,  Entregador,  Contrato,  Destino,  Procedencia,  EsPosicion,  AplicarANDuORalFiltro) " & _
                                                             "VALUES ( '{0}',      {1}    ,'{2}'      ,'{3}'        ,{4}    ,'{5}'    ,{6}        ,{7}            ,{8}            ,{9}        ,{10}       ,'{11}'      ,{12}   ,{13}       ,'{14}'           ,'{15}' ) ", _
                                                                      .Emails, .IdArticulo, .FechaDesde, .FechaHasta, .Orden, .Modo, .Vendedor, .CuentaOrden1, .CuentaOrden2, .Corredor, .Entregador, .Contrato, .Destino, .Procedencia, .EsPosicion, .AplicarANDuORalFiltro))
        End With
    End Function





    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    'Public Shared Function generarWHEREparaSQL(ByVal sc As String, ByVal dr As Data.DataRow, ByRef sTituloFiltroUsado As String, ByVal estado As CartaDePorteManager.enumCDPestado, ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, ByVal puntoventa As Integer) As String

    '    Dim strWHERE As String = "    WHERE 1=1 "

    '    With dr



    '        Dim idVendedor = .Item("Vendedor")
    '        Dim idCorredor = .Item("Corredor")
    '        Dim idDestinatario = .Item("Entregador")
    '        Dim idIntermediario = .Item("CuentaOrden1")
    '        Dim idRemComercial = .Item("CuentaOrden2")
    '        Dim idArticulo = .Item("IdArticulo")
    '        Dim idProcedencia = .Item("Procedencia")
    '        Dim idDestino = .Item("Destino")









    '        If iisNull(.Item("QueContenga")) <> "" Then
    '            Dim idVendedorQueContiene = BuscaIdClientePreciso(.Item("QueContenga"), sc)
    '            Dim idCorredorQueContiene = BuscaIdVendedorPreciso(.Item("QueContenga"), sc)

    '            If idVendedor <> -1 Or idCorredor <> -1 Then
    '                strWHERE += "  " & _
    '                 "           AND (Vendedor = " & idVendedor & _
    '                "           OR CuentaOrden1 = " & idVendedor & _
    '                "           OR CuentaOrden2 = " & idVendedor & _
    '                "             OR Corredor=" & idCorredor & _
    '                "             OR Entregador=" & idVendedor & ")"
    '            End If


    '        End If



    '        If iisNull(.Item("AplicarANDuORalFiltro")) = "1" Then
    '            strWHERE += iisIdValido(idVendedor, "           AND CDP.Vendedor = " & idVendedor, "") & _
    '                    iisIdValido(idCorredor, "             AND CDP.Corredor=" & idCorredor, "") & _
    '                    iisIdValido(idIntermediario, "             AND CDP.CuentaOrden1=" & idIntermediario, "") & _
    '                    iisIdValido(idRemComercial, "             AND CDP.CuentaOrden2=" & idRemComercial, "") & _
    '                    iisIdValido(idDestinatario, "             AND  CDP.Entregador=" & idDestinatario, "")
    '        Else
    '            Dim s = " AND (1=0 " & _
    '                     iisIdValido(idVendedor, "           OR CDP.Vendedor = " & idVendedor, "") & _
    '                    iisIdValido(idCorredor, "             OR CDP.Corredor=" & idCorredor, "") & _
    '                    iisIdValido(idIntermediario, "             OR CDP.CuentaOrden1=" & idIntermediario, "") & _
    '                    iisIdValido(idRemComercial, "             OR CDP.CuentaOrden2=" & idRemComercial, "") & _
    '                    iisIdValido(idDestinatario, "             OR  CDP.Entregador=" & idDestinatario, "") & _
    '                    "  )  "

    '            If s <> " AND (1=0   )  " Then strWHERE += s
    '        End If


    '        strWHERE += iisIdValido(idArticulo, "           AND CDP.IdArticulo=" & idArticulo, "")
    '        strWHERE += iisIdValido(idProcedencia, "             AND CDP.Procedencia=" & idProcedencia, "")
    '        strWHERE += iisIdValido(idDestino, "             AND CDP.Destino=" & idDestino, "")





    '        If estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas Then
    '            strWHERE += "    AND (isnull(FechaDescarga,'1/1/1753') Between '" & iisValidSqlDate(fechadesde, #1/1/1753#) & "' AND '" & iisValidSqlDate(fechahasta, #1/1/2100#) & "')"
    '        Else
    '            strWHERE += "    AND (isnull(FechaArribo,'1/1/1753') Between '" & iisValidSqlDate(fechadesde, #1/1/1753#) & "' AND '" & iisValidSqlDate(fechahasta, #1/1/2100#) & "')"
    '        End If

    '        If iisNull(.Item("modo")) = "Local" Then
    '            strWHERE += "  AND ISNULL(CDP.Exporta,'NO')='NO'  "
    '        ElseIf iisNull(.Item("modo")) = "Export" Then
    '            strWHERE += "  AND ISNULL(CDP.Exporta,'NO')='SI'  "
    '        End If


    '        If puntoventa > 0 Then
    '            strWHERE += "AND (PuntoVenta=" & puntoventa & ")"  ' OR PuntoVenta=0)"  'lo del punto de venta=0 era por las importaciones donde alguien (con acceso a todos los puntos de venta) no tenía donde elegir cual 
    '        End If

    '        Dim desde As String = iisValidSqlDate(fechadesde.ToString)
    '        Dim hasta As String = iisValidSqlDate(fechahasta.ToString)
    '        'no se por qué no está andando el formateaFecha
    '        'Dim hasta As String = formateaFecha(iisValidSqlDate(fechadesde.ToString))
    '        'Dim desde As String = formateaFecha(iisValidSqlDate(fechahasta.ToString))

    '        sTituloFiltroUsado &= String.Format(" {0} {1} {2} {3} {4} {5} {6} {7} {8} {9} {10} {11} {12}", _
    '                        IIf(IsDate(fechadesde) AndAlso fechadesde >= #1/1/1800#, "desde el " & FechaChica(desde), ""), _
    '                        IIf(IsDate(fechahasta) AndAlso fechahasta <= #1/1/2099#, "hasta el " & FechaChica(hasta), ""), _
    '                        "EXPORTA: " & iisNull(.Item("modo"), "NO"), _
    '                        "Punto de venta: " & IIf(puntoventa < 0, "Todos", puntoventa), _
    '                        "Criterio: " & IIf(iisNull(.Item("AplicarANDuORalFiltro")) = "1", "TODOS", "ALGUNOS"), _
    '                        IIf(Not IsDBNull(dr.Item("Vendedor")), "Titular: " & NombreCliente(sc, dr.Item("Vendedor")), ""), _
    '                        IIf(Not IsDBNull(dr.Item("CuentaOrden1")), "Intermediario " & NombreCliente(sc, dr.Item("CuentaOrden1")), ""), _
    '                        IIf(Not IsDBNull(dr.Item("CuentaOrden2")), "R.Comercial: " & NombreCliente(sc, dr.Item("CuentaOrden2")), ""), _
    '                        IIf(Not IsDBNull(dr.Item("Corredor")), "Corredor: " & NombreVendedor(sc, dr.Item("Corredor")), ""), _
    '                        IIf(Not IsDBNull(dr.Item("Entregador")), "Destinatario: " & NombreCliente(sc, dr.Item("Entregador")), ""), _
    '                        IIf(Not IsDBNull(dr.Item("Procedencia")), "Origen: " & NombreLocalidad(sc, dr.Item("Procedencia")), ""), _
    '                        IIf(Not IsDBNull(dr.Item("Destino")), "Destino: " & NombreDestino(sc, dr.Item("Destino")), ""), _
    '                        IIf(Not IsDBNull(dr.Item("IdArticulo")), "Producto: " & NombreArticulo(sc, dr.Item("IdArticulo")), "") _
    '                        )

    '        If Trim(sTituloFiltroUsado) = "" Then sTituloFiltroUsado = "(sin filtrar)"

    '    End With

    '    Return strWHERE
    'End Function





    Public Shared Function generarWHEREparaDataset(ByVal sc As String, ByVal dr As Data.DataRow, ByRef sTituloFiltroUsado As String, _
                                                   ByVal estado As CartaDePorteManager.enumCDPestado, _
                                                   ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, ByVal puntoventa As Integer) As String



        Dim strWHERE As String = "1=1 "

        With dr



            Dim idVendedor As Integer = iisNull(.Item("Vendedor"), -1)
            Dim idCorredor As Integer = iisNull(.Item("Corredor"), -1)
            Dim idDestinatario As Integer = iisNull(.Item("Entregador"), -1)
            Dim idIntermediario As Integer = iisNull(.Item("CuentaOrden1"), -1)
            Dim idRemComercial As Integer = iisNull(.Item("CuentaOrden2"), -1)
            Dim idArticulo As Integer = iisNull(.Item("IdArticulo"), -1)
            Dim idProcedencia As Integer = iisNull(.Item("Procedencia"), -1)
            Dim idDestino As Integer = iisNull(.Item("Destino"), -1)







            Try




                If iisNull(.Item("QueContenga")) <> "" Then
                    Dim idVendedorQueContiene = BuscaIdClientePreciso(.Item("QueContenga"), sc)
                    Dim idCorredorQueContiene = BuscaIdVendedorPreciso(.Item("QueContenga"), sc)

                    If idVendedor <> -1 Or idCorredor <> -1 Then
                        strWHERE += "  " & _
                         "           AND (Vendedor = " & idVendedor & _
                        "           OR CuentaOrden1 = " & idVendedor & _
                        "           OR CuentaOrden2 = " & idVendedor & _
                        "             OR Corredor=" & idCorredor & _
                        "             OR Entregador=" & idVendedor & ")"
                    End If


                End If





                If iisNull(.Item("AplicarANDuORalFiltro")) = "1" Then
                    strWHERE += iisIdValido(idVendedor, "           AND CDP.Vendedor = " & idVendedor, "") & _
                            iisIdValido(idCorredor, "             AND CDP.Corredor=" & idCorredor, "") & _
                            iisIdValido(idIntermediario, "             AND CDP.CuentaOrden1=" & idIntermediario, "") & _
                            iisIdValido(idRemComercial, "             AND CDP.CuentaOrden2=" & idRemComercial, "") & _
                            iisIdValido(idDestinatario, "             AND  CDP.Entregador=" & idDestinatario, "")
                Else
                    Dim s = " AND (1=0 " & _
                             iisIdValido(idVendedor, "           OR CDP.Vendedor = " & idVendedor, "") & _
                            iisIdValido(idCorredor, "             OR CDP.Corredor=" & idCorredor, "") & _
                            iisIdValido(idIntermediario, "             OR CDP.CuentaOrden1=" & idIntermediario, "") & _
                            iisIdValido(idRemComercial, "             OR CDP.CuentaOrden2=" & idRemComercial, "") & _
                            iisIdValido(idDestinatario, "             OR  CDP.Entregador=" & idDestinatario, "") & _
                            "  )  "

                    If s <> " AND (1=0   )  " Then strWHERE += s
                End If


                strWHERE += iisIdValido(idArticulo, "           AND CDP.IdArticulo=" & idArticulo, "")
                strWHERE += iisIdValido(idProcedencia, "             AND CDP.Procedencia=" & idProcedencia, "")
                strWHERE += iisIdValido(idDestino, "             AND CDP.Destino=" & idDestino, "")



                'If estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas Then
                '    strWHERE += "    AND (isnull(FechaDescarga,'1/1/1753') Between '" & iisValidSqlDate(fechadesde, #1/1/1753#) & "' AND '" & iisValidSqlDate(fechahasta, #1/1/2100#) & "')"
                'Else
                '    strWHERE += "    AND (isnull(FechaArribo,'1/1/1753') Between '" & iisValidSqlDate(fechadesde, #1/1/1753#) & "' AND '" & iisValidSqlDate(fechahasta, #1/1/2100#) & "')"
                'End If

                If iisNull(.Item("modo")) = "Entregas" Then
                    strWHERE += "  AND ISNULL(CDP.Exporta,'NO')='NO'  "
                ElseIf iisNull(.Item("modo")) = "Export" Then
                    strWHERE += "  AND ISNULL(CDP.Exporta,'NO')='SI'  "
                End If


                If puntoventa > 0 Then
                    strWHERE += "AND (PuntoVenta=" & puntoventa & ")"  ' OR PuntoVenta=0)"  'lo del punto de venta=0 era por las importaciones donde alguien (con acceso a todos los puntos de venta) no tenía donde elegir cual 
                End If

            Catch ex As Exception
                ErrHandler2.WriteError("Sector 1")
                Throw
            End Try


            Dim desde As String = iisValidSqlDate(fechadesde.ToString)
            Dim hasta As String = iisValidSqlDate(fechahasta.ToString)
            'no se por qué no está andando el formateaFecha
            'Dim hasta As String = formateaFecha(iisValidSqlDate(fechadesde.ToString))
            'Dim desde As String = formateaFecha(iisValidSqlDate(fechahasta.ToString))




            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            'Descargas, desde el 03/06/2013 hasta el 03/06/2013 . (Exporta: Entregas, Punto de venta: BuenosAires, Criterio: TODOS).
            'por este formato:
            'Buenos Aires - Descargas de Williams Entregas - Desde el 03/06/2013 al 03/06.
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            Try

                If sTituloFiltroUsado = "" Then
                    Select Case estado
                        Case CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas
                            sTituloFiltroUsado &= "Todas (menos las rechazadas), "
                        Case CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones
                            sTituloFiltroUsado &= "Descargas de Hoy + Todas las Posiciones, "
                        Case CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha
                            'acá podría verificar si las fechas no son las límite del año 1753 y 2100
                            sTituloFiltroUsado &= "Descargas de Hoy + Posiciones filtradas, "
                        Case CartaDePorteManager.enumCDPestado.Posicion
                            sTituloFiltroUsado &= "Posición, "
                        Case CartaDePorteManager.enumCDPestado.DescargasMasFacturadas
                            sTituloFiltroUsado &= "Descargas, "
                        Case CartaDePorteManager.enumCDPestado.Rechazadas
                            sTituloFiltroUsado &= "Rechazadas, "
                        Case Else
                            sTituloFiltroUsado &= estado.ToString
                    End Select
                End If

                'antes era así:   "{11} - de Williams Entregas - {0} {1} {2} {3} {4} {5} {6} {7} {8} {9}.   ({10},{12})"
                'sTituloFiltroUsado = String.Format(" {11} - {13} de Williams Entregas - {0} {1} ", _




                sTituloFiltroUsado = CartaDePorteManager.FormatearTitulo(sc, _
                                       sTituloFiltroUsado, _
                                      estado, "", idVendedor, idCorredor, _
                                      idDestinatario, idIntermediario, _
                                      idRemComercial, idArticulo, idProcedencia, idDestino, _
                                         iisNull(.Item("AplicarANDuORalFiltro"), 0), _
                                         .Item("modo").ToString, _
                                      fechadesde, fechahasta, _
                                      puntoventa, "Ambas", False, "", "", -1)


            Catch ex As Exception
                ErrHandler2.WriteError("Sector 2")
                Throw
            End Try


            'sTituloFiltroUsado = String.Format("{15} {13} {0} {1} {2} {3} {4} {5} {6} {7} {8} {9} {14}.   ({10}, {11}, {12})", _
            '                IIf(IsDate(fechadesde) AndAlso fechadesde >= #1/1/1800#, "Desde el " & FechaChica(desde), ""), _
            '                IIf(IsDate(fechahasta) AndAlso fechahasta <= #1/1/2099#, "al " & FechaChica(hasta), ""), _
            '                IIf(Not IsDBNull(dr.Item("Vendedor")), "Titular: " & No mbreCliente(sc, dr.Item("Vendedor")), ""), _
            '                IIf(Not IsDBNull(dr.Item("CuentaOrden1")), "Intermediario " & NombreCliente(sc, dr.Item("CuentaOrden1")), ""), _
            '                IIf(Not IsDBNull(dr.Item("CuentaOrden2")), "R.Comercial: " & NombreCliente(sc, dr.Item("CuentaOrden2")), ""), _
            '                IIf(Not IsDBNull(dr.Item("Corredor")), "Corredor: " & NombreVendedor(sc, dr.Item("Corredor")), ""), _
            '                IIf(Not IsDBNull(dr.Item("Entregador")), "Destinatario: " & NombreCliente(sc, dr.Item("Entregador")), ""), _
            '                IIf(Not IsDBNull(dr.Item("Procedencia")), "Origen: " & NombreLocalidad(sc, dr.Item("Procedencia")), ""), _
            '                IIf(Not IsDBNull(dr.Item("Destino")), "Destino: " & NombreDestino(sc, dr.Item("Destino")), ""), _
            '                IIf(Not IsDBNull(dr.Item("IdArticulo")), "Producto: " & NombreArticulo(sc, dr.Item("IdArticulo")), ""), _
            '                "Exporta: " & iisNull(.Item("modo"), "NO"), _
            '                "" & IIf(puntoventa < 0, "Todos", CartaDePorteManager.NombrePuntoVentaWilliams(puntoventa)), _
            '                "Criterio: " & IIf(iisNull(.Item("AplicarANDuORalFiltro")) = "1", "TODOS", "ALGUNOS"), _
            '                 " ", _
            '                 " ", _
            '                sTituloFiltroUsado _
            '                )
            If Trim(sTituloFiltroUsado) = "" Then sTituloFiltroUsado = "(sin filtrar)"


            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        End With


        strWHERE = strWHERE.Replace("CDP.", "")
        strWHERE = strWHERE.Replace("WHERE", "")

        Return strWHERE
    End Function

    Public Shared Function GenerarWHEREparaFiltrarFiltros_ODS(ByVal SC As String, ByVal textoBusqueda As String, ByVal cmbBuscarEsteCampoValue As String, ByVal puntoventa As Integer) As String
        'Esta filtra los filtros, no las cartas de porte, ojo
        'Esta filtra los filtros, no las cartas de porte, ojo
        'Esta filtra los filtros, no las cartas de porte, ojo

        Dim strWHERE As String

        strWHERE = "1=1 "

        strWHERE += " AND (PuntoVenta IS NULL OR PuntoVenta=" & puntoventa & " OR " & puntoventa & "<1)"


        If textoBusqueda <> "" Then


            If cmbBuscarEsteCampoValue = "Todos los clientes" Then


                'Dim idVendedor = BuscaIdClientePreciso(textoBusqueda, SC)
                'Dim idCorredor = BuscaIdVendedorPreciso(textoBusqueda, SC)

                'If idVendedor <> -1 Or idCorredor <> -1 Then
                '    strWHERE += "  " & _
                '     "           AND (Vendedor = " & idVendedor & _
                '    "           OR CuentaOrden1 = " & idVendedor & _
                '    "           OR CuentaOrden2 = " & idVendedor & _
                '    "             OR Corredor=" & idCorredor & _
                '    "             OR Entregador=" & idVendedor & ")"
                'End If


                strWHERE += " AND ( " & _
                                "Convert(VendedorDesc, 'System.String') LIKE '*" & textoBusqueda & "*' " & _
                                " OR Convert(CuentaOrden1Desc, 'System.String') LIKE '*" & textoBusqueda & "*' " & _
                                " OR Convert(CuentaOrden2Desc, 'System.String') LIKE '*" & textoBusqueda & "*' " & _
                                " OR Convert(CorredorDesc, 'System.String') LIKE '*" & textoBusqueda & "*' " & _
                                " OR Convert(EntregadorDesc, 'System.String') LIKE '*" & textoBusqueda & "*' " & _
                                " OR Convert(ClienteAuxiliarDesc, 'System.String') LIKE '*" & textoBusqueda & "*' " & _
                            ")" '_

                '"Convert(CuentaOrden1, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
                '& " OR " & _
                '"Convert(CuentaOrden1, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
                '& " OR " & _
                '"Convert(Vendedor, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
                '& " OR " & _
                '"Convert(Corredor, 'System.String') LIKE '*" & txtBuscar.Text & "*'"

            Else

                strWHERE += " AND ( " & _
                            "Convert(" & cmbBuscarEsteCampoValue & ", 'System.String') LIKE '*" & textoBusqueda & "*' )" '_

            End If


        End If

        '& " OR " & _
        '" DestinoDesc LIKE '*" & txtBuscar.Text & "*'    )" ' _

        '& " OR " & _
        '"Convert(CuentaOrden1, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
        '& " OR " & _
        '"Convert(CuentaOrden1, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
        '& " OR " & _
        '"Convert(Vendedor, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
        '& " OR " & _
        '"Convert(Corredor, 'System.String') LIKE '*" & txtBuscar.Text & "*'"



        ''si es un usuario proveedor, filtro sus comprobantes
        'If IsNumeric(Session("glbWebIdProveedor")) Then
        '    GenerarWHERE += " AND  IdProveedor=" & Session("glbWebIdProveedor")
        'End If


        'Select Case HFTipoFiltro.Value.ToString  '
        '    Case "", "AConfirmarEnObra"
        '        s += " AND (Aprobo IS NULL OR Aprobo=0)"
        '        's += " AND (ConfirmadoPorWeb='NO' OR ConfirmadoPorWeb IS NULL)"

        '    Case "AConfirmarEnCentral"
        '        s += " AND ( (ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL)  AND  (Aprobo IS NULL OR Aprobo=0) ) "

        '    Case "Confirmados"
        '        s += " AND (Aprobo NOT IS NULL AND Aprobo>0)"
        '        's += " AND (ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL)"
        'End Select


        Return strWHERE
    End Function


    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

        Try
            myConnection.Open()

            Dim adapterForTable1 = New SqlDataAdapter("select * from WilliamsMailFiltros", myConnection)
            Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
            'si te tira error acá, ojito con estar usando el dataset q usaste para el 
            'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update
            adapterForTable1.Update(dt)

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        Finally
            myConnection.Close()
        End Try

    End Function

    Public Shared Function Update(ByVal SC As String, ByVal Id As Long, ByVal dr As DataRow)

        Dim comandoSQLdinamico As String = String.Format("UPDATE " & Tabla & " SET " & _
                "HumedadDesnormalizada={1}, " & _
                "Factor={2}  " & _
                "WHERE IdCartaDePorte={0} ", dr.Item(""), DecimalToString(dr.Item(2)))

        ExecDinamico(SC, comandoSQLdinamico)
    End Function

    Public Shared Function Update(ByVal SC As String, ByVal Id As Long, ByVal Emails As String, ByVal idEntregador As Integer, ByVal idArticulo As Integer)

        '// Write your own Update statement blocks. 

        Dim comandoSQLdinamico As String = String.Format("UPDATE " & Tabla & " SET " & _
                "Emails='{1}', " & _
                "Entregador={2},  " & _
                "IdArticulo={3}  " & _
                "WHERE IdWilliamsMailFiltro={0} ", Id, Emails, idEntregador, idArticulo)

        ExecDinamico(SC, comandoSQLdinamico)
    End Function



    Public Shared Function Delete(ByVal SC As String, ByVal Id As Long)
        '// Write your own Delete statement blocks. 
        ExecDinamico(SC, String.Format("DELETE  " & Tabla & "  WHERE {1}={0}", Id, IdTabla))
    End Function



    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    Public Function RebindReportViewerExcel(ByVal SC As String, ByVal rdlFile As String, ByVal dt As DataTable, ByVal ArchivoExcelDestino As String) As String

        If ArchivoExcelDestino = "" Then
            ArchivoExcelDestino = IO.Path.GetTempPath & "Excel" & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        End If

        ''Dim vFileName As String = "c:\archivo.txt"
        '' FileOpen(1, ArchivoExcelDestino, OpenMode.Output)



        'ErrHandler2.WriteError("Este reportviewer EXPORTA a excel, pueden andar los mails y esto no. " & _
        '                      "-Eh? la otra función RebindReportViewer tambien exporta a EXCEL con un flag. Quizas lo hace con otro usuario... " & _
        '                      "-En fin. Puede llegar a explotar sin rastro. Fijate en los permisos de NETWORK SERVICE para " & _
        '                      "usar el com de EXCEL. Revisá el visor de eventos si no se loguean errores")

        Using ReportViewer2 As New ReportViewer
            With ReportViewer2
                .ProcessingMode = ProcessingMode.Local

                .Visible = False

                With .LocalReport

                    .ReportPath = rdlFile
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

                Dim bytes As Byte()

                Try
                    bytes = ReportViewer2.LocalReport.Render( _
                               format, Nothing, mimeType, encoding, _
                                 extension, _
                                streamids, warnings)



                Catch e As System.Exception
                    Dim inner As Exception = e.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            'MsgBox(inner.Message)
                            Stop
                        End If
                        ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message) ' & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                        inner = inner.InnerException
                    End While
                    Throw
                End Try



                Dim fs = New IO.FileStream(ArchivoExcelDestino, IO.FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()





                'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es la mitad de la normal)
                'Notas de Entrega: 160 ancho x 36 alt
                'Facturas y Adjuntos: 160 ancho x 78 alto

                'ArchivoExcelDestino = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextWilliamsAdjunto(ArchivoExcelDestino)

            End With
        End Using


        Return ArchivoExcelDestino

    End Function



    <Serializable()> Public Class CDPMailFiltro
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

        Public Destino As Integer
        Public Procedencia As Integer
    End Class
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




    Public Shared Function GetListDatasetPaginadoConWHERE(ByVal SC As String, ByVal ColumnaParaFiltrar As String, ByVal TextoParaFiltrar As String, ByVal puntoVenta As Integer, ByVal sortExpression As String, ByVal startRowIndex As Long, ByVal maximumRows As Long) As System.Data.DataSet



        'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
        ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
        Dim ds As Data.DataSet
        'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
        'With dc
        '    .ColumnName = "ColumnaTilde"
        '    .DataType = System.Type.GetType("System.Int32")
        '    .DefaultValue = 0
        'End With

        ds = EntidadManager.TraerDatos(SC, "wMailsFiltros_TTpaginadoYfiltrado", ColumnaParaFiltrar, TextoParaFiltrar, puntoVenta, sortExpression, startRowIndex, maximumRows)
        'ds = GetStoreProcedure(SC, "wMailsFiltros_TTpaginadoYfiltrado", ColumnaParaFiltrar, TextoParaFiltrar, sortExpression, startRowIndex, maximumRows)

        'Try
        '    ds = EntidadManager.TraerDatos(SC, "wClientes_T", -1)
        'Catch ex As Exception
        '    ds = EntidadManager.TraerDatos(SC, "wClientes_TT")
        '    'ds = EntidadManager.TraerDatos(SC, "Clientes_TT")
        'End Try


        'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
        'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
        With ds.Tables(0)
            '.Columns("IdWilliamsMailFiltro").ColumnName = "Id"
            '.Columns("NumeroRequerimiento").ColumnName = "Numero"
            '.Columns("FechaRequerimiento").ColumnName = "Fecha"
        End With

        'ds.Tables(0).Columns.Add(dc)
        Return ds

    End Function

    Public Shared Function FetchPrimeraPagina(ByVal SC As String, ByVal puntoventa As Integer) As DataTable

        'se está trayenda la tabla de filtros, no la de cartas de porte, ojo. Es un asqueroso select *, hay
        'que cambiarlo, pero por lo menos no te asustes, no es la tabla de cartas de porte


        Return ExecDinamico(SC, String.Format("SELECT TOP 120 " & _
                        "     CDP.*, " & _
                      " CLIVEN.Razonsocial as VendedorDesc, " & _
                      " CLICO1.Razonsocial as CuentaOrden1Desc, " & _
                      " CLICO2.Razonsocial as CuentaOrden2Desc, " & _
                      " CLICOR.Nombre as CorredorDesc, " & _
                      " CLIENT.Razonsocial as EntregadorDesc, " & _
                      " Articulos.Descripcion as Producto, " & _
                      " LOCORI.Nombre as ProcedenciaDesc, " & _
                      " LOCDES.Descripcion as DestinoDesc " & _
                      " FROM " & Tabla & " CDP " & _
                      " LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente " & _
                      " LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente " & _
                      " LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente " & _
                      " LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor " & _
                      " LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente " & _
                      " LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo " & _
                      " LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & _
                      " LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino " & _
                      " WHERE isnull(CDP.PuntoVenta,0)=" & puntoventa & " OR " & puntoventa & "=0" & _
                      " ORDER BY IdWilliamsMailFiltro DESC " _
                                  ))

    End Function

    Public Shared Function Fetch(ByVal SC As String, ByVal puntoventa As Integer) As DataTable

        'se está trayenda la tabla de filtros, no la de cartas de porte, ojo. Es un asqueroso select *, hay
        'que cambiarlo, pero por lo menos no te asustes, no es la tabla de cartas de porte

        'TODO: ineficiente, y a este se lo llama seguido...



        Return ExecDinamico(SC, String.Format("SELECT " & _
                        "     CDP.*, " & _
                            " CLIVEN.Razonsocial as VendedorDesc, " & _
                            " CLICO1.Razonsocial as CuentaOrden1Desc, " & _
                            " CLICO2.Razonsocial as CuentaOrden2Desc, " & _
                            " CLICOR.Nombre as CorredorDesc, " & _
                            " CLIENT.Razonsocial as EntregadorDesc, " & _
                            " CLIAUX.Razonsocial as ClienteAuxiliarDesc, " & _
                            " Articulos.Descripcion as Producto, " & _
                            " LOCORI.Nombre as ProcedenciaDesc, " & _
                            " LOCDES.Descripcion as DestinoDesc " & _
                            " FROM " & Tabla & " CDP " & _
                            " LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente " & _
                            " LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente " & _
                            " LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente " & _
                            " LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor " & _
                            " LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente " & _
                            " LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo " & _
                            " LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & _
                            " LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino " & _
                            " LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar= CLIAUX.IdCliente " & _
                            " WHERE isnull(CDP.PuntoVenta,0)=" & puntoventa & " OR " & puntoventa & "=0" & _
                            " ORDER BY IdWilliamsMailFiltro DESC " _
                                        ))

    End Function



    Public Shared Function FetchById(ByVal SC As String, Id As Integer) As DataRow

        'se está trayenda la tabla de filtros, no la de cartas de porte, ojo. Es un asqueroso select *, hay
        'que cambiarlo, pero por lo menos no te asustes, no es la tabla de cartas de porte

        'TODO: ineficiente, y a este se lo llama seguido...



        Return ExecDinamico(SC, String.Format("SELECT " & _
                        "     CDP.*, " & _
                            " CLIVEN.Razonsocial as VendedorDesc, " & _
                            " CLICO1.Razonsocial as CuentaOrden1Desc, " & _
                            " CLICO2.Razonsocial as CuentaOrden2Desc, " & _
                            " CLICOR.Nombre as CorredorDesc, " & _
                            " CLIENT.Razonsocial as EntregadorDesc, " & _
                            " CLIAUX.Razonsocial as ClienteAuxiliarDesc, " & _
                            " Articulos.Descripcion as Producto, " & _
                            " LOCORI.Nombre as ProcedenciaDesc, " & _
                            " LOCDES.Descripcion as DestinoDesc " & _
                            " FROM " & Tabla & " CDP " & _
                            " LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente " & _
                            " LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente " & _
                            " LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente " & _
                            " LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor " & _
                            " LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente " & _
                            " LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo " & _
                            " LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & _
                            " LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino " & _
                            " LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar= CLIAUX.IdCliente " & _
                            " WHERE IdWilliamsMailFiltro=" & Id)).Rows(0)

    End Function



    Public Shared Function EncabezadoHtml(puntoventa As Integer) As String


        Dim html = "" '" <img src=""data:image/jpg;base64, " + logo + """ />"""
        Dim a = "", b = ""



        Select Case puntoventa
            Case 1


                b = "<br/>Estimados, este mail se utiliza únicamente para envíos. <a style=""color:red;font-weight: bold;""> En caso de responder, favor de hacerlo a buenosaires@williamsentregas.com.ar</a>"

                a += "<br/><b>Williams Entregas S.A</b><br/>" + vbCrLf + _
                        "Oficina Buenos Aires<br/>" + vbCrLf + _
                        "Moreno 584. Piso 12°A ( C.A.B.A)<br/>" + vbCrLf + _
                        "Tel: (011) 4322-4805 / 4393-9762<br/>buenosaires@williamsentregas.com.ar" + vbCrLf


            Case 2

                b = "<br/>Estimados, este mail se utiliza únicamente para envíos. <a style=""color:red;font-weight: bold;""> En caso de responder, favor de hacerlo a sanlorenzo@williamsentregas.com.ar</a>"

                a += "<br/><b>Williams Entregas S.A</b><br/>" + vbCrLf + _
                        "Oficina San Lorenzo<br/>" + vbCrLf + _
                        "Santiago del Estero 1177 (San Lorenzo)<br/>" + vbCrLf + _
                        "Tel: 03476 - 430234 / 430158<br/>sanlorenzo@williamsentregas.com.ar" + vbCrLf

            Case 3

                b = "<br/>Estimados, este mail se utiliza únicamente para envíos. <a style=""color:red;font-weight: bold;""> En caso de responder, favor de hacerlo a arroyoseco@williamsentregas.com.ar</a>"

                a += "<br/><b>Williams Entregas S.A</b><br/>" + vbCrLf + _
                        "Oficina Arroyo Seco<br/>" + vbCrLf + _
                        "Rene Favaloro 726 (Arroyo Seco)<br/>" + vbCrLf + _
                        "Tel: 03402 437283 / 437287<br/>arroyoseco@williamsentregas.com.ar" + vbCrLf

            Case 4

                b = "<br/>Estimados, este mail se utiliza únicamente para envíos. <a style=""color:red;font-weight: bold;""> En caso de responder, favor de hacerlo a bahiablanca@williamsentregas.com.ar</a>"

                a += "<br/><b>Williams Entregas S.A</b><br/>" + vbCrLf + _
                        "Oficina Bahia Blanca<br/>" + vbCrLf + _
                        "Playa el Triangulo<br/>" + vbCrLf + _
                        "Tel: 0291 - 4007928 / 4816778<br/>bahiablanca@williamsentregas.com.ar" + vbCrLf


            Case Else

                b = "<br/>Estimados, este mail se utiliza únicamente para envíos. <a style=""color:red;font-weight: bold;""> En caso de responder, favor de hacerlo a buenosaires@williamsentregas.com.ar</a><br/>"

                a += "<br/><b>Williams Entregas S.A</b><br/>" + vbCrLf + _
                        "Oficina Buenos Aires<br/>" + vbCrLf + _
                        "Moreno 584. Piso 12°A (C.A.B.A)<br/>" + vbCrLf + _
                        "Tel: (011) 4322-4805 / 4393-9762<br/>buenosaires@williamsentregas.com.ar" + vbCrLf

        End Select


        html &= b



        Return html




        'Return "<p> Firma </p> Williams Entregas S. A. "

        ' <http://williamsentregas.com.ar/> Descripci=F3n: Descripci=F3n: =
        '            Descripci = F3n
        'C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image001.png

        'Williams Entregas S.A=20

        'Oficina San Lorenzo

        'Santiago del Estero 1177 (San Lorenzo)

        'Tel: 03476 =96 430234 / 430158

        '            sanlorenzo@ williamsentregas.com.ar

        ' <https://twitter.com/WEntregas?lang=3Des> Descripci=F3n: Descripci=F3n:
        'Descripci=F3n: C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image002.png

        '=20

        '=20

        '=20

        ' <http://williamsentregas.com.ar/> Descripci=F3n: Descripci=F3n:
        'C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image001.png

        'Williams Entregas S.A=20

        'Oficina Arroyo Seco

        'Rene Favaloro 726 (Arroyo Seco)

        'Tel: 0291 =96 4007928 / 4816778

        '            arroyoseco@ williamsentregas.com.ar

        ' <https://twitter.com/WEntregas?lang=3Des> Descripci=F3n: Descripci=F3n:
        'C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image002.png

        '=20

        '=20

        '=20

        '=20

        '=20

        ' <http://williamsentregas.com.ar/> Descripci=F3n: Descripci=F3n:
        'C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image001.png

        'Williams Entregas S.A=20

        'Oficina Bahia Blanca

        'Playa el Triangulo

        'Tel: 0291 =96 4007928 / 4816778

        '            bahiablanca@ williamsentregas.com.ar

        ' <https://twitter.com/WEntregas?lang=3Des> Descripci=F3n: Descripci=F3n:
        'Descripci=F3n: C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image002.png

        '=20

        '=20

        ' <http://williamsentregas.com.ar/> Descripci=F3n: Descripci=F3n: =
        '            Descripci = F3n
        'C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image001.png

        'Williams Entregas S.A=20

        'Oficina Buenos Aires

        'Moreno 584. Piso 12=B0A ( C.A.B.A)

        'Tel: (011) 4322-4805 / 4393-9762

        '            buenosaires@ williamsentregas.com.ar

        ' <https://twitter.com/WEntregas?lang=3Des> Descripci=F3n: Descripci=F3n:
        'Descripci=F3n: C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image002.png



    End Function


    Public Shared Function AgregarFirmaHtml(puntoventa As Integer) As String

        Dim html = "" '" <img src=""data:image/jpg;base64, " + logo + """ />"""
        Dim a = "", b = ""



        Select Case puntoventa
            Case 1


                b = "<br/>Estimados, este mail se utiliza únicamente para envíos. <a style=""color:red;font-weight: bold;""> En caso de responder, favor de hacerlo a buenosaires@williamsentregas.com.ar</a>"

                a += "<br/><b>Williams Entregas S.A</b><br/>" + vbCrLf + _
                        "Oficina Buenos Aires<br/>" + vbCrLf + _
                        "Moreno 584. Piso 12°A ( C.A.B.A)<br/>" + vbCrLf + _
                        "Tel: (011) 4322-4805 / 4393-9762<br/>buenosaires@williamsentregas.com.ar" + vbCrLf


            Case 2

                b = "<br/>Estimados, este mail se utiliza únicamente para envíos. <a style=""color:red;font-weight: bold;""> En caso de responder, favor de hacerlo a sanlorenzo@williamsentregas.com.ar</a>"

                a += "<br/><b>Williams Entregas S.A</b><br/>" + vbCrLf + _
                        "Oficina San Lorenzo<br/>" + vbCrLf + _
                        "Santiago del Estero 1177 (San Lorenzo)<br/>" + vbCrLf + _
                        "Tel: 03476 - 430234 / 430158<br/>sanlorenzo@williamsentregas.com.ar" + vbCrLf

            Case 3

                b = "<br/>Estimados, este mail se utiliza únicamente para envíos. <a style=""color:red;font-weight: bold;""> En caso de responder, favor de hacerlo a arroyoseco@williamsentregas.com.ar</a>"

                a += "<br/><b>Williams Entregas S.A</b><br/>" + vbCrLf + _
                        "Oficina Arroyo Seco<br/>" + vbCrLf + _
                        "Rene Favaloro 726 (Arroyo Seco)<br/>" + vbCrLf + _
                        "Tel: 03402 437283 / 437287<br/>arroyoseco@williamsentregas.com.ar" + vbCrLf

            Case 4

                b = "<br/>Estimados, este mail se utiliza únicamente para envíos. <a style=""color:red;font-weight: bold;""> En caso de responder, favor de hacerlo a bahiablanca@williamsentregas.com.ar</a>"

                a += "<br/><b>Williams Entregas S.A</b><br/>" + vbCrLf + _
                        "Oficina Bahia Blanca<br/>" + vbCrLf + _
                        "Playa el Triangulo<br/>" + vbCrLf + _
                        "Tel: 0291 - 4007928 / 4816778<br/>bahiablanca@williamsentregas.com.ar" + vbCrLf


            Case Else

                b = "<br/>Estimados, este mail se utiliza únicamente para envíos. <a style=""color:red;font-weight: bold;""> En caso de responder, favor de hacerlo a buenosaires@williamsentregas.com.ar</a>"

                a += "<br/><b>Williams Entregas S.A</b><br/>" + vbCrLf + _
                        "Oficina Buenos Aires<br/>" + vbCrLf + _
                        "Moreno 584. Piso 12°A (C.A.B.A)<br/>" + vbCrLf + _
                        "Tel: (011) 4322-4805 / 4393-9762<br/>buenosaires@williamsentregas.com.ar" + vbCrLf

        End Select


        html &= "<br/><a href=""http://williamsentregas.com.ar/""> <img src=""cid:Image""></a>" + a +
               "<br/><a href=""https://twitter.com/WEntregas?lang=es""><img src=""cid:Image2""></a>"




        Return html




        'Return "<p> Firma </p> Williams Entregas S. A. "

        ' <http://williamsentregas.com.ar/> Descripci=F3n: Descripci=F3n: =
        '            Descripci = F3n
        'C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image001.png

        'Williams Entregas S.A=20

        'Oficina San Lorenzo

        'Santiago del Estero 1177 (San Lorenzo)

        'Tel: 03476 =96 430234 / 430158

        '            sanlorenzo@ williamsentregas.com.ar

        ' <https://twitter.com/WEntregas?lang=3Des> Descripci=F3n: Descripci=F3n:
        'Descripci=F3n: C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image002.png

        '=20

        '=20

        '=20

        ' <http://williamsentregas.com.ar/> Descripci=F3n: Descripci=F3n:
        'C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image001.png

        'Williams Entregas S.A=20

        'Oficina Arroyo Seco

        'Rene Favaloro 726 (Arroyo Seco)

        'Tel: 0291 =96 4007928 / 4816778

        '            arroyoseco@ williamsentregas.com.ar

        ' <https://twitter.com/WEntregas?lang=3Des> Descripci=F3n: Descripci=F3n:
        'C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image002.png

        '=20

        '=20

        '=20

        '=20

        '=20

        ' <http://williamsentregas.com.ar/> Descripci=F3n: Descripci=F3n:
        'C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image001.png

        'Williams Entregas S.A=20

        'Oficina Bahia Blanca

        'Playa el Triangulo

        'Tel: 0291 =96 4007928 / 4816778

        '            bahiablanca@ williamsentregas.com.ar

        ' <https://twitter.com/WEntregas?lang=3Des> Descripci=F3n: Descripci=F3n:
        'Descripci=F3n: C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image002.png

        '=20

        '=20

        ' <http://williamsentregas.com.ar/> Descripci=F3n: Descripci=F3n: =
        '            Descripci = F3n
        'C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image001.png

        'Williams Entregas S.A=20

        'Oficina Buenos Aires

        'Moreno 584. Piso 12=B0A ( C.A.B.A)

        'Tel: (011) 4322-4805 / 4393-9762

        '            buenosaires@ williamsentregas.com.ar

        ' <https://twitter.com/WEntregas?lang=3Des> Descripci=F3n: Descripci=F3n:
        'Descripci=F3n: C:\Users\Tomas\AppData\Roaming\Microsoft\Firmas\tomas
        'williams_files\Image002.png



    End Function




    Public Shared Function EnviarMailFiltroPorId_DLL(ByVal SC As String, ByVal fechadesde As Date, _
                                                     ByVal fechahasta As Date, ByVal puntoventa As Integer, _
                                                     ByVal id As Long, ByVal titulo As String, ByVal estado As CartaDePorteManager.enumCDPestado, _
                                                     ByRef sError As String, ByVal bVistaPrevia As Boolean, _
                                                     ByVal SmtpServer As String, ByVal SmtpUser As String, _
                                                     ByVal SmtpPass As String, ByVal SmtpPort As Integer, ByVal CCOaddress As String, _
                                                     ByRef sError2 As String _
                                                        ) As String






        'Dim Id = GridView1.DataKeys(fila.RowIndex).Values(0).ToString()
        Dim dt = CDPMailFiltrosManager2.TraerMetadata(SC, id)
        Dim dr = dt.Rows(0)


        Return EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta, puntoventa, titulo, estado, dr, sError, bVistaPrevia, SmtpServer, SmtpUser, SmtpPass, SmtpPort, CCOaddress, sError2)



    End Function




    
 


    Public Shared Function EnviarMailFiltroPorRegistro_DLL(ByVal SC As String, ByVal fechadesde As Date, _
                                                  ByVal fechahasta As Date, ByVal puntoventa As Integer, _
                                                  ByVal titulo As String, ByVal estado As CartaDePorteManager.enumCDPestado, _
                                                  ByRef dr As DataRow, _
                                                  ByRef sError As String, ByVal bVistaPrevia As Boolean, _
                                                  ByVal SmtpServer As String, ByVal SmtpUser As String, _
                                                  ByVal SmtpPass As String, ByVal SmtpPort As Integer, ByVal CCOaddress As String, _
                                                  ByRef sError2 As String, Optional inlinePNG As String = "" _
                                                , Optional inlinePNG2 As String = "" _
                                                     ) As String




        Dim ModoImpresion As String = iisNull(dr.Item("ModoImpresion"), "Excel")


        If ModoImpresion = "Html" Or ModoImpresion = "HtmlIm" Then
            Throw New Exception("El informe HTML y HTMLIM no salen por servidor de informes, sino por modo local (son los informes que se llaman desde el AppCode\FiltroManager, y que deberiamos migrar) ")
        End If




        Dim output As String
        'output = generarNotasDeEntrega(#1/1/1753#, #1/1/2020#, Nothing, Nothing, Nothing, Nothing, Nothing, BuscaIdClientePreciso(Entregador.Text, sc), Nothing)
        With dr
            Dim l As Long

            Dim s = ""

            'If Not chkConLocalReport.Checked Then
            '    Dim sWHERE = generarWHEREparaSQL(sc, dr, titulo, estado, _
            '                                iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
            '                                iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), cmbPuntoVenta.SelectedValue)
            '    output = generarNotasDeEntrega(sc, dr, estado, l, titulo, sWHERE, Server.MapPath("~/Imagenes/Williams.bmp"))
            'Else




            If estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones Then
                fechadesde = #1/1/1753#
                fechahasta = #1/1/2100#

            ElseIf estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha Then
                'saqué esto. justamente, si uso rangofecha, las fechas tienen que estar
                'pero quizas estas usando otra cosa en el enviarya....
                ' fechadesde = #1/1/1753#
                ' fechahasta = #1/1/2100#


            End If


            Try
                Dim sWHERE = generarWHEREparaDataset(SC, dr, titulo, estado, _
                                            iisValidSqlDate(fechadesde, #1/1/1753#), _
                                            iisValidSqlDate(fechahasta, #1/1/2100#), puntoventa)

            Catch ex As Exception
                'logear el idfiltro con problemas

                ErrHandler2.WriteError(ex.ToString)
                dr.Item("UltimoResultado") = Left(Now.ToString("hh:mm") & " Falló: " & ex.ToString, 100)
                Throw
            End Try


            ' Dim bDescargaHtml =        CartaDePorteManager.CONSTANTE_HTML
            Dim bDescargaHtml = (iisNull(.Item("ModoImpresion"), "Excel") = "Html" Or iisNull(.Item("ModoImpresion"), "Excel") = "HtmlIm")


            Dim tiempoinforme, tiemposql As Integer

            If False And Debugger.IsAttached Then
                'output = generarNotasDeEntregaConReportViewer_ConServidorDeInformes(SC, fechadesde, fechahasta, dr, estado, l, titulo, "", puntoventa, tiemposql, tiempoinforme, bDescargaHtml)
            Else
                output = generarNotasDeEntregaConReportViewer_ConServidorDeInformes(SC, fechadesde, fechahasta, dr, estado, l, titulo, "", puntoventa, tiemposql, tiempoinforme, bDescargaHtml)
            End If


            'End If





            If output <> "-1" And output <> "-2" Then
                'MandaEmail("mscalella911@gmail.com", "Mailing Williams", "", , , , , "C:\ProntoWeb\doc\williams\Excels de salida\NE Descargas para el corredor Intagro.xls")

                'Dim mails() As String = Split(.Item("EMails"), ",")
                'For Each s As String In mails
                'ErrHandler2.WriteError("asdasde")
                Dim De As String

                Select Case puntoventa
                    Case 1
                        De = "buenosaires@williamsentregas.com.ar"
                        CCOaddress = "descargas-ba@williamsentregas.com.ar" ' & CCOaddress
                    Case 2
                        De = "sanlorenzo@williamsentregas.com.ar"
                        CCOaddress = "descargas-sl@williamsentregas.com.ar" ' & CCOaddress
                    Case 3
                        De = "arroyoseco@williamsentregas.com.ar"
                        CCOaddress = "descargas-as@williamsentregas.com.ar" '& CCOaddress
                    Case 4
                        De = "bahiablanca@williamsentregas.com.ar"
                        CCOaddress = "descargas-bb@williamsentregas.com.ar" ' & CCOaddress
                    Case Else
                        De = "buenosaires@williamsentregas.com.ar"
                        CCOaddress = "descargas-ba@williamsentregas.com.ar" ' & CCOaddress
                End Select

                Try
                    Dim destinatario As String
                    Dim truquito As String '= "    <img src =""http://" & HttpContext.Current.Request.ServerVariables("HTTP_HOST") & "/Pronto/mailPage.aspx?q=" & iisNull(UsuarioSesion.Mail(sc, Session)) & "&e=" & .Item("EMails") & "_" & tit & """/>" 'imagen para que llegue respuesta cuando sea leido
                    Dim cuerpo As String

                    If bVistaPrevia Then ' chkVistaPrevia.Checked Then
                        'lo manda a la casilla del usuario
                        'ver cómo crear una regla en Outlook para forwardearlo a la casilla correspondiente
                        'http://www.eggheadcafe.com/software/aspnet/34183421/question-on-rules-on-unattended-mailbox.aspx
                        destinatario = .Item("AuxiliarString2") ' UsuarioSesion.Mail(sc, Session)
                        cuerpo = .Item("EMails") & truquito
                    Else
                        'lo manda a la casilla del destino
                        destinatario = .Item("EMails")

                        'destinatario &= "," & De

                        cuerpo = truquito
                    End If


                    Dim stopWatch As New Stopwatch()
                    stopWatch.Start()


                    cuerpo = EncabezadoHtml(puntoventa) & cuerpo & AgregarFirmaHtml(puntoventa) 'aunque agrego la firma al final de la cadena, sale al principio en el mail










                    Dim idVendedor As Integer = iisNull(.Item("Vendedor"), -1)
                    Dim idCorredor As Integer = iisNull(.Item("Corredor"), -1)
                    Dim idDestinatario As Integer = iisNull(.Item("Entregador"), -1)
                    Dim idIntermediario As Integer = iisNull(.Item("CuentaOrden1"), -1)
                    Dim idRemComercial As Integer = iisNull(.Item("CuentaOrden2"), -1)
                    Dim idArticulo As Integer = iisNull(.Item("IdArticulo"), -1)
                    Dim idProcedencia As Integer = iisNull(.Item("Procedencia"), -1)
                    Dim idDestino As Integer = iisNull(.Item("Destino"), -1)



                    Dim AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR = iisNull(.Item("AplicarANDuORalFiltro"), 0)
                    Dim ModoExportacion As String = .Item("modo").ToString
                    Dim optDivisionSyngenta As String = "Ambas"


                    Dim asunto As String

                    Try

                        'Dim fechadesde As DateTime = iisValidSqlDate(DateTime.ParseExact(txtFechaDesde.Text, "dd/MM/yyyy", Globalization.CultureInfo.InvariantCulture), #1/1/1753#)
                        'Dim fechahasta As DateTime = iisValidSqlDate(DateTime.ParseExact(txtFechaHasta.Text, "dd/MM/yyyy", Globalization.CultureInfo.InvariantCulture), #1/1/2100#)


                        asunto = CartaDePorteManager.FormatearAsunto(SC, _
                             "", _
                           estado, "", idVendedor, idCorredor, _
                          idDestinatario, idIntermediario, _
                          idRemComercial, idArticulo, idProcedencia, idDestino, _
                           AplicarANDuORalFiltro, ModoExportacion, _
                          fechadesde, fechahasta, _
                           puntoventa, optDivisionSyngenta, False, "", "", -1)
                    Catch ex As Exception
                        asunto = "mal formateado"
                        ErrHandler2.WriteError(ex.ToString + " asunto mal formateado")
                    End Try




                    If iisNull(.Item("ModoImpresion"), "Excel") = "ExcHtm" Then

                        Dim grid As New GridView
                        Dim html = ExcelToHtml(output, grid)

                        MandaEmail_Nuevo(destinatario, _
                                                          asunto, _
                                                        cuerpo + html, _
                                                     De, _
                                                     SmtpServer, _
                                                              SmtpUser, _
                                                              SmtpPass, _
                                                                output, _
                                                              SmtpPort, _
                                                      , _
                                                      CCOaddress, , , De, , inlinePNG, inlinePNG2)


                    ElseIf iisNull(.Item("ModoImpresion"), "Excel") = "HOlav" Then
                        Dim grid As New GridView
                        Dim html = ExcelToHtml(output, grid, 2000)

                        MandaEmail_Nuevo(destinatario, _
                                    asunto, _
                              EncabezadoHtml(puntoventa) & html & AgregarFirmaHtml(puntoventa), _
                               De, _
                               SmtpServer, _
                                        SmtpUser, _
                                        SmtpPass, _
                                           "", _
                                        SmtpPort, _
                                , _
                                CCOaddress, , , De, , inlinePNG, inlinePNG2)

                    ElseIf iisNull(.Item("ModoImpresion"), "Excel") = "EHOlav" Then
                        Dim grid As New GridView
                        Dim html = ExcelToHtml(output, grid, 2000)

                        MandaEmail_Nuevo(destinatario, _
                                    asunto, _
                              EncabezadoHtml(puntoventa) & html & AgregarFirmaHtml(puntoventa), _
                               De, _
                               SmtpServer, _
                                        SmtpUser, _
                                        SmtpPass, _
                                          output, _
                                        SmtpPort, _
                                , _
                                CCOaddress, , , De, , inlinePNG, inlinePNG2)


                    ElseIf iisNull(.Item("ModoImpresion"), "Excel") = "HImag2" Then
                        Dim grid As New GridView
                        Dim html = ExcelToHtml(output, grid, 2000)

                        MandaEmail_Nuevo(destinatario, _
                                    asunto, _
                              EncabezadoHtml(puntoventa) & html & AgregarFirmaHtml(puntoventa), _
                               De, _
                               SmtpServer, _
                                        SmtpUser, _
                                        SmtpPass, _
                                          output, _
                                        SmtpPort, _
                                , _
                                CCOaddress, , , De, , inlinePNG, inlinePNG2)


                    ElseIf bDescargaHtml Then



                        Dim grid As New GridView
                        Dim html = ExcelToHtml(output, grid)

                        MandaEmail_Nuevo(destinatario, _
                                    asunto, _
                              EncabezadoHtml(puntoventa) & html & AgregarFirmaHtml(puntoventa), _
                               De, _
                               SmtpServer, _
                                        SmtpUser, _
                                        SmtpPass, _
                                          "", _
                                        SmtpPort, _
                                , _
                                CCOaddress, , , De, , inlinePNG, inlinePNG2)


                        'MandaEmail(destinatario, _
                        '                    asunto, _
                        '                  cuerpo + output, _
                        '                   De, _
                        '                 SmtpServer, _
                        '                SmtpUser, _
                        '                SmtpPass, _
                        '                "", _
                        '                SmtpPort, _
                        '                 , _
                        '                 CCOaddress, _
                        '                    truquito _
                        '                    , "Williams Entregas" _
                        '               )
                    Else

                        MandaEmail_Nuevo(destinatario, _
                                            asunto, _
                                          cuerpo, _
                                           De, _
                                         SmtpServer, _
                                        SmtpUser, _
                                        SmtpPass, _
                                        output, _
                                        SmtpPort, _
                                         , _
                                         CCOaddress, _
                                            truquito _
                                            , "Williams Entregas", De, , inlinePNG, inlinePNG2 _
                                       )

                    End If


                    stopWatch.Stop()
                    Dim tiempomail = stopWatch.Elapsed.Milliseconds


                    s = "Enviado con éxito a las " & Now.ToString(" hh:mm") & ". CDPs filtradas: " & l & " sql:" & tiemposql & " rs:" & tiempoinforme & " mail:" & tiempomail

                    dr.Item("UltimoResultado") = s

                Catch ex As Exception
                    'Verificar Mails rechazados en la cuenta que los envió
                    '        http://www.experts-exchange.com/Programming/Languages/C_Sharp/Q_23268068.html
                    'TheLearnedOne:
                    'The only way that I know of is to look in the Inbox for rejected messages.

                    '        Bob



                    ErrHandler2.WriteError("Error en EnviarMailFiltroPorId() " + ex.ToString)
                    'dddd()
                    s = Left(Now.ToString("hh:mm") & " Falló:  " & ex.ToString, 100)
                    dr.Item("UltimoResultado") = s
                    'MsgBoxAjax(Me, "Fallo al enviar. " & ex.ToString)
                End Try

                'Next
            ElseIf output = "-1" Then
                sError += "El filtro genera un informe vacío." & vbCrLf
                s = "Generó un informe vacío a las " & Now.ToString("hh:mm")
                dr.Item("UltimoResultado") = s
            ElseIf output = "-2" Then

                sError += "Modo IDE. Mail muy grande. No se enviará." & vbCrLf
                s = Now.ToString("hh:mm") & " Modo IDE. Mail muy grande. No se enviará"
                dr.Item("UltimoResultado") = s
            End If


            sError2 = s


        End With



        Return output


    End Function












    Public Shared Function AgruparPorPeriodo(sc, estado, AgrupadorDeTandaPeriodos, fechadesde, fechahasta)
        'Dim db As New LinqCartasPorteDataContext(HFSC.Value) 'no uses linq, porque necesitas más bien hacer updates
        Try

            Dim sWHERE As String = CartaDePorteManager.generarWHEREparaDatasetParametrizado(sc, _
                                   "", _
                                  estado, "", -1, -1, _
                                  -1, -1, _
                                  -1, -1, -1, -1, _
                                   CartaDePorteManager.FiltroANDOR.FiltroOR, "", _
                                  fechadesde, fechahasta, _
                                   -1, , , , , )


            If False Then
                'metodo 1
                'limpio anterior
                EntidadManager.ExecDinamico(sc, "UPDATE CartasDePorte  SET AgrupadorDeTandaPeriodos=NULL  where not AgrupadorDeTandaPeriodos is NULL")
                'elijo de nuevo
                EntidadManager.ExecDinamico(sc, "UPDATE CartasDePorte  SET AgrupadorDeTandaPeriodos=" & AgrupadorDeTandaPeriodos & " FROM CartasDePorte CDP  WHERE " & sWHERE)
            Else
                'metodo 2 usando tabla adicional (CartasDePorteMailClusters)

                EntidadManager.ExecDinamico(sc, "truncate table CartasDePorteMailClusters")
                EntidadManager.ExecDinamico(sc, "insert into CartasDePorteMailClusters select idcartadeporte,AgrupadorDeTandaPeriodos=" & AgrupadorDeTandaPeriodos & _
                                            " FROM CartasDePorte CDP  WHERE " _
                                            & sWHERE)
            End If

        Catch ex As Exception
            ErrHandler2.WriteAndRaiseError("Falló el AgrupadorDeTandaPeriodos. " & ex.ToString)
        End Try
    End Function



    Shared Function MinutosDiferencia(a As Object) As Long
        Try
            Return DateDiff(DateInterval.Minute, CDate(Mid(a, 13)), Now)
        Catch ex As Exception
            Return -1
        End Try
    End Function




    Public Shared Function PurgarColaDeMails(ByVal SC As String)

        'ok, qué hacemos entonces con los que quedan con la marca de "procesandose"?????
        'me podría mandar un mail de error avisandome que quedaron mails marcados con "procesandose"....
        ExecDinamico(SC, "IF (select COUNT (*) from WilliamsMailFiltrosCola) > 20000 BEGIN   DELETE from WilliamsMailFiltrosCola where UltimoResultado<>'En Cola'    END ")

    End Function


End Class


'pinta que no lo puedo usar en la dll?
'Partial Public Class LinqCartasPorteDataContext
'Public Function TraerContext(SC As String) As LinqCartasPorteDataContext
'    Dim conn As StackExchange.Profiling.Data.ProfiledDbConnection = New StackExchange.Profiling.Data.ProfiledDbConnection(New SqlConnection(SC), MiniProfiler.Current)
'    Return New LinqCartasPorteDataContext(conn)
'End Function
'End Class



'End Namespace




Public Class ColaMails

    Public Shared Function CancelarTrabajos(ByVal SC As String, Optional ByVal IdUsuario As Integer = -1) As DataTable
        If IdUsuario = -1 Then
            Return ExecDinamico(SC, "update WilliamsMailFiltrosCola set UltimoResultado='Cancelado a las " & Now.ToString & "'  where (UltimoResultado='En Cola'  OR UltimoResultado like 'Procesandose%' ) ")
        Else
            Return ExecDinamico(SC, "update WilliamsMailFiltrosCola set UltimoResultado='Cancelado a las " & Now.ToString & "'  where (UltimoResultado='En Cola'   OR UltimoResultado like 'Procesandose%')  AND IdUsuarioEncolo=" & IdUsuario)
        End If
    End Function

    Public Shared Function TraerMetadata(ByVal SC As String, Optional ByVal id As Integer = -1) As DataTable
        If id = -1 Then
            Return ExecDinamico(SC, "select * from WilliamsMailFiltrosCola where 1=0")
        Else
            Return ExecDinamico(SC, "select * from WilliamsMailFiltrosCola where idWilliamsMailFiltroCola=" & id)
        End If
    End Function

    Public Shared Function TraerEncolados(ByVal SC As String) As DataTable
        Return ExecDinamico(SC, "select * from WilliamsMailFiltrosCola where UltimoResultado='En Cola' order by AgrupadorDeTandaPeriodos DESC")
    End Function

    Public Shared Function TraerEncoladosCount(ByVal SC As String) As DataTable
        Return ExecDinamico(SC, "select count(*) from WilliamsMailFiltrosCola where UltimoResultado='En Cola'")
    End Function

    Public Shared Function TraerPrimerEncolado(ByVal SC As String) As DataTable
        Return ExecDinamico(SC, "select TOP 1 * from WilliamsMailFiltrosCola where UltimoResultado='En Cola' order by AgrupadorDeTandaPeriodos DESC ")
    End Function

    Public Shared Function TraerPrimerAtrasado(ByVal SC As String) As DataTable
        Return ExecDinamico(SC, "select TOP 1 * from WilliamsMailFiltrosCola where UltimoResultado LIKE 'Procesando%' order by AgrupadorDeTandaPeriodos DESC ")
    End Function

    Public Shared Function TraerAtrasados(ByVal SC As String) As DataTable
        Return ExecDinamico(SC, "select * from WilliamsMailFiltrosCola where UltimoResultado LIKE 'Procesando%' order by AgrupadorDeTandaPeriodos DESC ")
    End Function

    Public Shared Function TraerAtrasadosCount(ByVal SC As String) As DataTable
        Return ExecDinamico(SC, "select count(*) from WilliamsMailFiltrosCola where UltimoResultado LIKE 'Procesando%' ")
    End Function

    Public Shared Function TraerUno(ByVal SC As String, ByVal id As Integer) As DataTable
        Return ExecDinamico(SC, "select * from WilliamsMailFiltrosCola where idWilliamsMailFiltroCola=" & id)
    End Function





    Public Shared Function Insert_o_Update(ByVal SC As String, ByVal dt As DataTable) As Integer
        '// Write your own Insert statement blocks 


        'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
        ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
        'y esto? http://www.vbforums.com/showthread.php?t=352219


        ''convertir datarow en datatable
        'Dim ds As New DataSet
        'ds.Tables.Add(dr.Table.Clone())
        'ds.Tables(0).ImportRow(dr)

        Dim myConnection = New SqlConnection(Encriptar(SC))

        Try
            myConnection.Open()

            Dim adapterForTable1 = New SqlDataAdapter("select * from WilliamsMailFiltrosCola", myConnection)
            Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
            'si te tira error acá, ojito con estar usando el dataset q usaste para el 
            'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update
            adapterForTable1.Update(dt)
            Return 0
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            Insert_o_Update = -1
        Finally
            myConnection.Close()
        End Try

    End Function





End Class







<Serializable()> Public Class CDPDestino
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

    Public Destino As Integer
    Public Procedencia As Integer
End Class

Public Class CDPDestinosManager

    Const Tabla = "WilliamsDestinos"
    Const IdTabla = "IdWilliamsDestino"

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
                    " CLICO1.Razonsocial as Subcontratista1Desc, " & _
                    " CLICO2.Razonsocial as Subcontratista2Desc " & _
                    " ,PROVINCIAS.Nombre as Provincia, LOCALIDADES.Nombre as Localidad " & _
                    " FROM " & Tabla & " A " & _
                    " LEFT OUTER JOIN Clientes CLICO1 ON A.Subcontratista1 = CLICO1.IdCliente " & _
                    " LEFT OUTER JOIN Clientes CLICO2 ON A.Subcontratista2 = CLICO2.IdCliente " & _
                    " LEFT OUTER JOIN LOCALIDADES  ON LOCALIDADES.IdLocalidad = A.IdLocalidad " & _
                    " LEFT OUTER JOIN PROVINCIAS ON PROVINCIAS.IdProvincia = A.IdProvincia " & _
                                ""))
        '" LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & _
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

    Shared Function Update(ByVal sc As String, ByVal centro As String, ByVal oncaa As String, _
                               _obsoleto As String, codpostal As String, poblacion As String, empresa As String, planta As String _
, Optional localidadequivalente As Integer? = Nothing _
)


        Dim db = New LinqCartasPorteDataContext(Encriptar(sc))


        Dim ue As WilliamsDestino = (From p In db.WilliamsDestinos _
                       Where ((p.CodigoONCAA = oncaa And oncaa <> "") Or (p.Descripcion = planta And planta <> "")) _
                       Select p).FirstOrDefault


        'Centro	    Código ONCCA		Código Postal	Población	Nombre Empresa	Nombre Planta
        '0655		MOLINOS	2200	San Lorenzo	MOLINOS RIO DE LA PLATA S.A.	Molinos Pta. Binielli
        '0830   	21078	CARGILL	8103	Ingeniero White	CARGILL SACI	Cargill - Bahía Blanca
        'el "codigo oncca" de cargill es 21708, pero en williams solo se usa en "codigo YPF", y en oncca pusieron 25429


        If IsNothing(ue) Then
            ue = New WilliamsDestino

            ue.Descripcion = planta
            ue.CodigoONCAA = oncaa
            ue.CodigoYPF = centro ' oncaa
            ue.CodigoPostal = codpostal

            ue.IdLocalidad = localidadequivalente

            db.WilliamsDestinos.InsertOnSubmit(ue)
        Else


            ue.Descripcion = planta
            'ue.CodigoONCAA = centro
            If centro <> "" Then ue.CodigoYPF = centro ' oncaa
            If codpostal <> "" Then ue.CodigoPostal = codpostal

            If localidadequivalente IsNot Nothing Then ue.IdLocalidad = localidadequivalente
        End If


        'buscar todos los establecimientos con codigos con letras y intercambiarlos con la descripcion

        'update establecimientos
        'set aux1=descripcion, descripcion=
        'where descripcion is alfanumeric --recordar que uso descripcion por codigo 
        '

        db.SubmitChanges()
    End Function

    Public Shared Function Delete(ByVal SC As String, ByVal Id As Long)
        '// Write your own Delete statement blocks. 
        ExecDinamico(SC, String.Format("DELETE  " & Tabla & "  WHERE {1}={0}", Id, IdTabla))
    End Function



End Class



Public Class LogicaInformesWilliams


    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////




    Shared Sub GeneroDataTablesDeMovimientosDeStock(ByRef dtCDPs As DataTable, ByRef dtRenglonUnicoConLasExistencias As Object, _
                                             ByRef dtMOVs As Object, _
                                             ByVal idDestinatario As Integer, ByVal idDestino As Integer, ByVal idarticulo As Integer, _
                                             ByVal desde As Date, ByVal hasta As Date, ByVal sc As String)


        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10263  rechazadas están saliendo en el informe de existencias
        'no tengo que incluir los rechazos!, ni los duplicados

        'aca uso el _informes, y en el .rdl uso _informescorregido ....
        'efectivamente, ahí usa VendedorDesc en lugar de TitularDesc....


        Dim sTitulo As String = ""

        dtCDPs = CartaDePorteManager.GetDataTableFiltradoYPaginado(sc, _
                "", "", "", 1, 0, _
                enumCDPestado.TodasMenosLasRechazadas, "", -1, -1, _
                idDestinatario, -1, _
                -1, idarticulo, -1, idDestino, _
                "1", "Export", _
                 desde, hasta, -1, sTitulo, , , , , , , , , )



        Dim db As New LinqCartasPorteDataContext(Encriptar(sc))



        Dim movs = (From i In db.CartasPorteMovimientos _
                    Join c In db.linqClientes On i.IdExportadorOrigen Equals c.IdCliente _
                    Where _
                        (i.FechaIngreso >= desde And i.FechaIngreso <= hasta) _
                        And (i.IdArticulo = idarticulo) _
                        And (i.Puerto = idDestino) _
                        And ( _
                                (i.IdExportadorOrigen = idDestinatario) _
                                Or (i.IdExportadorDestino = idDestinatario) _
                        ) _
                        And If(i.Anulada, "NO") <> "SI" _
                    Select Tipo = f(i.Tipo), _
                                ExportadorOrigen = c.RazonSocial, i.FechaIngreso, _
                                i.Entrada_o_Salida, i.Cantidad, i.Vapor, i.Contrato, i.IdCDPMovimiento, i.Numero _
                ).ToList







        dtMOVs = movs

        'Dim dsVistaMOVS = CDPStockMovimientoManager.GetList(sc)







        '/////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////
        'mejunje: le estoy pasando un segundo dataset con las existencias calculadas
        'en VBasic. Tambien se podría usar la funcion SQL wExistencias......, pero es mas
        'piola calcularlo por visual. -Sí, pero así haces al informe dependiente del codigo... qué
        'se hace en un caso así?
        '/////////////////////////////////////////////////////

        'dt2 = New DataTable
        'dt2.Columns.Add("Existencias", GetType(Double))
        'dt2.Rows.Add(dt2.NewRow)
        ''dt2 = EntidadManager.ExecDinamico(HFSC.Value, "SELECT dbo.wExistenciasCartaPorteMovimientos (null,null,null) as Existencias")
        Dim ex = ExistenciasAlDiaPorPuerto(sc, desde, idarticulo, idDestino, idDestinatario)

        dtRenglonUnicoConLasExistencias = (From i In db.CartasDePortes.Take(1) Select Existencias = ex, CampoDummyParaQueGuardeElNombre = 0).ToList


        '/////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////






    End Sub

    Shared Function f(ByVal i As Integer) As String
        Dim TiposMovs() As String = {"Préstamo", "Transferencia", "Devolución", "Embarque", "Venta"}
        Try
            Return TiposMovs(i - 1)
        Catch ex As Exception
            Return ""
        End Try
    End Function



    Shared Function ExistenciasAlDiaPorPuerto(ByVal sc As String, ByVal Fecha As DateTime, _
                                              ByVal IdArticulo As Integer, ByVal IdDestinoWilliams As Integer, _
                                              ByVal iddestinatario As Integer) As Double

        Dim entradasMOV, entradasCDP, salidasMOV As Double
        Dim db As New LinqCartasPorteDataContext(Encriptar(sc))


        '///////////////////////////////////////////////
        'entradas por cartas de porte
        '///////////////////////////////////////////////

        'por qué no incluye acá la id 2092346? -por el subnumero de facturacion


        If True Then

            'acá tenes un tema con usar Fecha o Fecha-1
            '-si el tipo elige desde hoy hasta hoy, tenes que llamar a la funcion con el ultimo segundo de ayer, porque GetDataTableFiltradoYPaginado_CadenaSQL usa menor o igual


            Dim sql = CartaDePorteManager.GetDataTableFiltradoYPaginado_CadenaSQL(sc, _
                    "", "", "", 1, 0, _
                 enumCDPestado.TodasMenosLasRechazadas, "", -1, -1, _
                    iddestinatario, -1, _
                    -1, IdArticulo, -1, IdDestinoWilliams, _
                   "1", "Export", _
                      #1/1/1750#, DateAdd(DateInterval.Second, -1, Fecha), -1, , , , , , , , , , )



            entradasCDP = EntidadManager.ExecDinamico(sc, "select isnull(sum(netoproc),0) as total  from (" + sql + ") as C").Rows(0).Item(0)



        ElseIf False Then

            Dim q As IQueryable(Of CartasConCalada) = CartasLINQlocalSimplificadoTipadoConCalada(sc, _
                    "", "", "", 1, 0, _
                    enumCDPestado.TodasMenosLasRechazadas, "", -1, -1, _
                     iddestinatario, -1, _
                    -1, IdArticulo, -1, IdDestinoWilliams, _
                    FiltroANDOR.FiltroOR, enumCDPexportacion.Export, _
                     #1/1/1980#, Fecha, -1)

            Dim c = q.Count
            If c = 0 Then
                entradasCDP = 0
            Else
                'parece que si no trae registros, me explota el sum
                entradasCDP = q.DefaultIfEmpty.Sum(Function(x) x.NetoProc)
            End If

        Else

            'el true está obviando la condicion de SubnumeroDeFacturacion
            'el tema es que no puedo tomar solo la original, porque la que suele estar marcada como exportacion es una copia


            Dim q = Aggregate i In db.CartasDePortes _
                    Where (If(i.FechaDescarga, i.FechaDeCarga) < Fecha) _
                        And (If(i.SubnumeroDeFacturacion, 0) <= 0) _
                        And db.CartasDePortes.Any(Function(x) x.Exporta = "SI" And x.NumeroCartaDePorte = i.NumeroCartaDePorte) _
                        And i.Anulada <> "SI" _
                        And If(i.Destino, 0) = IdDestinoWilliams _
                        And If(i.IdArticulo, 0) = IdArticulo _
                        And If(i.Entregador, 0) = iddestinatario _
                    Into Sum(CType(i.NetoProc, Decimal?))

            entradasCDP = iisNull(q, 0)
        End If


        '///////////////////////////////////////////////
        'movimientos:
        '///////////////////////////////////////////////

        Dim temp = From i In db.CartasPorteMovimientos _
                   Where _
                        (i.FechaIngreso < Fecha) _
                    And (i.IdArticulo = IdArticulo) _
                    And (i.Puerto = IdDestinoWilliams) _
                    And ( _
                            (i.IdExportadorOrigen = iddestinatario) _
                            Or (i.IdExportadorDestino = iddestinatario) _
                        ) _
                    And If(i.Anulada, "NO") <> "SI"
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        'Throw New Exception("revisar este asunto, porque lo de entrada salida confunde")

        'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=12386





        Dim etemp = temp.Where(Function(i) ( _
                                                ( _
                                                    (i.Entrada_o_Salida = 1 And i.IdExportadorDestino = iddestinatario) _
                                                        Or _
                                                    (i.Entrada_o_Salida = 2 And i.IdExportadorOrigen = iddestinatario) _
                                                ) _
                                                And (i.FechaIngreso < Fecha))).DefaultIfEmpty

        etemp = temp.Where(Function(i) ((i.Entrada_o_Salida = 1) And (i.FechaIngreso < Fecha))).DefaultIfEmpty

        Debug.Print(etemp.Count)
        entradasMOV = etemp.Sum(Function(i) If(i.Cantidad, 0))



        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        Dim stemp = temp.Where(Function(i) ( _
                                                ( _
                                                    (i.Entrada_o_Salida = 2 And i.IdExportadorDestino = iddestinatario) _
                                                        Or _
                                                    (i.Entrada_o_Salida = 1 And i.IdExportadorOrigen = iddestinatario) _
                                                ) _
                                                And (i.FechaIngreso < Fecha))).DefaultIfEmpty


        stemp = temp.Where(Function(i) ((i.Entrada_o_Salida = 2) And (i.FechaIngreso < Fecha))).DefaultIfEmpty



        Debug.Print(stemp.Count)
        salidasMOV = stemp.Sum(Function(i) If(i.Cantidad, 0))


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////


        ErrHandler2.WriteError("entradasCDP: " & entradasCDP)
        ErrHandler2.WriteError("entradasMOV: " & entradasMOV)
        ErrHandler2.WriteError("salidas: " & salidasMOV)
        ErrHandler2.WriteError("total: " & (entradasCDP + entradasMOV - salidasMOV))


        Dim a5 = From x In stemp Order By x.IdCDPMovimiento Select CStr(x.IdCDPMovimiento)

        ErrHandler2.WriteError(vbCrLf & Join(a5.ToArray, vbCrLf))

        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////




        Return entradasCDP + entradasMOV - salidasMOV

    End Function


    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////

End Class



Public Class UserDatosExtendidosManager

    Shared Function Update(ByVal userid As String, ByVal razonsocial As String, cuit As String, ConexBDLmaster As String)
        Dim db = New LinqBDLmasterDataContext(Encriptar(ConexBDLmaster))


        Dim ue = (From p In db.UserDatosExtendidos _
                       Where p.UserId.ToString = userid _
                       Select p).SingleOrDefault


        If IsNothing(ue) Then
            ue = New UserDatosExtendido
            ue.UserId = New Guid(userid)
            ue.RazonSocial = razonsocial
            ue.CUIT = cuit

            db.UserDatosExtendidos.InsertOnSubmit(ue)
        Else
            ue.RazonSocial = razonsocial
        End If

        db.SubmitChanges()
    End Function

    Private Shared Function Traer(ByVal UserId As String, ConexBDLmaster As String) As UserDatosExtendido

        Dim db = New LinqBDLmasterDataContext(Encriptar(ConexBDLmaster))

        Dim uext = (From p In db.UserDatosExtendidos _
                       Where p.UserId.ToString = UserId _
                       Select p).SingleOrDefault

        Return uext
    End Function

    Private Shared Function TraerIdClienteRelacionado(ByVal UserId As String, ConexBDLmaster As String) As Integer

        Dim db = New LinqBDLmasterDataContext(Encriptar(ConexBDLmaster))

        Dim uext = (From p In db.UserDatosExtendidos _
                       Where p.UserId.ToString = UserId _
                       Select p).SingleOrDefault

        Return Convert.ToInt32(uext.RazonSocial)
    End Function


    Public Shared Function TraerRazonSocialDelUsuario(ByVal UserId As String, ConexBDLmaster As String, SC As String) As String

        Dim db = New LinqBDLmasterDataContext(Encriptar(ConexBDLmaster))

        Dim uext = (From p In db.UserDatosExtendidos _
                       Where p.UserId.ToString = UserId _
                       Select p).SingleOrDefault

        Return NombreCliente(SC, uext.RazonSocial)
    End Function
    

End Class