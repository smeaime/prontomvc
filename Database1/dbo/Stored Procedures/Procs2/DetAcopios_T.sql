





























CREATE Procedure [dbo].[DetAcopios_T]
@IdDetalleAcopios int
AS 
SELECT *
FROM [DetalleAcopios]
where (IdDetalleAcopios=@IdDetalleAcopios)






























