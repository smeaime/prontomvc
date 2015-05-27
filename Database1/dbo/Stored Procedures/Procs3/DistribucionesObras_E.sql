


CREATE Procedure [dbo].[DistribucionesObras_E]
@IdDistribucionObra int  
As 
Delete DistribucionesObras
Where (IdDistribucionObra=@IdDistribucionObra)


