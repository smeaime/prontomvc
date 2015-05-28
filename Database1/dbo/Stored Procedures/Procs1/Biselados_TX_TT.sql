





























CREATE Procedure [dbo].[Biselados_TX_TT]
@IdBiselado int
AS 
Select *
FROM Biselados
where (IdBiselado=@IdBiselado)






























