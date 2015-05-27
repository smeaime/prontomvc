
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
