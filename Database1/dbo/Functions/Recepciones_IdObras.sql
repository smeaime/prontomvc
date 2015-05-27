CREATE FUNCTION [dbo].[Recepciones_IdObras](@IdRecepcion int)
RETURNS VARCHAR(100)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+'('+Convert(varchar,Requerimientos.IdObra)+')'
	FROM DetalleRecepciones DetRec
	LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento = DetRec.IdDetalleRequerimiento
	LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetReq.IdRequerimiento
	WHERE DetRec.IdRecepcion=@IdRecepcion and Requerimientos.IdObra is not null
	GROUP BY Requerimientos.IdObra
	ORDER BY Requerimientos.IdObra

	RETURN Substring(@Retorno,1,100)
END