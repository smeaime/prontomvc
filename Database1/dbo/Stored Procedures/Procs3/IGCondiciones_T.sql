





























CREATE Procedure [dbo].[IGCondiciones_T]
@IdIGCondicion int
AS 
SELECT IdIGCondicion, Descripcion
FROM IGCondiciones
where (IdIGCondicion=@IdIGCondicion)






























