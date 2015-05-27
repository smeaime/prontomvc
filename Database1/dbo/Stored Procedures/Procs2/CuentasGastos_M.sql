
CREATE  Procedure [dbo].[CuentasGastos_M]

@IdCuentaGasto int ,
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

UPDATE CuentasGastos
SET
 CodigoSubcuenta=@CodigoSubcuenta,
 Descripcion=@Descripcion,
 IdRubroContable=@IdRubroContable,
 IdCuentaMadre=@IdCuentaMadre,
 Activa=@Activa,
 Codigo=@Codigo,
 CodigoDestino=@CodigoDestino,
 Titulo=@Titulo,
 Nivel=@Nivel
WHERE (IdCuentaGasto=@IdCuentaGasto)

RETURN(@IdCuentaGasto)
