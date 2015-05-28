
CREATE Procedure [dbo].[MovimientosFletes_E]

@IdMovimientoFlete int 

AS 

DELETE MovimientosFletes
WHERE (IdMovimientoFlete=@IdMovimientoFlete)
