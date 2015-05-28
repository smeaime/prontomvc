



CREATE Procedure [dbo].[DetAjustesStockSAT_A]
@IdDetalleAjusteStock int  output,
@IdAjusteStock int,
@IdArticulo int,
@Partida int,
@CantidadUnidades numeric(12,2),
@CantidadAdicional numeric(12,2),
@IdUnidad int,
@Cantidad1 numeric(12,2),
@Cantidad2 numeric(12,2),
@Observaciones ntext,
@IdUbicacion int,
@IdObra int,
@EnviarEmail tinyint,
@IdDetalleAjusteStockOriginal int
As 
Insert into DetalleAjustesStockSAT
(
 IdAjusteStock,
 IdArticulo,
 Partida,
 CantidadUnidades,
 CantidadAdicional,
 IdUnidad,
 Cantidad1,
 Cantidad2,
 Observaciones,
 IdUbicacion,
 IdObra,
 EnviarEmail,
 IdDetalleAjusteStockOriginal
)
Values
(
 @IdAjusteStock,
 @IdArticulo,
 @Partida,
 @CantidadUnidades,
 @CantidadAdicional,
 @IdUnidad,
 @Cantidad1,
 @Cantidad2,
 @Observaciones,
 @IdUbicacion,
 @IdObra,
 @EnviarEmail,
 @IdDetalleAjusteStockOriginal
)
Select @IdDetalleAjusteStock=@@identity
Return(@IdDetalleAjusteStock)

