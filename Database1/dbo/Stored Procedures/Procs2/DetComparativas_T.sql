





























CREATE Procedure [dbo].[DetComparativas_T]
@IdDetalleComparativa int
AS 
SELECT *
FROM [DetalleComparativas]
where (IdDetalleComparativa=@IdDetalleComparativa)






























