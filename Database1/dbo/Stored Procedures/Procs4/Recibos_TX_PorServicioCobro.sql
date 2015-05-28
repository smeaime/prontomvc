CREATE Procedure [dbo].[Recibos_TX_PorServicioCobro]

@ServicioCobro varchar(10),
@LoteServicioCobro varchar(15)

AS 

SELECT TOP 1 Recibos.NumeroRecibo
FROM Recibos
WHERE ServicioCobro=@ServicioCobro and LoteServicioCobro=@LoteServicioCobro and IsNull(Anulado,'NO')<>'SI'