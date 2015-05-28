





























CREATE Procedure [dbo].[ItemsPopUpMateriales_TX_ParaMenu]

@strsql ntext

AS

SET NOCOUNT ON

CREATE TABLE #PopUp (
			 IdArticulo INTEGER,
			 IdRubro INTEGER,
			 IdSubrubro INTEGER,
			 Campo01_Clave VARCHAR(50),
			 Campo01_Descripcion VARCHAR(50),
			 Campo02_Clave VARCHAR(50),
			 Campo02_Descripcion VARCHAR(50),
			 Campo03_Clave VARCHAR(50),
			 Campo03_Descripcion VARCHAR(50),
			 Campo04_Clave VARCHAR(50),
			 Campo04_Descripcion VARCHAR(50),
			 Campo05_Clave VARCHAR(50),
			 Campo05_Descripcion VARCHAR(50),
			 Campo06_Clave VARCHAR(50),
			 Campo06_Descripcion VARCHAR(50),
			 Campo07_Clave VARCHAR(50),
			 Campo07_Descripcion VARCHAR(50),
			 Campo08_Clave VARCHAR(50),
			 Campo08_Descripcion VARCHAR(50),
			 Campo09_Clave VARCHAR(50),
			 Campo09_Descripcion  VARCHAR(50),
			 Campo10_Clave VARCHAR(50),
			 Campo10_Descripcion VARCHAR(50),
			 Campo11_Clave VARCHAR(50),
			 Campo11_Descripcion VARCHAR(50),
			 Campo12_Clave VARCHAR(50),
			 Campo12_Descripcion VARCHAR(50)
			)
INSERT INTO #PopUp 
 Select Articulos.IdArticulo,Articulos.IdRubro,Articulos.IdSubrubro,
	'Rubros',Rubros.Descripcion,
	'Subrubros',SubRubros.Descripcion,
	Null,Null,
	Null,Null,
	Null,Null,
	Null,Null,
	Null,Null,
	Null,Null,
	Null,Null,
	Null,Null,
	Null,Null,
	Null,Null
 From Articulos
 Left Outer Join Rubros On Rubros.IdRubro=Articulos.IdRubro
 Left Outer Join SubRubros On SubRubros.IdSubrubro=Articulos.IdSubrubro
 Left Outer Join ItemsPopUpMateriales It On It.IdRubro=Articulos.IdRubro And It.IdSubrubro=Articulos.IdSubrubro And It.IdFamilia=Articulos.IdFamilia
 Where It.IdItemPopUpMateriales is Null

Exec(@strsql)

SET NOCOUNT OFF

SELECT 
 Articulos.Descripcion as [Articulo],
 #PopUp.* 
FROM #PopUp
LEFT OUTER JOIN Articulos On Articulos.IdArticulo=#PopUp.IdArticulo
ORDER By 	Campo01_Clave,Campo01_Descripcion,
		Campo02_Clave,Campo02_Descripcion,
		Campo03_Clave,Campo03_Descripcion,
		Campo04_Clave,Campo04_Descripcion,
		Campo05_Clave,Campo05_Descripcion,
		Campo06_Clave,Campo06_Descripcion,
		Campo07_Clave,Campo07_Descripcion,
		Campo08_Clave,Campo08_Descripcion,
		Campo09_Clave,Campo09_Descripcion,
		Campo10_Clave,Campo10_Descripcion,
		Campo11_Clave,Campo11_Descripcion,
		Campo12_Clave,Campo12_Descripcion,
		Articulos.Descripcion
DROP TABLE #PopUp





























