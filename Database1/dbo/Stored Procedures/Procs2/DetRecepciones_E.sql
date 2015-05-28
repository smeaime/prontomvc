


CREATE Procedure [dbo].[DetRecepciones_E]
@IdDetalleRecepcion int  
AS 
DELETE [DetalleRecepciones]
WHERE (IdDetalleRecepcion=@IdDetalleRecepcion)


