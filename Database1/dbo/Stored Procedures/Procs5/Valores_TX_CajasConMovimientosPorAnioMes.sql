﻿
CREATE Procedure [dbo].[Valores_TX_CajasConMovimientosPorAnioMes]

@IdCaja Int,
@Anio int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdValor INTEGER,
			 Fecha DATETIME
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Valores.IdValor,
  Case When Valores.IdBancoDeposito is not null and Valores.FechaDeposito is not null 
	Then Valores.FechaDeposito
	Else Valores.FechaComprobante
  End
 FROM Valores
 WHERE IsNull(Valores.IdCaja,0)=@IdCaja and 
	Case When Valores.IdBancoDeposito is not null and Valores.FechaDeposito is not null 
		Then Year(Valores.FechaDeposito)
		Else Year(Valores.FechaComprobante)
	End=@Anio

SET NOCOUNT OFF

SELECT 
 MIN(CONVERT(varchar, MONTH(Fecha)) + '/' + CONVERT(varchar, YEAR(Fecha))) as [Período],
 YEAR(Fecha), 
 MONTH(Fecha),
 CASE 
	WHEN MONTH(Fecha)=1 THEN 'Enero'
	WHEN MONTH(Fecha)=2 THEN 'Febrero'
	WHEN MONTH(Fecha)=3 THEN 'Marzo'
	WHEN MONTH(Fecha)=4 THEN 'Abril'
	WHEN MONTH(Fecha)=5 THEN 'Mayo'
	WHEN MONTH(Fecha)=6 THEN 'Junio'
	WHEN MONTH(Fecha)=7 THEN 'Julio'
	WHEN MONTH(Fecha)=8 THEN 'Agosto'
	WHEN MONTH(Fecha)=9 THEN 'Setiembre'
	WHEN MONTH(Fecha)=10 THEN 'Octubre'
	WHEN MONTH(Fecha)=11 THEN 'Noviembre'
	WHEN MONTH(Fecha)=12 THEN 'Diciembre'
	ELSE 'Error'
 END as [Mes]
FROM #Auxiliar1
GROUP BY YEAR(Fecha), MONTH(Fecha) 
ORDER by YEAR(Fecha) desc, MONTH(Fecha) desc

DROP TABLE #Auxiliar1
