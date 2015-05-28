





























CREATE Procedure [dbo].[Calidades_TX_TT]
@IdCalidad int
AS 
Select IdCalidad,Descripcion
FROM Calidades
where (IdCalidad=@IdCalidad)
order by Descripcion






























