CREATE Procedure [dbo].[Rubros_A]

@IdRubro int  output,
@Descripcion varchar(50),
@Abreviatura varchar(15),
@EnviarEmail tinyint,
@IdCuenta int,
@IdCuentaCompras int,
@IdCuentaComprasActivo int,
@IdCuentaCompras1 int,
@IdCuentaCompras2 int,
@IdCuentaCompras3 int,
@IdCuentaCompras4 int,
@IdCuentaCompras5 int,
@IdCuentaCompras6 int,
@IdCuentaCompras7 int,
@IdCuentaCompras8 int,
@IdCuentaCompras9 int,
@IdCuentaCompras10 int,
@Codigo int,
@IdTipoOperacion int

AS 

INSERT INTO [Rubros]
(
 Descripcion,
 Abreviatura,
 EnviarEmail,
 IdCuenta,
 IdCuentaCompras,
 IdCuentaComprasActivo,
 IdCuentaCompras1,
 IdCuentaCompras2,
 IdCuentaCompras3,
 IdCuentaCompras4,
 IdCuentaCompras5,
 IdCuentaCompras6,
 IdCuentaCompras7,
 IdCuentaCompras8,
 IdCuentaCompras9,
 IdCuentaCompras10,
 Codigo,
 IdTipoOperacion
)
VALUES
(
 @Descripcion,
 @Abreviatura,
 @EnviarEmail,
 @IdCuenta,
 @IdCuentaCompras,
 @IdCuentaComprasActivo,
 @IdCuentaCompras1,
 @IdCuentaCompras2,
 @IdCuentaCompras3,
 @IdCuentaCompras4,
 @IdCuentaCompras5,
 @IdCuentaCompras6,
 @IdCuentaCompras7,
 @IdCuentaCompras8,
 @IdCuentaCompras9,
 @IdCuentaCompras10,
 @Codigo,
 @IdTipoOperacion
)

SELECT @IdRubro=@@identity

RETURN(@IdRubro)