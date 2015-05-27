CREATE Procedure [dbo].[TarjetasCredito_A]

@IdTarjetaCredito int  output,
@Nombre varchar(50),
@IdCuenta int,
@IdMoneda int,
@TipoTarjeta varchar(1),
@DiseñoRegistro int,
@NumeroEstablecimiento varchar(10),
@CodigoServicio varchar(5),
@NumeroServicio varchar(10),
@Codigo int

AS 

INSERT INTO [TarjetasCredito]
(
 Nombre, 
 IdCuenta,
 IdMoneda,
 TipoTarjeta,
 DiseñoRegistro,
 NumeroEstablecimiento,
 CodigoServicio,
 NumeroServicio,
 Codigo
)
VALUES
(
 @Nombre,
 @IdCuenta,
 @IdMoneda,
 @TipoTarjeta,
 @DiseñoRegistro,
 @NumeroEstablecimiento,
 @CodigoServicio,
 @NumeroServicio,
 @Codigo
)

SELECT @IdTarjetaCredito=@@identity

RETURN(@IdTarjetaCredito)