















CREATE Procedure [dbo].[VentasEnCuotas_TX_PorIdCliente]

@IdCliente int

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111161133'
Set @vector_T='00965432500'

SELECT 
 vec.IdVentaEnCuotas,
 Articulos.Descripcion as [Bien / Producto],
 vec.IdVentaEnCuotas as [IdAux],
 vec.FechaOperacion as [Fecha operacion],
 vec.FechaPrimerVencimiento as [Fecha 1er. Vto.],
 vec.CantidadCuotas as [Cant. cuotas],
 vec.ImporteCuota as [Importe cuota],
 Empleados.Nombre as [Realizo],
 vec.Observaciones,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM VentasEnCuotas vec
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=vec.IdArticulo
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado=vec.IdRealizo
WHERE vec.IdCliente=@IdCliente
ORDER by vec.FechaOperacion















