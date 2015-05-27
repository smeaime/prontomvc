
CREATE Procedure [dbo].[wFondosFijos_E]

@IdFondoFijo int  

AS 

DELETE FondosFijos
WHERE (IdFondoFijo=@IdFondoFijo)

