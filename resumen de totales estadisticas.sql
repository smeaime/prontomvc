/*
declare @FechaDesde datetime
declare @FechaHasta datetime
declare @FechaDesdeAnterior datetime
declare @FechaHastaAnterior datetime
set @FechaDesdeAnterior ='20170101'
set @FechaHastaAnterior='20170131'
set @FechaDesde='20170201'
set @FechaHasta='20170228'
*/




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
			   ) as PeriodoAnteriorBuques



from
(

select

                   puntoventa as Sucursal,
			Exporta as Modo,
			Count(*) as CantCartas,
			sum(
				case when FechaDescarga>= @FechaDesde
				then NetoPto/1000
				else 0 	end
			   ) as NetoFinal,
			sum(
				case when FechaDescarga<= @FechaHastaAnterior  
				then NetoPto/1000
				else 0 	end
			   ) as PeriodoAnterior  

from 
 dbo.fSQL_GetDataTableFiltradoYPaginado  
				(  

					NULL, 
					0, 
					0,   --estado
					NULL, 
					-1,
					 
					-1, --Corredor
					-1,
					-1,
					-1,
					-1,

					-1,  --Procedencia
					NULL, 
					0,   --AplicarANDuORalFiltro
					NULL,  --ModoExportacion
					@FechaDesdeAnterior,

					@FechaHasta,
					NULL, 
					NULL,
					'FALSE', --TraerDuplicados
					NULL, 
					NULL, 

					NULL, --ClienteAuxiliarint
					NULL, 
					NULL,
					NULL, 
					NULL

					)
    
 as CDP










 Group by  cdp.PuntoVenta,cdp.exporta




union 

select 


                   IdStock as Sucursal,
			'Buque' as Modo,
			Count(*) as CantCartas,
			sum(
				case when i.FechaIngreso >= @FechaDesde
				then cantidad /1000
				else 0 	end
			   ) as NetoFinal,
			sum(
				case when i.FechaIngreso <= @FechaHastaAnterior 
				then cantidad /1000
				else 0 	end
			   ) as PeriodoAnterior           
			         



From CartasPorteMovimientos i
Where (
                                i.Tipo = 4 
                                And isnull(i.Anulada, 'NO') <> 'SI' 
                                And i.FechaIngreso >= @FechaDesdeAnterior And i.FechaIngreso <= @FechaHasta 
                           )



 

 Group by  IdStock

) as Q

where sucursal >0
group by sucursal

) as Q2


go












[wCartasDePorte_TX_ResumenDeTotalesEstadisticas] 
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
					'20161101',
					
					'20170510',
					NULL, 
					NULL,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL

					,'20151101','20160510'

go






[wCartasDePorte_TX_EstadisticasDeDescarga] 
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
					'20161101',
					
					'20170510',
					NULL, 
					NULL,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL

					,'20151101','20160510'

go

