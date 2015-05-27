CREATE Procedure [dbo].[CuboReservaPresupuestaria]

@FechaDesde datetime,
@FechaHasta datetime,
@Dts varchar(200)

AS 

SET NOCOUNT ON

TRUNCATE TABLE _TempCuboReservaPresupuestaria
INSERT INTO _TempCuboReservaPresupuestaria
 SELECT 
  Rubros.Descripcion,
  Articulos.Descripcion,
  Obras.NumeroObra+' '+IsNull(Requerimientos.Detalle,''),
  Articulos.CostoReposicion,
  DetReq.Cantidad,
  DetReq.Cantidad * IsNull(DetReq.Costo,IsNull(Articulos.CostoReposicion,0)),
  IsNull(Subrubros.Abreviatura,'S/D'),
  Requerimientos.NumeroRequerimiento
 FROM DetalleRequerimientos DetReq
 LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
 LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
 LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro
 WHERE Requerimientos.FechaRequerimiento 
		between @FechaDesde and DATEADD(n,1439,@FechaHasta) 

Declare @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT OFF