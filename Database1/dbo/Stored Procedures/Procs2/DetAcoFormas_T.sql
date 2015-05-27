





























CREATE Procedure [dbo].[DetAcoFormas_T]
@IdDetalleAcoForma int
AS 
SELECT *
FROM DetalleAcoFormas
where (IdDetalleAcoForma=@IdDetalleAcoForma)






























