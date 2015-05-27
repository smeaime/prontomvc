CREATE Procedure [dbo].[TiposNegociosVentas_E]

@IdTipoNegocioVentas int  

AS 

DELETE TiposNegociosVentas
WHERE (IdTipoNegocioVentas=@IdTipoNegocioVentas)