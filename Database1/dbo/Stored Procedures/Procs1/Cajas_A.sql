


CREATE Procedure [dbo].[Cajas_A]
@IdCaja int  output,
@Descripcion varchar(50),
@IdCuenta int,
@IdMoneda int
As 
Insert into [Cajas]
(
 Descripcion,
 IdCuenta,
 IdMoneda
)
Values
(
 @Descripcion,
 @IdCuenta,
 @IdMoneda
)
Select @IdCaja=@@identity
Return(@IdCaja)


