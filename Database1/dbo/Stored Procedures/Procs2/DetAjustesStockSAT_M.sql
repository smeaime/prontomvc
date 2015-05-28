




CREATE Procedure [dbo].[DetAjustesStockSAT_M]
@IdDetalleAjusteStock int,
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
Update DetalleAjustesStockSAT
Set 
 IdAjusteStock=@IdAjusteStock,
 IdArticulo=@IdArticulo,
 Partida=@Partida,
 CantidadUnidades=@CantidadUnidades,
 CantidadAdicional=@CantidadAdicional,
 IdUnidad=@IdUnidad,
 Cantidad1=@Cantidad1,
 Cantidad2=@Cantidad2,
 Observaciones=@Observaciones,
 IdUbicacion=@IdUbicacion,
 IdObra=@IdObra,
 EnviarEmail=@EnviarEmail,
 IdDetalleAjusteStockOriginal=@IdDetalleAjusteStockOriginal
Where (IdDetalleAjusteStock=@IdDetalleAjusteStock)
Return(@IdDetalleAjusteStock)

