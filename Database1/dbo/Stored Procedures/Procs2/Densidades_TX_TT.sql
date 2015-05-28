





























CREATE Procedure [dbo].[Densidades_TX_TT]
@IdDensidad int
AS 
Select *
FROM Densidades
where (IdDensidad=@IdDensidad)






























