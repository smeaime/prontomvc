





























CREATE Procedure [dbo].[Grados_T]
@IdGrado int
AS 
SELECT IdGrado, Descripcion
FROM Grados
where (IdGrado=@IdGrado)






























