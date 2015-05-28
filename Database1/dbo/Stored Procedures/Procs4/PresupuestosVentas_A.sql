CREATE Procedure [dbo].[PresupuestosVentas_A]

@IdPresupuestoVenta int  output,
@Numero int,
@IdCliente int,
@Fecha datetime,
@IdCondicionVenta smallint,
@IdVendedor int,
@Observaciones ntext,
@Estado varchar(1),
@TipoVenta int,
@TipoOperacion varchar(1),
@ImporteTotal numeric(18,2),
@PorcentajeBonificacion numeric(6,2),
@TotalBultos int,
@IdDetalleClienteLugarEntrega int

AS 

INSERT INTO [PresupuestosVentas]
(
 Numero,
 IdCliente,
 Fecha,
 IdCondicionVenta,
 IdVendedor,
 Observaciones,
 Estado,
 TipoVenta,
 TipoOperacion,
 ImporteTotal,
 PorcentajeBonificacion,
 TotalBultos,
 IdDetalleClienteLugarEntrega
)
VALUES
( 
 @Numero,
 @IdCliente,
 @Fecha,
 @IdCondicionVenta,
 @IdVendedor,
 @Observaciones,
 @Estado,
 @TipoVenta,
 @TipoOperacion,
 @ImporteTotal,
 @PorcentajeBonificacion,
 @TotalBultos,
 @IdDetalleClienteLugarEntrega
)

SELECT @IdPresupuestoVenta=@@identity

RETURN(@IdPresupuestoVenta)