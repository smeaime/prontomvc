


if OBJECT_ID ('wCartasPorte_WraperDeLaTVF') is not null 
    drop procedure wCartasPorte_LiquidacionSubcontratistas 
go 


create procedure  wCartasPorte_LiquidacionSubcontratistas
   		    @startRowIndex int  = NULL,
            @maximumRows int  = NULL,
            @estado int  = NULL,
            @QueContenga  VARCHAR(50) = NULL,
            @idVendedor int  = NULL,
            @idCorredor int  = NULL,
            @idDestinatario int  = NULL,
            @idIntermediario int  = NULL,
            @idRemComercial int  = NULL,
            @idArticulo int  = NULL,
            @idProcedencia int  = NULL,
            @idDestino int  = NULL,
            @AplicarANDuORalFiltro int  = NULL,
            @ModoExportacion  VARCHAR(20) = NULL,

			@fechadesde datetime,
			@fechahasta datetime,

            @puntoventa int  = NULL, 
            @optDivisionSyngenta  VARCHAR(50) = NULL,
           --@bTraerDuplicados As Boolean = False,
            @Contrato  VARCHAR(50) = NULL, 
            @QueContenga2  VARCHAR(50) = NULL,
            @idClienteAuxiliarint int  = NULL,
            @AgrupadorDeTandaPeriodos int  = NULL,
            @Vagon  int  = NULL,
			@Patente VARCHAR(10) = NULL,
            @optCamionVagon  VARCHAR(10) = NULL

		AS



		declare @IdAcopio int
		select top 1 @IdAcopio=IdAcopio from CartasPorteAcopios   where Descripcion = @optDivisionSyngenta


		SELECT  
		TOP (@maximumRows)  --quizas usando el TOP sin ORDERBY no haya diferencia de performance

		*

    	from dbo.fSQL_GetDataTableFiltradoYPaginado
		( 
							@startRowIndex, 
							@maximumRows, 
							@estado,
							@QueContenga, 
							@idVendedor, 

							@idCorredor, 
							@idDestinatario, 
							@idIntermediario,
							@idRemComercial, 
							@idArticulo,

							@idProcedencia,
							@idDestino,
					
							@AplicarANDuORalFiltro,
							@ModoExportacion,
							@fechadesde,

							@fechahasta, 
							@puntoventa, 
							@IdAcopio,
							@Contrato, 
							@QueContenga2, 

							@idClienteAuxiliarint, 
							@AgrupadorDeTandaPeriodos, 
							@Vagon,
							@Patente, 
							@optCamionVagon

							) as cdp










        Dim aaa = From xz In db.fSQL_GetDataTableFiltradoYPaginado(Nothing, Nothing, Nothing, Nothing, idVendedor,
                                                idCorredor, idDestinatario, idIntermediario, idRemComercial,
                                                idArticulo, idProcedencia, idDestino, AplicarANDuORalFiltro, ModoExportacion,
                                                fechadesde, fechahasta, puntoventa,
                                                Nothing, Nothing, Nothing, Nothing,
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




        Dim qq = From cdp In aaa _
                From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                From clisub1 In db.Clientes.Where(Function(i) i.IdCliente = If(cdp.Subcontr1, dest.Subcontratista1)).DefaultIfEmpty _
                From clisub2 In db.Clientes.Where(Function(i) i.IdCliente = If(cdp.Subcontr2, dest.Subcontratista2)).DefaultIfEmpty _
                From l1 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub1.IdListaPrecios).DefaultIfEmpty _
                From pd1 In db.ListasPreciosDetalles _
                        .Where(Function(i) i.IdListaPrecios = l1.IdListaPrecios And (i.IdArticulo = cdp.IdArticulo) _
                            And (i.IdCliente Is Nothing Or i.IdCliente = cdp.Vendedor Or i.IdCliente = cdp.Entregador Or i.IdCliente = cdp.CuentaOrden1 Or i.IdCliente = cdp.CuentaOrden2)) _
                        .OrderByDescending(Function(i) i.IdCliente).Take(1).DefaultIfEmpty() _
                From l2 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub2.IdListaPrecios).DefaultIfEmpty _
                From pd2 In db.ListasPreciosDetalles _
                        .Where(Function(i) i.IdListaPrecios = l2.IdListaPrecios And (i.IdArticulo = cdp.IdArticulo) _
                               And (i.IdCliente Is Nothing Or i.IdCliente = cdp.Vendedor Or i.IdCliente = cdp.Entregador Or i.IdCliente = cdp.CuentaOrden1 Or i.IdCliente = cdp.CuentaOrden2)) _
                        .OrderByDescending(Function(i) i.IdCliente).Take(1).DefaultIfEmpty() _
                Where 1 = 1 _
                      And (idSubcontr = -1 Or If(cdp.Subcontr1, dest.Subcontratista1) = idSubcontr Or If(cdp.Subcontr2, dest.Subcontratista2) = idSubcontr) _
                      And (puntoventa = -1 Or cdp.PuntoVenta = puntoventa) _
                      And If(cdp.SubnumeroDeFacturacion, 0) <= 0
                Select New asas With { _
                    .NumeroCartaDePorte = cdp.NumeroCartaDePorte, _
                    .IdCartaDePorte = cdp.IdCartaDePorte, _
                    .FechaDescarga = cdp.FechaDescarga, _
                    .NetoFinal = cdp.NetoFinal, _
                    .Subcontr1 = If(cdp.Subcontr1, dest.Subcontratista1), _
                    .Subcontr2 = If(cdp.Subcontr2, dest.Subcontratista2), _
                    .agrupVagon = If(destinosapartados.Contains(cdp.Destino), If(cdp.SubnumeroVagon = 0, "Camiones", "Vagones"), ""), _
                    .ExcluirDeSubcontratistas = cdp.ExcluirDeSubcontratistas, _
                    .SubnumeroDeFacturacion = cdp.SubnumeroDeFacturacion, _
                    .VendedorDesc = cdp.TitularDesc, _
                    .CuentaOrden1Desc = cdp.IntermediarioDesc, _
                    .CuentaOrden2Desc = cdp.RComercialDesc, _
                    .CorredorDesc = cdp.CorredorDesc, _
                    .EntregadorDesc = cdp.EntregadorDesc, _
                    .ProcedenciaDesc = cdp.ProcedenciaDesc, _
                    .DestinoDesc = dest.Descripcion, _
                    .Subcontr1Desc = clisub1.RazonSocial, _
                    .Subcontr2Desc = clisub2.RazonSocial, _
                    .tarif1 = CDec(If(If( _
                    (cdp.Exporta = "SI") _
                        , If(cdp.SubnumeroVagon <= 0 Or Not destinosapartados.Contains(cdp.Destino), _
                                pd1.PrecioCaladaExportacion, pd1.PrecioVagonesCaladaExportacion) _
                        , If(cdp.SubnumeroVagon <= 0 Or Not destinosapartados.Contains(cdp.Destino), _
                                pd1.PrecioCaladaLocal, pd1.PrecioVagonesCalada) _
                        ), 0)), _
                    .tarif2 = CDec(If(If( _
                        (cdp.Exporta = "SI") _
                        , If(cdp.SubnumeroVagon <= 0 Or Not destinosapartados.Contains(cdp.Destino), _
                                If(pd2.PrecioDescargaExportacion = 0, pd2.PrecioCaladaExportacion, pd2.PrecioDescargaExportacion), _
                                If(pd2.PrecioVagonesBalanzaExportacion = 0, pd2.PrecioVagonesCaladaExportacion, pd2.PrecioVagonesBalanzaExportacion) _
                                ) _
                        , If(cdp.SubnumeroVagon <= 0 Or Not destinosapartados.Contains(cdp.Destino), _
                                If(pd2.PrecioDescargaLocal = 0, pd2.PrecioCaladaLocal, pd2.PrecioDescargaLocal), _
                                If(pd2.PrecioVagonesBalanza = 0, pd2.PrecioVagonesCalada, pd2.PrecioVagonesBalanza) _
                                ) _
                                ), 0)), _
                    .Exporta = cdp.Exporta, _
                   .Corredor = cdp.Corredor, _
                    .IdClienteEntregador = cdp.IdClienteEntregador}
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





        If ModoExportacion = "Buques" Then

            Dim q7 = LogicaFacturacion.ListaEmbarquesQueryable(SC, fechadesde, fechahasta).ToList

            Dim ooo = (From cdp As ProntoMVC.Data.Models.CartasPorteMovimiento In q7 _
                       Join dest In db.WilliamsDestinos On dest.IdWilliamsDestino Equals cdp.Puerto _
                    Join art In db.Articulos On art.IdArticulo Equals cdp.IdArticulo _
                    From clisub1 In db.Clientes.Where(Function(i) i.IdCliente = dest.Subcontratista1).DefaultIfEmpty _
                    From clisub2 In db.Clientes.Where(Function(i) i.IdCliente = dest.Subcontratista2).DefaultIfEmpty _
                                    From l1 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub1.IdListaPrecios).DefaultIfEmpty _
                From pd1 In db.ListasPreciosDetalles _
                        .Where(Function(i) i.IdListaPrecios = l1.IdListaPrecios And (i.IdArticulo = cdp.IdArticulo) _
                            And (i.IdCliente Is Nothing Or i.IdCliente = cdp.IdExportadorOrigen)) _
                        .OrderByDescending(Function(i) i.IdCliente).Take(1).DefaultIfEmpty() _
                From l2 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub2.IdListaPrecios).DefaultIfEmpty _
                From pd2 In db.ListasPreciosDetalles _
                        .Where(Function(i) i.IdListaPrecios = l2.IdListaPrecios And (i.IdArticulo = cdp.IdArticulo) _
                               And (i.IdCliente Is Nothing Or i.IdCliente = cdp.IdExportadorOrigen)) _
                        .OrderByDescending(Function(i) i.IdCliente).Take(1).DefaultIfEmpty() _
            Select New asas With { _
                   .NumeroCartaDePorte = cdp.NumeroCDPMovimiento, _
                 .IdCartaDePorte = cdp.IdCartaDePorte, _
                   .FechaDescarga = cdp.FechaIngreso, _
                  .NetoFinal = cdp.Cantidad, _
                    .Subcontr1 = dest.Subcontratista1, _
                    .Subcontr2 = dest.Subcontratista2, _
                    .agrupVagon = "Buques", _
                    .ExcluirDeSubcontratistas = "NO", _
                    .SubnumeroDeFacturacion = 0, _
                    .VendedorDesc = cdp.IdExportadorOrigen, _
                    .CuentaOrden1Desc = cdp.IdExportadorOrigen, _
                    .CuentaOrden2Desc = "", _
                    .CorredorDesc = "", _
                    .EntregadorDesc = cdp.IdExportadorOrigen, _
                    .ProcedenciaDesc = cdp.IdExportadorOrigen, _
                    .DestinoDesc = dest.Descripcion, _
                    .Subcontr1Desc = clisub1.RazonSocial, _
                    .Subcontr2Desc = clisub2.RazonSocial, _
                    .tarif1 = pd1.PrecioBuquesCalada, _
                    .tarif2 = pd2.PrecioBuquesCalada, _
                    .Exporta = "SI", _
                    .Corredor = cdp.IdExportadorOrigen, _
                    .IdClienteEntregador = cdp.IdExportadorOrigen})



            qq = qq.Union(ooo).ToList()

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





        If Debugger.IsAttached Or True Then
            q.ToList()

            Dim a = From x In q Order By x.FechaDescarga, x.IdCartaDePorte Select SqlFunctions.StringConvert(x.NumeroCartaDePorte) & " " & SqlFunctions.StringConvert(x.IdCartaDePorte) & " " & x.tarif1 & " " & x.tarif2 ' & " " & x.IdListaPreciosDetalle1 & " " & x.IdListaPreciosDetalle2

            ErrHandler2.WriteError(vbCrLf & Join(a.ToArray, vbCrLf))
        End If












        Dim q4 As List(Of infLiqui) = (From cdp In q _
                    Where (idSubcontr = -1 Or cdp.Subcontr1 = idSubcontr) _
                    Select New infLiqui With { _
                        .agrupVagon = cdp.agrupVagon, _
                        .DestinoDesc = cdp.DestinoDesc & " Calada" & If( _
                            (cdp.Exporta = "SI") _
                                   , " - Export.", " - Entrega"), _
                        .SubcontrDesc = cdp.Subcontr1Desc, _
                        .NetoPto = cdp.NetoFinal, _
                        .Tarifa = cdp.tarif1, _
                        .Comision = cdp.NetoFinal * cdp.tarif1 / 1000, _
                        .numerocarta = cdp.NumeroCartaDePorte _
                }).ToList


        Dim q5 As List(Of infLiqui) = (From cdp In q _
                   Where (idSubcontr = -1 Or cdp.Subcontr2 = idSubcontr) _
                    Select New infLiqui With { _
                        .agrupVagon = cdp.agrupVagon, _
                        .DestinoDesc = cdp.DestinoDesc & " Balanza" & If( _
                                      (cdp.Exporta = "SI") _
                                    , " - Export.", " - Entrega"), _
                        .SubcontrDesc = cdp.Subcontr2Desc, _
                        .NetoPto = cdp.NetoFinal, _
                        .Tarifa = cdp.tarif2, _
                        .Comision = cdp.NetoFinal * cdp.tarif2 / 1000, _
                        .numerocarta = cdp.NumeroCartaDePorte _
                }).ToList


        Dim q6 As New List(Of infLiqui) '= q4.Union(q5)
        q6.AddRange(q4)
        q6.AddRange(q5)



        Dim q3 = From i In q6 _
                Group i By agrupVagon = i.agrupVagon, DestinoDesc = i.DestinoDesc, SubcontrDesc = i.SubcontrDesc, Tarifa = i.Tarifa Into g = Group _
                Select agrupVagon = agrupVagon, DestinoDesc = DestinoDesc, SubcontrDesc = SubcontrDesc, Tarifa = Tarifa, _
                NetoPto = g.Sum(Function(i) i.NetoPto), Comision = g.Sum(Function(i) i.Comision), CantCartas = g.Count, _
                numeros = vbCrLf + vbCrLf + vbCrLf + String.Join(vbCrLf, g.Select(Function(i) i.numerocarta.ToString).ToList)
        'le meto esos vbCrLf para que no se vean los primeros renglones y así no me modifique automaticamente el ancho de la columna "oculta"

        ErrHandler2.WriteError("     Excluidas por nofacturarasubcontratistas o duplicadas: " & filtr)


        Return q3.ToList





