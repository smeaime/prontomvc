
CREATE Procedure [dbo].[RecepcionesSAT_TXMes]

@Anio int

AS

SELECT Min(CONVERT(varchar,MONTH(FechaRecepcion)) + '/' + 
		CONVERT(varchar, YEAR(FechaRecepcion)) ) as [Periodo],
	YEAR(FechaRecepcion), MONTH(FechaRecepcion),
	CASE 
		WHEN MONTH(FechaRecepcion)=1 THEN 'Enero'
		WHEN MONTH(FechaRecepcion)=2 THEN 'Febrero'
		WHEN MONTH(FechaRecepcion)=3 THEN 'Marzo'
		WHEN MONTH(FechaRecepcion)=4 THEN 'Abril'
		WHEN MONTH(FechaRecepcion)=5 THEN 'Mayo'
		WHEN MONTH(FechaRecepcion)=6 THEN 'Junio'
		WHEN MONTH(FechaRecepcion)=7 THEN 'Julio'
		WHEN MONTH(FechaRecepcion)=8 THEN 'Agosto'
		WHEN MONTH(FechaRecepcion)=9 THEN 'Setiembre'
		WHEN MONTH(FechaRecepcion)=10 THEN 'Octubre'
		WHEN MONTH(FechaRecepcion)=11 THEN 'Noviembre'
		WHEN MONTH(FechaRecepcion)=12 THEN 'Diciembre'
		ELSE 'Error'
	END as [Mes]
FROM RecepcionesSAT
WHERE YEAR(FechaRecepcion)=@Anio
GROUP BY YEAR(FechaRecepcion), MONTH(FechaRecepcion)  
ORDER BY YEAR(FechaRecepcion) desc, MONTH(FechaRecepcion) desc
