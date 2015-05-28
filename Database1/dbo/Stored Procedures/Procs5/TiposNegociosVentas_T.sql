CREATE Procedure [dbo].[TiposNegociosVentas_T]

@IdTipoNegocioVentas int

AS 

SELECT*
FROM TiposNegociosVentas
WHERE (IdTipoNegocioVentas=@IdTipoNegocioVentas)