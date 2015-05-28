CREATE PROCEDURE [dbo].[ValesSalida_TX_TodosLosItems]

@IdValeSalida int

AS

SET NOCOUNT ON

DECLARE @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA varchar(2), @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)

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
			Where DetVal.IdValeSalida='+Convert(varchar,@IdValeSalida)+' and a.IdArticulo is not null and IsNull(A.ParaMantenimiento,'+''''+''+''''+')='+''''+'SI'+''''+' and IsNull(A.Activo,'+''''+''+''''+')<>'+''''+'NO'+''''
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
	 WHERE DetVal.IdValeSalida=@IdValeSalida and a.IdArticulo is not null and IsNull(a.Activo,'')<>'NO' and IsNull(a.ParaMantenimiento,'SI')='SI' 
    END

SET NOCOUNT OFF

SELECT
 DetVal.*,
 LMateriales.NumeroLMateriales,
 DetalleLMateriales.NumeroItem as [NumeroItemLMateriales],
 Reservas.NumeroReserva,
 Articulos.Codigo,
 Articulos.Descripcion as [Articulo],
 IsNull(Unidades.Abreviatura,Unidades.Descripcion) as [Unidad],
 Requerimientos.NumeroRequerimiento,
 DetReq.NumeroItem as [ItemRM],
 DetReq.CodigoDistribucion,
 Requerimientos.TipoRequerimiento as [TipoRM],
 Requerimientos.IdOrdenTrabajo,
 #Auxiliar3.NumeroInventario as [CodigoEquipoDestino],
 #Auxiliar3.Descripcion as [EquipoDestino]
FROM DetalleValesSalida DetVal
LEFT OUTER JOIN Articulos ON DetVal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetVal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN DetalleLMateriales ON DetVal.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales = LMateriales.IdLMateriales 
LEFT OUTER JOIN DetalleReservas ON DetVal.IdDetalleReserva = DetalleReservas.IdDetalleReserva
LEFT OUTER JOIN Reservas ON DetalleReservas.IdReserva= Reservas.IdReserva
LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento = DetVal.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetReq.IdRequerimiento
LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdArticulo = IsNull(DetVal.IdEquipoDestino,IsNull(DetReq.IdEquipoDestino,Requerimientos.IdEquipoDestino))
WHERE (DetVal.IdValeSalida = @IdValeSalida)

DROP TABLE #Auxiliar3