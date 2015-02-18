
drop FUNCTION [dbo].[DetalleFactura_TipoImputacionCartaPorte]
go

CREATE FUNCTION [dbo].[DetalleFactura_TipoImputacionCartaPorte]
(
	@IdDetalleFactura int
)

RETURNS int
AS
BEGIN

declare @i int


--qu� idfactura le corresponde?


--esta hecha por prontoweb?


--and dbo.Factura_TieneNotaDeCreditoImputada(det.idFactura)=0
--and dbo.Factura_HechaEnProntoWeb(IdFactura) =1

--fue anulada? tiene una nota de credito?



--si ten�a originales
--	las sigue teniendo?
	

--son solo buques?




return @i

end
go






drop FUNCTION [dbo].[Factura_TieneNotaDeCreditoImputada]
go

CREATE FUNCTION [dbo].[Factura_TieneNotaDeCreditoImputada]
(
	@IdFactura int
)

RETURNS int
AS
BEGIN

declare @i int


  select @i=count(*) 
from [DetalleNotasCreditoImputaciones] DETNC
inner join  CuentasCorrientesDeudores CC on CC.IdCtaCte=DETNC.idImputacion 
						and CC.IdTipoComp=1 and CC.Idcomprobante=@IdFactura
--inner join  Facturas on CuentasCorrientesDeudores.IdComprobante=Facturas.idfactura and IdTipoComp=1
--order by idfactura



return @i

end
go


print dbo.[Factura_TieneNotaDeCreditoImputada](56151)  
print dbo.[Factura_TieneNotaDeCreditoImputada](56152)  




drop FUNCTION [dbo].[Factura_HechaEnProntoWeb]
go

CREATE FUNCTION [dbo].[Factura_HechaEnProntoWeb]
(
	@IdFactura int
)

RETURNS int
AS
BEGIN

declare @i int

	
 select @i=count(*) from Log 
 where (detalle like 'Factura por ProntoWeb' and idcomprobante=@IdFactura )  

return @i

end
go

print dbo.Factura_HechaEnProntoWeb(58523)
print dbo.Factura_HechaEnProntoWeb(58529)


drop FUNCTION [dbo].[Factura_CantidadDeCartasPorteImputadas]
go

CREATE FUNCTION [dbo].[Factura_CantidadDeCartasPorteImputadas]
(
	@IdFactura int
)

RETURNS int
AS
BEGIN

declare @id int
declare @id2 int

	select 
		@id= 	count(*)


from CartasDePorte 
--inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
--inner  join CartasDePorte CDP on CDP.IdFacturaImputada=CABFAC.IdFactura  
where IdFacturaImputada=@IdFactura


--imputadas ahora
select 
		@id2= 	count(*)


from  CartasPorteMovimientos
--inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
--inner  join CartasDePorte CDP on CDP.IdFacturaImputada=CABFAC.IdFactura  
where IdFacturaImputada=@IdFactura


	return ISNULL(@id, 0)+ISNULL(@id2, 0)
	

end
go



drop FUNCTION [dbo].[Factura_CantidadDeCartasPorteImputadasOriginalmente]
go

CREATE FUNCTION [dbo].[Factura_CantidadDeCartasPorteImputadasOriginalmente]
(
	@IdFactura int
)

RETURNS int
AS
BEGIN


--imputadas originalmente
declare @i3 int
select @i3= count(*) from Log 
 where (detalle like 'Imputacion de IdCartaPorte%' 
		and idcomprobante=@IdFactura) 
 

	return ISNULL(@i3, 0)
	

end
go


print dbo.Factura_CantidadDeCartasPorteImputadas(56949)
print dbo.Factura_CantidadDeCartasPorteImputadasOriginalmente(56949)

		
--[DetalleFacturas_PorIdCartaPorte]

drop FUNCTION [dbo].[DetalleFacturas_PorIdCartaPorte]
go

CREATE FUNCTION [dbo].[DetalleFacturas_PorIdCartaPorte]
(
	@IdCartaPorte int
)

RETURNS int
AS
BEGIN

declare @id int



declare @IdFacturaImputada int
select 	@IdFacturaImputada=IdFacturaImputada from cartasdeporte where IdCartaDePorte = @IdCartaPorte 
if isnull(@IdFacturaImputada,0)=0 return 0




--que pasa si encontramos mas de un renglon candidato, porque est� duplicada la descripcion?
--ver cuantos candidatos hay


	select 
	@cant=COUNT( 	DETFAC.IdDetalleFactura)


