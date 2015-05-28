





























CREATE Procedure [dbo].[Rangos_T]
@IdRango int
AS 
SELECT IdRango, Descripcion
FROM Rangos
where (IdRango=@IdRango)






























