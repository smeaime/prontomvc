﻿





























CREATE Procedure [dbo].[DetDepositosBancarios_E]
@IdDetalleDepositoBancario int
AS 
Delete DetalleDepositosBancarios
where (IdDetalleDepositoBancario=@IdDetalleDepositoBancario)






























