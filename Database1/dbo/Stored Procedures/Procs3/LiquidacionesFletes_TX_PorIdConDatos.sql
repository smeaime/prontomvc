
CREATE Procedure [dbo].[LiquidacionesFletes_TX_PorIdConDatos]

@IdLiquidacionFlete int

AS 

SELECT LiquidacionesFletes.*, Transportistas.IdProveedor, (Select Sum(dlf.Importe) From DetalleLiquidacionesFletes dlf Where dlf.IdLiquidacionFlete=@IdLiquidacionFlete) as [Importe],
	(Select Top 1 cp.NumeroReferencia From ComprobantesProveedores cp Where cp.IdLiquidacionFlete=@IdLiquidacionFlete) as [NumeroReferencia]
FROM LiquidacionesFletes
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista=LiquidacionesFletes.IdTransportista
WHERE LiquidacionesFletes.IdLiquidacionFlete=@IdLiquidacionFlete
