CREATE Procedure [dbo].[PresupuestosVentas_M]

@IdPresupuestoVenta int,
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

UPDATE PresupuestosVentas
SET 
 Numero=@Numero,
 IdCliente=@IdCliente,
 Fecha=@Fecha,
 IdCondicionVenta=@IdCondicionVenta,
 IdVendedor=@IdVendedor,
 Observaciones=@Observaciones,
 Estado=@Estado,
 TipoVenta=@TipoVenta,
 TipoOperacion=@TipoOperacion,
 ImporteTotal=@ImporteTotal,
 PorcentajeBonificacion=@PorcentajeBonificacion,
 TotalBultos=@TotalBultos,
 IdDetalleClienteLugarEntrega=@IdDetalleClienteLugarEntrega
WHERE (IdPresupuestoVenta=@IdPresupuestoVenta)

RETURN(@IdPresupuestoVenta)