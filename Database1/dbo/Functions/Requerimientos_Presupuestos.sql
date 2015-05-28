
CREATE FUNCTION [dbo].[Requerimientos_Presupuestos](@IdRequerimiento int)
RETURNS VARCHAR(100)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+Convert(varchar,Presupuestos.Numero)+IsNull('/'+Convert(varchar,Presupuestos.Subnumero),'')+' '
	FROM DetalleRequerimientos DetReq
	LEFT OUTER JOIN DetallePresupuestos ON DetReq.IdDetalleRequerimiento = DetallePresupuestos.IdDetalleRequerimiento
	LEFT OUTER JOIN Presupuestos ON DetallePresupuestos.IdPresupuesto = Presupuestos.IdPresupuesto
	WHERE DetReq.IdRequerimiento=@IdRequerimiento
	GROUP BY Presupuestos.Numero, Presupuestos.Subnumero
	ORDER BY Presupuestos.Numero, Presupuestos.Subnumero

	RETURN Substring(@Retorno,1,100)
END

