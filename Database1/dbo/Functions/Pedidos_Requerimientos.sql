
CREATE FUNCTION [dbo].[Pedidos_Requerimientos](@IdPedido int)
RETURNS VARCHAR(100)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+
			Substring('00000000',1,8-Len(Convert(varchar,Requerimientos.NumeroRequerimiento)))+Convert(varchar,Requerimientos.NumeroRequerimiento)+' '
	FROM DetallePedidos DetPed
	LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
	LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
	WHERE DetPed.IdPedido=@IdPedido
	GROUP BY Requerimientos.NumeroRequerimiento
	ORDER BY Requerimientos.NumeroRequerimiento

	RETURN Substring(@Retorno,1,100)
END


