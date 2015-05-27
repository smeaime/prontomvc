CREATE Procedure [dbo].[DetSalidasMateriales_AnularConsumos]

@IdDetalleSalidaMateriales int

AS

DECLARE @IdEquipoDestino int, @BasePRONTOMANT varchar(50), @sql1 nvarchar(1000)

SET @IdEquipoDestino=(Select Top 1 IdEquipoDestino From DetalleSalidasMateriales Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales)
SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')

IF @IdEquipoDestino is Not null and DB_ID(@BasePRONTOMANT) is not null
    BEGIN
	CREATE TABLE #Auxiliar3 (IdAux INTEGER)
	SET @sql1='Delete '+@BasePRONTOMANT+'.dbo.DetalleConsumos 
			Where IsNull(IdDetalleSalidaMaterialesPRONTO,-1)='+
			Convert(varchar,@IdDetalleSalidaMateriales)+' and 
			BDOrigenSalidaPRONTO='+''''+DB_NAME()+''''
	EXEC sp_executesql @sql1
	DROP TABLE #Auxiliar3
    END