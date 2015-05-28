






























CREATE Procedure [dbo].[ItemsPopUpMateriales_TT]
AS 
Select 
IdItemPopUpMateriales,
Rubros.Descripcion as [Rubro],
SubRubros.Descripcion as [Subrubro],
Familias.Descripcion as [Familia],
Campo01_Nombre as [Campo 1],
Campo02_Nombre as [Campo 2],
Campo03_Nombre as [Campo 3],
Campo04_Nombre as [Campo 4],
Campo05_Nombre as [Campo 5],
Campo06_Nombre as [Campo 6],
Campo07_Nombre as [Campo 7],
Campo08_Nombre as [Campo 8],
Campo09_Nombre as [Campo 9],
Campo10_Nombre as [Campo 10]
FROM ItemsPopUpMateriales
Left Outer Join Rubros On Rubros.IdRubro=ItemsPopUpMateriales.IdRubro
Left Outer Join SubRubros On SubRubros.IdSubrubro=ItemsPopUpMateriales.IdSubrubro
Left Outer Join Familias On Familias.IdFamilia=ItemsPopUpMateriales.IdFamilia
ORDER by Rubros.Descripcion,SubRubros.Descripcion,Familias.Descripcion































