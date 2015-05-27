

--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////


CREATE PROCEDURE [dbo].[DetProduccionFichas_TXSal]

@IdProduccionFicha int,
@IdObra int = Null

AS 

SET @IdObra=IsNull(@IdObra,-1)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='000011111133'
Set @vector_T='000033E33300'

SELECT 
 DetSal.IdDetalleProduccionFicha,
 DetSal.IdProduccionFicha,
 DetSal.IdArticulo,
 DetSal.IdUnidad,
 '    ' as [Estado],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as Articulo,
 DetSal.Cantidad as [Cant.],
 Porcentaje as [%],
 Unidades.Descripcion as [En :],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProduccionFichas DetSal
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
WHERE DetSal.IdProduccionFicha = @IdProduccionFicha

