CREATE Procedure [dbo].[Colores_E]

@IdColor int  

AS 

DELETE Colores
WHERE (IdColor=@IdColor)