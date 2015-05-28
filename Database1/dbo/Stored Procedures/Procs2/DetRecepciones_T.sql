


CREATE Procedure [dbo].[DetRecepciones_T]
@IdDetalleRecepcion int
AS 
SELECT *
FROM [DetalleRecepciones]
WHERE (IdDetalleRecepcion=@IdDetalleRecepcion)


