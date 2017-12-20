﻿Imports System
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Collections.Generic
Imports Pronto.ERP.BO
Imports Pronto.ERP.Bll

Imports System.Data
Imports System.Data.SqlClient

Imports System.Linq
Imports System.Xml.Linq

Imports System.IO

Imports System.Configuration

Imports Microsoft.VisualBasic

'http://msdn.microsoft.com/en-us/library/s5xy331f(v=vs.110).aspx
'http://stackoverflow.com/questions/639987/is-it-possible-to-perform-a-web-service-call-inside-a-reporting-services-report


'<SoapDocumentService(Use:=System.Web.Services.Description.SoapBindingUse.Literal,   ParameterStyle:=SoapParameterStyle.Wrapped)> _
<WebService(Namespace:="http://microsoft.com/webservices/")>
<System.Web.Script.Services.ScriptService()>
Public Class WebServiceCartas
    Inherits System.Web.Services.WebService

    ''

    Public ReadOnly Property scLocal() As String
        Get
            Return ConfigurationManager.AppSettings("scLocal")
        End Get
    End Property
    Public ReadOnly Property scWilliamsRelease() As String
        Get
            Return ConfigurationManager.AppSettings("scWilliamsRelease")
        End Get
    End Property

    Public ReadOnly Property scWilliamsDebug() As String
        Get
            Return ConfigurationManager.AppSettings("scWilliamsDebug")
        End Get
    End Property


    Public ReadOnly Property scConexBDLmaster() As String
        Get
            Return ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        End Get
    End Property



    Public ReadOnly Property AplicacionConImagenes() As String 'si lo uso desde prontoclientes, debo apuntar hacia el de pronto a secas
        Get
            Return ConfigurationManager.AppSettings("AplicacionConImagenes")
        End Get
    End Property







    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    'tambien hay que tener cuidado con el Namespace: tempuri.org o microsoft.com\services
    'para conectarse a la List, uso en el informe:
    '
    'DATASOURCE
    'Embedded conection:
    '    Type: XML
    '    Conection string : http://localhost/ProntoTesting/ProntoWeb/WebServiceCartas.asmx?wsdl
    'Credenciales
    '   poner usuario y pass específicos -no podés, tenes que usar Windows Credentials. Pero anda igual! No sé cómo! Cómo autorizó el acceso al webservice en el server de williams??? 
    'http://stackoverflow.com/questions/8232246/ssrs-report-rendering-hangs-with-stored-credentials-for-xml-data-source-type?rq=1
    '
    'y en el DATASET:
    'Query:
    '   <Query>
    '   <Method Namespace="http://microsoft.com/webservices" Name="GetCartas"></Method>
    '   <SoapAction>http://microsoft.com/webservices/GetCartas</SoapAction>
    '   </Query>


    'Pero no sirve para conectarse al formato Dataset

    'El reporteador devuelve columnas si el método no tiene parámetros. Si uso parámetros, devuelve un par de columnas extrañas.


    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    'para pasar parametros al webservice usado por el informe, tenes que agregar:
    '                   <Parameters>      <Parameter Name="Item">
    'por cada parametro en la Query, y
    'en Parameters del Dataset el parametro que corresponda.

    'http://stackoverflow.com/questions/2961168/how-to-use-xml-and-web-service-data-sources-as-a-source-for-reporting-servi?rq=1
    'https://msdn.microsoft.com/en-us/library/aa964129(SQL.90).aspx



    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




    <WebMethod(Description:="Devuelve un archivo con la imagen de la carta porte", EnableSession:=False)>
    Public Function BajarImagenDeCartaPorte(usuario As String, password As String, numerocarta As Long) As Byte()

        Try

            Dim scs As String

            If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
                scs = scLocal
            Else
                scs = scWilliamsRelease
            End If

            Return CartaDePorteManager.BajarImagenDeCartaPorte_DLL(usuario, password, numerocarta, Encriptar(scs), AplicacionConImagenes, Encriptar(scConexBDLmaster))
        Catch ex As Exception

            ErrHandler2.WriteError(ex)
        End Try

    End Function




    <WebMethod(Description:="Devuelve un listado de descargas", EnableSession:=False)>
    Public Function BajarListadoDeCartaPorte(usuario As String, password As String, fechadesde As DateTime, fechahasta As DateTime) As Byte()


        Try

            Dim scs As String

            If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
                scs = scLocal
            Else
                scs = scWilliamsRelease
            End If

            Return CartaDePorteManager.BajarListadoDeCartaPorte_DLL(usuario, password, fechadesde, fechahasta, Encriptar(scs), AplicacionConImagenes, Encriptar(scConexBDLmaster))
        Catch ex As Exception

            ErrHandler2.WriteError(ex)
        End Try



    End Function


    <WebMethod(Description:="Devuelve un listado de descargas con formato Cerealnet", EnableSession:=False)>
    Public Function BajarListadoDeCartaPorte_CerealNet(usuario As String, password As String, cuit As String, fechadesde As DateTime, fechahasta As DateTime) As CerealNet.WSCartasDePorte.respuestaEntrega


        Try

            Dim scs As String

            If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
                scs = scLocal
            Else
                scs = scWilliamsRelease
            End If

            Return CartaDePorteManager.BajarListadoDeCartaPorte_CerealNet_DLL(usuario, password, cuit, fechadesde, fechahasta, Encriptar(scs), AplicacionConImagenes, Encriptar(scConexBDLmaster))
        Catch ex As Exception

            ErrHandler2.WriteError(ex)
        End Try



    End Function






    <WebMethod(Description:="", EnableSession:=False)>
    Public Function GrabarComentario(idCartaPorte As Integer, sComentario As String, usuarioDestino As String) As String


        Try

            Dim scs As String

            If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
                scs = scLocal
            Else
                'scs = scWilliamsRelease
                scs = scWilliamsDebug
            End If




            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






            GrabarComentarioYEnviarMailNotificacionSegunUsuariosDelReclamo(idCartaPorte, sComentario, scs, usuarioDestino)


            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





        Catch ex As Exception

            ErrHandler2.WriteError(ex)
            Throw
        End Try



    End Function






    Private Function GrabarComentarioYEnviarMailNotificacionSegunUsuariosDelReclamo(idCartaPorte As Integer, sComentario As String, scs As String, usuarioDestino As String)


        Dim carta = CartaDePorteManager.GetItem(Encriptar(scs), idCartaPorte)
        Dim usuario = Membership.GetUser.UserName
        Dim s = New ServicioCartaPorte.servi()
        Dim usuarios As String() = s.GrabarComentario_DLL(idCartaPorte, sComentario, usuario, Encriptar(scs), usuarioDestino)




        Dim linkAlReclamo = ConfigurationManager.AppSettings("UrlDominio") + "/ProntoWeb/CartaDePorteMovil.aspx?Id=" + idCartaPorte.ToString
        Dim casillas = ""
        For Each u In usuarios
            If u Is Nothing Then Continue For
            If u = usuario Then Continue For
            If Membership.GetUser(u) Is Nothing Then Continue For
            casillas += Membership.GetUser(u).Email + ","
        Next


        If Not (Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsComercial") Or Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsAdmin") Or Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsFacturacion")) Then
            'como es un usuario externo el q hace el comentario, incluyo en las casillas a la oficina

            Dim De As String
            Dim CCOaddress As String
            Select Case carta.PuntoVenta
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

            casillas += De 'ConfigurationManager.AppSettings("ErrorMail")

            'como es un externo, como hago con la notificacion al usuario interno?
        End If




        Dim coment = "Comentario de " + usuario + ": <br/>" + sComentario + "<br/><br/> " + "<a href='" + linkAlReclamo + "'>Link al comentario</a>"

        Try


            Pronto.ERP.Bll.EntidadManager.MandaEmail_Nuevo(casillas,
                               "Consulta por carta porte",
                            coment,
                            ConfigurationManager.AppSettings("SmtpUser"),
                            ConfigurationManager.AppSettings("SmtpServer"),
                            ConfigurationManager.AppSettings("SmtpUser"),
                            ConfigurationManager.AppSettings("SmtpPass"),
                              "",
                           Convert.ToInt16(ConfigurationManager.AppSettings("SmtpPort")),,,,,,)

        Catch ex As Exception
            ErrHandler2.WriteError(ex)

        End Try


        s.EnviarNotificacionALosDispositivosDelUsuario(usuarioDestino, coment, "consulta", Encriptar(scs))




    End Function



    <WebMethod(Description:="", EnableSession:=False)>
    Public Function CerrarReclamo(idCartaPorte As Integer, usuarioDestino As String) As String


        Try

            Dim scs As String

            If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
                scs = scLocal
            Else
                'scs = scWilliamsRelease
                scs = scWilliamsDebug
            End If




            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            Dim carta = CartaDePorteManager.GetItem(Encriptar(scs), idCartaPorte)
            Dim usuario = Membership.GetUser.UserName
            Dim s = New ServicioCartaPorte.servi()
            Dim usuarios = s.CerrarReclamo_DLL(idCartaPorte, usuario, Encriptar(scs), usuarioDestino)



            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





        Catch ex As Exception

            ErrHandler2.WriteError(ex)
            Throw
        End Try



    End Function


    <WebMethod(Description:="", EnableSession:=False)>
    Public Function AbrirReclamo(idCartaPorte As Integer, usuarioDestino As String) As String


        Try

            Dim scs As String

            If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
                scs = scLocal
            Else
                'scs = scWilliamsRelease
                scs = scWilliamsDebug
            End If




            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            Dim carta = CartaDePorteManager.GetItem(Encriptar(scs), idCartaPorte)
            Dim usuario = Membership.GetUser.UserName
            Dim s = New ServicioCartaPorte.servi()
            Dim usuarios = s.AbrirReclamo_DLL(idCartaPorte, usuario, Encriptar(scs), usuarioDestino)



            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





        Catch ex As Exception

            ErrHandler2.WriteError(ex)
            Throw
        End Try



    End Function



    <WebMethod(Description:="", EnableSession:=False)>
    Public Function EstadoReclamo(idCartaPorte As Integer, usuarioDestino As String) As Integer


        Try

            Dim scs As String

            If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
                scs = scLocal
            Else
                'scs = scWilliamsRelease
                scs = scWilliamsDebug
            End If




            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            Dim carta = CartaDePorteManager.GetItem(Encriptar(scs), idCartaPorte)
            Dim usuario = Membership.GetUser.UserName
            Dim s = New ServicioCartaPorte.servi()
            Dim ret = s.EstadoReclamo_DLL(idCartaPorte, usuario, Encriptar(scs), usuarioDestino)



            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            Return ret



        Catch ex As Exception

            ErrHandler2.WriteError(ex)
            Throw
        End Try



    End Function











    <WebMethod(Description:="", EnableSession:=False)>
    Public Function GrabarSituacion(idcarta As Long, idsituacion As Integer, sObservacionesSituacion As String) As String


        Try

            Dim scs As String

            If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
                scs = scLocal
            Else
                'scs = scWilliamsRelease
                scs = scWilliamsDebug
            End If

            Return CartaDePorteManager.GrabarSituacion_DLL(idcarta, idsituacion, sObservacionesSituacion, Encriptar(scs))
        Catch ex As Exception

            ErrHandler2.WriteError(ex)
        End Try



    End Function




    <WebMethod(Description:="", EnableSession:=False)>
    Public Function GrabarSituaciones(idscartas As Long(), idsituacion As Integer, sObservacionesSituacion As String) As String


        Try

            Dim scs As String

            If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
                scs = scLocal
            Else
                'scs = scWilliamsRelease
                scs = scWilliamsDebug
            End If

            Return CartaDePorteManager.GrabarSituaciones_DLL(idscartas, idsituacion, sObservacionesSituacion, Encriptar(scs))
        Catch ex As Exception

            ErrHandler2.WriteError(ex)
        End Try



    End Function





    <WebMethod(Description:="", EnableSession:=False)>
    Public Function MapaGeoJSON(modoExportacion As String, fechadesde As Date, fechahasta As Date, idprocedencia As Integer, idarticulo As Integer, idclientefacturado As Integer, tonsdesde As Integer, tonshasta As Integer) As String




        Try

            Dim scs As String

            If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
                scs = scLocal
            Else
                scs = scWilliamsRelease
            End If



            Dim s = New ServicioCartaPorte.servi()
            Return s.MapaGeoJSON_DLL(Encriptar(scs), modoExportacion, fechadesde, fechahasta, idprocedencia, idarticulo, idclientefacturado, tonsdesde, tonshasta)


        Catch ex As Exception

            ErrHandler2.WriteError(ex)
        End Try



    End Function












    <WebMethod(Description:="", EnableSession:=False)>
    Public Function AsociarUsuarioConTokenFirebase(token As String) As String


        Try

            Dim scs As String

            If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
                scs = scLocal
            Else
                'scs = scWilliamsRelease
                scs = scWilliamsDebug
            End If


            Dim usuario = Membership.GetUser().UserName


            Dim s = New ServicioCartaPorte.servi()
            s.AsociarUsuarioConTokenFirebase(token, usuario, Encriptar(scs))



        Catch ex As Exception

            ErrHandler2.WriteError(ex)
            Throw
        End Try



    End Function















    '<WebMethod(Description:="", EnableSession:=False)>
    '<System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    'Public Sub ReclamosMaestro(sidx As String, sord As String, page As Integer, rows As Integer, _search As Boolean,
    '                                 FechaInicial As String, FechaFinal As String, puntovent As Integer, idcarta As Integer, nombreusuario As String) ' As String
    '    ReclamosMaestro(sidx, sord, page, rows, _search, "",
    '                                 FechaInicial, FechaFinal, puntovent, idcarta, nombreusuario)


    '    'https://stackoverflow.com/questions/1522585/can-web-methods-be-overloaded  -parece que no....

    'End Sub



    <WebMethod(Description:="", EnableSession:=False)>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Sub ReclamosMaestro(sidx As String, sord As String, page As Integer, rows As Integer, _search As Boolean,
                                    filters As String, FechaInicial As String, FechaFinal As String, puntovent As Integer, idcarta As Integer, nombreusuario As String) ' As String


        Try

            Dim scs As String

            If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
                scs = scLocal
            Else
                'scs = scWilliamsRelease
                scs = scWilliamsDebug
            End If


            Dim SCbdlmaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)




            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            Dim carta = CartaDePorteManager.GetItem(Encriptar(scs), idcarta)
            Dim usuario = ""
            Dim s = New ServicioCartaPorte.servi()


            If Not (Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsComercial") Or Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsAdmin") Or Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsFacturacion")) Then
                usuario = Membership.GetUser.UserName
            End If


            Dim ret = s.ReclamosMaestro_DynamicGridData(sidx, sord, page, rows, _search, filters, "", "", 0, idcarta, Encriptar(scs), usuario, SCbdlmaster)
            'Dim ret = s.ReclamosComentarios_DynamicGridData(sidx, sord, page, rows, _search, filters, "", "", 0, idcarta, Encriptar(scs), "", SCbdlmaster)







            ' https://stackoverflow.com/questions/19563641/how-to-get-json-response-from-a-3-5-asmx-web-service

            Context.Response.Clear()
            Context.Response.ContentType = "application/json"
            'HelloWorldData Data = New HelloWorldData()
            'Data.Message = "HelloWorld"
            'Context.Response.Write(js.Serialize(Data));
            Context.Response.Write(ret)
            '            Return ret

        Catch ex As Exception

            ErrHandler2.WriteError(ex)
            Throw
        End Try



    End Sub




















    '<WebMethod(Description:="", EnableSession:=False)>
    '<System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    'Public Sub ReclamosMaestro(sidx As String, sord As String, page As Integer, rows As Integer, _search As Boolean,
    '                                 FechaInicial As String, FechaFinal As String, puntovent As Integer, idcarta As Integer, nombreusuario As String) ' As String
    '    ReclamosMaestro(sidx, sord, page, rows, _search, "",
    '                                 FechaInicial, FechaFinal, puntovent, idcarta, nombreusuario)


    '    'https://stackoverflow.com/questions/1522585/can-web-methods-be-overloaded  -parece que no....

    'End Sub



    <WebMethod(Description:="", EnableSession:=False)>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Sub ReclamosComentarios(sidx As String, sord As String, page As Integer, rows As Integer, _search As Boolean,
                                    filters As String, FechaInicial As String, FechaFinal As String, puntovent As Integer, idcarta As Integer, nombreusuario As String) ' As String


        Try

            Dim scs As String

            If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
                scs = scLocal
            Else
                'scs = scWilliamsRelease
                scs = scWilliamsDebug
            End If


            Dim SCbdlmaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)




            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            Dim carta = CartaDePorteManager.GetItem(Encriptar(scs), idcarta)
            Dim usuario = ""
            usuario = Membership.GetUser.UserName

            Dim s = New ServicioCartaPorte.servi()


            If Not (Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsComercial") Or Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsAdmin") Or Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsFacturacion")) Then
                'el usuario es  externo
                nombreusuario = usuario
            End If


            'Dim ret = s.ReclamosMaestro_DynamicGridData(sidx, sord, page, rows, _search, filters, "", "", 0, idcarta, Encriptar(scs), usuario, SCbdlmaster)
            'Dim ret = s.ReclamosComentarios_DynamicGridData(sidx, sord, page, rows, _search, filters, "", "", 0, idcarta, Encriptar(scs), "", SCbdlmaster)



            Dim ret = s.ReclamosComentarios_DynamicGridData(
                                        sidx, sord, page,
                                        rows, _search, filters, FechaInicial, FechaFinal, Convert.ToInt32(puntovent),
                                        Convert.ToInt32(idcarta),
                                        Encriptar(scs), usuario, SCbdlmaster, nombreusuario)




            ' https://stackoverflow.com/questions/19563641/how-to-get-json-response-from-a-3-5-asmx-web-service

            Context.Response.Clear()
            Context.Response.ContentType = "application/json"
            'HelloWorldData Data = New HelloWorldData()
            'Data.Message = "HelloWorld"
            'Context.Response.Write(js.Serialize(Data));
            Context.Response.Write(ret)
            '            Return ret

        Catch ex As Exception

            ErrHandler2.WriteError(ex)
            Throw
        End Try



    End Sub







End Class