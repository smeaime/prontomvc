



CREATE Procedure [dbo].[Requerimientos_T]
@IdRequerimiento int
AS 
SELECT * 
FROM Requerimientos
WHERE (IdRequerimiento=@IdRequerimiento)



