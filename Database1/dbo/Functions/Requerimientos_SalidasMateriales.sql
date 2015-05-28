
CREATE FUNCTION [dbo].[Requerimientos_SalidasMateriales](@IdRequerimiento int)
RETURNS VARCHAR(100)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+
			Substring('0000',1,4-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)+' '
	FROM DetalleRequerimientos DetReq
	LEFT OUTER JOIN DetalleValesSalida ON DetReq.IdDetalleRequerimiento = DetalleValesSalida.IdDetalleRequerimiento
	LEFT OUTER JOIN DetalleSalidasMateriales ON DetalleValesSalida.IdDetalleValeSalida = DetalleSalidasMateriales.IdDetalleValeSalida
	LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
	WHERE DetReq.IdRequerimiento=@IdRequerimiento and IsNull(SalidasMateriales.Anulada,'NO')<>'SI'
	GROUP BY SalidasMateriales.NumeroSalidaMateriales2, SalidasMateriales.NumeroSalidaMateriales
	ORDER BY SalidasMateriales.NumeroSalidaMateriales2, SalidasMateriales.NumeroSalidaMateriales

	RETURN Substring(@Retorno,1,100)
END



