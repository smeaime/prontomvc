CREATE Procedure [dbo].[Valores_TX_GastosPorAnio]

@Estado varchar(1) = Null

AS

SET @Estado=IsNull(@Estado,'G')

SELECT MIN(CONVERT(varchar, YEAR(FechaComprobante))) AS Período,YEAR(FechaComprobante)
FROM Valores
WHERE Valores.Estado=@Estado
GROUP BY YEAR(FechaComprobante) 
ORDER BY YEAR(FechaComprobante) desc 
