CREATE FUNCTION [dbo].[Equipos_SubEquiposInstalados](@IdEquipo int)
RETURNS VARCHAR(100)

BEGIN
	DECLARE @Retorno varchar (2000), @IdDetalleObraEquipoInstalado int

	SET @Retorno = ''
	SET @IdDetalleObraEquipoInstalado=IsNull((Select Top 1 IdDetalleObraEquipoInstalado From DetalleObrasEquiposInstalados Where IdArticulo=@IdEquipo and FechaDesinstalacion is null),0)

	SELECT @Retorno = COALESCE(@Retorno,'')+IsNull(Articulos.Codigo+' ','')
	FROM DetalleObrasEquiposInstalados2 doei2
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = doei2.IdArticulo
	WHERE doei2.IdDetalleObraEquipoInstalado=@IdDetalleObraEquipoInstalado

	RETURN Substring(@Retorno,1,100)
END

