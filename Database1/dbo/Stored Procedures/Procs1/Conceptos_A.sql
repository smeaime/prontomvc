CREATE Procedure [dbo].[Conceptos_A]

@IdConcepto int  output,
@Descripcion varchar(50),
@IdCuenta int,
@ValorRechazado varchar(2),
@CodigoConcepto int,
@GravadoDefault varchar(2),
@Grupo int,
@CodigoAFIP varchar(20),
@CoeficienteAuxiliar numeric(18,2),
@GeneraComision varchar(2),
@NoTomarEnRanking varchar(2)

AS

INSERT INTO [Conceptos]
(
 Descripcion,
 IdCuenta,
 ValorRechazado,
 CodigoConcepto,
 GravadoDefault,
 Grupo,
 CodigoAFIP,
 CoeficienteAuxiliar,
 GeneraComision,
 NoTomarEnRanking
)
VALUES
(
 @Descripcion,
 @IdCuenta,
 @ValorRechazado,
 @CodigoConcepto,
 @GravadoDefault,
 @Grupo,
 @CodigoAFIP,
 @CoeficienteAuxiliar,
 @GeneraComision,
 @NoTomarEnRanking
)

SELECT @IdConcepto=@@identity

RETURN(@IdConcepto)