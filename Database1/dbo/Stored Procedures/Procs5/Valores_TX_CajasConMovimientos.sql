
CREATE Procedure [dbo].[Valores_TX_CajasConMovimientos]

AS 

SELECT 
 Cajas.IdCaja,
 Cajas.Descripcion
FROM Valores
LEFT OUTER JOIN Cajas ON Cajas.IdCaja=Valores.IdCaja
WHERE Valores.IdCaja is not null
GROUP BY Cajas.IdCaja, Cajas.Descripcion
ORDER BY Cajas.Descripcion
