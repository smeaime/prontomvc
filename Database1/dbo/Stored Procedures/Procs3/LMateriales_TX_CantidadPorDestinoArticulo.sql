CREATE  Procedure [dbo].[LMateriales_TX_CantidadPorDestinoArticulo]

@IdEquipoDestino int,
@IdArticulo int,
@IdDetalleSalidaMateriales int = Null

AS 

SET @IdDetalleSalidaMateriales=IsNull(@IdDetalleSalidaMateriales,0)

DECLARE @IdObra int, @Destino varchar(13), @CantidadLM numeric(18,2), @CantidadSM numeric(18,2), @IdFamilia int, @Familia varchar(50)

/*
SET @IdObra=IsNull((Select Top 1 IdObra From DetalleObrasDestinos Where IdDetalleObraDestino=@IdDetalleObraDestino),0)
SET @Destino=IsNull((Select Top 1 Destino From DetalleObrasDestinos Where IdDetalleObraDestino=@IdDetalleObraDestino),'')
*/
SET @IdObra=IsNull((Select Top 1 IdObra From LMateriales Where IsNull(IdUnidadFuncional,0)=@IdEquipoDestino),0)
SET @Destino=IsNull((Select Top 1 NumeroObra From Obras Where IdObra=@IdObra),'')
SET @IdFamilia=IsNull((Select Top 1 IdRelacion From Articulos Where IdArticulo=@IdArticulo),0)
SET @Familia=IsNull((Select Top 1 Descripcion From Relaciones Where IdRelacion=@IdFamilia),'')

IF @IdFamilia<>0
    BEGIN
	SET @CantidadLM=IsNull((Select Sum(IsNull(DetLMat.Cantidad,0)) From DetalleLMateriales DetLMat
							Left Outer Join Articulos On Articulos.IdArticulo=DetLMat.IdArticulo
							Left Outer Join LMateriales On LMateriales.IdLMateriales=DetLMat.IdLMateriales
							Where IsNull(LMateriales.IdUnidadFuncional,0)=@IdEquipoDestino and IsNull(Articulos.IdRelacion,0)=@IdFamilia),0)
	SET @CantidadSM=IsNull((Select Sum(IsNull(DetSM.Cantidad,0)) From DetalleSalidasMateriales DetSM
							Left Outer Join SalidasMateriales On SalidasMateriales.IdSalidaMateriales=DetSM.IdSalidaMateriales
							Left Outer Join Articulos On Articulos.IdArticulo=DetSM.IdArticulo
							Where IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
								IsNull(DetSM.IdEquipoDestino,0)=@IdEquipoDestino and IsNull(Articulos.IdRelacion,0)=@IdFamilia and 
								DetSM.IdDetalleSalidaMateriales<>@IdDetalleSalidaMateriales and SalidasMateriales.TipoSalida=1),0) - 
					IsNull((Select Sum(IsNull(DetOI.Cantidad,0)) From DetalleOtrosIngresosAlmacen DetOI
							Left Outer Join OtrosIngresosAlmacen On OtrosIngresosAlmacen.IdOtroIngresoAlmacen=DetOI.IdOtroIngresoAlmacen
							Left Outer Join Articulos On Articulos.IdArticulo=DetOI.IdArticulo
							Where IsNull(OtrosIngresosAlmacen.Anulado,'NO')<>'SI' and 
								IsNull(DetOI.IdEquipoDestino,0)=@IdEquipoDestino and IsNull(Articulos.IdRelacion,0)=@IdFamilia and OtrosIngresosAlmacen.TipoIngreso=3),0)
    END
ELSE
    BEGIN
	SET @CantidadLM=IsNull((Select Sum(IsNull(DetLMat.Cantidad,0)) From DetalleLMateriales DetLMat
							Left Outer Join LMateriales On LMateriales.IdLMateriales=DetLMat.IdLMateriales
							Where IsNull(LMateriales.IdUnidadFuncional,0)=@IdEquipoDestino and DetLMat.IdArticulo=@IdArticulo),0)
	SET @CantidadSM=IsNull((Select Sum(IsNull(DetSM.Cantidad,0)) From DetalleSalidasMateriales DetSM
							Left Outer Join SalidasMateriales On SalidasMateriales.IdSalidaMateriales=DetSM.IdSalidaMateriales
							Where IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
								IsNull(DetSM.IdEquipoDestino,0)=@IdEquipoDestino and DetSM.IdArticulo=@IdArticulo and 
								DetSM.IdDetalleSalidaMateriales<>@IdDetalleSalidaMateriales and SalidasMateriales.TipoSalida=1),0) - 
					IsNull((Select Sum(IsNull(DetOI.Cantidad,0)) From DetalleOtrosIngresosAlmacen DetOI
							Left Outer Join OtrosIngresosAlmacen On OtrosIngresosAlmacen.IdOtroIngresoAlmacen=DetOI.IdOtroIngresoAlmacen
							Where IsNull(OtrosIngresosAlmacen.Anulado,'NO')<>'SI' and 
								IsNull(DetOI.IdEquipoDestino,0)=@IdEquipoDestino and DetOI.IdArticulo=@IdArticulo and OtrosIngresosAlmacen.TipoIngreso=3),0)
    END

SELECT @IdObra as [IdObra], @Destino as [Destino], @CantidadLM as [CantidadLM], @CantidadSM as [CantidadSM], @Familia as [Familia]