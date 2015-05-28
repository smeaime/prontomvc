CREATE Procedure [dbo].[DetConjuntos_T]

@IdDetalleConjunto int

AS 

SELECT *
FROM [DetalleConjuntos]
WHERE (IdDetalleConjunto=@IdDetalleConjunto)