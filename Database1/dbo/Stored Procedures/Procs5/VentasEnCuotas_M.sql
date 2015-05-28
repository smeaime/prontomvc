















CREATE Procedure [dbo].[VentasEnCuotas_M]
@IdVentaEnCuotas int ,
@IdCliente int,
@IdArticulo int,
@FechaOperacion datetime,
@FechaPrimerVencimiento datetime,
@CantidadCuotas int,
@ImporteCuota numeric(18,2),
@IdRealizo int,
@Observaciones ntext,
@Estado varchar(2),
@IdEstadoVentaEnCuotas int
As 
Update VentasEnCuotas
Set 
 IdCliente=@IdCliente,
 IdArticulo=@IdArticulo,
 FechaOperacion=@FechaOperacion,
 FechaPrimerVencimiento=@FechaPrimerVencimiento,
 CantidadCuotas=@CantidadCuotas,
 ImporteCuota=@ImporteCuota,
 IdRealizo=@IdRealizo,
 Observaciones=@Observaciones,
 Estado=@Estado,
 IdEstadoVentaEnCuotas=@IdEstadoVentaEnCuotas
Where (IdVentaEnCuotas=@IdVentaEnCuotas)
Return(@IdVentaEnCuotas)





