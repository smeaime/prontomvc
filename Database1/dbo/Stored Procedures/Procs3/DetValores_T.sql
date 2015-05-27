





























CREATE Procedure [dbo].[DetValores_T]
@IdDetalleValor int
AS 
SELECT *
FROM [DetalleValores]
where (IdDetalleValor=@IdDetalleValor)






























