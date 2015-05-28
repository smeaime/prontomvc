
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
	
--	if 	@Tipo=1
--	  select idarticulo,cantidad  from [CartasPorteMovimientos] where Tipo=4 and IdFacturaImputada=10
--	else if   @Tipo=1
--	  select idarticulo,cantidad  from [CartasDePorte]  where EXPORTA='SI' and IdFacturaImputada=10
--	else if   @Tipo=2
--	  select idarticulo,cantidad  from [CartasDePorte]  where EXPORTA='SI' and IdFacturaImputada=10
--	end

--cómo sé si el renglon es de buque???? -observaciones empieza con BUQUE


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
					
