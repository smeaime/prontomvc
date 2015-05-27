
CREATE FUNCTION [dbo].[Requerimientos_Recepciones](@IdRequerimiento int)
RETURNS VARCHAR(100)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+
			Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+
			IsNull('/'+Convert(varchar,Recepciones.Subnumero),'')+' '
	FROM DetalleRequerimientos DetReq
	LEFT OUTER JOIN DetalleRecepciones ON DetReq.IdDetalleRequerimiento = DetalleRecepciones.IdDetalleRequerimiento
	LEFT OUTER JOIN Recepciones ON DetalleRecepciones.IdRecepcion = Recepciones.IdRecepcion
	WHERE DetReq.IdRequerimiento=@IdRequerimiento and IsNull(Recepciones.Anulada,'NO')<>'SI'
	GROUP BY Recepciones.NumeroRecepcion1, Recepciones.NumeroRecepcion2, Recepciones.Subnumero
	ORDER BY Recepciones.NumeroRecepcion1, Recepciones.NumeroRecepcion2, Recepciones.Subnumero

	RETURN Substring(@Retorno,1,100)
END



