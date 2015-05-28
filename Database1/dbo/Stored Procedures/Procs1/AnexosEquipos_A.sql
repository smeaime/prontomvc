































CREATE Procedure [dbo].[AnexosEquipos_A]
@IdAnexoEquipos int  output,
@NumeroNCM varchar(10),
@Equipo varchar(70),
@DescripcionAESA ntext,
@DescripcionNCM ntext
AS 
Insert into AnexosEquipos
(
 NumeroNCM,
 Equipo,
 DescripcionAESA,
 DescripcionNCM
)
Values
(
 @NumeroNCM,
 @Equipo,
 @DescripcionAESA,
 @DescripcionNCM
)
Select @IdAnexoEquipos=@@identity
Return(@IdAnexoEquipos)
































