﻿































CREATE Procedure [dbo].[AcoMarcas_T]
@IdAcoMarca int
AS 
SELECT *
FROM AcoMarcas
where (IdAcoMarca=@IdAcoMarca)
































