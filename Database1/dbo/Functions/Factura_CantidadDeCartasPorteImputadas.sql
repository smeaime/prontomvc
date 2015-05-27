
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
