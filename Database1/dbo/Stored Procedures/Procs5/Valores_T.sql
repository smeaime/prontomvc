﻿

































CREATE Procedure [dbo].[Valores_T]
@IdValor int
AS 
SELECT *
FROM Valores
where (IdValor=@IdValor)


































