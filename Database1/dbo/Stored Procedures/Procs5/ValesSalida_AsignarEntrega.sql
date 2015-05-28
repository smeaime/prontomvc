CREATE PROCEDURE [dbo].[ValesSalida_AsignarEntrega]

@IdDetalleValeSalida int

AS

SET NOCOUNT ON

DECLARE @IdValeSalida int
SET @IdValeSalida=(Select DetVal.IdValeSalida From DetalleValesSalida DetVal
			Where DetVal.IdDetalleValeSalida=@IdDetalleValeSalida)

DECLARE @Cantidad Numeric(18,2)
SET @Cantidad=IsNull((Select DetVal.Cantidad 
			From DetalleValesSalida DetVal
			Where DetVal.IdDetalleValeSalida=@IdDetalleValeSalida),0)

DECLARE @Entregado Numeric(18,2)
SET @Entregado=IsNull((Select Sum(DetSal.Cantidad) 
			From DetalleSalidasMateriales DetSal
			Left Outer Join SalidasMateriales On DetSal.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
			Where IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
				DetSal.IdDetalleValeSalida is not null and 
				DetSal.IdDetalleValeSalida=@IdDetalleValeSalida),0)

IF @Entregado>=@Cantidad
    BEGIN
	UPDATE DetalleValesSalida
	SET Cumplido='SI'
	WHERE DetalleValesSalida.IdDetalleValeSalida=@IdDetalleValeSalida
	IF Not Exists(Select Top 1 DetVal.IdValeSalida
			From DetalleValesSalida DetVal
			Where DetVal.IdValeSalida=@IdValeSalida and 
				IsNull(Cumplido,'NO')='NO' or IsNull(Cumplido,'NO')='PA')
		UPDATE ValesSalida
		SET Cumplido='SI'
		WHERE IdValeSalida=@IdValeSalida
    END

IF @Entregado<>0 and @Entregado<@Cantidad
    BEGIN
	UPDATE DetalleValesSalida
	SET Cumplido='PA'
	WHERE DetalleValesSalida.IdDetalleValeSalida=@IdDetalleValeSalida

	UPDATE ValesSalida
	SET Cumplido=Null
	WHERE IdValeSalida=@IdValeSalida
    END

EXEC ValesSalida_ActualizarEstado @IdValeSalida

SET NOCOUNT OFF