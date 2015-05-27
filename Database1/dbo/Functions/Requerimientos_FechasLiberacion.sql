CREATE FUNCTION [dbo].[Requerimientos_FechasLiberacion](@IdRequerimiento int)
RETURNS VARCHAR(100)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+Convert(varchar,DetReq.NumeroItem)+'='+IsNull(Convert(varchar,DetReq.FechaLiberacionParaCompras,103),'S/D')+' '
	FROM DetalleRequerimientos DetReq
	WHERE DetReq.IdRequerimiento=@IdRequerimiento 
	GROUP BY DetReq.NumeroItem, DetReq.FechaLiberacionParaCompras
	ORDER BY DetReq.NumeroItem, DetReq.FechaLiberacionParaCompras

	RETURN Substring(@Retorno,1,100)
END
