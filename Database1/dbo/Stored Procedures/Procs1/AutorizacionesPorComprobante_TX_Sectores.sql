
CREATE Procedure [dbo].[AutorizacionesPorComprobante_TX_Sectores]

AS

SELECT DISTINCT 
 Case When IsNull(_TempAutorizaciones.IdAutoriza,0) = -1 Then -1 Else _TempAutorizaciones.IdSector End as [IdSector],
 Case When IsNull(_TempAutorizaciones.IdAutoriza,0) = -1 Then '_A Designar' Else Sectores.Descripcion End as [Sector]
FROM _TempAutorizaciones
LEFT OUTER JOIN Sectores ON _TempAutorizaciones.IdSector=Sectores.IdSector
WHERE _TempAutorizaciones.IdSector is not null or IsNull(_TempAutorizaciones.IdAutoriza,0) = -1
ORDER BY [IdSector]
