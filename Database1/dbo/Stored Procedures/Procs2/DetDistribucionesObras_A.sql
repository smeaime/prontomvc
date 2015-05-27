


CREATE Procedure [dbo].[DetDistribucionesObras_A]
@IdDetalleDistribucionObra int  output,
@IdDistribucionObra int,
@IdObra int,
@Porcentaje numeric(6,2)
As 
Insert into [DetalleDistribucionesObras]
(
 IdDistribucionObra,
 IdObra,
 Porcentaje
)
Values
(
 @IdDistribucionObra,
 @IdObra,
 @Porcentaje
)
Select @IdDetalleDistribucionObra=@@identity
Return(@IdDetalleDistribucionObra)


