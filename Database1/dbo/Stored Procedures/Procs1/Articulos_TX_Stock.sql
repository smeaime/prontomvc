
CREATE Procedure [dbo].[Articulos_TX_Stock]

@IdStock int

AS

SELECT 
 Stk.IdStock,
 Stk.IdArticulo,
 Articulos.Codigo,
 Articulos.Descripcion,
 Stk.Partida,
 Stk.CantidadUnidades,
 Stk.CantidadAdicional,
 Stk.IdUnidad,
 Stk.IdObra,
 Unidades.Descripcion as [Unidad],
 Unidades.Abreviatura as [UnidadAb],
 Stk.IdUbicacion,
 Stk.NumeroCaja,
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Obras.NumeroObra as [Obra]
FROM Stock Stk
LEFT OUTER JOIN Articulos ON Stk.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON Stk.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Ubicaciones ON Stk.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras ON Stk.IdObra = Obras.IdObra
WHERE Stk.IdStock=@IdStock and IsNull(Articulos.RegistrarStock,'SI')='SI'
