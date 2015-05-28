CREATE Procedure [dbo].[ListasPrecios_TX_UltimoPorIdArticulo]

@IdArticulo int,
@IdMoneda int,
@IdListaPrecios int = Null

AS 

SET @IdListaPrecios=IsNull(@IdListaPrecios,0)
IF @IdListaPrecios=0
	SET @IdListaPrecios=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdListaPrecios'),0)

SELECT TOP 1 lpd.Precio as [Precio]
FROM ListasPreciosDetalle lpd
LEFT OUTER JOIN ListasPrecios ON lpd.IdListaPrecios=ListasPrecios.IdListaPrecios
WHERE lpd.IdArticulo=@IdArticulo and IsNull(ListasPrecios.Activa,'SI')<>'NO' and ListasPrecios.IdMoneda=@IdMoneda and (@IdListaPrecios<=0 or lpd.IdListaPrecios=@IdListaPrecios)
ORDER BY ListasPrecios.FechaVigencia DESC