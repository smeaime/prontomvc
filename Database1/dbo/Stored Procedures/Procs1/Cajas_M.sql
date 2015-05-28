
CREATE  Procedure [dbo].[Cajas_M]

@IdCaja int ,
@Descripcion varchar(50),
@IdCuenta int,
@IdMoneda int

AS

UPDATE Cajas
SET
 Descripcion=@Descripcion,
 IdCuenta=@IdCuenta,
 IdMoneda=@IdMoneda
WHERE (IdCaja=@IdCaja)

RETURN(@IdCaja)
