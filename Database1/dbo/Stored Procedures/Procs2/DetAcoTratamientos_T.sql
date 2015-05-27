





























CREATE Procedure [dbo].[DetAcoTratamientos_T]
@IdDetalleAcoTratamiento int
AS 
SELECT *
FROM DetalleAcoTratamientos
where (IdDetalleAcoTratamiento=@IdDetalleAcoTratamiento)






























