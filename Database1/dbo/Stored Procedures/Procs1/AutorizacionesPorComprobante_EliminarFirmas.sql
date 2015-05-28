CREATE Procedure [dbo].[AutorizacionesPorComprobante_EliminarFirmas]

@IdFormulario int,
@IdComprobante int,
@OrdenAutorizacion int = Null, 
@IdUsuarioElimino int = Null

AS 

SET @OrdenAutorizacion=IsNull(@OrdenAutorizacion,-1)
SET @IdUsuarioElimino=IsNull(@IdUsuarioElimino,0)

IF @IdFormulario=4
  BEGIN
	CREATE TABLE #Auxiliar1 
				(
				 IdAutorizacionPorComprobante INTEGER,
				 OrdenAutorizacion INTEGER,
				 IdAutorizo INTEGER,
				 Fecha DATETIME
				)
	CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (OrdenAutorizacion) ON [PRIMARY]
	INSERT INTO #Auxiliar1 
	 SELECT IdAutorizacionPorComprobante, OrdenAutorizacion, IdAutorizo, FechaAutorizacion
	 FROM AutorizacionesPorComprobante 
	 WHERE IdFormulario=@IdFormulario and IdComprobante=@IdComprobante
	
	/*  CURSOR  */
	DECLARE @IdAutorizacionPorComprobante int, @OrdenAutorizacion1 int, @IdAutorizo int, @Fecha datetime, @Firmante varchar(50)
	
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdAutorizacionPorComprobante, OrdenAutorizacion, IdAutorizo, Fecha FROM #Auxiliar1 ORDER BY OrdenAutorizacion
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdAutorizacionPorComprobante, @OrdenAutorizacion1, @IdAutorizo, @Fecha
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		SET @Firmante=IsNull((Select Top 1 Nombre From Empleados Where IdEmpleado=@IdAutorizo),'')

		INSERT INTO [Log](Tipo, IdComprobante, FechaRegistro, AuxNum1, Detalle)
		VALUES ('PED', @IdComprobante, GetDate(), @IdUsuarioElimino, 'Eliminacion de firma '+Convert(varchar,@OrdenAutorizacion1)+' firmante : '+@Firmante)
	
		FETCH NEXT FROM Cur INTO @IdAutorizacionPorComprobante, @OrdenAutorizacion1, @IdAutorizo, @Fecha
	  END
	CLOSE Cur
	DEALLOCATE Cur
	
	UPDATE Pedidos
	SET CircuitoFirmasCompleto=Null
	WHERE IdPedido=@IdComprobante

	DROP TABLE #Auxiliar1
  END

DELETE AutorizacionesPorComprobante
WHERE IdFormulario=@IdFormulario and IdComprobante=@IdComprobante and (@OrdenAutorizacion=-1 or OrdenAutorizacion=@OrdenAutorizacion)