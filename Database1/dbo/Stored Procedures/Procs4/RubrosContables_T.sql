﻿

































CREATE Procedure [dbo].[RubrosContables_T]
@IdRubroContable int
AS 
SELECT *
FROM RubrosContables
WHERE (IdRubroContable=@IdRubroContable)


































