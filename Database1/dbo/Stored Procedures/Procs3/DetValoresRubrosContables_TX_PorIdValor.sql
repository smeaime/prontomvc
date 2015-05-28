
CREATE PROCEDURE [dbo].[DetValoresRubrosContables_TX_PorIdValor]
@IdValor int
AS
SELECT *
FROM DetalleValoresRubrosContables 
WHERE (DetalleValoresRubrosContables.IdValor = @IdValor)
