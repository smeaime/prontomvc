


CREATE Procedure [dbo].[Valores_ActualizarComprobantes]

@IdOrigenTransmision int

AS

CREATE TABLE #Auxiliar 	(
			 IdValor INTEGER,
			 IdValorOriginal INTEGER,
			 CuitClienteTransmision VARCHAR(13),
			 IdDetalleReciboValoresOriginal INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar ON #Auxiliar (IdValor) ON [PRIMARY]
INSERT INTO #Auxiliar 
 SELECT IdValor, IdValorOriginal, CuitClienteTransmision, IdDetalleReciboValoresOriginal
 FROM Valores 
 WHERE IdOrigenTransmision=@IdOrigenTransmision and 
	(IsNull(IdCliente,0)=0 or IsNull(IdDetalleReciboValores,0)=0)

/*  CURSOR  */
DECLARE @IdValor int, @IdValorOriginal int, @CuitClienteTransmision varchar(13), 
	@IdDetalleReciboValoresOriginal int
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdValor, IdValorOriginal, CuitClienteTransmision, IdDetalleReciboValoresOriginal
		FROM #Auxiliar
		ORDER BY IdValor
OPEN Cur
FETCH NEXT FROM Cur INTO @IdValor, @IdValorOriginal, @CuitClienteTransmision, 
			 @IdDetalleReciboValoresOriginal
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF Len(IsNull(@CuitClienteTransmision,''))>0
		UPDATE Valores
		SET IdCliente=IsNull((Select Top 1 Clientes.IdCliente From Clientes 
					Where Clientes.Cuit=@CuitClienteTransmision),0)
		WHERE IdValor=@IdValor and IsNull(IdCliente,0)=0

	UPDATE Valores
	SET IdDetalleReciboValores=(Select Top 1 drv.IdDetalleReciboValores From DetalleRecibosValores drv 
					Where drv.IdDetalleReciboValoresOriginal=@IdDetalleReciboValoresOriginal and 
						drv.IdOrigenTransmision=@IdOrigenTransmision)
	WHERE IdValor=@IdValor and IsNull(IdDetalleReciboValores,0)=0
	
	FETCH NEXT FROM Cur INTO @IdValor, @IdValorOriginal, @CuitClienteTransmision, 
				 @IdDetalleReciboValoresOriginal
   END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar


