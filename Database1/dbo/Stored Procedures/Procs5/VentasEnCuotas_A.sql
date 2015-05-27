






CREATE Procedure [dbo].[VentasEnCuotas_A]
@IdVentaEnCuotas int output,
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
Insert into [VentasEnCuotas]
(
 IdCliente,
 IdArticulo,
 FechaOperacion,
 FechaPrimerVencimiento,
 CantidadCuotas,
 ImporteCuota,
 IdRealizo,
 Observaciones,
 Estado,
 IdEstadoVentaEnCuotas
)
Values
(
 @IdCliente,
 @IdArticulo,
 @FechaOperacion,
 @FechaPrimerVencimiento,
 @CantidadCuotas,
 @ImporteCuota,
 @IdRealizo,
 @Observaciones,
 @Estado,
 @IdEstadoVentaEnCuotas
)
Select @IdVentaEnCuotas=@@identity
Return(@IdVentaEnCuotas)





