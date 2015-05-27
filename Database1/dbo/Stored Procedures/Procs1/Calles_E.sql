CREATE Procedure [dbo].[Calles_E]

@IdCalle int  

AS 

DELETE Calles
WHERE (IdCalle=@IdCalle)