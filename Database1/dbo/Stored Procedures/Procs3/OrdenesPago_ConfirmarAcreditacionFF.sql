
CREATE Procedure [dbo].[OrdenesPago_ConfirmarAcreditacionFF]
@IdOrdenPago int
AS 
UPDATE OrdenesPago
SET ConfirmacionAcreditacionFF='SI'
WHERE IdOrdenPago=@IdOrdenPago and Tipo='FF'
