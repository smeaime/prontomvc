





CREATE Procedure [dbo].[VentasEnCuotas_TX_CuotasGeneradasAgrupadasPorNumero]

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111111111133'
Set @vector_T='02055555555500'

SELECT DISTINCT 
 DetVta.NumeroGeneracion as [IdNro],
 Clientes.RazonSocial as [Cliente],
 Substring(Articulos.Descripcion,1,80) as [Bien / Producto],
 DetVta.NumeroGeneracion as [Nro.Generacion],
 DetVta.FechaGeneracion as [Fecha Generacion],
 MIN(DetVta.FechaPrimerVencimiento) as [Fecha 1er.Vto.],
 MIN(DetVta.FechaSegundoVencimiento) as [Fecha 2do.Vto.],
 MIN(DetVta.FechaTercerVencimiento) as [Fecha 3er.Vto.],
 MIN(DetVta.InteresPrimerVencimiento) as [% Interes 1er.Vto.],
 MIN(DetVta.InteresSegundoVencimiento) as [% Interes 1er.Vto.],
 MAX(vec.ImporteCuota) as [Importe cuota],
 Bancos.Nombre as [Ente Recaudador],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleVentasEnCuotas DetVta
LEFT OUTER JOIN VentasEnCuotas vec ON vec.IdVentaEnCuotas=DetVta.IdVentaEnCuotas
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=vec.IdCliente
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=vec.IdArticulo
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DetVta.IdBanco
GROUP BY DetVta.FechaGeneracion,DetVta.NumeroGeneracion,Bancos.Nombre,Clientes.RazonSocial,Articulos.Descripcion
ORDER by DetVta.FechaGeneracion,DetVta.NumeroGeneracion





