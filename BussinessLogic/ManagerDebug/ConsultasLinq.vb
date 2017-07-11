
Option Infer On


Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Configuration
Imports System.Linq   '"namespace or type specified in ... doesn't contain any " -Sorry Linq is only available in .net 3.5 http://forums.asp.net/t/1332780.aspx  Advanced Compile Options
'Imports System.Data.Linq 'lo necesita el CompileQuery?
Imports ADODB.DataTypeEnum
Imports System.Diagnostics
Imports System.Data
Imports Microsoft.Reporting.WebForms
Imports System.IO

Imports System.Collections.Generic
Imports System.Data.SqlClient


Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager


'Imports System.Data.Objects.SqlClient
Imports System.Data.Entity.SqlServer


Imports ProntoMVC.Data.Models

'Namespace Pronto.ERP.Bll

<DataObjectAttribute()>
<Transaction(TransactionOption.Required)>
Public Class ConsultasLinq
    Inherits ServicedComponent

    'Shared dt As DataTable









    Public Shared Function totpormessucursal(ByVal SC As String,
          ByVal ColumnaParaFiltrar As String,
          ByVal TextoParaFiltrar As String,
          ByVal sortExpression As String,
          ByVal startRowIndex As Long,
          ByVal maximumRows As Long,
          ByVal estado As CartaDePorteManager.enumCDPestado,
          ByVal QueContenga As String,
          ByVal idVendedor As Integer,
          ByVal idCorredor As Integer,
          ByVal idDestinatario As Integer,
          ByVal idIntermediario As Integer,
          ByVal idRemComercial As Integer,
          ByVal idArticulo As Integer,
          ByVal idProcedencia As Integer,
          ByVal idDestino As Integer,
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR,
          ByVal ModoExportacion As String,
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime,
          ByVal puntoventa As Integer,
          Optional ByRef sTituloFiltroUsado As String = "",
          Optional ByVal optDivisionSyngenta As String = "Ambas",
          Optional ByVal bTraerDuplicados As Boolean = False,
          Optional ByVal Contrato As String = "") As Object


        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        'db.CommandTimeout = 5 * 60 ' 3 Mins

        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))



        'If False Then

        '    ''Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        '    ''Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
        '    ''Dim fechadesde2 As Date

        '    ' ''la fecha del periodo anterior a comparar
        '    ''If cmbPeriodo.Text = "Este mes" Or cmbPeriodo.Text = "Mes anterior" Then
        '    ''    fechadesde2 = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, fechadesde))
        '    ''Else
        '    ''    fechadesde2 = fechadesde - (fechahasta - fechadesde)
        '    ''End If
        '    ''////////////////////////////////////////////////////
        '    ''////////////////////////////////////////////////////


        '    'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        '    Dim pv1, pv2, pv3, pv4 As Decimal

        '    Dim fechamin = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, Today))


        '    pv1 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(1) _
        '            Where cdp.FechaArribo > fechamin _
        '            Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

        '    pv2 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(2) _
        '            Where cdp.FechaArribo > fechamin _
        '            Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

        '    pv3 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(3) _
        '            Where cdp.FechaArribo > fechamin _
        '            Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

        '    pv4 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(4) _
        '            Where cdp.FechaArribo > fechamin _
        '            Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

        '    '//////////////////////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////


        '    'Que pasa con los clientes nuevos o que no tienen tarifa? -Usar un promedio.

        '    Dim lista As New Generic.List(Of tipoloco)
        '    Dim i As tipoloco


        '    Dim q2 = (From l In lista Select Monto = l.monto, Mes = l.mes, Ano = l.ano, Orden = l.orden, Serie = l.serie).ToList 'ojo que es CaseSensitive!!!!
        '    'Mes
        '    'ano tarifa netofinal precio


        'End If









        'Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        'Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)

        Dim q = (From cdp In db.CartasDePortes
                 Join cli In db.Clientes On cli.IdCliente Equals cdp.Vendedor
                 From art In db.Articulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty
                 From clitit In db.Clientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty
                 Where
                     cdp.Vendedor > 0 _
                     And cli.RazonSocial IsNot Nothing _
                     And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
                     And (cdp.Anulada <> "SI") _
                     And ((ModoExportacion = "Ambos") Or (ModoExportacion = "Entregas" And If(cdp.Exporta, "NO") = "NO") Or (ModoExportacion = "Export" And If(cdp.Exporta, "NO") = "SI")) _
                     And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
                     And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                     And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                     And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                     And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                     And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                     And (idDestino = -1 Or cdp.Destino = idDestino) _
                     And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa)
                 Group cdp By Ano = cdp.FechaDescarga.Value.Year,
                             Producto = art.Descripcion,
                             MesNumero = cdp.FechaDescarga.Value.Month,
                             Sucursal = cdp.PuntoVenta
                     Into g = Group
                 Select New With {
                          .Sucursal = SqlFunctions.StringConvert(Sucursal),
                     .Ano = Ano,
                     .Mes = MesNumero,
                     .Producto = Producto,
                     .CantCartas = g.Count,
                 .NetoPto = g.Sum(Function(i) i.NetoFinal) / 1000,
                     .Merma = g.Sum(Function(i) (i.Merma + i.HumedadDesnormalizada)) / 1000,
                     .NetoFinal = g.Sum(Function(i) i.NetoProc) / 1000,
                     .MesNumero = MesNumero,
                     .Importe = g.Sum(Function(i) CDec(CDec(If(i.TarifaFacturada, 0)) * CDec(If(i.NetoPto, 0)) / 1000))
                 }).ToList



        '.Importe= g.Sum(Function(i) CDec(IIf(False Or i.TarifaFacturada > 0, _
        '                                 CDec(i.TarifaFacturada) * CDec(i.NetoPto) / 1000, _
        '                                 CDec(If(db.wTarifaWilliamsEstimada(i.Vendedor, i.IdArticulo, i.Destino, 0), 0)) * CDec(i.NetoPto) / 1000 _
        '                                ))) _





        ' http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9809
        '        * Si la carta de Porte esta facturada -> Tomar en cuenta la tarifa que se facturó
        '* Si la carta de Porte no está facturada -> Tal como en el informe \"Proyección de facturación\", chequear a que cliente le correspondería en el automático facturarle la carta de porte y tomar la tarifa que le corresponde.
        '* Si de lo anterior surge una tarifa en cero o un cliente que no tiene cargada la tarifa, promediar las tarifas del mes anterior para el mismo Cereal y mismo Destino. (intentar con esto acercarse lo más posible a lo real y buscar que no queden cartas de porte en 0)


        For Each i In q
            i.Sucursal = PuntoVentaWilliams.NombrePuntoVentaWilliams2(Val(i.Sucursal))

            'If i.Importe = 0 Then
            '    i.Importe=db.wTarifaWilliams(

            'End If


            'Select Case i.Sucursal
            '    Case "1"
            '        i.Sucursal = "Buenos Aires"
            '    Case 2
            '    Case 3
            '    Case 4

            '    Case Else
            'End Select
        Next

        Return q

    End Function

    Private Class tipoloco
        Public monto
        Public mes
        Public ano
        Public orden
        Public serie
    End Class








    Const IdWilliams = 12454
    Const IdCorredorBLD = 43



    Public Shared Function EsExporta(exporta As String, corredor As Long, entregador As Long) As Boolean
        'http://bdlconsultores.sytes.net/Consultas/Admin/VerConsultas1.php?recordid=13216
        'En el informe de liquidación de subcontratistas, las cartas de porte de corredor BLD y un entregador distinto de Williams deben tomarse como de exportación


        Return (exporta = "SI" Or (corredor = IdCorredorBLD And (entregador <> IdWilliams Or entregador <= 0)))


    End Function



    Public Shared Function destinosSeparados(SC) As List(Of Integer)

        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        Dim s As String = iisNull(ParametroManager.TraerValorParametro2(SC, "DestinosDeCartaPorteApartadosEnLiquidacionSubcontr"), "")

        Dim lista() As String = Split(s, "|")

        Dim lll = db.WilliamsDestinos.Where(Function(x) lista.Contains(x.Descripcion)).Select(Function(y) y.IdWilliamsDestino).ToList

        Return lll
        'Dim corredor As String = EntidadManager.GetItem(SC, "Vendedores", idCorredor).Item("Nombre")

        'For Each s In a
        '    If Trim(s).ToUpper = "" Then Continue For
        '    If (InStr(corredor.ToUpper, Trim(s).ToUpper) > 0) Then
        '        Return IdClienteEquivalenteDelIdVendedor(idCorredor, SC) 'oCDP.Corredor
        '    End If
        'Next

    End Function


    Class asas
        Public IdCartaDePorte As Integer?
        Public NumeroCartaDePorte As Long?
        Public FechaDescarga As Date?
        Public agrupVagon As String
        Public NetoFinal As Decimal?
        Public Subcontr1 As Integer?
        Public Subcontr2 As Integer?
        Public ExcluirDeSubcontratistas As String
        Public SubnumeroDeFacturacion As Integer?
        Public VendedorDesc As String
        Public CuentaOrden1Desc As String
        Public CuentaOrden2Desc As String
        Public CorredorDesc As String
        Public EntregadorDesc As String
        Public ProcedenciaDesc As String
        Public DestinoDesc As String
        Public Subcontr1Desc As String
        Public Subcontr2Desc As String
        Public Exporta As String
        Public Corredor As Integer?
        Public IdClienteEntregador As Integer
        Public tarif1 As Decimal?
        Public tarif2 As Decimal?
    End Class


    Public Shared Function LiquidacionSubcontratistas(ByVal SC As String,
          ByVal ColumnaParaFiltrar As String,
          ByVal TextoParaFiltrar As String,
          ByVal sortExpression As String,
          ByVal startRowIndex As Long,
          ByVal maximumRows As Long,
          ByVal estado As CartaDePorteManager.enumCDPestado,
          ByVal QueContenga As String,
          ByVal idVendedor As Integer,
          ByVal idCorredor As Integer,
          ByVal idDestinatario As Integer,
          ByVal idIntermediario As Integer,
          ByVal idRemComercial As Integer,
          ByVal idArticulo As Integer,
          ByVal idProcedencia As Integer,
          ByVal idDestino As Integer,
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR,
          ByVal ModoExportacion As String,
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime,
          ByVal puntoventa As Integer, idSubcontr As Integer,
          ByRef sTituloFiltroUsado As String
          ) As Object



        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))



        Dim ms As String = ""
        'el filtro tiene que incluir duplicados (el True despues de syngenta)
        Try
            'LogicaFacturacion.CorrectorParcheSubnumeroFacturacion(SC, ms)
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        Dim destinosapartados As List(Of Integer) = destinosSeparados(SC)


        'tiene que incluir las copias???? quiero decir con esto... con qué informe puedo comparar la cantidad de cartas que me tira este?
        'tiene que incluir las copias???? quiero decir con esto... con qué informe puedo comparar la cantidad de cartas que me tira este?
        'tiene que incluir las copias???? quiero decir con esto... con qué informe puedo comparar la cantidad de cartas que me tira este?
        'tiene que incluir las copias???? quiero decir con esto... con qué informe puedo comparar la cantidad de cartas que me tira este?
        'tiene que incluir las copias???? quiero decir con esto... con qué informe puedo comparar la cantidad de cartas que me tira este?
        'tiene que incluir las copias???? quiero decir con esto... con qué informe puedo comparar la cantidad de cartas que me tira este?

        'supongo que hay quilombo en el join del detalle de precios        'http://stackoverflow.com/questions/492683/how-to-limit-a-linq-left-outer-join-to-one-row
        'no puedo usae el take(1) en sql2000!!!! -y si agrupo esos registros con un Average?  .Average(Function(i) i.PrecioCaladaLocal).



        'https://entityframework.codeplex.com/workitem/705
        'https://entityframework.codeplex.com/workitem/705
        'https://entityframework.codeplex.com/workitem/705
        'https://entityframework.codeplex.com/workitem/705
        '        To diagnose this run: 

        '        sp_dbcmptlevel() '<your_database_name>' 

        'If it reports a value below 90 then running 

        '            sp_dbcmptlevel() '<your_database_name>', 90 

        'updates the compatibility level of the database and fixes the problem.


        Dim aaa = From xz In db.fSQL_GetDataTableFiltradoYPaginado(Nothing, Nothing, Nothing, Nothing, idVendedor,
                                                idCorredor, idDestinatario, idIntermediario, idRemComercial,
                                                idArticulo, idProcedencia, idDestino, AplicarANDuORalFiltro, ModoExportacion,
                                                fechadesde, fechahasta, puntoventa,
                                                Nothing, True, Nothing, Nothing, Nothing,
                                                Nothing, Nothing, Nothing, Nothing)
                  Select xz

        'aaa.ToList()



        '        http://stackoverflow.com/questions/1462174/use-inline-table-valued-function-in-linq-compiled-query
        'http://stackoverflow.com/questions/1462174/use-inline-table-valued-function-in-linq-compiled-query
        'http://stackoverflow.com/questions/1462174/use-inline-table-valued-function-in-linq-compiled-query
        'http://stackoverflow.com/questions/1462174/use-inline-table-valued-function-in-linq-compiled-query
        'http://stackoverflow.com/questions/1462174/use-inline-table-valued-function-in-linq-compiled-query
        'http://stackoverflow.com/questions/1462174/use-inline-table-valued-function-in-linq-compiled-query
        'http://stackoverflow.com/questions/1462174/use-inline-table-valued-function-in-linq-compiled-query
        'http://weblogs.asp.net/zeeshanhirani/table-valued-functions-in-linq-to-sql
        '        http://weblogs.asp.net/zeeshanhirani/table-valued-functions-in-linq-to-sql
        '        https://msdn.microsoft.com/en-us/data/hh859577.aspx
        '        https://msdn.microsoft.com/en-us/data/hh859577.aspx



        'And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
        '(If(cdp.FechaDescarga, cdp.FechaArribo) >= fechadesde And If(cdp.FechaDescarga, cdp.FechaArribo) <= fechahasta) _
        '      And (cdp.Anulada <> "SI") _
        '      And ((ModoExportacion = "Ambos") Or (ModoExportacion = "Entregas" _
        '              And If(cdp.Exporta, "NO") = "NO") Or (ModoExportacion = "Export" And If(cdp.Exporta, "NO") = "SI") _
        '          ) _
        '    And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _

        'And If(cdp.SubnumeroDeFacturacion, 0) <= 0


        db.Database.CommandTimeout = 300

        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)

        'http://stackoverflow.com/questions/26761827/adding-a-query-hint-when-calling-table-valued-function
        '        Are there other callers of fDE_myquery outside of your specific usage? And how often does this get called? The issue is not that your SELECT * FROM dbo.fDE_myquery(); is getting a sub-optimal plan, it is that one or more queries inside of fDE_myquery is getting a sub-optimal plan. Hence, you could just add the OPTION(RECOMPILE) to one or more queries inside that TVF.

        'If this TVF is called a lot then this would have a negative impact on performance. That is why I asked about other uses of this TVF: if this is the only, or by far the main, use of this TVF, then it might be well worth it if the bad plans are being picked up frequently.

        'But if there are several other callers of this TVF that are not experiencing an issue, then putting the RECOMPILE in the TVF might not be the way to go. Although, in that case you could create a wrapper TVF that encapsulates the SELECT * FROM dbo.fDE_myquery() OPTION (RECOMPILE);. This would appear to be a more flexible solution :). It would have to be a Multistatment TVF instead of the typically better Inline TVF as I just tried it and the Inline TVF does not seem to appreciate the OPTION clause, but the Multistatement TVF was fine with it.


        db.Database.ExecuteSqlCommand("EXEC sp_recompile 'dbo.fSQL_GetDataTableFiltradoYPaginado';")

        Dim qq = (From cdp In aaa
                  From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = If(cdp.Destino, 0)).DefaultIfEmpty
                  From clisub1 In db.Clientes.Where(Function(i) i.IdCliente = If(cdp.Subcontr1, dest.Subcontratista1)).DefaultIfEmpty
                  From clisub2 In db.Clientes.Where(Function(i) i.IdCliente = If(cdp.Subcontr2, dest.Subcontratista2)).DefaultIfEmpty
                  From l1 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub1.IdListaPrecios).DefaultIfEmpty
                  From pd1 In db.ListasPreciosDetalles _
                          .Where(Function(i) i.IdListaPrecios = l1.IdListaPrecios And (i.IdArticulo = cdp.IdArticulo) And (i.IdDestinoDeCartaDePorte Is Nothing Or i.IdDestinoDeCartaDePorte = cdp.Destino) _
                              And (i.IdCliente Is Nothing Or i.IdCliente = cdp.Vendedor Or i.IdCliente = cdp.Entregador Or i.IdCliente = cdp.CuentaOrden1 Or i.IdCliente = cdp.CuentaOrden2)) _
                          .OrderByDescending(Function(i) i.IdCliente).Take(1).DefaultIfEmpty()
                  From l2 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub2.IdListaPrecios).DefaultIfEmpty
                  From pd2 In db.ListasPreciosDetalles _
                          .Where(Function(i) i.IdListaPrecios = l2.IdListaPrecios And (i.IdArticulo = cdp.IdArticulo) And (i.IdDestinoDeCartaDePorte Is Nothing Or i.IdDestinoDeCartaDePorte = cdp.Destino) _
                                 And (i.IdCliente Is Nothing Or i.IdCliente = cdp.Vendedor Or i.IdCliente = cdp.Entregador Or i.IdCliente = cdp.CuentaOrden1 Or i.IdCliente = cdp.CuentaOrden2)) _
                          .OrderByDescending(Function(i) i.IdCliente).Take(1).DefaultIfEmpty()
                  Where 1 = 1 _
                        And (idSubcontr = -1 Or If(cdp.Subcontr1, dest.Subcontratista1) = idSubcontr Or If(cdp.Subcontr2, dest.Subcontratista2) = idSubcontr) _
                        And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa)
                  Select New asas() With {
                      .NumeroCartaDePorte = cdp.NumeroCartaDePorte,
                      .IdCartaDePorte = cdp.IdCartaDePorte,
                      .FechaDescarga = cdp.FechaDescarga,
                      .NetoFinal = cdp.NetoFinal,
                      .Subcontr1 = If(cdp.Subcontr1, dest.Subcontratista1),
                      .Subcontr2 = If(cdp.Subcontr2, dest.Subcontratista2),
                      .agrupVagon = If(destinosapartados.Contains(cdp.Destino), If(cdp.SubnumeroVagon = 0, "Camiones", "Vagones"), ""),
                      .ExcluirDeSubcontratistas = cdp.ExcluirDeSubcontratistas,
                      .SubnumeroDeFacturacion = cdp.SubnumeroDeFacturacion,
                      .VendedorDesc = cdp.TitularDesc,
                      .CuentaOrden1Desc = cdp.IntermediarioDesc,
                      .CuentaOrden2Desc = cdp.RComercialDesc,
                      .CorredorDesc = cdp.CorredorDesc,
                      .EntregadorDesc = cdp.EntregadorDesc,
                      .ProcedenciaDesc = cdp.ProcedenciaDesc,
                      .DestinoDesc = dest.Descripcion,
                      .Subcontr1Desc = clisub1.RazonSocial,
                      .Subcontr2Desc = clisub2.RazonSocial,
                      .tarif1 = CDec(If(If(
                      (cdp.Exporta = "SI") _
                          , If(cdp.SubnumeroVagon <= 0 Or Not destinosapartados.Contains(cdp.Destino),
                                  pd1.PrecioCaladaExportacion, pd1.PrecioVagonesCaladaExportacion) _
                          , If(cdp.SubnumeroVagon <= 0 Or Not destinosapartados.Contains(cdp.Destino),
                                  pd1.PrecioCaladaLocal, pd1.PrecioVagonesCalada)
                          ), 0)),
                      .tarif2 = CDec(If(If(
                          (cdp.Exporta = "SI") _
                          , If(cdp.SubnumeroVagon <= 0 Or Not destinosapartados.Contains(cdp.Destino),
                                  If(pd2.PrecioDescargaExportacion = 0, pd2.PrecioCaladaExportacion, pd2.PrecioDescargaExportacion),
                                  If(pd2.PrecioVagonesBalanzaExportacion = 0, pd2.PrecioVagonesCaladaExportacion, pd2.PrecioVagonesBalanzaExportacion)
                                  ) _
                          , If(cdp.SubnumeroVagon <= 0 Or Not destinosapartados.Contains(cdp.Destino),
                                  If(pd2.PrecioDescargaLocal = 0, pd2.PrecioCaladaLocal, pd2.PrecioDescargaLocal),
                                  If(pd2.PrecioVagonesBalanza = 0, pd2.PrecioVagonesCalada, pd2.PrecioVagonesBalanza)
                                  )
                                  ), 0)),
                      .Exporta = cdp.Exporta,
                     .Corredor = cdp.Corredor,
                      .IdClienteEntregador = If(cdp.IdClienteEntregador, 0)}).ToList
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)
        'si te tarda mucho, puede ser por el parameter sniffing!!!!!! (en especial si en la consola de sql ejecuta rapido)






        'Dim a = qq.FirstOrDefault


        'http://stackoverflow.com/questions/5568860/linq-to-sql-join-issues-with-firstordefault




        'Dim qq2 = qq.ToList
        Dim aa = qq
        Dim filtr As Integer
        If False Then
            'que pasa con las cartas que tienen varios subnumerodefacturacion y el 0 anulado? y no se puede tirar un listado viendo el subnumerodefac?


            aa = qq.Where(Function(i) False Or (If(i.ExcluirDeSubcontratistas, "NO") = "NO" And If(i.SubnumeroDeFacturacion, 0) <= 0))
            filtr = qq.Count - aa.Count
        Else

        End If





        If ModoExportacion = "Buques" Then

            Dim q7 = LogicaFacturacion.ListaEmbarquesQueryable(SC, fechadesde, fechahasta, -1, 0, -1, db)

            'From destino In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Puerto).DefaultIfEmpty
            'Join dest In db.WilliamsDestinos On dest.IdWilliamsDestino Equals cdp.Puerto
            'Join art In db.Articulos On art.IdArticulo Equals cdp.IdArticulo

            Dim ooo = (From cdp As ProntoMVC.Data.Models.CartasPorteMovimiento In q7
                       From art In db.Articulos.Where(Function(i) i.IdArticulo = If(cdp.IdArticulo, 0)).DefaultIfEmpty
                       From destino In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = If(cdp.Puerto, 0)).DefaultIfEmpty
                       From clisub1 In db.Clientes.Where(Function(i) i.IdCliente = If(destino.Subcontratista1, 0)).DefaultIfEmpty
                       From clisub2 In db.Clientes.Where(Function(i) i.IdCliente = If(destino.Subcontratista2, 0)).DefaultIfEmpty
                       From l1 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub1.IdListaPrecios).DefaultIfEmpty
                       From pd1 In db.ListasPreciosDetalles _
                        .Where(Function(i) i.IdListaPrecios = l1.IdListaPrecios And (i.IdArticulo = cdp.IdArticulo) _
                            And (i.IdCliente Is Nothing Or i.IdCliente = cdp.IdExportadorOrigen)) _
                        .OrderByDescending(Function(i) i.IdCliente).Take(1).DefaultIfEmpty()
                       From l2 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub2.IdListaPrecios).DefaultIfEmpty
                       From pd2 In db.ListasPreciosDetalles _
                        .Where(Function(i) i.IdListaPrecios = l2.IdListaPrecios And (i.IdArticulo = cdp.IdArticulo) _
                               And (i.IdCliente Is Nothing Or i.IdCliente = cdp.IdExportadorOrigen)) _
                        .OrderByDescending(Function(i) i.IdCliente).Take(1).DefaultIfEmpty()
                       Select New asas With {
                    .NumeroCartaDePorte = cdp.NumeroCDPMovimiento,
                    .IdCartaDePorte = cdp.IdCartaDePorte,
                    .FechaDescarga = cdp.FechaIngreso,
                    .NetoFinal = cdp.Cantidad,
                    .Subcontr1 = destino.Subcontratista1,
                    .Subcontr2 = destino.Subcontratista2,
                    .agrupVagon = "Buques",
                    .ExcluirDeSubcontratistas = "NO",
                    .SubnumeroDeFacturacion = 0,
                    .VendedorDesc = cdp.IdExportadorOrigen,
                    .CuentaOrden1Desc = cdp.IdExportadorOrigen,
                    .CuentaOrden2Desc = "",
                    .CorredorDesc = "",
                    .EntregadorDesc = cdp.IdExportadorOrigen,
                    .ProcedenciaDesc = cdp.IdExportadorOrigen,
                    .DestinoDesc = destino.Descripcion,
                    .Subcontr1Desc = clisub1.RazonSocial,
                    .Subcontr2Desc = clisub2.RazonSocial,
                    .tarif1 = If(pd1 Is Nothing, 0, pd1.PrecioBuquesCalada),
                    .tarif2 = If(pd2 Is Nothing, 0, pd2.PrecioBuquesCalada),
                    .Exporta = "SI",
                    .Corredor = cdp.IdExportadorOrigen,
                    .IdClienteEntregador = If(cdp.IdExportadorOrigen, 0)}).ToList


            'qq = ooo
            qq = qq.Union(ooo).ToList

        End If







        Dim q = From i In qq
                Group By
                    i.IdCartaDePorte,
                    i.NumeroCartaDePorte,
                    i.FechaDescarga,
                    i.agrupVagon,
                    i.NetoFinal,
                    i.Subcontr1,
                    i.Subcontr2,
                    i.ExcluirDeSubcontratistas,
                    i.SubnumeroDeFacturacion,
                    i.VendedorDesc,
                    i.CuentaOrden1Desc,
                    i.CuentaOrden2Desc,
                    i.CorredorDesc,
                    i.EntregadorDesc,
                    i.ProcedenciaDesc,
                    i.DestinoDesc,
                    i.Subcontr1Desc,
                    i.Subcontr2Desc,
                    i.Exporta,
                    i.Corredor,
                    i.IdClienteEntregador
                Into Group
                Select New With {
                    IdCartaDePorte,
                    NumeroCartaDePorte,
                    FechaDescarga,
                    agrupVagon,
                    NetoFinal,
                    Subcontr1,
                    Subcontr2,
                    ExcluirDeSubcontratistas,
                    SubnumeroDeFacturacion,
                    VendedorDesc,
                    CuentaOrden1Desc,
                    CuentaOrden2Desc,
                    CorredorDesc,
                    EntregadorDesc,
                    ProcedenciaDesc,
                    DestinoDesc,
                    Subcontr1Desc,
                    Subcontr2Desc,
                    Exporta,
                    .tarif1 = Group.Max(Function(x) x.tarif1),
                    .tarif2 = Group.Max(Function(x) x.tarif2),
                    Corredor,
                    IdClienteEntregador
                     }
        'IdListaPreciosDetalle1, IdListaPreciosDetalle2


        'q = q.Where(Function(x) x.NumeroCartaDePorte = 557836815).Distinct()



        If Debugger.IsAttached Or True Then
            Try

                q.ToList()

                Dim a = (From x In q Order By x.FechaDescarga, x.IdCartaDePorte Select x.NumeroCartaDePorte, x.IdCartaDePorte, x.tarif1, x.tarif2).ToList
                Dim b = From x In a Select x.NumeroCartaDePorte.ToString & " " & x.IdCartaDePorte.ToString & " " & x.tarif1 & " " & x.tarif2 ' & " " & x.IdListaPreciosDetalle1 & " " & x.IdListaPreciosDetalle2


                ErrHandler2.WriteError(vbCrLf & Join(b.ToArray, vbCrLf))
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

        End If










        'uso Group by, porque el distinct en vb.net es medio loco! (no anda igual que en c#)

        Dim q4 As List(Of infLiqui) = (From cdp In q
                                        Where (idSubcontr = -1 Or cdp.Subcontr1 = idSubcontr)
                                       Group By
                                        cdp.agrupVagon,
                                        cdp.DestinoDesc,
                                        cdp.Exporta,
                                        cdp.Subcontr1Desc,
                                        cdp.tarif1,
                                        cdp.NumeroCartaDePorte,
                                        cdp.NetoFinal
                                       Into Group
                                           Select New infLiqui With {
                                           .agrupVagon = agrupVagon,
                                           .DestinoDesc = DestinoDesc & " Calada" & If(
                                               (Exporta = "SI") _
                                                      , " - Export.", " - Entrega"),
                                           .SubcontrDesc = Subcontr1Desc,
                                           .NetoPto = NetoFinal,
                                           .Tarifa = If(tarif1, 0),
                                           .Comision = NetoFinal * If(tarif1, 0) / 1000,
                                            .numerocarta = NumeroCartaDePorte
                                        }).ToList.Distinct.ToList()


        Dim q5 As List(Of infLiqui) = (From cdp In q
                                       Where (idSubcontr = -1 Or cdp.Subcontr2 = idSubcontr)
                                        Group By
                                        cdp.agrupVagon,
                                        cdp.DestinoDesc,
                                        cdp.Exporta,
                                        cdp.Subcontr2Desc,
                                        cdp.tarif2,
                                        cdp.NumeroCartaDePorte,
                                        cdp.NetoFinal
                                       Into Group
                                       Select New infLiqui With {
                                           .agrupVagon = agrupVagon,
                                           .DestinoDesc = DestinoDesc & " Balanza" & If(
                                                         (Exporta = "SI") _
                                                       , " - Export.", " - Entrega"),
                                           .SubcontrDesc = Subcontr2Desc,
                                           .NetoPto = NetoFinal,
                                           .Tarifa = If(tarif2, 0),
                                           .Comision = NetoFinal * If(tarif2, 0) / 1000,
                                        .numerocarta = NumeroCartaDePorte
                                   }).ToList.Distinct.ToList()


        Dim q6 As New List(Of infLiqui) '= q4.Union(q5)
        q6.AddRange(q4)
        q6.AddRange(q5)



        Dim q3 = From i In q6
                 Group i By agrupVagon = i.agrupVagon, DestinoDesc = i.DestinoDesc, SubcontrDesc = i.SubcontrDesc, Tarifa = i.Tarifa Into g = Group
                 Select agrupVagon = agrupVagon, DestinoDesc = DestinoDesc, SubcontrDesc = SubcontrDesc, Tarifa = Tarifa,
                 NetoPto = g.Sum(Function(i) i.NetoPto), Comision = g.Sum(Function(i) i.Comision), CantCartas = g.Count,
                 numeros = Left(vbCrLf + vbCrLf + vbCrLf + "[comienzo  " + String.Join(vbCrLf, g.Select(Function(i) i.numerocarta.ToString).ToList) + "  fin]", 30000)
        'le meto esos vbCrLf para que no se vean los primeros renglones y así no me modifique automaticamente el ancho de la columna "oculta"

        ErrHandler2.WriteError("     Excluidas por nofacturarasubcontratistas o duplicadas: " & filtr)


        Return q3.ToList

    End Function




    Class infLiqui
        Public agrupVagon As String
        Public DestinoDesc As String
        Public SubcontrDesc As String
        Public NetoPto As Decimal
        Public Tarifa As Decimal
        Public Comision As Decimal
        Public numerocarta As Long
    End Class




    Public Shared Function totpormes(ByVal SC As String,
          ByVal ColumnaParaFiltrar As String,
          ByVal TextoParaFiltrar As String,
          ByVal sortExpression As String,
          ByVal startRowIndex As Long,
          ByVal maximumRows As Long,
          ByVal estado As CartaDePorteManager.enumCDPestado,
          ByVal QueContenga As String,
          ByVal idVendedor As Integer,
          ByVal idCorredor As Integer,
          ByVal idDestinatario As Integer,
          ByVal idIntermediario As Integer,
          ByVal idRemComercial As Integer,
          ByVal idArticulo As Integer,
          ByVal idProcedencia As Integer,
          ByVal idDestino As Integer,
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR,
          ByVal ModoExportacion As String,
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime,
          ByVal puntoventa As Integer,
          Optional ByRef sTituloFiltroUsado As String = "",
          Optional ByVal optDivisionSyngenta As String = "Ambas",
          Optional ByVal bTraerDuplicados As Boolean = False,
          Optional ByVal Contrato As String = "") As Object



        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        'db.CommandTimeout = 5 * 60 ' 3 Mins





        Dim q = (From cdp In db.CartasDePortes
                 Join cli In db.Clientes On cli.IdCliente Equals cdp.Vendedor
                 From art In db.Articulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty
                 From clitit In db.Clientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty
                 From clidest In db.Clientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty
                 From cliint In db.Clientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty
                 From clircom In db.Clientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty
                 From corr In db.Vendedores.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty
                 From cal In db.Calidade_EF.Where(Function(i) i.IdCalidad = cdp.Calidad).DefaultIfEmpty
                 From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty
                 From estab In db.CDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty
                 From tr In db.Transportistas.Where(Function(i) i.IdTransportista = cdp.IdTransportista).DefaultIfEmpty
                 From loc In db.Localidades.Where(Function(i) i.IdLocalidad = cdp.Procedencia).DefaultIfEmpty
                 From chf In db.Choferes.Where(Function(i) i.IdChofer = cdp.IdChofer).DefaultIfEmpty
                 From emp In db.Empleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty
                 Where
                     cdp.Vendedor > 0 _
                     And cli.RazonSocial IsNot Nothing _
                     And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
                     And (cdp.Anulada <> "SI") _
                     And ((ModoExportacion = "Ambos") Or
                         (ModoExportacion = "Entregas" And If(cdp.Exporta, "NO") = "NO") Or
                         (ModoExportacion = "Export" And If(cdp.Exporta, "NO") = "SI")) _
                     And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
                     And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                     And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                     And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                     And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                     And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                     And (idDestino = -1 Or cdp.Destino = idDestino) _
                     And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa)
                 Group cdp By Ano = cdp.FechaDescarga.Value.Year,
                             MesNumero = cdp.FechaDescarga.Value.Month,
                             Producto = art.Descripcion Into g = Group
                 Select New With {
                     .Ano = Ano,
                     .Mes = MesNumero,
                     .Producto = Producto,
                     .CantCartas = g.Count,
                     .NetoPto = g.Sum(Function(i) i.NetoFinal) / 1000,
                     .Merma = g.Sum(Function(i) (i.Merma + i.HumedadDesnormalizada)) / 1000,
                     .NetoFinal = g.Sum(Function(i) i.NetoProc) / 1000,
                     .MesNumero = MesNumero
                 }).ToList




        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////

        Dim aaa As Decimal? = 0


        Dim q2 = LogicaFacturacion.ListaEmbarquesQueryable(SC, fechadesde, fechahasta).ToList
        Dim a = (From i In q2
                 Join art In db.Articulos On art.IdArticulo Equals i.IdArticulo
                 Group i By Ano = i.FechaIngreso.Value.Year,
                         MesNumero = i.FechaIngreso.Value.Month,
                         Producto = art.Descripcion
                 Into g = Group
                 Select New With {
                 .Ano = Ano,
                 .Mes = MesNumero,
                 .Producto = Producto,
                 .CantCartas = g.Count,
                 .NetoPto = g.Sum(Function(i) i.Cantidad) / 1000,
                 .Merma = aaa,
                 .NetoFinal = g.Sum(Function(i) i.Cantidad) / 1000,
                 .MesNumero = MesNumero
                 }).ToList

        Dim x = q.Union(a).ToList()

        'http://connect.microsoft.com/VisualStudio/feedback/details/590217/editor-very-slow-when-code-contains-linq-queries

        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////





        Return x



    End Function



    Public Shared Function totpormesmodo(ByVal SC As String,
          ByVal ColumnaParaFiltrar As String,
          ByVal TextoParaFiltrar As String,
          ByVal sortExpression As String,
          ByVal startRowIndex As Long,
          ByVal maximumRows As Long,
          ByVal estado As CartaDePorteManager.enumCDPestado,
          ByVal QueContenga As String,
          ByVal idVendedor As Integer,
          ByVal idCorredor As Integer,
          ByVal idDestinatario As Integer,
          ByVal idIntermediario As Integer,
          ByVal idRemComercial As Integer,
          ByVal idArticulo As Integer,
          ByVal idProcedencia As Integer,
          ByVal idDestino As Integer,
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR,
          ByVal ModoExportacion As String,
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime,
          ByVal puntoventa As Integer,
          Optional ByRef sTituloFiltroUsado As String = "",
          Optional ByVal optDivisionSyngenta As String = "Ambas",
          Optional ByVal bTraerDuplicados As Boolean = False,
          Optional ByVal Contrato As String = "") As Object



        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        'db.CommandTimeout = 5 * 60 ' 3 Mins


        'If False Then

        '    ''Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        '    ''Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
        '    ''Dim fechadesde2 As Date

        '    ' ''la fecha del periodo anterior a comparar
        '    ''If cmbPeriodo.Text = "Este mes" Or cmbPeriodo.Text = "Mes anterior" Then
        '    ''    fechadesde2 = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, fechadesde))
        '    ''Else
        '    ''    fechadesde2 = fechadesde - (fechahasta - fechadesde)
        '    ''End If
        '    ''////////////////////////////////////////////////////
        '    ''////////////////////////////////////////////////////


        '    'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        '    Dim pv1, pv2, pv3, pv4 As Decimal

        '    Dim fechamin = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, Today))


        '    pv1 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(1) _
        '            Where cdp.FechaArribo > fechamin _
        '            Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

        '    pv2 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(2) _
        '            Where cdp.FechaArribo > fechamin _
        '            Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

        '    pv3 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(3) _
        '            Where cdp.FechaArribo > fechamin _
        '            Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

        '    pv4 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(4) _
        '            Where cdp.FechaArribo > fechamin _
        '            Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

        '    '//////////////////////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////


        '    'Que pasa con los clientes nuevos o que no tienen tarifa? -Usar un promedio.

        '    Dim lista As New Generic.List(Of tipoloco)
        '    Dim i As tipoloco


        '    Dim q2 = (From l In lista Select Monto = l.monto, Mes = l.mes, Ano = l.ano, Orden = l.orden, Serie = l.serie).ToList 'ojo que es CaseSensitive!!!!
        '    'Mes
        '    'ano tarifa netofinal precio


        'End If



        'ListaEmbarquesQueryable()





        'Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        'Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)

        Dim q = (From cdp In db.CartasDePortes
                 Join cli In db.Clientes On cli.IdCliente Equals cdp.Vendedor
                 From art In db.Articulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty
                 From clitit In db.Clientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty
                 Where
                     cdp.Vendedor > 0 _
                     And cli.RazonSocial IsNot Nothing _
                     And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
                     And (cdp.Anulada <> "SI") _
                     And ((ModoExportacion = "Ambos") Or (ModoExportacion = "Entregas" And If(cdp.Exporta, "NO") = "NO") Or (ModoExportacion = "Export" And If(cdp.Exporta, "NO") = "SI")) _
                     And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
                     And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                     And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                     And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                     And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                     And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                     And (idDestino = -1 Or cdp.Destino = idDestino) _
                     And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa)
                 Group cdp By Ano = cdp.FechaDescarga.Value.Year,
                             Producto = art.Descripcion,
                             MesNumero = cdp.FechaDescarga.Value.Month,
                             Sucursal = cdp.Exporta
                     Into g = Group
                 Select New With {
                     .Sucursal = Sucursal,
                     .Ano = Ano,
                     .Mes = MesNumero,
                     .Producto = Producto,
                     .CantCartas = g.Count,
                     .NetoPto = g.Sum(Function(i) i.NetoFinal) / 1000,
                     .Merma = g.Sum(Function(i) (i.Merma + i.HumedadDesnormalizada)) / 1000,
                     .NetoFinal = g.Sum(Function(i) i.NetoProc) / 1000,
                     .MesNumero = MesNumero,
                      .Importe = g.Sum(Function(i) CDec(CDec(If(i.TarifaFacturada, 0)) * CDec(If(i.NetoPto, 0)) / 1000))
                 }).ToList

        'CDec(IIf(False Or i.TarifaFacturada > 0, _
        '                                             CDec(i.TarifaFacturada) * CDec(i.NetoPto) / 1000, _
        '                                             CDec(If(db.wTarifaWilliamsEstimada(i.Vendedor, i.IdArticulo, i.Destino, 0), 0)) * CDec(i.NetoPto) / 1000 _
        '                                            ))) _

        ' http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9809
        '        * Si la carta de Porte esta facturada -> Tomar en cuenta la tarifa que se facturó
        '* Si la carta de Porte no está facturada -> Tal como en el informe \"Proyección de facturación\", chequear a que cliente le correspondería en el automático facturarle la carta de porte y tomar la tarifa que le corresponde.
        '* Si de lo anterior surge una tarifa en cero o un cliente que no tiene cargada la tarifa, promediar las tarifas del mes anterior para el mismo Cereal y mismo Destino. (intentar con esto acercarse lo más posible a lo real y buscar que no queden cartas de porte en 0)



        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////

        '        http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=12512
        'acá cómo agregar la opcion "buques"? agrego un check? y solo para estos informes?


        Dim x = q.ToList()

        If ModoExportacion = "Buques" Then

            Dim q3 = LogicaFacturacion.ListaEmbarquesQueryable(SC, fechadesde, fechahasta).ToList
            Dim a = (From i In q3
                     Join art In db.Articulos On art.IdArticulo Equals i.IdArticulo
                     Group i By Ano = i.FechaIngreso.Value.Year,
                             MesNumero = i.FechaIngreso.Value.Month,
                             Producto = art.Descripcion
                     Into g = Group
                     Select New With {
                     .Sucursal = "Buque",
                     .Ano = Ano,
                     .Mes = MesNumero,
                     .Producto = Producto,
                     .CantCartas = g.Count,
                     .NetoPto = g.Sum(Function(i) i.Cantidad) / 1000,
                     .Merma = CDec(0),
                     .NetoFinal = g.Sum(Function(i) i.Cantidad) / 1000,
                     .MesNumero = MesNumero,
                      .Importe = CDec(0)
                     }).ToList
            x = x.Union(a).ToList()

        End If


        'http://connect.microsoft.com/VisualStudio/feedback/details/590217/editor-very-slow-when-code-contains-linq-queries

        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////


        For Each i In x
            i.Sucursal = IIf(i.Sucursal = "SI", "Exportación", "Entrega")
            ' i.Sucursal = CartaDePorteManager.NombrePuntoVentaWilliams(Val(i.Sucursal))

            'i.Importe = 0

            'Select Case i.Sucursal
            '    Case "1"
            '        i.Sucursal = "Buenos Aires"
            '    Case 2
            '    Case 3
            '    Case 4

            '    Case Else
            'End Select
        Next

        Return x



    End Function


    Public Shared Function totpormesmodoysucursal(ByVal SC As String,
          ByVal ColumnaParaFiltrar As String,
          ByVal TextoParaFiltrar As String,
          ByVal sortExpression As String,
          ByVal startRowIndex As Long,
          ByVal maximumRows As Long,
          ByVal estado As CartaDePorteManager.enumCDPestado,
          ByVal QueContenga As String,
          ByVal idVendedor As Integer,
          ByVal idCorredor As Integer,
          ByVal idDestinatario As Integer,
          ByVal idIntermediario As Integer,
          ByVal idRemComercial As Integer,
          ByVal idArticulo As Integer,
          ByVal idProcedencia As Integer,
          ByVal idDestino As Integer,
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR,
          ByVal ModoExportacion As String,
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime,
          ByVal puntoventa As Integer,
          Optional ByRef sTituloFiltroUsado As String = "",
          Optional ByVal optDivisionSyngenta As String = "Ambas",
          Optional ByVal bTraerDuplicados As Boolean = False,
          Optional ByVal Contrato As String = "") As Object





        'An Error Has Occurred! System.NotSupportedException: This function can only be invoked from LINQ to Entities. at System.Data.Entity.SqlServer.SqlFunctions.StringConvert(Nullable`1 number) at Read_VB$AnonymousType_98`10(ObjectMaterializer`1 ) at System.Data.Linq.SqlClient.ObjectReaderCompiler.ObjectReader`2.MoveNext() at System.Collections.Generic.List`1..ctor(IEnumerable`1 collection) at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source) at ConsultasLinq.totpormessucursal(String SC, String ColumnaParaFiltrar, String TextoParaFiltrar, String sortExpression, Int64 startRowIndex, Int64 maximumRows, enumCDPestado estado, String QueContenga, Int32 idVendedor, Int32 idCorredor, Int32 idDestinatario, Int32 idIntermediario, Int32 idRemComercial, Int32 idArticulo, Int32 idProcedencia, Int32 idDestino, FiltroANDOR AplicarANDuORalFiltro, String ModoExportacion, DateTime fechadesde, DateTime fechahasta, Int32 puntoventa, String& sTituloFiltroUsado, String optDiv


        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        'db.CommandTimeout = 5 * 60 ' 3 Mins
        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))




        'If False Then

        '    ''Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        '    ''Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
        '    ''Dim fechadesde2 As Date

        '    ' ''la fecha del periodo anterior a comparar
        '    ''If cmbPeriodo.Text = "Este mes" Or cmbPeriodo.Text = "Mes anterior" Then
        '    ''    fechadesde2 = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, fechadesde))
        '    ''Else
        '    ''    fechadesde2 = fechadesde - (fechahasta - fechadesde)
        '    ''End If
        '    ''////////////////////////////////////////////////////
        '    ''////////////////////////////////////////////////////


        '    'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        '    Dim pv1, pv2, pv3, pv4 As Decimal

        '    Dim fechamin = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, Today))


        '    pv1 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(1) _
        '            Where cdp.FechaArribo > fechamin _
        '            Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

        '    pv2 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(2) _
        '            Where cdp.FechaArribo > fechamin _
        '            Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

        '    pv3 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(3) _
        '            Where cdp.FechaArribo > fechamin _
        '            Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

        '    pv4 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(4) _
        '            Where cdp.FechaArribo > fechamin _
        '            Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

        '    '//////////////////////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////


        '    'Que pasa con los clientes nuevos o que no tienen tarifa? -Usar un promedio.

        '    Dim lista As New Generic.List(Of tipoloco)
        '    Dim i As tipoloco


        '    Dim q2 = (From l In lista Select Monto = l.monto, Mes = l.mes, Ano = l.ano, Orden = l.orden, Serie = l.serie).ToList 'ojo que es CaseSensitive!!!!
        '    'Mes
        '    'ano tarifa netofinal precio


        'End If





        Dim sSQL = "update cartasdeporte " &
            " set tarifafacturada=dbo.wTarifaWilliams (Vendedor,IdArticulo,Destino,  case when isnull(Exporta,'NO')='SI' then 1 else 0 end   ,0)" &
            " from cartasdeporte " &
            " where (idfacturaimputada=0 or idfacturaimputada=-1 or idfacturaimputada is null )" &
            " and isnull(Anulada,'')<>'SI'" &
            " and tarifafacturada=0"

        Try
            ExecDinamico(SC, sSQL) ', 300) si le pongo 300 me chifla que no está preparada la cadena de conexion para ese timeout

        Catch ex As Exception

            ErrHandler2.WriteError(ex)
            Try
                ExecDinamico(SC, sSQL)
                ', 300) si le pongo 300 me chifla que no está preparada la cadena de conexion para ese timeout



                'ah mira vos es este el que suele explotar por timeout

                '    ErrHandler2()
                '    mandamailerror()

            Catch ex2 As Exception
                ErrHandler2.WriteError(ex2)
                Throw
            End Try
        End Try





        'ListaEmbarquesQueryable



        'Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        'Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)

        Dim q = (From cdp In db.CartasDePortes
                 Join cli In db.Clientes On cli.IdCliente Equals cdp.Vendedor
                 From art In db.Articulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty
                 From clitit In db.Clientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty
                 Where
                     cdp.Vendedor > 0 _
                     And cli.RazonSocial IsNot Nothing _
                     And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
                     And (cdp.Anulada <> "SI") _
                     And ((ModoExportacion = "Ambos") Or (ModoExportacion = "Entregas" And If(cdp.Exporta, "NO") = "NO") Or (ModoExportacion = "Export" And If(cdp.Exporta, "NO") = "SI")) _
                     And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
                     And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                     And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                     And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                     And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                     And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                     And (idDestino = -1 Or cdp.Destino = idDestino) _
                     And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa)
                 Group cdp By Ano = cdp.FechaDescarga.Value.Year,
                             Producto = art.Descripcion,
                             MesNumero = cdp.FechaDescarga.Value.Month,
                             Modo = cdp.Exporta,
                             Sucursal = cdp.PuntoVenta
                         Into g = Group
                 Select New With {
                     .Sucursal = SqlFunctions.StringConvert(Sucursal),
                     .Modo = If(Modo = "SI", "Exportación", "Entrega").ToString,
                     .Ano = Ano,
                     .Mes = MesNumero,
                     .Producto = Producto,
                     .CantCartas = g.Count,
                     .NetoPto = g.Sum(Function(i) i.NetoFinal) / 1000,
                     .Merma = g.Sum(Function(i) (i.Merma + i.HumedadDesnormalizada)) / 1000,
                     .NetoFinal = g.Sum(Function(i) i.NetoProc) / 1000,
                     .MesNumero = MesNumero,
                     .Importe = g.Sum(Function(i) CDec(CDec(If(i.TarifaFacturada, 0)) * CDec(If(i.NetoPto, 0)) / 1000))
                 }).ToList


        '.Importe = g.Sum(Function(i) CDec(IIf(False Or i.TarifaFacturada > 0, _
        '                                            CDec(i.TarifaFacturada) * CDec(i.NetoPto) / 1000, _
        '                                            CDec(If(db.wTarifaWilliamsEstimada(i.Vendedor, i.IdArticulo, i.Destino, 0), 0)) * CDec(i.NetoPto) / 1000 _
        '                                           )))

        ' http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9809
        '        * Si la carta de Porte esta facturada -> Tomar en cuenta la tarifa que se facturó
        '* Si la carta de Porte no está facturada -> Tal como en el informe \"Proyección de facturación\", chequear a que cliente le correspondería en el automático facturarle la carta de porte y tomar la tarifa que le corresponde.
        '* Si de lo anterior surge una tarifa en cero o un cliente que no tiene cargada la tarifa, promediar las tarifas del mes anterior para el mismo Cereal y mismo Destino. (intentar con esto acercarse lo más posible a lo real y buscar que no queden cartas de porte en 0)

        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////

        Dim x = q.ToList()

        If ModoExportacion = "Buques" Then

            Dim q3 = LogicaFacturacion.ListaEmbarquesQueryable(SC, fechadesde, fechahasta).ToList
            Dim a = (From i In q3
                     Join art In db.Articulos On art.IdArticulo Equals i.IdArticulo
                     Group i By Ano = i.FechaIngreso.Value.Year,
                             MesNumero = i.FechaIngreso.Value.Month,
                             Producto = art.Descripcion,
                                Modo = "Buque",
                             Sucursal = i.IdStock
                     Into g = Group
                     Select New With {
                     .Sucursal = SqlFunctions.StringConvert(Sucursal),
                     .Modo = Modo,
                     .Ano = Ano,
                     .Mes = MesNumero,
                     .Producto = Producto,
                     .CantCartas = g.Count,
                     .NetoPto = g.Sum(Function(i) i.Cantidad) / 1000,
                     .Merma = CDec(0),
                     .NetoFinal = g.Sum(Function(i) i.Cantidad) / 1000,
                     .MesNumero = MesNumero,
                      .Importe = CDec(0)
                     }).ToList

            x = x.Union(a).ToList()

        End If


        'http://connect.microsoft.com/VisualStudio/feedback/details/590217/editor-very-slow-when-code-contains-linq-queries

        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////





        For Each i In x
            i.Sucursal = PuntoVentaWilliams.NombrePuntoVentaWilliams2(Val(i.Sucursal))

            'If i.Importe = 0 Then
            '    i.Importe=db.wTarifaWilliams(

            'End If


            'Select Case i.Sucursal
            '    Case "1"
            '        i.Sucursal = "Buenos Aires"
            '    Case 2
            '    Case 3
            '    Case 4

            '    Case Else
            'End Select
        Next



        Return x



    End Function




    Private Shared Function CartasLINQxxxx(ByVal SC As String,
        ByVal ColumnaParaFiltrar As String,
        ByVal TextoParaFiltrar As String,
        ByVal sortExpression As String,
        ByVal startRowIndex As Long,
        ByVal maximumRows As Long,
        ByVal estado As CartaDePorteManager.enumCDPestado,
        ByVal QueContenga As String,
        ByVal idVendedor As Integer,
        ByVal idCorredor As Integer,
        ByVal idDestinatario As Integer,
        ByVal idIntermediario As Integer,
        ByVal idRemComercial As Integer,
        ByVal idArticulo As Integer,
        ByVal idProcedencia As Integer,
        ByVal idDestino As Integer,
        ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR,
        ByVal ModoExportacion As String,
        ByVal fechadesde As DateTime, ByVal fechahasta As DateTime,
        ByVal puntoventa As Integer,
        Optional ByRef sTituloFiltroUsado As String = "",
        Optional ByVal optDivisionSyngenta As String = "Ambas",
        Optional ByVal bTraerDuplicados As Boolean = False,
        Optional ByVal Contrato As String = "") As IQueryable(Of CartasDePorte)

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

        Dim q = From cdp In db.CartasDePortes
                Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
        'From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
        'From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
        'From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
        'From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
        'From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
        'From cal In db.Calidades.Where(Function(i) i.IdCalidad = CInt(cdp.Calidad)).DefaultIfEmpty _
        'From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
        'From estab In db.linqCDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
        'From tr In db.Transportistas.Where(Function(i) i.IdTransportista = cdp.IdTransportista).DefaultIfEmpty _
        'From loc In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(cdp.Procedencia)).DefaultIfEmpty _
        'From chf In db.Choferes.Where(Function(i) i.IdChofer = cdp.IdChofer).DefaultIfEmpty _
        'From emp In db.linqEmpleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty _
        'Where _
        '    cdp.Vendedor > 0 _
        '    And cli.RazonSocial IsNot Nothing _
        '    And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
        '    And (cdp.Anulada <> "SI") _
        '    And (ModoExportacion <> "Local" Or cdp.Exporta <> "SI") _
        '    And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
        '    And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
        '    And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
        '    And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
        '    And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
        '    And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
        '    And (idDestino = -1 Or cdp.Destino = idDestino) _
        '    And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
        'Select New CartaDePorte With { _
        '    .Id = cdp.IdCartaDePorte, _
        '   .NumeroCartaDePorte = cdp.NumeroCartaDePorte, _
        '   .NumeroSubfijo = cdp.NumeroSubfijo, _
        '    .SubnumeroVagon = cdp.SubnumeroVagon, _
        '    .FechaArribo = cdp.FechaArribo, _
        '   .FechaModificacion = cdp.FechaModificacion, _
        '   .FechaDescarga = cdp.FechaDescarga _
        '    } Skip startRowIndex Take maximumRows




        Return q
    End Function



    Public Shared Function VolumenCarga(ByVal SC As String,
          ByVal ColumnaParaFiltrar As String,
          ByVal TextoParaFiltrar As String,
          ByVal sortExpression As String,
          ByVal startRowIndex As Long,
          ByVal maximumRows As Long,
          ByVal estado As CartaDePorteManager.enumCDPestado,
          ByVal QueContenga As String,
          ByVal idVendedor As Integer,
          ByVal idCorredor As Integer,
          ByVal idDestinatario As Integer,
          ByVal idIntermediario As Integer,
          ByVal idRemComercial As Integer,
          ByVal idArticulo As Integer,
          ByVal idProcedencia As Integer,
          ByVal idDestino As Integer,
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR,
          ByVal ModoExportacion As String,
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime,
          ByVal puntoventa As Integer,
          Optional ByRef sTituloFiltroUsado As String = "",
          Optional ByVal optDivisionSyngenta As String = "Ambas",
          Optional ByVal bTraerDuplicados As Boolean = False,
          Optional ByVal Contrato As String = "") As Object



        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))

        'Dim a=From l In db.Logs Where l.

        'Dim s = "select * from log    where  (IdComprobante=" & idcarta & " AND  Detalle='Tabla : CartaPorte' ) " & _
        '            " or detalle like 'Imputacion de IdCartaPorte" & idcarta & "C%'   ORDER BY FechaRegistro ASC"

        'Dim o As String = (From i In db.Logs Where i.IdComprobante = IdFactura And i.Detalle.StartsWith("Factura De Cartas") Select i.Detalle).FirstOrDefault


        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9872
        '* Agregarle la cantidad de modificaciones promedio por carta de porte.

        Dim l As Integer() = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23}
        Dim listahoras = l.ToList()
        Dim sucu As Integer() = {1, 2, 3, 4}
        Dim tipo As String() = {"ALTA", "MODIF", "IMPORT"}

        Dim q = (From cdp In db.CartasDePortes
                 Join cli In db.Clientes On cli.IdCliente Equals cdp.Vendedor
                 Join log In db.Logs On cdp.IdCartaDePorte Equals log.IdComprobante
                 From art In db.Articulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty
                 From clitit In db.Clientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty
                 Where
                     cdp.Vendedor > 0 _
                     And cli.RazonSocial IsNot Nothing _
                     And log.Detalle.StartsWith("Tabla : CartaPorte") _
                     And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
                     And (cdp.Anulada <> "SI") _
                     And ((ModoExportacion = "Ambos") Or (ModoExportacion = "Entregas" And If(cdp.Exporta, "NO") = "NO") Or (ModoExportacion = "Export" And If(cdp.Exporta, "NO") = "SI")) _
                     And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
                     And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                     And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                     And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                     And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                     And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                     And (idDestino = -1 Or cdp.Destino = idDestino) _
                     And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa)
                 Group cdp By
                             Hora = If(log.FechaRegistro Is Nothing, -1, log.FechaRegistro.Value.Hour),
                             altabaja = log.Tipo,
                             Sucursal = cdp.PuntoVenta
                     Into g = Group
                 Select New With {
                     .Sucursal = SqlFunctions.StringConvert(Sucursal),
                     .Hora = Hora,
                     .CantCartas = g.Count,
                     .ModificacionesPromedio = altabaja
                 }).ToList


        'quien = log.AuxString2, _
        'Hora = If(cdp.FechaIngreso, New Date(2000, 1, 1)).Hour, _
        'Hora2 = If(log.FechaRegistro Is Nothing, -1, log.FechaRegistro.Value.Hour), _
        'podria usar la hora de log.fecharegistro en lugar de cdp.ingreso








        Dim a = (From h In listahoras
                 From s In sucu
                 From aaa In tipo
                 From qs In q.Where(Function(i) i.Hora = h And Val(i.Sucursal) = s And i.ModificacionesPromedio = aaa).DefaultIfEmpty()
                 Where (puntoventa = -1 Or s = puntoventa)
                 Select New With {
                     .Sucursal = s.ToString,
                     .Hora = h _
                     , .CantCartas = If(qs Is Nothing, 0, qs.CantCartas),
                     .ModificacionesPromedio = aaa
             }).ToList



        For Each i In a
            i.Sucursal = PuntoVentaWilliams.NombrePuntoVentaWilliams4(Val(i.Sucursal))
        Next



        Return a

    End Function

    Public Shared Function DiferenciasDestino(ByVal SC As String,
          ByVal ColumnaParaFiltrar As String,
          ByVal TextoParaFiltrar As String,
          ByVal sortExpression As String,
          ByVal startRowIndex As Long,
          ByVal maximumRows As Long,
          ByVal estado As CartaDePorteManager.enumCDPestado,
          ByVal QueContenga As String,
          ByVal idVendedor As Integer,
          ByVal idCorredor As Integer,
          ByVal idDestinatario As Integer,
          ByVal idIntermediario As Integer,
          ByVal idRemComercial As Integer,
          ByVal idArticulo As Integer,
          ByVal idProcedencia As Integer,
          ByVal idDestino As Integer,
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR,
          ByVal ModoExportacion As String,
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime,
          ByVal puntoventa As Integer,
          Optional ByRef sTituloFiltroUsado As String = "",
          Optional ByVal optDivisionSyngenta As String = "Ambas",
          Optional ByVal bTraerDuplicados As Boolean = False,
          Optional ByVal Contrato As String = "") As Object



        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))





        Dim desde2, hasta2 As Date
        desde2 = DateAdd(DateInterval.Year, -1, fechadesde)
        hasta2 = DateAdd(DateInterval.Year, -1, fechahasta)

        If desde2 < Date.Parse(System.Data.SqlTypes.SqlDateTime.MinValue) Then
            desde2 = System.Data.SqlTypes.SqlDateTime.MinValue
            'Throw New Exception("Para mostrar diferencia de períodos, se necesita una fecha de inicio")
        End If


        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9872
        '* Agregarle la cantidad de modificaciones promedio por carta de porte.

        Dim q = (From cdp In db.CartasDePortes
                 Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor
                 From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty
                 From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty
                 Where
                     cdp.Vendedor > 0 _
                     And cli.RazonSocial IsNot Nothing _
                     And (
                             (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
                                 Or
                             (cdp.FechaDescarga >= desde2 And cdp.FechaDescarga <= hasta2)
                         ) _
                     And (cdp.Anulada <> "SI") _
                     And ((ModoExportacion = "Ambos") Or (ModoExportacion = "Entregas" And If(cdp.Exporta, "NO") = "NO") Or (ModoExportacion = "Export" And If(cdp.Exporta, "NO") = "SI")) _
                     And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
                     And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                     And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                     And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                     And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                     And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                     And (idDestino = -1 Or cdp.Destino = idDestino) _
                     And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa)
                 Group cdp By
                             Ano = cdp.FechaDescarga.Value.Year,
                             MesNumero = cdp.FechaDescarga.Value.Month,
                             Destino = dest.Descripcion
                         Into g = Group
                 Select New With {
                     .Destino = Destino,
                     .Ano = Ano,
                     .MesNumero = MesNumero,
                     .Mes = MonthName(MesNumero),
                     .NetoFinal = g.Sum(Function(i) CInt(i.NetoFinal.GetValueOrDefault / 1000)),
                     .TotalDelUltimoAnoParaOrdenar = g.Sum(Function(i) IIf(i.FechaDescarga >= fechadesde, CInt(i.NetoFinal.GetValueOrDefault / 1000), 0)),
                     .periodo1 = g.Sum(Function(i) IIf(i.FechaDescarga < fechadesde, CInt(i.NetoFinal.GetValueOrDefault / 1000), 0)),
                     .periodo2 = g.Sum(Function(i) IIf(i.FechaDescarga >= fechadesde, CInt(i.NetoFinal.GetValueOrDefault / 1000), 0))
                 }).OrderBy(Function(x) x.Destino).ToList


        '        1) Revisar porcentajes de diferencia que no están saliendo correcamente
        '2) Sacar la columna Total, poner en cambio la Diferencia en Kg del año actual con el anterior.

        '        Ahi adjunte un ejemplo de 1).
        'Por lo que veo el problema se produce cuando se saca un período que incluye días de dos años distintos (En el ej: del 1-6-13 al 29-4-14).
        'Creo que la cuenta que está haciendo es el período elegido contra el anterior, pero es imposible de verificar.
        'Creo que lo que habría que hacer es en las columnas no dividir por años si no por los períodos elegidos.




        '/////////////////////////////////////////////////////

        '* Mostrar porcentajes en nivel superior
        '* Ordenar los destinos por Toneladas del año actual



        'Hora = If(cdp.FechaIngreso, New Date(2000, 1, 1)).Hour, _
        'Hora2 = If(log.FechaRegistro Is Nothing, -1, log.FechaRegistro.Value.Hour), _
        'podria usar la hora de log.fecharegistro en lugar de cdp.ingreso



        'For Each i In q
        '    i.Sucursal = CartaDePorteManager.NombrePuntoVentaWilliams(Val(i.Sucursal))
        'Next



        Return q

    End Function






    Public Shared Function rankcereales(ByVal SC As String,
          ByVal ColumnaParaFiltrar As String,
          ByVal TextoParaFiltrar As String,
          ByVal sortExpression As String,
          ByVal startRowIndex As Long,
          ByVal maximumRows As Long,
          ByVal estado As CartaDePorteManager.enumCDPestado,
          ByVal QueContenga As String,
          ByVal idVendedor As Integer,
          ByVal idCorredor As Integer,
          ByVal idDestinatario As Integer,
          ByVal idIntermediario As Integer,
          ByVal idRemComercial As Integer,
          ByVal idArticulo As Integer,
          ByVal idProcedencia As Integer,
          ByVal idDestino As Integer,
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR,
          ByVal ModoExportacion As String,
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime,
          ByVal puntoventa As Integer, fechadesde2 As DateTime) As Object



        Dim db As LinqCartasPorteDataContext = New LinqCartasPorteDataContext(Encriptar(SC))


        'TO DO:mover a dll


        Dim q = (From cdp In db.CartasDePortes _
                Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor _
                Join art In db.linqArticulos On art.IdArticulo Equals cdp.IdArticulo _
                Where cdp.Vendedor > 0 _
                    And cli.RazonSocial IsNot Nothing _
                    And (cdp.FechaDescarga >= fechadesde2 And cdp.FechaDescarga <= fechahasta) _
                    And (cdp.Anulada <> "SI") _
                    And ((ModoExportacion = "Ambos") Or (ModoExportacion = "Entregas" And If(cdp.Exporta, "NO") = "NO") Or (ModoExportacion = "Export" And If(cdp.Exporta, "NO") = "SI")) _
                    And (cdp.PuntoVenta = puntoventa Or puntoventa = -1) _
                    And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                    And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                    And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                    And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                    And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                    And (idDestino = -1 Or cdp.Destino = idDestino) _
        Group cdp By Producto = art.Descripcion Into g = Group _
                Select New With { _
                        .Producto = Producto, _
                        .PV1 = g.Sum(Function(i) IIf(i.PuntoVenta = 1 And i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .PV2 = g.Sum(Function(i) IIf(i.PuntoVenta = 2 And i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .PV3 = g.Sum(Function(i) IIf(i.PuntoVenta = 3 And i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .PV4 = g.Sum(Function(i) IIf(i.PuntoVenta = 4 And i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .Total = g.Sum(Function(i) IIf(i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .Porcent = 0, _
                        .PeriodoAnterior = g.Sum(Function(i) IIf((puntoventa = 0 Or i.PuntoVenta = puntoventa) And i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .Diferen = 0, _
                        .DiferencPorcent = 0 _
                    } _
                ).Where(Function(i) i.Total > 0).ToList






        Return q

        'Cereal
        'BA (Tn sin mermas de Buenos Aires si se saca de todos los PV)
        'SL (Tn sin mermas de San Lorenzo si se saca de todos los PV)
        'AS (Tn sin mermas de Arroyo Seco si se saca de todos los PV)
        'BB (Tn sin mermas de Bahia Blanca si se saca de todos los PV)
        'Total (Tn netas sin mermas)
        '% (Sobre la suma de todos los clientes)
        'Total Periodo Anterior (*)
        'Diferencia (Total - Total Periodo Anterior)
        '%Dif (Diferencia/Total).



    End Function




    Public Shared Function rankingclientes(ByVal SC As String,
          ByVal ColumnaParaFiltrar As String,
          ByVal TextoParaFiltrar As String,
          ByVal sortExpression As String,
          ByVal startRowIndex As Long,
          ByVal maximumRows As Long,
          ByVal estado As CartaDePorteManager.enumCDPestado,
          ByVal QueContenga As String,
          ByVal idVendedor As Integer,
          ByVal idCorredor As Integer,
          ByVal idDestinatario As Integer,
          ByVal idIntermediario As Integer,
          ByVal idRemComercial As Integer,
          ByVal idArticulo As Integer,
          ByVal idProcedencia As Integer,
          ByVal idDestino As Integer,
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR,
          ByVal ModoExportacion As String,
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime,
          ByVal puntoventa As Integer,
            fechadesde2 As DateTime, fechahasta2 As DateTime, MinimoNeto As Integer, topclie As Integer) As Object


        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))
        db.Database.CommandTimeout = 300



        Dim bTraerDuplicados = True 'consulta 42686
        '//En el ranking de clientes, si se pide Modo: Entregas Fechas: 1/11/16 al 30/06/17, viene Amaggi en el lugar 9.
        '// Amaggi no tiene facturadas cartas de porte de entrega
        '// -esto pasa porque son duplicadas, y al pedir entrega, estas usando un TRUCHAMIENTO (en el fsql_) para hacer pasar el original por una de entrega (q es la de AMAGGI de exportacion)
        '// -ok, una opcion es traer tambien los duplicados (porq el TRUCHAMIENTO lo haces solo al pedir originales)!!!




        'CREATE NONCLUSTERED INDEX IDX_CartasDePorte_FechaDescarga
        'ON [dbo].[CartasDePorte] ([FechaDescarga])
        '        INCLUDE([NumeroCartaDePorte], [Anulada], [Vendedor], [CuentaOrden1], [CuentaOrden2], [Corredor], [Entregador],
        '        [Procedencia], [Patente], [idArticulo], [NetoProc], [NetoFinal], [Contrato], [Destino], [IdFacturaImputada], [puntoventa],
        '        [SubnumeroVagon], [FechaArribo], [Corredor2], [SubnumeroDeFacturacion], [IdClienteAuxiliar], [Acopio1], [Acopio2], [Acopio3], [Acopio4], [Acopio5], [Acopio6])
        '        GO()


        Dim q = (From cdp In db.fSQL_GetDataTableFiltradoYPaginado(Nothing, Nothing, estado, Nothing, idVendedor,
                                        idCorredor, idDestinatario, idIntermediario, idRemComercial,
                                        idArticulo, idProcedencia, idDestino, AplicarANDuORalFiltro, ModoExportacion,
                                        fechadesde2, fechahasta, puntoventa,
                                         Nothing, bTraerDuplicados, Nothing, Nothing, Nothing,
                                        Nothing, Nothing, Nothing, Nothing) _
                 Where cdp.FechaDescarga IsNot Nothing And _
                         ((If(cdp.FechaDescarga, fechadesde) >= fechadesde And If(cdp.FechaDescarga, fechadesde) <= fechahasta) Or
                          (If(cdp.FechaDescarga, fechadesde) >= fechadesde2 And If(cdp.FechaDescarga, fechadesde) <= fechahasta2))
                  Group cdp By ClienteDesc = cdp.ClienteFacturado, pv = cdp.PuntoVenta, EsAnterior = (If(cdp.FechaDescarga, fechadesde) <= fechahasta2) Into g = Group _
                  Select New With { _
                        ClienteDesc,
                        pv,
                        EsAnterior,
                        .NetoFinal = g.Sum(Function(i) i.NetoFinal / 1000)
               }).ToList()


        Dim tot = q.Where(Function(i) i.EsAnterior).Sum(Function(i) i.NetoFinal)



        Dim q9 = (From cdp In q _
                  Group cdp By cdp.ClienteDesc Into g = Group _
                  Select New With { _
                        .Producto = ClienteDesc, _
                        .PV1 = g.Where(Function(i) i.pv = 1 And Not i.EsAnterior).Sum(Function(i) i.NetoFinal), _
                        .PV2 = g.Where(Function(i) i.pv = 2 And Not i.EsAnterior).Sum(Function(i) i.NetoFinal), _
                        .PV3 = g.Where(Function(i) i.pv = 3 And Not i.EsAnterior).Sum(Function(i) i.NetoFinal), _
                        .PV4 = g.Where(Function(i) i.pv = 4 And Not i.EsAnterior).Sum(Function(i) i.NetoFinal), _
                        .Total = g.Where(Function(i) Not i.EsAnterior).Sum(Function(i) i.NetoFinal), _
                        .Porcent = 0, _
                        .PeriodoAnterior = g.Where(Function(i) i.EsAnterior).Sum(Function(i) i.NetoFinal), _
                        .Diferen = 0, _
                        .DiferencPorcent = 0 _
                    } _
                ).Where(Function(i) i.Total >= MinimoNeto).OrderByDescending(Function(i) i.Total).Take(topclie).tolist


        Dim tot2 = q9.Sum(Function(i) i.PeriodoAnterior)




        Return q9


    End Function









    'aca deberia bancarme el destino y el articulo, pero y los demas filtros???
    Shared Function EstadisticasDescargas(ByRef p2 As ReportParameter, txtFechaDesde As String, txtFechaHasta As String,
                                           txtFechaDesdeAnterior As String, txtFechaHastaAnterior As String,
                                          cmbPeriodo As String, cmbPuntoVenta As Integer, ModoExportacion As String, SC As String _
                                , idDestinatario As Integer, idDestino As Integer, IdArticulo As Integer, ByVal estado As CartaDePorteManager.enumCDPestado
                    ) As Object



        Dim dt = New DataTable

        '////////////////////////////////////////////////////
        '////////////////////////////////////////////////////
        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta, #1/1/2100#)

        Dim fechadesdeAnterior As Date = iisValidSqlDate(txtFechaDesdeAnterior, #1/1/2100#)
        Dim fechahastaAnterior As Date = iisValidSqlDate(txtFechaHastaAnterior, #1/1/2100#)

        If False Then

            'la fecha del periodo anterior a comparar
            If cmbPeriodo = "Este mes" Or cmbPeriodo = "Mes anterior" Then
                fechadesdeAnterior = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, fechadesde))
            Else
                fechadesdeAnterior = DateAdd(DateInterval.Day, -1, fechadesde - (fechahasta - fechadesde)) 'le agrego un dia mas porque si puso "ayer", la dif entre hasta y desde es 0
            End If
        End If


        'logear (o poner en el titulo) el rango de fechas usado para el periodo anterior
        ErrHandler2.WriteError("estadidesc   " & fechadesdeAnterior.ToShortDateString() & "   " & fechadesdeAnterior.ToShortDateString() & "   " & fechadesde.ToShortDateString() & "    " & fechahasta.ToShortDateString())

        '////////////////////////////////////////////////////
        '////////////////////////////////////////////////////

        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))

        db.Database.CommandTimeout = 80  'configurar

        Dim pv As Integer = cmbPuntoVenta
        'ListaEmbarquesQueryable

        'Dim qqqq = (From cdp In db.CartasDePortes _
        '        Join cli In db.Clientes On cli.IdCliente Equals cdp.Vendedor _
        '        Join art In db.Articulos On art.IdArticulo Equals cdp.IdArticulo _
        '        Where cdp.Vendedor > 0 _
        '            And cli.RazonSocial IsNot Nothing _
        '            And ( _
        '                    (cdp.FechaDescarga >= fechadesde2 And cdp.FechaDescarga <= fechahasta2) _
        '                    Or _
        '                    (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
        '                ) _
        '            And (cdp.Anulada <> "SI") _
        '            And ((ModoExportacion = "Ambos") _
        '                  Or (ModoExportacion = "Todos") _
        '                  Or (ModoExportacion = "Entregas" And If(cdp.Exporta, "NO") = "NO") _
        '                  Or (ModoExportacion = "Export" And If(cdp.Exporta, "NO") = "SI")) _
        '            And (pv = -1 Or cdp.PuntoVenta = pv)
        '        )




        'If ModoExportacion <> "Buques" Then

        Dim aaa = From xz In db.wCartasDePorte_TX_EstadisticasDeDescarga(Nothing, Nothing, estado,
                                                                         Nothing, Nothing,
                                                                          Nothing, idDestinatario, Nothing, Nothing, Nothing, Nothing, idDestino,
                                                                           Nothing,
                                                                             ModoExportacion, fechadesde, fechahasta, pv,
                                                                            Nothing, Nothing, Nothing, Nothing, Nothing, Nothing,
                                                                          Nothing,
                                                                         Nothing, fechadesdeAnterior, fechahastaAnterior)
                  Select xz
        'End If




        Dim x = aaa.ToList()

        If ModoExportacion = "Buques" Or ModoExportacion = "Todos" Then


            Dim q2 = LogicaFacturacion.ListaEmbarquesQueryable(SC, fechadesdeAnterior, fechahasta).ToList
            Dim bb = (From i In q2
                      From art In db.Articulos.Where(Function(f) f.IdArticulo = i.IdArticulo).DefaultIfEmpty
                      Group i By
                          Producto = art.Descripcion,
                          Modo = "Buque",
                          Sucursal = i.IdStock
                      Into g = Group
                      Select New ProntoMVC.Data.Models.wCartasDePorte_TX_EstadisticasDeDescarga_Result1 With {
                          .Sucursal = Sucursal,
                          .Modo = Modo,
                          .Producto = Producto,
                          .CantCartas = 0,
                          .NetoPto = CDec(0),
                          .Merma = CDec(0),
                          .NetoFinal = CDec(0),
                          .Importe = CDec(0),
                          .PV1 = g.Where(Function(i) i.IdStock = 1 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(If(i, New ProntoMVC.Data.Models.CartasPorteMovimiento).Cantidad, 0)) / 1000,
                          .PV2 = g.Where(Function(i) i.IdStock = 2 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(If(i, New ProntoMVC.Data.Models.CartasPorteMovimiento).Cantidad, 0)) / 1000,
                          .PV3 = g.Where(Function(i) i.IdStock = 3 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(If(i, New ProntoMVC.Data.Models.CartasPorteMovimiento).Cantidad, 0)) / 1000,
                          .PV4 = g.Where(Function(i) i.IdStock = 4 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(If(i, New ProntoMVC.Data.Models.CartasPorteMovimiento).Cantidad, 0)) / 1000,
                          .TotalEntrega = 0,
                          .TotalExportacion = 0,
                          .TotalBuques = g.Where(Function(i) i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(If(i, New ProntoMVC.Data.Models.CartasPorteMovimiento).Cantidad, 0)) / 1000,
                          .Total = g.Where(Function(i) i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(If(i, New ProntoMVC.Data.Models.CartasPorteMovimiento).Cantidad, 0)) / 1000,
                          .Porcent = 0,
                          .PeriodoAnterior = g.Where(Function(i) i.FechaIngreso <= fechahastaAnterior).DefaultIfEmpty().Sum(Function(i) If(If(i, New ProntoMVC.Data.Models.CartasPorteMovimiento).Cantidad, 0)) / 1000,
                          .Diferen = 0,
            .DiferencPorcent = 0
                      }).ToList

            x = x.Union(bb).ToList()
        End If


        'http://connect.microsoft.com/VisualStudio/feedback/details/590217/editor-very-slow-when-code-contains-linq-queries

        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////


        For Each i In x
            ' i.Sucursal = PuntoVentaWilliams.NombrePuntoVentaWilliams2(Val(i.Sucursal))
            i.Modo = IIf(i.Modo = "SI", "Exportación", "Entrega").ToString()


            'Dim a = i.Cartas.Select(Function(xx) xx.ToString).ToArray
            'Dim sss = String.Join(vbCrLf, a)
            'ErrHandler2.WriteError(i.Producto & " " & i.CantCartas & " " & sss)
        Next


        Dim p1 = New ReportParameter("IdCartaDePorte", -1)

        p2 = New ReportParameter("GranTotal", x.Sum(Function(i) i.Total))
        Return x



    End Function

    Class ss
        Public Sucursal As String
        Public Modo As String
        Public Producto As String
        Public CantCartas As Integer
        Public NetoPto As Decimal
        Public Merma As Decimal
        Public NetoFinal As Decimal
        Public Importe As Decimal
        Public PV1 As Integer
        Public PV2 As Integer
        Public PV3 As Integer
        Public PV4 As Integer
        Public TotalEntrega As Integer
        Public TotalExportacion As Integer
        Public TotalBuques As Integer
        Public Total As Integer
        Public Porcent As Integer
        Public PeriodoAnterior As Integer
        Public Diferen As Integer
        Public DiferencPorcent As Integer
    End Class

End Class

'End Namespace








