CREATE Procedure [dbo].[Articulos_TX_StockPorPartida]

@IdArticulo int

AS

SET NOCOUNT ON

DECLARE @vector_X varchar(50), @vector_T varchar(50), @Clave varchar(3), @MostrarDatosTelas varchar(2)

SET @MostrarDatosTelas=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
				Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
				Where pic.Clave='Mostrar datos de telas en consultas de stock' and IsNull(ProntoIni.Valor,'')='SI'),'')

EXEC Stock_CalcularEquivalencias

CREATE TABLE #Auxiliar1
			(
			 IdArticulo INTEGER,
			 IdUbicacion INTEGER,
			 IdUnidad INTEGER,
			 Partida VARCHAR(20),
			 Cantidad NUMERIC(18, 2),
			 Reservado NUMERIC(18, 2),
			 NumeroCaja INTEGER,
			 Equivalencia NUMERIC(18,6),
			 CantidadEquivalencia NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Stk.IdArticulo,
  Stk.IdUbicacion,
  Stk.IdUnidad,
  Stk.Partida,
  Stk.CantidadUnidades,
  (Select Sum(DetalleReservas.CantidadUnidades) From DetalleReservas Where DetalleReservas.IdStock=Stk.IdStock),
  Stk.NumeroCaja,
  Stk.Equivalencia,
  Stk.CantidadEquivalencia
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
			 Equivalencia NUMERIC(18,6),
			 CantidadEquivalencia NUMERIC(18,2)
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
  #Auxiliar1.Equivalencia,
  SUM(#Auxiliar1.CantidadEquivalencia)
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdArticulo, #Auxiliar1.IdUbicacion, #Auxiliar1.IdUnidad, #Auxiliar1.Partida, #Auxiliar1.NumeroCaja, #Auxiliar1.Equivalencia

SET @vector_X='01011111101111111133'
IF @MostrarDatosTelas='SI'
	SET @vector_T='0902D103101222232F00'
ELSE
	SET @vector_T='0902D103101222239900'
SET @Clave='SPP'

SET NOCOUNT OFF

SELECT
 #Auxiliar2.IdArticulo as [IdArticulo],
 @Clave as [StockPorPartida],
 #Auxiliar2.IdArticulo as [IdArticulo],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Colores.Descripcion as [Color],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 #Auxiliar2.Partida as [Partida],
 #Auxiliar2.Cantidad as [Cant.],
 #Auxiliar2.IdUnidad as [IdUnidad],
 U1.Abreviatura as [Unidad],
 U2.Abreviatura as [Equiv. a],
 #Auxiliar2.Equivalencia as [Equiv.],
 #Auxiliar2.CantidadEquivalencia as [Cant.Equiv.],
 #Auxiliar2.NumeroCaja as [Nro.Caja],
 #Auxiliar2.Reservado as [Cant.Res.],
 UnidadesEmpaque.Metros as [Metros],
 UnidadesEmpaque.PartidasOrigen as [Partidas utilizadas],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN Articulos ON #Auxiliar2.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades U1 ON #Auxiliar2.IdUnidad = U1.IdUnidad
LEFT OUTER JOIN Unidades U2 ON Articulos.IdUnidad = U2.IdUnidad
LEFT OUTER JOIN Ubicaciones ON #Auxiliar2.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN UnidadesEmpaque ON #Auxiliar2.NumeroCaja = UnidadesEmpaque.NumeroUnidad
LEFT OUTER JOIN Colores ON UnidadesEmpaque.IdColor = Colores.IdColor

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2