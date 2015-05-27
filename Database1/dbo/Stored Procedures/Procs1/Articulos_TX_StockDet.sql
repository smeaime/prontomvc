


CREATE Procedure [dbo].[Articulos_TX_StockDet]

@IdArticulo int,
@Partida varchar(20),
@IdUnidad int

AS

SELECT TOP 1
 Stk.IdStock,
 Stk.IdArticulo,
 Articulos.Descripcion,
 Stk.Partida,
 Stk.CantidadUnidades,
 Stk.CantidadAdicional,
 Stk.IdUnidad,
 Unidades.Descripcion as [Unidad],
 (Select sum(DetalleReservas.CantidadUnidades) 
	from DetalleReservas
	where DetalleReservas.IdStock=Stk.IdStock	) as [Cant.Res.],
 (Select sum(DetalleReservas.CantidadAdicional) 
	from DetalleReservas
	where DetalleReservas.IdStock=Stk.IdStock and not DetalleReservas.CantidadAdicional is null) as [Med.Reserv.]
FROM Stock Stk
LEFT OUTER JOIN Articulos ON Stk.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON Stk.IdUnidad = Unidades.IdUnidad
WHERE Stk.IdArticulo=@IdArticulo and IsNull(Articulos.RegistrarStock,'SI')='SI' and 
	Stk.Partida=@Partida and Stk.IdUnidad=@IdUnidad


