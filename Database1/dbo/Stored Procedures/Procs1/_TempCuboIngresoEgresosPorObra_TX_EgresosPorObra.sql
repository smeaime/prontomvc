CREATE Procedure [dbo].[_TempCuboIngresoEgresosPorObra_TX_EgresosPorObra]

@Obra varchar(13)

AS

SELECT
 RubroContable,
 Sum(Importe * -1) as [Importe]
FROM _TempCuboIngresoEgresosPorObra
WHERE Substring(Tipo,3,7)='EGRESOS' and Obra is not null and PATINDEX('%'+@Obra+'%', Obra)>0
GROUP BY RubroContable
ORDER BY RubroContable