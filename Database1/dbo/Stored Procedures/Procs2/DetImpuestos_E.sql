CREATE Procedure [dbo].[DetImpuestos_E]

@IdDetalleImpuesto int  

AS

DELETE DetalleImpuestos
WHERE (IdDetalleImpuesto=@IdDetalleImpuesto)