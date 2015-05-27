


CREATE Procedure [dbo].[DetObrasRecepciones_T]
@IdDetalleObraRecepcion int
AS 
SELECT *
FROM [DetalleObrasRecepciones]
WHERE (IdDetalleObraRecepcion=@IdDetalleObraRecepcion)


