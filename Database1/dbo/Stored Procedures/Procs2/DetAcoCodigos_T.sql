





























CREATE Procedure [dbo].[DetAcoCodigos_T]
@IdDetalleAcoCodigo int
AS 
SELECT *
FROM DetalleAcoCodigos
where (IdDetalleAcoCodigo=@IdDetalleAcoCodigo)






























