
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

        db.CommandTimeout = 5 * 60 ' 3 Mins

        If False Then

            ''Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
            ''Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
            ''Dim fechadesde2 As Date

            ' ''la fecha del periodo anterior a comparar
            ''If cmbPeriodo.Text = "Este mes" Or cmbPeriodo.Text = "Mes anterior" Then
            ''    fechadesde2 = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, fechadesde))
            ''Else
            ''    fechadesde2 = fechadesde - (fechahasta - fechadesde)
            ''End If
            ''////////////////////////////////////////////////////
            ''////////////////////////////////////////////////////


            'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

            Dim pv1, pv2, pv3, pv4 As Decimal

            Dim fechamin = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, Today))


            pv1 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(1) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

            pv2 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(2) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

            pv3 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(3) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

            pv4 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(4) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

            '//////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////


            'Que pasa con los clientes nuevos o que no tienen tarifa? -Usar un promedio.

            Dim lista As New Generic.List(Of tipoloco)
            Dim i As tipoloco


            Dim q2 = (From l In lista Select Monto = l.monto, Mes = l.mes, Ano = l.ano, Orden = l.orden, Serie = l.serie).ToList 'ojo que es CaseSensitive!!!!
            'Mes
            'ano tarifa netofinal precio


        End If









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
                    .Sucursal = Sucursal.ToString(), _
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


        db.CommandTimeout = 5 * 60 ' 3 Mins


        If False Then

            ''Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
            ''Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
            ''Dim fechadesde2 As Date

            ' ''la fecha del periodo anterior a comparar
            ''If cmbPeriodo.Text = "Este mes" Or cmbPeriodo.Text = "Mes anterior" Then
            ''    fechadesde2 = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, fechadesde))
            ''Else
            ''    fechadesde2 = fechadesde - (fechahasta - fechadesde)
            ''End If
            ''////////////////////////////////////////////////////
            ''////////////////////////////////////////////////////


            'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

            Dim pv1, pv2, pv3, pv4 As Decimal

            Dim fechamin = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, Today))


            pv1 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(1) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

            pv2 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(2) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

            pv3 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(3) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

            pv4 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(4) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

            '//////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////


            'Que pasa con los clientes nuevos o que no tienen tarifa? -Usar un promedio.

            Dim lista As New Generic.List(Of tipoloco)
            Dim i As tipoloco


            Dim q2 = (From l In lista Select Monto = l.monto, Mes = l.mes, Ano = l.ano, Orden = l.orden, Serie = l.serie).ToList 'ojo que es CaseSensitive!!!!
            'Mes
            'ano tarifa netofinal precio


        End If



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
                    .Sucursal = IIf(Sucursal = "SI", "Exportación", "Entrega").ToString, _
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


        db.CommandTimeout = 5 * 60 ' 3 Mins


        If False Then

            ''Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
            ''Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
            ''Dim fechadesde2 As Date

            ' ''la fecha del periodo anterior a comparar
            ''If cmbPeriodo.Text = "Este mes" Or cmbPeriodo.Text = "Mes anterior" Then
            ''    fechadesde2 = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, fechadesde))
            ''Else
            ''    fechadesde2 = fechadesde - (fechahasta - fechadesde)
            ''End If
            ''////////////////////////////////////////////////////
            ''////////////////////////////////////////////////////


            'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

            Dim pv1, pv2, pv3, pv4 As Decimal

            Dim fechamin = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, Today))


            pv1 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(1) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

            pv2 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(2) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

            pv3 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(3) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

            pv4 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(4) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

            '//////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////


            'Que pasa con los clientes nuevos o que no tienen tarifa? -Usar un promedio.

            Dim lista As New Generic.List(Of tipoloco)
            Dim i As tipoloco


            Dim q2 = (From l In lista Select Monto = l.monto, Mes = l.mes, Ano = l.ano, Orden = l.orden, Serie = l.serie).ToList 'ojo que es CaseSensitive!!!!
            'Mes
            'ano tarifa netofinal precio


        End If





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
                    .Sucursal = Sucursal.ToString(), _
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
                        .Sucursal = Sucursal.ToString, _
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
                    .Sucursal = Sucursal.ToString(), _
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






    Shared Function EstadisticasDescargas(ByRef p2 As ReportParameter, txtFechaDesde As String, txtFechaHasta As String, cmbPeriodo As String, cmbPuntoVenta As Integer, ModoExportacion As String, SC As String) As Object
        Dim dt = New DataTable

        '////////////////////////////////////////////////////
        '////////////////////////////////////////////////////
        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta, #1/1/2100#)
        Dim fechadesde2 As Date

        'la fecha del periodo anterior a comparar
        If cmbPeriodo = "Este mes" Or cmbPeriodo = "Mes anterior" Then
            fechadesde2 = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, fechadesde))
        Else
            fechadesde2 = DateAdd(DateInterval.Day, -1, fechadesde - (fechahasta - fechadesde)) 'le agrego un dia mas porque si puso "ayer", la dif entre hasta y desde es 0
        End If
        '////////////////////////////////////////////////////
        '////////////////////////////////////////////////////

        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        Dim pv As Integer = cmbPuntoVenta
        'ListaEmbarquesQueryable


        Dim q = (From cdp In db.CartasDePortes _
                Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor _
                Join art In db.linqArticulos On art.IdArticulo Equals cdp.IdArticulo _
                Where cdp.Vendedor > 0 _
                   And cli.RazonSocial IsNot Nothing _
                   And (cdp.FechaDescarga >= fechadesde2 And cdp.FechaDescarga <= fechahasta) _
                  And (cdp.Anulada <> "SI") _
                    And ((ModoExportacion = "Ambos") _
                          Or (ModoExportacion = "Todos") _
                          Or (ModoExportacion = "Entregas" And If(cdp.Exporta, "NO") = "NO") _
                          Or (ModoExportacion = "Export" And If(cdp.Exporta, "NO") = "SI")) _
                    And (pv = -1 Or cdp.PuntoVenta = pv) _
                Group cdp By _
                            Producto = art.Descripcion, _
                             Modo = cdp.Exporta, _
                    Sucursal = cdp.PuntoVenta _
                    Into g = Group _
                Select New With { _
                         .Sucursal = Sucursal.ToString(), _
                        .Modo = IIf(Modo = "SI", "Exportación", "Entrega").ToString(), _
                        .Producto = Producto, _
                        .CantCartas = g.Count, _
                                            .NetoPto = g.Sum(Function(i) i.NetoFinal.GetValueOrDefault) / 1000, _
                    .Merma = g.Sum(Function(i) (i.Merma.GetValueOrDefault + i.HumedadDesnormalizada.GetValueOrDefault)) / 1000, _
                    .NetoFinal = g.Sum(Function(i) i.NetoProc.GetValueOrDefault) / 1000, _
                        .Importe = g.Sum(Function(i) CDec( _
                                                         CDec(If(i.TarifaFacturada, 0)) * CDec(If(i.NetoPto, 0)) / 1000 _
                                                        )), _
                        .PV1 = g.Sum(Function(i) IIf(i.PuntoVenta = 1 And i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .PV2 = g.Sum(Function(i) IIf(i.PuntoVenta = 2 And i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .PV3 = g.Sum(Function(i) IIf(i.PuntoVenta = 3 And i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .PV4 = g.Sum(Function(i) IIf(i.PuntoVenta = 4 And i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .TotalEntrega = g.Sum(Function(i) IIf(i.FechaDescarga >= fechadesde And If(Modo, "NO") = "NO", CInt(i.NetoFinal / 1000), 0)), _
                        .TotalExportacion = g.Sum(Function(i) IIf(i.FechaDescarga >= fechadesde And If(Modo, "NO") = "SI", CInt(i.NetoFinal / 1000), 0)), _
                          .TotalBuques = 0, _
                        .Total = g.Sum(Function(i) IIf(i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .Porcent = 0, _
                        .PeriodoAnterior = g.Sum(Function(i) IIf(i.FechaDescarga < fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .Diferen = 0, _
                        .DiferencPorcent = 0 _
                    } _
                ).Where(Function(i) i.Total > 0).ToList

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



        Dim x = q.ToList()

        If ModoExportacion = "Buques" Or ModoExportacion = "Todos" Then


            Dim q2 = LogicaFacturacion.ListaEmbarquesQueryable(SC, fechadesde, fechahasta).ToList
            Dim a = (From i In q2 _
                    Join art In db.linqArticulos On art.IdArticulo Equals i.IdArticulo _
                        Group i By _
                            Producto = art.Descripcion, _
                            Modo = "Buque", _
                            Sucursal = i.IdStock _
                        Into g = Group _
                        Select New With { _
                            .Sucursal = Sucursal.ToString(), _
                            .Modo = Modo, _
                            .Producto = Producto, _
                            .CantCartas = 0, _
                            .NetoPto = CDec(0), _
                            .Merma = CDec(0), _
                            .NetoFinal = CDec(0), _
                            .Importe = CDec(0), _
                            .PV1 = g.Sum(Function(i) IIf(i.IdStock = 1 And i.FechaIngreso >= fechadesde, CInt(i.Cantidad / 1000), 0)), _
                            .PV2 = g.Sum(Function(i) IIf(i.IdStock = 2 And i.FechaIngreso >= fechadesde, CInt(i.Cantidad / 1000), 0)), _
                            .PV3 = g.Sum(Function(i) IIf(i.IdStock = 3 And i.FechaIngreso >= fechadesde, CInt(i.Cantidad / 1000), 0)), _
                            .PV4 = g.Sum(Function(i) IIf(i.IdStock = 4 And i.FechaIngreso >= fechadesde, CInt(i.Cantidad / 1000), 0)), _
                            .TotalEntrega = 0, _
                            .TotalExportacion = 0, _
                            .TotalBuques = CInt(g.Sum(Function(i) If(i.Cantidad, 0) / 1000)), _
                            .Total = g.Sum(Function(i) IIf(i.FechaIngreso >= fechadesde, CInt(i.Cantidad / 1000), 0)), _
                            .Porcent = 0, _
                            .PeriodoAnterior = g.Sum(Function(i) IIf(i.FechaIngreso < fechadesde, CInt(i.Cantidad / 1000), 0)), _
                            .Diferen = 0, _
                            .DiferencPorcent = 0 _
                        }).ToList

            x = x.Union(a).ToList()
        End If


        'http://connect.microsoft.com/VisualStudio/feedback/details/590217/editor-very-slow-when-code-contains-linq-queries

        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////


        For Each i In x
            i.Sucursal = PuntoVentaWilliams.NombrePuntoVentaWilliams2(Val(i.Sucursal))
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








