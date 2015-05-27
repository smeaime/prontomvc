





























CREATE Procedure [dbo].[Materiales_TX_TT]
@IdMaterial smallint
AS 
Select IdMaterial,Descripcion
FROM Materiales
where (IdMaterial=@IdMaterial)
order by Descripcion






























