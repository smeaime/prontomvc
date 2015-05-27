












CREATE Procedure [dbo].[VentasEnCuotas_TX_DatosPorIdDetalleVentaEnCuotas]
@IdDetalleVentaEnCuotas int
AS 
SELECT 
 DetVta.*,
 vec.IdCliente,
 vec.IdArticulo,
 vec.FechaOperacion,
 vec.FechaPrimerVencimiento,
 vec.CantidadCuotas,
 vec.ImporteCuota,
 vec.Estado,
 Clientes.RazonSocial as [Cliente],
 Articulos.Descripcion as [Articulo]
FROM DetalleVentasEnCuotas DetVta
LEFT OUTER JOIN VentasEnCuotas vec ON vec.IdVentaEnCuotas=DetVta.IdVentaEnCuotas
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=vec.IdCliente
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=vec.IdArticulo
WHERE DetVta.IdDetalleVentaEnCuotas=@IdDetalleVentaEnCuotas













