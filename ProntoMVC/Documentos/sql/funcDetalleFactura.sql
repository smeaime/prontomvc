
/*

select  idfactura,
dbo.DetalleFacturas_PorTipoCartaPorte  ( IdFactura,0),
dbo.DetalleFacturas_PorTipoCartaPorte  ( IdFactura,1),
dbo.DetalleFacturas_PorTipoCartaPorte  ( IdFactura,2),
dbo.DetalleFacturas_PorTipoCartaPorte  ( IdFactura,3)
from DetalleFacturas
where IdFactura>44700 and IdFactura<46000 




print dbo.DetalleFacturas_PorTipoCartaPorte  ( 68153,0)
print dbo.DetalleFacturas_PorTipoCartaPorte  ( 68153,1)
print dbo.DetalleFacturas_PorTipoCartaPorte  ( 68153,2)
print dbo.DetalleFacturas_PorTipoCartaPorte  ( 68153,3)


print dbo.DetalleFacturas_PorTipoCartaPorte  ( 65744,2)

go
*/

/*
select sum(MOVS.Cantidad)
from facturas CABFAC
left OUTER  join detallefacturas DETFAC ON DETFAC.IdFactura = CABFAC.IdFactura
left OUTER  join   [CartasPorteMovimientos] MOVS ON MOVS.IdFacturaImputada = CABFAC.IdFactura
where MOVS.Tipo=4
and  DETFAC.IdDetalleFactura=65744 
and DETFAC.Observaciones like 'BUQUE%'
*/



/*
wCartasDePorte_TX_PorIdFactura 44700
go
select * from Facturas
go
select * from detalleFacturas where iddetallefactura=68153
go
*/

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
--me mandas un pequeño select desde los detalles de factura 
--para separar por cantidad e importe las ventas por estos 3 items, asi no le erro.
-- no tengo imputacion contra item, asi q te pido el idarticulo


--te devuelvo la cantidad  -pero con eso no basta, necesito el importe! 
--el importe depende del item de la factura
--sí!, pero puede ser de otro renglon!!!!!


	SET @Tipo = ISNULL(@Tipo, 0)

declare @cantidad numeric(18,2)
	
/*
	if 	@Tipo=1
	  select idarticulo,cantidad  from [CartasPorteMovimientos] where Tipo=4 and IdFacturaImputada=10
	else if   @Tipo=1
	  select idarticulo,cantidad  from [CartasDePorte]  where EXPORTA='SI' and IdFacturaImputada=10
	else if   @Tipo=2
	  select idarticulo,cantidad  from [CartasDePorte]  where EXPORTA='SI' and IdFacturaImputada=10
	end

cómo sé si el renglon es de buque???? -observaciones empieza con BUQUE
*/


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

			--CDP.IdCartaDePorte,
			--CDP.NumeroCartaDePorte,
			--detfac.iddetallefactura,
			--detfac.observaciones as detobs,
			


from detallefacturas DETFAC  
inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
inner  join CartasDePorte CDP on CDP.IdDetalleFactura=DETFAC.IdDetalleFactura  
LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino

LEFT OUTER JOIN Log PRONTOLOG ON CABFAC.Idfactura = PRONTOLOG.Idcomprobante and prontolog.Detalle like 'Factura de CartasPorte%'
				
where				
 	DETFAC.IdDetalleFactura=@IdDetalleFactura and @IdDetalleFactura<>1
--(			

--	CABFAC.IdFactura=DETFAC.idFactura 
--	and CDP.IdArticulo = DETFAC.IdArticulo
--	and  charindex(Articulos.Descripcion, 'CAMBIO DE CARTA')=0 					 --
--	and  charindex(LOCDES.Descripcion  COLLATE SQL_Latin1_General_CP1_CI_AS, detfac.Observaciones)>0  --el destino
--	and 
--	(
--		(				
--			substring(cabfac.NumeroExpedienteCertificacionObra,4,1)<>'4' --no es CANJE
--			AND
--			(
--				LOCDES.Descripcion = cast(detfac.Observaciones as nvarchar(300)) + ' '
--				or 
--				charindex(CLIVEN.Razonsocial  COLLATE SQL_Latin1_General_CP1_CI_AS, detfac.Observaciones)>0
--			)
--		)
--		or
--		(
--			--es canje (se agrupa por CLICO1 y CLICO2)
--			substring(cabfac.NumeroExpedienteCertificacionObra,4,1)='4' --es CANJE
--			AND
--			charindex( CAST( isnull(CLICO1.IdCliente,-1) as varchar)  +  ' ' + CAST( isnull(CLICO2.IdCliente,-1) as varchar)     , detfac.Observaciones)>0
--		)
--	)
--)	

and

(
	(@Tipo=1 AND  isnull(CDP.EXPORTA,'SI')='SI') 
	OR  
	(@Tipo=0 AND isnull(CDP.EXPORTA,'SI')<>'SI')
)

end

	return ISNULL(@cantidad, 0)



end
					