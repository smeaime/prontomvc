CREATE PROCEDURE [dbo].[ValesSalida_ActualizarEstado]

@IdValeSalida int

AS

SET NOCOUNT ON

DECLARE @Registros as int
SET @Registros=(Select Count(*) From DetalleValesSalida DetVal
			Where DetVal.IdValeSalida=@IdValeSalida)

DECLARE @RegistrosAnulados as int
SET @RegistrosAnulados=(Select Count(*) From DetalleValesSalida DetVal
			  Where DetVal.IdValeSalida=@IdValeSalida and 
				IsNull(DetVal.Estado,'')='AN')

DECLARE @RegistrosCumplidos as int
SET @RegistrosCumplidos=(Select Count(*) From DetalleValesSalida DetVal
			   Where DetVal.IdValeSalida=@IdValeSalida and 
				IsNull(DetVal.Cumplido,'')='SI')

IF @RegistrosAnulados>=@Registros
	UPDATE ValesSalida
	SET Cumplido='AN'
	WHERE ValesSalida.IdValeSalida=@IdValeSalida
ELSE
	IF @RegistrosCumplidos+@RegistrosAnulados>=@Registros
		UPDATE ValesSalida
		SET Cumplido='SI'
		WHERE ValesSalida.IdValeSalida=@IdValeSalida

CREATE TABLE #Auxiliar (IdDetalleRequerimiento INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar (IdDetalleRequerimiento) ON [PRIMARY]
INSERT INTO #Auxiliar 
 SELECT DetVal.IdDetalleRequerimiento
 FROM DetalleValesSalida DetVal
 WHERE DetVal.IdValeSalida=@IdValeSalida and IsNull(DetVal.Estado,'')='AN' and DetVal.IdDetalleRequerimiento is not null

DECLARE @IdDetalleRequerimiento int
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleRequerimiento FROM #Auxiliar ORDER BY IdDetalleRequerimiento
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleRequerimiento
WHILE @@FETCH_STATUS = 0
   BEGIN
	UPDATE DetalleRequerimientos 
	SET TipoDesignacion='STK'
	WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento
	FETCH NEXT FROM Cur INTO @IdDetalleRequerimiento
   END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar

SET NOCOUNT OFF