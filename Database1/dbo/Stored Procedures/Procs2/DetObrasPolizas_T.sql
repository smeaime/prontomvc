


CREATE Procedure [dbo].[DetObrasPolizas_T]
@IdDetalleObraPoliza int
AS 
SELECT *
FROM [DetalleObrasPolizas]
WHERE (IdDetalleObraPoliza=@IdDetalleObraPoliza)


