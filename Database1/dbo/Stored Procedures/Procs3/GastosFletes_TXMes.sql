
CREATE Procedure [dbo].[GastosFletes_TXMes]

@Anio int

AS

SELECT 
 Min(Convert(varchar, Month(Fecha)) + '/' + Convert(varchar, Year(Fecha))) as [Período],
 Year(Fecha), 
 Month(Fecha),
 Case 
	When Month(Fecha)=1 Then 'Enero'
	When Month(Fecha)=2 Then 'Febrero'
	When Month(Fecha)=3 Then 'Marzo'
	When Month(Fecha)=4 Then 'Abril'
	When Month(Fecha)=5 Then 'Mayo'
	When Month(Fecha)=6 Then 'Junio'
	When Month(Fecha)=7 Then 'Julio'
	When Month(Fecha)=8 Then 'Agosto'
	When Month(Fecha)=9 Then 'Setiembre'
	When Month(Fecha)=10 Then 'Octubre'
	When Month(Fecha)=11 Then 'Noviembre'
	When Month(Fecha)=12 Then 'Diciembre'
	ELSE 'Error'
 End as [Mes]
FROM GastosFletes
WHERE Year(Fecha)=@Anio
GROUP BY Year(Fecha), Month(Fecha)  
ORDER BY Year(Fecha) Desc, Month(Fecha) Desc
