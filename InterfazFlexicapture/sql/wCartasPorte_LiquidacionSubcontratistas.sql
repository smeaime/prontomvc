


if OBJECT_ID ('wCartasPorte_LiquidacionSubcontratistas') is not null 
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
            @optCamionVagon  VARCHAR(10) = NULL,
            @idSubcontr int  = NULL

		AS



		declare @IdAcopio int
		select top 1 @IdAcopio=IdAcopio from CartasPorteAcopios   where Descripcion = @optDivisionSyngenta





		SELECT
			CONS2.agrupvagon,
			
			case 
				when Subcontr1 = @idSubcontr then
					 CONS2.DestinoDesc + ' Calada'  + case when Exporta ='SI'  THEN  ' - Export.' ELSE ' - Entrega' end 
				
				when Subcontr2	= @idSubcontr 	then
                     CONS2.DestinoDesc + ' Balanza' + case when Exporta ='SI'  THEN  ' - Export.' ELSE ' - Entrega' end 
				else 
					' ' + STR(Subcontr1) + ' ' + STR(Subcontr2)

			end as DestinoDesc
			
			, CONS2.NetoFinal,

			case 
				when Subcontr1 = @idSubcontr then
					CONS2.tarif1
				
				when Subcontr2	= @idSubcontr 	then
                     CONS2.tarif2

			end as Tarifa
			
			
			, CONS2.NumeroCartaDePorte
            , 
			
			case 
				when Subcontr1 = @idSubcontr then
					(CONS2.NetoFinal * CONS2.tarif1 / 1000) 
				
				when Subcontr2	= @idSubcontr 	then
                    (CONS2.NetoFinal * CONS2.tarif2 / 1000) 

			end as Comision
			
		
         
		from
		(

		SELECT  
		     CONS.IdCartaDePorte, 
			        NumeroCartaDePorte, 
                    FechaDescarga, 
                    agrupVagon, 
                    NetoFinal, 
                    Subcontr1, 
                    Subcontr2, 
                    ExcluirDeSubcontratistas, 
                    SubnumeroDeFacturacion, 
					TitularDesc, 
                    IntermediarioDesc, 
                    RComercialDesc, 
					CorredorDesc, 
                    EntregadorDesc, 
                    ProcedenciaDesc, 
                    DestinoDesc, 
                    Subcontr1Desc, 
                    Subcontr2Desc, 
                    Exporta,
                    Max( CONS.tarif1) as tarif1, 
                    Max( CONS.tarif2) as tarif2, 
                     CONS.Corredor, 
                     CONS.IdClienteEntregador
		FROM 
		(








											SELECT  
											--TOP (@maximumRows)  --quizas usando el TOP sin ORDERBY no haya diferencia de performance

														cdp.NumeroCartaDePorte, 
														cdp.IdCartaDePorte, 
														cdp.FechaDescarga, 
														cdp.NetoFinal, 
														cdp.Subcontr1, --If(cdp.Subcontr1, dest.Subcontratista1), 
														cdp.Subcontr2, --If(cdp.Subcontr2, dest.Subcontratista2), 
														--If(destinosapartados.Contains(cdp.Destino), If(cdp.SubnumeroVagon = 0, "Camiones", "Vagones"), "") as  agrupVagon,
														case when cdp.SubnumeroVagon =0  THEN 'Camiones' ELSE  'Vagones' end  as  agrupVagon,
														cdp.ExcluirDeSubcontratistas, 
														cdp.SubnumeroDeFacturacion, 
														cdp.TitularDesc, 
														cdp.IntermediarioDesc, 
														cdp.RComercialDesc, 
														cdp.CorredorDesc, 
														cdp.EntregadorDesc, 
														cdp.ProcedenciaDesc, 
														dest.Descripcion as DestinoDesc, 
														clisub1.RazonSocial as Subcontr1Desc, 
														clisub2.RazonSocial as Subcontr2Desc,
                    
														case when cdp.Exporta='SI'
															then					  

																case when  (cdp.SubnumeroVagon <= 0) -- Or Not destinosapartados.Contains(cdp.Destino))
																	then pd1.PrecioCaladaExportacion 
																	else pd1.PrecioVagonesCaladaExportacion
																end

															else

																case when  (cdp.SubnumeroVagon <= 0) -- Or Not destinosapartados.Contains(cdp.Destino))
																	then pd1.PrecioCaladaLocal 
																	else pd1.PrecioVagonesCalada
																end

														end as tarif1, 

   
														case when cdp.Exporta='SI'
															then					  

																case when  (cdp.SubnumeroVagon <= 0) -- Or Not destinosapartados.Contains(cdp.Destino))
																	then 
																		case when  (pd2.PrecioDescargaExportacion = 0) -- Or Not destinosapartados.Contains(cdp.Destino))
																			then pd2.PrecioCaladaExportacion 
																			else pd2.PrecioDescargaExportacion
																		end
																	else 
																		case when  (pd2.PrecioVagonesBalanzaExportacion = 0) -- Or Not destinosapartados.Contains(cdp.Destino))
																			then pd2.PrecioVagonesCaladaExportacion 
																			else pd2.PrecioVagonesBalanzaExportacion
																		end
																end	

															else

																case when  (cdp.SubnumeroVagon <= 0) -- Or Not destinosapartados.Contains(cdp.Destino))
																	then 
																		case when  (pd2.PrecioDescargaLocal = 0) -- Or Not destinosapartados.Contains(cdp.Destino))
																			then pd2.PrecioCaladaLocal 
																			else pd2.PrecioDescargaLocal
																		end
																	else 
																		case when  (pd2.PrecioVagonesBalanza = 0) -- Or Not destinosapartados.Contains(cdp.Destino))
																			then pd2.PrecioVagonesCalada 
																			else pd2.PrecioVagonesBalanza
																		end

																end

														end as tarif2, 
       
       
													   cdp.Exporta, 
													   cdp.Corredor, 
													   cdp.IdClienteEntregador

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
																'TRUE',
																@Contrato, 
																@QueContenga2, 

																@idClienteAuxiliarint, 
																@AgrupadorDeTandaPeriodos, 
																@Vagon,
																@Patente, 
																@optCamionVagon

																) as cdp






													left join WilliamsDestinos dest on dest.IdWilliamsDestino = cdp.Destino
													left join Clientes clisub1 on  clisub1.IdCliente = cdp.Subcontr1 --, dest.Subcontratista1
													left join Clientes clisub2 on  clisub2.IdCliente = cdp.Subcontr2 --, dest.Subcontratista2
													left join ListasPrecios l1 on  l1.IdListaPrecios = clisub1.IdListaPrecios
													left join   ListasPreciosDetalle pd1     on  pd1.IdListaPrecios = l1.IdListaPrecios  
																				and  pd1.IdArticulo = cdp.IdArticulo
																		 And (pd1.IdCliente Is null Or pd1.IdCliente = cdp.Vendedor Or 
																		 pd1.IdCliente = cdp.Entregador Or pd1.IdCliente = cdp.CuentaOrden1 Or 
																		 pd1.IdCliente = cdp.CuentaOrden2)
														  --.OrderByDescending(Function(i) i.IdCliente).Take(1).DefaultIfEmpty() 
													left join ListasPrecios l2       on  l2.IdListaPrecios = clisub2.IdListaPrecios
													left join ListasPreciosDetalle pd2  on  pd2.IdListaPrecios = l2.IdListaPrecios     
																		and  pd2.IdArticulo = cdp.IdArticulo
													--               And (i.IdCliente Is Nothing Or i.IdCliente = cdp.Vendedor Or i.IdCliente = cdp.Entregador Or i.IdCliente = cdp.CuentaOrden1 Or i.IdCliente = cdp.CuentaOrden2)) 
													--        .OrderByDescending(Function(i) i.IdCliente).Take(1).DefaultIfEmpty() 
													Where 1 = 1 
														  And (	
																ISNULL(@idSubcontr,-1) = -1 
																Or ISNULL(cdp.Subcontr1, dest.Subcontratista1) = @idSubcontr 
																Or ISNULL(cdp.Subcontr2, dest.Subcontratista2) = @idSubcontr
															) 
														  And (ISNULL(@puntoventa,-1) = -1 Or cdp.PuntoVenta = @puntoventa) 
														 

												) as CONS








													Group By 
														IdCartaDePorte, 
														NumeroCartaDePorte, 
														FechaDescarga, 
														agrupVagon, 
														NetoFinal, 
														Subcontr1, 
														Subcontr2, 
														ExcluirDeSubcontratistas, 
														SubnumeroDeFacturacion, 
														TitularDesc, 
														IntermediarioDesc, 
														RComercialDesc, 
														CorredorDesc, 
														EntregadorDesc, 
														ProcedenciaDesc, 
														DestinoDesc, 
														Subcontr1Desc, 
														Subcontr2Desc, 
														Exporta, 
														Corredor, 
														IdClienteEntregador
               
		) as CONS2
			   
		order by NumeroCartaDePorte




		/*


        If ModoExportacion = "Buques" Then

            Dim q7 = LogicaFacturacion.ListaEmbarquesQueryable(SC, fechadesde, fechahasta).ToList

			        Dim embarques = From i In db.CartasPorteMovimientos 
                        Join c In db.Clientes On c.IdCliente Equals i.IdExportadorOrigen 
                          Where ( 
                                i.Tipo = 4 
                                And If(i.Anulada, "NO") <> "SI" 
                                And i.FechaIngreso >= FechaDesde And i.FechaIngreso <= FechaHasta 
                                And (i.IdExportadorOrigen = idTitular Or idTitular = -1) 
                                And (i.IdStock Is Nothing Or i.IdStock = pventa Or i.IdStock = 0 Or pventa = 0) 
                                And (idQueContenga = -1 Or i.IdExportadorOrigen = idQueContenga Or i.IdExportadorDestino = idQueContenga) 
                           ) 
                        Select i




            Dim ooo = (From cdp As ProntoMVC.Data.Models.CartasPorteMovimiento In q7 
                       Join dest In db.WilliamsDestinos On dest.IdWilliamsDestino Equals cdp.Puerto 
                    Join art In db.Articulos On art.IdArticulo Equals cdp.IdArticulo 
                    From clisub1 In db.Clientes.Where(Function(i) i.IdCliente = dest.Subcontratista1).DefaultIfEmpty 
                    From clisub2 In db.Clientes.Where(Function(i) i.IdCliente = dest.Subcontratista2).DefaultIfEmpty 
                                    From l1 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub1.IdListaPrecios).DefaultIfEmpty 
                From pd1 In db.ListasPreciosDetalles 
                        .Where(Function(i) i.IdListaPrecios = l1.IdListaPrecios And (i.IdArticulo = cdp.IdArticulo) 
                            And (i.IdCliente Is Nothing Or i.IdCliente = cdp.IdExportadorOrigen)) 
                        .OrderByDescending(Function(i) i.IdCliente).Take(1).DefaultIfEmpty() 
                From l2 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub2.IdListaPrecios).DefaultIfEmpty 
                From pd2 In db.ListasPreciosDetalles 
                        .Where(Function(i) i.IdListaPrecios = l2.IdListaPrecios And (i.IdArticulo = cdp.IdArticulo) 
                               And (i.IdCliente Is Nothing Or i.IdCliente = cdp.IdExportadorOrigen)) 
                        .OrderByDescending(Function(i) i.IdCliente).Take(1).DefaultIfEmpty() 
            Select New asas With { 
                   .NumeroCartaDePorte = cdp.NumeroCDPMovimiento, 
                 .IdCartaDePorte = cdp.IdCartaDePorte, 
                   .FechaDescarga = cdp.FechaIngreso, 
                  .NetoFinal = cdp.Cantidad, 
                    .Subcontr1 = dest.Subcontratista1, 
                    .Subcontr2 = dest.Subcontratista2, 
                    .agrupVagon = "Buques", 
                    .ExcluirDeSubcontratistas = "NO", 
                    .SubnumeroDeFacturacion = 0, 
                    .VendedorDesc = cdp.IdExportadorOrigen, 
                    .CuentaOrden1Desc = cdp.IdExportadorOrigen, 
                    .CuentaOrden2Desc = "", 
                    .CorredorDesc = "", 
                    .EntregadorDesc = cdp.IdExportadorOrigen, 
                    .ProcedenciaDesc = cdp.IdExportadorOrigen, 
                    .DestinoDesc = dest.Descripcion, 
                    .Subcontr1Desc = clisub1.RazonSocial, 
                    .Subcontr2Desc = clisub2.RazonSocial, 
                    .tarif1 = pd1.PrecioBuquesCalada, 
                    .tarif2 = pd2.PrecioBuquesCalada, 
                    .Exporta = "SI", 
                    .Corredor = cdp.IdExportadorOrigen, 
                    .IdClienteEntregador = cdp.IdExportadorOrigen})



            qq = qq.Union(ooo).ToList()

        End If







        Dim q = From i In aa 
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







        Dim q4 As List(Of infLiqui) = (From cdp In q 
                    Where (idSubcontr = -1 Or cdp.Subcontr1 = idSubcontr) 
                    Select New infLiqui With { 
                        .agrupVagon = cdp.agrupVagon, 
                        .DestinoDesc = cdp.DestinoDesc & " Calada" & If( 
                            (cdp.Exporta = "SI") 
                                   , " - Export.", " - Entrega"), 
                        .SubcontrDesc = cdp.Subcontr1Desc, 
                        .NetoPto = cdp.NetoFinal, 
                        .Tarifa = cdp.tarif1, 
                        .Comision = cdp.NetoFinal * cdp.tarif1 / 1000, 
                        .numerocarta = cdp.NumeroCartaDePorte 
                }).ToList


        Dim q5 As List(Of infLiqui) = (From cdp In q 
                   Where (idSubcontr = -1 Or cdp.Subcontr2 = idSubcontr) 
                    Select New infLiqui With { 
                        .agrupVagon = cdp.agrupVagon, 
                        .DestinoDesc = cdp.DestinoDesc & " Balanza" & If( 
                                      (cdp.Exporta = "SI") 
                                    , " - Export.", " - Entrega"), 
                        .SubcontrDesc = cdp.Subcontr2Desc, 
                        .NetoPto = cdp.NetoFinal, 
                        .Tarifa = cdp.tarif2, 
                        .Comision = cdp.NetoFinal * cdp.tarif2 / 1000, 
                        .numerocarta = cdp.NumeroCartaDePorte 
                }).ToList


        Dim q6 As New List(Of infLiqui) '= q4.Union(q5)
        q6.AddRange(q4)
        q6.AddRange(q5)



        Dim q3 = From i In q6 
                Group i By agrupVagon = i.agrupVagon, DestinoDesc = i.DestinoDesc, SubcontrDesc = i.SubcontrDesc, Tarifa = i.Tarifa Into g = Group 
                Select agrupVagon = agrupVagon, DestinoDesc = DestinoDesc, SubcontrDesc = SubcontrDesc, Tarifa = Tarifa, 
                NetoPto = g.Sum(Function(i) i.NetoPto), Comision = g.Sum(Function(i) i.Comision), CantCartas = g.Count, 
                numeros = vbCrLf + vbCrLf + vbCrLf + String.Join(vbCrLf, g.Select(Function(i) i.numerocarta.ToString).ToList)
        'le meto esos vbCrLf para que no se vean los primeros renglones y así no me modifique automaticamente el ancho de la columna "oculta"

        ErrHandler2.WriteError("     Excluidas por nofacturarasubcontratistas o duplicadas: " & filtr)


        Return q3.ToList

*/



