
CREATE Procedure [dbo].[_TempAsientoSueldos_A]

@FechaAsiento datetime,
@FechaLiquidacion datetime,
@DescripcionLiquidacion varchar(50),
@Legajo int,
@Apellido varchar(30),
@Nombre varchar(30),
@Renglon int,
@Cuenta int,
@DescripcionCuenta varchar(50),
@CodigoDebeHaber varchar(1),
@NumeroRecibo int,
@Importe numeric(18,2),
@IdEmpleado int,
@IdCuenta int

AS 

INSERT INTO [_TempAsientoSueldos]
(
 FechaAsiento,
 FechaLiquidacion,
 DescripcionLiquidacion,
 Legajo,
 Apellido,
 Nombre,
 Renglon,
 Cuenta,
 DescripcionCuenta,
 CodigoDebeHaber,
 NumeroRecibo,
 Importe,
 IdEmpleado,
 IdCuenta
)
VALUES
(
 @FechaAsiento,
 @FechaLiquidacion,
 @DescripcionLiquidacion,
 @Legajo,
 @Apellido,
 @Nombre,
 @Renglon,
 @Cuenta,
 @DescripcionCuenta,
 @CodigoDebeHaber,
 @NumeroRecibo,
 @Importe,
 @IdEmpleado,
 @IdCuenta
)

RETURN(1)
