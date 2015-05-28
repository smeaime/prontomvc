
CREATE Procedure [dbo].[wArticulos_T]

@IdArticulo int = Null

AS 

SET @IdArticulo=IsNull(@IdArticulo,-1)

SELECT 
 Articulos.*,
 Rubros.Descripcion as [Rubro],
 Subrubros.Descripcion as [Subrubro],
 (Select Sum(Stock.CantidadUnidades) From Stock 
	Where Stock.IdArticulo=Articulos.IdArticulo) as [Stock actual],
 (Select Top 1 Unidades.Abreviatura From Unidades 
	Where Articulos.IdUnidad=Unidades.IdUnidad) as [Un],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Unidades.Abreviatura as [Unidad]
FROM Articulos
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro 
LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro 
LEFT OUTER JOIN Ubicaciones ON Articulos.IdUbicacionStandar = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Unidades ON Articulos.IdUnidad = Unidades.IdUnidad
WHERE (@IdArticulo=-1 or Articulos.IdArticulo=@IdArticulo) and IsNull(Articulos.Activo,'')<>'NO'
ORDER by Rubros.Descripcion,Subrubros.Descripcion,Articulos.Codigo
