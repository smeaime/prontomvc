
CREATE Procedure [dbo].[Obras_TX_PorIdObraConDatos]

@IdObra int

AS 

SELECT 
 Obras.*,
 CASE 	
	WHEN TipoObra=1 THEN 'Taller'
	WHEN TipoObra=2 THEN 'Montaje'
	WHEN TipoObra=3 THEN 'Servicio'
	ELSE Null
 END as [TipoObra],
 Obras.Descripcion as [Obra],
 Clientes.RazonSocial as [Cliente],
 UnidadesOperativas.Descripcion as [UnidadOperativa],
 Empleados.Nombre as [Jefe de obra]
FROM Obras
LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Empleados ON Obras.IdJefe = Empleados.IdEmpleado
LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
WHERE IdObra=@IdObra
ORDER BY Obras.NumeroObra
