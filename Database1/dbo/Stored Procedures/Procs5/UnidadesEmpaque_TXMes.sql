
CREATE Procedure [dbo].[UnidadesEmpaque_TXMes]

@Anio int

AS

SELECT Min(Convert(varchar,Month(FechaAlta)) + '/' +Convert(varchar, Year(FechaAlta)) )  as [Período], Year(FechaAlta),  Month(FechaAlta),
 Case When Month(FechaAlta)=1 Then 'Enero'
	When Month(FechaAlta)=2 Then 'Febrero'
	When Month(FechaAlta)=3 Then 'Marzo'
	When Month(FechaAlta)=4 Then 'Abril'
	When Month(FechaAlta)=5 Then 'Mayo'
	When Month(FechaAlta)=6 Then 'Junio'
	When Month(FechaAlta)=7 Then 'Julio'
	When Month(FechaAlta)=8 Then 'Agosto'
	When Month(FechaAlta)=9 Then 'Setiembre'
	When Month(FechaAlta)=10 Then 'Octubre'
	When Month(FechaAlta)=11 Then 'Noviembre'
	When Month(FechaAlta)=12 Then 'Diciembre'
	ELSE 'Error'
 End as [Mes]
FROM UnidadesEmpaque
WHERE YEAR(FechaAlta)=@Anio
GROUP BY YEAR(FechaAlta), Month(FechaAlta)  
ORDER bY YEAR(FechaAlta)  DESC, Month(FechaAlta) DESC
