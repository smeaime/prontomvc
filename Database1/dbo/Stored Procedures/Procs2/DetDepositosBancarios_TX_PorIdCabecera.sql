





























CREATE PROCEDURE [dbo].[DetDepositosBancarios_TX_PorIdCabecera]
@IdDepositoBancario int
AS
SELECT *
FROM DetalleDepositosBancarios DetDep
WHERE (DetDep.IdDepositoBancario = @IdDepositoBancario)






























