CREATE Procedure [dbo].[DetFletes_TX_ParaTransmitir_Todos]

AS 

SET NOCOUNT ON

UPDATE DetalleFletes
SET Patente=(Select Top 1 Fletes.Patente From Fletes Where Fletes.IdFlete=DetalleFletes.IdFlete)
WHERE Len(IsNull(Patente,''))=0

SET NOCOUNT OFF

SELECT  IdDetalleFlete, 0 as [IdFlete], Fecha, Tara, Ancho, Largo, Alto, Capacidad, Patente, IdOrigenTransmision
FROM DetalleFletes