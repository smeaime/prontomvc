﻿































CREATE Procedure [dbo].[ValoresIngresos_T]
@IdValorIngreso int
AS 
SELECT *
FROM ValoresIngresos
WHERE (IdValorIngreso=@IdValorIngreso)
































