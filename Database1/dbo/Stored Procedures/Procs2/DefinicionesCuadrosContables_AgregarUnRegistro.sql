





CREATE Procedure [dbo].[DefinicionesCuadrosContables_AgregarUnRegistro]
@IdCuenta int,
@Descripcion varchar(50),
@IdCuentaIngreso int,
@IdCuentaEgreso int
AS 
INSERT INTO [DefinicionesCuadrosContables]
(
 IdCuenta,
 Descripcion,
 IdCuentaIngreso,
 IdCuentaEgreso
)
VALUES
(
 @IdCuenta,
 @Descripcion,
 @IdCuentaIngreso,
 @IdCuentaEgreso
)





