﻿































CREATE Procedure [dbo].[Obras_T]
@IdObra int
AS 
SELECT *
FROM Obras
where (IdObra=@IdObra)
































