




CREATE Procedure [dbo].[DetObrasRecepciones_E]
@IdDetalleObraRecepcion int  
As 
Delete [DetalleObrasRecepciones]
Where (IdDetalleObraRecepcion=@IdDetalleObraRecepcion)





