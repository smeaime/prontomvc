


CREATE Procedure [dbo].[DetObrasPolizas_E]
@IdDetalleObraPoliza int  
AS 
DELETE [DetalleObrasPolizas]
WHERE (IdDetalleObraPoliza=@IdDetalleObraPoliza)