go




wCartasPorte_WraperDeLaTVF 
					NULL, 
					100, 
					NULL,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL, --@idArticulo,

					NULL, --@idProcedencia,
					NULL,---1, --@idDestino,
					0, --@AplicarANDuORalFiltro,
					'Ambos', --'Buques',
					'2016-08-03 00:00:00',
					
					'2016-30-03 00:00:00',
					NULL, 
					NULL,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL

go



GRANT EXECUTE ON wCartasPorte_WraperDeLaTVF to [NT AUTHORITY\ANONYMOUS LOGON]
go



exec wCartasPorte_WraperDeLaTVF @startRowIndex=NULL,@fechadesde='2000-01-01 00:00:00',@maximumRows=100,@fechahasta='2100-01-01 00:00:00'
,@estado=NULL,@idDestino=-1,@QueContenga=NULL,@idVendedor=NULL,@idCorredor=NULL,@idDestinatario=NULL,
@idIntermediario=NULL,@idRemComercial=NULL,@idArticulo=NULL,@idProcedencia=NULL,@AplicarANDuORalFiltro=NULL,@ModoExportacion='Ambos',
@puntoventa=0,
@optDivisionSyngenta=NULL,@Contrato=NULL,@QueContenga2=NULL,@idClienteAuxiliarint=NULL,@AgrupadorDeTandaPeriodos=NULL,@Vagon=NULL,
@Patente=NULL,@optCamionVagon=NULL
go


