



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_ResumenDeTotalesEstadisticas]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wCartasDePorte_TX_ResumenDeTotalesEstadisticas]
go



CREATE PROCEDURE [dbo].[wCartasDePorte_TX_ResumenDeTotalesEstadisticas]

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


            @fechadesdeAnterior As DateTime= NULL,
			@fechahastaAnterior As DateTime= NULL

AS



select 
		*
, sum (Elevacion)  OVER () as TotalElevacion
, sum (Entrega)  OVER () as TotalEntrega
, sum (Buques)  OVER () as TotalBuques
, sum (FacElevacion)  OVER () as FacTotalElevacion
, sum (FacEntrega)  OVER () as FacTotalEntrega
, sum (FacBuques)  OVER () as FacTotalBuques

from
(
select 

sucursal,


sum(
				case when Modo='SI'
				then NetoFinal
				else 0 	end
			   ) as Elevacion,
sum(
				case when Modo='NO'
				then NetoFinal
				else 0 	end
			   ) as Entrega,
sum(
				case when Modo='Buque'
				then NetoFinal
				else 0 	end
			   ) as Buques,

sum(
				case when Modo='NO'
				then PeriodoAnterior  
				else 0 	end
			   ) as PeriodoAnteriorEntrega,

sum(
				case when Modo='SI'
				then PeriodoAnterior  
				else 0 	end
			   ) as PeriodoAnteriorElevacion,

sum(
				case when Modo='Buque'
				then PeriodoAnterior  
				else 0 	end
			   ) as PeriodoAnteriorBuques,



			   sum(
				case when Modo='SI'
				then Facturado
				else 0 	end
			   ) as FacElevacion,
sum(
				case when Modo='NO'
				then Facturado
				else 0 	end
			   ) as FacEntrega,
sum(
				case when Modo='Buque'
				then Facturado
				else 0 	end
			   ) as FacBuques,

sum(
				case when Modo='NO'
				then FacturadoAnterior  
				else 0 	end
			   ) as FacPeriodoAnteriorEntrega,

sum(
				case when Modo='SI'
				then FacturadoAnterior  
				else 0 	end
			   ) as FacPeriodoAnteriorElevacion,

sum(
				case when Modo='Buque'
				then FacturadoAnterior  
				else 0 	end
			   ) as FacPeriodoAnteriorBuques






from
(

select

                   cdp.puntoventa as Sucursal,
			Exporta as Modo,
			Count(*) as CantCartas,
			sum(
				case when FechaDescarga between @FechaDesde and @FechaHasta
				then NetoFinal/1000
				else 0 	end
			   ) as NetoFinal,
			sum(
				case when FechaDescarga between @FechaDesdeAnterior and @FechaHastaAnterior  
				then NetoFinal/1000
				else 0 	end
			   ) as PeriodoAnterior  ,
			   
			
			  sum(
				case when FechaDescarga between @FechaDesde and @FechaHasta
				then DETFAC.PrecioUnitario * NetoFinal / 1000
				else 0 	end
			   ) 
			    as Facturado,
			
			
			  sum(
				case when FechaDescarga between @FechaDesdeAnterior and @FechaHastaAnterior  
				then DETFAC.PrecioUnitario * NetoFinal / 1000
				else 0 	end
			   ) 
			    as FacturadoAnterior
			


from 
 dbo.fSQL_GetDataTableFiltradoYPaginado  
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
				
							@FechaDesdeAnterior,

							@FechaHasta,
				
							@puntoventa, 
							NULL,
							 'FALSE',--duplicados?
							@Contrato, 

							@QueContenga2, 
							@idClienteAuxiliarint, 
							@AgrupadorDeTandaPeriodos, 
							@Vagon,
							@Patente, 

							@optCamionVagon
					)
    
 as CDP

left join detallefacturas DETFAC on CDP.IdDetalleFactura=DETFAC.IdDetalleFactura

 Group by  cdp.PuntoVenta,cdp.exporta




union 

select 


                   IdStock as Sucursal,
			'Buque' as Modo,
			Count(*) as CantCartas,
			sum(
				case when i.FechaIngreso >= @FechaDesde
				then i.cantidad /1000
				else 0 	end
			   ) as NetoFinal,
			sum(
				case when i.FechaIngreso <= @FechaHastaAnterior 
				then i.cantidad /1000
				else 0 	end
			   ) as PeriodoAnterior           ,

			  sum(
				case when i.FechaIngreso >= @FechaDesde
				then DETFAC.PrecioUnitario * i.cantidad / 1000
				else 0 	end
			   ) 
			       as Facturado,
			   
			  sum(
				case when i.FechaIngreso <= @FechaHastaAnterior 
				then DETFAC.PrecioUnitario * i.cantidad / 1000
				else 0 	end
			   ) 
			    as FacturadoAnterior
			         
			

From CartasPorteMovimientos i

left join detallefacturas DETFAC on i.IdDetalleFactura=DETFAC.IdDetalleFactura


Where (
                                i.Tipo = 4 
                                And isnull(i.Anulada, 'NO') <> 'SI' 
								And (isnull(@puntoventa,0)<=0  OR  @puntoventa=IdStock)
	--And i.FechaIngreso >= @FechaDesdeAnterior And i.FechaIngreso <= @FechaHasta 
	and ((i.FechaIngreso >= @FechaDesde and i.FechaIngreso <= @FechaHasta) or (i.FechaIngreso >= @FechaDesdeAnterior and i.FechaIngreso <=@FechaHastaAnterior))
                           )



 

 Group by  IdStock

) as Q

