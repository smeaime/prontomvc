CREATE Procedure [dbo].[TiposCompra_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011133'
SET @vector_T='029200'

SELECT 
 TiposCompra.IdTipoCompra as [IdTipoCompra],
 TiposCompra.Descripcion as [Tipo compra],
 TiposCompra.IdTipoCompra as [IdAux],
 TiposCompra.Modalidad as [Mod.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM TiposCompra
ORDER BY TiposCompra.Descripcion