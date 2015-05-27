






CREATE Procedure [dbo].[_TempCuentasCorrientesAcreedores_A]
@IdTempCtaCte int  output,
@IdCtaCte int,
@IdProveedor int,
@Fecha datetime,
@IdTipoComp int,
@IdComprobante int,
@NumeroComprobante int,
@IdImputacion int,
@ImporteTotal numeric(18,2),
@Saldo numeric(18,2)
As 
Insert into _TempCuentasCorrientesAcreedores
(
 IdCtaCte,
 IdProveedor,
 Fecha,
 IdTipoComp,
 IdComprobante,
 NumeroComprobante,
 IdImputacion,
 ImporteTotal,
 Saldo
)
Values
(
 @IdCtaCte,
 @IdProveedor,
 @Fecha,
 @IdTipoComp,
 @IdComprobante,
 @NumeroComprobante,
 @IdImputacion,
 @ImporteTotal,
 @Saldo
)
Select @IdTempCtaCte=@@identity
Return(@IdTempCtaCte)