from detallefacturas DETFAC  
inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
inner  join CartasDePorte CDP on CDP.IdFacturaImputada=CABFAC.IdFactura  
LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
inner  join Articulos ON CDP.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Log PRONTOLOG ON CABFAC.Idfactura = PRONTOLOG.Idcomprobante and prontolog.Detalle like 'Factura de CartasPorte%'
where				
(			
CDP.IdCartaDePorte = @IdCartaPorte and
	CABFAC.IdFactura=DETFAC.idFactura 
	and CDP.IdArticulo = DETFAC.IdArticulo
	and  charindex(Articulos.Descripcion, 'CAMBIO DE CARTA')=0 					 --
	and  charindex(LOCDES.Descripcion  COLLATE SQL_Latin1_General_CP1_CI_AS, detfac.Observaciones)>0  --el destino
	and 
	(
		(				
			--substring(cabfac.NumeroExpedienteCertificacionObra,4,1)<>'4' --no es CANJE
			--AND
			(
				LOCDES.Descripcion = cast(detfac.Observaciones as nvarchar(300)) + ' '
				or 
				charindex(CLIVEN.Razonsocial  COLLATE SQL_Latin1_General_CP1_CI_AS, detfac.Observaciones)>0
			)
		)
		or
		(
			----es canje (se agrupa por CLICO1 y CLICO2)
			--substring(cabfac.NumeroExpedienteCertificacionObra,4,1)='4' --es CANJE
			--AND
			charindex( CAST( isnull(CLICO1.IdCliente,-1) as varchar)  +  ' ' + CAST( isnull(CLICO2.IdCliente,-1) as varchar)     , detfac.Observaciones)>0
		)
		--or 1=1
	)
)	




if @cant>1



--////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////



	select 
		@id= 	DETFAC.IdDetalleFactura


from detallefacturas DETFAC  
inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
inner  join CartasDePorte CDP on CDP.IdFacturaImputada=CABFAC.IdFactura  
LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
inner  join Articulos ON CDP.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Log PRONTOLOG ON CABFAC.Idfactura = PRONTOLOG.Idcomprobante and prontolog.Detalle like 'Factura de CartasPorte%'
where				
(			
CDP.IdCartaDePorte = @IdCartaPorte and
	CABFAC.IdFactura=DETFAC.idFactura 
	and CDP.IdArticulo = DETFAC.IdArticulo
	and  charindex(Articulos.Descripcion, 'CAMBIO DE CARTA')=0 					 --
	and  charindex(LOCDES.Descripcion  COLLATE SQL_Latin1_General_CP1_CI_AS, detfac.Observaciones)>0  --el destino
	and 
	(
		(				
			--substring(cabfac.NumeroExpedienteCertificacionObra,4,1)<>'4' --no es CANJE
			--AND
			(
				LOCDES.Descripcion = cast(detfac.Observaciones as nvarchar(300)) + ' '
				or 
				charindex(CLIVEN.Razonsocial  COLLATE SQL_Latin1_General_CP1_CI_AS, detfac.Observaciones)>0
			)
		)
		or
		(
			----es canje (se agrupa por CLICO1 y CLICO2)
			--substring(cabfac.NumeroExpedienteCertificacionObra,4,1)='4' --es CANJE
			--AND
			charindex( CAST( isnull(CLICO1.IdCliente,-1) as varchar)  +  ' ' + CAST( isnull(CLICO2.IdCliente,-1) as varchar)     , detfac.Observaciones)>0
		)
		--or 1=1
	)
)	




	set @id=ISNULL(@id, 0)


	if @id=0 
	begin   
		-- me resigno con menos condiciones	

			select 
				@id= 	DETFAC.IdDetalleFactura


		from detallefacturas DETFAC  
		inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
		inner  join CartasDePorte CDP on CDP.IdFacturaImputada=CABFAC.IdFactura  
		LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
		LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
		LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
		LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
		LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
		LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
		LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
		LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
		inner  join Articulos ON CDP.IdArticulo = Articulos.IdArticulo
		LEFT OUTER JOIN Log PRONTOLOG ON CABFAC.Idfactura = PRONTOLOG.Idcomprobante and prontolog.Detalle like 'Factura de CartasPorte%'
		where				
		(			
		CDP.IdCartaDePorte = @IdCartaPorte and
			CABFAC.IdFactura=DETFAC.idFactura 
			and CDP.IdArticulo = DETFAC.IdArticulo
			and  charindex(Articulos.Descripcion, 'CAMBIO DE CARTA')=0 					 --
			and  charindex(LOCDES.Descripcion  COLLATE SQL_Latin1_General_CP1_CI_AS, detfac.Observaciones)>0  --el destino
		)	


	
	end
	
	
	if @id=0 
	begin   
		-- me resigno con menos condiciones	aun (de todas maneras, siempre respetando el IdFacturaImputada)

			select 
				@id= 	DETFAC.IdDetalleFactura


		from detallefacturas DETFAC  
		inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
		inner  join CartasDePorte CDP on CDP.IdFacturaImputada=CABFAC.IdFactura  
		LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
		LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
		LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
		LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
		LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
		LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
		LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
		LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
		inner  join Articulos ON CDP.IdArticulo = Articulos.IdArticulo
		LEFT OUTER JOIN Log PRONTOLOG ON CABFAC.Idfactura = PRONTOLOG.Idcomprobante and prontolog.Detalle like 'Factura de CartasPorte%'
		where				
		(			
		CDP.IdCartaDePorte = @IdCartaPorte and
			CABFAC.IdFactura=DETFAC.idFactura 
			and CDP.IdArticulo = DETFAC.IdArticulo
			and  charindex(Articulos.Descripcion, 'CAMBIO DE CARTA')=0 					 --
			--and  charindex(LOCDES.Descripcion  COLLATE SQL_Latin1_General_CP1_CI_AS, detfac.Observaciones)>0  --el destino
		)	


	
	end
	





	return ISNULL(@id, 0)
	
	end

