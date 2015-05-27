





























CREATE Procedure [dbo].[DetValesSalida_T]
@IdDetalleValeSalida int
AS 
SELECT *
FROM [DetalleValesSalida]
where (IdDetalleValeSalida=@IdDetalleValeSalida)






























