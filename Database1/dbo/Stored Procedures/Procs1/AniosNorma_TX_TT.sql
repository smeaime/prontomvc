































CREATE Procedure [dbo].[AniosNorma_TX_TT]
@IdAnioNorma int
AS 
Select IdAnioNorma,Descripcion
FROM AniosNorma
where (IdAnioNorma=@IdAnioNorma)
order by Descripcion
































