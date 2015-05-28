


CREATE  Procedure [dbo].[DistribucionesObras_TX_TT]

@IdDistribucionObra int

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0133'
set @vector_T='0500'

SELECT 
 DistribucionesObras.IdDistribucionObra,
 DistribucionesObras.Descripcion as [Nombre de la matriz],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DistribucionesObras
WHERE (IdDistribucionObra=@IdDistribucionObra)


