
CREATE Procedure [dbo].[CuentasGastos_A]

@IdCuentaGasto int  output,
@CodigoSubcuenta int,
@Descripcion varchar(50),
@IdRubroContable int,
@IdCuentaMadre int,
@Activa varchar(2),
@Codigo varchar(20),
@CodigoDestino varchar(10),
@Titulo varchar(2),
@Nivel int

AS 

INSERT INTO [CuentasGastos]
(
 CodigoSubcuenta,
 Descripcion,
 IdRubroContable,
 IdCuentaMadre,
 Activa,
 Codigo,
 CodigoDestino,
 Titulo,
 Nivel
)
VALUES
(
 @CodigoSubcuenta,
 @Descripcion,
 @IdRubroContable,
 @IdCuentaMadre,
 @Activa,
 @Codigo,
 @CodigoDestino,
 @Titulo,
 @Nivel
)

SELECT @IdCuentaGasto=@@identity
RETURN(@IdCuentaGasto)
