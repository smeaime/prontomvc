




CREATE Procedure [dbo].[DetValores_M]
@IdDetalleValor int,
@IdValor int,
@TipoDetalle varchar(1),
@IdObra int,
@IdCuenta int,
@Detalle ntext,
@Importe numeric(12,2),
@ImporteNeto numeric(12,2),
@IdPedido int,
@IdCentroCosto int
as
Update [DetalleValores]
SET 
 IdValor=@IdValor,
 TipoDetalle=@TipoDetalle,
 IdObra=@IdObra,
 IdCuenta=@IdCuenta,
 Detalle=@Detalle,
 Importe=@Importe,
 ImporteNeto=@ImporteNeto,
 IdPedido=@IdPedido,
 IdCentroCosto=@IdCentroCosto
Where (IdDetalleValor=@IdDetalleValor)
Return(@IdDetalleValor)




