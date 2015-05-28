





























CREATE PROCEDURE [dbo].[DetComparativas_TXCom]
@IdComparativa int
as
SELECT *
FROM DetalleComparativas
WHERE (IdComparativa = @IdComparativa)






























