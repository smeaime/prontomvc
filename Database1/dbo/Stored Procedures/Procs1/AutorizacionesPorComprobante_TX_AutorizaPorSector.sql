
CREATE Procedure [dbo].[AutorizacionesPorComprobante_TX_AutorizaPorSector]

@IdSector int

AS

SELECT DISTINCT 
 _TempAutorizaciones.IdAutoriza,
 IsNull(Empleados.Nombre,'_A Designar') as [Autoriza]
FROM _TempAutorizaciones
LEFT OUTER JOIN Empleados ON _TempAutorizaciones.IdAutoriza=Empleados.IdEmpleado
WHERE _TempAutorizaciones.IdAutoriza is not null and (_TempAutorizaciones.IdSector=@IdSector or (@IdSector=-1 and IsNull(_TempAutorizaciones.IdAutoriza,0)=-1))
ORDER BY [Autoriza]
