


CREATE Procedure [dbo].[DetDistribucionesObras_M]
@IdDetalleDistribucionObra int,
@IdDistribucionObra int,
@IdObra int,
@Porcentaje numeric(6,2)
As
Update [DetalleDistribucionesObras]
Set 
 IdDistribucionObra=@IdDistribucionObra,
 IdObra=@IdObra,
 Porcentaje=@Porcentaje
Where (IdDetalleDistribucionObra=@IdDetalleDistribucionObra)
Return(@IdDetalleDistribucionObra)


