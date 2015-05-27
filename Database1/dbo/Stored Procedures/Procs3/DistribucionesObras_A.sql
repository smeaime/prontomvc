


CREATE Procedure [dbo].[DistribucionesObras_A]
@IdDistribucionObra int  output,
@Descripcion varchar(50)
As 
Insert into DistribucionesObras
(
 Descripcion
)
Values
(
 @Descripcion
)
Select @IdDistribucionObra=@@identity
Return(@IdDistribucionObra)


