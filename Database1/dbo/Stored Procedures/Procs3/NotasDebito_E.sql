﻿






























CREATE Procedure [dbo].[NotasDebito_E]
@IdNotaDebito int
AS 
Delete NotasDebito
where (IdNotaDebito=@IdNotaDebito)































