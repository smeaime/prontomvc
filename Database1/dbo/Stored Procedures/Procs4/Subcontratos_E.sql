CREATE Procedure [dbo].[Subcontratos_E]

@IdSubcontrato int  

AS 

DELETE SubcontratosPxQ
WHERE (IdSubcontrato=@IdSubcontrato)

DELETE Subcontratos
WHERE (IdSubcontrato=@IdSubcontrato)