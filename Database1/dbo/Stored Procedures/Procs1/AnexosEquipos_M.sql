































CREATE  Procedure [dbo].[AnexosEquipos_M]
@IdAnexoEquipos int ,
@NumeroNCM varchar(10),
@Equipo varchar(70),
@DescripcionAESA ntext,
@DescripcionNCM ntext
AS
Update AnexosEquipos
SET
 NumeroNCM=@NumeroNCM,
 Equipo=@Equipo,
 DescripcionAESA=@DescripcionAESA,
 DescripcionNCM=@DescripcionNCM
where (IdAnexoEquipos=@IdAnexoEquipos)
Return(@IdAnexoEquipos)
































