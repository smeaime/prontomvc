﻿

































CREATE Procedure [dbo].[Articulos_TX_PorId]
@IdArticulo int
AS 
SELECT *
FROM Articulos
WHERE (IdArticulo=@IdArticulo)


































