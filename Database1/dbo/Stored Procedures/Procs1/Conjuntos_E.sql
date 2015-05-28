
CREATE Procedure [dbo].[Conjuntos_E]

@IdConjunto int  

AS

DELETE Conjuntos
WHERE (IdConjunto=@IdConjunto)
