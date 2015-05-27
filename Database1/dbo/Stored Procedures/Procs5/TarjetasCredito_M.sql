CREATE  Procedure [dbo].[TarjetasCredito_M]

@IdTarjetaCredito int ,
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

UPDATE TarjetasCredito
SET
 Nombre=@Nombre,
 IdCuenta=@IdCuenta,
 IdMoneda=@IdMoneda,
 TipoTarjeta=@TipoTarjeta,
 DiseñoRegistro=@DiseñoRegistro,
 NumeroEstablecimiento=@NumeroEstablecimiento,
 CodigoServicio=@CodigoServicio,
 NumeroServicio=@NumeroServicio,
 Codigo=@Codigo
WHERE (IdTarjetaCredito=@IdTarjetaCredito)

RETURN(@IdTarjetaCredito)