CREATE PROCEDURE [dbo].[ValesSalida_TX_PendientesDetallado]

@Parciales int

AS

SET NOCOUNT ON

DECLARE @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA varchar(2), @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50), @StockObra varchar(2)

SET @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA=IsNull((Select Top 1 Valor From Parametros2 Where Campo='EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA'),'NO')
SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')

CREATE TABLE #Auxiliar3 (IdArticulo INTEGER, Descripcion VARCHAR(256), NumeroInventario VARCHAR(20))
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdArticulo) ON [PRIMARY]

IF @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA='SI' and Len(@BasePRONTOMANT)>0
  BEGIN
	SET @sql1='Select Distinct a.IdArticulo, a.Descripcion, a.NumeroInventario 
				From DetalleValesSalida DetVal
				Left Outer Join DetalleRequerimientos dr On dr.IdDetalleRequerimiento = DetVal.IdDetalleRequerimiento
				Left Outer Join Requerimientos On dr.IdRequerimiento = Requerimientos.IdRequerimiento
				Left Outer Join '+@BasePRONTOMANT+'.dbo.Articulos a On IsNull(DetVal.IdEquipoDestino,IsNull(dr.IdEquipoDestino,Requerimientos.IdEquipoDestino)) = a.IdArticulo
				Where a.IdArticulo is not null and IsNull(A.ParaMantenimiento,'+''''+''+''''+')='+''''+'SI'+''''+' and IsNull(A.Activo,'+''''+''+''''+')<>'+''''+'NO'+''''
	INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
  END
ELSE
  BEGIN
	INSERT INTO #Auxiliar3 
	 SELECT DISTINCT a.IdArticulo, a.Descripcion, a.NumeroInventario
	 FROM DetalleValesSalida DetVal
	 LEFT OUTER JOIN DetalleRequerimientos dr ON dr.IdDetalleRequerimiento = DetVal.IdDetalleRequerimiento
	 LEFT OUTER JOIN Requerimientos ON dr.IdRequerimiento = Requerimientos.IdRequerimiento
	 LEFT OUTER JOIN Articulos a ON IsNull(DetVal.IdEquipoDestino,IsNull(dr.IdEquipoDestino,Requerimientos.IdEquipoDestino)) = a.IdArticulo
	 WHERE a.IdArticulo is not null and IsNull(a.Activo,'')<>'NO' and IsNull(a.ParaMantenimiento,'SI')='SI' 
  END

SET @StockObra=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
						Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
						Where pic.Clave='Mostrar stock de obra en consulta de vales' and IsNull(ProntoIni.Valor,'')='SI'),'')

CREATE TABLE #Auxiliar1	
			(
			 IdDetalleValeSalida INTEGER,
			 Entregado NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetSal.IdDetalleValeSalida,
  SUM(DetSal.Cantidad) 
 FROM DetalleSalidasMateriales DetSal
 LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and DetSal.IdDetalleValeSalida is not null
 GROUP BY DetSal.IdDetalleValeSalida

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='001111111111111111111133'
IF @StockObra='SI'
	SET @vector_T='00342E199901199230185E00'
ELSE
	SET @vector_T='00342E199901192930185E00'

SELECT
 DetVal.IdValeSalida,
 DetVal.IdArticulo,
 ValesSalida.NumeroValeSalida as [Vale (Det.)],
 ValesSalida.FechaValeSalida as [Fecha],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetVal.Cantidad as [Cant.],
 DetVal.Cantidad1 as [Med.1],
 DetVal.Cantidad2 as [Med.2],
 DetVal.IdValeSalida as [IdAux],
 Unidades.Abreviatura as [En :],
 #Auxiliar1.Entregado as [Entregado],
 Case When #Auxiliar1.Entregado is not null Then DetVal.Cantidad-#Auxiliar1.Entregado Else DetVal.Cantidad End as [Pendiente],
 DetVal.IdDetalleValeSalida as [IdAux1],
 (Select Sum(IsNull(Stock.CantidadUnidades,0)) From Stock Where Stock.IdArticulo=DetVal.IdArticulo) as [Stock tot.actual],
 (Select Sum(IsNull(Stock.CantidadUnidades,0)) From Stock Where Stock.IdArticulo=DetVal.IdArticulo and Stock.IdObra=ValesSalida.IdObra) as [Stock en obra],
 Obras.NumeroObra as [Obra],
 Empleados.Nombre as [Aprobo],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 ValesSalida.Observaciones as [Observaciones],
 DetReq.Observaciones as [Observaciones item RM],
 #Auxiliar3.NumeroInventario+' '+#Auxiliar3.Descripcion as [Equipo destino],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleValesSalida DetVal
LEFT OUTER JOIN Articulos ON DetVal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetVal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN ValesSalida ON DetVal.IdValeSalida= ValesSalida.IdValeSalida
LEFT OUTER JOIN #Auxiliar1 ON DetVal.IdDetalleValeSalida= #Auxiliar1.IdDetalleValeSalida
LEFT OUTER JOIN Obras ON ValesSalida.IdObra = Obras.IdObra
LEFT OUTER JOIN Ubicaciones ON Articulos.IdUbicacionStandar = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Empleados ON ValesSalida.Aprobo = Empleados.IdEmpleado
LEFT OUTER JOIN DetalleRequerimientos DetReq On DetVal.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetReq.IdRequerimiento
LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdArticulo = IsNull(DetVal.IdEquipoDestino,IsNull(DetReq.IdEquipoDestino,Requerimientos.IdEquipoDestino))
WHERE IsNull(ValesSalida.Cumplido,'')<>'SI' and IsNull(DetVal.Cumplido,'')<>'SI' and IsNull(DetVal.Estado,'')<>'AN' and 
		(@Parciales=-1 or IsNull(#Auxiliar1.Entregado,0)>0)

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar3