



CREATE Procedure [dbo].[Presupuestos_TXMesAnio]
As
SELECT min(CONVERT(varchar, MONTH(FechaIngreso)) + '/' + CONVERT(varchar, YEAR(FechaIngreso)) )
    AS Período,YEAR(FechaIngreso) , MONTH(FechaIngreso)  
    FROM Presupuestos
    GROUP BY  YEAR(FechaIngreso) , MONTH(FechaIngreso)  
    ORDER BY  YEAR(FechaIngreso)  desc , MONTH(FechaIngreso)  desc



