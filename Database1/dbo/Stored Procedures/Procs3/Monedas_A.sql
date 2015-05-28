
CREATE Procedure [dbo].[Monedas_A]

@IdMoneda int  output,
@Nombre varchar(50),
@Abreviatura varchar(15),
@EquivalenciaUS numeric(14,4),
@CodigoAFIP varchar(3),
@GeneraImpuestos varchar(2),
@EnviarEmail tinyint

AS

INSERT INTO [Monedas]
(
 Nombre,
 Abreviatura,
 EquivalenciaUS,
 CodigoAFIP,
 GeneraImpuestos,
 EnviarEmail
)
VALUES
(
 @Nombre,
 @Abreviatura,
 @EquivalenciaUS,
 @CodigoAFIP,
 @GeneraImpuestos,
 @EnviarEmail
)

SELECT @IdMoneda=@@identity
RETURN(@IdMoneda)