go




 --@startRowIndex int  = NULL,
 --           @maximumRows int  = NULL,
 --           @estado int  = NULL,
 --           @QueContenga  VARCHAR(50) = NULL,
 --           @idVendedor int  = NULL,
 --           @idCorredor int  = NULL,
 --           @idDestinatario int  = NULL,
 --           @idIntermediario int  = NULL,
 --           @idRemComercial int  = NULL,
 --           @idArticulo int  = NULL,
 --           @idProcedencia int  = NULL,
 --           @idDestino int  = NULL,
 --           @AplicarANDuORalFiltro int  = NULL,
 --           @ModoExportacion  VARCHAR(20) = NULL,

	--		@fechadesde datetime,
	--		@fechahasta datetime,

 --           @puntoventa int  = NULL, 
 --           @optDivisionSyngenta  VARCHAR(50) = NULL,
 --           @Contrato  VARCHAR(50) = NULL, 
 --           @QueContenga2  VARCHAR(50) = NULL,
 --           @idClienteAuxiliarint int  = NULL,
           
	--	    @AgrupadorDeTandaPeriodos int  = NULL,
 --           @Vagon  int  = NULL,
	--		@Patente VARCHAR(10) = NULL,
 --           @optCamionVagon  VARCHAR(10) = NULL,
 --           @idSubcontr int  = NULL



wCartasPorte_LiquidacionSubcontratistas 
					NULL, 
					100000, 
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
					'2016-01-12 00:00:00',
					
					'2016-31-12 00:00:00',
			
					NULL, 
					NULL,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL,
					NULL,
					6319

go




GRANT EXECUTE ON wCartasPorte_LiquidacionSubcontratistas to [NT AUTHORITY\ANONYMOUS LOGON]
go



select subcontr1,subcontr2,* from cartasdeporte where numerocartadeporte=557251815

EXEC sp_recompile 'dbo.fSQL_GetDataTableFiltradoYPaginado'
