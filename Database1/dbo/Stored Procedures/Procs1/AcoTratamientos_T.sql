﻿































CREATE Procedure [dbo].[AcoTratamientos_T]
@IdAcoTratamiento int
AS 
SELECT *
FROM AcoTratamientos
where (IdAcoTratamiento=@IdAcoTratamiento)
































