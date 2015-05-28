
CREATE PROCEDURE [dbo].[Recepciones_ActualizarEstadoPedidos]

@IdRecepcion int

AS

DECLARE @Anulada varchar(2)
SET @Anulada=IsNull((Select Top 1 Anulada From Recepciones Where IdRecepcion=@IdRecepcion),'NO')

CREATE TABLE #Auxiliar1 (IdDetallePedido INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetallePedido) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT DetRec.IdDetallePedido
 FROM DetalleRecepciones DetRec
 WHERE DetRec.IdRecepcion = @IdRecepcion and DetRec.IdDetallePedido is not null
 GROUP BY DetRec.IdDetallePedido

/*  CURSOR  */
DECLARE @IdDetallePedido int
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetallePedido FROM #Auxiliar1 ORDER BY IdDetallePedido
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetallePedido
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE DetallePedidos
	SET CantidadRecibida=IsNull((Select Sum(IsNull(DetRec.Cantidad,0))
					From DetalleRecepciones DetRec
					Left Outer Join Recepciones On DetRec.IdRecepcion=Recepciones.IdRecepcion
					Where DetRec.IdDetallePedido=@IdDetallePedido and IsNull(Recepciones.Anulada,'NO')<>'SI' and DetRec.IdDetalleSalidaMateriales is null),0)
	WHERE IdDetallePedido=@IdDetallePedido and IsNull(Cumplido,'NO')<>'AN'  

	UPDATE DetallePedidos
	SET Cumplido = 'SI'
	WHERE IdDetallePedido=@IdDetallePedido and IsNull(Cumplido,'NO')<>'AN' and 
		(Cantidad<=CantidadRecibida or IdDioPorCumplido is not null)

	UPDATE DetallePedidos
	SET Cumplido = 'PA'
	WHERE IdDetallePedido=@IdDetallePedido and IsNull(Cumplido,'NO')<>'AN' and 
		Cantidad>CantidadRecibida and CantidadRecibida<>0 and IdDioPorCumplido is null

	UPDATE DetallePedidos
	SET Cumplido = Null
	WHERE IdDetallePedido=@IdDetallePedido and IsNull(Cumplido,'NO')<>'AN' and 
		Cantidad>CantidadRecibida and CantidadRecibida=0 and IdDioPorCumplido is null

	FETCH NEXT FROM Cur INTO @IdDetallePedido
END
CLOSE Cur
DEALLOCATE Cur


CREATE TABLE #Auxiliar2 (IdPedido INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdPedido) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT DetPed.IdPedido
 FROM DetalleRecepciones DetRec
 LEFT OUTER JOIN DetallePedidos DetPed ON DetRec.IdDetallePedido = DetPed.IdDetallePedido
 WHERE DetRec.IdRecepcion = @IdRecepcion and DetRec.IdDetallePedido is not null
 GROUP BY DetPed.IdPedido

/*  CURSOR  */
DECLARE @IdPedido int
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdPedido FROM #Auxiliar2 ORDER BY IdPedido
OPEN Cur
FETCH NEXT FROM Cur INTO @IdPedido
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE Pedidos
	SET Cumplido=Null
	WHERE Pedidos.IdPedido=@IdPedido and IsNull(Cumplido,'NO')<>'AN' 

	UPDATE Pedidos
	SET Cumplido='SI'
	WHERE Pedidos.IdPedido=@IdPedido and IsNull(Cumplido,'NO')<>'AN' and 
		not exists(Select Top 1 DetPed.IdPedido
				From DetallePedidos DetPed
				Where DetPed.IdPedido=@IdPedido and (IsNull(DetPed.Cumplido,'NO')='NO' or IsNull(DetPed.Cumplido,'NO')='PA'))
	FETCH NEXT FROM Cur INTO @IdPedido
END
CLOSE Cur
DEALLOCATE Cur

CREATE TABLE #Auxiliar3 (IdDetalleRequerimiento INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdDetalleRequerimiento) ON [PRIMARY]
INSERT INTO #Auxiliar3 
 SELECT DetRec.IdDetalleRequerimiento
 FROM DetalleRecepciones DetRec
 WHERE DetRec.IdRecepcion = @IdRecepcion and DetRec.IdDetalleRequerimiento is not null
 GROUP BY DetRec.IdDetalleRequerimiento

/*  CURSOR  */
DECLARE @IdDetalleRequerimiento int, @CantidadRecibida numeric(18,2)
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleRequerimiento FROM #Auxiliar3 ORDER BY IdDetalleRequerimiento
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleRequerimiento
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @CantidadRecibida=IsNull((Select Sum(IsNull(DetRec.Cantidad,0))
					From DetalleRecepciones DetRec
					Left Outer Join Recepciones On DetRec.IdRecepcion=Recepciones.IdRecepcion
					Where DetRec.IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Recepciones.Anulada,'NO')<>'SI' and DetRec.IdDetalleSalidaMateriales is null),0)

	UPDATE DetalleRequerimientos
	SET Recepcionado = 'SI'
	WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Cumplido,'NO')<>'AN' and Cantidad<=@CantidadRecibida

	UPDATE DetalleRequerimientos
	SET Recepcionado = 'PA'
	WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Cumplido,'NO')<>'AN' and Cantidad>@CantidadRecibida and @CantidadRecibida<>0

	UPDATE DetalleRequerimientos
	SET Recepcionado = Null
	WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Cumplido,'NO')<>'AN' and Cantidad>@CantidadRecibida and @CantidadRecibida=0

	IF @Anulada='SI' and IsNull((Select Top 1 P.ActivarSolicitudMateriales From Parametros P Where P.IdParametro=1),'NO')='SI'
		UPDATE DetalleRequerimientos
		SET TipoDesignacion='CMP'
		WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento and TipoDesignacion='REC'

	FETCH NEXT FROM Cur INTO @IdDetalleRequerimiento
