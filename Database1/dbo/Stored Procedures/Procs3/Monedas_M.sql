
CREATE  Procedure [dbo].[Monedas_M]

@IdMoneda int ,
@Nombre varchar(50),
@Abreviatura varchar(15),
@EquivalenciaUS numeric(14,4),
@CodigoAFIP varchar(3),
@GeneraImpuestos varchar(2),
@EnviarEmail tinyint

AS

UPDATE Monedas
SET
 Nombre=@Nombre,
 Abreviatura=@Abreviatura,
 EquivalenciaUS=@EquivalenciaUS,
 CodigoAFIP=@CodigoAFIP,
 GeneraImpuestos=@GeneraImpuestos,
 EnviarEmail=@EnviarEmail
WHERE (IdMoneda=@IdMoneda)

RETURN(@IdMoneda)