where sucursal >0
group by sucursal

) as Q2


go




IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_DetalleDeTotalesEstadisticas]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wCartasDePorte_TX_DetalleDeTotalesEstadisticas]
go



CREATE PROCEDURE [dbo].[wCartasDePorte_TX_DetalleDeTotalesEstadisticas]

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


            @fechadesdeAnterior As DateTime= NULL,
			@fechahastaAnterior As DateTime= NULL

AS




select *
from 
(
select



month(FechaDescarga) as  mes  , 
year(FechaDescarga) as a�o, 
            cdp.puntoventa as Sucursal,
			Exporta as Modo,
			Count(*) as CantCartas,
			sum(
				case when FechaDescarga between @FechaDesde and @FechaHasta
				then NetoFinal/1000
				else 0 	end
			   ) as NetoFinal,
			sum(
				case when FechaDescarga between @FechaDesdeAnterior and @FechaHastaAnterior  
				then NetoFinal/1000
				else 0 	end
			   ) as PeriodoAnterior  ,
			   
			
			  sum(
				case when FechaDescarga between @FechaDesde and @FechaHasta
				then DETFAC.PrecioUnitario * NetoFinal / 1000
				else 0 	end
			   ) 
			    as Facturado,
			

			
			  sum(
				case when FechaDescarga between @FechaDesdeAnterior and @FechaHastaAnterior  
				then DETFAC.PrecioUnitario * NetoFinal / 1000
				else 0 	end
			   ) 
			    as FacturadoAnterior
			

from 
 dbo.fSQL_GetDataTableFiltradoYPaginado  
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
				
							@FechaDesdeAnterior,

							@FechaHasta,
				
							@puntoventa, 
							NULL,
							 'FALSE',--duplicados?
							@Contrato, 

							@QueContenga2, 
							@idClienteAuxiliarint, 
							@AgrupadorDeTandaPeriodos, 
							@Vagon,
							@Patente, 

							@optCamionVagon
					)
    
 as CDP

left join detallefacturas DETFAC on CDP.IdDetalleFactura=DETFAC.IdDetalleFactura
where 
	(FechaDescarga between @FechaDesde and @FechaHasta) or 
	(FechaDescarga between @FechaDesdeAnterior and @FechaHastaAnterior)



 Group by  cdp.PuntoVenta,cdp.exporta

,month(FechaDescarga)  , 
year(FechaDescarga) 



union 

select 


month(FechaIngreso) as  mes  , 
year(FechaIngreso) as a�o, 
                   IdStock as Sucursal,
			'Buque' as Modo,
			Count(*) as CantCartas,
			sum(
				case when i.FechaIngreso >= @FechaDesde
				then i.cantidad /1000
				else 0 	end
			   ) as NetoFinal,
			sum(
				case when i.FechaIngreso <= @FechaHastaAnterior 
				then i.cantidad /1000
				else 0 	end
			   ) as PeriodoAnterior           ,

			
			  sum(
				case when i.FechaIngreso >= @FechaDesde
				then DETFAC.PrecioUnitario * i.cantidad / 1000
				else 0 	end
			   ) 
			       as Facturado,
			   
			  sum(
				case when i.FechaIngreso <= @FechaHastaAnterior 
				then DETFAC.PrecioUnitario * i.cantidad / 1000
				else 0 	end
			   ) 
			    as FacturadoAnterior
			
			
