













CREATE PROCEDURE [dbo].[DetRecibosCuentas_TX_PorIdRecibo]

@IdRecibo int

AS

SELECT *
FROM DetalleRecibosCuentas 
WHERE (DetalleRecibosCuentas.IdRecibo = @IdRecibo)














