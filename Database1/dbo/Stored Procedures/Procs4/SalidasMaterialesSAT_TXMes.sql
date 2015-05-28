
CREATE Procedure [dbo].[SalidasMaterialesSAT_TXMes]

@Anio int

AS

SELECT Min(CONVERT(varchar,MONTH(FechaSalidaMateriales)) + '/' + 
		CONVERT(varchar, YEAR(FechaSalidaMateriales)) )  as [Periodo],
	YEAR(FechaSalidaMateriales), MONTH(FechaSalidaMateriales),
	CASE 
		WHEN MONTH(FechaSalidaMateriales)=1 THEN 'Enero'
		WHEN MONTH(FechaSalidaMateriales)=2 THEN 'Febrero'
		WHEN MONTH(FechaSalidaMateriales)=3 THEN 'Marzo'
		WHEN MONTH(FechaSalidaMateriales)=4 THEN 'Abril'
		WHEN MONTH(FechaSalidaMateriales)=5 THEN 'Mayo'
		WHEN MONTH(FechaSalidaMateriales)=6 THEN 'Junio'
		WHEN MONTH(FechaSalidaMateriales)=7 THEN 'Julio'
		WHEN MONTH(FechaSalidaMateriales)=8 THEN 'Agosto'
		WHEN MONTH(FechaSalidaMateriales)=9 THEN 'Setiembre'
		WHEN MONTH(FechaSalidaMateriales)=10 THEN 'Octubre'
		WHEN MONTH(FechaSalidaMateriales)=11 THEN 'Noviembre'
		WHEN MONTH(FechaSalidaMateriales)=12 THEN 'Diciembre'
		ELSE 'Error'
	END as Mes
FROM SalidasMaterialesSAT
WHERE YEAR(FechaSalidaMateriales)=@Anio
GROUP BY YEAR(FechaSalidaMateriales), MONTH(FechaSalidaMateriales)  
ORDER BY YEAR(FechaSalidaMateriales) desc, MONTH(FechaSalidaMateriales) desc
