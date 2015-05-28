
CREATE  Procedure [dbo].[LiquidacionesFletes_TL]

AS 

SELECT 
 LiquidacionesFletes.IdLiquidacionFlete as [IdLiquidacionFlete],
 Substring('000000',1,6-Len(Convert(varchar,LiquidacionesFletes.NumeroLiquidacion)))+Convert(varchar,LiquidacionesFletes.NumeroLiquidacion)+
	' ('+Transportistas.RazonSocial+')' as [Titulo]
FROM LiquidacionesFletes
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista = LiquidacionesFletes.IdTransportista
ORDER BY LiquidacionesFletes.NumeroLiquidacion
