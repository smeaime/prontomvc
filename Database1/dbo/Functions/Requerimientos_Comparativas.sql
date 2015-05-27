
CREATE FUNCTION [dbo].[Requerimientos_Comparativas](@IdRequerimiento int)
RETURNS VARCHAR(100)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+Convert(varchar,Comparativas.Numero)+' '
	FROM DetalleRequerimientos DetReq
	LEFT OUTER JOIN DetallePresupuestos ON DetReq.IdDetalleRequerimiento = DetallePresupuestos.IdDetalleRequerimiento
	LEFT OUTER JOIN DetalleComparativas ON DetallePresupuestos.IdDetallePresupuesto = DetalleComparativas.IdDetallePresupuesto
	LEFT OUTER JOIN Comparativas ON DetalleComparativas.IdComparativa = Comparativas.IdComparativa
	WHERE DetReq.IdRequerimiento=@IdRequerimiento 
	GROUP BY Comparativas.Numero
	ORDER BY Comparativas.Numero

	RETURN Substring(@Retorno,1,100)
END



