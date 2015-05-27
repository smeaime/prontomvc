CREATE Procedure [dbo].[PresupuestoObrasRedeterminaciones_TX_ParaPresupuestoEstaticoYDinamico]

@IdObra int

AS 

SELECT por.IdObra as [IdObra], por.Año as [Año], por.Mes as [Mes], Sum(IsNull(por.Importe,0)) as [Importe]
FROM PresupuestoObrasRedeterminaciones por
WHERE (@IdObra=-1 or por.IdObra=@IdObra)
GROUP BY por.IdObra, por.Año, por.Mes
ORDER BY por.IdObra, por.Año, por.Mes
