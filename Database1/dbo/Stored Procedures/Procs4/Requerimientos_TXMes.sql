



CREATE Procedure [dbo].[Requerimientos_TXMes]
@Anio int
AS
SELECT 
 Min(CONVERT(varchar,MONTH(FechaRequerimiento)) + '/' + 
	CONVERT(varchar, YEAR(FechaRequerimiento)) )  as Período,
 YEAR(FechaRequerimiento), 
 MONTH(FechaRequerimiento),
 CASE 
	WHEN MONTH(FechaRequerimiento)=1 THEN 'Enero'
	WHEN MONTH(FechaRequerimiento)=2 THEN 'Febrero'
	WHEN MONTH(FechaRequerimiento)=3 THEN 'Marzo'
	WHEN MONTH(FechaRequerimiento)=4 THEN 'Abril'
	WHEN MONTH(FechaRequerimiento)=5 THEN 'Mayo'
	WHEN MONTH(FechaRequerimiento)=6 THEN 'Junio'
	WHEN MONTH(FechaRequerimiento)=7 THEN 'Julio'
	WHEN MONTH(FechaRequerimiento)=8 THEN 'Agosto'
	WHEN MONTH(FechaRequerimiento)=9 THEN 'Setiembre'
	WHEN MONTH(FechaRequerimiento)=10 THEN 'Octubre'
	WHEN MONTH(FechaRequerimiento)=11 THEN 'Noviembre'
	WHEN MONTH(FechaRequerimiento)=12 THEN 'Diciembre'
	ELSE 'Error'
 END as Mes
FROM Requerimientos
WHERE YEAR(FechaRequerimiento)=@Anio
GROUP BY  YEAR(FechaRequerimiento) , MONTH(FechaRequerimiento)  
ORDER by  YEAR(FechaRequerimiento)  desc , MONTH(FechaRequerimiento)  desc



