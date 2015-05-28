CREATE Procedure [dbo].[CuentasBancarias_A]

@IdCuentaBancaria int  output,
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

INSERT INTO [CuentasBancarias]
(
 Cuenta,
 IdBanco,
 IdMoneda,
 IdProvincia,
 Detalle,
 PlantillaChequera,
 ChequesPorPlancha,
 CBU,
 InformacionAuxiliar,
 CaracteresBeneficiario,
 Activa,
 DiseñoCheque
)
VALUES
(
 @Cuenta,
 @IdBanco,
 @IdMoneda,
 @IdProvincia,
 @Detalle,
 @PlantillaChequera,
 @ChequesPorPlancha,
 @CBU,
 @InformacionAuxiliar,
 @CaracteresBeneficiario,
 @Activa,
 @DiseñoCheque
)

SELECT @IdCuentaBancaria=@@identity

RETURN(@IdCuentaBancaria)