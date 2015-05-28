CREATE FUNCTION [dbo].[AjustesStock_SolicitudesDeMateriales](@IdAjusteStock int)
RETURNS VARCHAR(100)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+IsNull(Convert(varchar,ValesSalida.NumeroValeSalida),'')+' '
	FROM DetalleAjustesStock Det
	LEFT OUTER JOIN DetalleValesSalida ON DetalleValesSalida.IdDetalleValeSalida = Det.IdDetalleValeSalida
	LEFT OUTER JOIN ValesSalida ON ValesSalida.IdValeSalida = DetalleValesSalida.IdValeSalida
	WHERE Det.IdAjusteStock=@IdAjusteStock
	GROUP BY ValesSalida.NumeroValeSalida
	ORDER BY ValesSalida.NumeroValeSalida

	RETURN Substring(@Retorno,1,100)
END

