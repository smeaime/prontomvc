
CREATE Procedure [dbo].[Valores_TX_CajasConMovimientosPorAnio]

@IdCaja int

AS 

SELECT DISTINCT
 Case When Valores.IdBancoDeposito is not null and Valores.FechaDeposito is not null 
	Then Year(Valores.FechaDeposito)
	Else Year(Valores.FechaComprobante)
 End as [Año]
FROM Valores
WHERE IsNull(Valores.IdCaja,0)=@IdCaja
ORDER BY [Año] DESC
