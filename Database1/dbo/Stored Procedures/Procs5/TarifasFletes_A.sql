CREATE Procedure [dbo].[TarifasFletes_A]

@IdTarifaFlete int  output,
@Descripcion varchar(50),
@ValorUnitario numeric(18,2),
@Codigo varchar(10),
@LimiteInferior numeric(18,2),
@LimiteSuperior numeric(18,2),
@IdUnidad int,
@FechaVigencia datetime

AS 

INSERT INTO [TarifasFletes]
(
 Descripcion,
 ValorUnitario,
 Codigo,
 LimiteInferior,
 LimiteSuperior,
 IdUnidad,
 FechaVigencia
)
VALUES
(
 @Descripcion,
 @ValorUnitario,
 @Codigo,
 @LimiteInferior,
 @LimiteSuperior,
 @IdUnidad,
 @FechaVigencia
)

SELECT @IdTarifaFlete=@@identity
RETURN(@IdTarifaFlete)