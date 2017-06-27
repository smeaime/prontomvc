Imports System
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Collections.Generic
Imports Pronto.ERP.BO
Imports Pronto.ERP.Bll

Imports System.Web.Script.Serialization
Imports System.Web.Script.Services

Imports ProntoMVC.Data.Models

Imports CartaDePorteManager

<WebService(Namespace:="http://tempuri.org/")>
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<System.Web.Script.Services.ScriptService()>
Public Class WebServiceClientes
    Inherits System.Web.Services.WebService

    <WebMethod()>
    Public Function GetCompletionList(ByVal prefixText As String, ByVal count As Integer, ByVal contextKey As String) As String()
        'Dim c1 As Char
        'Dim c2 As Char
        'Dim c3 As Char

        If (count = 0) Then
            count = 10
        End If

        'Dim rnd As New Random()

        Dim items As New List(Of String)

        Dim cod As String




        Dim sc As String '= "Data Source=NANOPC\SQLEXPRESS;Initial catalog=Equimac;User ID=sa; Password=ok;Connect Timeout=45"
        sc = contextKey
        '/////////////////////////////
        '/////////////////////////////
        'funciona esto? conviene?
        'Dim Usuario As New Usuario
        'Usuario = session(SESSIONPRONTO_USUARIO)
        'sc = Usuario.StringConnection
        '/////////////////////////////
        '/////////////////////////////


        '/////////////////////////////
        'para debug, saco el acceso a sql y veo cuanto tarda el webservice
        'items.Add("""{""First"":""AUTOCOMPLETE DEBUG"",""Second"":""0""}""")
        'items.Add("""{""First"":""AUTOCOMPLETE DEBUG"",""Second"":""0""}""")
        'items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem("AUTOCOMPLETE DEBUG", 0))
        '/////////////////////////////





        Dim clientelist = EntidadManager.GetStoreProcedure(sc, enumSPs.wClientes_TX_Busqueda, prefixText)
        For Each cliente As Data.DataRow In clientelist.Rows
            'items.Add(articulo.Descripcion)

            cod = cliente.Item("IdCliente") & "^" & cliente.Item("Cuit")
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(cliente.Item("RazonSocial"), cod))
        Next

        'http://vincexu.blogspot.com/2008/12/custom-autocomplete-3-check-if.html
        If clientelist.Rows.Count = 0 Then
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem("No se encontraron resultados", -1))
        End If




        ' '//////////////////////////////////////////////////////////////////////////////////////////////
        ' '//////////////////////////////////////////////////////////////////////////////////////////////
        ' 'codigo para traer el ID
        ' ' http://lisazhou.wordpress.com/2007/12/14/ajaxnet-autocomplete-passing-selected-value-id-to-code-behind/
        ' 'http://forums.asp.net/t/1162005.aspx
        ' 'http://forums.asp.net/p/1131690/1796218.aspx
        ' 'http://www.codeplex.com/AjaxControlToolkit/WorkItem/View.aspx?WorkItemId=9043

        ' http://blogs.msdn.com/phaniraj/archive/2007/06/19/how-to-use-a-key-value-pair-in-your-autocompleteextender.aspx
        ' '//////////////////////////////////////////////////////////////////////////////////////////////
        ' '//////////////////////////////////////////////////////////////////////////////////////////////

        ' Dim Co As String


        'c string[] GetCompletionListWithContextAndValues(string prefixText, int count, string contextKey)
        '         {
        '             Generic.List<string>(GetCompletionListWithContext(prefixText, count, contextKey));
        '             for (int i = 0; i < items.Count; i++)
        '             {
        '                 items[i] = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(items[i], i.ToString());
        '             }
        '             return items.ToArray();
        '         }

        '     For Each articulo As Pronto.ERP.BO.Articulo In articulolist
        '         items.Add(articulo.Descripcion)


        '         Co = articulo.Codigo & "," & articulo.Descripcion
        '         If sQuickName.StartsWith(prefixText, StringComparison.OrdinalIgnoreCase) Or sCompany.StartsWith(prefixText, StringComparison.OrdinalIgnoreCase) Or sLocationName.StartsWith(prefixText, StringComparison.OrdinalIgnoreCase) Then
        '             '—add the member name to the list if the text starts with the variables—
        '             listOfMembersStartsWith.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(Co, dr("ReceiverPK")))
        '         Else
        '             '—add the member name to the list if the text contains the keyword but not as an prefix—
        '             listOfMembersNotStartsWith.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(Co, dr("ReceiverPK")))
        '         End If

        '     Next




        '     '//////////////////////////////////////////////////////////////////////////////////////////////
        '     '//////////////////////////////////////////////////////////////////////////////////////////////
        '     '//////////////////////////////////////////////////////////////////////////////////////////////
        '     '//////////////////////////////////////////////////////////////////////////////////////////////




        Return items.ToArray()
    End Function


    <WebMethod()>
    Public Function AcopiosPorCliente(NombreCliente As String, SC As String) As List(Of aaa) 'As String()

        'Pronto.ERP.Bll.CartaPorteManagerAux()


        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar("Data Source=serversql3;Initial catalog=Williams;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If

        'ErrHandler2.WriteError("AcopiosPorCliente " & NombreCliente & " - " & Encriptar(SC))



        Try
            Dim idcliente = BuscaIdClientePrecisoConCUIT(NombreCliente, SC)
            Dim a = CartaDePorteManager.excepcionesAcopios(SC, idcliente)
            Return a

        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString)

        End Try


        'Return New String() {"asdas", "ddd"}



    End Function



    Class autocomplete
        Public id As Integer
        Public value As String
    End Class


    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    <WebMethod()>
    Public Function WilliamsDestinoGetWilliamsDestinos(term As String) As String ' As List(Of autocomplete) 'As String()

        Dim SC As String




        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar(scLocal())
            'SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If


        Dim usuario = Membership.GetUser()
        Dim dt As System.Data.DataTable = EntidadManager.ExecDinamico(SC, "Empleados_TX_UsuarioNT '" + usuario.UserName + "'")
        Dim idUsuario As Integer = Convert.ToInt32(dt.Rows(0)(0))
        Dim puntovent As Integer = EmpleadoManager.GetItem(SC, idUsuario).PuntoVentaAsociado



        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        Dim q = (From item In db.WilliamsDestinos
                 Where item.Descripcion.ToLower().Contains(term.ToLower()) And (puntovent = 0 Or item.PuntoVenta = puntovent)
                 Order By item.Descripcion
                 Select New autocomplete With
                 {
                     .id = item.IdWilliamsDestino,
                     .value = item.Descripcion
                 }).Take(10).ToList()


        'Return q

        '    return Json(q, JsonRequestBehavior.AllowGet);

        Dim TheSerializer As JavaScriptSerializer = New JavaScriptSerializer()


        Dim TheJson As String = TheSerializer.Serialize(q)

        Return TheJson


    End Function




    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    <WebMethod()>
    Public Function NormasCalidad_DynamicGridData(sidx As String, sord As String, page As Integer, rows As Integer, _search As Boolean, filters As String) As String 'As ServicioCartaPorte.jqGridJson

        Dim SC As String

        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar(scLocal())
            'SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If



        Dim s = New ServicioCartaPorte.servi()

        Dim q = s.NormasCalidad_DynamicGridData(SC, sidx, sord, page, rows, _search, filters)


        'Dim TheSerializer As JavaScriptSerializer = New JavaScriptSerializer()
        'Dim TheJson As String = TheSerializer.Serialize()

        Dim TheJson As String = Newtonsoft.Json.JsonConvert.SerializeObject(q)


        Return TheJson

    End Function




    '<ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    <WebMethod()>
    Public Function NormasCalidad_DynamicGridData_2(sidx As String, sord As String, page As Integer, rows As Integer, _search As Boolean, filters As String) As ServicioCartaPorte.jqGridJson

        Dim SC As String

        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar(scLocal())
            'SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If



        Dim s = New ServicioCartaPorte.servi()

        Dim q = s.NormasCalidad_DynamicGridData(SC, sidx, sord, page, rows, _search, filters)



        Return q

    End Function




    <WebMethod()>
    Public Function NormaCalidadBatchUpdate(o As CartaPorteNormasCalidad) As String
        'Public Function DestinoBatchUpdate(o As ProntoMVC.Data.Models.CartasDePorteControlDescarga) As String
        ' (o As ProntoMVC.Data.Models.CartasDePorteControlDescarga)




        'http://stackoverflow.com/questions/6292510/passing-data-from-jqgrid-to-webmethod/6296601#6296601
        'http://stackoverflow.com/questions/6292510/passing-data-from-jqgrid-to-webmethod/6296601#6296601
        'http://stackoverflow.com/questions/6292510/passing-data-from-jqgrid-to-webmethod/6296601#6296601
        'http://stackoverflow.com/questions/6292510/passing-data-from-jqgrid-to-webmethod/6296601#6296601

        Dim SC As String

        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar(scLocal())
            'SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If



        Dim s = New ServicioCartaPorte.servi()

        Dim q = s.NormaCalidadBatchUpdate(SC, o)





    End Function


    <WebMethod()>
    Public Function RebajaCalculo(SC As String, rubrodesc As String, resultado As Decimal, articulodesc As String, destinodesc As String) As Decimal 'As String()

        'Pronto.ERP.Bll.CartaPorteManagerAux()


        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar("Data Source=serversql3;Initial catalog=Williams;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If

        'ErrHandler2.WriteError("AcopiosPorCliente " & NombreCliente & " - " & Encriptar(SC))


        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        Dim idrubro = (From item In db.CartaPorteRubrosCalidads Where item.Descripcion = rubrodesc Select item.IdCartaPorteRubroCalidad).Single()
        Dim idarticulo = BuscaIdArticuloPreciso(articulodesc, SC)
        Dim iddestino = BuscaIdWilliamsDestinoPreciso(destinodesc, SC)



        Try
            Dim s = New ServicioCartaPorte.servi()
            Dim r = s.RebajaCalculo(SC, idrubro, resultado, idarticulo, iddestino)
            Return r

        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString)

        End Try


        'Return New String() {"asdas", "ddd"}



    End Function



    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    <WebMethod()>
    Public Function GetNormasCalidad(term As String) As String ' As List(Of autocomplete) 'As String()

        Dim SC As String




        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar(scLocal())
            'SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If



        Dim s = New ServicioCartaPorte.servi()

        Dim q = s.GetNormasCalidad(SC, term)


        'Return q

        '    return Json(q, JsonRequestBehavior.AllowGet);

        Dim TheSerializer As JavaScriptSerializer = New JavaScriptSerializer()


        Dim TheJson As String = TheSerializer.Serialize(q)

        Return TheJson


    End Function


    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    <WebMethod()>
    Public Function NormaCalidadDelete(id As Integer) As String

        Dim SC As String

        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar(scLocal())
            'SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If

        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        Dim q = (From item In db.CartaPorteNormasCalidads
                 Where item.IdCartaPorteNormaCalidad = id).FirstOrDefault()

        db.CartaPorteNormasCalidads.Remove(q)

        db.SaveChanges()


        'Return q

        '    return Json(q, JsonRequestBehavior.AllowGet);

        Dim TheSerializer As JavaScriptSerializer = New JavaScriptSerializer()


        Dim TheJson As String = TheSerializer.Serialize(q)

        Return TheJson


    End Function






    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    <WebMethod()>
    Public Function GetCorredores(term As String) As String ' As List(Of autocomplete) 'As String()

        Dim SC As String




        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar(scLocal())
            'SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If


        Dim usuario = Membership.GetUser()
        Dim dt As System.Data.DataTable = EntidadManager.ExecDinamico(SC, "Empleados_TX_UsuarioNT '" + usuario.UserName + "'")
        Dim idUsuario As Integer = Convert.ToInt32(dt.Rows(0)(0))
        Dim puntovent As Integer = EmpleadoManager.GetItem(SC, idUsuario).PuntoVentaAsociado



        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        Dim q = (From item In db.Vendedores
                 Where item.Nombre.ToLower().Contains(term.ToLower())
                 Order By item.Nombre
                 Select New autocomplete With
                 {
                     .id = item.IdVendedor,
                     .value = item.Nombre
                 }).Take(10).ToList()


        'Return q

        '    return Json(q, JsonRequestBehavior.AllowGet);

        Dim TheSerializer As JavaScriptSerializer = New JavaScriptSerializer()


        Dim TheJson As String = TheSerializer.Serialize(q)

        Return TheJson


    End Function




    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    <WebMethod()>
    Public Function GetLocalidades(term As String) As String ' As List(Of autocomplete) 'As String()

        Dim SC As String




        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar(scLocal())
            'SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If


        Dim usuario = Membership.GetUser()
        Dim dt As System.Data.DataTable = EntidadManager.ExecDinamico(SC, "Empleados_TX_UsuarioNT '" + usuario.UserName + "'")
        Dim idUsuario As Integer = Convert.ToInt32(dt.Rows(0)(0))
        Dim puntovent As Integer = EmpleadoManager.GetItem(SC, idUsuario).PuntoVentaAsociado



        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        Dim q = (From item In db.Localidades
                 Where item.Nombre.ToLower().Contains(term.ToLower())
                 Order By item.Nombre
                 Select New autocomplete With
                 {
                     .id = item.IdLocalidad,
                     .value = item.Nombre
                 }).Take(10).ToList()


        'Return q

        '    return Json(q, JsonRequestBehavior.AllowGet);

        Dim TheSerializer As JavaScriptSerializer = New JavaScriptSerializer()


        Dim TheJson As String = TheSerializer.Serialize(q)

        Return TheJson


    End Function


    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    <WebMethod()>
    Public Function GetProductos(term As String) As String ' As List(Of autocomplete) 'As String()

        Dim SC As String




        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar(scLocal())
            'SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If


        Dim usuario = Membership.GetUser()
        Dim dt As System.Data.DataTable = EntidadManager.ExecDinamico(SC, "Empleados_TX_UsuarioNT '" + usuario.UserName + "'")
        Dim idUsuario As Integer = Convert.ToInt32(dt.Rows(0)(0))
        Dim puntovent As Integer = EmpleadoManager.GetItem(SC, idUsuario).PuntoVentaAsociado



        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        Dim q = (From item In db.Articulos
                 Where item.Descripcion.ToLower().Contains(term.ToLower())
                 Order By item.Descripcion
                 Select New autocomplete With
                 {
                     .id = item.IdArticulo,
                     .value = item.Descripcion
                 }).Take(10).ToList()


        'Return q

        '    return Json(q, JsonRequestBehavior.AllowGet);

        Dim TheSerializer As JavaScriptSerializer = New JavaScriptSerializer()


        Dim TheJson As String = TheSerializer.Serialize(q)

        Return TheJson


    End Function

    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    <WebMethod()>
    Public Function GetClientes(term As String) As String ' As List(Of autocomplete) 'As String()

        Dim SC As String




        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar(scLocal())
            'SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If


        Dim usuario = Membership.GetUser()
        Dim dt As System.Data.DataTable = EntidadManager.ExecDinamico(SC, "Empleados_TX_UsuarioNT '" + usuario.UserName + "'")
        Dim idUsuario As Integer = Convert.ToInt32(dt.Rows(0)(0))
        Dim puntovent As Integer = EmpleadoManager.GetItem(SC, idUsuario).PuntoVentaAsociado



        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        Dim q = (From item In db.Clientes
                 Where item.RazonSocial.ToLower().Contains(term.ToLower())
                 Order By item.RazonSocial
                 Select New autocomplete With
                 {
                     .id = item.IdCliente,
                     .value = item.RazonSocial
                 }).Take(10).ToList()


        'Return q

        '    return Json(q, JsonRequestBehavior.AllowGet);

        Dim TheSerializer As JavaScriptSerializer = New JavaScriptSerializer()


        Dim TheJson As String = TheSerializer.Serialize(q)

        Return TheJson


    End Function

    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    <WebMethod()>
    Public Function DestinoDelete(id As Integer) As String ' As List(Of autocomplete) 'As String()

        Dim SC As String

        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar(scLocal())
            'SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If

        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        Dim q = (From item In db.CartasDePorteControlDescargas
                 Where item.IdCartasDePorteControlDescarga = id).FirstOrDefault()

        db.CartasDePorteControlDescargas.Remove(q)

        db.SaveChanges()


        'Return q

        '    return Json(q, JsonRequestBehavior.AllowGet);

        Dim TheSerializer As JavaScriptSerializer = New JavaScriptSerializer()


        Dim TheJson As String = TheSerializer.Serialize(q)

        Return TheJson


    End Function


    <WebMethod()>
    Public Function DestinoBatchUpdate(o As Object) As String
        'Public Function DestinoBatchUpdate(o As ProntoMVC.Data.Models.CartasDePorteControlDescarga) As String
        ' (o As ProntoMVC.Data.Models.CartasDePorteControlDescarga)




        'http://stackoverflow.com/questions/6292510/passing-data-from-jqgrid-to-webmethod/6296601#6296601
        'http://stackoverflow.com/questions/6292510/passing-data-from-jqgrid-to-webmethod/6296601#6296601
        'http://stackoverflow.com/questions/6292510/passing-data-from-jqgrid-to-webmethod/6296601#6296601
        'http://stackoverflow.com/questions/6292510/passing-data-from-jqgrid-to-webmethod/6296601#6296601

        Dim SC As String

        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar(scLocal())
            'SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If

        Dim db As DemoProntoEntities = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))

        Dim id As Integer = o("IdCartasDePorteControlDescarga")

        Dim usuario = Membership.GetUser()
        Dim dt As System.Data.DataTable = EntidadManager.ExecDinamico(SC, "Empleados_TX_UsuarioNT '" + usuario.UserName + "'")
        Dim idUsuario As Integer = Convert.ToInt32(dt.Rows(0)(0))
        Dim puntovent As Integer = EmpleadoManager.GetItem(SC, idUsuario).PuntoVentaAsociado


        Try



            If (id > 0) Then

                Dim EntidadOriginal = db.CartasDePorteControlDescargas.Where(Function(p) p.IdCartasDePorteControlDescarga = id).SingleOrDefault()
                Dim EntidadEntry = db.Entry(EntidadOriginal)

                EntidadOriginal.Fecha = o("Fecha")
                EntidadOriginal.IdDestino = CInt(o("IdWilliamsDestino"))
                EntidadOriginal.TotalDescargaDia = CInt(o("TotalDescargaDia"))
                EntidadOriginal.IdPuntoVenta = puntovent ' CInt(o("IdPuntoVenta"))

                EntidadEntry.CurrentValues.SetValues(EntidadOriginal)

                db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified

            Else
                Dim x As New CartasDePorteControlDescarga
                x.Fecha = o("Fecha")
                x.IdDestino = CInt(o("IdWilliamsDestino"))
                x.TotalDescargaDia = CInt(o("TotalDescargaDia"))
                x.IdPuntoVenta = puntovent ' CInt(o("IdPuntoVenta"))

                db.CartasDePorteControlDescargas.Add(x)
            End If

            db.SaveChanges()


        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        'TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();
        'return Json(new { Success = 1, IdCotizacion = Cotizacion.IdCotizacion, ex = "" });

        '}
        'catch (Exception ex)
        '{
        '    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
        '    Response.TrySkipIisCustomErrors = true;

        '    List<string> errors = new List<string>();
        '    errors.Add(ex.Message);
        '    return Json(errors);
        '}




    End Function










    Class bbbb
        Public IdWilliamsDestino As Integer
        Public Descripcion As String

    End Class

    <WebMethod()>
    Public Function DestinosPorPuntoVenta(term As String, puntoventa As Integer, SC As String) As String 'As List(Of bbbb) 'As String()

        'Pronto.ERP.Bll.CartaPorteManagerAux()


        'SC = SC.Replace(vbNewLine, "\n")
        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar("Data Source=serversql3;Initial catalog=Williams;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If

        'ErrHandler2.WriteError("AcopiosPorCliente " & NombreCliente & " - " & Encriptar(SC))



        Try
            Dim db As New LinqCartasPorteDataContext(Encriptar(SC))





            Dim q = (From i In db.WilliamsDestinos
                     Where (i.PuntoVenta = puntoventa Or i.PuntoVenta Is Nothing) And i.Descripcion.Contains(term)
                     Select New bbbb With {.IdWilliamsDestino = i.IdWilliamsDestino, .Descripcion = i.Descripcion}).ToList()

            ' instantiate a serializer
            Dim TheSerializer = New System.Web.Script.Serialization.JavaScriptSerializer()
            Dim TheJson = TheSerializer.Serialize(q)
            Return TheJson

        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString)

        End Try


        'Return New String() {"asdas", "ddd"}



    End Function

End Class
