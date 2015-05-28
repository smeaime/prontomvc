


CREATE  Procedure [dbo].[CuentasGastos_MarcarComoActiva]
@IdCuentaGasto int ,
@Activa varchar(2)
AS
UPDATE CuentasGastos
SET Activa=Case When @Activa='NO' Then Null Else @Activa End
WHERE (IdCuentaGasto=@IdCuentaGasto)