END
CLOSE Cur
DEALLOCATE Cur

CREATE TABLE #Auxiliar4 (IdRequerimiento INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (IdRequerimiento) ON [PRIMARY]
INSERT INTO #Auxiliar4 
 SELECT DetReq.IdRequerimiento
 FROM DetalleRecepciones DetRec
 LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetRec.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
 WHERE DetRec.IdRecepcion = @IdRecepcion and DetRec.IdDetalleRequerimiento is not null
 GROUP BY DetReq.IdRequerimiento

/*  CURSOR  */
DECLARE @IdRequerimiento int
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdRequerimiento FROM #Auxiliar4 ORDER BY IdRequerimiento
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRequerimiento
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE Requerimientos
	SET Recepcionado=Null
	WHERE IdRequerimiento=@IdRequerimiento and IsNull(Cumplido,'NO')<>'AN' 

	UPDATE Requerimientos
	SET Recepcionado='SI'
	WHERE IdRequerimiento=@IdRequerimiento and IsNull(Cumplido,'NO')<>'AN' and 
		not exists(Select Top 1 DetReq.IdRequerimiento
				From DetalleRequerimientos DetReq
				Where DetReq.IdRequerimiento=@IdRequerimiento and (IsNull(DetReq.Recepcionado,'NO')='NO' or IsNull(DetReq.Recepcionado,'NO')='PA'))

	UPDATE Requerimientos
	SET Recepcionado='PA'
	WHERE IdRequerimiento=@IdRequerimiento and IsNull(Cumplido,'NO')<>'AN' and 
		Recepcionado is null and 
		exists(Select Top 1 DetReq.IdRequerimiento
			From DetalleRequerimientos DetReq
			Where DetReq.IdRequerimiento=@IdRequerimiento and IsNull(DetReq.Recepcionado,'NO')<>'NO')
	FETCH NEXT FROM Cur INTO @IdRequerimiento
END
CLOSE Cur
DEALLOCATE Cur

--Proceso las recepciones de items de RM que no tienen pedido, si recepcione la cantidad requerida pongo la RM como cumplida
CREATE TABLE #Auxiliar5 (IdDetalleRequerimiento INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar5 ON #Auxiliar5 (IdDetalleRequerimiento) ON [PRIMARY]
INSERT INTO #Auxiliar5 
 SELECT DetRec.IdDetalleRequerimiento
 FROM DetalleRecepciones DetRec
 WHERE DetRec.IdRecepcion = @IdRecepcion and DetRec.IdDetalleRequerimiento is not null and DetRec.IdDetallePedido is null
 GROUP BY DetRec.IdDetalleRequerimiento

/*  CURSOR  */
DECLARE @CantidadPedida numeric(18,2)
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleRequerimiento FROM #Auxiliar5 ORDER BY IdDetalleRequerimiento
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleRequerimiento
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @CantidadRecibida=IsNull((Select Sum(IsNull(DetRec.Cantidad,0))
					From DetalleRecepciones DetRec
					Left Outer Join Recepciones On DetRec.IdRecepcion=Recepciones.IdRecepcion
					Where DetRec.IdDetalleRequerimiento=@IdDetalleRequerimiento and DetRec.IdDetallePedido is null and IsNull(Recepciones.Anulada,'NO')<>'SI' and DetRec.IdDetalleSalidaMateriales is null),0)
	SET @CantidadPedida=IsNull((Select Sum(IsNull(DetPed.Cantidad,0))
					From DetallePedidos DetPed
					Left Outer Join Pedidos On DetPed.IdPedido=Pedidos.IdPedido
					Where IsNull(DetPed.IdDetalleRequerimiento,0)=@IdDetalleRequerimiento and IsNull(DetPed.Cumplido,'NO')<>'AN' and IsNull(Pedidos.Cumplido,'NO')<>'AN'),0)
	SET @IdRequerimiento=IsNull((Select Top 1 DetReq.IdRequerimiento From DetalleRequerimientos DetReq Where DetReq.IdDetalleRequerimiento=@IdDetalleRequerimiento),0)

	UPDATE DetalleRequerimientos
	SET Cumplido=Null
	WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Cumplido,'NO')<>'AN'

	UPDATE DetalleRequerimientos
	SET Cumplido='SI'
	WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Cumplido,'NO')<>'AN' and Cantidad<=(@CantidadRecibida+@CantidadPedida)

	UPDATE DetalleRequerimientos
	SET Cumplido='PA'
	WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Cumplido,'NO')<>'AN' and Cantidad>(@CantidadRecibida+@CantidadPedida) and (@CantidadRecibida+@CantidadPedida)>0 

	UPDATE Requerimientos
	SET Cumplido=Null
	WHERE IdRequerimiento=@IdRequerimiento and IsNull(Cumplido,'NO')<>'AN'
	
	UPDATE Requerimientos
	SET Cumplido='SI'
	WHERE IdRequerimiento=@IdRequerimiento and IsNull(Cumplido,'NO')<>'AN' and 
		not exists(Select Top 1 DetReq.IdRequerimiento From DetalleRequerimientos DetReq
				Where DetReq.IdRequerimiento=@IdRequerimiento and (IsNull(DetReq.Cumplido,'NO')='NO' or IsNull(DetReq.Cumplido,'NO')='PA'))

	FETCH NEXT FROM Cur INTO @IdDetalleRequerimiento
END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5
