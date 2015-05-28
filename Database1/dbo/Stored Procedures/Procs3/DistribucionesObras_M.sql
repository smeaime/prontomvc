CREATE Procedure [dbo].[DistribucionesObras_M]

@IdDistribucionObra int,
@Descripcion varchar(50)

As

Update DistribucionesObras
Set Descripcion=@Descripcion
Where (IdDistribucionObra=@IdDistribucionObra)
Return(@IdDistribucionObra)
