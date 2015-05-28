CREATE PROCEDURE [dbo].[Obras_TX_EstadoEquipos]

@FechaDesde datetime,
@FechaHasta datetime

AS 


SET NOCOUNT ON

CREATE TABLE #Auxiliar0 
			(
			 IdObra INTEGER,
			 IdArticulo INTEGER,
			 IdEquipo INTEGER,
			 FechaInstalacion DATETIME,
			 FechaDesinstalacion DATETIME
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar01 ON #Auxiliar0 (IdArticulo) ON [PRIMARY]
CREATE NONCLUSTERED INDEX IX__Auxiliar02 ON #Auxiliar0 (IdEquipo) ON [PRIMARY]
INSERT INTO #Auxiliar0
 SELECT doei.IdObra, Obras.IdArticuloAsociado, doei.IdArticulo, doei.FechaInstalacion, doei.FechaDesinstalacion
 FROM DetalleObrasEquiposInstalados doei
 LEFT OUTER JOIN Obras ON Obras.IdObra=doei.IdObra


CREATE TABLE #Auxiliar1 
			(
			 IdArticulo INTEGER,
			 Equipos INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdArticulo) ON [PRIMARY]
INSERT INTO #Auxiliar1
 SELECT IdArticulo, Count(*)
 FROM #Auxiliar0
 GROUP BY IdArticulo


CREATE TABLE #Auxiliar2 
			(
			 IdObra INTEGER,
			 IdArticulo INTEGER,
			 IdEquipo INTEGER,
			 FechaInstalacion DATETIME,
			 FechaDesinstalacion DATETIME,
			 DominioActual VARCHAR(20),
			 DominioAnterior VARCHAR(20),
			 ClienteActual VARCHAR(100),
			 ClienteAnterior VARCHAR(100)
			)
INSERT INTO #Auxiliar2
 SELECT doei.IdObra, Obras.IdArticuloAsociado, doei.IdArticulo, doei.FechaInstalacion, doei.FechaDesinstalacion, Null, Null, Null, Null
 FROM DetalleObrasEquiposInstalados doei
 LEFT OUTER JOIN Obras ON Obras.IdObra=doei.IdObra
 WHERE (IsNull(doei.FechaInstalacion,0) between @FechaDesde and @FechaHasta or IsNull(doei.FechaDesinstalacion,0) between @FechaDesde and @FechaHasta) and 
		IsNull((Select #Auxiliar1.Equipos From #Auxiliar1 Where #Auxiliar1.IdArticulo=Obras.IdArticuloAsociado),0)>1

UPDATE #Auxiliar2
SET DominioActual=(Select Top 1 Articulos.Codigo From Obras 
			Left Outer Join Articulos On Articulos.IdArticulo=Obras.IdArticuloAsociado
			Where Obras.IdObra=#Auxiliar2.IdObra and #Auxiliar2.FechaDesinstalacion is null)
UPDATE #Auxiliar2
SET DominioAnterior=(Select Top 1 Articulos.Codigo From #Auxiliar0 A0
			Left Outer Join Obras On Obras.IdObra=A0.IdObra
			Left Outer Join Articulos On Articulos.IdArticulo=Obras.IdArticuloAsociado
			Where A0.IdEquipo=#Auxiliar2.IdEquipo and A0.FechaDesinstalacion is not null and A0.FechaDesinstalacion<=IsNull(#Auxiliar2.FechaDesinstalacion,#Auxiliar2.FechaInstalacion)
			Order By A0.FechaDesinstalacion Desc)
/*
1	15/08/2012	
5	01/07/2012	01/08/2012
3	05/04/2012	01/07/2012
7	12/02/2012	05/04/2012
*/

UPDATE #Auxiliar2
SET ClienteActual=(Select Top 1 Clientes.RazonSocial From Obras 
			Left Outer Join Clientes On Clientes.IdCliente=Obras.IdCliente
			Where Obras.IdObra=#Auxiliar2.IdObra and #Auxiliar2.FechaDesinstalacion is null)
UPDATE #Auxiliar2
SET ClienteAnterior=(Select Top 1 Clientes.RazonSocial From #Auxiliar0 A0
			Left Outer Join Obras On Obras.IdObra=A0.IdObra
			Left Outer Join Clientes On Clientes.IdCliente=Obras.IdCliente
			Where A0.IdEquipo=#Auxiliar2.IdEquipo and A0.FechaDesinstalacion is not null and A0.FechaDesinstalacion<=IsNull(#Auxiliar2.FechaDesinstalacion,#Auxiliar2.FechaInstalacion)
			Order By A0.FechaDesinstalacion Desc)


CREATE TABLE #Auxiliar3 
			(
			 IdObra INTEGER,
			 IdArticulo INTEGER,
			 IdEquipo INTEGER,
			 FechaInstalacion DATETIME,
			 DominioActual VARCHAR(20),
			 ClienteActual VARCHAR(100)
			)
INSERT INTO #Auxiliar3
 SELECT doei.IdObra, Obras.IdArticuloAsociado, doei.IdArticulo, doei.FechaInstalacion, Null, Null
 FROM DetalleObrasEquiposInstalados doei
 LEFT OUTER JOIN Obras ON Obras.IdObra=doei.IdObra
 WHERE IsNull(doei.FechaInstalacion,0) between @FechaDesde and @FechaHasta and doei.FechaDesinstalacion is null and 
		IsNull((Select #Auxiliar1.Equipos From #Auxiliar1 Where #Auxiliar1.IdArticulo=Obras.IdArticuloAsociado),0)=1

UPDATE #Auxiliar3
SET DominioActual=(Select Top 1 Articulos.Codigo From Obras 
			Left Outer Join Articulos On Articulos.IdArticulo=Obras.IdArticuloAsociado
			Where Obras.IdObra=#Auxiliar3.IdObra)
UPDATE #Auxiliar3
SET ClienteActual=(Select Top 1 Clientes.RazonSocial From Obras 
			Left Outer Join Clientes On Clientes.IdCliente=Obras.IdCliente
			Where Obras.IdObra=#Auxiliar3.IdObra)


CREATE TABLE #Auxiliar4 
			(
			 IdArticulo INTEGER,
			 IdEquipo INTEGER,
			 FechaDesinstalacion DATETIME,
			 DominioAnterior VARCHAR(20),
			 ClienteAnterior VARCHAR(100)
			)
INSERT INTO #Auxiliar4
 SELECT Obras.IdArticuloAsociado, doei.IdArticulo, doei.FechaDesinstalacion, Null, Null
 FROM DetalleObrasEquiposInstalados doei
 LEFT OUTER JOIN Obras ON Obras.IdObra=doei.IdObra
 WHERE IsNull(doei.FechaDesinstalacion,0) between @FechaDesde and @FechaHasta and doei.FechaDesinstalacion is not null and 
	not Exists(Select #Auxiliar0.IdEquipo From #Auxiliar0 Where #Auxiliar0.IdEquipo=doei.IdArticulo and doei.FechaDesinstalacion is null)

UPDATE #Auxiliar4
SET DominioAnterior=(Select Top 1 Articulos.Codigo From #Auxiliar0 A0
			Left Outer Join Obras On Obras.IdObra=A0.IdObra
			Left Outer Join Articulos On Articulos.IdArticulo=Obras.IdArticuloAsociado
			Where A0.IdEquipo=#Auxiliar4.IdEquipo and A0.FechaInstalacion is not null and A0.FechaInstalacion<=#Auxiliar4.FechaDesinstalacion
			Order By A0.FechaInstalacion Desc)
UPDATE #Auxiliar4
SET ClienteAnterior=(Select Top 1 Clientes.RazonSocial From #Auxiliar0 A0
			Left Outer Join Obras On Obras.IdObra=A0.IdObra
			Left Outer Join Clientes On Clientes.IdCliente=Obras.IdCliente
			Where A0.IdEquipo=#Auxiliar4.IdEquipo and A0.FechaInstalacion is not null and A0.FechaInstalacion<=#Auxiliar4.FechaDesinstalacion
			Order By A0.FechaInstalacion Desc)

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111111133'
SET @vector_T='0398325532300'

SELECT 
 A1.Codigo as [IdAux],
 A1.Codigo as [Unidad],
 1 as [Orden],
 'INSTALACIONES' as [Tipo],
 A2.Codigo as [Equipo],
 #Auxiliar3.DominioActual as [Dominio actual],
 #Auxiliar3.FechaInstalacion as [Fecha inst.],
 Null as [Fecha desinst.],
 #Auxiliar3.ClienteActual as [Cliente actual],
 Null as [Dominio anterior],
 Null  as [Cliente anterior],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3
LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo=#Auxiliar3.IdArticulo
LEFT OUTER JOIN Articulos A2 ON A2.IdArticulo=#Auxiliar3.IdEquipo

UNION ALL

SELECT 
 A1.Codigo as [IdAux],
 A1.Codigo as [Unidad],
 2 as [Orden],
 'CAMBIO DE EQUIPO' as [Tipo],
 A2.Codigo as [Equipo],
 #Auxiliar2.DominioActual as [Dominio actual],
 #Auxiliar2.FechaInstalacion as [Fecha inst.],
 #Auxiliar2.FechaDesinstalacion as [Fecha desinst.],
 #Auxiliar2.ClienteActual as [Cliente actual],
 #Auxiliar2.DominioAnterior as [Dominio anterior],
 #Auxiliar2.ClienteAnterior as [Cliente anterior],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo=#Auxiliar2.IdArticulo
LEFT OUTER JOIN Articulos A2 ON A2.IdArticulo=#Auxiliar2.IdEquipo

UNION ALL 

SELECT 
 A1.Codigo as [IdAux],
 A1.Codigo as [Unidad],
 3 as [Orden],
 'DESINSTALACIONES' as [Tipo],
 A2.Codigo as [Equipo],
 Null as [Dominio actual],
 Null as [Fecha inst.],
 #Auxiliar4.FechaDesinstalacion as [Fecha desinst.],
 Null as [Cliente actual],
 #Auxiliar4.DominioAnterior as [Dominio anterior],
 #Auxiliar4.ClienteAnterior as [Cliente anterior],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar4
LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo=#Auxiliar4.IdArticulo
LEFT OUTER JOIN Articulos A2 ON A2.IdArticulo=#Auxiliar4.IdEquipo

ORDER BY [Orden], [IdAux], [Fecha inst.], [Fecha desinst.] Desc

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4