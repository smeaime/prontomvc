CREATE Procedure [dbo].[Pedidos_ActualizarEstadoPorIdPedido]

@IdPedido int

AS

CREATE TABLE #Auxiliar1	
			(
			 IdDetallePedido INTEGER,
			 IdDetalleAcopios INTEGER,
			 IdDetalleRequerimiento INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetallePedido) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT 
  DetPed.IdDetallePedido,
  IsNull(DetPed.IdDetalleAcopios,0),
  IsNull(DetPed.IdDetalleRequerimiento,0)
 FROM DetallePedidos DetPed
 WHERE DetPed.IdPedido = @IdPedido

DECLARE @Cantidad numeric(18,2), @IdRequerimiento int, @IdDetallePedido int, @IdDetalleAcopios int, @IdDetalleRequerimiento int

/*  CURSOR  */
DECLARE DetPed CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetallePedido,IdDetalleAcopios,IdDetalleRequerimiento FROM #Auxiliar1
OPEN DetPed
FETCH NEXT FROM DetPed INTO @IdDetallePedido,@IdDetalleAcopios,@IdDetalleRequerimiento
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE DetallePedidos
	SET CantidadRecibida=IsNull((Select Sum(IsNull(DetRec.Cantidad,0))
					From DetalleRecepciones DetRec
					Left Outer Join Recepciones On DetRec.IdRecepcion=Recepciones.IdRecepcion
					Where DetRec.IdDetallePedido=@IdDetallePedido and IsNull(Recepciones.Anulada,'NO')<>'SI'),0)
	WHERE IdDetallePedido=@IdDetallePedido and IsNull(Cumplido,'NO')<>'AN'  

	IF @IdDetalleRequerimiento<>0
	   BEGIN
		SET @Cantidad=IsNull((Select Sum(IsNull(DetPed.Cantidad,0))
					From DetallePedidos DetPed
					Left Outer Join Pedidos On DetPed.IdPedido=Pedidos.IdPedido
					Where IsNull(DetPed.IdDetalleRequerimiento,0)=@IdDetalleRequerimiento and 
						IsNull(DetPed.Cumplido,'NO')<>'AN' and IsNull(Pedidos.Cumplido,'NO')<>'AN'),0)

		SET @IdRequerimiento=IsNull((Select Top 1 DetReq.IdRequerimiento
						From DetalleRequerimientos DetReq
						Where DetReq.IdDetalleRequerimiento=@IdDetalleRequerimiento),0)
		
		UPDATE DetalleRequerimientos
		SET Cumplido=Null
		WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Cumplido,'NO')<>'AN'

		UPDATE DetalleRequerimientos
		SET Cumplido='SI'
		WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Cumplido,'NO')<>'AN' and Cantidad<=@Cantidad

		UPDATE DetalleRequerimientos
		SET Cumplido='PA'
		WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Cumplido,'NO')<>'AN' and Cantidad>@Cantidad and @Cantidad>0 

		UPDATE Requerimientos
		SET Cumplido=Null
		WHERE IdRequerimiento=@IdRequerimiento and IsNull(Cumplido,'NO')<>'AN'
		
		UPDATE Requerimientos
		SET Cumplido='SI'
		WHERE IdRequerimiento=@IdRequerimiento and IsNull(Cumplido,'NO')<>'AN' and 
			not exists(Select Top 1 DetReq.IdRequerimiento From DetalleRequerimientos DetReq
					Where DetReq.IdRequerimiento=@IdRequerimiento and (IsNull(DetReq.Cumplido,'NO')='NO' or IsNull(DetReq.Cumplido,'NO')='PA'))
	   END

	UPDATE DetallePedidos
	SET Cumplido = 'SI'
	WHERE IdDetallePedido=@IdDetallePedido and IsNull(Cumplido,'NO')<>'AN' and (Cantidad<=CantidadRecibida or IdDioPorCumplido is not null)

	UPDATE DetallePedidos
	SET Cumplido = 'PA'
	WHERE IdDetallePedido=@IdDetallePedido and IsNull(Cumplido,'NO')<>'AN' and 
		Cantidad>CantidadRecibida and CantidadRecibida<>0 and IdDioPorCumplido is null

	UPDATE DetallePedidos
	SET Cumplido = Null
	WHERE IdDetallePedido=@IdDetallePedido and IsNull(Cumplido,'NO')<>'AN' and 
		Cantidad>CantidadRecibida and CantidadRecibida=0 and IdDioPorCumplido is null

	FETCH NEXT FROM DetPed INTO @IdDetallePedido,@IdDetalleAcopios,@IdDetalleRequerimiento
END
CLOSE DetPed
DEALLOCATE DetPed

UPDATE Pedidos
SET Cumplido=Null
WHERE IdPedido=@IdPedido and IsNull(Cumplido,'NO')<>'AN'

UPDATE Pedidos
SET Cumplido='SI'
WHERE IdPedido=@IdPedido and IsNull(Cumplido,'NO')<>'AN' and 
	not exists(Select Top 1 DetPed.IdPedido From DetallePedidos DetPed
			Where DetPed.IdPedido=@IdPedido and (IsNull(DetPed.Cumplido,'NO')='NO' or IsNull(DetPed.Cumplido,'NO')='PA'))

DROP TABLE #Auxiliar1