
CREATE Procedure [dbo].[DetValoresRubrosContables_E]
@IdDetalleValorRubrosContables int
As 
Delete DetalleValoresRubrosContables
Where (IdDetalleValorRubrosContables=@IdDetalleValorRubrosContables)
