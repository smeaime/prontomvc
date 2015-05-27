































CREATE Procedure [dbo].[AcoTiposRosca_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoTiposRosca.IdTipoRosca, 
TiposRosca.Descripcion as Titulo
FROM DetalleAcoTiposRosca 
INNER JOIN AcoTiposRosca ON DetalleAcoTiposRosca.IdAcoTipoRosca = AcoTiposRosca.IdAcoTipoRosca 
INNER JOIN TiposRosca ON DetalleAcoTiposRosca.IdTipoRosca = TiposRosca.IdTipoRosca
WHERE AcoTiposRosca.IdRubro = @Rubro AND AcoTiposRosca.IdSubRubro = @Subrubro
































