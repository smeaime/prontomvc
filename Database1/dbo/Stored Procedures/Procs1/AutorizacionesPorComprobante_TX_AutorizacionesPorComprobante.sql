CREATE Procedure [dbo].[AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante]

@IdFormulario int,
@IdComprobante int

AS

SELECT AutorizacionesPorComprobante.*, Empleados.Iniciales, Sectores.Descripcion as [Sector], Empleados.Nombre
FROM AutorizacionesPorComprobante
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado=AutorizacionesPorComprobante.IdAutorizo
LEFT OUTER JOIN Sectores ON Sectores.IdSector=Empleados.IdSector
WHERE AutorizacionesPorComprobante.IdFormulario=@IdFormulario and AutorizacionesPorComprobante.IdComprobante=@IdComprobante
ORDER BY AutorizacionesPorComprobante.OrdenAutorizacion