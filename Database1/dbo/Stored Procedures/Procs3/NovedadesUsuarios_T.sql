﻿































CREATE Procedure [dbo].[NovedadesUsuarios_T]
@IdNovedadUsuarios int
AS 
SELECT *
FROM NovedadesUsuarios
where (IdNovedadUsuarios=@IdNovedadUsuarios)
































