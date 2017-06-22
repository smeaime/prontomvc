
IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_MapaEstrategico]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].wCartasDePorte_TX_MapaEstrategico
go



CREATE PROCEDURE [dbo].wCartasDePorte_TX_MapaEstrategico

            @Modo  VARCHAR(20) = NULL,

			@FechaDesde datetime,
			@FechaHasta datetime,

			@idArticulo int  = NULL,
			@idProcedencia int  = NULL,
			@idClienteFacturado int  = NULL,

			@Tonsdesde int = NULL,
			@TonsHasta int = NULL
AS





select
*
from
(
select
 FLOOR( sum(netoproc) /1000) as kilos, 
LOCORI.Nombre as localidad, 
isnull(PROVORI.Nombre,'BUENOS AIRES' ) as provincia,
Clientes.RazonSocial,
--ProcedenciaDesc,
--ProcedenciaProvinciaDesc,
Procedencia,
lat,
lng

from 
 dbo.fSQL_GetDataTableFiltradoYPaginado  
				(  

					NULL, 
					6,  --facturadas?
					0,
					NULL, 
					-1,
					 
					-1,-1,
					-1,
					-1,
					-1,

					-1, 
					NULL, 
					0,
					@Modo,
					@FechaDesde,

					@FechaHasta,
					NULL, 
					NULL,
					 'FALSE',
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL

					)
    
 as CDP




RIGHT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad          
LEFT OUTER JOIN Provincias PROVORI ON LOCORI.IdProvincia = PROVORI.IdProvincia           
inner JOIN Facturas FAC ON CDP.idfacturaimputada = FAC.IdFactura
inner  JOIN Clientes ON FAC.IdCliente= Clientes.IdCliente
where   1=1
	--procedencia is not null
	--and netoproc > 0
	and (FAC.IdCliente = @idClienteFacturado or isnull(@idClienteFacturado, -1)=-1 )
	And (@IdArticulo IS NULL Or @IdArticulo=-1 Or cdp.IdArticulo = @IdArticulo)
	And (@idProcedencia IS NULL Or @idProcedencia=-1   Or cdp.Procedencia = @idProcedencia)


group by LOCORI.Nombre,PROVORI.Nombre,Clientes.RazonSocial,FAC.IdCliente,Procedencia,lat,lng


) as C
where kilos >= isnull(@TonsDesde,0)
and kilos <= isnull(@TonsHasta,999999999)

order by kilos desc





go






wCartasDePorte_TX_MapaEstrategico
					NULL,
					'20170201','20170510',
					
					NULL, 
					NULL, 
					NULL, 
					
					NULL, NULL
go

--@Modo  VARCHAR(20) = NULL,

--			@FechaDesde datetime,
--			@FechaHasta datetime,

--			@idArticulo int  = NULL,
--			@idProcedencia int  = NULL,
--			@idClienteFacturado int  = NULL,

--			@Tonsdesde int = NULL,
--			@TonsHasta int = NULL