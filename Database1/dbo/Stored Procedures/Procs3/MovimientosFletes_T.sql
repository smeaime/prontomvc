
CREATE Procedure [dbo].[MovimientosFletes_T]

@IdMovimientoFlete int

AS 

SELECT *
FROM MovimientosFletes
WHERE (IdMovimientoFlete=@IdMovimientoFlete)
