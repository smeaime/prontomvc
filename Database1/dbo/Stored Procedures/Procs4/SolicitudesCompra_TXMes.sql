



CREATE Procedure [dbo].[SolicitudesCompra_TXMes]
@Anio int
AS
SELECT 
 Min(CONVERT(varchar,MONTH(FechaSolicitud)) + '/' + 
	CONVERT(varchar, YEAR(FechaSolicitud)) )  as Período,
 YEAR(FechaSolicitud), 
 MONTH(FechaSolicitud),
 CASE 
	WHEN MONTH(FechaSolicitud)=1 THEN 'Enero'
	WHEN MONTH(FechaSolicitud)=2 THEN 'Febrero'
	WHEN MONTH(FechaSolicitud)=3 THEN 'Marzo'
	WHEN MONTH(FechaSolicitud)=4 THEN 'Abril'
	WHEN MONTH(FechaSolicitud)=5 THEN 'Mayo'
	WHEN MONTH(FechaSolicitud)=6 THEN 'Junio'
	WHEN MONTH(FechaSolicitud)=7 THEN 'Julio'
	WHEN MONTH(FechaSolicitud)=8 THEN 'Agosto'
	WHEN MONTH(FechaSolicitud)=9 THEN 'Setiembre'
	WHEN MONTH(FechaSolicitud)=10 THEN 'Octubre'
	WHEN MONTH(FechaSolicitud)=11 THEN 'Noviembre'
	WHEN MONTH(FechaSolicitud)=12 THEN 'Diciembre'
	ELSE 'Error'
 END as Mes
FROM SolicitudesCompra
WHERE YEAR(FechaSolicitud)=@Anio
GROUP BY  YEAR(FechaSolicitud) , MONTH(FechaSolicitud)  
ORDER by  YEAR(FechaSolicitud)  desc , MONTH(FechaSolicitud)  desc



