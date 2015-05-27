


























CREATE Procedure [dbo].[OrdenesPago_TX_PorId]
@IdOrdenPago int
AS 
SELECT *
FROM OrdenesPago
WHERE (IdOrdenPago=@IdOrdenPago)



























