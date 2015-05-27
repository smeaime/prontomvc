
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
