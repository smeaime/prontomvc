
CREATE Procedure [dbo].[Fletes_E]

@IdFlete int  

AS 

DELETE Fletes
WHERE (IdFlete=@IdFlete)
