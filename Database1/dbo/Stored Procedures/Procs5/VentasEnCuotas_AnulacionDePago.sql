












CREATE Procedure [dbo].[VentasEnCuotas_AnulacionDePago]

@IdRecibo int

AS 

UPDATE DetalleVentasEnCuotas
SET 
 FechaCobranza=Null,
 ImporteCobrado=Null,
 Intereses=Null,
 IdRecibo=Null
WHERE IdRecibo=@IdRecibo













