





























CREATE Procedure [dbo].[TareasFijas_T]
@IdTareaFija int
AS 
SELECT*
FROM TareasFijas
where (IdTareaFija=@IdTareaFija)






























