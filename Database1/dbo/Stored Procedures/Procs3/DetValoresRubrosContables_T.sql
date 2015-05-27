
CREATE Procedure [dbo].[DetValoresRubrosContables_T]
@IdDetalleValorRubrosContables int
AS 
SELECT *
FROM DetalleValoresRubrosContables
WHERE (IdDetalleValorRubrosContables=@IdDetalleValorRubrosContables)
