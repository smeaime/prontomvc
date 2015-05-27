





























CREATE Procedure [dbo].[DetAcoMateriales_A]
@IdDetalleAcoMaterial int  output,
@IdAcoMaterial int,
@IdMaterial int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoMateriales]
(
IdAcoMaterial,
IdMaterial
)
Values
(
@IdAcoMaterial,
@IdMaterial
)
Select @IdDetalleAcoMaterial=@@identity
Return(@IdDetalleAcoMaterial)






























