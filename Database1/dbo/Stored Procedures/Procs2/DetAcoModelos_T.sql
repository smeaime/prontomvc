





























CREATE Procedure [dbo].[DetAcoModelos_T]
@IdDetalleAcoModelo int
AS 
SELECT *
FROM DetalleAcoModelos
where (IdDetalleAcoModelo=@IdDetalleAcoModelo)






























