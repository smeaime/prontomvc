





























CREATE Procedure [dbo].[DetAcoTiposRosca_T]
@IdDetalleAcoTipoRosca int
AS 
SELECT *
FROM DetalleAcoTiposRosca
where (IdDetalleAcoTipoRosca=@IdDetalleAcoTipoRosca)






























