





























CREATE Procedure [dbo].[Rangos_TX_TT]
@IdRango int
AS 
Select IdRango,Descripcion
FROM Rangos
where (IdRango=@IdRango)
order by Descripcion






























