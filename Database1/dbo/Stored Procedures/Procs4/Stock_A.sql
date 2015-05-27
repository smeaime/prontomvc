CREATE Procedure [dbo].[Stock_A]

@IdStock int  output,
@IdArticulo int,
@Partida varchar(20),
@CantidadUnidades numeric(18,2),
@CantidadAdicional numeric(18,2),
@IdUnidad int,
@IdUbicacion int,
@IdObra int,
@NumeroCaja int,
@FechaAlta datetime,
@Equivalencia numeric(18,6),
@CantidadEquivalencia numeric(18,2),
@Talle varchar(2)

AS

INSERT INTO [Stock]
(
 IdArticulo,
 Partida,
 CantidadUnidades,
 CantidadAdicional,
 IdUnidad,
 IdUbicacion,
 IdObra,
 NumeroCaja,
 FechaAlta,
 Equivalencia,
 CantidadEquivalencia,
 Talle
)
VALUES
(
 @IdArticulo,
 @Partida,
 @CantidadUnidades,
 @CantidadAdicional,
 @IdUnidad,
 @IdUbicacion,
 @IdObra,
 @NumeroCaja,
 GetDate(),
 @Equivalencia,
 @CantidadEquivalencia,
 @Talle
)

SELECT @IdStock=@@identity

RETURN(@IdStock)