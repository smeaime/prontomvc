CREATE Procedure [dbo].[ListasPrecios_TX_Buscar]

@IdArticulo int,
@IdCliente int,
@IdListaPrecios int = Null

AS 

SET @IdListaPrecios=IsNull(@IdListaPrecios,0)
IF @IdListaPrecios=0
	SET @IdListaPrecios=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdListaPrecios'),0)

DECLARE @Registros int

IF @IdCliente>0 
   BEGIN
	SET @Registros=IsNull((Select Count(*) From ListasPreciosDetalle lpd
				Left Outer Join ListasPrecios On lpd.IdListaPrecios=ListasPrecios.IdListaPrecios
				Where lpd.IdArticulo=@IdArticulo and IsNull(lpd.IdCliente,0)=@IdCliente and IsNull(ListasPrecios.Activa,'SI')<>'NO' and 
					(@IdListaPrecios<=0 or lpd.IdListaPrecios=@IdListaPrecios)),0)
	IF @Registros=0
		SET @IdCliente=0 
   END

SELECT lpd.*
FROM ListasPreciosDetalle lpd
LEFT OUTER JOIN ListasPrecios ON lpd.IdListaPrecios=ListasPrecios.IdListaPrecios
WHERE lpd.IdArticulo=@IdArticulo and IsNull(lpd.IdCliente,0)=@IdCliente and IsNull(ListasPrecios.Activa,'SI')<>'NO' and (@IdListaPrecios<=0 or lpd.IdListaPrecios=@IdListaPrecios)
ORDER BY ListasPrecios.FechaVigencia DESC