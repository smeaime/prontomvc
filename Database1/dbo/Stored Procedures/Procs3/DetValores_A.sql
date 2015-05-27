




CREATE Procedure [dbo].[DetValores_A]
@IdDetalleValor int  output,
@IdValor int,
@TipoDetalle varchar(1),
@IdObra int,
@IdCuenta int,
@Detalle ntext,
@Importe numeric(12,2),
@ImporteNeto numeric(12,2),
@IdPedido int,
@IdCentroCosto int
AS 
Insert into [DetalleValores]
(
 IdValor,
 TipoDetalle,
 IdObra,
 IdCuenta,
 Detalle,
 Importe,
 ImporteNeto,
 IdPedido,
 IdCentroCosto
)
Values
(
 @IdValor,
 @TipoDetalle,
 @IdObra,
 @IdCuenta,
 @Detalle,
 @Importe,
 @ImporteNeto,
 @IdPedido,
 @IdCentroCosto
)
Select @IdDetalleValor=@@identity
Return(@IdDetalleValor)




