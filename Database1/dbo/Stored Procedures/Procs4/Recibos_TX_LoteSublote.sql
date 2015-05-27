



CREATE Procedure [dbo].[Recibos_TX_LoteSublote]
@Lote int,
@Sublote int,
@FechaLote datetime
AS 
SELECT *
FROM Recibos
WHERE Lote=@Lote and 
	Sublote=@Sublote and 
	FechaLote=@FechaLote and 
	IsNull(Anulado,'NO')<>'SI'



