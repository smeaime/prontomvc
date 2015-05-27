CREATE  Procedure [dbo].[Stock_M]

@IdStock int,
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

UPDATE Stock
SET 
 IdArticulo=@IdArticulo,
 Partida=@Partida,
 CantidadUnidades=@CantidadUnidades,
 CantidadAdicional=@CantidadAdicional,
 IdUnidad=@IdUnidad,
 IdUbicacion=@IdUbicacion,
 IdObra=@IdObra,
 NumeroCaja=@NumeroCaja,
 Equivalencia=@Equivalencia,
 CantidadEquivalencia=@CantidadEquivalencia,
 Talle=@Talle
WHERE (IdStock=@IdStock)

RETURN(@IdStock)