
CREATE Procedure [dbo].[UnidadesEmpaque_TXAnio]

AS

SELECT Min(Convert(varchar,Year(FechaAlta))) as [Período], Year(FechaAlta)
FROM UnidadesEmpaque
WHERE FechaAlta is not null
GROUP BY YEAR(FechaAlta) 
ORDER bY YEAR(FechaAlta)  DESC
