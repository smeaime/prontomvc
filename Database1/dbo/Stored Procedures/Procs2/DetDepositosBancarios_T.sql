





























CREATE Procedure [dbo].[DetDepositosBancarios_T]
@IdDetalleDepositoBancario int
AS 
SELECT *
FROM DetalleDepositosBancarios
where (IdDetalleDepositoBancario=@IdDetalleDepositoBancario)






























