﻿































CREATE Procedure [dbo].[AcoMateriales_T]
@IdAcoMaterial int
AS 
SELECT *
FROM AcoMateriales
where (IdAcoMaterial=@IdAcoMaterial)
































