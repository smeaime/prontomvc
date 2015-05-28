CREATE Procedure [dbo].[DetConjuntos_E]

@IdDetalleConjunto int  

AS

DELETE [DetalleConjuntos]
WHERE (IdDetalleConjunto=@IdDetalleConjunto)