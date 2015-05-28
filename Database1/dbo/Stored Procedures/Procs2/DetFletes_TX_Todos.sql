CREATE Procedure [dbo].[DetFletes_TX_Todos]

AS 

SET NOCOUNT ON

UPDATE DetalleFletes
SET Patente=(Select Top 1 Fletes.Patente From Fletes Where Fletes.IdFlete=DetalleFletes.IdFlete)
WHERE Len(IsNull(Patente,''))=0

SET NOCOUNT OFF

SELECT *
FROM DetalleFletes