CREATE Procedure [dbo].[Articulos_TX_AVL2]

@Activos varchar(1)

AS

SELECT 
 Obras.NumeroObra as [Dominio],
 a1.Codigo as [Dominio2],
 Clientes.RazonSocial as [Cliente],
 a2.Codigo as [Equipo],
 doei.FechaDesinstalacion as [FechaDesinstalacionEquipo],
 a3.Codigo as [Sim],
 doei.FechaDesinstalacion as [FechaDesinstalacionSim]
FROM Obras
LEFT OUTER JOIN Clientes ON Clientes.IdCliente = Obras.IdCliente
LEFT OUTER JOIN DetalleObrasEquiposInstalados doei ON doei.IdObra = Obras.IdObra
LEFT OUTER JOIN DetalleObrasEquiposInstalados2 doei2 ON doei2.IdDetalleObraEquipoInstalado = doei.IdDetalleObraEquipoInstalado
LEFT OUTER JOIN Articulos a1 ON a1.IdArticulo = Obras.IdArticuloAsociado
LEFT OUTER JOIN Articulos a2 ON a2.IdArticulo = doei.IdArticulo
LEFT OUTER JOIN Articulos a3 ON a3.IdArticulo = doei2.IdArticulo
WHERE Obras.Activa='SI' and (@Activos='T' or (@Activos='A' and doei.FechaDesinstalacion is null and doei2.FechaDesinstalacion is null))
ORDER BY Obras.NumeroObra, a2.Codigo, a3.Codigo