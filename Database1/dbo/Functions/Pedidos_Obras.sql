CREATE FUNCTION [dbo].[Pedidos_Obras](@IdPedido int)
RETURNS VARCHAR(100)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+Obras.NumeroObra+' '
	FROM DetallePedidos DetPed
	LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
	LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
	LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
	WHERE DetPed.IdPedido=@IdPedido and Obras.NumeroObra is not null
	GROUP BY Obras.NumeroObra
	ORDER BY Obras.NumeroObra

	RETURN Substring(@Retorno,1,100)
END
