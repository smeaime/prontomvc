





CREATE Procedure [dbo].[PosicionesImportacion_TX_Existente]
@CodigoPosicion varchar(15)
AS 
SELECT *
FROM PosicionesImportacion
WHERE CodigoPosicion=@CodigoPosicion





