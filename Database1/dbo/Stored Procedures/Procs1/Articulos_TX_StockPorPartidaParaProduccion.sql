
create Procedure [dbo].[Articulos_TX_StockPorPartidaParaProduccion]

@IdArticulo INT,
@IdUbicacion INT=null

AS

if @IdUbicacion=-1 begin set @IdUbicacion=null end

SET NOCOUNT ON

CREATE TABLE #Auxiliar1
			(
			 IdArticulo INTEGER,
			 IdUbicacion INTEGER,
			 IdUnidad INTEGER,
			 Partida VARCHAR(20),
			 Cantidad NUMERIC(18, 2),
			 Reservado NUMERIC(18, 2),
			 NumeroCaja INTEGER,
			IdStock INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Stk.IdArticulo,
  Stk.IdUbicacion,
  Stk.IdUnidad,
  Stk.Partida,
  Stk.CantidadUnidades,
 (Select Sum(DetalleReservas.CantidadUnidades) 
  From DetalleReservas
  Where DetalleReservas.IdStock=Stk.IdStock),
  Stk.NumeroCaja,
  Stk.IdStock
 FROM Stock Stk
 LEFT OUTER JOIN Articulos ON Stk.IdArticulo = Articulos.IdArticulo
 WHERE Stk.IdArticulo=@IdArticulo and Stk.CantidadUnidades<>0 and IsNull(Articulos.RegistrarStock,'SI')='SI'

UPDATE #Auxiliar1
SET Reservado=0 
WHERE Reservado IS NULL

CREATE TABLE #Auxiliar2
			(
			 IdArticulo INTEGER,
			 IdUbicacion INTEGER,
			 IdUnidad INTEGER,
			 Partida VARCHAR(20),
			 Cantidad NUMERIC(18, 2),
			 Reservado NUMERIC(18, 2),
			 NumeroCaja INTEGER,
			IdStock INTEGER
			)
INSERT INTO #Auxiliar2 
 SELECT 
  #Auxiliar1.IdArticulo,
  #Auxiliar1.IdUbicacion,
  #Auxiliar1.IdUnidad,
  #Auxiliar1.Partida,
  SUM(#Auxiliar1.Cantidad),
  SUM(#Auxiliar1.Reservado),
  #Auxiliar1.NumeroCaja,
  #Auxiliar1.IdStock
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdArticulo, #Auxiliar1.IdUbicacion, #Auxiliar1.IdUnidad, #Auxiliar1.Partida, #Auxiliar1.NumeroCaja, #Auxiliar1.IdStock

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30),@Clave varchar(3)
SET @vector_X='01011111101111133'
SET @vector_T='0902D103101231900'
SET @Clave='SPP'

SELECT
 #Auxiliar2.IdArticulo,
 @Clave as [StockPorPartida],
 #Auxiliar2.IdArticulo,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Colores.Descripcion as [Color],
 Depositos.Descripcion+' - Est.:'+Ubicaciones.Estanteria+
	' - Mod.:'+Ubicaciones.Modulo+' - Gab.:'+Ubicaciones.Gabeta as [Ubicacion],
 #Auxiliar2.Partida,
 #Auxiliar2.Cantidad as [Cant.],
 #Auxiliar2.IdUnidad,
 Unidades.Descripcion as [Unidad],
 #Auxiliar2.NumeroCaja as [Nro.Caja],
 #Auxiliar2.Reservado as [Cant.Res.],
 Ubicaciones.IdUbicacion,
#Auxiliar2.IdStock,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN Articulos ON #Auxiliar2.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON #Auxiliar2.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Ubicaciones ON #Auxiliar2.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN UnidadesEmpaque ON #Auxiliar2.NumeroCaja = UnidadesEmpaque.NumeroUnidad
LEFT OUTER JOIN Colores ON UnidadesEmpaque.IdColor = Colores.IdColor
WHERE #Auxiliar2.IdUbicacion =ISNULL(@IdUbicacion,#Auxiliar2.IdUbicacion)


DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
