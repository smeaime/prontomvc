




CREATE Procedure [dbo].[EstadosVentasEnCuotas_TX_ParaCombo]
AS 
SELECT 
 IdEstadoVentaEnCuotas,
 Descripcion as [Titulo]
FROM EstadosVentasEnCuotas
ORDER BY Descripcion




