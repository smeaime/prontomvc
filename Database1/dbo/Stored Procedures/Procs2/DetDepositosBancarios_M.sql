





























CREATE Procedure [dbo].[DetDepositosBancarios_M]
@IdDetalleDepositoBancario int,
@IdDepositoBancario int,
@IdValor int
as
Update DetalleDepositosBancarios
SET 
 IdDepositoBancario=@IdDepositoBancario,
 IdValor=@IdValor
where (IdDetalleDepositoBancario=@IdDetalleDepositoBancario)
Return(@IdDetalleDepositoBancario)






























