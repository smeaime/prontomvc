
CREATE Procedure [dbo].[Unidades_A]

@IdUnidad int  output,
@Descripcion varchar(30),
@Abreviatura varchar(15),
@CodigoAFIP varchar(2),
@UnidadesPorPack int,
@TaraEnKg numeric(18,4)

AS 

INSERT INTO [Unidades]
(
 Descripcion,
 Abreviatura,
 CodigoAFIP,
 UnidadesPorPack,
 TaraEnKg
)
VALUES
(
 @Descripcion,
 @Abreviatura,
 @CodigoAFIP,
 @UnidadesPorPack,
 @TaraEnKg
)

SELECT @IdUnidad=@@identity
RETURN(@IdUnidad)
