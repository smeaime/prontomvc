﻿































CREATE Procedure [dbo].[AnexosEquipos_T]
@IdAnexoEquipos int
AS 
SELECT *
FROM AnexosEquipos
where (IdAnexoEquipos=@IdAnexoEquipos)
































