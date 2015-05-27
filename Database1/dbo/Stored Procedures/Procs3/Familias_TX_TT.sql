





























CREATE Procedure [dbo].[Familias_TX_TT]
@IdFamilia smallint
AS 
Select 
IdFamilia,
Descripcion
FROM Familias
where (IdFamilia=@IdFamilia)
order by Descripcion






























