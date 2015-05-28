CREATE Procedure [dbo].[Obras_TX_PorId]

@IdObra int,
@IdUnidadOperativa int = Null

AS 

SET @IdUnidadOperativa=IsNull(@IdUnidadOperativa,-1)

SELECT *
FROM Obras
WHERE (@IdObra>0 and IdObra=@IdObra) or (@IdObra<=0 and IdUnidadOperativa=@IdUnidadOperativa) or (@IdObra<=0 and @IdUnidadOperativa<=0)