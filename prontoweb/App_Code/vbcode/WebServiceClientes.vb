﻿Imports System
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Collections.Generic
Imports Pronto.ERP.BO
Imports Pronto.ERP.Bll

Imports System.Web.Script.Serialization
Imports System.Web.Script.Services

Imports CartaDePorteManager

<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<System.Web.Script.Services.ScriptService()> _
Public Class WebServiceClientes
    Inherits System.Web.Services.WebService

    <WebMethod()> _
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


    <WebMethod()> _
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


    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)> _
    <WebMethod()> _
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

        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        Dim q = (From item In db.WilliamsDestinos
                   Where item.Descripcion.ToLower().Contains(term.ToLower())
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






    <WebMethod()> _
    Public Function CotizacionWilliamsDestinoBatchUpdate(o As Object) ' (o As ProntoMVC.Data.Models.CartasDePorteControlDescarga)

        'http://stackoverflow.com/questions/6292510/passing-data-from-jqgrid-to-webmethod/6296601#6296601
        'http://stackoverflow.com/questions/6292510/passing-data-from-jqgrid-to-webmethod/6296601#6296601
        'http://stackoverflow.com/questions/6292510/passing-data-from-jqgrid-to-webmethod/6296601#6296601
        'http://stackoverflow.com/questions/6292510/passing-data-from-jqgrid-to-webmethod/6296601#6296601

        If (o.IdCartasDePorteControlDescarga > 0) Then

        End If



        'if (!PuedeEditar(enumNodos.Cotizaciones)) throw new Exception("No tenés permisos");

        'Try
        '{
        '    If (ModelState.IsValid) Then
        '    {
        '        If (Cotizacion.IdCotizacion > 0) Then
        '        {
        '            var EntidadOriginal = db.Cotizaciones.Where(p => p.IdCotizacion == Cotizacion.IdCotizacion).SingleOrDefault();
        '            var EntidadEntry = db.Entry(EntidadOriginal);
        '            EntidadEntry.CurrentValues.SetValues(Cotizacion);

        '            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
        '        }
        '        Else
        '        {
        '            db.Cotizaciones.Add(Cotizacion);
        '        }

        '        db.SaveChanges();

        '        TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

        '        return Json(new { Success = 1, IdCotizacion = Cotizacion.IdCotizacion, ex = "" });
        '    }
        '    else
        '    {
        '        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
        '        Response.TrySkipIisCustomErrors = true;

        '        JsonResponse res = new JsonResponse();
        '        res.Status = Status.Error;
        '        res.Errors = GetModelStateErrorsAsString(this.ModelState);
        '        res.Message = "El registro tiene datos invalidos";

        '        return Json(res);
        '    }
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

    <WebMethod()> _
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





            Dim q = (From i In db.WilliamsDestinos _
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
