






CREATE PROCEDURE [dbo].[Acopios_TX_Pendientes]

AS

declare @vector_X varchar(50),@vector_T varchar(50),@TiposComprobante varchar(1)
set @TiposComprobante=' '
set @vector_X='0111111111111111114133'
set @vector_T='0210132200090499419900'

SELECT 
 DetAco.IdDetalleAcopios,
 Acopios.NumeroAcopio as [L.Acopio],
 DetAco.NumeroItem as [Item],
 DetAco.Cantidad as [Cant.],
 Empleados.Nombre as [Comprador],
 (Select SUM(DetalleReservas.CantidadUnidades) 
	From DetalleReservas 
	Where DetalleReservas.IdDetalleAcopios=DetAco.IdDetalleAcopios) 
	as [Reservado],
 (Select SUM(DetallePedidos.Cantidad)
	From DetallePedidos 
	Where DetallePedidos.IdDetalleAcopios=DetAco.IdDetalleAcopios and 
		(DetallePedidos.Cumplido is null or DetallePedidos.Cumplido<>'AN')) 
	as [Cant.Ped.],
 (Select SUM(DetalleRecepciones.Cantidad) 
	From DetalleRecepciones 
	Left Outer Join Recepciones On Recepciones.IdRecepcion=DetalleRecepciones.IdRecepcion
	Where DetalleRecepciones.IdDetalleAcopios=DetAco.IdDetalleAcopios and 
		(Recepciones.Anulada is null or Recepciones.Anulada<>'SI')) 
	as [Recibido],
 (Select Unidades.Descripcion
	From Unidades
	Where Unidades.IdUnidad=DetAco.IdUnidad) as  [Unidad en],
 DetAco.Cantidad1 as [Med.1],
 DetAco.Cantidad2 as [Med.2],
 DetAco.IdArticulo,
 Articulos.Descripcion as [Articulo],
 DetAco.FechaNecesidad as [F.necesidad],
 DetAco.IdDetalleAcopios,
 DetAco.IdAcopio,
 Cuentas.Descripcion as [Cuenta contable],
 DetAco.Cumplido as [Cump.],
 DetAco.Observaciones,
 DetAco.IdDetalleAcopios,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleAcopios DetAco
LEFT OUTER JOIN Articulos ON DetAco.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Acopios ON DetAco.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN Obras ON Acopios.IdObra=Obras.IdObra
LEFT OUTER JOIN Cuentas ON DetAco.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Empleados ON DetAco.IdComprador = Empleados.IdEmpleado
WHERE Acopios.Aprobo is not null AND 
	 (@TiposComprobante='T' or DetAco.Cumplido is null or (DetAco.Cumplido<>'SI' and DetAco.Cumplido<>'AN')) AND 
/*	 (@TiposComprobante='T' or DetAco.IdProveedor is null) AND 	*/
	 (@TiposComprobante='T' or DetAco.IdAproboAlmacen is not null)
ORDER BY Acopios.NumeroAcopio,DetAco.NumeroItem






