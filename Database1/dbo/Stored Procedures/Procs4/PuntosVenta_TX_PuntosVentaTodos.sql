CREATE Procedure [dbo].[PuntosVenta_TX_PuntosVentaTodos]

AS 

SELECT 
 IdPuntoVenta,
 Substring('0000',1,4-Len(Convert(varchar,PuntoVenta)))+Convert(varchar,PuntoVenta) as [Titulo]
FROM PuntosVenta
WHERE IsNull(Activo,'SI')='SI'
ORDER by PuntoVenta