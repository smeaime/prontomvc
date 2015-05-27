CREATE FUNCTION [dbo].[Pedidos_IdObras](@IdPedido int)
RETURNS VARCHAR(100)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+'('+Convert(varchar,Requerimientos.IdObra)+')'
	FROM DetallePedidos DetPed
	LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
	LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
	WHERE DetPed.IdPedido=@IdPedido and Requerimientos.IdObra is not null
	GROUP BY Requerimientos.IdObra
	ORDER BY Requerimientos.IdObra

	RETURN Substring(@Retorno,1,100)
END

