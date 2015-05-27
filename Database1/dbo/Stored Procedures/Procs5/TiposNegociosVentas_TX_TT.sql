CREATE Procedure [dbo].[TiposNegociosVentas_TX_TT]

@IdTipoNegocioVentas int

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111133'
SET @vector_T='0494400'

SELECT 
 TiposNegociosVentas.IdTipoNegocioVentas as [IdTipoNegocioVentas],
 TiposNegociosVentas.Codigo as [Codigo],
 TiposNegociosVentas.IdTipoNegocioVentas as [IdAux],
 TiposNegociosVentas.Descripcion as [Tipo compra],
 TiposNegociosVentas.Grupo as [Grupo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM TiposNegociosVentas
WHERE TiposNegociosVentas.IdTipoNegocioVentas=@IdTipoNegocioVentas