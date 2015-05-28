
CREATE Procedure [dbo].[BZ_Pesadas_TX_TT]
@idPesada int

AS 
Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111111111111133'
Set @vector_T='0113111115E911100'

SELECT 
BZ_Pesadas.*,

BZ_Pesadas.NumeroPesada,
BZ_Pesadas.FechaIngreso as [Fecha],
Articulos.Codigo as [Codigo],
Articulos.Descripcion as [Artículo],
Partida,
Clientes.RazonSocial as Cliente,
Proveedores.RazonSocial as Proveedor,
Transportistas.RazonSocial as Transportista,
Camiones.Descripcion as [Camion],

BZ_Pesadas.Cantidad,
Unidades.descripcion as [Uni.],

 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM BZ_Pesadas 
LEFT OUTER JOIN Clientes ON  BZ_Pesadas.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON  BZ_Pesadas.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Transportistas ON  BZ_Pesadas.IdTransportista = Transportistas.IdTransportista
--LEFT OUTER JOIN Empleados ON  BZ_Pesadas.IdEmpleado = Empleados.IdEmpleado

LEFT OUTER JOIN Unidades ON BZ_Pesadas.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Articulos ON BZ_Pesadas.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Articulos Camiones ON BZ_Pesadas.IdArticulo = Articulos.IdArticulo
WHERE (idPesada=@idPesada)
ORDER BY BZ_Pesadas.idPesada