go


print dbo.[DetalleFacturas_PorIdCartaPorte] (1412268)


print dbo.DetalleFacturas_PorIdCartaPorte( 1376722)

print dbo.DetalleFacturas_PorIdCartaPorte( 1355967)

--print dbo.DetalleFacturas_PorIdCartaPorte( 1355967)
--print dbo.DetalleFacturas_PorIdCartaPorte( 3000)
--print dbo.DetalleFacturas_PorIdCartaPorte( 30000)
--print dbo.DetalleFacturas_PorIdCartaPorte( 300000)
--print dbo.DetalleFacturas_PorIdCartaPorte( 980000)
--print dbo.DetalleFacturas_PorIdCartaPorte( 981176)

--select IdCartaDePorte from CartasDePorte

-- [RefrescarCartasPorteDetalleFacturas]

--select * from CartasPorteMovimientos where idfacturaimputada=57748


drop PROCEDURE [dbo].[RefrescarCartasPorteDetalleFacturas]
go

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
					--and MOVS2.IdDetalleFactura=null -- que el item de factura de buque no est� ya asignado a un buque

				   
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




go


--[RefrescarCartasPorteDetalleFacturas]






drop FUNCTION [dbo].[DetalleFacturas_PorTipoCartaPorte]
go

CREATE FUNCTION [dbo].[DetalleFacturas_PorTipoCartaPorte]
(
	@IdDetalleFactura int,
	@Tipo int  -- 0 normal entrega (default)/ 1 exportacion / 2 embarque / 3 gasto administrativo
)

RETURNS numeric(18,2)
AS
BEGIN

--  me pidio hugo un informe donde tengo que separar las ventas por exportacion, entregas y buques, donde tengo el dato?
--[09:38:16 a.m.] Mariano Scalella: lo de si es exportacion o entrega lo tenes en el campo EXPORTA de la tabla cartasdeporte
--me mandas un peque�o select desde los detalles de factura 
--para separar por cantidad e importe las ventas por estos 3 items, asi no le erro.
-- no tengo imputacion contra item, asi q te pido el idarticulo


--te devuelvo la cantidad  -pero con eso no basta, necesito el importe! 
--el importe depende del item de la factura
--s�!, pero puede ser de otro renglon!!!!!


	SET @Tipo = ISNULL(@Tipo, 0)

declare @cantidad numeric(18,2)
	
--	if 	@Tipo=1
--	  select idarticulo,cantidad  from [CartasPorteMovimientos] where Tipo=4 and IdFacturaImputada=10
--	else if   @Tipo=1
--	  select idarticulo,cantidad  from [CartasDePorte]  where EXPORTA='SI' and IdFacturaImputada=10
--	else if   @Tipo=2
--	  select idarticulo,cantidad  from [CartasDePorte]  where EXPORTA='SI' and IdFacturaImputada=10
--	end

--c�mo s� si el renglon es de buque???? -observaciones empieza con BUQUE


