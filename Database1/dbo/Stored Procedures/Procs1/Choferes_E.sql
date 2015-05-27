
CREATE Procedure [dbo].[Choferes_E]

@IdChofer int  

AS 

DELETE Choferes
WHERE (IdChofer=@IdChofer)
