




CREATE Procedure [dbo].[VentasEnCuotas_TX_TT]

@IdVentaEnCuotas int

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='011111111111133'
Set @vector_T='049D34533253500'

SELECT 
 vec.IdVentaEnCuotas,
 Clientes.RazonSocial as [Cliente],
 vec.IdVentaEnCuotas as [IdAux],
 Articulos.Descripcion as [Bien / Producto],
 Articulos.NumeroManzana as [Manzana],
 vec.FechaOperacion as [Fecha operacion],
 vec.FechaPrimerVencimiento as [Fecha 1er. Vto.],
 vec.CantidadCuotas as [Cant. cuotas],
 vec.ImporteCuota as [Importe cuota],
 Empleados.Nombre as [Realizo],
 Estado,
 EstadosVentasEnCuotas.Descripcion as [Situacion actual],
 vec.Observaciones,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM VentasEnCuotas vec
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=vec.IdCliente
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=vec.IdArticulo
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado=vec.IdRealizo
LEFT OUTER JOIN EstadosVentasEnCuotas ON EstadosVentasEnCuotas.IdEstadoVentaEnCuotas=vec.IdEstadoVentaEnCuotas
WHERE (IdVentaEnCuotas=@IdVentaEnCuotas)




