
CREATE PROCEDURE [dbo].[RefrescarCartasPorteDetalleFacturas]
(
	@ForzarReimputacion as bit = 0
)
as

	SET @ForzarReimputacion = ISNULL(@ForzarReimputacion, 0)


update CartasDePorte
set IdDetalleFactura=1
where ISNULL(IdFacturaImputada,0)<=0


update CartasPorteMovimientos
set IdDetalleFactura=1
where ISNULL(IdFacturaImputada,0)<=0


	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--si hay items de detallefactura que quedan sin imputar, pueden ser "cambios de carta porte" que se pusieron manuales al facturar, o
	-- facturas hechas sueltas por pronto, o facturas con nota de credito cuyas cartas se reimputaron a otras facturas
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--select * from detallefacturas  where idfactura=57748
--select * from CartasPorteMovimientos where idfacturaimputada=57748
--update CartasPorteMovimientos
--set iddetallefactura=null
--where idfacturaimputada=57748

--update CartasPorteMovimientos
--set iddetallefactura=97218
--where IdCDPMovimiento=581

--update CartasPorteMovimientos
--set iddetallefactura=97219
--where IdCDPMovimiento=582

--update CartasPorteMovimientos
--set iddetallefactura=97220
--where IdCDPMovimiento=583




	DECLARE contact_cursor2 CURSOR FOR
	select CartasPorteMovimientos.IdCDPMovimiento from CartasPorteMovimientos  where iddetallefactura is null or @ForzarReimputacion=1;

	declare @d int
	DECLARE @i int
	OPEN contact_cursor2;

	-- Perform the first fetch.
	FETCH NEXT FROM contact_cursor2 into  @i;

	-- Check @@FETCH_STATUS to see if there are any more rows to fetch.
	WHILE @@FETCH_STATUS = 0
	BEGIN

				--set @d =isnull(	dbo.DetalleFacturas_PorIdCartaPorte( @i) ,1)
				--if @d=0 set @d=1
				--print  @i 
				--print @d
				
				select @d=DETFAC.iddetallefactura
					from facturas CABFAC
					inner join detallefacturas DETFAC ON DETFAC.IdFactura = CABFAC.IdFactura
					inner join   [CartasPorteMovimientos] MOVS ON MOVS.IdFacturaImputada = CABFAC.IdFactura
					--left OUTER  join [CartasPorteMovimientos] MOVS2 ON DETFAC.iddetallefactura = MOVS2.iddetallefactura
					where 
					MOVS.IdCDPMovimiento=@i
					and
					MOVS.Tipo=4
					and DETFAC.Observaciones like 'BUQUE%'
					and abs(detfac.Cantidad-movs.Cantidad/1000)<1
					--and MOVS2.IdDetalleFactura=null -- que el item de factura de buque no esté ya asignado a un buque

				   
				update CartasPorteMovimientos
				set CartasPorteMovimientos.iddetallefactura=@d
				where CartasPorteMovimientos.IdCDPMovimiento=@i
				

	   -- This is executed as long as the previous fetch succeeds.
	   FETCH NEXT FROM contact_cursor2 into  @i;

	END

	CLOSE contact_cursor2;
	DEALLOCATE contact_cursor2;




	

	DECLARE contact_cursor CURSOR FOR
	select IdCartaDePorte   from CartasDePorte  where iddetallefactura is null or @ForzarReimputacion=1;

	OPEN contact_cursor;

	-- Perform the first fetch.
	FETCH NEXT FROM contact_cursor into  @i;

	-- Check @@FETCH_STATUS to see if there are any more rows to fetch.
	WHILE @@FETCH_STATUS = 0
	BEGIN

				set @d =isnull(	dbo.DetalleFacturas_PorIdCartaPorte( @i) ,1)
				if @d=0 set @d=1
				print  @i 
				print @d
				   
				update CartasDePorte
				set CartasDePorte.iddetallefactura=@d
				where IdCartaDePorte=@i

	   -- This is executed as long as the previous fetch succeeds.
	   FETCH NEXT FROM contact_cursor into  @i;
	END

	CLOSE contact_cursor;
	DEALLOCATE contact_cursor;



	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--si hay items de detallefactura que quedan sin imputar, pueden ser por:
			--"cambios de carta porte" que se pusieron manuales al facturar, + articulos administrativos (gastos admin, etc)
			--o facturas hechas sueltas por pronto,
			--o facturas con nota de credito cuyas cartas se reimputaron a otras facturas
			--o cartas de porte que individualmente se reimputaron manualmente a otras facturas
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	--devolver las cartas que tienen idfacturaimputada pero no se les asigno iddetallefactura

	
select IdCartaDePorte,IdDetalleFactura,IdFacturaImputada 
from  CartasDePorte
where ISNULL(IdFacturaImputada,0)>0 and  ISNULL(IdDetalleFactura,0)<=0 




