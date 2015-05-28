CREATE Procedure [dbo].[Impuestos_T]

@IdImpuesto int

AS 

SELECT *
FROM Impuestos
WHERE (IdImpuesto=@IdImpuesto)