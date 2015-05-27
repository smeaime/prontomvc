





























CREATE Procedure [dbo].[DetAcopiosRevisiones_T]
@IdDetalleAcopiosRevisiones int
AS 
SELECT *
FROM DetalleAcopiosRevisiones
where (IdDetalleAcopiosRevisiones=@IdDetalleAcopiosRevisiones)






























