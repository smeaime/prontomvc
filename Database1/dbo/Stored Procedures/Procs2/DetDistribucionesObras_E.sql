


CREATE Procedure [dbo].[DetDistribucionesObras_E]
@IdDetalleDistribucionObra int  
As 
Delete [DetalleDistribucionesObras]
Where (IdDetalleDistribucionObra=@IdDetalleDistribucionObra)


