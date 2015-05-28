CREATE Procedure [dbo].[PresupuestoObrasNodosConsumos_TX_Control_HH_HE]

@Año int = Null, 
@Mes int = Null,
@Origen varchar(2) = Null

AS 

SET NOCOUNT ON

SET @Año=IsNull(@Año,-1)
SET @Mes=IsNull(@Mes,-1)
SET @Origen=IsNull(@Origen,'')

CREATE TABLE #Auxiliar 
			(
			 IdPresupuestoObrasNodoConsumo INTEGER,
			 IdPresupuestoObrasNodo INTEGER,
			 IdObra INTEGER,
			 Fecha DATETIME,
			 Numero INTEGER,
			 Detalle varchar(100),
			 Importe NUMERIC(18,2),
			 Cantidad NUMERIC(18,2)
			)
INSERT INTO #Auxiliar 
 SELECT ponc.IdPresupuestoObrasNodoConsumo, ponc.IdPresupuestoObrasNodo, pon.IdObra, ponc.Fecha, ponc.Numero, ponc.Detalle, ponc.Importe, ponc.Cantidad
 FROM PresupuestoObrasNodosConsumos ponc
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON pon.IdPresupuestoObrasNodo=ponc.IdPresupuestoObrasNodo
 WHERE (Len(@Origen)=0 or ponc.Origen=@Origen) and (@Año<=0 or year(ponc.Fecha)=@Año) and (@Mes<=0 or Month(ponc.Fecha)=@Mes)

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0116633'
SET @vector_T='0525500'

SELECT 
 #Auxiliar.IdObra as [IdObra],
 Obras.NumeroObra as [Obra],
 Obras.Descripcion as [Descripcion],
 Sum(IsNull(#Auxiliar.Cantidad,0)) as [Total Hs.],
 Sum(IsNull(#Auxiliar.Importe,0)) as [Total Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
LEFT OUTER JOIN Obras ON Obras.IdObra=#Auxiliar.IdObra
GROUP BY #Auxiliar.IdObra, Obras.NumeroObra,Obras.Descripcion

UNION ALL

SELECT 
 999999 as [IdObra],
 Null as [Obra],
 'TOTAL GENERAL' as [Descripcion],
 Sum(IsNull(#Auxiliar.Cantidad,0)) as [Total Hs.],
 Sum(IsNull(#Auxiliar.Importe,0)) as [Total Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
LEFT OUTER JOIN Obras ON Obras.IdObra=#Auxiliar.IdObra

ORDER BY [Descripcion], [Obra]

DROP TABLE #Auxiliar
