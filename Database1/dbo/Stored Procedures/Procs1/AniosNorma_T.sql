﻿































CREATE Procedure [dbo].[AniosNorma_T]
@IdAnioNorma int
AS 
SELECT IdAnioNorma, Descripcion
FROM AniosNorma
where (IdAnioNorma=@IdAnioNorma)
































