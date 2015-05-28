CREATE Procedure [dbo].[Impuestos_E]

@IdImpuesto int 

AS 

DELETE DetalleImpuestos
WHERE (IdImpuesto=@IdImpuesto)

DELETE Impuestos
WHERE (IdImpuesto=@IdImpuesto)