exec wCartasPorte_WraperDeLaTVF @startRowIndex=NULL,@fechadesde='2015-01-01 00:00:00',@maximumRows=40,@fechahasta='2016-01-01 00:00:00',
@estado=4,@idDestino=-1,@QueContenga=NULL,@idVendedor=-1,@idCorredor=-1,@idDestinatario=-1,
@idIntermediario=-1,@idRemComercial=-1,@idArticulo=-1,@idProcedencia=-1,@AplicarANDuORalFiltro=0,@ModoExportacion=N'Ambos',
@puntoventa=-1,@optDivisionSyngenta=N'Ambas',@Contrato=NULL,@QueContenga2=N'-1',@idClienteAuxiliarint=-1,
@AgrupadorDeTandaPeriodos=NULL,@Vagon=NULL,@Patente=NULL,@optCamionVagon=N'Todos'
go


exec wCartasPorte_WraperDeLaTVF @startRowIndex=0,@fechadesde='2016-01-01 00:00:00',@maximumRows=40,@fechahasta='2016-01-01 00:00:00',@estado=4,@idDestino=-1,@QueContenga=N'0',
@idVendedor=-1,@idCorredor=-1,@idDestinatario=-1,@idIntermediario=-1,@idRemComercial=-1,@idArticulo=-1,@idProcedencia=-1,@AplicarANDuORalFiltro=0,@ModoExportacion=N'Ambas',@puntoventa=-1,@optDivisionSyngenta=N'Ambas',@Contrato=N'-1',@QueContenga2=N'-1',@idClienteAuxiliarint=-1,@AgrupadorDeTandaPeriodos=-1,@Vagon=0,@Patente=N'',@optCamionVagon=N'Todos'



exec wCartasPorte_WraperDeLaTVF @startRowIndex=0,@fechadesde='2016-01-10 00:00:00',@maximumRows=3000,
@fechahasta='2016-31-10 00:00:00',@estado=4,@idDestino=-1,@QueContenga=N'0',@idVendedor=6762,@idCorredor=-1,
@idDestinatario=-1,@idIntermediario=6762,@idRemComercial=6762,@idArticulo=-1,@idProcedencia=-1,@AplicarANDuORalFiltro=0,
@ModoExportacion=N'Entregas',@puntoventa=-1,@optDivisionSyngenta=N'BANDERA',@Contrato=N'-1',@QueContenga2=N'-1',
@idClienteAuxiliarint=6762,@AgrupadorDeTandaPeriodos=-1,@Vagon=0,@Patente=N'',@optCamionVagon=N'Todos'



