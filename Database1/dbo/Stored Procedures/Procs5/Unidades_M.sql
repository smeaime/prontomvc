
CREATE  Procedure [dbo].[Unidades_M]

@IdUnidad int ,
@Descripcion varchar(30),
@Abreviatura varchar(15),
@CodigoAFIP varchar(2),
@UnidadesPorPack int,
@TaraEnKg numeric(18,4)

AS

UPDATE Unidades
SET 
 Descripcion=@Descripcion,
 Abreviatura=@Abreviatura,
 CodigoAFIP=@CodigoAFIP,
 UnidadesPorPack=@UnidadesPorPack,
 TaraEnKg=@TaraEnKg
WHERE (IdUnidad=@IdUnidad)

RETURN(@IdUnidad)
