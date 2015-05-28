CREATE Procedure [dbo].[Pedidos_RecalcularTotales]

@IdPedido int

AS 

SET NOCOUNT ON

DECLARE @IdDetallePedido int, @Cantidad numeric(18,2), @Precio numeric(18,4), @PorcentajeBonificacion numeric(6,2), @ImporteBonificacion numeric(18,4), @PorcentajeIVA numeric(6,2), 
	@ImporteIVA numeric(18,4), @ImporteTotalItem numeric(18,4), @SubTotal numeric(18,2), @Bonificacion numeric(18,2), @TotalIva1 numeric(18,4), @TotalPedido numeric(18,2), 
	@ImpuestosInternos numeric(18,2), @ImpuestosInternos1 numeric(18,2), @ImporteTotalItem1 numeric(18,4), @ImporteTotalItem2 numeric(18,4), @BonificacionDistribuida numeric(18,4), 
	@BonificacionPorItem numeric(18,4), @ImporteIVAItem numeric(18,4), @PorcentajeBonificacion1 numeric(6,2), 
	@OtrosConceptos1 numeric(18,2), @OtrosConceptos2 numeric(18,2), @OtrosConceptos3 numeric(18,2), @OtrosConceptos4 numeric(18,2), @OtrosConceptos5 numeric(18,2)

SET @SubTotal=IsNull((Select Sum(Round(IsNull(dp.Precio,0)*IsNull(dp.Cantidad,0),2)) From DetallePedidos dp Where dp.IdPedido=@IdPedido and IsNull(dp.Cumplido,'NO')<>'AN'),0)
SET @Bonificacion=IsNull((Select Bonificacion From Pedidos Where IdPedido=@IdPedido),0)
SET @PorcentajeBonificacion1=IsNull((Select PorcentajeBonificacion From Pedidos Where IdPedido=@IdPedido),0)
SET @OtrosConceptos1=IsNull((Select OtrosConceptos1 From Pedidos Where IdPedido=@IdPedido),0)
SET @OtrosConceptos2=IsNull((Select OtrosConceptos2 From Pedidos Where IdPedido=@IdPedido),0)
SET @OtrosConceptos3=IsNull((Select OtrosConceptos3 From Pedidos Where IdPedido=@IdPedido),0)
SET @OtrosConceptos4=IsNull((Select OtrosConceptos4 From Pedidos Where IdPedido=@IdPedido),0)
SET @OtrosConceptos5=IsNull((Select OtrosConceptos5 From Pedidos Where IdPedido=@IdPedido),0)

CREATE TABLE #Auxiliar 	(
			 IdDetallePedido INTEGER,
			 Cantidad NUMERIC(18,2),
			 Precio NUMERIC(18,4),
			 PorcentajeBonificacion NUMERIC(6,2),
			 ImporteBonificacion NUMERIC(18,4),
			 PorcentajeIVA NUMERIC(6,2),
			 ImporteIVA NUMERIC(18,4),
			 ImpuestosInternos NUMERIC(18,2),
			 ImporteTotalItem NUMERIC(18,4)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar ON #Auxiliar (IdDetallePedido) ON [PRIMARY]
INSERT INTO #Auxiliar
 SELECT IdDetallePedido, IsNull(Cantidad,0), IsNull(Precio,0), IsNull(PorcentajeBonificacion,0), IsNull(ImporteBonificacion,0), IsNull(PorcentajeIVA,0), IsNull(ImporteIVA,0), IsNull(ImpuestosInternos,0), IsNull(ImporteTotalItem,0)
 FROM DetallePedidos dp 
 WHERE dp.IdPedido=@IdPedido and IsNull(dp.Cumplido,'NO')<>'AN'

SET @BonificacionPorItem=0
SET @ImpuestosInternos1=0
SET @TotalIva1=0

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR 
	SELECT IdDetallePedido, Cantidad, Precio, PorcentajeBonificacion, ImporteBonificacion, PorcentajeIVA, ImporteIVA, ImpuestosInternos, ImporteTotalItem FROM #Auxiliar ORDER BY IdDetallePedido
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetallePedido, @Cantidad, @Precio, @PorcentajeBonificacion, @ImporteBonificacion, @PorcentajeIVA, @ImporteIVA, @ImpuestosInternos, @ImporteTotalItem
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @ImporteTotalItem1=@Cantidad*@Precio
	SET @BonificacionDistribuida=0
	SET @ImporteIVAItem=0

	SET @ImporteBonificacion=@ImporteTotalItem1*@PorcentajeBonificacion/100
	IF @SubTotal<>0
	   BEGIN
		SET @BonificacionDistribuida=@Bonificacion*(@ImporteTotalItem1/@SubTotal)
	   END
	SET @BonificacionPorItem=@BonificacionPorItem+@ImporteBonificacion
	SET @ImporteIVAItem=(@ImporteTotalItem1-@ImporteBonificacion-@BonificacionDistribuida)*@PorcentajeIVA/100

	SET @ImporteTotalItem2=@ImporteTotalItem1-@ImporteBonificacion-@BonificacionDistribuida+@ImporteIVAItem
	SET @ImpuestosInternos1=@ImpuestosInternos1+@ImpuestosInternos
	SET @TotalIva1=@TotalIva1+@ImporteIVAItem

	UPDATE DetallePedidos
	SET ImporteBonificacion=@ImporteBonificacion, ImporteIVA=@ImporteIVAItem, ImporteTotalItem=@ImporteTotalItem2
	WHERE IdDetallePedido=@IdDetallePedido

	FETCH NEXT FROM Cur INTO @IdDetallePedido, @Cantidad, @Precio, @PorcentajeBonificacion, @ImporteBonificacion, @PorcentajeIVA, @ImporteIVA, @ImpuestosInternos, @ImporteTotalItem
   END
CLOSE Cur
DEALLOCATE Cur

SET @TotalIva1=ROund(@TotalIva1,2)
IF @PorcentajeBonificacion1<>0
	SET @Bonificacion=Round((@SubTotal-@BonificacionPorItem)*@PorcentajeBonificacion1/100,2)

SET @TotalPedido=@SubTotal-@Bonificacion-@BonificacionPorItem+@TotalIva1+@ImpuestosInternos1+@OtrosConceptos1+@OtrosConceptos2+@OtrosConceptos3+@OtrosConceptos4+@OtrosConceptos5

UPDATE Pedidos
SET ImpuestosInternos=@ImpuestosInternos1, Bonificacion=@Bonificacion, TotalIva1=@TotalIva1, TotalPedido=@TotalPedido
WHERE IdPedido=@IdPedido

DROP TABLE #Auxiliar

SET NOCOUNT OFF