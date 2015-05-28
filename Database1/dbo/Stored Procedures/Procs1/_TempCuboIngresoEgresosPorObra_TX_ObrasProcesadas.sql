CREATE Procedure [dbo].[_TempCuboIngresoEgresosPorObra_TX_ObrasProcesadas]

AS

SELECT 
Case When PATINDEX('%-%', Obra)>0 Then Rtrim(Substring(Obra,1,PATINDEX('%-%', Obra)-1)) Else Obra End as [Obra]
FROM _TempCuboIngresoEgresosPorObra
WHERE Substring(Tipo,3,7)='EGRESOS' and Obra is not null
GROUP BY Obra
ORDER BY Obra