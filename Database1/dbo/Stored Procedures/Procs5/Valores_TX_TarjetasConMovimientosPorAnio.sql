
CREATE Procedure [dbo].[Valores_TX_TarjetasConMovimientosPorAnio]

@IdTarjetaCredito int

AS 

SELECT DISTINCT Year(Valores.FechaComprobante) as [Año]
FROM Valores
WHERE IsNull(Valores.IdTarjetaCredito,0)=@IdTarjetaCredito
ORDER BY [Año] DESC
