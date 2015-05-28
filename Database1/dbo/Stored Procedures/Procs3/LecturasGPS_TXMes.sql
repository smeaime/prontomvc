
CREATE Procedure [dbo].[LecturasGPS_TXMes]

@Anio int

AS

SELECT 
 Min(Convert(varchar, Month(FechaLectura)) + '/' + Convert(varchar, Year(FechaLectura))) as [Período],
 Year(FechaLectura), 
 Month(FechaLectura),
 Case 
	When Month(FechaLectura)=1 Then 'Enero'
	When Month(FechaLectura)=2 Then 'Febrero'
	When Month(FechaLectura)=3 Then 'Marzo'
	When Month(FechaLectura)=4 Then 'Abril'
	When Month(FechaLectura)=5 Then 'Mayo'
	When Month(FechaLectura)=6 Then 'Junio'
	When Month(FechaLectura)=7 Then 'Julio'
	When Month(FechaLectura)=8 Then 'Agosto'
	When Month(FechaLectura)=9 Then 'Setiembre'
	When Month(FechaLectura)=10 Then 'Octubre'
	When Month(FechaLectura)=11 Then 'Noviembre'
	When Month(FechaLectura)=12 Then 'Diciembre'
	ELSE 'Error'
 End as [Mes]
FROM LecturasGPS
WHERE Year(FechaLectura)=@Anio
GROUP BY Year(FechaLectura), Month(FechaLectura)  
ORDER BY Year(FechaLectura) Desc, Month(FechaLectura) Desc
