
CREATE  Procedure [dbo].[Sectores_M]

@IdSector int ,
@Descripcion varchar(50),
@SectorDeObra varchar(2),
@IdEncargado int,
@SeUsaEnPresupuestos varchar(2),
@OrdenPresentacion int,
@EnviarEmail tinyint

AS

UPDATE Sectores
SET
 Descripcion=@Descripcion,
 SectorDeObra=@SectorDeObra,
 IdEncargado=@IdEncargado,
 SeUsaEnPresupuestos=@SeUsaEnPresupuestos,
 OrdenPresentacion=@OrdenPresentacion,
 EnviarEmail=@EnviarEmail
WHERE (IdSector=@IdSector)

RETURN(@IdSector)
