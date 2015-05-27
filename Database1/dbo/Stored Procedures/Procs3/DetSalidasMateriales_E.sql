
CREATE Procedure [dbo].[DetSalidasMateriales_E]

@IdDetalleSalidaMateriales int  

AS 

DECLARE @IdEquipoDestino int
SET @IdEquipoDestino=IsNull((Select Top 1 IdEquipoDestino
				From DetalleSalidasMateriales 
				Where DetalleSalidasMateriales.IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales),0)

DECLARE @BasePRONTOMANT varchar(50), @sql1 nvarchar(1000)
SET @BasePRONTOMANT=IsNull((Select Top 1 P.BasePRONTOMantenimiento 
				From Parametros P Where P.IdParametro=1),'')
IF @IdEquipoDestino<>0 and DB_ID(@BasePRONTOMANT) is not null
   BEGIN
	SET NOCOUNT ON
	CREATE TABLE #Auxiliar3 (IdAux INTEGER)
	SET @sql1='Delete '+@BasePRONTOMANT+'.dbo.DetalleConsumos 
			Where IsNull(IdDetalleSalidaMaterialesPRONTO,-1)='+
			Convert(varchar,@IdDetalleSalidaMateriales)+' and 
			BDOrigenSalidaPRONTO='+''''+DB_NAME()+''''
	EXEC sp_executesql @sql1

	DELETE ProntoMantenimiento.dbo.DetalleOrdenesTrabajoConsumos
	WHERE IsNull(IdDetalleSalidaMaterialesPRONTO,-1)=@IdDetalleSalidaMateriales

	DROP TABLE #Auxiliar3
	SET NOCOUNT OFF
   END

DELETE [DetalleSalidasMaterialesPresupuestosObras]
WHERE (IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales)

DELETE [DetalleSalidasMaterialesKits]
WHERE (IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales)

DELETE [DetalleSalidasMateriales]
WHERE (IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales)
