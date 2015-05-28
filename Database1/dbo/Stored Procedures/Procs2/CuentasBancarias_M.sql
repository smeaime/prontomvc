CREATE  Procedure [dbo].[CuentasBancarias_M]

@IdCuentaBancaria int ,
@Cuenta varchar(50),
@IdBanco int,
@IdMoneda int,
@IdProvincia int,
@Detalle varchar(30),
@PlantillaChequera varchar(50),
@ChequesPorPlancha int,
@CBU varchar(22),
@InformacionAuxiliar varchar(10),
@CaracteresBeneficiario int,
@Activa varchar(2),
@DiseñoCheque varchar(4000)

AS

UPDATE CuentasBancarias
SET 
 Cuenta=@Cuenta,
 IdBanco=@IdBanco,
 IdMoneda=@IdMoneda,
 IdProvincia=@IdProvincia,
 Detalle=@Detalle,
 PlantillaChequera=@PlantillaChequera,
 ChequesPorPlancha=@ChequesPorPlancha,
 CBU=@CBU,
 InformacionAuxiliar=@InformacionAuxiliar,
 CaracteresBeneficiario=@CaracteresBeneficiario,
 Activa=@Activa,
 DiseñoCheque=@DiseñoCheque
WHERE (IdCuentaBancaria=@IdCuentaBancaria)

RETURN(@IdCuentaBancaria)