if @Tipo=2	
begin
	select @cantidad=	sum(MOVS.Cantidad)/1000
	from facturas CABFAC
	left OUTER  join detallefacturas DETFAC ON DETFAC.IdFactura = CABFAC.IdFactura
	left OUTER  join   [CartasPorteMovimientos] MOVS ON MOVS.IdFacturaImputada = CABFAC.IdFactura
	where MOVS.Tipo=4
	and  DETFAC.IdDetalleFactura=@IdDetalleFactura 
	and DETFAC.Observaciones like 'BUQUE%'
end
else if @Tipo=3	
begin

	select 		@cantidad= 	sum(CDP.NetoFinal)
	from facturas CABFAC
	left OUTER  join detallefacturas DETFAC ON DETFAC.IdFactura = CABFAC.IdFactura
	left join CartasDePorte CDP on CDP.IdFacturaImputada=CABFAC.IdFactura  
	where DETFAC.Idarticulo=   57
	and  DETFAC.IdDetalleFactura=@IdDetalleFactura 
	--DETFAC.Observaciones='POR GASTOS ADMINISTRATIVOS'

end
else 	
begin
	select 
		@cantidad= 	CDP.NetoFinal

from CartasDePorte CDP 
where				
 	CDP.IdDetalleFactura=@IdDetalleFactura and CDP.IdDetalleFactura<>1
and

(
	(@Tipo=1 AND  isnull(CDP.EXPORTA,'SI')='SI') 
	OR  
	(@Tipo=0 AND isnull(CDP.EXPORTA,'SI')<>'SI')
)

end

	return ISNULL(@cantidad, 0)



end
					
go




--select  IdFactura,IdDetalleFactura,
--dbo.DetalleFacturas_PorTipoCartaPorte  ( IdDetalleFactura,0),
--dbo.DetalleFacturas_PorTipoCartaPorte  ( IdDetalleFactura,1),
--dbo.DetalleFacturas_PorTipoCartaPorte  ( IdDetalleFactura,2),
--dbo.DetalleFacturas_PorTipoCartaPorte  ( IdDetalleFactura,3)
--from DetalleFacturas
--where IdFactura>44700 and IdFactura<44750 




--print dbo.DetalleFacturas_PorTipoCartaPorte  ( 68153,0)
--print dbo.DetalleFacturas_PorTipoCartaPorte  ( 68153,1)
--print dbo.DetalleFacturas_PorTipoCartaPorte  ( 68153,2)
--print dbo.DetalleFacturas_PorTipoCartaPorte  ( 68153,3)


--print dbo.DetalleFacturas_PorTipoCartaPorte  ( 65744,2)

--go





--[04:04:19 p.m.] Eduardo De Santis: hacelo tipo sp, que devuelva una tabla Tipo, Cantidad por cada item con 1 a n registros de devolucion
--[04:04:38 p.m.] Eduardo De Santis: yo lo atrapo en una tabla temporaria y despues agrupo



drop PROCEDURE [spDetalleFacturas_PorTipoCartaPorte]
go

CREATE PROCEDURE [spDetalleFacturas_PorTipoCartaPorte]
(
--	@IdDetalleFactura int,
	 -- 0 normal entrega (default)/ 1 exportacion / 2 embarque / 3 gasto administrativo

--@IdDetalleFacturaDesde int=1,
--@IdDetalleFacturaHasta int=null



    @FechaDesde DATETIME = NULL,
    @FechaHasta DATETIME = NULL
	)

AS 
    SET NOCOUNT ON

    SET @FechaDesde = ISNULL(@FechaDesde, CONVERT(DATETIME, '1/1/1900'))
    SET @FechaHasta = ISNULL(@FechaHasta, CONVERT(DATETIME, '1/1/2100'))


