
CREATE Procedure [dbo].[LecturasGPS_TXAnio]

AS

SELECT Min(Convert(varchar,Year(FechaLectura))) as [Período], Year(FechaLectura)
FROM LecturasGPS
GROUP BY YEAR(FechaLectura) 
ORDER BY YEAR(FechaLectura) Desc
