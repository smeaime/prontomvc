CREATE FUNCTION [dbo].[Facturas_Remitos](@IdFactura int)
RETURNS VARCHAR(1000)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+
			Substring('0000',1,4-Len(Convert(varchar,IsNull(Remitos.PuntoVenta,0))))+Convert(varchar,IsNull(Remitos.PuntoVenta,0))+'-'+
				Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+Convert(varchar,Remitos.NumeroRemito)+' '
	FROM DetalleFacturas Det
	LEFT OUTER JOIN DetalleFacturasRemitos ON Det.IdDetalleFactura = DetalleFacturasRemitos.IdDetalleFactura
	LEFT OUTER JOIN Facturas ON Det.IdFactura = Facturas.IdFactura
	LEFT OUTER JOIN DetalleRemitos ON DetalleFacturasRemitos.IdDetalleRemito = DetalleRemitos.IdDetalleRemito
	LEFT OUTER JOIN Remitos ON DetalleRemitos.IdRemito = Remitos.IdRemito
	WHERE Det.IdFactura=@IdFactura
	GROUP BY Remitos.PuntoVenta, Remitos.NumeroRemito
	ORDER BY Remitos.PuntoVenta, Remitos.NumeroRemito

	RETURN Substring(@Retorno,1,1000)
END
