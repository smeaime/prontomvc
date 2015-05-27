





























CREATE Procedure [dbo].[IGCondiciones_TX_TT]
@IdIGCondicion int
AS 
Select IdIGCondicion,Descripcion
FROM IGCondiciones
where (IdIGCondicion=@IdIGCondicion)
order by Descripcion






























