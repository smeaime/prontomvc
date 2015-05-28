





























CREATE Procedure [dbo].[DetAcoTipos_T]
@IdDetalleAcoTipo int
AS 
SELECT *
FROM DetalleAcoTipos
where (IdDetalleAcoTipo=@IdDetalleAcoTipo)






























