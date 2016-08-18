
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


'Namespace Pronto.ERP.Bll

<DataObjectAttribute()> _
<Transaction(TransactionOption.Required)> _
Public Class ConsultasLinq
    Inherits ServicedComponent

    'Shared dt As DataTable









    Public Shared Function totpormessucursal(ByVal SC As String, _
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
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR, _
          ByVal ModoExportacion As String, _
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
          ByVal puntoventa As Integer, _
          Optional ByRef sTituloFiltroUsado As String = "", _
          Optional ByVal optDivisionSyngenta As String = "Ambas", _
          Optional ByVal bTraerDuplicados As Boolean = False, _
          Optional ByVal Contrato As String = "") As Object


        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        'Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))

        db.CommandTimeout = 5 * 60 ' 3 Mins

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

        Dim q = (From cdp In db.CartasDePortes _
                Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor _
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                Where _
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
                    And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
                Group cdp By Ano = cdp.FechaDescarga.Value.Year, _
                            Producto = art.Descripcion, _
                            MesNumero = cdp.FechaDescarga.Value.Month, _
                            Sucursal = cdp.PuntoVenta _
                    Into g = Group _
                Select New With { _
                         .Sucursal = SqlFunctions.StringConvert(Sucursal), _
                    .Ano = Ano, _
                    .Mes = MonthName(MesNumero), _
                    .Producto = Producto, _
                    .CantCartas = g.Count, _
                .NetoPto = g.Sum(Function(i) i.NetoFinal.GetValueOrDefault) / 1000, _
                    .Merma = g.Sum(Function(i) (i.Merma.GetValueOrDefault + i.HumedadDesnormalizada.GetValueOrDefault)) / 1000, _
                    .NetoFinal = g.Sum(Function(i) i.NetoProc.GetValueOrDefault) / 1000, _
                    .MesNumero = MesNumero, _
                    .Importe = g.Sum(Function(i) CDec(CDec(If(i.TarifaFacturada, 0)) * CDec(If(i.NetoPto, 0)) / 1000 _
                                        )) _
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


    Public Shared Function LiquidacionSubcontratistas(ByVal SC As String, _
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
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR, _
          ByVal ModoExportacion As String, _
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
          ByVal puntoventa As Integer, idSubcontr As Integer, _
          ByRef sTituloFiltroUsado As String _
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



        'supongo que hay quilombo en el join del detalle de precios        'http://stackoverflow.com/questions/492683/how-to-limit-a-linq-left-outer-join-to-one-row
        'no puedo usae el take(1) en sql2000!!!! -y si agrupo esos registros con un Average?  .Average(Function(i) i.PrecioCaladaLocal).
        Dim qq = From cdp In db.CartasDePortes _
                From art In db.Articulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.Clientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                From clidest In db.Clientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
                From cliint In db.Clientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
                From clircom In db.Clientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
                From corr In db.Vendedores.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
                From cal In db.Calidade_EF.Where(Function(i) i.IdCalidad = CInt(cdp.Calidad)).DefaultIfEmpty _
                From estab In db.CDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
                From loc In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(cdp.Procedencia)).DefaultIfEmpty _
                From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                From clisub1 In db.Clientes.Where(Function(i) i.IdCliente = If(cdp.Subcontr1, dest.Subcontratista1)).DefaultIfEmpty _
                From clisub2 In db.Clientes.Where(Function(i) i.IdCliente = If(cdp.Subcontr2, dest.Subcontratista2)).DefaultIfEmpty _
                From l1 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub1.IdListaPrecios).DefaultIfEmpty _
                From pd1 In db.ListasPreciosDetalles.Where(Function(i) i.IdListaPrecios = l1.IdListaPrecios And (i.IdArticulo = cdp.IdArticulo)).DefaultIfEmpty _
                From l2 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub2.IdListaPrecios).DefaultIfEmpty _
                From pd2 In db.ListasPreciosDetalles.Where(Function(i) i.IdListaPrecios = l2.IdListaPrecios And (i.IdArticulo = cdp.IdArticulo)).DefaultIfEmpty _
                Where _
                 (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
                    And (cdp.Anulada <> "SI") _
                    And ((ModoExportacion = "Ambos") Or (ModoExportacion = "Entregas" _
                            And If(cdp.Exporta, "NO") = "NO") Or (ModoExportacion = "Export" And If(cdp.Exporta, "NO") = "SI") _
                        ) _
                    And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
                  And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                  And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                  And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                  And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                  And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                  And (idDestino = -1 Or cdp.Destino = idDestino) _
                  And (idSubcontr = -1 Or If(cdp.Subcontr1, dest.Subcontratista1) = idSubcontr Or If(cdp.Subcontr2, dest.Subcontratista2) = idSubcontr) _
                  And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
                Select New With { _
                    cdp.NumeroCartaDePorte, _
                    cdp.IdCartaDePorte, _
                    cdp.FechaDescarga, _
                    cdp.NetoFinal, _
                    .Subcontr1 = If(cdp.Subcontr1, dest.Subcontratista1), _
                    .Subcontr2 = If(cdp.Subcontr2, dest.Subcontratista2), _
                    .agrupVagon = If(destinosapartados.Contains(cdp.Destino), If(cdp.SubnumeroVagon = 0, "Camiones", "Vagones"), ""), _
                    cdp.ExcluirDeSubcontratistas, _
                    cdp.SubnumeroDeFacturacion, _
                    .VendedorDesc = clitit.RazonSocial, _
                    .CuentaOrden1Desc = cliint.RazonSocial, _
                    .CuentaOrden2Desc = clircom.RazonSocial, _
                    .CorredorDesc = corr.Nombre, _
                    .EntregadorDesc = clidest.RazonSocial, _
                    .ProcedenciaDesc = loc.Nombre, _
                    .DestinoDesc = dest.Descripcion, _
                    .Subcontr1Desc = clisub1.RazonSocial, _
                    .Subcontr2Desc = clisub2.RazonSocial, _
                    .tarif1 = CDec(If(If( _
                    (cdp.Exporta = "SI" Or (cdp.Corredor = IdCorredorBLD And (cdp.IdClienteEntregador <> IdWilliams Or cdp.IdClienteEntregador <= 0))) _
                        , If(cdp.SubnumeroVagon <= 0, pd1.PrecioCaladaExportacion, pd1.PrecioVagonesCalada) _
                        , If(cdp.SubnumeroVagon <= 0, pd1.PrecioCaladaLocal, pd1.PrecioVagonesCalada) _
                        ), 0)), _
                    .tarif2 = CDec(If(If( _
                        (cdp.Exporta = "SI" Or (cdp.Corredor = IdCorredorBLD And (cdp.IdClienteEntregador <> IdWilliams Or cdp.IdClienteEntregador <= 0))) _
                        , If(cdp.SubnumeroVagon <= 0, pd2.PrecioDescargaExportacion, pd2.PrecioVagonesBalanza) _
                        , If(cdp.SubnumeroVagon <= 0, pd2.PrecioDescargaLocal, pd2.PrecioVagonesBalanza) _
                                ), 0)), _
                    .Exporta = cdp.Exporta, _
                    cdp.Corredor, _
                    cdp.IdClienteEntregador}
        'IdListaPreciosDetalle1 = pd1.IdListaPreciosDetalle, IdListaPreciosDetalle2 = pd2.IdListaPreciosDetalle



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







        Dim q = From i In aa _
                Group By _
                    i.IdCartaDePorte, _
                    i.NumeroCartaDePorte, _
                    i.FechaDescarga, _
                    i.agrupVagon, _
                    i.NetoFinal, _
                    i.Subcontr1, _
                    i.Subcontr2, _
                    i.ExcluirDeSubcontratistas, _
                    i.SubnumeroDeFacturacion, _
                    i.VendedorDesc, _
                    i.CuentaOrden1Desc, _
                    i.CuentaOrden2Desc, _
                    i.CorredorDesc, _
                    i.EntregadorDesc, _
                    i.ProcedenciaDesc, _
                    i.DestinoDesc, _
                    i.Subcontr1Desc, _
                    i.Subcontr2Desc, _
                    i.Exporta, _
                    i.Corredor, _
                    i.IdClienteEntregador
                Into Group _
                Select New With { _
                    IdCartaDePorte, _
                    NumeroCartaDePorte, _
                    FechaDescarga, _
                    agrupVagon, _
                    NetoFinal, _
                    Subcontr1, _
                    Subcontr2, _
                    ExcluirDeSubcontratistas, _
                    SubnumeroDeFacturacion, _
                    VendedorDesc, _
                    CuentaOrden1Desc, _
                    CuentaOrden2Desc, _
                    CorredorDesc, _
                    EntregadorDesc, _
                    ProcedenciaDesc, _
                    DestinoDesc, _
                    Subcontr1Desc, _
                    Subcontr2Desc, _
                    Exporta, _
                    .tarif1 = Group.Max(Function(x) x.tarif1), _
                    .tarif2 = Group.Max(Function(x) x.tarif2), _
                    Corredor, _
                    IdClienteEntregador
                     }
        'IdListaPreciosDetalle1, IdListaPreciosDetalle2





        If Debugger.IsAttached Then
            q.ToList()

            Dim a = From x In q Order By x.FechaDescarga, x.IdCartaDePorte Select SqlFunctions.StringConvert(x.NumeroCartaDePorte) & " " & SqlFunctions.StringConvert(x.IdCartaDePorte) & " " & x.tarif1 & " " & x.tarif2 ' & " " & x.IdListaPreciosDetalle1 & " " & x.IdListaPreciosDetalle2

            ErrHandler2.WriteError(vbCrLf & Join(a.ToArray, vbCrLf))
        End If












        Dim q4 As List(Of infLiqui) = (From cdp In q _
                    Where (idSubcontr = -1 Or cdp.Subcontr1 = idSubcontr) _
                    Select New infLiqui With { _
                        .agrupVagon = cdp.agrupVagon, _
                        .DestinoDesc = cdp.DestinoDesc & " Calada" & If( _
                            (cdp.Exporta = "SI" Or (cdp.Corredor = IdCorredorBLD And (cdp.IdClienteEntregador <> IdWilliams Or cdp.IdClienteEntregador <= 0))) _
                                   , " - Export.", " - Entrega"), _
                        .SubcontrDesc = cdp.Subcontr1Desc, _
                        .NetoPto = cdp.NetoFinal, _
                        .Tarifa = cdp.tarif1, _
                        .Comision = cdp.NetoFinal * cdp.tarif1 / 1000}).ToList

        Dim q5 As List(Of infLiqui) = (From cdp In q _
                   Where (idSubcontr = -1 Or cdp.Subcontr2 = idSubcontr) _
                    Select New infLiqui With { _
                        .agrupVagon = cdp.agrupVagon, _
                        .DestinoDesc = cdp.DestinoDesc & " Balanza" & If( _
                                      (cdp.Exporta = "SI" Or (cdp.Corredor = IdCorredorBLD And (cdp.IdClienteEntregador <> IdWilliams Or cdp.IdClienteEntregador <= 0))) _
                                    , " - Export.", " - Entrega"), _
                        .SubcontrDesc = cdp.Subcontr2Desc, _
                        .NetoPto = cdp.NetoFinal, _
                        .Tarifa = cdp.tarif2, _
                        .Comision = cdp.NetoFinal * cdp.tarif2 / 1000}).ToList


        Dim q6 As New List(Of infLiqui) '= q4.Union(q5)
        q6.AddRange(q4)
        q6.AddRange(q5)



        Dim q3 = From i In q6 _
                Group i By agrupVagon = i.agrupVagon, DestinoDesc = i.DestinoDesc, SubcontrDesc = i.SubcontrDesc, Tarifa = i.Tarifa Into g = Group _
                Select agrupVagon = agrupVagon, DestinoDesc = DestinoDesc, SubcontrDesc = SubcontrDesc, Tarifa = Tarifa, _
                NetoPto = g.Sum(Function(i) i.NetoPto), Comision = g.Sum(Function(i) i.Comision), CantCartas = g.Count


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
    End Class




    Public Shared Function totpormes(ByVal SC As String, _
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
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR, _
          ByVal ModoExportacion As String, _
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
          ByVal puntoventa As Integer, _
          Optional ByRef sTituloFiltroUsado As String = "", _
          Optional ByVal optDivisionSyngenta As String = "Ambas", _
          Optional ByVal bTraerDuplicados As Boolean = False, _
          Optional ByVal Contrato As String = "") As Object



        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        'Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        db.CommandTimeout = 5 * 60 ' 3 Mins





        Dim q = (From cdp In db.CartasDePortes _
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
                    And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
                Group cdp By Ano = cdp.FechaDescarga.Value.Year, _
                            MesNumero = cdp.FechaDescarga.Value.Month, _
                            Producto = art.Descripcion Into g = Group _
                Select New With { _
                    .Ano = Ano, _
                    .Mes = MonthName(MesNumero), _
                    .Producto = Producto, _
                    .CantCartas = g.Count, _
                    .NetoPto = g.Sum(Function(i) i.NetoFinal.GetValueOrDefault) / 1000, _
                    .Merma = g.Sum(Function(i) (i.Merma.GetValueOrDefault + i.HumedadDesnormalizada.GetValueOrDefault)) / 1000, _
                    .NetoFinal = g.Sum(Function(i) i.NetoProc.GetValueOrDefault) / 1000, _
                    .MesNumero = MesNumero _
                }).ToList




        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////

        Dim q2 = LogicaFacturacion.ListaEmbarquesQueryable(SC, fechadesde, fechahasta).ToList
        Dim a = (From i In q2 _
                Join art In db.linqArticulos On art.IdArticulo Equals i.IdArticulo _
                    Group i By Ano = i.FechaIngreso.Value.Year, _
                            MesNumero = i.FechaIngreso.Value.Month, _
                            Producto = art.Descripcion _
                    Into g = Group _
                    Select New With { _
                    .Ano = Ano, _
                    .Mes = MonthName(MesNumero), _
                    .Producto = Producto, _
                    .CantCartas = g.Count, _
                    .NetoPto = g.Sum(Function(i) i.Cantidad.GetValueOrDefault) / 1000, _
                    .Merma = CDec(0), _
                    .NetoFinal = g.Sum(Function(i) i.Cantidad.GetValueOrDefault) / 1000, _
                    .MesNumero = MesNumero _
                    }).ToList

        Dim x = q.Union(a).ToList()

        'http://connect.microsoft.com/VisualStudio/feedback/details/590217/editor-very-slow-when-code-contains-linq-queries

        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////





        Return x



    End Function
    Public Shared Function totpormesmodo(ByVal SC As String, _
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
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR, _
          ByVal ModoExportacion As String, _
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
          ByVal puntoventa As Integer, _
          Optional ByRef sTituloFiltroUsado As String = "", _
          Optional ByVal optDivisionSyngenta As String = "Ambas", _
          Optional ByVal bTraerDuplicados As Boolean = False, _
          Optional ByVal Contrato As String = "") As Object



        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        'Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        db.CommandTimeout = 5 * 60 ' 3 Mins


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

        Dim q = (From cdp In db.CartasDePortes _
                Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor _
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                Where _
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
                    And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
                Group cdp By Ano = cdp.FechaDescarga.Value.Year, _
                            Producto = art.Descripcion, _
                            MesNumero = cdp.FechaDescarga.Value.Month, _
                            Sucursal = cdp.Exporta _
                    Into g = Group _
                Select New With { _
                    .Sucursal = Sucursal, _
                    .Ano = Ano, _
                    .Mes = MonthName(MesNumero), _
                    .Producto = Producto, _
                    .CantCartas = g.Count, _
                    .NetoPto = g.Sum(Function(i) i.NetoFinal.GetValueOrDefault) / 1000, _
                    .Merma = g.Sum(Function(i) (i.Merma.GetValueOrDefault + i.HumedadDesnormalizada.GetValueOrDefault)) / 1000, _
                    .NetoFinal = g.Sum(Function(i) i.NetoProc.GetValueOrDefault) / 1000, _
                    .MesNumero = MesNumero, _
                     .Importe = g.Sum(Function(i) CDec( _
                                                     CDec(If(i.TarifaFacturada, 0)) * CDec(If(i.NetoPto, 0)) / 1000 _
                                                    )) _
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
            Dim a = (From i In q3 _
                    Join art In db.linqArticulos On art.IdArticulo Equals i.IdArticulo _
                        Group i By Ano = i.FechaIngreso.Value.Year, _
                                MesNumero = i.FechaIngreso.Value.Month, _
                                Producto = art.Descripcion _
                        Into g = Group _
                        Select New With { _
                        .Sucursal = "Buque", _
                        .Ano = Ano, _
                        .Mes = MonthName(MesNumero), _
                        .Producto = Producto, _
                        .CantCartas = g.Count, _
                        .NetoPto = g.Sum(Function(i) i.Cantidad.GetValueOrDefault) / 1000, _
                        .Merma = CDec(0), _
                        .NetoFinal = g.Sum(Function(i) i.Cantidad.GetValueOrDefault) / 1000, _
                        .MesNumero = MesNumero, _
                         .Importe = CDec(0) _
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


    Public Shared Function totpormesmodoysucursal(ByVal SC As String, _
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
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR, _
          ByVal ModoExportacion As String, _
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
          ByVal puntoventa As Integer, _
          Optional ByRef sTituloFiltroUsado As String = "", _
          Optional ByVal optDivisionSyngenta As String = "Ambas", _
          Optional ByVal bTraerDuplicados As Boolean = False, _
          Optional ByVal Contrato As String = "") As Object



        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        'Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        db.CommandTimeout = 5 * 60 ' 3 Mins


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





        Dim sSQL = "update cartasdeporte " & _
            " set tarifafacturada=dbo.wTarifaWilliams (Vendedor,IdArticulo,Destino,  case when isnull(Exporta,'NO')='SI' then 1 else 0 end   ,0)" & _
            " from cartasdeporte " & _
            " where (idfacturaimputada=0 or idfacturaimputada=-1 or idfacturaimputada is null )" & _
            " and isnull(Anulada,'')<>'SI'" & _
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

        Dim q = (From cdp In db.CartasDePortes _
                Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor _
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                Where _
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
                    And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
                Group cdp By Ano = cdp.FechaDescarga.Value.Year, _
                            Producto = art.Descripcion, _
                            MesNumero = cdp.FechaDescarga.Value.Month, _
                            Modo = cdp.Exporta, _
                            Sucursal = cdp.PuntoVenta _
                        Into g = Group _
                Select New With { _
                    .Sucursal = SqlFunctions.StringConvert(Sucursal), _
                    .Modo = IIf(Modo = "SI", "Exportación", "Entrega").ToString, _
                    .Ano = Ano, _
                    .Mes = MonthName(MesNumero), _
                    .Producto = Producto, _
                    .CantCartas = g.Count, _
                    .NetoPto = g.Sum(Function(i) i.NetoFinal.GetValueOrDefault) / 1000, _
                    .Merma = g.Sum(Function(i) (i.Merma.GetValueOrDefault + i.HumedadDesnormalizada.GetValueOrDefault)) / 1000, _
                    .NetoFinal = g.Sum(Function(i) i.NetoProc.GetValueOrDefault) / 1000, _
                    .MesNumero = MesNumero, _
                    .Importe = g.Sum(Function(i) CDec( _
                                                     CDec(i.TarifaFacturada.GetValueOrDefault) * CDec(i.NetoPto) / 1000 _
                                                   )) _
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
            Dim a = (From i In q3 _
                    Join art In db.linqArticulos On art.IdArticulo Equals i.IdArticulo _
                        Group i By Ano = i.FechaIngreso.Value.Year, _
                                MesNumero = i.FechaIngreso.Value.Month, _
                                Producto = art.Descripcion, _
                                   Modo = "Buque", _
                                Sucursal = i.IdStock _
                        Into g = Group _
                        Select New With { _
                        .Sucursal = SqlFunctions.StringConvert(Sucursal), _
                        .Modo = Modo, _
                        .Ano = Ano, _
                        .Mes = MonthName(MesNumero), _
                        .Producto = Producto, _
                        .CantCartas = g.Count, _
                        .NetoPto = g.Sum(Function(i) i.Cantidad.GetValueOrDefault) / 1000, _
                        .Merma = CDec(0), _
                        .NetoFinal = g.Sum(Function(i) i.Cantidad.GetValueOrDefault) / 1000, _
                        .MesNumero = MesNumero, _
                         .Importe = CDec(0) _
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

    Private Shared Function CartasLINQxxxx(ByVal SC As String, _
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
        ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR, _
        ByVal ModoExportacion As String, _
        ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
        ByVal puntoventa As Integer, _
        Optional ByRef sTituloFiltroUsado As String = "", _
        Optional ByVal optDivisionSyngenta As String = "Ambas", _
        Optional ByVal bTraerDuplicados As Boolean = False, _
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

        Dim q = From cdp In db.CartasDePortes _
    Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor _
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



    Public Shared Function VolumenCarga(ByVal SC As String, _
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
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR, _
          ByVal ModoExportacion As String, _
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
          ByVal puntoventa As Integer, _
          Optional ByRef sTituloFiltroUsado As String = "", _
          Optional ByVal optDivisionSyngenta As String = "Ambas", _
          Optional ByVal bTraerDuplicados As Boolean = False, _
          Optional ByVal Contrato As String = "") As Object



        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

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

        Dim q = (From cdp In db.CartasDePortes _
                Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor _
                Join log In db.Logs On cdp.IdCartaDePorte Equals log.IdComprobante _
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                Where _
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
                    And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
                Group cdp By _
                            Hora = If(log.FechaRegistro Is Nothing, -1, log.FechaRegistro.Value.Hour), _
                            altabaja = log.Tipo, _
                            Sucursal = cdp.PuntoVenta _
                    Into g = Group _
                Select New With { _
                    .Sucursal = SqlFunctions.StringConvert(Sucursal), _
                    .Hora = Hora, _
                    .CantCartas = g.Count, _
                    .ModificacionesPromedio = altabaja _
                }).ToList


        'quien = log.AuxString2, _
        'Hora = If(cdp.FechaIngreso, New Date(2000, 1, 1)).Hour, _
        'Hora2 = If(log.FechaRegistro Is Nothing, -1, log.FechaRegistro.Value.Hour), _
        'podria usar la hora de log.fecharegistro en lugar de cdp.ingreso








        Dim a = (From h In listahoras _
                 From s In sucu _
                 From aaa In tipo _
                 From qs In q.Where(Function(i) i.Hora = h And Val(i.Sucursal) = s And i.ModificacionesPromedio = aaa).DefaultIfEmpty() _
                 Where (puntoventa = -1 Or s = puntoventa) _
                    Select New With { _
                        .Sucursal = s.ToString, _
                        .Hora = h _
                        , .CantCartas = If(qs Is Nothing, 0, qs.CantCartas), _
                        .ModificacionesPromedio = aaa _
                }).ToList



        For Each i In a
            i.Sucursal = PuntoVentaWilliams.NombrePuntoVentaWilliams4(Val(i.Sucursal))
        Next



        Return a

    End Function

    Public Shared Function DiferenciasDestino(ByVal SC As String, _
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
          ByVal AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR, _
          ByVal ModoExportacion As String, _
          ByVal fechadesde As DateTime, ByVal fechahasta As DateTime, _
          ByVal puntoventa As Integer, _
          Optional ByRef sTituloFiltroUsado As String = "", _
          Optional ByVal optDivisionSyngenta As String = "Ambas", _
          Optional ByVal bTraerDuplicados As Boolean = False, _
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

        Dim q = (From cdp In db.CartasDePortes _
                Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor _
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                Where _
                    cdp.Vendedor > 0 _
                    And cli.RazonSocial IsNot Nothing _
                    And ( _
                            (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
                                Or _
                            (cdp.FechaDescarga >= desde2 And cdp.FechaDescarga <= hasta2) _
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
                    And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
                Group cdp By _
                            Ano = cdp.FechaDescarga.Value.Year, _
                            MesNumero = cdp.FechaDescarga.Value.Month, _
                            Destino = dest.Descripcion _
                        Into g = Group _
                Select New With { _
                    .Destino = Destino, _
                    .Ano = Ano, _
                    .MesNumero = MesNumero, _
                    .Mes = MonthName(MesNumero), _
                    .NetoFinal = g.Sum(Function(i) CInt(i.NetoFinal.GetValueOrDefault / 1000)), _
                    .TotalDelUltimoAnoParaOrdenar = g.Sum(Function(i) IIf(i.FechaDescarga >= fechadesde, CInt(i.NetoFinal.GetValueOrDefault / 1000), 0)), _
                    .periodo1 = g.Sum(Function(i) IIf(i.FechaDescarga < fechadesde, CInt(i.NetoFinal.GetValueOrDefault / 1000), 0)), _
                    .periodo2 = g.Sum(Function(i) IIf(i.FechaDescarga >= fechadesde, CInt(i.NetoFinal.GetValueOrDefault / 1000), 0)) _
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





    'aca deberia bancarme el destino y el articulo, pero y los demas filtros???
    Shared Function EstadisticasDescargas(ByRef p2 As ReportParameter, txtFechaDesde As String, txtFechaHasta As String, _
                                           txtFechaDesdeAnterior As String, txtFechaHastaAnterior As String, _
                                          cmbPeriodo As String, cmbPuntoVenta As Integer, ModoExportacion As String, SC As String _
                                , idDestinatario As Integer, idDestino As Integer, IdArticulo As Integer
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

        db.Database.CommandTimeout = 80

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

        Dim aaa = From xz In db.wCartasDePorte_TX_EstadisticasDeDescarga(Nothing, Nothing, Nothing, Nothing, Nothing,
                                                                          Nothing, Nothing, fechadesdeAnterior, fechahastaAnterior, Nothing,
                                                                         Nothing, Nothing, Nothing, Nothing, Nothing,
                                                                          Nothing, ModoExportacion, fechadesde, fechahasta, pv,
                                                                         Nothing, idDestinatario, Nothing, Nothing, Nothing,
                                                                         Nothing, IdDestino)
                  Select xz
        'End If



        '.Cartas = g.Select(Function(i) i.NumeroCartaDePorte), _
        If False Then

            Dim o = (From cdp In db.CartasDePortes _
                    Join art In db.Articulos On art.IdArticulo Equals cdp.IdArticulo _
                    Where cdp.Vendedor > 0 _
                        And ( _
                                (cdp.FechaDescarga >= fechadesdeAnterior And cdp.FechaDescarga <= fechahastaAnterior) _
                                Or _
                                (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
                            ) _
                        And (cdp.Anulada <> "SI") _
                        And ((ModoExportacion = "Ambos") _
                              Or (ModoExportacion = "Todos") _
                              Or (ModoExportacion = "Entregas" And If(cdp.Exporta, "NO") = "NO") _
                              Or (ModoExportacion = "Export" And If(cdp.Exporta, "NO") = "SI")) _
                        And (pv = -1 Or cdp.PuntoVenta = pv)
                       Group cdp By _
                            Producto = art.Descripcion, _
                            Modo = cdp.Exporta, _
                            Sucursal = cdp.PuntoVenta _
                              Into g = Group
                      Select New With { _
                            .Sucursal = SqlFunctions.StringConvert(Sucursal), _
                            .Modo = Modo, _
                            .Producto = Producto, _
                            .CantCartas = g.Count, _
                            .NetoPto = g.Sum(Function(i) If(i.NetoFinal, 0)) / 1000, _
                            .Merma = g.Sum(Function(i) (If(i.Merma, 0) + If(i.HumedadDesnormalizada, 0))) / 1000, _
                            .NetoFinal = g.Sum(Function(i) If(i.NetoProc, 0)) / 1000, _
                            .Importe = g.Sum(Function(i) CDec( _
                                                             CDec(If(i.TarifaFacturada, 0)) * CDec(If(i.NetoPto, 0)) / 1000 _
                                                            )), _
                            .PV1 = CInt(g.Where(Function(i) i.PuntoVenta = 1 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                            .PV2 = CInt(g.Where(Function(i) i.PuntoVenta = 2 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                            .PV3 = CInt(g.Where(Function(i) i.PuntoVenta = 3 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                            .PV4 = CInt(g.Where(Function(i) i.PuntoVenta = 4 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                            .TotalEntrega = CInt(g.Where(Function(i) i.FechaDescarga >= fechadesde And If(Modo, "NO") = "NO") _
                                                .DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                            .TotalExportacion = CInt(g.Where(Function(i) i.FechaDescarga >= fechadesde And If(Modo, "NO") = "SI") _
                                                .DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                            .TotalBuques = 0, _
                            .Total = CInt(g.Where(Function(i) i.FechaDescarga >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                            .Porcent = 0, _
                            .PeriodoAnterior = CInt(g.Where(Function(i) i.FechaDescarga < fechadesde).DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                            .Diferen = 0, _
                            .DiferencPorcent = 0 _
                        } _
                    ).Where(Function(i) i.Total > 0).ToList
        End If

        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////



        Dim x = aaa.ToList()

        If ModoExportacion = "Buques" Or ModoExportacion = "Todos" Then


            Dim q2 = LogicaFacturacion.ListaEmbarquesQueryable(SC, fechadesdeAnterior, fechahasta).ToList
            Dim bb = (From i In q2 _
                       From art In db.Articulos.Where(Function(f) f.IdArticulo = i.IdArticulo).DefaultIfEmpty _
                        Group i By _
                            Producto = art.Descripcion, _
                            Modo = "Buque", _
                            Sucursal = i.IdStock _
                        Into g = Group _
                        Select New ProntoMVC.Data.Models.wCartasDePorte_TX_EstadisticasDeDescarga_Result1 With { _
                            .Sucursal = Sucursal, _
                            .Modo = Modo, _
                            .Producto = Producto, _
                            .CantCartas = 0, _
                            .NetoPto = CDec(0), _
                            .Merma = CDec(0), _
                            .NetoFinal = CDec(0), _
                            .Importe = CDec(0), _
                            .PV1 = CInt(g.Where(Function(i) i.IdStock = 1 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(If(i, New ProntoMVC.Data.Models.CartasPorteMovimiento).Cantidad, 0)) / 1000), _
                            .PV2 = CInt(g.Where(Function(i) i.IdStock = 2 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(If(i, New ProntoMVC.Data.Models.CartasPorteMovimiento).Cantidad, 0)) / 1000), _
                            .PV3 = CInt(g.Where(Function(i) i.IdStock = 3 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(If(i, New ProntoMVC.Data.Models.CartasPorteMovimiento).Cantidad, 0)) / 1000), _
                            .PV4 = CInt(g.Where(Function(i) i.IdStock = 4 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(If(i, New ProntoMVC.Data.Models.CartasPorteMovimiento).Cantidad, 0)) / 1000), _
                            .TotalEntrega = 0, _
                            .TotalExportacion = 0, _
                            .TotalBuques = CInt(g.Where(Function(i) i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(If(i, New ProntoMVC.Data.Models.CartasPorteMovimiento).Cantidad, 0)) / 1000), _
                            .Total = CInt(g.Where(Function(i) i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(If(i, New ProntoMVC.Data.Models.CartasPorteMovimiento).Cantidad, 0)) / 1000), _
                            .Porcent = 0, _
                            .PeriodoAnterior = CInt(g.Where(Function(i) i.FechaIngreso <= fechahastaAnterior).DefaultIfEmpty().Sum(Function(i) If(If(i, New ProntoMVC.Data.Models.CartasPorteMovimiento).Cantidad, 0)) / 1000), _
                            .Diferen = 0, _
                            .DiferencPorcent = 0 _
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








