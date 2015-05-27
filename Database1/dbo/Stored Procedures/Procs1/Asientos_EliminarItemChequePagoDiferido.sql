CREATE PROCEDURE [dbo].[Asientos_EliminarItemChequePagoDiferido]

@Señal varchar(1),
@IdDetalleAsiento int = Null,
@IdValor int = Null

AS

SET @IdDetalleAsiento=IsNull(@IdDetalleAsiento,0)
SET @IdValor=IsNull(@IdValor,0)

IF @Señal='0'
  BEGIN
	IF @IdDetalleAsiento<>0 
		UPDATE DetalleAsientos
		SET Debe=Null, Haber=Null
		WHERE DetalleAsientos.IdDetalleAsiento=@IdDetalleAsiento
	IF @IdValor<>0 
		UPDATE DetalleAsientos
		SET Debe=Null, Haber=Null
		WHERE DetalleAsientos.IdValor=@IdValor
  END
ELSE
  BEGIN
	IF @IdDetalleAsiento<>0 
	  BEGIN
		UPDATE Valores
		SET RegistroContableChequeDiferido=Null
		WHERE Valores.IdValor=(Select Top 1 Det.IdValor
					From DetalleAsientos Det 
					Where Det.IdDetalleAsiento=@IdDetalleAsiento)
		DELETE DetalleAsientos
		WHERE DetalleAsientos.IdDetalleAsiento=@IdDetalleAsiento
	  END
	IF @IdValor<>0 
	  BEGIN
		UPDATE Valores
		SET RegistroContableChequeDiferido=Null
		WHERE Valores.IdValor=@IdValor
		DELETE DetalleAsientos
		WHERE DetalleAsientos.IdValor=@IdValor
	  END
  END
