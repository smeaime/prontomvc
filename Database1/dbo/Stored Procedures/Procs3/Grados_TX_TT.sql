





























CREATE Procedure [dbo].[Grados_TX_TT]
@IdGrado int
AS 
Select IdGrado,Descripcion
FROM Grados
where (IdGrado=@IdGrado)
order by Descripcion






























