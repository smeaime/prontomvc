

CREATE Procedure [dbo].[LiquidacionesFletes_E]

@IdLiquidacionFlete int  

AS 

DELETE LiquidacionesFletes
WHERE (IdLiquidacionFlete=@IdLiquidacionFlete)