From CartasPorteMovimientos i

left join detallefacturas DETFAC on i.IdDetalleFactura=DETFAC.IdDetalleFactura


Where (
                                i.Tipo = 4 
                                And isnull(i.Anulada, 'NO') <> 'SI' 
    							And (isnull(@puntoventa,0)<=0  OR  @puntoventa=IdStock)
	--and ((i.FechaIngreso between @FechaDesde and @FechaHasta) or (i.FechaIngreso between @FechaDesdeAnterior and @FechaHastaAnterior))
	and ((i.FechaIngreso >= @FechaDesde and i.FechaIngreso <= @FechaHasta) or (i.FechaIngreso >= @FechaDesdeAnterior and i.FechaIngreso <=@FechaHastaAnterior))
	--And (i.FechaIngreso >= @FechaDesdeAnterior And i.FechaIngreso <= @FechaHasta) 
	
)

 

 Group by  IdStock
 
,month(FechaIngreso) , 
year(FechaIngreso)

) as Q

order by a�o, mes




go





--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





declare @FechaDesde datetime
declare @FechaHasta datetime
declare @FechaDesdeAnterior datetime
declare @FechaHastaAnterior datetime
set @FechaDesdeAnterior ='20160601'
set @FechaHastaAnterior='20160731'
set @FechaDesde='20170601'
set @FechaHasta='20170731'







exec [wCartasDePorte_TX_DetalleDeTotalesEstadisticas] 
					NULL, 
					NULL, 
					4,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL, ---1, --@idArticulo,

					NULL, --@idProcedencia,
					NULL, ---1,---1, --@idDestino,
					NULL, --@AplicarANDuORalFiltro,
					NULL, --'Export', --'Entregas', --'Ambos', --'Buques',
						
					
@FechaDesde, @FechaHasta,


					NULL, 
					NULL,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL

,@FechaDesdeAnterior , @FechaHastaAnterior












exec [wCartasDePorte_TX_ResumenDeTotalesEstadisticas] 
					NULL, 
					NULL, 
					4,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL, --@idArticulo,

					NULL, --@idProcedencia,
					NULL,---1, --@idDestino,
					NULL, --@AplicarANDuORalFiltro,
					NULL, --  'Export', --'Entregas', --'Ambos', --'Buques',
						
					
@FechaDesde, @FechaHasta,


					NULL, 
					NULL,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL

,@FechaDesdeAnterior , @FechaHastaAnterior












/*

exec [wCartasDePorte_TX_EstadisticasDeDescarga] 
					NULL, 
					NULL, 
					4,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					-1, --@idArticulo,

					NULL, --@idProcedencia,
					-1,---1, --@idDestino,
					NULL, --@AplicarANDuORalFiltro,
					'Entregas', --'Ambos', --'Buques',
					
					
				@FechaDesde, @FechaHasta,
					
					NULL, 
					NULL,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL

,@FechaDesdeAnterior , @FechaHastaAnterior

go



*/



/*
Missing Index Details from C:\bdl\pronto\ProntoMVC\Documentos\sql\resumen de totales estadisticas.sql
The Query Processor estimates that implementing the following index could improve the query cost by 49.7958%.
*/
/*
CREATE NONCLUSTERED INDEX [CartasDePorte_PuntoVenta]
ON [dbo].[CartasDePorte] ([PuntoVenta])
INCLUDE ([NumeroCartaDePorte],[Anulada],[Vendedor],[CuentaOrden1],[CuentaOrden2],[Corredor],[Entregador],[Procedencia],[Patente],
[IdArticulo],[NetoProc],[NetoFinal],[Contrato],[Destino],[FechaDescarga],[Exporta],[IdFacturaImputada],[SubnumeroVagon],[FechaArribo],
[Corredor2],[SubnumeroDeFacturacion],[IdClienteAuxiliar])
GO

*/
