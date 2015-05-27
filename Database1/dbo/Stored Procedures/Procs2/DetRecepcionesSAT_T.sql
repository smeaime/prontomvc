
CREATE Procedure [dbo].[DetRecepcionesSAT_T]
@IdDetalleRecepcion int
AS 
SELECT *
FROM [DetalleRecepcionesSAT]
WHERE (IdDetalleRecepcion=@IdDetalleRecepcion)
