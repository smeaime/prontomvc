




CREATE Procedure [dbo].[VentasEnCuotas_TX_CuotasGeneradasDetalladasPorNumero]

@NumeroGeneracion int

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='011111161111111111133'
Set @vector_T='019044639999999999900'

SELECT 
 vec.IdVentaEnCuotas,
 Clientes.RazonSocial as [Cliente],
 DetVta.IdDetalleVentaEnCuotas as [DetVta],
 Substring(Articulos.Descripcion,1,85) as [Bien / Producto],
 DetVta.FechaPrimerVencimiento as [Fec.1er.Vto.],
 vec.CantidadCuotas as [Cant. cuotas],
 DetVta.Cuota as [Cuota generada],
 vec.ImporteCuota as [Importe cuota],
 DetVta.NumeroGeneracion,
 DetVta.FechaGeneracion,
 DetVta.FechaPrimerVencimiento,
 DetVta.FechaSegundoVencimiento,
 DetVta.FechaTercerVencimiento,
 DetVta.InteresPrimerVencimiento,
 DetVta.InteresSegundoVencimiento,
 Bancos.Nombre as [EnteRecaudador],
 DetVta.IdBanco,
 DetVta.IdNotaDebito,
 Clientes.CodigoCliente as [CodigoCliente],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleVentasEnCuotas DetVta
LEFT OUTER JOIN VentasEnCuotas vec ON vec.IdVentaEnCuotas=DetVta.IdVentaEnCuotas
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=vec.IdCliente
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=vec.IdArticulo
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado=vec.IdRealizo
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DetVta.IdBanco
WHERE DetVta.NumeroGeneracion=@NumeroGeneracion
ORDER by Clientes.RazonSocial,vec.FechaOperacion




