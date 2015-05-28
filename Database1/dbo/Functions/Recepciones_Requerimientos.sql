CREATE FUNCTION [dbo].[Recepciones_Requerimientos](@IdRecepcion int)
RETURNS VARCHAR(100)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+Substring('00000000',1,8-Len(Convert(varchar,Requerimientos.NumeroRequerimiento)))+Convert(varchar,Requerimientos.NumeroRequerimiento)+' '
	FROM DetalleRecepciones DetRec
	LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento = DetRec.IdDetalleRequerimiento
	LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetReq.IdRequerimiento
	WHERE DetRec.IdRecepcion=@IdRecepcion and Requerimientos.NumeroRequerimiento is not null
	GROUP BY Requerimientos.NumeroRequerimiento
	ORDER BY Requerimientos.NumeroRequerimiento

	RETURN Substring(@Retorno,1,100)
END
