
CREATE FUNCTION [dbo].[Facturas_OrdenesCompra](@IdFactura int)
RETURNS VARCHAR(500)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+
			Substring('00000000',1,8-Len(Convert(varchar,OrdenesCompra.NumeroOrdenCompra)))+Convert(varchar,OrdenesCompra.NumeroOrdenCompra)+' '
	FROM DetalleFacturas Det
	LEFT OUTER JOIN DetalleFacturasOrdenesCompra ON Det.IdDetalleFactura = DetalleFacturasOrdenesCompra.IdDetalleFactura
	LEFT OUTER JOIN Facturas ON Det.IdFactura = Facturas.IdFactura
	LEFT OUTER JOIN DetalleOrdenesCompra ON DetalleFacturasOrdenesCompra.IdDetalleOrdenCompra = DetalleOrdenesCompra.IdDetalleOrdenCompra
	LEFT OUTER JOIN OrdenesCompra ON DetalleOrdenesCompra.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
	WHERE Det.IdFactura=@IdFactura
	GROUP BY OrdenesCompra.NumeroOrdenCompra
	ORDER BY OrdenesCompra.NumeroOrdenCompra

	RETURN Substring(@Retorno,1,500)
END