select * from 
(

select 
DETFAC.IdDetalleFactura, 
Case When CDP.Exporta='SI' Then 'EXPORTACION'  Else 'ENTREGA' End as Tipo -- When  DETFAC.IdArticulo=57 Then 'ADMINISTRATIVO'
,sum(CDP.NetoFinal/1000) as Cantidad
FROM Detallefacturas DETFAC
inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
inner JOIN CartasDePorte CDP on CDP.IdDetalleFactura=DETFAC.IdDetalleFactura
where 
--DETFAC.IdDetalleFactura between @IdDetalleFacturaDesde and @IdDetalleFacturaHasta
CABFAC.FechaFactura between @FechaDesde and @FechaHasta
group by DETFAC.IdDetalleFactura,CDP.Exporta

UNION
select 
DETFAC.IdDetalleFactura , 
'BUQUE' as Tipo,
sum(MOVS.Cantidad/1000000)
FROM Detallefacturas DETFAC
inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
inner JOIN CartasPorteMovimientos MOVS ON MOVS.IdDetalleFactura = DETFAC.IdDetalleFactura and MOVS.Tipo=4
where 
--DETFAC.IdDetalleFactura between @IdDetalleFacturaDesde and @IdDetalleFacturaHasta
CABFAC.FechaFactura between @FechaDesde and @FechaHasta
group by DETFAC.IdDetalleFactura

UNION

--select 
--DETFAC.IdDetalleFactura , 
--'SIN IMPUTAR' as Tipo,
--sum(DETFAC.cantidad) - sum(isnull(MOVS.Cantidad,0)) /1000 - SUM (isnull(CDP.NetoFinal,0))/1000   --cuando haces el join, la cantidad de DETFAC se multiplica por cada renglon...

--FROM Detallefacturas DETFAC
--left outer JOIN CartasDePorte CDP on CDP.IdDetalleFactura=DETFAC.IdDetalleFactura
--left outer JOIN CartasPorteMovimientos MOVS ON MOVS.IdDetalleFactura = DETFAC.IdDetalleFactura and MOVS.Tipo=4
--where DETFAC.IdDetalleFactura between @IdDetalleFacturaDesde and @IdDetalleFacturaHasta
--group by DETFAC.IdDetalleFactura


--UNION

select 
DETFAC.IdDetalleFactura , 
'TOTAL' as Tipo,
DETFAC.cantidad 
FROM Detallefacturas DETFAC
inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
where 
--DETFAC.IdDetalleFactura between @IdDetalleFacturaDesde and @IdDetalleFacturaHasta
CABFAC.FechaFactura between @FechaDesde and @FechaHasta

-------

) as Q


union



select DETFAC.IdDetalleFactura,'SIN IMPUTAR'
,isnull(DETFAC.Cantidad,0)-isnull(T.Cantidad,0)
from Detallefacturas 
DETFAC
left outer join 
(
	select  G.IdDetalleFactura as IdDetalleFactura,'IMPUTADO' as Tipo ,sum(G.Cantidad)  as Cantidad from  (
					select 
					DETFAC.IdDetalleFactura, 
					Case When CDP.Exporta='SI' Then 'EXPORTACION'  Else 'ENTREGA' End as Tipo -- When  DETFAC.IdArticulo=57 Then 'ADMINISTRATIVO'
					,sum(CDP.NetoFinal/1000) as Cantidad
					FROM Detallefacturas DETFAC
					inner JOIN CartasDePorte CDP on CDP.IdDetalleFactura=DETFAC.IdDetalleFactura
					inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
					where 
					--DETFAC.IdDetalleFactura between @IdDetalleFacturaDesde and @IdDetalleFacturaHasta
					CABFAC.FechaFactura between @FechaDesde and @FechaHasta
					group by DETFAC.IdDetalleFactura,CDP.Exporta

					UNION
					select 
					DETFAC.IdDetalleFactura , 
					'BUQUE' as Tipo,
					MOVS.Cantidad/1000000
					FROM Detallefacturas DETFAC
					inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
					inner JOIN CartasPorteMovimientos MOVS ON MOVS.IdDetalleFactura = DETFAC.IdDetalleFactura and MOVS.Tipo=4
					where 
					--DETFAC.IdDetalleFactura between @IdDetalleFacturaDesde and @IdDetalleFacturaHasta
					CABFAC.FechaFactura between @FechaDesde and @FechaHasta

					) as G
					group by G.IdDetalleFactura

	) as T    on DETFAC.IdDetalleFactura=T.IdDetalleFactura 
	inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  

where 
--DETFAC.IdDetalleFactura between @IdDetalleFacturaDesde and @IdDetalleFacturaHasta
CABFAC.FechaFactura between @FechaDesde and @FechaHasta


-----
order by Q.IdDetalleFactura,Tipo




--comparar con la suma total de la factura
go


--[spDetalleFacturas_PorTipoCartaPorte] 10000,1000000--null,null
go

--[spDetalleFacturas_PorTipoCartaPorte] '1/10/2012','1/31/2012'  --null,null


--[RefrescarCartasPorteDetalleFacturas] 0


--select * from iddetallefactura=66690 -- hay varios buques que apuntan a este item


            

select iddetallefactura from cartasdeporte where iddetallefactura=   117517         

select iddetallefactura,idfacturaimputada, * from cartasdeporte where idfacturaimputada= 66132
update cartasdeporte set iddetallefactura=null where idfacturaimputada= 66132

select  * from detallefacturas where idfactura=66132           
