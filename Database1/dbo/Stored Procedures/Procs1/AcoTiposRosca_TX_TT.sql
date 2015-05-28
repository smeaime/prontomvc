﻿































CREATE Procedure [dbo].[AcoTiposRosca_TX_TT]
@IdAcoTipoRosca int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='04400'
Select 
AcoTiposRosca.IdAcoTipoRosca,
Rubros.Descripcion as Rubro,
Subrubros.Descripcion as Subrubro,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM AcoTiposRosca
INNER JOIN Rubros ON AcoTiposRosca.IdRubro = Rubros.IdRubro
INNER JOIN Subrubros ON AcoTiposRosca.IdSubrubro = Subrubros.IdSubrubro
where (IdAcoTipoRosca=@IdAcoTipoRosca)
































