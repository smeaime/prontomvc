﻿

































CREATE Procedure [dbo].[Parametros_T]
@IdParametro int
AS 
SELECT *
FROM Parametros
where (IdParametro=@IdParametro)


































