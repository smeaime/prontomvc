﻿


































CREATE Procedure [dbo].[Articulos_T]
@IdArticulo int
AS 
SELECT *
FROM Articulos
where (IdArticulo=@IdArticulo)



































