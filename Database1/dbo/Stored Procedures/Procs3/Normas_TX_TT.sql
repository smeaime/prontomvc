





























CREATE Procedure [dbo].[Normas_TX_TT]
@IdNorma int
AS 
Select *
FROM Normas
where (IdNorma=@IdNorma)
order by Descripcion






























