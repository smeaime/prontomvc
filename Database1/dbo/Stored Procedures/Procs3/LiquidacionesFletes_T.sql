

CREATE Procedure [dbo].[LiquidacionesFletes_T]

@IdLiquidacionFlete int

AS 

SELECT * 
FROM LiquidacionesFletes
WHERE (IdLiquidacionFlete=@IdLiquidacionFlete)

