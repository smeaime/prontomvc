CREATE PROCEDURE [dbo].[ValesSalida_DarPorCumplido]

@IdValeSalida int,
@IdUsuarioDioPorCumplido int,
@MotivoDioPorCumplido ntext

AS

SET NOCOUNT ON

UPDATE ValesSalida
SET Cumplido='SI', IdUsuarioDioPorCumplido=@IdUsuarioDioPorCumplido, FechaDioPorCumplido=GetDate(), MotivoDioPorCumplido=@MotivoDioPorCumplido
WHERE IdValeSalida=@IdValeSalida

UPDATE DetalleValesSalida
SET Cumplido='SI'
WHERE IdValeSalida=@IdValeSalida

SET NOCOUNT OFF
