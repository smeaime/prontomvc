CREATE Procedure [dbo].[Stock_TX_PorNumeroCaja]

@NumeroCaja int

AS 

SELECT TOP 1 
 Stk.*, 
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Articulos.Caracteristicas as [Caracteristicas],
 Articulos.CostoPPP,
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Obras.NumeroObra as [Obra],
 Unidades.Abreviatura as [Un],
 Colores.Descripcion as [Color]
FROM Stock Stk
LEFT OUTER JOIN Articulos ON Stk.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON Stk.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Ubicaciones ON Stk.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras ON Stk.IdObra = Obras.IdObra
LEFT OUTER JOIN UnidadesEmpaque ON Stk.NumeroCaja = UnidadesEmpaque.NumeroUnidad
LEFT OUTER JOIN Colores ON IsNull(UnidadesEmpaque.IdColor,Stk.IdColor) = Colores.IdColor
WHERE IsNull(Stk.NumeroCaja,0)=@NumeroCaja and Stk.CantidadUnidades<>0