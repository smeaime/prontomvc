
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
