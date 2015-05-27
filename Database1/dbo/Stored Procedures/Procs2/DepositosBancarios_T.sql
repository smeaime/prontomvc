






























CREATE Procedure [dbo].[DepositosBancarios_T]
@IdDepositoBancario int
AS 
SELECT *
FROM DepositosBancarios
where (IdDepositoBancario=@IdDepositoBancario)































