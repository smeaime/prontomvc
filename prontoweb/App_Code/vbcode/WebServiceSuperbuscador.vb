Imports System
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Collections.Generic
Imports Pronto.ERP.BO
Imports Pronto.ERP.Bll
Imports System.IO
Imports Microsoft.VisualBasic

Imports System.Text.RegularExpressions

Imports System.Data
Imports System.Data.SqlClient


<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
<System.Web.Script.Services.ScriptService()> _
Public Class WebServiceSuperbuscador
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function GetCompletionList(ByVal prefixText As String, ByVal count As Integer, ByVal contextKey As String) As String()

        If (count = 0) Then
            count = 10
        End If

        Dim rnd As New Random()

        Dim items As New List(Of String)

        Dim cod As String = ""


        Dim sc As String '= "Data Source=NANOPC\SQLEXPRESS;Initial catalog=Equimac;User ID=sa; Password=ok;Connect Timeout=45"
        sc = contextKey

        Try
            If prefixText.Length > 0 Then
                If prefixText(0) = ">" Then
                    'mostrar lista de comando de la "consola pronto" (supongo que tests)

                End If
            End If
        Catch ex As Exception

        End Try




        Dim lista As Data.DataTable
        Try

            deberia ir con timeout
            lista = EntidadManager.GetStoreProcedure(sc, enumSPs.wBusqueda, prefixText)
            'lista = EntidadManager.ExecDinamico(sc, "wBusqueda " & prefixText, 15)


        Catch ex As Exception
            'ojito si anda lento!!!!!!!
            'ojito si anda lento!!!!!!!
            'ojito si anda lento!!!!!!!
            'ojito si anda lento!!!!!!!
            'Stored procedure slow when called from web, fast from Management Studio // Parameter Sniffing
            '            http://stackoverflow.com/questions/6585417/stored-procedure-slow-when-called-from-web-fast-from-management-studio
            'http://stackoverflow.com/questions/834124/ado-net-calling-t-sql-stored-procedure-causes-a-sqltimeoutexception/839055#839055
            'http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
            'http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
            'http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
            'http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
            'http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
            'http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
            'http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why

            ErrHandler2.WriteError("prefixText " & prefixText)
            ErrHandler2.WriteError("En efecto, hay que usar WITH RECOMPILE en este store")
            ErrHandler2.WriteError("Timeout? Parameter sniffing? o usar WITH RECOMPILE para que el store no use la cache en este caso del Buscador que se usa con tantos registros.   ejecutar DBCC DROPCLEANBUFFERS y  DBCC FREEPROCCACHE ????? agregar OPTION RECOMPILE en el codigo TSQL? ")
            ErrHandler2.WriteError(ex)

            CartaDePorteManager.MandarMailDeError("El superbuscador dio timeout.  cadena " + prefixText + "     " + ex.ToString)


            'EntidadManager.ExecDinamico(sc, "DBCC DROPCLEANBUFFERS")
            'EntidadManager.ExecDinamico(sc, "DBCC FREEPROCCACHE")


            'In essence, it sounds like SQL Server may have a corrupt cached execution plan. 
            'You() 're hitting the bad plan with your web server, but SSMS lands on a different plan since 
            'there is a different setting on the ARITHABORT flag (which would otherwise have no impact on your particular query/stored proc).

            'See ADO.NET calling T-SQL Stored Procedure causes a SqlTimeoutException for another example, 
            '    with a more complete explanation and resolution

            'Warning This answer is only an extremely short term fix and completely unnecessarily brutal. 
            '        DBCC DROPCLEANBUFFERS will drop most of the data pages from cache and have no effect. DBCC FREEPROCCACHE will flush the entire procedure cache all just to remove one problematic plan! There is no guarantee that the problem won't reoccur at some future stage. The issue is parameter sniffing. Please see this article for fuller explanation.

        End Try





        For Each i As Data.DataRow In lista.Rows
            'items.Add(articulo.Descripcion) 
            With i
                cod = .Item("ID") & "^" & .Item("Numero")
                'Dim texto As String = "<b>" & iisNull(.Item("Numero"), "") & "</b> <br />" & vbCrLf & iisNull(.Item("Tipo"), "")

                'en el explorer no están saliendo los renglones adicionales!!!!!!!
                Dim texto As String = Left(iisNull(.Item("Numero"), "").ToString, 30).PadRight(40, "") & " " & iisNull(.Item("Tipo"), ".").ToString.Replace(" ", ".").PadRight(50, ".") & " " & iisNull(.Item("item1"), "").ToString.PadRight(40)
                'texto = texto.Replace(Chr(10) + Chr(13), "<br />")

                'texto = HighlightText(texto, prefixText)

                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(texto, cod))
            End With
        Next

        'If lista.Rows.Count = 0 Then
        ' items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem("No se encontraron resultados", -1))
        ' End If




        Dim dt As New Data.DataTable
        'http://social.msdn.microsoft.com/forums/en-US/csharpgeneral/thread/67dacbbf-6358-4de7-b398-293e89cab6b1/
        Dim s As String = File.ReadAllText((DirApp() & "\SuperbuscadorTags.xml"))
        s = " <tables><row><table_name>ticket</table_name><record_key>68</record_key></row><row>" & _
               "<table_name>sales</table_name><record_key>3001</record_key></row></tables>"
        Dim theReader As StringReader = New StringReader(s)
        'dt.ReadXml(theReader)

        dt.Columns.Add("tagDesc", System.Type.GetType("System.String"))
        dt.Columns.Add("tagSug", System.Type.GetType("System.String"))

        'dt.Rows.Add("RM Listado", "~/ProntoWeb/Requerimientos.aspx")
        'dt.Rows.Add("RM Nuevo       CTRL-F6", "~/ProntoWeb/Requerimiento.aspx?Id=-1")
        'dt.Rows.Add("Requerimientos", "~/ProntoWeb/Requerimientos.aspx")

        dt.Rows.Add("Comprobantes de Proveedor", "~/ProntoWeb/ComprobantesPrv.aspx")
        dt.Rows.Add("CP Nuevo Comprobante de Proveedor", "~/ProntoWeb/ComprobantePrv.aspx?Id=-1")

        'dt.Rows.Add("OP Ordenes de Pago", "~/ProntoWeb/OrdenesPago.aspx")
        'dt.Rows.Add("Nueva OP Ordenes de Pago", "~/ProntoWeb/OrdenPago.aspx?Id=-1")


        'dt.Rows.Add("Circuito de Ventas - Tests", "~/ProntoWeb/CircuitoDeVentas.aspx")
        'dt.Rows.Add("Circuito de Compras - Tests", "~/ProntoWeb/CircuitoDeCompras.aspx")



        dt.Rows.Add("Listado de usuarios", "~/Admin/ListadoUsuarios.aspx")
        dt.Rows.Add("Agregar usuarios", "~/Admin/AgregarUsuarios.aspx")
        dt.Rows.Add("Asignar empresa a usuario", "~/Admin/AsignarEmpresa.aspx")
        dt.Rows.Add("Empleados", "~/ProntoWeb/Empleados.aspx")
        dt.Rows.Add("Configuracion y parametros", "~/ProntoWeb/Configuracion.aspx")
        dt.Rows.Add("Articulos", "~/ProntoWeb/Articulos.aspx")
        dt.Rows.Add("Choferes", "~/ProntoWeb/Choferes.aspx?tipo=Confirmados")
        dt.Rows.Add("Cotizaciones", "~/ProntoWeb/Cotizaciones.aspx")
        dt.Rows.Add("Localidades", "~/ProntoWeb/Localidades.aspx?tipo=Confirmados")
        dt.Rows.Add("Transportistas", "~/ProntoWeb/Transportistas.aspx?tipo=Confirmados")
        dt.Rows.Add("Calidades", "~/ProntoWeb/Calidades.aspx?tipo=Confirmados")

        dt.Rows.Add("Diccionario de equivalencias", "~/ProntoWeb/DiccionarioEquivalencias.aspx?tipo=Confirmados")
        dt.Rows.Add("Humedades", "~/ProntoWeb/CDPHumedades.aspx?tipo=Confirmados")
        dt.Rows.Add("Destinos", "~/ProntoWeb/CDPDestinos.aspx?tipo=Confirmados")
        dt.Rows.Add("Clientes", "~/ProntoWeb/Clientes.aspx")
        dt.Rows.Add("Vendedores", "~/ProntoWeb/Vendedores.aspx?tipo=Confirmados")

        dt.Rows.Add("FAC Facturas", "~/ProntoWeb/FACTURAS.aspx?tipo=AConfirmarEnObra")
        dt.Rows.Add("NC Notas De Credito", "~/ProntoWeb/NotaDeCreditos.aspx?tipo=Confirmados")
        'dt.Rows.Add("ND Notas De Debito", "~/ProntoWeb/NotaDeCreditos.aspx?tipo=Confirmados")
        dt.Rows.Add("ListasPrecios", "~/ProntoWeb/ListasPrecios.aspx?tipo=Confirmados")

        dt.Rows.Add("Nueva CDP", "~/ProntoWeb/CartaDePorte.aspx?Id=-1")
        dt.Rows.Add("Cartas de Porte", "~/ProntoWeb/CartasDePortes.aspx?tipo=Todas")
        'dt.Rows.Add("sss", "~/ProntoWeb/CartasDePortes.aspx?tipo=Posición")
        'dt.Rows.Add("sss", "~/ProntoWeb/CartasDePortes.aspx?tipo=Descargas")


        dt.Rows.Add("sss", "~/ProntoWeb/CartasDePorteImportador.aspx?Id=-1")
        dt.Rows.Add("sss", "~/ProntoWeb/CDPMailing.aspx")
        dt.Rows.Add("sss", "~/ProntoWeb/CartaDePorteInformesConReportViewer.aspx?tipo=Confirmados")


        dt.Rows.Add("sss", "~/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados")

        dt.Rows.Add("sss", "~/ProntoWeb/CartaDePorteInformes.aspx?tipo=Confirmados")

        dt.Rows.Add("Movimientos CDP", "~/ProntoWeb/CDPStockMovimientos.aspx")

        'dt.Rows.Add("sss", "~/ProntoWeb/Resolucion1361.aspx")
        'dt.Rows.Add("sss", "~/ProntoWeb/ImportarInformacionImpositiva.aspx")


        'dt.Rows.Add("Proveedores", "~/ProntoWeb/Proveedores.aspx")

        'dt.Rows.Add("sss", "~/ProntoWeb/frmConsultaRMsPendientesDeAsignacion.aspx")
        'dt.Rows.Add("sss", "~/ProntoWeb/ComprobantesPrv.aspx")
        'dt.Rows.Add("sss", "~/ProntoWeb/Presupuesto.aspx?Id=-1")
        'dt.Rows.Add("sss", "~/ProntoWeb/Presupuestos.aspx?tipo=AConfirmarEnObra")
        'dt.Rows.Add("sss", "~/ProntoWeb/FondoFijos.aspx?tipo=AConfirmarEnObra")


        'dt.Rows.Add("sss", "~/ProntoWeb/Comparativa.aspx?Id=-1")
        'dt.Rows.Add("sss", "~/ProntoWeb/Comparativas.aspx?tipo=AConfirmarEnObra")
        'dt.Rows.Add("sss", "~/ProntoWeb/Comparativas.aspx?tipo=Confirmados")

        'dt.Rows.Add("sss", "~/ProntoWeb/Pedido.aspx?Id=-1")
        'dt.Rows.Add("sss", "~/ProntoWeb/Pedidos.aspx?tipo=AConfirmarEnObra")


        'dt.Rows.Add("sss", "~/ProntoWeb/CircuitoDeVentas.aspx")
        'dt.Rows.Add("OC Ordenes de compra", "~/ProntoWeb/OrdenDeCompras.aspx")
        'dt.Rows.Add("Remitos", "~/ProntoWeb/Remitos.aspx")
        'dt.Rows.Add("sss", "~/ProntoWeb/Facturas.aspx")
        'dt.Rows.Add("sss", "~/ProntoWeb/Recibos.aspx")
        'dt.Rows.Add("sss", "~/ProntoWeb/NotaDeCreditos.aspx")
        'dt.Rows.Add("sss", "~/ProntoWeb/NotaDeDebitos.aspx")
        'dt.Rows.Add("CC Deudores cuentas corrientes", "~/ProntoWeb/CtaCteDeudores.aspx")


        'dt.Rows.Add("Asientos", "~/ProntoWeb/Asientos.aspx")
        'dt.Rows.Add("Nuevo Asiento", "~/ProntoWeb/Asiento.aspx?Id=-1")


        For Each dr As Data.DataRow In dt.Rows
            If InStr(dr.Item("tagDesc").ToString.ToUpper, prefixText.ToUpper) > 0 Then

                Dim desc As String = dr.Item("tagDesc").ToString
                cod = dr.Item("tagSug")  '& "^" & proveedor.Item("Nombre")

                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(desc, cod))
                'items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(HighlightText(desc, prefixText), cod))

            End If
        Next


        If lista.Rows.Count = 0 Then
            'no me conviene poner lo de "No se encontraron resultados" si uso FirstSelectedRow y permito altas al vuelo
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem("No se encontraron resultados", -1))
        Else
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem("Ver más resultados para " & prefixText, -1))
        End If


        dt.Rows.Add("Ver más resultados", "")


        Return items.ToArray()
    End Function

    Function HighlightText(ByVal InputTxt As String, ByVal substr As String) As String
        ' This function is called whenever text is displayed in the FirstName and LastName 
        ' fields from our database. If we're not searching then just return the original 
        ' input, this speeds things up a bit


        ' Otherwise create a new regular expression and evaluate the FirstName and 
        ' LastName fields against our search string.
        Dim ResultStr As Regex
        ResultStr = New Regex(substr.Replace(" ", "|"), RegexOptions.IgnoreCase)
        Return ResultStr.Replace(InputTxt, New MatchEvaluator(AddressOf ReplaceWords))

    End Function

    Public Function ReplaceWords(ByVal m As Match) As String
        ' This match evaluator returns the found string and adds it a CSS class I defined 
        ' as 'highlight'
        Return "<span class=highlight>" + m.ToString + "</span>"
    End Function















    ' <SoapDocumentMethod( _
    '"http://www.contoso.com/DocumentLiteral", _
    'RequestNamespace:="http://www.contoso.com", _
    'ResponseNamespace:="http://www.contoso.com", _
    'Use:=SoapBindingUse.Literal)>

    <WebMethod(Description:="Returns Northwind Customers", EnableSession:=False)> _
    Public Function GetCartas(partedelnumero As String, desde As String, hasta As String, quecontenga As String, iddestino As String, idproducto As String) As List(Of CartaDePorteManager.CartasConCalada)

        Dim SC As String
        ' SC = Encriptar("Data Source=Mariano-PC\MSSQLSERVER2;Initial catalog=Williams;User ID=sa; Password=ok;Connect Timeout=8")

        'http://localhost:48391/ProntoWeb/WebServiceCartas.asmx?op=GetCartas&partedelnumero=&desde=1/1/2013&hasta=1/1/2014&quecontenga=&iddestino=-1&idproducto=-1



        If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
            SC = EncriptarParaCSharp(scLocal)  'EncriptarParaCSharp("Data Source=MARIANO-PC\MSSQLSERVER2;Initial Catalog=Williams;Uid=sa; PWD=ok;")
        Else
            SC = EncriptarParaCSharp(scWilliamsRelease) '    "Data Source=osvm21;Initial catalog=Williams;User ID=sa; Password=Zeekei3quo;Connect Timeout=90")
        End If

        'Es el quecontenga2


        Dim q As List(Of CartaDePorteManager.CartasConCalada)

        If True Then

            q = CartaDePorteManager.CartasLINQlocalSimplificadoTipadoConCalada3(SC, _
                       "", "", "", 1, 10, _
                  CartaDePorteManager.enumCDPestado.Todas, quecontenga, -1, -1, _
                   -1, -1, _
                   -1, IIf(Val(idproducto) > 0, Val(idproducto), -1), -1, IIf(Val(iddestino) > 0, Val(iddestino), -1), CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas", _
                    Convert.ToDateTime(iisValidSqlDate(desde, #1/1/1753#)), _
                    Convert.ToDateTime(iisValidSqlDate(hasta, #1/1/2100#)), _
                    -1, , , , , , partedelnumero).ToList()

        Else

            q = CartaDePorteManager.CartasLINQlocalSimplificadoTipadoConCalada3(SC, _
                   "", "", "", 1, 10, _
              CartaDePorteManager.enumCDPestado.Todas, "", -1, -1, _
               -1, -1, _
               -1, -1, -1, Val(iddestino), CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas", _
                #1/1/2013#, _
                #1/1/2104#, _
                -1, , , , , , "").ToList()

        End If

        'Dim dt = LogicaFacturacion.ToDataTableNull(q)
        'dt.TableName = "lalalal"



        ' Dim xmlElements = new System.Xml.Linq.XElement("Branches", Branches.Select(i => new XElement("branch", i)));

        '  dt.WriteXml()
        '  Return dt.WriteXml()
        'Return dt
        Return q
        'Return xmlElements
    End Function



    <WebMethod(Description:="Devuelve un xml con una lista de cartas", EnableSession:=False)> _
    Public Function GetCartasSinParametros() As List(Of CartaDePorteManager.CartasConCalada)

        Dim SC As String
        ' SC = Encriptar("Data Source=Mariano-PC\MSSQLSERVER2;Initial catalog=Williams;User ID=sa; Password=ok;Connect Timeout=8")





        If System.Diagnostics.Debugger.IsAttached() Or ConfigurationManager.AppSettings("UrlDominio").Contains("localhost") Then
            SC = EncriptarParaCSharp(scLocal)  'EncriptarParaCSharp("Data Source=MARIANO-PC\MSSQLSERVER2;Initial Catalog=Williams;Uid=sa; PWD=ok;")
        Else
            SC = EncriptarParaCSharp(scWilliamsRelease) '    "Data Source=osvm21;Initial catalog=Williams;User ID=sa; Password=Zeekei3quo;Connect Timeout=90")
        End If

        'Es el quecontenga2

        '
        Dim q As List(Of CartaDePorteManager.CartasConCalada) = CartaDePorteManager.CartasLINQlocalSimplificadoTipadoConCalada3(SC, _
                   "", "", "", 1, 10, _
              CartaDePorteManager.enumCDPestado.Todas, "", -1, -1, _
               -1, -1, _
               -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas", _
                #1/1/2013#, _
                #1/1/2104#, _
                -1, , , , , , "").ToList()


        'Dim dt = LogicaFacturacion.ToDataTableNull(q)
        'dt.TableName = "lalalal"



        ' Dim xmlElements = new System.Xml.Linq.XElement("Branches", Branches.Select(i => new XElement("branch", i)));

        '  dt.WriteXml()
        '  Return dt.WriteXml()
        'Return dt
        Return q
        'Return xmlElements
    End Function


    ' http://kiranpatils.wordpress.com/2008/09/23/generic-list-to-xml-using-linq/
    Private Function GenerateListToXMLWithNameSpace(employeeList As List(Of CartaDePorteManager.CartasConCalada)) As XDocument

        Dim employeeNameSpace As XNamespace = "http://www.abc.org/employees/0.9"
        Dim xmlDocument = New XDocument(New XDeclaration("1.0", "UTF-8", "yes"), _
              New XElement(employeeNameSpace + "Employees", _
              From employee In employeeList _
              Select New XElement(employeeNameSpace + "Employee", _
              New XElement(employeeNameSpace + "EmployeeID", employee.IdCartaDePorte), _
                  New XElement(employeeNameSpace + "EmployeeName", employee.IdCartaDePorte), _
                   New XElement(employeeNameSpace + "EmployeeAddress", employee.IdCartaDePorte))))

        Return xmlDocument
    End Function




    <WebMethod(Description:="Returns Northwind Customers", EnableSession:=False)> _
    Public Function GetCustomers() As DataSet

        Dim SC As String
        ' SC = Encriptar("Data Source=Mariano-PC\MSSQLSERVER2;Initial catalog=Williams;User ID=sa; Password=ok;Connect Timeout=8")

        If System.Diagnostics.Debugger.IsAttached() Then
            SC = EncriptarParaCSharp(scLocal)  'EncriptarParaCSharp("Data Source=MARIANO-PC\MSSQLSERVER2;Initial Catalog=Williams;Uid=sa; PWD=ok;")
        Else
            SC = EncriptarParaCSharp(scWilliamsRelease) '    "Data Source=osvm21;Initial catalog=Williams;User ID=sa; Password=Zeekei3quo;Connect Timeout=90")
        End If


        Dim dt As DataTable
        dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(SC, _
                "", "", "", 1, 10, _
              CartaDePorteManager.enumCDPestado.Todas, "", -1, -1, _
               -1, -1, _
               -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "", #1/1/1753#, #1/1/2100#, -1)



        'Return dt.WriteXml(

        Return dt.DataSet
    End Function


    Public connection As SqlConnection = New SqlConnection("Data Source=(local);Integrated Security=SSPI;Initial Catalog=Northwind")


    <WebMethod(Description:="Updates Northwind Customers", EnableSession:=False)> _
    Public Function UpdateCustomers(custDS As DataSet) As DataSet
        Dim adapter As SqlDataAdapter = New SqlDataAdapter()

        adapter.InsertCommand = New SqlCommand( _
          "INSERT INTO Customers (CustomerID, CompanyName) " & _
          "Values(@CustomerID, @CompanyName)", connection)
        adapter.InsertCommand.Parameters.Add( _
          "@CustomerID", SqlDbType.NChar, 5, "CustomerID")
        adapter.InsertCommand.Parameters.Add( _
          "@CompanyName", SqlDbType.NChar, 15, "CompanyName")

        adapter.UpdateCommand = New SqlCommand( _
          "UPDATE Customers Set CustomerID = @CustomerID, " & _
          "CompanyName = @CompanyName WHERE CustomerID = " & _
          "@OldCustomerID", connection)
        adapter.UpdateCommand.Parameters.Add( _
          "@CustomerID", SqlDbType.NChar, 5, "CustomerID")
        adapter.UpdateCommand.Parameters.Add( _
          "@CompanyName", SqlDbType.NChar, 15, "CompanyName")

        Dim parameter As SqlParameter = _
          adapter.UpdateCommand.Parameters.Add( _
          "@OldCustomerID", SqlDbType.NChar, 5, "CustomerID")
        parameter.SourceVersion = DataRowVersion.Original

        adapter.DeleteCommand = New SqlCommand( _
          "DELETE FROM Customers WHERE CustomerID = @CustomerID", _
          connection)
        parameter = adapter.DeleteCommand.Parameters.Add( _
          "@CustomerID", SqlDbType.NChar, 5, "CustomerID")
        parameter.SourceVersion = DataRowVersion.Original

        adapter.Update(custDS, "Customers")

        Return custDS
    End Function






    <WebMethod()> _
    Public Function Fertilizantes(NombreCliente As String, SC As String) 'As List(Of aaa) 'As String()

        'Pronto.ERP.Bll.CartaPorteManagerAux()


        'SC = SC.Replace(vbNewLine, "\n")
        If Not Diagnostics.Debugger.IsAttached Then
            SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")

        End If

        'ErrHandler2.WriteError("AcopiosPorCliente " & NombreCliente & " - " & Encriptar(SC))



        Try
            Dim idcliente = BuscaIdClientePrecisoConCUIT(NombreCliente, SC)

            Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))

            Dim a = ProntoMVC.Data.FuncionesGenericasCSharp.Fertilizantes_DynamicGridData(db, "NumeroPedido", "desc", 0, 50, False, "")

            'Return a

        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString)

        End Try


        'Return New String() {"asdas", "ddd"}



    End Function

End Class
