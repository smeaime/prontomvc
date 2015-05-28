
CREATE Procedure [dbo].[OtrosIngresosAlmacenSAT_TXMes]

@Anio int

AS

SELECT Min(CONVERT(varchar,MONTH(FechaOtroIngresoAlmacen)) + '/' + 
	CONVERT(varchar, YEAR(FechaOtroIngresoAlmacen)) )  as [Periodo],
	YEAR(FechaOtroIngresoAlmacen), 
	MONTH(FechaOtroIngresoAlmacen),
	CASE 
		WHEN MONTH(FechaOtroIngresoAlmacen)=1 THEN 'Enero'
		WHEN MONTH(FechaOtroIngresoAlmacen)=2 THEN 'Febrero'
		WHEN MONTH(FechaOtroIngresoAlmacen)=3 THEN 'Marzo'
		WHEN MONTH(FechaOtroIngresoAlmacen)=4 THEN 'Abril'
		WHEN MONTH(FechaOtroIngresoAlmacen)=5 THEN 'Mayo'
		WHEN MONTH(FechaOtroIngresoAlmacen)=6 THEN 'Junio'
		WHEN MONTH(FechaOtroIngresoAlmacen)=7 THEN 'Julio'
		WHEN MONTH(FechaOtroIngresoAlmacen)=8 THEN 'Agosto'
		WHEN MONTH(FechaOtroIngresoAlmacen)=9 THEN 'Setiembre'
		WHEN MONTH(FechaOtroIngresoAlmacen)=10 THEN 'Octubre'
		WHEN MONTH(FechaOtroIngresoAlmacen)=11 THEN 'Noviembre'
		WHEN MONTH(FechaOtroIngresoAlmacen)=12 THEN 'Diciembre'
		ELSE 'Error'
	END as [Mes]
FROM OtrosIngresosAlmacenSAT
WHERE YEAR(FechaOtroIngresoAlmacen)=@Anio
GROUP BY  YEAR(FechaOtroIngresoAlmacen) , MONTH(FechaOtroIngresoAlmacen)  
ORDER by  YEAR(FechaOtroIngresoAlmacen)  desc , MONTH(FechaOtroIngresoAlmacen)  desc
