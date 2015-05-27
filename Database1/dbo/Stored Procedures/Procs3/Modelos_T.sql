





























CREATE Procedure [dbo].[Modelos_T]
@IdModelo int
AS 
SELECT IdModelo, Descripcion
FROM Modelos
where (IdModelo=@IdModelo)






























