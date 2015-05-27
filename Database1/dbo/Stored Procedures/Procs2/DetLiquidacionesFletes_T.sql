
CREATE Procedure [dbo].[DetLiquidacionesFletes_T]

@IdDetalleLiquidacionFlete int

AS 

SELECT *
FROM [DetalleLiquidacionesFletes]
WHERE (IdDetalleLiquidacionFlete=@IdDetalleLiquidacionFlete)
