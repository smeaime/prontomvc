CREATE  Procedure [dbo].[TarifasFletes_M]

@IdTarifaFlete int ,
@Descripcion varchar(50),
@ValorUnitario numeric(18,2),
@Codigo varchar(10),
@LimiteInferior numeric(18,2),
@LimiteSuperior numeric(18,2),
@IdUnidad int,
@FechaVigencia datetime

AS

UPDATE TarifasFletes
SET
 Descripcion=@Descripcion,
 ValorUnitario=@ValorUnitario,
 Codigo=@Codigo,
 LimiteInferior=@LimiteInferior,
 LimiteSuperior=@LimiteSuperior,
 IdUnidad=@IdUnidad,
 FechaVigencia=@FechaVigencia
WHERE (IdTarifaFlete=@IdTarifaFlete)

RETURN(@IdTarifaFlete)