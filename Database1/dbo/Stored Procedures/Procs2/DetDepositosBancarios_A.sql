



CREATE Procedure [dbo].[DetDepositosBancarios_A]
@IdDetalleDepositoBancario int  output,
@IdDepositoBancario int,
@IdValor int
AS 
Insert into [DetalleDepositosBancarios]
(
 IdDepositoBancario,
 IdValor
)
Values
(
 @IdDepositoBancario,
 @IdValor
)
Select @IdDetalleDepositoBancario=@@identity
Return(@IdDetalleDepositoBancario)



