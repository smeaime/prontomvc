﻿





























CREATE Procedure [dbo].[DetAcoModelos_TXPrimero]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select TOP 1
DetalleAcoModelos.IdDetalleAcoModelo,
DetalleAcoModelos.IdModelo,
Modelos.Descripcion as Modelo,
DetalleAcoModelos.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoModelos
INNER JOIN Modelos ON DetalleAcoModelos.IdModelo = Modelos.IdModelo






























