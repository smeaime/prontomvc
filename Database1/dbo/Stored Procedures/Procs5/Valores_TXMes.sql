
CREATE Procedure [dbo].[Valores_TXMes]

@Anio int

As

SELECT 
 Min(CONVERT(varchar, MONTH(FechaValor)) + '/' + CONVERT(varchar, YEAR(FechaValor)) )  AS Período,
 YEAR(FechaValor), 
 MONTH(FechaValor),
 CASE 
	WHEN MONTH(FechaValor)=1 THEN 'Enero'
	WHEN MONTH(FechaValor)=2 THEN 'Febrero'
	WHEN MONTH(FechaValor)=3 THEN 'Marzo'
	WHEN MONTH(FechaValor)=4 THEN 'Abril'
	WHEN MONTH(FechaValor)=5 THEN 'Mayo'
	WHEN MONTH(FechaValor)=6 THEN 'Junio'
	WHEN MONTH(FechaValor)=7 THEN 'Julio'
	WHEN MONTH(FechaValor)=8 THEN 'Agosto'
	WHEN MONTH(FechaValor)=9 THEN 'Setiembre'
	WHEN MONTH(FechaValor)=10 THEN 'Octubre'
	WHEN MONTH(FechaValor)=11 THEN 'Noviembre'
	WHEN MONTH(FechaValor)=12 THEN 'Diciembre'
	ELSE 'Error'
 END as Mes
FROM Valores
WHERE YEAR(FechaValor)=@Anio
GROUP BY YEAR(FechaValor) , MONTH(FechaValor)  
ORDER BY YEAR(FechaValor)  desc , MONTH(FechaValor)  desc
