﻿






























CREATE Procedure [dbo].[DepositosBancarios_E]
@IdDepositoBancario int
AS 
Delete DepositosBancarios
where (IdDepositoBancario=@IdDepositoBancario)































