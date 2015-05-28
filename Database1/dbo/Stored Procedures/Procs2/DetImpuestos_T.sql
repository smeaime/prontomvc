CREATE Procedure [dbo].[DetImpuestos_T]

@IdDetalleImpuesto int

AS 

SELECT *
FROM DetalleImpuestos
WHERE (IdDetalleImpuesto=@IdDetalleImpuesto)