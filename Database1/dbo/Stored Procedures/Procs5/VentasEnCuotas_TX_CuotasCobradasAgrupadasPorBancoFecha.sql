












CREATE Procedure [dbo].[VentasEnCuotas_TX_CuotasCobradasAgrupadasPorBancoFecha]

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0111633'
Set @vector_T='0557500'

SELECT DISTINCT 
 0 as [IdNro],
 Bancos.Codigo as [Codigo],
 Bancos.Nombre as [Ente Recaudador],
 DetVta.FechaCobranza as [Fecha Cobranza],
 SUM(DetVta.ImporteCobrado) as [Importe Cobrado],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleVentasEnCuotas DetVta
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DetVta.IdBanco
WHERE DetVta.FechaCobranza is not null and DetVta.IdBanco is not null
GROUP BY DetVta.IdBanco,DetVta.FechaCobranza,Bancos.Codigo,Bancos.Nombre
ORDER by DetVta.FechaCobranza,Bancos.Nombre












