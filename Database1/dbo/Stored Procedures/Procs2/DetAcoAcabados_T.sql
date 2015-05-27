





























CREATE Procedure [dbo].[DetAcoAcabados_T]
@IdDetalleAcoAcabado int
AS 
SELECT *
FROM DetalleAcoAcabados
where (IdDetalleAcoAcabado=@IdDetalleAcoAcabado)






























