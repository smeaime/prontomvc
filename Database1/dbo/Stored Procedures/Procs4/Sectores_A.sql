



CREATE Procedure [dbo].[Sectores_A]
@IdSector int  output,
@Descripcion varchar(50),
@SectorDeObra varchar(2),
@IdEncargado int,
@SeUsaEnPresupuestos varchar(2),
@OrdenPresentacion int,
@EnviarEmail tinyint
As 
Insert into [Sectores]
(
 Descripcion,
 SectorDeObra,
 IdEncargado,
 SeUsaEnPresupuestos,
 OrdenPresentacion,
 EnviarEmail
)
Values
(
 @Descripcion,
 @SectorDeObra,
 @IdEncargado,
 @SeUsaEnPresupuestos,
 @OrdenPresentacion,
 @EnviarEmail
)
Select @IdSector=@@identity
Return(@IdSector)



