﻿





























CREATE Procedure [dbo].[DetAcoTiposRosca_TXDetAco]
@IdAcoTipoRosca int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select 
DetalleAcoTiposRosca.IdDetalleAcoTipoRosca,
DetalleAcoTiposRosca.IdTipoRosca,
TiposRosca.Descripcion as TipoRosca,
DetalleAcoTiposRosca.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoTiposRosca
INNER JOIN TiposRosca ON DetalleAcoTiposRosca.IdTipoRosca = TiposRosca.IdTipoRosca
WHERE (DetalleAcoTiposRosca.IdAcoTipoRosca = @IdAcoTipoRosca)






























